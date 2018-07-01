require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.get(key)
      update_node!(@map[key])
    else
      calc!(key)
    end
    @map[key].val
  end

  def to_s
    'Map: ' + @map.to_s + "\n" + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    eject! if @store.length == @max
    node = @store.append(key, @prc.call(key))
    @map.set(key, node)
  end

  def update_node!(node)
    @store.move_to_end(node)
  end

  def eject!
    @map[@store.first.key] = nil
    @store.remove(@store.first.key)
  end
end

if $PROGRAM_NAME == __FILE__
  lru = LRUCache.new(3, Proc.new { |i| i ** 2 })
  lru.get(1)
  lru.get(2)
  lru.get(4)
  lru.get(2)
  lru.get(5)
  lru.get(4)
  lru.get(3)
  puts lru
end
