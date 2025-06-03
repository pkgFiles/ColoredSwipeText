import Orion
import ColoredSwipeTextC

// ColoredSwipeText - [...]
// For iOS 14.0 - 16.7.10
// Made for personal purposes
//MARK: - Variables
var tweakPrefs: SettingsModel = SettingsModel()

//MARK: - Initialize Tweak
struct DefaultGroup: HookGroup {}
struct BarrelRoll: Tweak {
    init() {
         remLog("Preferences Loading...")
         tweakPrefs = TweakPreferences.preferences.loadPreferences()
         
         let defaultHook: DefaultGroup = DefaultGroup()

         switch tweakPrefs.isTweakEnabled {
         case true:
             remLog("Tweak is Enabled! :)")
             defaultHook.activate()
         case false:
             remLog("Tweak is Disabled! :(")
             break
         }
    }
}

//MARK: - Hooks
class LockscreenViewHook: ClassHook<CSCoverSheetView> {
    typealias Group = DefaultGroup
    
    func didMoveToWindow() {
        orig.didMoveToWindow()

        guard let callToActionLabel = target.teachableMomentsContainerView.callToActionLabel else { return }
        callToActionLabel.setTextColor(UIColor(hex: tweakPrefs.labelColor))
    }
}
