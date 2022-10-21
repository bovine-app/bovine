# frozen_string_literal: true

# Stubs retrieving a Session instance as if its JWT serialization were stored
# in session[:jwt], and makes current_session available to the spec group.
def with_current_session
  let(:current_session) { create(:session) }

  before { allow(Session).to receive(:from_jwt).and_return(current_session) }
end

# Stubs retrieving a Session instance as if its JWT serialization were stored
# in session[:jwt], and makes current_session and current_user available to the
# spec group.
def with_current_user
  with_current_session

  let(:current_user) { current_session.user }
end
