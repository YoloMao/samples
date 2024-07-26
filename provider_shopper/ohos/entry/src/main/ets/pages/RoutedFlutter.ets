import common from '@ohos.app.ability.common'
import router from '@ohos.router'
import {
  FlutterEngine,
  FlutterEntry,
  FlutterManager,
  FlutterPage,
  FlutterPlugin,
  FlutterView } from '@ohos/flutter_ohos'
import { GeneratedPluginRegistrant } from '../plugins/GeneratedPluginRegistrant'

@Entry
@Component
struct RoutedFlutter {
  private flutterEntry: GFlutterEntry | null = null
  private flutterView?: FlutterView
  private context = getContext(this) as common.UIAbilityContext

  aboutToAppear() {
    this.flutterEntry = new GFlutterEntry(this.context)
    this.flutterEntry.setFlutterEngineConfigurator(new GFlutterEngineConfigurator(this.context))
    this.flutterEntry.aboutToAppear()
    this.flutterView = this.flutterEntry.getFlutterView()

    let window = FlutterManager.getInstance()
      .getWindowStage(FlutterManager.getInstance().getUIAbility(this.context))
    window.getMainWindowSync().setWindowLayoutFullScreen(true)
  }

  aboutToDisappear() {
    this.flutterEntry?.aboutToDisappear()
  }

  onPageShow() {
    this.flutterEntry?.onPageShow()
  }

  onPageHide() {
    this.flutterEntry?.onPageHide()
  }

  onBackPress(): boolean | void {
    this.flutterEntry?.onBackPress()
    return true
  }

  build() {
    Stack() {
      FlutterPage({ viewId: this.flutterView?.getId() })
    }
  }
}

interface AsGrowingAnalytics extends FlutterPlugin {
  context: Context
}

class GFlutterEngineConfigurator {
  context: Context
  constructor(context: Context) {
    this.context = context
  }
  configureFlutterEngine(flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine)
    let plugins = flutterEngine.getPlugins()
    if (plugins && plugins.has('FlutterGrowingAutotrackerPlugin')) {
      let analytics = plugins.get('FlutterGrowingAutotrackerPlugin') as AsGrowingAnalytics
      analytics.context = this.context
    }
  }
  cleanUpFlutterEngine(flutterEngine: FlutterEngine) {

  }
}

class GFlutterEntry extends FlutterEntry {
  // 在flutter首页触发onBackPress，则返回鸿蒙页面
  popSystemNavigator(): boolean {
    router.back()
    return true
  }
}