require 'rails_helper'

RSpec.describe Dropbox::Login, type: :service do
  context "client" do
    let(:client) { Dropbox::Login.new.execute }

    it "should have a display_name" do
      expect(client.account_info).to have_key('display_name')
    end
  end
end
