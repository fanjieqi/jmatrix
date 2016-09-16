module JMatrixHelper

  def multiply(matrix_a, matrix_b)
    rows = matrix_a.count
    cols = matrix_a[0].count
    matrix_c = Array.new(rows){ Array.new(cols, 0) }
    matrix_b.count.times do |k|
      matrix_a.count.times do |i|
        matrix_b[0].count.times do |j|
          matrix_c[i][j] += matrix_a[i][k] * matrix_b[k][j]
        end
      end
    end
    matrix_c
  end

end

class Array
  include JMatrixHelper
  def multiply(matrix)
    super(self, matrix)
  end

  def round_value
    self.map{|row| row.map{|ele| ele.round(9)}}
  end

end
