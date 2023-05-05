# frozen-string-literal: true

# Player class holds a player name and the color of his disks.
# Also, player has a turn variable that says if it is his turn
class Player
  attr_accessor :name, :disk, :turn

  def initialize(disk, turn = false, name = 'unknown')
    @name = name
    @disk = disk
    @turn = turn
  end
end
