cask "barmod" do
  version "0.1.0"
  sha256 "de6444b0cf5fe0e1f4b3172969719de7dc14f33495efb88bd7e88178a8fef429"

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
