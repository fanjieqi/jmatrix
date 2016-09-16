module JMatrixHelper

  def multiply(matrix_a, matrix_b)
    rows = matrix_a.count
    cols = matrix_a[0].count
    matrix_c = Array.new(rows){ Array.new(cols, 0) }
    (0..matrix_b.count - 1).each do |k|
      (0..matrix_a.count - 1).each do |i|
        (0..matrix_b[0].count - 1).each do |j|
          matrix_c[i][j] ||= 0
          matrix_c[i][j] += matrix_a[i][k] * matrix_b[k][j]
        end
      end
    end
    matrix_c
  end

end
