# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  subject { response }

  describe 'GET /user/new' do
    before { get '/user/new' }

    it { is_expected.to have_http_status :success }
  end

  describe 'POST /user' do
    let(:user) { build(:user) }

    before do
      post '/user', params: { user: {
        email: user.email,
        password: user.password,
        password_confirmation: user.password
      } }
    end

    it { is_expected.to redirect_to root_url }

    it 'creates the user' do
      expect(User.where(email: user.email).count).to be 1
    end
  end
end
