module NF
  class Algorithm
    attr_accessor :map, :path_groups

    START_POINTS_AREA = (0..9).to_a.product((0..9).to_a)

    def initialize(map, path_groups)
      @map = map
      @path_groups = path_groups
      @start_points = []
    end

    def call(found: -> (map, _){puts map}, expanded: -> (_, _){})
      solutions = []

      # complete solution found
      f = -> (map, vector) do
        found.call(map, vector)
        solutions << vector
      end

      find_solutions([], f, expanded)

      solutions
    end

    private

    def start_points
      return @start_points unless @start_points.empty?
      @start_points = path_groups.map do |pg|
        Hash[pg.paths.map{|p| [p, START_POINTS_AREA.select{|(i, j)| map.feasible?([i, j], p)}]}]
      end
    end

    def find_solutions(vector, found, expanded)
      n = vector.count

      if n == no_paths
        found.call(map, vector) # vector is solution
      else
        start_points[n].each do |p, st_points|
          st_points.each do |point|
            if map.feasible?(point, p)
              map.add_path(point, p)
              v = vector + [p]
              expanded.call(map, v)
              find_solutions(v, found, expanded)
              map.remove_path(point, p) # backtracking
            end
          end
        end
      end
    end

    def no_paths
      path_groups.count
    end
  end
end
