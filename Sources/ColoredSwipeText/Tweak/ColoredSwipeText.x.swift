import Orion
import ColoredSwipeTextC

// ColoredSwipeText - Color the "Swipe up to open" text with ease.
// For iOS 16.0 - 16.7.10
//MARK: - Variables
var tweakPrefs: SettingsModel = SettingsModel()

//MARK: - Initialize Tweak
struct DefaultGroup: HookGroup {}
struct CthulhuLynxGroup: HookGroup {}
struct BarrelRoll: Tweak {
    init() {
        remLog("Preferences Loading...")
        tweakPrefs = TweakPreferences.preferences.loadPreferences()

        switch tweakPrefs.isTweakEnabled {
        case true:
            remLog("Tweak is Enabled! :)")
            if PreferenceCollection.TweakHookingMode.getMode() == .cthulhuMode {
                let cthulhuHook: CthulhuLynxGroup = CthulhuLynxGroup()
                cthulhuHook.activate()
            } else {
                let defaultHook: DefaultGroup = DefaultGroup()
                defaultHook.activate()
            }
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
        
        NotificationCenter.default.addObserver(target, selector: #selector(updateLabel), name: NSNotification.Name("ColorChange"), object: nil)
    }
    
    //orion:new
    func updateLabel() {
        guard let callToActionLabel = target.teachableMomentsContainerView.callToActionLabel else { return }
        callToActionLabel.setTextColor(UIColor(hex: tweakPrefs.labelColor))
    }
}

class LockscreenTeachableMomentsHook: ClassHook<CSTeachableMomentsContainerView> {
    typealias Group = DefaultGroup
    
    func setCallToActionLabel(_ label: SBUILegibilityLabel) {
        orig.setCallToActionLabel(label)
        NotificationCenter.default.post(name: NSNotification.Name("ColorChange"), object: nil)
    }
}

class LockscreenCthulhuLynxHook: ClassHook<CSCoverSheetView> {
    typealias Group = CthulhuLynxGroup
    
    func didMoveToWindow() {
        orig.didMoveToWindow()
        
        guard let callToActionLabel = target.teachableMomentsContainerView.callToActionLabel else { return }
        callToActionLabel.setTextColor(UIColor(hex: tweakPrefs.labelColor))
    }
}
