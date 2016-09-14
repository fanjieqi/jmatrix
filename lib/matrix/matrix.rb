class Matrix

  def initialize(matrix_a = nil, matrix_b = nil)
    @matrix_a = matrix_a
    @matrix_b = matrix_b
    @rows = @matrix_a.count
    @cols = @matrix_a[0].count
    @matrix_b.map!{|row| [row]} if !@matrix_b[0].is_a?(Array) && @rows > 1
  end

  def gaussian_elimination
    matrix_a = @matrix_a.clone rescue nil
    matrix_b = @matrix_b.clone rescue nil
    for k in (0 .. @rows - 1)
      for i in (k + 1 .. @rows - 1)
        times = matrix_a[i][k] / matrix_a[k][k].to_f
        for j in (k .. @cols - 1)
          matrix_a[i][j] = matrix_a[i][j] - times * matrix_a[k][j].to_f
          matrix_b[i][j] = matrix_b[i][j] - times * matrix_b[k][j].to_f if j < matrix_b[i].count
        end
      end
    end
    [matrix_a, matrix_b]
  end

  def determinant
    matrix = gaussian_elimination[0]
    matrix.each.with_index.inject(1){|ans, (row,i)| ans *= row[i]}
  end

end
