# ContentImporter read and save all new and modified content files
class ContentImporter

  # Read and convert markdown files to Content objects
  def execute
    begin
      # Get all markdown files
      contents_path = Rails.root.join(ENV["CONTENT_DIR"], '**', '*.md')
      files = Dir[contents_path].sort_by{ |file| File.mtime(file) }.reverse!

      import_files files
    rescue => e
      raise "Can't import contents! #{ e.message }"
    end
  end

  private

  # Imports markdown files to Content objects
  # Args:
  # * +files+: A list of files to import
  def import_files files
    last_import_date = get_last_import_date

    files.each do |file|
      next if file.end_with? "README.md"

      if File.mtime(file) > last_import_date
        content_provider = ContentProvider.new(file)
        content_provider.execute
      end
    end

    set_last_import_date
  end

  # Get the last content import date
  #
  # Returns:
  # * a date
  def get_last_import_date
    last_import_file = Rails.root.join(ENV["LAST_IMPORT_FILE"])

    unless File.exist?(last_import_file)
      File.open(last_import_file, 'w') {|f| f.write(Time.new(1970,1,1).to_s) }
    end

    Date.parse(File.open(last_import_file, &:readline))
  end

  # Set the last content import date
  def set_last_import_date
    last_import_file = Rails.root.join(ENV["LAST_IMPORT_FILE"])

    File.open(last_import_file, 'w') {|f| f.write(Time.new.to_s) }
  end
end
