require 'board'

describe Board do
  let(:ship) { double :ship }
  before(:each) { allow(ship).to receive(:got_hit) }
  before(:each) { allow(ship).to receive(:size) { 2 } }
  before(:each) { subject.place_ship(ship, :A1, :Vertically) }

  describe '#place_ship' do
    context 'ships of size 2' do
      describe '#place_ship' do
        it 'places the ship on the specified coords' do
          expect(subject.positions[:A1]).to eq ship
        end

        it 'places the ship on the specified coords' do
          expect(subject.positions[:A2]).to eq ship
        end

        it 'does not allow ships to overlap' do
          expect { subject.place_ship(ship, :A2, :Horizontally) }.to raise_error 'Overlapping ships'
        end
      end
    end
  end

  describe '#check_board' do
    it 'should return hit if it is a hit' do
      expect(subject.check_board(:A1)).to eq :hit
    end

    it 'should return miss if it is a miss' do
      expect(subject.check_board(:E5)).to eq :miss
    end

    it 'the ship will recieve got_hit when it is hit' do
      expect(ship).to receive :got_hit
      subject.check_board(:A2)
    end

    it 'the ship will not receive got_hit when it is missed' do
      expect(ship).to_not receive :got_hit
      subject.check_board(:E5)
    end
  end

  describe '#all_sunk' do
    it 'should return true when ships are all sunk' do
      subject.check_board(:A1)
      subject.check_board(:A2)
      expect(subject.all_sunk?).to eq true
    end

    it 'should return false when ships are not all sunk' do
      subject.check_board(:A1)
      expect(subject.all_sunk?).to eq false
    end
  end

  describe 'logging hits and misses' do
    describe 'hits' do
      it 'should track the hits' do
        subject.check_board(:A1)
        expect(subject.hits).to eq [:A1]
      end
    end

    describe 'misses' do
      it 'should track the misses' do
        subject.check_board(:E5)
        expect(subject.misses).to eq [:E5]
      end
    end

    it 'should raise an error if the user hits the same spot again' do
      subject.check_board(:A1)
      expect { subject.check_board(:A1) }.to raise_error 'You have already hit that spot'
    end

    it 'should raise an error if the user misses the same spot again' do
      subject.check_board(:J10)
      expect { subject.check_board(:J10) }.to raise_error 'You have already missed that spot'
    end
  end

  describe 'board constraints' do
    it 'should raise error if coords are outside of board' do
      expect { subject.place_ship(:ship, :J10, :Vertically) }.to raise_error 'Outside of board'
    end

    it 'should raise error if coords are outside of board' do
      expect { subject.place_ship(:ship, :J10, :Horizontally) }.to raise_error 'Outside of board'
    end
  end
end

