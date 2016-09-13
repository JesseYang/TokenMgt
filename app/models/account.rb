class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :platform, type: String
  field :account, type: String
  field :password, type: String
  field :access_token, type: String
  field :refresh_token, type: String

  BOX_CLIENT_ID = "buq4gus2fhoariwcaq0r15nf6l2u8auf"
  REDIRECT_URI = "https://117.121.10.67:3001"


  def self.create_account(platform, account, password)
    account = Account.create(platform: platform, account: account, password: password)
  end

  def self.platforms_for_select
    hash = {
      "box": "box",
      "onedrive": "onedrive"
    }
    hash
  end

  def login_url
    if self.platform == "box"
      return "https://account.box.com/api/oauth2/authorize?response_type=code&client_id=#{BOX_CLIENT_ID}&state=#{self.id.to_s}&redirect_uri=#{REDIRECT_URI}/redirects/box"
    end
  end
end
