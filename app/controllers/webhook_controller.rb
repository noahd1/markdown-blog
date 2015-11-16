class WebhookController < ApplicationController
  def merged
    begin
      importer = ContentImporter.new
      importer.execute

      render nothing: true, status: :ok
    rescue => e
      raise e
      # render nothing: true, status: :internal_server_error
    end
  end
end
