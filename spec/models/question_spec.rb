require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'association' do
    it { should have_many(:answers).dependent(:destroy) }
    it { should belong_to(:user) }
    it { should have_many(:attachments).dependent(:destroy) }
  end

  describe 'validation' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_length_of(:title).is_at_least(10) }
    it { should validate_length_of(:title).is_at_most(200) }
    it { should validate_length_of(:body).is_at_least(10) }
  end

  describe 'attributes' do
    it { should accept_nested_attributes_for :attachments }
  end
end
