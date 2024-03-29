require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  let(:enrollment) { FactoryBot.create(:enrollment) }
  describe 'Enrollment' do
    it 'has valid presence of' do
      expect(enrollment).to be_valid
    end
    it "belongs to user" do
      expect(Enrollment._reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "belongs to course" do
      expect(Enrollment._reflect_on_association(:course).macro).to eq(:belongs_to)
    end

  end
end
