Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34903 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753925AbdC1G3t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 02:29:49 -0400
Received: by mail-pg0-f54.google.com with SMTP id 81so48592565pgh.2
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 23:29:48 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 1/6] hd: stop sharing request queue across multiple gendisks
Date: Mon, 27 Mar 2017 23:28:42 -0700
Message-Id: <dc3e8fc2dd692fc27f43c51eaf607ea0c3ddda5f.1490681910.git.osandov@fb.com>
In-Reply-To: <cover.1490681910.git.osandov@fb.com>
References: <cover.1490681910.git.osandov@fb.com>
In-Reply-To: <cover.1490681910.git.osandov@fb.com>
References: <cover.1490681910.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Compile-tested only.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/hd.c | 62 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/block/hd.c b/drivers/block/hd.c
index 6043648da1e8..79d63b20a297 100644
--- a/drivers/block/hd.c
+++ b/drivers/block/hd.c
@@ -95,7 +95,7 @@
 #define ICRC_ERR		0x80	/* new meaning:  CRC error during transfer */
 
 static DEFINE_SPINLOCK(hd_lock);
-static struct request_queue *hd_queue;
+static unsigned int hd_queue;
 static struct request *hd_req;
 
 #define TIMEOUT_VALUE	(6*HZ)
@@ -537,7 +537,7 @@ static void hd_times_out(unsigned long dummy)
 	if (!hd_req)
 		return;
 
-	spin_lock_irq(hd_queue->queue_lock);
+	spin_lock_irq(&hd_lock);
 	reset = 1;
 	name = hd_req->rq_disk->disk_name;
 	printk("%s: timeout\n", name);
@@ -548,7 +548,7 @@ static void hd_times_out(unsigned long dummy)
 		hd_end_request_cur(-EIO);
 	}
 	hd_request();
-	spin_unlock_irq(hd_queue->queue_lock);
+	spin_unlock_irq(&hd_lock);
 }
 
 static int do_special_op(struct hd_i_struct *disk, struct request *req)
@@ -566,6 +566,25 @@ static int do_special_op(struct hd_i_struct *disk, struct request *req)
 	return 1;
 }
 
+static int set_next_request(void)
+{
+	struct request_queue *q;
+	int old_pos = hd_queue;
+
+	do {
+		q = hd_gendisk[hd_queue]->queue;
+		if (++hd_queue == NR_HD)
+			hd_queue = 0;
+		if (q) {
+			hd_req = blk_fetch_request(q);
+			if (hd_req)
+				break;
+		}
+	} while (hd_queue != old_pos);
+
+	return hd_req != NULL;
+}
+
 /*
  * The driver enables interrupts as much as possible.  In order to do this,
  * (a) the device-interrupt is disabled before entering hd_request(),
@@ -587,12 +606,9 @@ static void hd_request(void)
 repeat:
 	del_timer(&device_timer);
 
-	if (!hd_req) {
-		hd_req = blk_fetch_request(hd_queue);
-		if (!hd_req) {
-			do_hd = NULL;
-			return;
-		}
+	if (!hd_req && !set_next_request()) {
+		do_hd = NULL;
+		return;
 	}
 	req = hd_req;
 
@@ -676,7 +692,7 @@ static irqreturn_t hd_interrupt(int irq, void *dev_id)
 {
 	void (*handler)(void) = do_hd;
 
-	spin_lock(hd_queue->queue_lock);
+	spin_lock(&hd_lock);
 
 	do_hd = NULL;
 	del_timer(&device_timer);
@@ -684,7 +700,7 @@ static irqreturn_t hd_interrupt(int irq, void *dev_id)
 		handler = unexpected_hd_interrupt;
 	handler();
 
-	spin_unlock(hd_queue->queue_lock);
+	spin_unlock(&hd_lock);
 
 	return IRQ_HANDLED;
 }
@@ -700,16 +716,8 @@ static int __init hd_init(void)
 	if (register_blkdev(HD_MAJOR, "hd"))
 		return -1;
 
-	hd_queue = blk_init_queue(do_hd_request, &hd_lock);
-	if (!hd_queue) {
-		unregister_blkdev(HD_MAJOR, "hd");
-		return -ENOMEM;
-	}
-
-	blk_queue_max_hw_sectors(hd_queue, 255);
 	init_timer(&device_timer);
 	device_timer.function = hd_times_out;
-	blk_queue_logical_block_size(hd_queue, 512);
 
 	if (!NR_HD) {
 		/*
@@ -742,7 +750,11 @@ static int __init hd_init(void)
 		sprintf(disk->disk_name, "hd%c", 'a'+drive);
 		disk->private_data = p;
 		set_capacity(disk, p->head * p->sect * p->cyl);
-		disk->queue = hd_queue;
+		disk->queue = blk_init_queue(do_hd_request, &hd_lock);
+		if (!disk->queue)
+			goto Enomem;
+		blk_queue_max_hw_sectors(disk->queue, 255);
+		blk_queue_logical_block_size(disk->queue, 512);
 		p->unit = drive;
 		hd_gendisk[drive] = disk;
 		printk("%s: %luMB, CHS=%d/%d/%d\n",
@@ -781,11 +793,15 @@ static int __init hd_init(void)
 out:
 	del_timer(&device_timer);
 	unregister_blkdev(HD_MAJOR, "hd");
-	blk_cleanup_queue(hd_queue);
 	return -1;
 Enomem:
-	while (drive--)
-		put_disk(hd_gendisk[drive]);
+	for (drive = 0; drive < NR_HD; drive++) {
+		if (hd_gendisk[drive]) {
+			if (hd_gendisk[drive]->queue)
+				blk_cleanup_queue(hd_gendisk[drive]->queue);
+			put_disk(hd_gendisk[drive]);
+		}
+	}
 	goto out;
 }
 
-- 
2.12.1
