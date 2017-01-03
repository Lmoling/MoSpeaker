Pod::Spec.new do |s|

  s.name         = "MoSpeaker"
  s.version      = "1.0.2"
  s.summary      = "voice recognition player"

 s.homepage     = "https://github.com/Lmoling/MoSpeaker"

  s.license = "MIT"

  s.author = {"Lmoling" => "lmoling@yeah.net"}

  s.platform = :ios, "7.0"

  s.source       = { :git => "https://github.com/Lmoling/MoSpeaker.git", :tag => s.version }

  s.source_files  = "MoSpeaker", "_moSpeaker/**/*.{h,m}"

end
