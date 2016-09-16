require "jmatrix/helper"
class JMatrix
  include JMatrixHelper
  PRECISION = 0.0000000001

  def initialize(matrix_a = nil, matrix_b = nil)
    @matrix_a = matrix_a
    @matrix_b = matrix_b
    @rows = @matrix_a.count
    @cols = @matrix_a[0].count rescue nil
    @matrix_b.map!{|row| [row]} if @matrix_b && !@matrix_b[0].is_a?(Array) && @rows > 1
    @identity = @rows.times.map{|row, l| [0]*@rows;}.map.with_index{|row, l| row[l]=1;row}
  end

  def gaussian_elimination
    matrix_a = @matrix_a.clone rescue nil
    matrix_b = @matrix_b.clone rescue nil
    for k in (0 .. @rows - 1)
      for i in (k + 1 .. @rows - 1)

        change_rows(matrix_a, matrix_b, k)

        times = matrix_a[i][k] / matrix_a[k][k].to_f
        yield k, i, times rescue nil
        for j in (k .. @cols - 1)
          matrix_a[i][j] = matrix_a[i][j] - times * matrix_a[k][j]
        end
        matrix_b[i].map!.with_index{|ele, col| ele - times * matrix_b[k][col]} rescue nil
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

  def lu_decomposition
    @matrix_ls = (@rows-1).times.map{|row| Marshal.load(Marshal.dump(@identity)) }
    gaussian_elimination{|k, i, times| @matrix_ls[k][i][k] = times }
    ans = @matrix_ls[0]
    (@matrix_ls.count - 1).times do |k|
      ans = multiply(ans, @matrix_ls[k+1])
    end
    ans
  end

  def determinant
    matrix = gaussian_elimination[0]
    matrix.each.with_index.inject(1){|ans, (row,i)| ans *= row[i]}
  end

  def inverse
    gauss_jordan_elimination[1]
  end

  private
  def change_rows(matrix_a, matrix_b, k)
    #change the rows when matrix[k][k].zero?
    if matrix_a[k][k].abs <= PRECISION
      (@rows - 1).downto(k + 1) do |l|
        if matrix_a[k][l].abs >= PRECISION
          matrix_a[k], matrix_a[l] = matrix_a[l], matrix_a[k]
          matrix_b[k], matrix_b[l] = matrix_b[l], matrix_b[k] rescue nil
          @matrix_c[k], @matrix_c[l] = @matrix_c[l], @matrix_c[k] rescue nil
        end
      end
    end
  end

end
