Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Russell King <linux@armlinux.org.uk>
CC: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe
	<axboe@kernel.dk>, Jan Kara <jack@suse.cz>, <yanaijie@huawei.com>,
	<zhaohongjiang@huawei.com>, <miaoxie@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-block@vger.kernel.org>
Subject: [PATCH] ARM: Fix rd_size declaration
Date: Wed, 3 May 2017 12:46:00 -0700
Message-ID: <20170503194600.16089-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

The global variable 'rd_size' is declared as 'int' in source file
arch/arm/kernel/atags_parse.c and as 'unsigned long' in
drivers/block/brd.c. Fix this inconsistency. Additionally, remove
the declarations of rd_image_start, rd_prompt and rd_doload from
parse_tag_ramdisk() since these duplicate existing declarations
in <linux/initrd.h>.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>
Cc: <yanaijie@huawei.com>
Cc: <zhaohongjiang@huawei.com>
Cc: <miaoxie@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-block@vger.kernel.org
---
 arch/arm/kernel/atags_parse.c | 3 +--
 drivers/block/brd.c           | 1 +
 include/linux/initrd.h        | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 68c6ae0b9e4c..98fbfd235ac8 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/initrd.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/root_dev.h>
@@ -91,8 +92,6 @@ __tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
 #ifdef CONFIG_BLK_DEV_RAM
 static int __init parse_tag_ramdisk(const struct tag *tag)
 {
-	extern int rd_size, rd_image_start, rd_prompt, rd_doload;
-
 	rd_image_start = tag->u.ramdisk.start;
 	rd_doload = (tag->u.ramdisk.flags & 1) == 0;
 	rd_prompt = (tag->u.ramdisk.flags & 2) == 0;
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 3adc32a3153b..30a45080a9b4 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/initrd.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/major.h>
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 55289d261b4f..bc67b767f9ce 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -10,6 +10,9 @@ extern int rd_prompt;
 /* starting block # of image */
 extern int rd_image_start;
 
+/* size of a single RAM disk */
+extern unsigned long rd_size;
+
 /* 1 if it is not an error if initrd_start < memory_start */
 extern int initrd_below_start_ok;
 
-- 
2.12.2
