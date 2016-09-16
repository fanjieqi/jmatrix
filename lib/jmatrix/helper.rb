module JMatrixHelper

  def multiply(martrix_a, martrix_b)
    rows = martrix_a.count
    cols = martrix_a[0].count
    martrix_c = Array.new(rows){ Array.new(cols, 0) }
    (0..martrix_b.count - 1).each do |k|
      (0..martrix_a.count - 1).each do |i|
        (0..martrix_b[0].count - 1).each do |j|
          martrix_c[i][j] ||= 0
          martrix_c[i][j] += martrix_a[i][k] * martrix_b[k][j]
        end
      end
    end
    martrix_c
  end

end
