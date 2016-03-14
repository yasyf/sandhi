class Server
  def connections(client)
    client.in_range.flat_map do |ap|
      ap.clients.flat_map { |c| c.in_range }
    end.uniq
  end

  def rebalance(orig_client)
    conns = connections(orig_client)
    conns.length.times do
      conns.each do |ap|
        ap.clients(sorted: true).each do |client|
          client.in_range(sorted: true) do |new_ap|
            next if ap == new_ap
            next if new_ap.util > 0.9 * ap.util
            ap.kick client, to: new_ap
          end
        end
      end
    end
  end
end
