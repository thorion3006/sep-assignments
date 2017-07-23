require_relative 'pixel'

class Screen
  attr_accessor :width
  attr_accessor :height
  attr_accessor :matrix

  def initialize(width, height)
    @width = width
    @height = height
    @matrix = []
  end

  # Insert a Pixel at x, y
  def insert(pixel, x, y)
    matrix[x, y] = pixel
  end

  def at(x, y)
    matrix[x, y].first if inbounds(x, y)
  end

  private

  def inbounds(x, y)
    x > 0 && y > 0 ? true : false
  end
end
