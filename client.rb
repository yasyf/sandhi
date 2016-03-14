class Client
  def initialize
    @attempted = []
    scan
  end

  def scan(num_channels = 10)
    @aps = 1.upto(num_channels).flat_map { |i| channels[i].listen(30) }.sort { |ap| ap.signal_strength }
  end

  def send(frame)
  end

  def associate(ap)
    @address = ap.associate self
  end

  def estimate_throughput
    # ...
  end

  def connect
    ap = @aps.find { |ap| !@attempted.include?(ap) }
    @attempted << ap
    associate ap
    frame = Hello.new @address, ap.address, estimate_throughput, @aps
    send frame
  end
end
