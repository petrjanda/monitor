require 'singleton'
require 'yaml'

class Configuration
  include Singleton

  attr_accessor :working_directory, 
    :app_directory,
    :database_server, 
    :database_name, 
    :email_domain, 
    :email_user_name, 
    :email_password, 
    :airbrake_api_key,
    :db,
    :kiss_log_dir,

    :github_app_id,
    :github_app_secret,
    :github_redirect_uri

  def current_user
    @current_user
  end

  def current_user=(user)
    @current_user = user
  end

  def load(path)
    file = YAML::load(File.open(path))

    [
      :working_directory, 
      :app_directory,
      :database_server, 
      :database_name, 
      :email_domain, 
      :email_user_name, 
      :email_password, 
      :airbrake_api_key,
      :kiss_log_dir,

      :github_app_id,
      :github_app_secret,
      :github_redirect_uri
    ].each do |attr|
      self.send("#{attr}=", file[attr.to_s])
    end
  end
end