class Card

  attr_reader :face_value, :face_up

  def initialize(face_value)
    @face_value = face_value
    @face_up = false
  end

  def display
    face_value if face_up
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def to_s
    face_value.to_s
  end

  def == (card)
    self.face_value == card.face_value
  end


end
