class Search
  attr_reader :term
  def initialize(options)
    @term = options.fetch(:term, "")
  end

  def users
    User.where("email LIKE ? OR lower(name) LIKE ?", "%#{term}%", "%#{term.downcase}%")
  end
  
  
end