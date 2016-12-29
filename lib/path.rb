require 'yaml'

module NF
  class Path
    attr_accessor :name, :directions

    def initialize
      @directions = []
    end

    def self.load(file, i)
      p = Path.new
      p.load(file)
      p.variant(i)
    end

    def load(file)
      f = YAML.load_file(file)
      @name = f['name']
      @directions = f['directions'].split('')
    end

    def variant(i)
      case i
      when 0
        self
      when 1
        transpose
      when 2
        reverse
      when 3
        transpose.reverse
      end
    end

    def transpose
      @directions.map!{|d| d == 'r' ? 'u' : 'r'}
      self
    end

    def reverse
      @directions.reverse!
      self
    end

    def to_coords(offset: [0, 0])
      directions.reduce([offset]) do |c, d|
        last = c.last
        c + [(d == 'r' ? [last.first, last.last + 1] : [last.first + 1, last.last])]
      end
    end

    def to_s
      0.upto(rows - 1).map{|i| row(rows - i - 1).join}.join("\n")
    end

    private

    # ui
    # [0, 0] is lower bottom
    def cols
      directions.count('r') + 1
    end

    def rows
      directions.count('u') + 1
    end

    def row(i)
      r = Array.new(cols, ' ')
      to_coords.select{|(j, _)| i == j}.map{|(_, k)| k}.each{|k| r[k] = name}
      r
    end
  end
end
