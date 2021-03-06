class Meta
  NOOP = 0x0
  HELLO = 0x1
  GOODBYE = 0x2
  UNHAPPY = 0x3
  UTIL = 0x4
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
    # metric_t: (metric * value)
    # bucket_t: [metric_t]
    # data_t: (address * timestamp * [metric_t])
    @data = { apid: apid, metrics: metrics }
  end
end


class Unhappy < Frame
  def initialize(src, dst)
    super src, dst, Meta::UNHAPPY
  end
end

