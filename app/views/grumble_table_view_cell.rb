class GrumbleTableViewCell < UITableViewCell
  attr_accessor :name, :complain, :address, :image

  COMPLAIN_CELL_REUSE_ID = "GrumbleTableViewCell"

  def self.cellForComplainItem(complain_item, inTableView:tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(COMPLAIN_CELL_REUSE_ID) || GrumbleTableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:COMPLAIN_CELL_REUSE_ID)
    cell.complain = complain_item.description
    cell.name = complain_item.username
    cell.address = complain_item.address
    cell.image = complain_item.image
    cell
  end


  def layoutSubviews
    removePreviousViews
    if @background_image.nil?
      @background_image = imageViewWithBackground
      #self.addSubview(@background_image)
    end
    @name_complain_label = labelWithNameAndComplain
    @grumble_image = grumbleBoxImage
    #self.addSubview(@grumble_image)
    self.addSubview(@name_complain_label)
  end

  def labelWithNameAndComplain
  name_label = UILabel.new.tap do |lb|
  lb.frame = ([[10, 10], [300, 40]])
  lb.font = UIFont.fontWithName("futura", size:17)
  lb.textColor = UIColor.blackColor
  lb.adjustsFontSizeToFitWidth = true
  lb.text = formatted_message.camelize
  lb.backgroundColor = UIColor.clearColor
  end
end

 def formatted_message
  "#{@name} says, #{@complain} !"
 end

def grumbleBoxImage
  grumble_image = UIImageView.new.tap do |ui|
  ui.image = @image.nil? ? UIImage.imageNamed('grumbleicon.png') : UIImage.imageWithContentsOfFile(App.resources_path + '/' + @image)
  ui.frame = ([[209,86], [102,100]])
  end
end

def removePreviousViews
    @name_complain_label.removeFromSuperview if @name_complain_label
end

  def imageViewWithBackground
    UIImageView.alloc.initWithImage(UIImage.imageNamed("cell.jpg"))
  end
end