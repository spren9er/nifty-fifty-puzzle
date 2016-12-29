module NF
  class Map
    attr_accessor :board, :paths, :rows, :cols

    def initialize
      @board = {}
      @paths = []
      @rows = 0
      @cols = 0
    end

    def self.load(file)
      new.load(file)
    end

    def load(file)
      b = File.read(file)
      lines = b.split("\n")

      @rows = lines.count
      @cols = lines.first.length

      lines.each_with_index do |r, i|
        r.split('').each_with_index do |c, j|
          board[[@rows - i - 1, j]] = 0 if c == '0'
        end
      end

      self
    end

    def feasible?(point, path)
      path.to_coords(offset: point).all?{|p| board[p] == 0}
    end

    def add_path(point, path)
      path.to_coords(offset: point).map{|p| @board[p] = path.name}
    end

    def remove_path(point, path)
      path.to_coords(offset: point).map{|p| @board[p] = 0}
    end

    def [](i, j)
      paths.map{|p| p[[i, j]]}.compact.first || board[[i, j]]
    end

    def to_s
      0.upto(rows - 1).map{|r| row(@rows - r - 1)}.join("\n")
    end

    private

    # ui
    # [0, 0] is lower bottom
    def row(i)
      0.upto(cols - 1).map{|j| self[i, j] || 'X'}.join
    end
  end
end
