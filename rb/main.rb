
#############################

# main file for ruby code for agc
# using slim for templating

# Jared Henry Oviatt

#############################
### go back and change later
# just a comment
#############################

require 'sinatra'
require 'slim'
require 'data_mapper'

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

  property :id,          Serial
  property :reputation,  Integer, :default => 0
  property :username,    String,  :required => true
  property :password,    String,  :required => true
  property :name,        String
  property :organization, String
  property :about_me,    Text,    :length => 300
  property :created_at,  DateTime
  ### add profiles (linkedin/social/github/etc)
  
  belongs_to :projectInfo  ### not sure about capitalization here
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

  property :reputation,  Integer, :default => 0
  property :created_at,  DateTime

  has 1, :projectinfo    #
  has 1, :projectabout   # check capitalization
  has 1, :projectcontact #
end

##########

class ProjectInfo
  include DataMapper::Resource
  
  property :title,       String,  :required => true
  property :summary,     String,  :length => 120
  property :wwn,         Text,    :length => 120
  
  has n, :users  ### i think this should work... double check later
end

##########

class ProjectAbout
  include DataMapper::Resource
  
  property :city,        String
  property :state,       String,  :length => 2
  property :wwn_extended, Text,   :length => 500
  ### videos?
  ### pictures?
end

##########

class ProjectEmail
  include DataMapper::Resource
  
  property :email,       String
end

class ProjectPhone
  include DataMapper::Resource

  property :phone,       String
end

class ProjectContact
  include DataMapper::Resource

  property :website,     String
  
  has n, :projectemails ### check capitalization
  has n, :projectphones ### check capitalization
end

##########

# done defining models
DataMapper.finalize ### check if this is right