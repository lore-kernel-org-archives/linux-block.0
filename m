Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 26 Oct 2017 00:00:50 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] loop: check loop_add's return value
Message-ID: <20171025160031.GA40241@source.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

do cleanup if loop_add fail.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 drivers/block/loop.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bc8e61506968..9bea70a7da16 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1987,6 +1987,14 @@ static struct miscdevice loop_misc = {
 MODULE_ALIAS_MISCDEV(LOOP_CTRL_MINOR);
 MODULE_ALIAS("devname:loop-control");
 
+static int loop_exit_cb(int id, void *ptr, void *data)
+{
+	struct loop_device *lo = ptr;
+
+	loop_remove(lo);
+	return 0;
+}
+
 static int __init loop_init(void)
 {
 	int i, nr;
@@ -2050,27 +2058,29 @@ static int __init loop_init(void)
 
 	/* pre-create number of devices given by config or max_loop */
 	mutex_lock(&loop_index_mutex);
-	for (i = 0; i < nr; i++)
-		loop_add(&lo, i);
+	for (i = 0; i < nr; i++) {
+		err = loop_add(&lo, i);
+		if (err < 0) {
+			mutex_unlock(&loop_index_mutex);
+			goto err_blk;
+		}
+	}
 	mutex_unlock(&loop_index_mutex);
 
 	printk(KERN_INFO "loop: module loaded\n");
 	return 0;
 
+err_blk:
+	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
+	idr_destroy(&loop_index_idr);
+	blk_unregister_region(MKDEV(LOOP_MAJOR, 0), range);
+	unregister_blkdev(LOOP_MAJOR, "loop");
 misc_out:
 	misc_deregister(&loop_misc);
 err_out:
 	return err;
 }
 
-static int loop_exit_cb(int id, void *ptr, void *data)
-{
-	struct loop_device *lo = ptr;
-
-	loop_remove(lo);
-	return 0;
-}
-
 static void __exit loop_exit(void)
 {
 	unsigned long range;
-- 
2.14.2
