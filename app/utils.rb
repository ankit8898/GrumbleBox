
  def subViewAdder arr
    case self.superclass
    when UIViewController
      arr.each {|field| self.view.addSubview field}
    when UITableViewCell
      p "------------------"
      arr.each {|field| self.addSubview field}  
    end
  end

    def showAlert(message, title:title)
    alert = UIAlertView.alloc.initWithTitle(title,
      message:message,
      delegate:self,
      cancelButtonTitle:'OK',
      otherButtonTitles:nil)
    alert.show
  end
