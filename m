Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Russell King <linux@armlinux.org.uk>
CC: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe
	<axboe@kernel.dk>, Jan Kara <jack@suse.cz>, <yanaijie@huawei.com>,
	<zhaohongjiang@huawei.com>, <miaoxie@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-block@vger.kernel.org>
Subject: [PATCH] ARM: Fix rd_size declaration
Date: Mon, 17 Apr 2017 16:10:03 -0700
Message-ID: <20170417231003.7178-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

The global variable 'rd_size' is declared as 'int' in source file
arch/arm/kernel/atags_parse.c and as 'unsigned long' in
drivers/block/brd.c. Fix this inconsistency.

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
 arch/arm/kernel/atags_parse.c | 4 ++--
 drivers/block/brd.c           | 1 +
 include/linux/brd.h           | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/brd.h

diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 68c6ae0b9e4c..85cb659e622a 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -23,6 +23,8 @@
 #include <linux/root_dev.h>
 #include <linux/screen_info.h>
 #include <linux/memblock.h>
+#include <linux/brd.h>		/* rd_size */
+#include <linux/initrd.h>	/* rd_image_start, rd_prompt, rd_doload */
 
 #include <asm/setup.h>
 #include <asm/system_info.h>
@@ -91,8 +93,6 @@ __tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
 #ifdef CONFIG_BLK_DEV_RAM
 static int __init parse_tag_ramdisk(const struct tag *tag)
 {
-	extern int rd_size, rd_image_start, rd_prompt, rd_doload;
-
 	rd_image_start = tag->u.ramdisk.start;
 	rd_doload = (tag->u.ramdisk.flags & 1) == 0;
 	rd_prompt = (tag->u.ramdisk.flags & 2) == 0;
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 3adc32a3153b..6d4bd38a9b7c 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -24,6 +24,7 @@
 #endif
 
 #include <linux/uaccess.h>
+#include <linux/brd.h>
 
 #define SECTOR_SHIFT		9
 #define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
diff --git a/include/linux/brd.h b/include/linux/brd.h
new file mode 100644
index 000000000000..dbb0f92fefc8
--- /dev/null
+++ b/include/linux/brd.h
@@ -0,0 +1 @@
+extern unsigned long rd_size;
-- 
2.12.2
