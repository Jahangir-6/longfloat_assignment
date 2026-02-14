package com.example.my_flutter_chat_app

import android.content.Context
import android.view.Gravity
import android.view.View
import android.widget.EditText
import android.widget.FrameLayout
import android.widget.ImageView
import androidx.core.content.ContextCompat

class ChatInputView(context: Context) : FrameLayout(context) {

    init {
        setBackgroundColor(ContextCompat.getColor(context, android.R.color.white))

        // Chat logo in the center
        val chatLogo = ImageView(context)
        chatLogo.setImageResource(android.R.drawable.ic_dialog_email)
        chatLogo.layoutParams = LayoutParams(150, 150).apply {
            gravity = Gravity.CENTER
        }

        // Input box at bottom
        val editText = EditText(context)
        editText.hint = "Type your message..."
        editText.layoutParams = LayoutParams(
            LayoutParams.MATCH_PARENT,
            LayoutParams.WRAP_CONTENT
        ).apply {
            gravity = Gravity.BOTTOM
            marginStart = 16
            marginEnd = 16
            bottomMargin = 32
        }

        addView(chatLogo)
        addView(editText)
    }
}
