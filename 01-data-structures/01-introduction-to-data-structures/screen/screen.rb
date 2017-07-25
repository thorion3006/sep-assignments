require_relative 'pixel'

class Screen
  attr_accessor :width
  attr_accessor :height
  attr_accessor :matrix

  def initialize(width, height)
    @width = width if width > 0
    @height = height if height > 0
    @matrix = []
    width.times do |i|
      @matrix[i] = []
      height.times do |j|
        @matrix[i][j] = Pixel.new(0, 0, 0, i, j)
      end
    end
  end

  # Insert a Pixel at x, y
  def insert(pixel, x, y)
    @matrix[x][y] = pixel if pixel.class == Pixel
  end

  def at(x, y)
    @matrix[x][y] if inbounds(x, y)
  end

  private

  def inbounds(x, y)
    x > 0 && x < @width && y > 0 && y < @height ? true : false
  end
end
