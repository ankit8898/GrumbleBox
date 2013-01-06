class GrumbleBoxViewController < UIViewController

  HEADER_LABEL_TAG = 1
  NAME_TEXT_FIELD_TAG = 2
  COMPLAIN_FIELD_TAG = 3
  ADDRESS_FIELD_TAG = 4
  BUTTON_TAG = 5

  def loadView
    views = NSBundle.mainBundle.loadNibNamed "GrumbleBoxView", owner:self, options:nil
    self.view = views[0]
    self.title = "New Complaint"
  end

  def viewDidLoad
    @label_top = label_top
    @text_field_name = text_field_name
    @text_field_complain = text_field_complain
    @text_field_address = text_field_address
    @tap_gesture_recognizer = tap_gesture_recognizer
    @button = button
    subViewAdder [@label_top,@text_field,@button]
    self.view.addGestureRecognizer(@tap_gesture_recognizer)
  end


  def dismissKeyboard(tap_gesture_recognizer)
    @text_field_name.resignFirstResponder
    @text_field_complain.resignFirstResponder
    @text_field_address.resignFirstResponder
  end

  def tap_gesture_recognizer
    UITapGestureRecognizer.alloc.initWithTarget(self,action:'dismissKeyboard:')
  end

  def enter
    unless isvalidForm
      #form save logic will come here
      showAlert("Success", title:"This should work when form submit is valid")
    else
     showAlert("Error", title:"Please, fill all the fields.")
   end
 end

 def isvalidForm
  #form validation should come here
  false
end

 def close
  dismissModalViewControllerAnimated true
end

def showAlert(message, title:title)
  alert = UIAlertView.alloc.initWithTitle(title,
    message:message,
    delegate:self,
    cancelButtonTitle:'OK',
    otherButtonTitles:nil)
  alert.show
end

def label_top
  self.view.viewWithTag HEADER_LABEL_TAG 
end

def text_field_name
  self.view.viewWithTag NAME_TEXT_FIELD_TAG
end

def text_field_complain
  self.view.viewWithTag COMPLAIN_FIELD_TAG
end

def text_field_address
  self.view.viewWithTag ADDRESS_FIELD_TAG
end

def button
 btn = self.view.viewWithTag BUTTON_TAG
 btn.addTarget(self, action:'enter', forControlEvents:UIControlEventTouchUpInside)
end

def clearField
  @text_field_name.text, @text_field_mail.text =  NSString.new,  NSString.new      
end

def subViewAdder arr 
  arr.each {|field| self.view.addSubview field}
end
end