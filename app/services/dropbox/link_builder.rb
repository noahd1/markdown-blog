# Dropbox::LinkBuilder builds the link to an uploaded file
class Dropbox::LinkBuilder

  # Args:
  # * +uid+: The uid from the dropbox client
  # * +path+: The file path from the upload response
  def initialize(uid, path)
    @uid = uid
    @path = path
  end

  # Uploads a file to the public dropbox directory.
  #
  # Returns:
  # * a hash containing the metadata of the uploaded file.
  def execute
    dropbox_path = 'https://dl.dropboxusercontent.com/u'
    path = @path.sub('/public/', '')

    "#{ dropbox_path }/#{ @uid }/#{ path }"
  end
end
