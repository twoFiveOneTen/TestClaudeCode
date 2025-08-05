# 问题1
**错误内容**
Cannot find '***' in scope SourceKit
**解决方案1**
执行以下命令
```
xcode-build-server config -project *.xcodeproj -scheme TimeMemory
rm -r .bundle; xcodebuild -project *.xcodeproj -scheme TimeMemory -destination 'generic/platform=iOS Simulator' -resultBundlePath .bundle build
```
