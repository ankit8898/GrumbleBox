class GrumbleBoxListViewController < UIViewController

  ISSUES_CELL_REUSE_ID = "IssuesCellId"

  # def initWithStyle(style)
  #   super
  #   self.title = "All Complaints"
  #   self
  # end

  def viewDidLoad
    super

    self.title = "All Complaints"

    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.dataSource = self
    @table.delegate = self
    @issues = Issue.all
    self.view.addSubview @table
  end

  # def viewWillAppear(animated)
  #   @issues =  Issue.all
  #   self.tableView.reloadData
  # end
 
  def tableView(tableView, numberOfRowsInSection:section)
    @issues.length
  end


  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(ISSUES_CELL_REUSE_ID) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: ISSUES_CELL_REUSE_ID)
    issue_item = @issues[ indexPath.row ]
    cell.textLabel.text = issue_item.description
    cell.detailTextLabel.text = issue_item.username
    cell
  end
end