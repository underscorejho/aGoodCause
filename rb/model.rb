
#############################

# models file for ruby code for agc
# using slim for templating
# using datamapper and sqlite for db

# Jared Henry Oviatt

#############################
### go back and change later
# just a comment
#############################

require 'sinatra'
require 'data_mapper'
require 'sqlite3'
require 'bcrypt'

# setting up data mapper
# use a different .db filename on production
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

# define models
### include more for classes from deskapp.rb?

# example model
#class Thing
#  include DataMapper::Resource
#
#  property :id,          Serial
#  property :title,       String
#  property :body,        Text
#  property :created_at,  DateTime
#end

##########

class User
  include DataMapper::Resource
  include BCrypt # for password, I think this inclusion is necessary

  property :id,          Serial
  property :reputation,  Integer, :default => 0
  property :username,    String,  :required => true
  property :password,    BCryptHash,  :required => true
  property :name,        String
  property :email,       String
  property :organization, String
  property :about_me,    Text,    :length => 300
  property :created_at,  DateTime
  ### add profiles (linkedin/social/github/etc)
  
  has n, :projects, :through => Resource  ### not sure about capitalization here

  def authenticate(pass_attempt)
    if self.password == pass_attempt
      true
    else
      false
    end
  end
end

##########

class Project
  include DataMapper::Resource
  
#
# for most of these
#  use '.new' and use the unsaved values
#  to '.create' a new Project
#
# -OR-
#
# '.create' all and instead    #
#  use a has-one relationship  # USING THIS FOR NOW
#                              #

  property :id,          Serial
  property :reputation,  Integer, :default => 0
  property :created_at,  DateTime

  has 1, :projectinfo    #
  has 1, :projectabout   # check capitalization
  has 1, :projectcontact #
end

##########

class Projectinfo
  include DataMapper::Resource
  
  property :id,          Serial
  property :title,       String,  :required => true
  property :summary,     String,  :length => 120
  property :wwn,         Text,    :length => 120
  
  has n, :users, :through => Resource  ### i think this should work... double check later
end

##########

class Projectabout
  include DataMapper::Resource
  
  property :id,          Serial
  property :city,        String
  property :state,       String,  :length => 2
  property :wwn_extended, Text,   :length => 500
  ### videos?
  ### pictures?
end

##########

class Projectemail
  include DataMapper::Resource
  
  property :id,          Serial
  property :email,       String
end

class Projectphone
  include DataMapper::Resource

  property :id,          Serial
  property :phone,       String
end

class Projectcontact
  include DataMapper::Resource

  property :id,          Serial
  property :website,     String
  
  has n, :projectemails ### check capitalization
  has n, :projectphones ### check capitalization
end

##########

# done defining models
DataMapper.finalize 

#DataMapper.auto_migrate!   ### might need this later
                            ### -OR-
#DataMapper.auto_upgrade!   ### this

