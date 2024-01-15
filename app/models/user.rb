# frozen_string_literal: true

class User < ApplicationRecord
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :user_course_progresses
  
  validates :first_name, :last_name, :email, :phone, :address, presence: true
  validates :first_name, :last_name, length: { minimum: 2, maximum: 20 }
  validates :first_name, :last_name, format: { with: /\A[A-Z]+[a-z]*\z/ }
  # email must be unique and case insensitive
  validates :email, uniqueness: { case_sensitive: false }
  # email should be valid according to this regular expression
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_plausible_phone :phone, presence: true
  # address have at least 10 character and maximum 100 character
  validates :address, length: { minimum: 10, maximum: 100 }
  # set default country code for bangladesh
  phony_normalize :phone, default_country_code: 'BD'
  enum role: {
    learner: 0,
    instructor: 1,
    admin: 2
  }
  # this function name return the full_name of a person
  def name
    "#{first_name} #{last_name}"
  end
  
end
