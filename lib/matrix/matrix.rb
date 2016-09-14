class Matrix

  def initialize(matrix_a = nil, matrix_b = nil)
    @matrix_a = matrix_a
    @matrix_b = matrix_b
    @rows = @matrix_a.count
    @cols = @matrix_a[0].count
  end

end
