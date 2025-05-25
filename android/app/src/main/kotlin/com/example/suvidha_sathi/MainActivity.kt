package com.example.suvidha_sathi

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.suvidha_sathi/call"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "makeCall") {
                val number = call.argument<String>("number")
                if (number != null && number.isNotBlank()) {
                    val intent = Intent(Intent.ACTION_CALL)
                    intent.data = Uri.parse("tel:$number")
                    try {
                        startActivity(intent)
                        result.success("Calling $number")
                    } catch (e: Exception) {
                        result.error("CALL_FAILED", "Could not initiate call", e.localizedMessage)
                    }
                } else {
                    result.error("INVALID_NUMBER", "Phone number is null or blank", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
