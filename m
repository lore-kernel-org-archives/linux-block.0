Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [patch] block: fix up io_poll documentation
Date: Tue, 03 Jan 2017 17:51:33 -0500
Message-ID: <x49zij74v0q.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


/sys/block/<dev>/queue/io_poll is a boolean.  Fix the docs.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index 5164215..c0a3bb5 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -54,9 +54,9 @@ This is the hardware sector size of the device, in bytes.
 
 io_poll (RW)
 ------------
-When read, this file shows the total number of block IO polls and how
-many returned success.  Writing '0' to this file will disable polling
-for this device.  Writing any non-zero value will enable this feature.
+When read, this file shows whether polling is enabled (1) or disabled
+(0).  Writing '0' to this file will disable polling for this device.
+Writing any non-zero value will enable this feature.
 
 io_poll_delay (RW)
 ------------------
