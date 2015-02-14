
# a desktop implimentation of agc

### 'go back to becuase this needs to change eventually'

###################################################################

### add documentation / a list of add_ commands

###################################################################

class Person
  def initialize (name, org)
    @name = name
    @organization = org
  end
end

class User
  @reputation = 0
  def initialize (name, pass) ### probably not very secure
  @name = name
  @pass = pass
  end
  def add_aboutMe (str) ### add check for length (300 chars or less)
    @aboutMe = str
  end
  ### add profile (linkedin/social/github/etc)
  ### add reputation modifiers
end

###################################################################

class ProjectInfo ### add check for lengths (100 chars or less)
  @people = []
  @users = []
  def initialize (title, summary)
    @title = title
    @summary = summary
  end
  def add_wwn (str)
    @wwn = str # "what we need"
  end
  def add_Person (person)
  @people << person # requires Person class
  end
  def add_User (user)
  @users << user  # requires User class
  end
  ### add cover picture later
end

class ProjectAbout
  @peopleAbout = Hash.new
  def add_personAbout (person, str) ### add check for str length 
    @peopleAbout[person] = str  #requires person class
  end
  def add_location (location)
    @location = location
  end
  def add_wwnExtended (str) ### 500 chars or less ### streamine in the future
    @wwnExtended = str
  end
  ### videos later
  ### pictures later
end

class ProjectContact
  @contactEmails = []
  @contactPhones = []
  def add_email (str) ### add check for valid email
    @contactEmails << str
  end
  def add_phone (str)
    @contactPhones << str
  end
  def add_website (str) ### add check for valid website
    @website = str
  end
end

###################################################################

class Project
  @popularity = 0
  def initialize (projectInfo, projectAbout, projectContact)
    @info = projectInfo
    @about = projectAbout
    @contact = projectContact
  end
end

