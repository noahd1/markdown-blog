# ArticleProvider creates a Article object from a markdown file
class ArticleProvider
  # Initialize the ArticleProvider class
  #
  # filename - The filename for creating a new Article object
  #
  # Examples
  #
  #   ArticleProvider.new "/path/to/markdown/fil.md"
  def initialize(filename)
    @filename = filename
  end

  # Creates the Article from a given filename
  #
  # Returns a new Article object
  def execute
    begin
      filename = File.basename(@filename, ".*")
      markdown = File.read(@filename)
      parser = MarkdownParser.new markdown
      data = parser.execute
      html = data.output
      metadata = data.metadata

      tags = []
      unless metadata.empty?
        title = metadata[:title]
        author = metadata[:author]
        tags = get_tags(metadata)
      end

      article = Article.find_or_create_by(filename: filename)
      article.title = title
      article.slug = article.title.downcase.gsub(" ", "-")
      article.markdown = markdown
      article.content = html
      article.author = author
      article.tags = tags

     article
    rescue => e
      raise "Can't read file! #{ e.message }"
    end
  end

  private

  # Get used Tags for a Article. If a use Tag not exists,
  # it will be created
  #
  # metadata - The metadata from a markdown file
  #
  # Returns used Tags
  #
  #   ArticleProvider.new "/path/to/markdown/fil.md"
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
