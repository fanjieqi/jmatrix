class Matrix

  def initialize(matrix_a = nil, matrix_b = nil)
    @matrix_a = matrix_a
    @matrix_b = matrix_b
    @rows = @matrix_a.count
    @cols = @matrix_a[0].count
  end

  def gaussian_elimination
    matrix_a = @matrix_a.clone
    for k in (0 .. @rows - 1)
      for i in (k + 1 .. @rows - 1)
        times = matrix_a[i][k] / matrix_a[k][k].to_f
        for j in (k .. @cols - 1)
          matrix_a[i][j] = matrix_a[i][j] - times * matrix_a[k][j].to_f
        end
      end
    end
    matrix_a
  end

end
