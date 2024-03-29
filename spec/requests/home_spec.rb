# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home' do
  subject { response }

  describe 'GET /' do
    before { get '/' }

    it { is_expected.to have_http_status :found }
    it { is_expected.to redirect_to new_session_url }
  end
end
