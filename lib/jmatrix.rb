class JMatrix

  def initialize(matrix_a = nil, matrix_b = nil)
    @matrix_a = matrix_a
    @matrix_b = matrix_b
    @rows = @matrix_a.count
    @cols = @matrix_a[0].count
    @matrix_b.map!{|row| [row]} if @matrix_b && !@matrix_b[0].is_a?(Array) && @rows > 1
  end

  def gaussian_elimination
    matrix_a = @matrix_a.clone rescue nil
    matrix_b = @matrix_b.clone rescue nil
    for k in (0 .. @rows - 1)
      for i in (k + 1 .. @rows - 1)
        times = matrix_a[i][k] / matrix_a[k][k].to_f
        for j in (k .. @cols - 1)
          matrix_a[i][j] = matrix_a[i][j] - times * matrix_a[k][j]
        end
        matrix_b[i].map!.with_index{|ele, col| ele - times * matrix_b[k][col]}
      end
    end
    [matrix_a, matrix_b]
  end

  def gaussian_elimination2
    matrix_a = @matrix_a.clone rescue nil
    matrix_b = @matrix_b.clone rescue nil
    matrix_a.each_with_index do |row, k|
      matrix_a.drop(k + 1).each_with_index do |cur_row, i|
        times = cur_row[k] / row[k].to_f
        cur_row.drop(k).each_with_index{|ele, j| ele -= times * row[j].to_f}
        matrix_b[i].each.with_index{|ele, j| ele -= times * matrix_b[k][j]}
      end
    end
    [matrix_a, matrix_b]
  end

  def gauss_jordan_elimination
    matrix_a, matrix_b = gaussian_elimination
    for k in (@rows - 1).downto(1)
      matrix_b[k].map!{|ele| ele / matrix_a[k][k]}
      matrix_a[k][k] = 1
      for i in (0 .. k - 1)
        times = matrix_a[i][k] / matrix_a[k][k].to_f
        matrix_a[i][k] = matrix_a[i][k] - times * matrix_a[k][k]
        matrix_b[i].map!.with_index{|ele, col| ele - times * matrix_b[k][col]}
      end
    end
    [matrix_a, matrix_b]
  end

  def determinant
    matrix = gaussian_elimination[0]
    matrix.each.with_index.inject(1){|ans, (row,i)| ans *= row[i]}
  end

  def inverse
    gauss_jordan_elimination[1]
  end

end
