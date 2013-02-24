class GrumbleBoxListViewController < UITableViewController

  ISSUES_CELL_REUSE_ID = "IssuesCellId"


  def initWithStyle(style)
    super
    self 
  end
 

  def viewWillAppear(animated)
    @issues =  Issue.all
    back_button_background = UIImage.imageNamed("back_btn.jpg").resizableImageWithCapInsets([0, 14, 0, 6])
    back_button = UIBarButtonItem.appearance.setBackButtonBackgroundImage(back_button_background, forState: UIControlStateNormal, barMetrics: UIBarMetricsDefault)
    self.navigationItem.backBarButtonItem = back_button
    setupNavigationBar
    add_button_background = UIImage.imageNamed("add_new.png")
    add_button = UIButton.buttonWithType UIButtonTypeRoundedRect
    add_button.setBackgroundImage(add_button_background, forState: UIControlStateNormal)
    add_button.frame = [[120, 50], [25, 25]]
    add_button.addTarget(self,
      action: :new_complaint,
      forControlEvents: UIControlEventTouchUpInside)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithCustomView(add_button)

    self.tableView.reloadData
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    @issues.length
  end
  
  def tableView(tableView, cellForRowAtIndexPath:indexPath)    
    complain_item = @issues[ indexPath.row ]      
    GrumbleTableViewCell.cellForComplainItem(complain_item, inTableView:tableView)
  end 

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    50.0
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

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
   complain_item = @issues[indexPath.row]
  complain_item_controller = ComplainDetailViewController.new
  complain_item_controller.complain_item = complain_item
  self.navigationController.pushViewController(complain_item_controller,
    animated:true)
end
  
end