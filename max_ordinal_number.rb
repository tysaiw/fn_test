require 'redis'

class MaxOrdinalNumber
  EXPIRE_DAY = 1
  EXPIRE_SEC = 60 * 60 * 24 * EXPIRE_DAY
  KEY_PREFIX = "max_ordinal_number"
    
  def initialize(screening_id)
    @screening_id = screening_id
    @redis_key = "#{KEY_PREFIX}:#{@screening_id}"
    @redis = Redis.new(host: "localhost", port: 6379) # 這裡應該是實際 Redis 相關設定，可能寫在 config/initializers/redis.rb ，包括 port, host, databasename 那些
  end
  
  def get
    @redis.get(@redis_key).to_i
  end
  
  def set(number)
    @redis.setex(@redis_key, EXPIRE_SEC, number)
  end
end