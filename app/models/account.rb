class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  include HTTParty
  base_uri 'https://api.box.com/'

  BOX_BASE_URI = "https://api.box.com"
  ONEDRIVE_BASE_URI = "https://login.live.com"

  field :platform, type: String
  field :account, type: String
  field :password, type: String
  field :access_token, type: String
  field :refresh_token, type: String
  field :token_updated_at, type: Date

  BOX_CLIENT_ID = "buq4gus2fhoariwcaq0r15nf6l2u8auf"
  BOX_CLIENT_SECRET = "gi5W2ysE3Q0CtNhoqbVHjD6GMSaaycPQ"
  BOX_REDIRECT_URI = "https://117.121.10.67:3001/redirects/box"

  ONEDRIVE_CLIENT_ID = "f396f15e-356d-45df-83a9-8bafb50129ad"
  ONEDRIVE_CLIENT_SECRET = "kPJzHHpzgwefwMrq8gxfORs"
  ONEDRIVE_REDIRECT_URI = "https://b-fox.cn:3001/redirects/onedrive"

  GOOGLEDRIVE_CLIENT_ID = "1019535295007-54qg2bs003pejvvq26gqiqk90c5re3p4.apps.googleusercontent.com"
  GOOGLEDRIVE_CLIENT_SECRET = "rhcyewEi_2-dI70Va8rIU8U5"
  GOOGLEDRIVE_REDIRECT_URI = "http://b-fox.cn:3001/redirects/googledrive/"

  def self.create_account(platform, account, password)
    account = Account.create(platform: platform, account: account, password: password)
  end

  def self.platforms_for_select
    hash = {
      "box": "box",
      "onedrive": "onedrive",
      "googledrive": "googledrive"
    }
    hash
  end

  def login_url
    if self.platform == "box"
      return "https://account.box.com/api/oauth2/authorize?response_type=code&client_id=#{BOX_CLIENT_ID}&state=#{self.id.to_s}&redirect_uri=#{BOX_REDIRECT_URI}"
    end
    if self.platform == "onedrive"
      return "https://login.live.com/oauth20_authorize.srf?client_id=#{ONEDRIVE_CLIENT_ID}&scope=onedrive.readwrite offline_access&response_type=code&state=#{self.id.to_s}&redirect_uri=#{ONEDRIVE_REDIRECT_URI}?id=#{self.id.to_s}"
    end
    if self.platform == "googledrive"
      return "https://accounts.google.com/o/oauth2/v2/auth?response_type=code&client_id=#{GOOGLEDRIVE_CLIENT_ID}&redirect_uri=#{GOOGLEDRIVE_REDIRECT_URI}&scope=email profile&state=#{self.id.to_s}&access_type=offline&prompt=consent"
    end
  end

  def get_tokens(code)
    case self.platform
    when "box"
      self.base_uri BOX_BASE_URI
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
    when "onedrive"
      self.base_uri ONEDRIVE_BASE_URI
      options = {
        body: {
          grant_type: "authorization_code",
          code: code,
          client_id: ONEDRIVE_CLIENT_ID,
          client_secret: ONEDRIVE_CLIENT_SECRET,
          redirect_uri: ONEDRIVE_REDIRECT_URI
        }
      }
      response = self.class.post("/oauth20_token.srf", options)
      logger.info "AAAAAAAAAAAAAAA"
      logger.info response
      logger.info "AAAAAAAAAAAAAAA"
    end
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
