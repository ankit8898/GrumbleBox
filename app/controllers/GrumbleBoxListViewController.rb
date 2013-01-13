class GrumbleBoxListViewController < UITableViewController

  ISSUES_CELL_REUSE_ID = "IssuesCellId"


  def initWithStyle(style)
    super
    self 
  end

  def viewWillAppear(animated)
    @issues =  Issue.all
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
  
end