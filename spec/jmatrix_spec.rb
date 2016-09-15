require "jmatrix"

describe JMatrix do

  case1 = [[[1,2,3],[3,2,4],[4,5,6]], [6,7,8]]
  expected = [[[1, 2, 3], [0.0, -4.0, -5.0], [0.0, 0.0, -2.25]], [[6], [-11.0], [-7.75]]]

  describe ".gaussian_elimination" do
    context "given #{case1}" do
      it "returns #{expected}" do
        @matrix = JMatrix.new(case1[0], case1[1])
        expect(@matrix.gaussian_elimination).to eq expected
      end
    end
  end

  describe ".gaussian_elimination2" do
    context "given #{case1}" do
      it "returns #{expected}" do
        @matrix = JMatrix.new(case1[0], case1[1])
        expect(@matrix.gaussian_elimination2).to eq expected
      end
    end
  end

end
