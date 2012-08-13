class DataReporter
  def self.gross
    total = 0.0

    Transaction.includes(:item).all.each do |t|
      total += t.item.price * t.count
    end

    total
  end
end
