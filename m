Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Shaohua Li <shli@fb.com>, Omar Sandoval <osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: change configfs dependency to select
Message-ID: <5aa79539-200c-c67b-5a28-d1d557036317@kernel.dk>
Date: Tue, 3 Oct 2017 15:50:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

A recent commit made null_blk depend on configfs, which is kind of
annoying since you now have to find this dependency and enable that
as well. Discovered this since I no longer had null_blk available
on a box I needed to debug, since it got killed when the config
updated after the configfs change was merged.

Fixes: 3bf2bd20734e ("nullb: add configfs interface")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 4a438b8abe27..2dfe99b328f8 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -17,7 +17,7 @@ if BLK_DEV
 
 config BLK_DEV_NULL_BLK
 	tristate "Null test block driver"
-	depends on CONFIGFS_FS
+	select CONFIGFS_FS
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
