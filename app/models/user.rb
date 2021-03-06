class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :entries, dependent: :destroy
  has_many :active_interactives, class_name: Interactive.name,
    foreign_key: :follower_id,
    dependent: :destroy
  has_many :passive_interactives, class_name: Interactive.name,
    foreign_key: :followed_id,
    dependent: :destroy
  has_many :following, through: :active_interactives,  source: :followed
  has_many :followers, through: :passive_interactives, source: :follower

  before_save :downcase_email

  validates :name, presence: true, length: {maximum: Settings.length_max.name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:
    Settings.length_max.email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

  has_secure_password

  validates :password, presence: true, length: {minimum:
    Settings.length_min.password}, allow_nil: true

  scope :order_name, ->{order id: :asc}

  class << self
    def digest string
      @cost = BCrypt::Engine.MIN_COST if ActiveModel::SecurePassword.min_cost
      @cost = BCrypt::Engine.cost
      BCrypt::Password.create string, cost: @cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute :reset_digest,  User.digest(reset_token)
    update_attribute :reset_sent_at, Time.zone.now
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def follow other_user
    active_interactives.create followed_id: other_user.id
  end

  def feed
    Entry.order_entry
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
