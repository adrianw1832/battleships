require 'player'

describe Player do
  let(:ship) { double :ship }
  let(:board) { double :board }
  let(:name) { double :name }
  let(:subject) { described_class.new(name, board) }

  describe '#fire' do
    it 'board should receive check_board when fire is called' do
      expect(board).to receive(:check_board)
      subject.fire(:A1)
    end
  end

  describe '#place_ship' do
    it 'board should receive place_ship when place is called' do
      expect(board).to receive(:place_ship)
      subject.place(ship, :A1, :Horizontally)
    end
  end

  describe '#hits' do
    it 'board should receive hits when hits is called' do
      expect(board).to receive(:hits)
      subject.hits
    end

    describe '#misses' do
      it 'board should receive hits when hits is called' do
        expect(board).to receive(:hits)
        subject.hits
      end
    end
  end
end
