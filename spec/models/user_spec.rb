# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject { build(:user) }

  it { is_expected.to be_valid }

  describe 'class methods' do
    let!(:confirmed_user) { create(:confirmed_user) }
    let!(:unconfirmed_user) { create(:user) }

    describe '.confirmed' do
      subject { described_class.confirmed }

      it { is_expected.to include confirmed_user }
      it { is_expected.not_to include unconfirmed_user }
    end

    describe '.unconfirmed' do
      subject { described_class.unconfirmed }

      it { is_expected.not_to include confirmed_user }
      it { is_expected.to include unconfirmed_user }
    end
  end

  describe '#authenticate!' do
    subject(:authenticate!) { user.authenticate!(password) }

    let(:user) { create(:confirmed_user) }

    context 'with a correct password' do
      let(:password) { user.password }

      it { is_expected.to be user }
    end

    context 'with an incorrect password' do
      let(:password) { Faker::Internet.password }

      it { expect { authenticate! }.to raise_exception Bovine::Errors::UserAuthenticationError }
    end
  end
end
