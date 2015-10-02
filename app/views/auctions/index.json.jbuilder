json.array!(@auctions) do |auction|
  json.extract! auction, :id, :title, :details, :ending_date, :reserve_price
  json.url auction_url(auction, format: :json)
end
