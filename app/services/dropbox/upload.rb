require 'dropbox_sdk'

# Dropbox::Upload uploads a given file to dropbox
class Dropbox::Upload

  # Args:
  # * +filename+: The file path to upload.
  def initialize(filename)
    @filename = filename
  end

  # Uploads a file to the public dropbox directory.
  #
  # Returns:
  # * a hash containing the metadata of the uploaded file.
  def execute
    login = Dropbox::Login.new
    client = login.execute

    file = File.read(@filename)
    path = File.dirname(@filename).sub('/var/www/html/', '')
    filename = File.basename(@filename)
    overwrite = true

    client.put_file("public/#{ path }/#{ filename }", file, overwrite)
  end
end
