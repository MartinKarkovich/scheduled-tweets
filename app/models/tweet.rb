# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: { minimum: 1, maximum: 280 }
  validates :publish_at, presence: true
  validate :publish_at_cannot_be_in_the_past

  after_initialize do
    self.publish_at ||= 24.hours.from_now
  end

  after_save do
    if publish_at_previously_changed?
      TweetJob.set(wait_until: publish_at).perform_later(self)
    end
  end

  def published?
    tweet_id?
  end

  def publish_to_twitter!
    tweet = twitter_account.client.update(body)
    update(tweet_id: tweet.id)
  end

  def publish_at_cannot_be_in_the_past
    if publish_at.present? && publish_at < Time.now
      errors.add(:publish_at, "must be a future datetime!")
    end
  end
end