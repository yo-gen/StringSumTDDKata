require_relative 'main'

RSpec.describe 'Main' do
  describe '#sum_number_string' do
    it 'returns 0 for an empty string' do
      expect(sum_number_string('')).to eq(0)
    end

    it 'returns number for single number' do
      expect(sum_number_string('1')).to eq(1)
    end

    it 'returns sum of numbers for two numbers' do
      expect(sum_number_string('1,2')).to eq(3)
    end

    it 'returns the sum of multiple numbers' do
      expect(sum_number_string('1,2,3,4,5')).to eq(15)
    end

    it "handles \n between numbers" do
      expect(sum_number_string("1\n2,3")).to eq(6)
    end

    it 'handles different delimiter' do
      expect(sum_number_string("//;\n1;2")).to eq(3)
    end

    it 'handles delimiter of any length even when provided without brackets' do
      expect(sum_number_string("//;;;\n1;;;2")).to eq(3)
    end

    it 'handles delimiters of any length but with given format' do
      expect(sum_number_string("//[*****]\n1*****2")).to eq(3)
    end

    it "handles multiple delimiters with length of one char" do
      expect(sum_number_string("//[*][%][&][a][^]\n1*2%3^4a2")).to eq(12)
    end
    
    it "handles multiple delimiters with length longer than one char" do
      expect(sum_number_string("//[***][%%%][dd]\n1***2%%%3dd4")).to eq(10)
    end

    it 'raises ArgumentError for negative numbers' do
      expect { sum_number_string('1,-2,-3') }.to raise_error(ArgumentError, 'Negative numbers not allowed: -2, -3')
    end

    it "ignores numbers bigger than 1000" do
      expect(sum_number_string("2,1001")).to eq(2)
    end
  end
end
