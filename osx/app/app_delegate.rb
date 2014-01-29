class AppDelegate
  attr_accessor :status_menu

  def applicationDidFinishLaunching(notification)

    @app_name = NSBundle.mainBundle.infoDictionary['CFBundleDisplayName']

    @status_menu = NSMenu.new

    @status_item = NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength).init
    @status_item.setMenu(@status_menu)
    @status_item.setHighlightMode(true)
    @status_item.setTitle(@app_name)

    #@status_menu.addItem createMenuItem("About #{@app_name}", 'orderFrontStandardAboutPanel:')
    @status_menu.addItem createMenuItem("Test Audio", 'testAudioAction')
    @status_menu.addItem createMenuItem("Quit", 'terminate:')

    # Do the firebase stuff here
    firebase = Firebase.new(FIREBASE_URL)
    firebase.auth(FIREBASE_AUTH)

    firebase.on(:changed) { |snapshot|
      playAudio(snapshot.value['sound'])
    }
  end

  def createMenuItem(name, action)
    NSMenuItem.alloc.initWithTitle(name, action: action, keyEquivalent: '')
  end

  def playAudio(clip_name)
    ap clip_name
    # Cringeworthy code below
    `curl -s #{CLIP_URL_PREFIX}/#{clip_name} -o /tmp/dPanda_#{clip_name} && afplay -t 5 /tmp/dPanda_#{clip_name}`
  end

  def testAudioAction
    playAudio('headshot')
  end

end