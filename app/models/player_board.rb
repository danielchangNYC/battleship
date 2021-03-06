class PlayerBoard < ActiveRecord::Base
  SHIPS_ALLOWED = 10
  SIZE = 1..5
  CELLS = SIZE.to_a.length * SIZE.to_a.length

  belongs_to :game
  after_create :generate_cells
  has_many :cells
  has_many :ships, through: :cells
  has_many :moves, through: :cells # moves refers to moves made by the opponent

  validates_presence_of :game_id, :name, :type

  private

  def all_coordinates
    SIZE.to_a.repeated_permutation(2).to_a
  end

  def all_coordinates_as_hashes
    all_coordinates.map do |coordinate|
      {
        row: coordinate[0],
        column: coordinate[1]
      }
    end
  end

  def generate_cells
    cells.create! all_coordinates_as_hashes
  end
end
