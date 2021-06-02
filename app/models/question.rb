class Question < ApplicationRecord
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :title, :body, presence: true, length: { minimum: 10, maximum: 200 }

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
end
