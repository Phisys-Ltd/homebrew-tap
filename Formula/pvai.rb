class Pvai < Formula
  desc "Make Claude Code and Codex sessions reachable for the PhiVoice AI app"
  homepage "https://github.com/Phisys-Ltd/pvai"
  url "https://github.com/Phisys-Ltd/pvai/archive/refs/tags/v0.5.29.tar.gz"
  sha256 "af73aa460fde1b13743507361b36d8e0a88e9aed7556e0d281c175b4c8515b12"
  license all_of: ["Apache-2.0", "MIT"]
  head "https://github.com/Phisys-Ltd/pvai.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "nlohmann-json" => :build
  depends_on "openssl@3"

  def install
    system "cmake", "-S", ".", "-B", "build", "-G", "Ninja", "-DBUILD_TESTING=OFF", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
      Start Claude Code through pvai so the PhiVoice AI app can reach it:
        pvai run -- claude
        pvai codex
      The first `pvai run` adds pvai's hooks to ~/.claude/settings.json.
      Setup, pairing and removal: https://github.com/Phisys-Ltd/pvai/blob/main/docs/INSTALL.md
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pvai --version").strip
  end
end
