class GrumbleBoxViewController < UIViewController

  HEADER_LABEL_TAG = 1
  NAME_TEXT_FIELD_TAG = 2
  COMPLAIN_FIELD_TAG = 3
  ADDRESS_FIELD_TAG = 4
  BUTTON_TAG = 5
  COUNT_LABEL_TAG = 6
  ADD_PHOTO_BUTTON = 7

  def loadView
    views = NSBundle.mainBundle.loadNibNamed "GrumbleBoxView", owner:self, options:nil
    self.view = views[0]
    self.title = "New Complaint"
  end

  def viewDidLoad
    @label_top = label_top
    @label_count = label_count
    @label_count.setNeedsDisplay
    @text_field_name = text_field_name
    @text_field_complain = text_field_complain
    @text_field_address = text_field_address
    @tap_gesture_recognizer = tap_gesture_recognizer
    @button = button

    # To capture image
    init_picker_btn
    init_image_picker
    
    subViewAdder [@label_top,@text_field,@button,@label_count]
    self.view.addGestureRecognizer(@tap_gesture_recognizer)
  end
 
  def viewDidUnload
    super
    @label_top,@text_field,@button,@label_count = nil
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
    if isvalidForm?
      opts = {username: @text_field_name.text, complain_description: @text_field_complain.text, address: @text_field_address.text }
      Issue.create_new(opts)
      clearField
      label_count
      showAlert("Success", title:"Your Complain is Listed. ")
    else
      showAlert("Error", title:"Please, fill all the fields.")
    end
  end

  def isvalidForm?
    #form validation should come here
    ![@text_field_name.text, @text_field_complain.text, @text_field_address.text].any?{|field| field.empty?}
  end

  def close
    dismissModalViewControllerAnimated true
  end

  def label_count
    label =  self.view.viewWithTag COUNT_LABEL_TAG 
    label.text = "#{Issue.count} Complains Listed"
    label
  end
  
   def clearField
    @text_field_name.text, @text_field_complain.text, @text_field_address.text =  NSString.new,  NSString.new, NSString.new
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
 
  def imagePickerController(picker, didFinishPickingImage:image, editingInfo:info)
    self.dismissModalViewControllerAnimated(true)
    add_image_view(image)
    apply_image_filter
  end

  private

  def init_picker_btn
    btn = self.view.viewWithTag ADD_PHOTO_BUTTON
    btn.addTarget(self, action: :touched, forControlEvents:UIControlEventTouchUpInside)
  end

  def init_image_picker
    @image_picker = UIImagePickerController.alloc.init
    @image_picker.delegate = self
    @image_picker.sourceType = camera_available ?
    UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary
  end

  def touched
    presentModalViewController(@image_picker, animated:true)
  end

  def camera_available
    UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceTypeCamera)
  end

  def add_image_view(image)
    @image_view.removeFromSuperview if @image_view
    @image_view = UIImageView.alloc.initWithImage(image)
    @image_view.frame = [[60, 320], [200, 200]]
    view.addSubview(@image_view)
  end

  def apply_image_filter
    ci_image = CIImage.imageWithCGImage(@image_view.image.CGImage)
    filter = CIFilter.filterWithName("CIColorPosterize")

    filter.setValue(ci_image, forKey:KCIInputImageKey)
    adjusted_image = filter.valueForKey(KCIOutputImageKey)

    new_image = UIImage.imageWithCIImage(adjusted_image)
    @image_view.image = new_image
  end
end