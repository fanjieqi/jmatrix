require "jmatrix"

describe JMatrix do

  describe ".gaussian_elimination" do

    case1 = [[[1,2,3],[3,2,4],[4,5,6]], [6,7,8]]
    context "given #{case1}" do
      expected = [[[1, 2, 3], [0.0, -4.0, -5.0], [0.0, 0.0, -2.25]], [[6], [-11.0], [-7.75]]]
      it "returns #{expected}" do
        @matrix = JMatrix.new(case1[0], case1[1])
        expect(@matrix.gaussian_elimination).to eq expected
      end
    end
  end

end
