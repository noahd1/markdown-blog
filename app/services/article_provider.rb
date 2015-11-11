# Public: ArticleProvider creates a Article object from a markdown file
class ArticleProvider

  # Public: Initialize the ArticleProvider class
  #
  # filename - The filename for creating a new Article object
  #
  # Examples
  #
  #   ArticleProvider.new "/path/to/markdown/fil.md"
  def initialize(filename)
    @filename = filename
  end

  # Public: Creates the Article from a given filename
  #
  # Returns a new Article object
  def execute
    begin
      markdown = File.read(@filename)
      parser = MarkdownParser.new markdown
      data = parser.execute
      html = data.output
      metadata = data.metadata

      article = get_article(markdown, html, metadata)

      article
    rescue => e
      raise "Can't read file! #{ e.message }"
    end
  end

  private

  # Private: Create or edit a Article object
  #
  # markdown - The content from a markdown file
  # html     - The parsed markdown
  # metadata - The metadata from a markdown file
  #
  # Returns a Article
  def get_article(markdown, html, metadata)
    filename = File.basename(@filename, ".*")

    # Create or edit article model
    article = Article.find_or_create_by(filename: filename)
    article.title = metadata[:title]
    article.slug = article.title.downcase.tr(" ", "-")
    article.markdown = markdown
    article.content = html
    article.author = metadata[:author]
    article.tags = get_tags(metadata)

    article.save
    article
  end

  # Private: Get used Tags for a Article. If a use Tag not exists,
  # it will be created
  #
  # metadata - The metadata from a markdown file
  #
  # Returns used Tags
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
