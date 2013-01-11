class Issue < NanoStore::Model  
  # Do not move this method down
  def self.attributes(*attrs)
    attrs.size > 0 ? attrs.each{|attr| attribute attr} : super
  end

  attributes :description, :username, :address, :created_at
   
  class << self  
    def create_new(opts) 
      obj = new(username: opts[:username],
              description: opts[:complain_description],
              address: opts[:address], 
              created_at: Time.now) 
      obj.save  
    end  
  end  
end