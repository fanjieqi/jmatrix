require "jmatrix"

describe JMatrix do

  case1 = [[[1,2,3],[3,2,4],[4,5,6]], [6,7,8]]
  expected1 = [[[1, 2, 3], [0.0, -4.0, -5.0], [0.0, 0.0, -2.25]], [[6], [-11.0], [-7.75]]]
  describe ".gaussian_elimination" do
    context "given #{case1}" do
      it "returns #{expected1}" do
        @matrix = JMatrix.new(case1[0].clone, case1[1].clone)
        expect(@matrix.gaussian_elimination).to eq expected1
      end
    end
  end

  case2 = [[[1,2,3],[3,2,4],[4,5,6]], [[1,0,0],[0,1,0],[0,0,1]]]
  expected2 = [[[1, 0.0, 0.0], [0.0, 1, 0.0], [0.0, 0.0, 1]], [[-0.8888888888888891, 0.33333333333333326, 0.2222222222222221], [-0.2222222222222222, -0.6666666666666666, 0.5555555555555556], [0.7777777777777778, 0.3333333333333333, -0.4444444444444444]]]
  describe ".gauss_jordan_elimination" do
    context "given #{case2}" do
      it "returns #{expected2}" do
        @matrix = JMatrix.new(case2[0], case2[1])
        expect(@matrix.gauss_jordan_elimination).to eq expected2
      end
    end
  end

  case3 = [[1,2,3],[2,5,7],[3,5,3]]
  expected3 = [[[1,0,0],[2,1,0],[3,-1,1]], [[1, 2, 3],[0,1,1],[0,0,-5]]]
  describe ".lu_decomposition" do
    context "given #{case3}" do
      it "returns #{expected3}" do
        @matrix = JMatrix.new(case3)
        matrix_l, matrix_u = @matrix.lu_decomposition
        expect( matrix_l ).to eq expected3[0]
        expect( matrix_u ).to eq expected3[1]
      end
    end
  end

  case4 = [
    [[1,1,-1,2],[-1,-1,-4,1],[2,4,-6,1],[1,2,4,2]],
    [[1,4,-1,4],[2,1,4,3],[4,2,3,11],[3,0,9,2]],
  ]
  expected4 = [
    57,
    10,
  ]
  describe ".determinant" do
    context "given #{case4[0]}" do
      it "returns #{expected4[0]}" do
        @matrix = JMatrix.new(case4[0])
        expect(@matrix.determinant).to eq expected4[0]
      end
    end
    context "given #{case4[1]}" do
      it "returns #{expected4[1]}" do
        @matrix = JMatrix.new(case4[1])
        expect( @matrix.determinant.round(9) ).to eq expected4[1]
      end
    end
  end

  case5 = [[-2,1],[4,-3]]
  expected5 = [[1,0],[0,1]]
  describe ".inverse" do
    context "given #{case2[0]}" do
      it "returns #{case2[1]}" do
        @matrix = JMatrix.new(case2[0])
        expect( case2[0].multiply(@matrix.inverse).round_value ).to eq case2[1]
      end
    end

    context "given #{case5}" do
      it "returns #{expected5}" do
        @matrix = JMatrix.new(case5)
        expect( case5.multiply(@matrix.inverse).round_value ).to eq expected5
      end
    end
  end

  case6 = [[1,2,2,2],[2,4,6,8],[3,6,8,10]]
  expected6_1 = [[1,2,2,2],[0,0,2,4],[0,0,0,0]]
  expected6_2 = [[1,2,0,-2],[0,0,1,2],[0,0,0,0]]
  describe ".reduced_row_echelon_form" do
    context "given #{case6}" do
      it "returns #{expected6_2}" do
        @matrix = JMatrix.new(case6)
        expect( @matrix.gaussian_elimination[0] ).to eq expected6_1
        # expect( @matrix.rref ).to eq expected6_2
      end
    end
  end

end
