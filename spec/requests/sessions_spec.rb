# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions' do
  describe 'GET /new' do
    subject { response }

    before { get '/sessions/new' }

    it { is_expected.to have_http_status :success }
  end

  describe 'POST /' do
    subject { response }

    let(:user) { create(:user) }

    context 'with valid parameters' do
      before { post '/sessions', params: { user: { email: user.email, password: user.password } } }

      it { is_expected.to redirect_to root_url }

      it 'creates a session' do
        expect(User.find_by(email: user.email).sessions.count).to be 1
      end
    end
  end

  describe 'DELETE /' do
    subject { response }

    with_current_session

    before { delete '/sessions' }

    it { is_expected.to redirect_to(root_url) }

    it 'destroys the session' do
      expect { Session.find(current_session.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE /:id' do
    subject { response }

    with_current_user

    let(:target_session) { create(:session, user: current_user) }

    before { delete '/sessions', params: { id: target_session.id } }

    it { is_expected.to redirect_to(sessions_url) }

    it 'destroys the target session' do
      expect { Session.find(target_session.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'does not destroy the current session' do
      expect(Session.where(id: current_session.id).count).to be(1)
    end
  end
end
