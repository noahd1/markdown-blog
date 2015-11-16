# ContentProvider creates an Content and Tags from a markdown file
class ContentProvider

  # Args:
  # * +filename+: The filename for creating a new Content object
  def initialize(filename)
    @filename = filename
  end

  # Creates the Content from a given filename
  #
  # Returns:
  # * a new Content object
  def execute
    begin
      markdown = File.read(@filename)
      parser = MarkdownParser.new markdown
      data = parser.execute
      html = data.output
      metadata = data.metadata

      content = get_content(markdown, html, metadata)

      content
    rescue => e
      raise "Can't read file! #{ e.message }"
    end
  end

  private

  # Create or edit a Content object
  #
  # Args:
  # * +markdown+: The content from a markdown file
  # * +html+: The parsed markdown
  # * +metadata+: The metadata from a markdown file
  #
  # Returns:
  # * a Content object
  def get_content(markdown, html, metadata)
    filename = File.basename(@filename, ".*")

    # Create or edit content model
    content = Content.find_or_create_by(filename: filename)
    content.title = metadata[:title]
    content.slug = content.title.downcase.tr(" ", "-")
    content.content_type = metadata[:type]
    content.markdown = markdown
    content.content = html
    content.author = metadata[:author]
    content.tags = get_tags(metadata)

    content.save
    content
  end

  # Get used Tags for a Content. If a use Tag not exists, it will be created
  #
  # Args:
  # * +metadata+: The metadata from a markdown file
  #
  # Returns:
  # * an array of Tags
  def get_tags(metadata)
    unless metadata[:tags].nil? && metadata[:tags].empty?
      tags = metadata[:tags]
      metadata[:tags] = tags.split(",").map(&:strip)
      tags = metadata[:tags].map { |title|
        Tag.find_or_create_by(title: title)
      }
    end

    tags
  end
end
