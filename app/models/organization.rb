# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  validates :name, uniqueness: true, presence: true
  accepts_nested_attributes_for :users
end