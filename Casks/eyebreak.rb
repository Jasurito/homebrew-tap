cask "eyebreak" do
  version "1.3.0"
  sha256 "02c440951815fc07d1da23ea78f6edf81083b920ed81f7320d6385f836ea1ff3"

  url "https://github.com/Jasurito/EyeBreak/releases/download/v#{version}/EyeBreak-#{version}.zip"
  name "EyeBreak"
  desc "Menu bar reminder for the 20-20-20 eye strain rule"
  homepage "https://github.com/Jasurito/EyeBreak"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "EyeBreak.app"

  # The app isn't notarized by Apple, so Gatekeeper would block the first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/EyeBreak.app"],
        must_succeed: false
  end

  uninstall quit: "com.jasurito.EyeBreak"

  zap trash: [
    "~/Library/Application Support/EyeBreak",
    "~/Library/Preferences/com.jasurito.EyeBreak.plist",
  ]
end
