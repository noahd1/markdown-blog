class Article < ActiveRecord::Base
  has_and_belongs_to_many :tags
  validates_presence_of :slug, :title, :filename

  # Returns a String, which Action Pack uses for constructing an URL to this object.
  # http://apidock.com/rails/ActiveRecord/Integration/to_param
  def to_param
    slug
  end
end
