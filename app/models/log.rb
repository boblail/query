class Log < ActiveRecord::Base
  establish_connection Rails.application.secrets.database_url
  
end
