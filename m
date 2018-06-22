Return-Path: <elviskitone@gmail.com>
Return-Path: <elviskitone@gmail.com>
Date: Fri, 22 Jun 2018 14:39:19 +0300
From: Kitone Elvis Peter <elviskitone@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] block: Change simple_strtol() to kstrtol()
Message-ID: <20180622113918.GA6633@kitone-HP-ProBook-4530s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

The usage of simple_strtol is discouraged, because
strtol() is obsolete. Instead kstrtol() should be 
used to convert a string into a long integer.  

Signed-off-by: Kitone Elvis Peter <elviskitone@gmail.com>
---
 drivers/block/brd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index e2a1278..4b7a28e 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -351,7 +351,7 @@ MODULE_ALIAS("rd");
 /* Legacy boot options - nonmodular */
 static int __init ramdisk_size(char *str)
 {
-	rd_size = simple_strtol(str, NULL, 0);
+	rd_size = kstrtol(str, NULL, 0);
 	return 1;
 }
 __setup("ramdisk_size=", ramdisk_size);
-- 
2.7.4
