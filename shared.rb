class Meta
  NOOP = 0x0
  HELLO = 0x1
  GOODBYE = 0x2
  UTIL = 0x3
  UNHAPPY = 0x4
end

class Frame
  def initialize(src, dst, meta = Meta::NOOP)
    @src, @dst, @data, @meta = src, dst, nil, meta
  end
end

class Hello < Frame
  def initialize(src, dst, required_throughput, rankings)
    super src, dst, Meta::HELLO
    @data = { required: required_throughput, rankings: rankings }
  end
end

class Goodbye < Frame
  def initialize(src, dst, new_ap = nil)
    super src, dst, Meta::GOODBYE
    @data = { transfer: new_ap }
  end
end

class Utilization < Frame
  def initialize(src, dst, apid, metrics)
    super src, dst, Meta::UTIL
    @data = { apid: apid, metrics: metrics } # metrics: [(metric * value)]
  end
end


class Unhappy < Frame
  def initialize(src, dst)
    super src, dst, Meta::UNHAPPY
  end
end

