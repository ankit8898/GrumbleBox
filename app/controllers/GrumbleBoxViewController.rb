class GrumbleBoxViewController < UIViewController


  NAME_TEXT_FIELD_TAG = 1
  COMPLAIN_FIELD_TAG = 3
  ADDRESS_FIELD_TAG = 2
  BUTTON_TAG = 5
  ADD_PHOTO_BUTTON = 4

  def loadView
    views = NSBundle.mainBundle.loadNibNamed "GrumbleNewView", owner:self, options:nil
    self.view = views[0]
    self.view.backgroundColor =  UIColor.colorWithPatternImage(UIImage.imageNamed('bg'))
  end

  def viewDidLoad
    @text_field_name = text_field_name
    @text_field_complain = text_field_complain
    @text_field_address = text_field_address
    @tap_gesture_recognizer = tap_gesture_recognizer
    @button = button
    
    #custom navigation bar
    setupNavigationBar

    # To capture image
    init_picker_btn
    init_image_picker
    
    subViewAdder [@label_top,@text_field,@button]
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
      opts = {username: @text_field_name.text, complain_description: @text_field_complain.text, address: @text_field_address.text, image: @image_name}
      Issue.create_new(opts)
      clearField
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
    @image_view.image = nil if @image_view
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
   btn.layer.cornerRadius = 5.0
   btn.layer.masksToBounds = true
   btn.addTarget(self, action:'enter', forControlEvents:UIControlEventTouchUpInside)
  end
 
  def imagePickerController(picker, didFinishPickingImage:image, editingInfo:info)
    self.dismissModalViewControllerAnimated(true)
    add_image_view(image)
    save_image
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
  
  def setupNavigationBar
   self.navigationController.navigationBar.setBackgroundImage(UIImage.imageNamed("header.png"),
    forBarMetrics:UIBarMetricsDefault)
   rightButton = UIBarButtonItem.alloc.initWithCustomView(all_complains)
  self.navigationItem.rightBarButtonItem = rightButton
  end
  
  def all_complains
    all_complains = UIButton.buttonWithType(UIButtonTypeCustom)
    all_complains.layer.cornerRadius = 5.0
    all_complains.layer.masksToBounds = true
    all_complains.setTitle("All", forState:UIControlStateNormal)
    all_complains.titleLabel.font = UIFont.fontWithName("Optima",size:18)
    all_complains.frame = [[280, 50], [56, 41]]
    all_complains.setBackgroundImage(UIImage.imageNamed("view_all.jpg"), forState:UIControlStateNormal)
    all_complains.addTarget(self, 
      action:"list_complains", 
      forControlEvents:UIControlEventTouchUpInside)
    all_complains
  end

  def list_complains
    all_controller = GrumbleBoxListViewController.new
    self.navigationController.pushViewController(all_controller, animated: true)
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
    @image_view.frame = [[120, 300], [90, 90]]
    view.addSubview(@image_view)
  end

  def save_image
    # This should be save on to the server once we make http setup
    imageData = UIImage.UIImageJPEGRepresentation(@image_view.image, 1)
    encodedData = [imageData].pack("m0")
    data = {"image" => encodedData }
    unpack = data["image"].unpack("m0")
    @image_name = Time.now.to_s.gsub(/:|-| /,'') + ".jpg"

    File.open("#{App.resources_path}/#{@image_name}", "w+b") do |f|
      f.write(unpack.first)
    end
  end

end