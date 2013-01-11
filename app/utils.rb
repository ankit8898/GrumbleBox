
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
