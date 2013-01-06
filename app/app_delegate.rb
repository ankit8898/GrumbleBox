class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    grumble_controller = GrumbleBoxViewController.new 
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = grumble_controller
    @window.makeKeyAndVisible
    true
  end
end
