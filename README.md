# VimeoPublishPlugin

A plugin for [Publish](https://github.com/JohnSundell/Publish) that lets you embed Vimeo videos into your posts.

This plugin was inspired by, and heavily borrows ideas from, [Gui Rambo's](https://github.com/insidegui) [TwitterPublishPlugin](https://github.com/insidegui/TwitterPublishPlugin)

To embed a Vimeo video in your post, use a markdown blockquote, and add a **vimeo** prefix:

```
> vimeo https://vimeo.com/595434582
```

To install the plugin, add it to your site's publishing steps:

```swift
try mysite().publish(using: [
    .installPlugin(.vimeo()),
    // ...
])
```
