# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject(:user) { build(:user) }

  it { is_expected.to be_valid }

  describe 'scopes' do
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

  describe 'class methods' do
    describe '.find_and_authenticate_by!' do
      subject(:find_and_authenticate_by!) { described_class.find_and_authenticate_by!(email:, password:) }

      let(:user)     { create(:user) }
      let(:email)    { user.email    }
      let(:password) { user.password }

      context 'with a correct password' do
        it { is_expected.to eq user }
      end

      context 'with an uppercased email' do
        let(:email) { user.email.upcase }

        it { is_expected.to eq user }
      end

      context 'with an incorrect email' do
        let(:email) { Faker::Internet.email }

        it { expect { find_and_authenticate_by! }.to raise_exception Bovine::Errors::UserAuthenticationError }
      end

      context 'with an incorrect password' do
        let(:password) { Faker::Internet.password }

        it { expect { find_and_authenticate_by! }.to raise_exception Bovine::Errors::UserAuthenticationError }
      end
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

  describe '#email' do
    context 'when unique' do
      it { is_expected.to be_valid }
    end

    context 'when not unique' do
      before { create(:user, email: user.email) }

      it { is_expected.not_to be_valid }
    end

    context 'when not case-sensitive unique' do
      before { create(:user, email: user.email.upcase) }

      it { is_expected.not_to be_valid }
    end
  end
end
