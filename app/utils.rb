
  def subViewAdder arr 
    arr.each {|field| self.view.addSubview field}
  end

    def showAlert(message, title:title)
    alert = UIAlertView.alloc.initWithTitle(title,
      message:message,
      delegate:self,
      cancelButtonTitle:'OK',
      otherButtonTitles:nil)
    alert.show
  end

    def clearField opts
    opts.each_pair {|k,v| v = NSString.new}
    #@text_field_name.text, @text_field_complain.text, @text_field_address.text =  NSString.new,  NSString.new, NSString.new
  end