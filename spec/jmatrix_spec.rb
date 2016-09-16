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
  expected3 = [[1,0,0],[2,1,0],[3,-1,1]]
  describe ".lu_decomposition" do
    context "given #{case3}" do
      it "returns #{expected3}" do
        @matrix = JMatrix.new(case3)
        expect(@matrix.lu_decomposition).to eq expected3
      end
    end
  end

end
