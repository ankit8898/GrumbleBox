class Issue < NanoStore::Model  
  # Do not move this method down
  def self.initialize_attributes(*attrs)
    attrs.each{|attr| attribute attr}
  end

  initialize_attributes :description, :username, :address, :created_at
  
   
  class << self  
    def create_new(username, description, address) 
      obj = new(username: username,
              description: description,
              address: address, 
              created_at: Time.now) 
      obj.save  
    end  
  end  
end