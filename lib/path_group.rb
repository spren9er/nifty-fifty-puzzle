require_relative 'path.rb'

module NF
  class PathGroup
    attr_accessor :paths

    def initialize(paths=nil)
      @paths = paths || []
    end

    def self.load(file)
      new(0.upto(3).map{|i| Path.load(file, i)})
    end
  end
end
