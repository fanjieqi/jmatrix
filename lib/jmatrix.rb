require "jmatrix/helper"
class JMatrix
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
    matrix_a = Marshal.load(Marshal.dump(@matrix_a)) rescue nil
    matrix_b = Marshal.load(Marshal.dump(@matrix_b)) rescue nil
    for k in (0 .. @rows - 1)
      for i in (k + 1 .. @rows - 1)

        change_rows(matrix_a, matrix_b, k)
        l = k
        l += 1 while matrix_a[k][l] == 0 && l < @cols

        times = matrix_a[i][l] / matrix_a[k][l].to_f
        yield l, i, times rescue nil
        for j in (l .. @cols - 1)
          matrix_a[i][j] -= times * matrix_a[k][j]
        end
        matrix_b[i].map!.with_index{|ele, col| ele - times * matrix_b[k][col]} rescue nil
      end
    end
    [matrix_a, matrix_b]
  end

  def gauss_jordan_elimination
    matrix_a, matrix_b = gaussian_elimination
    for k in (@rows - 1).downto(0)
      next if matrix_a[k].all?{|ele| ele.zero? }
      l = k
      l += 1 while matrix_a[k][l] == 0 && l < @cols
      matrix_b[k].map!{|ele| ele / matrix_a[k][l]} rescue nil

      times = matrix_a[k][l]
      matrix_a[k].map!{|ele| ele / times } rescue nil
      for i in (0 .. k - 1)
        times = matrix_a[i][l] / matrix_a[k][l].to_f
        for j in (l .. @cols - 1)
          matrix_a[i][j] -= times * matrix_a[k][j]
        end
        # matrix_a[i].map!.with_index{|ele, col| ele - times * matrix_a[k][col]}
        matrix_b[i].map!.with_index{|ele, col| ele - times * matrix_b[k][col]} rescue nil
      end
    end
    [matrix_a, matrix_b]
  end

  def lu_decomposition
    @matrix_ls = (@rows-1).times.map{|row| Marshal.load(Marshal.dump(@identity)) }
    matrix_u = gaussian_elimination{|k, i, times| @matrix_ls[k][i][k] = times }[0]
    ans = @matrix_ls[0]
    matrix_l = @matrix_ls.drop(1).inject(ans){|ans, matrix| ans = ans.multiply( matrix) }
    [matrix_l, matrix_u]
  end

  def determinant
    gaussian_elimination[0].map.with_index{|row,i| row[i]}.inject(:*)
  end

  def inverse
    @matrix_b ||= Marshal.load(Marshal.dump(@identity))
    gauss_jordan_elimination[1]
  end

  def reduced_row_echelon_form
    gauss_jordan_elimination[0]
  end

  def rref
    reduced_row_echelon_form
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
