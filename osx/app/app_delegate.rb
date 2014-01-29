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
    url = "#{CLIP_URL_PREFIX}/#{clip_name}"

    # Verify url exists
    BW::HTTP.get(url) do |response|
      if response.status_code == 200
        # FIXME: THIS IS A MAJOR HACK JOB
        `curl -s #{url} -o /tmp/dPanda_#{clip_name} && afplay -t 5 /tmp/dPanda_#{clip_name}`
      end
    end

  end

  def testAudioAction
    playAudio('headshot')
  end

end