# CLAUDE.md

此文件为 Claude Code (claude.ai/code) 在此代码库中工作时提供指导。

## 项目概述

这是一个使用 Swift 构建的 iOS 应用程序，采用 UIKit 和 Storyboards。项目遵循标准的 iOS 应用架构：

- **Bundle Identifier**: com.yupingtech.testcc.TestClaudeCode  
- **部署目标**: iOS 18.5
- **Swift 版本**: 5.0
- **Xcode 版本**: 16.4

## 架构

- **AppDelegate.swift**: 主应用委托，处理应用生命周期
- **SceneDelegate.swift**: iOS 13+ 基于场景的生命周期管理
- **ViewController.swift**: 主视图控制器（目前是最小实现）
- **Main.storyboard**: 使用 Interface Builder 的主要 UI 布局
- **LaunchScreen.storyboard**: 应用启动屏幕

## 常用流程

### 构建和运行
- 在Xcode中打开`TestClaudeCode.xcodeproj`
- 尝试构建以测试代码是否有编译问题：`xcodebuild -project TestClaudeCode.xcodeproj -scheme TestClaudeCode -configuration Debug -destination "generic/platform=iOS" -quiet clean build  && echo '** BUILD SUCCEEDED **'`

### 代码检查
- SwiftLint仅在Debug构建时配置
- 配置文件：项目根目录下的`.swiftlint.yml`
- 遵循SwiftLint规则保持代码风格一致
- 开发过程中应处理SwiftLint警告
- 编码后要执行swiftlint检查代码问题
- SwiftLint检查命令：`swiftlint`

### 测试
- 运行单元测试：`xcodebuild test -scheme TestClaudeCodeTests -destination 'platform=iOS Simulator,name=iPhone 16' -quiet && echo '** TESTS SUCCEEDED **'`
- 测试文件位于`TestClaudeCodeTests/`和`TestClaudeCodeUITests/`
- 使用XCTest框架和Combine进行异步测试

## 项目结构

- **TestClaudeCode/**: 主应用目标源文件
- **TestClaudeCodeTests/**: 使用 XCTest 框架的单元测试文件
- **TestClaudeCodeUITests/**: 自动化 UI 测试文件
- **Assets.xcassets/**: 应用图标、图片和其他视觉资源

## 开发注意事项

- 使用基于 Storyboard 的 UI（非 SwiftUI）
- 配置为 iPhone 和 iPad 通用应用
- 支持多种界面方向
- UI约束布局请使用 Snapkit
