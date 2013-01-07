class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    NanoStore.shared_store = NanoStore.store(:file, App.documents_path + "/nano.db")

    grumble_controller = GrumbleBoxViewController.new 
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = grumble_controller
    @window.makeKeyAndVisible
    true
  end
end
