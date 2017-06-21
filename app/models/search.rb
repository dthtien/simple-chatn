class Search
  attr_reader :term
  def initialize(options)
    @term = options.fetch(:term, "")
  end

  def users
    User.where("email LIKE ?", "%#{term}%")
  end
  
  
end