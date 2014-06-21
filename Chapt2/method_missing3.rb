# Comparison  native method and ghost method performance

class String
  #Opening up String for testing, not a good idea in production code.
  def method_missing(method, *args)
    method == :ghost_reverse ? reverse : super
  end
end

require 'benchmark'
Benchmark.bm do |b|
  b.report 'Normal method' do 
    10000000.times { "abc".reverse }
  end

  b.report 'Ghost method' do
    10000000.times { "abc".ghost_reverse }
  end
end
