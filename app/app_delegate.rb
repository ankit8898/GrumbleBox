class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    NanoStore.shared_store = NanoStore.store(:file, App.documents_path + "/nano.db")
    new_grumble_controller = GrumbleBoxViewController.new
    list_grumble_controller = GrumbleBoxListViewController.new
    tab_controller = UITabBarController.new
    tab_controller.viewControllers = [new_grumble_controller, list_grumble_controller]
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = tab_controller
    @window.makeKeyAndVisible
    true
  end
end
