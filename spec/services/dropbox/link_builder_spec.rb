require 'rails_helper'

RSpec.describe Dropbox::Upload, type: :service do
  context "upload" do
    let(:file) { "/var/www/html/spec/factories/markdown.md" }
    let(:upload) { Dropbox::Upload.new file }

    it "should upload a file" do
      response = upload.execute
      expect(response).to have_key('path')
    end
  end
end
