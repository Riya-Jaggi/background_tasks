package com.example.background_tasks

import android.content.Intent
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import com.pravera.flutter_foreground_task.service.ForegroundService


class MainActivity: FlutterActivity() {
    override fun onPause() {
        super.onPause()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(Intent(this, ForegroundService::class.java))
        } else {
            startService(Intent(this, ForegroundService::class.java))
        }
    }
}
