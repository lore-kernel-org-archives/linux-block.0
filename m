Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33348 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753925AbdC1G3z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 02:29:55 -0400
Received: by mail-pg0-f41.google.com with SMTP id n5so55446574pgh.0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 23:29:49 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Tim Waugh <tim@cyberelk.net>
Subject: [PATCH 2/6] parport/pd: stop sharing request queue across multiple gendisks
Date: Mon, 27 Mar 2017 23:28:43 -0700
Message-Id: <70d4d7b67848ee2fdcbfcf6b1accc89ac7a1659c.1490681910.git.osandov@fb.com>
In-Reply-To: <cover.1490681910.git.osandov@fb.com>
References: <cover.1490681910.git.osandov@fb.com>
In-Reply-To: <cover.1490681910.git.osandov@fb.com>
References: <cover.1490681910.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Compile-tested only.

Cc: Tim Waugh <tim@cyberelk.net>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/paride/pd.c | 50 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 9cfd2e06a649..b05e151c9b38 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -381,12 +381,33 @@ static enum action do_pd_write_start(void);
 static enum action do_pd_read_drq(void);
 static enum action do_pd_write_done(void);
 
-static struct request_queue *pd_queue;
+static int pd_queue;
 static int pd_claimed;
 
 static struct pd_unit *pd_current; /* current request's drive */
 static PIA *pi_current; /* current request's PIA */
 
+static int set_next_request(void)
+{
+	struct gendisk *disk;
+	struct request_queue *q;
+	int old_pos = pd_queue;
+
+	do {
+		disk = pd[pd_queue].gd;
+		q = disk ? disk->queue : NULL;
+		if (++pd_queue == PD_UNITS)
+			pd_queue = 0;
+		if (q) {
+			pd_req = blk_fetch_request(q);
+			if (pd_req)
+				break;
+		}
+	} while (pd_queue != old_pos);
+
+	return pd_req != NULL;
+}
+
 static void run_fsm(void)
 {
 	while (1) {
@@ -418,8 +439,7 @@ static void run_fsm(void)
 				spin_lock_irqsave(&pd_lock, saved_flags);
 				if (!__blk_end_request_cur(pd_req,
 						res == Ok ? 0 : -EIO)) {
-					pd_req = blk_fetch_request(pd_queue);
-					if (!pd_req)
+					if (!set_next_request())
 						stop = 1;
 				}
 				spin_unlock_irqrestore(&pd_lock, saved_flags);
@@ -839,7 +859,13 @@ static void pd_probe_drive(struct pd_unit *disk)
 	p->first_minor = (disk - pd) << PD_BITS;
 	disk->gd = p;
 	p->private_data = disk;
-	p->queue = pd_queue;
+	p->queue = blk_init_queue(do_pd_request, &pd_lock);
+	if (!p->queue) {
+		disk->gd = NULL;
+		put_disk(p);
+		return;
+	}
+	blk_queue_max_hw_sectors(p->queue, cluster);
 
 	if (disk->drive == -1) {
 		for (disk->drive = 0; disk->drive <= 1; disk->drive++)
@@ -919,26 +945,18 @@ static int __init pd_init(void)
 	if (disable)
 		goto out1;
 
-	pd_queue = blk_init_queue(do_pd_request, &pd_lock);
-	if (!pd_queue)
-		goto out1;
-
-	blk_queue_max_hw_sectors(pd_queue, cluster);
-
 	if (register_blkdev(major, name))
-		goto out2;
+		goto out1;
 
 	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
 	       name, name, PD_VERSION, major, cluster, nice);
 	if (!pd_detect())
-		goto out3;
+		goto out2;
 
 	return 0;
 
-out3:
-	unregister_blkdev(major, name);
 out2:
-	blk_cleanup_queue(pd_queue);
+	unregister_blkdev(major, name);
 out1:
 	return -ENODEV;
 }
@@ -953,11 +971,11 @@ static void __exit pd_exit(void)
 		if (p) {
 			disk->gd = NULL;
 			del_gendisk(p);
+			blk_cleanup_queue(p->queue);
 			put_disk(p);
 			pi_release(disk->pi);
 		}
 	}
-	blk_cleanup_queue(pd_queue);
 }
 
 MODULE_LICENSE("GPL");
-- 
2.12.1
