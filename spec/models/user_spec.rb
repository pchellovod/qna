require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association' do
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  describe 'validation' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  describe '#author?' do
    let(:user) { create(:user) }
    let(:new_user) { create(:user) }
    let(:question) { create(:question, user: user) }

    it 'author' do
      expect(user).to be_author(question)
    end

    it 'is not author' do
      expect(new_user).to_not be_author(question)
    end
  end
end
