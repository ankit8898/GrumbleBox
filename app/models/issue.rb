class Issue < NanoStore::Model  
  # Do not move this method down
  def self.attributes(*attrs)
    attrs.size > 0 ? attrs.each{|attr| attribute attr} : super
  end

  attributes :description, :username, :address, :created_at, :image
   
  class << self  
    def create_new(opts) 
      obj = new(username: opts[:username],
              description: opts[:complain_description],
              address: opts[:address], 
              image: opts[:image],
              created_at: Time.now) 
      obj.save  
    end  
  end  
end