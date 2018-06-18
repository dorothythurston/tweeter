require "rails_helper"

RSpec.describe TweetsController, type: :controller do
  it "assigns tweets" do
    user = create :user
    tweet = create(:tweet, user: user)
    expect(user.tweets.first).to eq(tweet)
  end
end