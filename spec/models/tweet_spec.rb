require 'rails_helper'

RSpec.describe Tweet, :type => :model do
  let(:user) { User.new }
  subject { user.tweets.build(body: 'body') }

  it 'should have a body' do
    expect(subject.body).to eql('body')
  end
end
