cask "barmod" do
  version "0.1.2"
  sha256 "1aced4d753f188c5f3bdb00990272caebc1412fc3ac1ae6ecaa3dd8fee5c25c8"

  url "https://github.com/Jasurito/BarMod/releases/download/v#{version}/BarMod-#{version}.zip"
  name "BarMod"
  desc "Windows-style popup for hidden menu bar icons"
  homepage "https://github.com/Jasurito/BarMod"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "BarMod.app"

  # The app isn't notarized by Apple, so Gatekeeper would block the first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/BarMod.app"],
        must_succeed: false
  end

  uninstall quit: "com.jasurito.BarMod"

  zap trash: [
    "~/Library/Logs/BarMod",
    "~/Library/Preferences/com.jasurito.BarMod.plist",
  ]

  caveats "BarMod needs Accessibility access to find hidden icons. Allow it under System Settings → Privacy & Security → Accessibility."
end
