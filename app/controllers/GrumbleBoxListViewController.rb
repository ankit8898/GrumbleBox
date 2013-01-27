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
    200.0
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
   complain_item = @issues[indexPath.row]
  complain_item_controller = ComplainDetailViewController.new
  complain_item_controller.complain_item = complain_item
  self.navigationController.pushViewController(complain_item_controller,
    animated:true)
end
  
end