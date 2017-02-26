require 'rufus-scheduler'
scheduler = Rufus::Scheduler.new

scheduler.every("50m") do
  box_accounts = Account.where(platform: "box", account: /box*/)
  box_accounts.each do |e|
    e.refresh_tokens
  end
end
