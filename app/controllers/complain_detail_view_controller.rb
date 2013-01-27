class ComplainDetailViewController < UIViewController

 attr_accessor :complain_item

  TITLE_LABEL_TAG = 1
  IMAGE_VIEW_TAG = 2
  COMPLAIN_TAG = 4
  
  
   def loadView
    views = NSBundle.mainBundle.loadNibNamed "GrumbleComplainDetail", owner:self, options:nil
    self.view = views[0]
    self.view.backgroundColor =  UIColor.colorWithPatternImage(UIImage.imageNamed('bg'))
  end

  def viewDidLoad
    setup_title_label
    setup_image_view
    setup_complain
  end


  def setup_title_label
    title_label = self.view.viewWithTag(TITLE_LABEL_TAG)
    title_label.text = @complain_item.username
  end


  def setup_image_view
    if @complain_item.image
      image_view = self.view.viewWithTag(IMAGE_VIEW_TAG)
      image_view.image = UIImage.imageNamed @complain_item.image
    end
  end

def setup_complain
  complain = self.view.viewWithTag(COMPLAIN_TAG)
  complain.text = @complain_item.description
end

end