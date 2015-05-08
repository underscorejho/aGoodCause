
#############################

# main file for ruby code for agc
# using slim for templating
# using datamapper and sqlite for db

# Jared Henry Oviatt

#############################
### go back and change later
# just a comment
#############################

require 'sinatra'
require 'slim'
require 'warden'

require './model.rb'

#############################

use Warden::Manager do |config|
  config.serialize_into_session{|user| user.id}
  config.serialize_from_session{|id| User.get(id)}
  
  config.scope_defaults :default,
    strategies: [:password],
    action: 'auth/unauthenticated'
end

Warden::Manager.before_failure do |env, opts|
  env['REQUEST_METHOD'] = 'POST'
end

Warden::Strategies.add(:password) do
  def valid?
    params['user']['username'] && params['user']['password']
  end

  def authenticate!
    user = User.first(username: params['user']['username'])
    
    if user.nil?
      fail!("Username does not exist.")
    elsif user.authenticate(params['user']['password'])
      success!(user)
    else
      fail!("Unable to log in.")
    end
  end
end

#############################



#############################

get '/' do
  @users = User.all
  slim :index
end

#############################

get '/auth/signup' do
  slim :signup
end

post '/auth/signup' do ### add username and email duplicate protection ###### shits not finished
  @new_user = User.create username: params[:newusername], 
    password: params[:newpassword],
    name: params[:newfullname],
    email: params[:newemail],
    organization: params[:neworganization],
    about_me: params[:newaboutme]
  # Warden login for the new user
  env['warden'].authenticate!
  # Redirect to agc home
  redirect '/'                 ### not sure if this whole form works...
end

get '/auth/login' do
  slim :login
end

post '/auth/login' do
  env['warden'].authenticate!

  if session[return_to].nil?
    redirect '/'
  else
    redirect session[:return_to]
  end
end

get '/auth/logout' do
  env['warden'].raw_session.inspect
  env['warden'].logout
  redirect '/'
end

post '/auth/unauthenticated' do
  session[:return_to] = env['warden.options'][':attempted_path']
  redirect '/auth/login'
end

