class GrumbleTableViewCell < UITableViewCell
  attr_accessor :name, :complain, :address, :image_name

  COMPLAIN_CELL_REUSE_ID = "GrumbleTableViewCell"

  def self.cellForComplainItem(complain_item, inTableView:tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(COMPLAIN_CELL_REUSE_ID) || GrumbleTableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:COMPLAIN_CELL_REUSE_ID)
    cell.complain = complain_item.description
    cell.name = complain_item.username
    cell
  end


  def layoutSubviews
    removePreviousViews
    if @background_image.nil?
      @background_image = imageViewWithBackground
      self.addSubview(@background_image)
    end
    @name_label = labelWithName
    @grumble_image = grumbleBoxImage
    self.addSubview(@grumble_image)
    self.addSubview(@name_label)
  end

  def labelWithName
  name_label = UILabel.new.tap do |lb|
  lb.frame = ([[10, 10], [300, 40]])
  lb.font = UIFont.fontWithName("Optima", size:20)
  lb.textColor = UIColor.blackColor
  lb.adjustsFontSizeToFitWidth = true
  lb.text = "Name:  " + @name
  lb.backgroundColor = UIColor.clearColor
  end
end

def grumbleBoxImage
  grumble_image = UIImageView.new.tap do |ui|
  ui.image = UIImage.imageNamed('grumbleicon.png')
  ui.frame = ([[208,20], [102,100]])
  end
end

def removePreviousViews
    @name_label.removeFromSuperview if @name_label
    @grumble_image.removeFromSuperview if @grumble_image
end

  def imageViewWithBackground
    UIImageView.alloc.initWithImage(UIImage.imageNamed("cell.jpg"))
  end
end