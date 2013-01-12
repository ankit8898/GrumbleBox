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

    if @background_image.nil?

      @background_image = imageViewWithBackground
      self.addSubview(@background_image)
    end
  end

  def imageViewWithBackground

    UIImageView.alloc.initWithImage(UIImage.imageNamed("cell.jpg"))
  end
end