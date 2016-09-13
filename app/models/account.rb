class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  include HTTParty
  base_uri 'https://api.box.com/'

  field :platform, type: String
  field :account, type: String
  field :password, type: String
  field :access_token, type: String
  field :refresh_token, type: String
  field :token_updated_at, type: Date

  BOX_CLIENT_ID = "buq4gus2fhoariwcaq0r15nf6l2u8auf"
  BOX_CLIENT_SECRET = "gi5W2ysE3Q0CtNhoqbVHjD6GMSaaycPQ"
  BOX_REDIRECT_URI = "https://117.121.10.67:3001"


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
      return "https://account.box.com/api/oauth2/authorize?response_type=code&client_id=#{BOX_CLIENT_ID}&state=#{self.id.to_s}&redirect_uri=#{BOX_REDIRECT_URI}/redirects/box"
    end
  end

  def get_tokens(code)
    options = {
      body: {
        grant_type: "authorization_code",
        code: code,
        client_id: BOX_CLIENT_ID,
        client_secret: BOX_CLIENT_SECRET
      }
    }
    response = self.class.post("/oauth2/token", options)
    data = JSON.parse(response.body)
    self.update_attributes(
      {
        access_token: data["access_token"],
        refresh_token: data["refresh_token"],
        token_updated_at: Time.now
      })
  end

  def refresh_tokens
    options = {
      body: {
        grant_type: "refresh_token",
        refresh_token: self.refresh_token,
        client_id: BOX_CLIENT_ID,
        client_secret: BOX_CLIENT_SECRET
      }
    }
    response = self.class.post("/oauth2/token", options)
    data = JSON.parse(response.body)
    self.update_attributes(
      {
        access_token: data["access_token"],
        refresh_token: data["refresh_token"],
        token_updated_at: Time.now
      })
  end
end
