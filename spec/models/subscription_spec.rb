# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription do
  subject(:subscription) { build(:subscription, feed:, user:) }

  let(:feed) { build(:feed) }
  let(:user) { build(:user) }

  it { is_expected.to be_valid }

  context 'without a feed' do
    let(:feed) { nil }

    it { is_expected.not_to be_valid }
  end

  context 'without a user' do
    let(:user) { nil }

    it { is_expected.not_to be_valid }
  end

  context 'with duplicate feed_id and user_id' do
    let(:feed) { create(:feed) }
    let(:user) { create(:user) }

    before { create(:subscription, feed:, user:) }

    it { is_expected.not_to be_valid }
  end
end
