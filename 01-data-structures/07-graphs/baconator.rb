require_relative 'node'

class Baconator
  def initialize(node)
    @root = node
    @root.previous = nil
    @root.weight = 0
  end

  def find_kevin_bacon
    queue = []
    root = bfs
    while root.previous
      queue.push(root)
      root = root.previous
    end
    movies = []
    while queue.any?
      actor = queue.pop
      movies.push(actor.movie)
    end
    movies
  end

  def bfs
    queue = []
    @root.film_actor_hash.each do |movie, actors|
      actors.each do |actor|
        actor.previous = @root
        actor.weight = @root.weight + 1
        actor.movie = movie
        return actor if actor.name == 'Kevin Bacon'
        queue.push(actor)
      end
    end
    while queue.any?
      root = queue.shift
      root.film_actor_hash.each do |movie, actors|
        actors.each do |actor|
          actor.movie = movie
          actor.previous = root
          actor.weight = root.weight + 1
          return actor if actor.name == 'Kevin Bacon'
          queue.push(actor) if actor.weight <= 5
        end
      end
    end
  end
end
