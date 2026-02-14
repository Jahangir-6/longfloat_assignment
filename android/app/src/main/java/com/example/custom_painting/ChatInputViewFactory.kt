package com.example.my_flutter_chat_app

import android.content.Context
import android.view.View
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.StandardMessageCodec

class ChatInputViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return object : PlatformView {
            private val chatInputView = ChatInputView(context)
            override fun getView(): View = chatInputView
            override fun dispose() {}
        }
    }
}
