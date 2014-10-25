require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { described_class.new(email: 'user@domain.com') }

  it 'should have an email' do
    expect(subject.email).to eql('user@domain.com')
  end
end
