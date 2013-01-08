class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    NanoStore.shared_store = NanoStore.store(:file, App.documents_path + "/nano.db")

    # grumble_controller = GrumbleBoxViewController.new 
    # @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    # @window.rootViewController = grumble_controller
    # @window.makeKeyAndVisible

    new_grumble_controller = GrumbleBoxViewController.alloc.initWithNibName(nil, bundle: nil)
    list_grumble_controller = GrumbleBoxListViewController.alloc.initWithNibName(nil, bundle:nil)

    tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
    tab_controller.viewControllers = [new_grumble_controller, list_grumble_controller]

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = tab_controller

    @window.makeKeyAndVisible
    true
  end
end
