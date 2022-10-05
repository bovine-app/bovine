# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feed do
  subject(:feed) { build(:feed) }

  it { is_expected.to be_valid }

  context 'without a title' do
    before { feed.title = nil }

    it { is_expected.not_to be_valid }
  end

  context 'with an invalid URL' do
    before { feed.url = Faker::String.random }

    it { is_expected.not_to be_valid }
  end

  context 'without a URL' do
    before { feed.url = nil }

    it { is_expected.not_to be_valid }
  end
end
