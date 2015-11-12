require 'dropbox_sdk'

# Dropbox::Login create a connection to dropbox with given access token
class Dropbox::Login

  # Login to dropbox
  #
  # Returns:
  # * a DropboxClient object
  def execute
    DropboxClient.new(ENV['DROPBOX_ACCESS_TOKEN'])
  end
end
