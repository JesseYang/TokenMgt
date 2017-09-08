require 'rufus-scheduler'
scheduler = Rufus::Scheduler.new

scheduler.every("25m") do
  print("BBBBBBBBBBBBBBBB")
  Rails.logger.info("BBBBBBBBBBBBBBBB")
  Rails.logger.info(Time.now.to_s)
  Rails.logger.info("BBBBBBBBBBBBBBBB")
  box_accounts = Account.where(platform: "box", account: /box*/)
  box_accounts.each do |e|
    e.refresh_tokens
  end
end

# scheduler.every("3s") do
#   print("AAAAAAAAAA")
#   Rails.logger.info("AAAAAAAAAA")
# end
