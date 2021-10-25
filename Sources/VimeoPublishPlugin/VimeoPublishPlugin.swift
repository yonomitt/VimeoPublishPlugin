//
//  VimeoPublishPlugin.swift
//
//
//  Created by Yonatan Mittlefehldt on 2021-24-10.
//

import Publish
import Ink
import Foundation

public extension Plugin {
    static func vimeo() -> Self {
        Plugin(name: "Vimeo Video Embedder") { context in
            context.markdownParser.addModifier(
                .vimeoBlockquote()
            )
        }
    }
}

public extension Modifier {
    static func vimeoBlockquote() -> Self {
        return Modifier(target: .blockquotes) { html, markdown in
            let prefix = "vimeo "
            var markdown = markdown.dropFirst().trimmingCharacters(in: .whitespaces)

            guard markdown.hasPrefix(prefix) else {
                return html
            }

            markdown = markdown.dropFirst(prefix.count).trimmingCharacters(in: .newlines)

            let embeddedVideo = try! VimeoAPI.metadata(for: markdown)

            return embeddedVideo.html
        }
    }
}
