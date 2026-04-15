# ProGuard 规则
-keep class com.douniu.game.** { *; }
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}
-dontwarn android.webkit.**
