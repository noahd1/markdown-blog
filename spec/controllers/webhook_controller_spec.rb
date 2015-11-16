require 'rails_helper'

RSpec.describe WebhookController, type: :controller do

  describe "GET #merged" do
    it "returns http success" do
      get :merged
      expect(response).to have_http_status(:success)
    end
  end

end
