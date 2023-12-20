# S23

My phone requirements: 
- have wireless charging
- not be chinese branded
- not apple (sorry)

That's it.

wireless charging yes, can reduce battery life in the long term, and yes, generates excessive heat thus also costing more in power, but for a single digit wattage phone charger, I don't see the power bill being an issue.

Battery endurance is also something that I'd love to maximise, as it reduces eWaste and reduces unnecessary financial expenditures, but _for me_, the convenience of wireless charging is so much greater than the battery endurance, that I am ok with the drawback. Furthermore, I mandate 5W slowcharging as I always charge overnight, which also reduces battery wear.

Would have gotten Samsung A54 but, no wireless charging.

Pixel 7a was tempting but their quick panel (settings above notif) isn't for me (too many taps), and google might kill it at any time.

Found a good deal on the S23 so here we are.

## ADB Bloatware Removal

This is my list of applications that I removed from my S23 using the Android Development Bridge on Windows Powershell. Syntax should be the same across platforms, just not the `.\` part.

You can find out what each app's APK name is using an Application Inspector. I use [this one](https://play.google.com/store/apps/details?id=com.ubqsoft.sec01). 

```powershell
.\adb.exe shell pm uninstall -k --user 0 com.facebook.katana
.\adb.exe shell pm uninstall -k --user 0 com.facebook.services
.\adb.exe shell pm uninstall -k --user 0 com.facebook.system
.\adb.exe shell pm uninstall -k --user 0 com.facebook.appmanager
.\adb.exe shell pm uninstall -k --user 0 com.linkedin.android
.\adb.exe shell pm uninstall -k --user 0 com.microsoft.appmanager
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.mdx
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.calendar
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.vtcamerasettings
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.allshare.service.mediashare
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.smartsuggestions
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.samsungpassautofill
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.app.omcagent
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.mcfserver
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.app.watchmanagerstub
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.mcfds
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.visionintelligence
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.bbc.bbcagent
.\adb.exe shell pm uninstall -k --user 0 com.sec.android.easyMover
.\adb.exe shell pm uninstall -k --user 0 com.android.bips
.\adb.exe shell pm uninstall -k --user 0 com.android.bluetoothmidiservice
.\adb.exe shell pm uninstall -k --user 0 com.android.dreams.basic
.\adb.exe shell pm uninstall -k --user 0 com.android.dreams.phototable
.\adb.exe shell pm uninstall -k --user 0 com.android.printspooler
.\adb.exe shell pm uninstall -k --user 0 com.android.providers.partnerbookmarks
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.app.reminder
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.app.settings.bixby
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.bixby.agent
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.bixby.wakeup
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.bixbyvision.framework
.\adb.exe shell pm uninstall -k --user 0 com.diotek.sec.lookup.dictionary
.\adb.exe shell pm uninstall -k --user 0 com.microsoft.skydrive
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.aircommandmanager
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.app.camera.sticker.facearavatar.preload
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.app.clipboardedge
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.app.cocktailbarservice
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.app.taskedge
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.ardrawing
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.aremoji
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.aremojieditor
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.beaconmanager
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.easysetup
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.kidsinstaller
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.rubin.app
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.service.peoplestripe
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.stickercenter
.\adb.exe shell pm uninstall -k --user 0 com.samsung.faceservice
.\adb.exe shell pm uninstall -k --user 0 com.samsung.storyservice
.\adb.exe shell pm uninstall -k --user 0 com.sec.android.app.magnifier
.\adb.exe shell pm uninstall -k --user 0 com.sec.android.app.quicktool
.\adb.exe shell pm uninstall -k --user 0 com.sec.android.easyMover.Agent
.\adb.exe shell pm uninstall -k --user 0 com.sec.android.easyonehand
.\adb.exe shell pm uninstall -k --user 0 com.sec.android.mimage.avatarstickers
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.scpm
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.fast
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.dkey
.\adb.exe shell pm uninstall -k --user 0 com.samsung.app.newtrim
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.spayfw
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.scloud
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.honeyboard
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.fmm
.\adb.exe shell pm uninstall -k --user 0 com.osp.app.signin
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.game.gos
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.carkey
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.authfw
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.coldwalletservice
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.ipsgeofence
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.da.daagent
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.game.gametools
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.app.contacts
.\adb.exe shell pm uninstall -k --user 0 com.samsung.knox.securefolder
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.kgclient
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.themecenter
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.mobileservice
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.mdecservice
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.rampart
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.mdx.kit
.\adb.exe shell pm uninstall -k --user 0 com.google.android.apps.tachyon
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.messaging
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.net.wifi.wifiguider
.\adb.exe shell pm uninstall -k --user 0 com.android.hotwordenrollment.xgoogle
.\adb.exe shell pm uninstall -k --user 0 com.google.android.apps.accessibility.voiceaccess
.\adb.exe shell pm uninstall -k --user 0 com.sec.android.daemonapp
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.game.gamehome
.\adb.exe shell pm uninstall -k --user 0 com.sec.android.app.billing
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.visualars
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.smartmirroring

.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.incallui
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.mapsagent
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.service.tagservice
.\adb.exe shell pm uninstall -k --user 0 com.sec.location.nsflp2
.\adb.exe shell pm uninstall -k --user 0 com.samsung.android.themestore
.\adb.exe shell pm uninstall -k --user 0 com.sec.android.widgetapp.webmanual
.\adb.exe shell pm uninstall -k --user 0 com.google.android.apps.tachyon
.\adb.exe shell pm uninstall -k --user 0 com.sec.android.app.samsungapps
```

#### Restore app

If you mess up and need to restore an app, you can restore with



```powershell
.\adb shell pm install-existing --user 0 com.app.dir
.\adb shell pm enable --user 0 com.app
```