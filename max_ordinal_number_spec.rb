require_relative 'max_ordinal_number'
require 'redis'

RSpec.describe MaxOrdinalNumber do
  let(:screening_id) { "margin_sell_up" }
  let(:redis_key) { "#{described_class::KEY_PREFIX}:#{screening_id}" }

  describe "#set and #get" do
    let(:max_ordinal_number) { described_class.new(screening_id) }
    let(:number) { 5 }
    before { max_ordinal_number.set(number) }

    it { expect(REDIS.ttl(redis_key)).to eq 86400 } # 60 * 60 * 24 * 1
    it { expect(max_ordinal_number.get).to eq 5 }
  end
end
