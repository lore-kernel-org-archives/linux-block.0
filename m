Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42852 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbeJLB7I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Oct 2018 21:59:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so4565640pgq.9
        for <linux-block@vger.kernel.org>; Thu, 11 Oct 2018 11:30:44 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 07/13] amiflop: clean up on errors during setup
Date: Thu, 11 Oct 2018 11:30:17 -0700
Message-Id: <92d692ff3dc902e4b1845fd784be750dda2cab0b.1539282366.git.osandov@fb.com>
In-Reply-To: <cover.1539282366.git.osandov@fb.com>
References: <cover.1539282366.git.osandov@fb.com>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The error handling in fd_probe_drives() doesn't clean up at all. Fix it
up in preparation for converting to blk-mq. While we're here, get rid of
the commented out amiga_floppy_remove().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/amiflop.c | 84 ++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index a7d6e6a9b12f..eef3b085e70a 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1818,11 +1818,41 @@ static const struct block_device_operations floppy_fops = {
 	.check_events	= amiga_check_events,
 };
 
+static struct gendisk *fd_alloc_disk(int drive)
+{
+	struct gendisk *disk;
+
+	disk = alloc_disk(1);
+	if (!disk)
+		goto out;
+
+	disk->queue = blk_init_queue(do_fd_request, &amiflop_lock);
+	if (IS_ERR(disk->queue)) {
+		disk->queue = NULL;
+		goto out_put_disk;
+	}
+
+	unit[drive].trackbuf = kmalloc(FLOPPY_MAX_SECTORS * 512, GFP_KERNEL);
+	if (!unit[drive].trackbuf)
+		goto out_cleanup_queue;
+
+	return disk;
+
+out_cleanup_queue:
+	blk_cleanup_queue(disk->queue);
+	disk->queue = NULL;
+out_put_disk:
+	put_disk(disk);
+out:
+	unit[drive].type->code = FD_NODRIVE;
+	return NULL;
+}
+
 static int __init fd_probe_drives(void)
 {
 	int drive,drives,nomem;
 
-	printk(KERN_INFO "FD: probing units\nfound ");
+	pr_info("FD: probing units\nfound");
 	drives=0;
 	nomem=0;
 	for(drive=0;drive<FD_MAX_UNITS;drive++) {
@@ -1830,27 +1860,17 @@ static int __init fd_probe_drives(void)
 		fd_probe(drive);
 		if (unit[drive].type->code == FD_NODRIVE)
 			continue;
-		disk = alloc_disk(1);
+
+		disk = fd_alloc_disk(drive);
 		if (!disk) {
-			unit[drive].type->code = FD_NODRIVE;
+			pr_cont(" no mem for fd%d", drive);
+			nomem = 1;
 			continue;
 		}
 		unit[drive].gendisk = disk;
-
-		disk->queue = blk_init_queue(do_fd_request, &amiflop_lock);
-		if (!disk->queue) {
-			unit[drive].type->code = FD_NODRIVE;
-			continue;
-		}
-
 		drives++;
-		if ((unit[drive].trackbuf = kmalloc(FLOPPY_MAX_SECTORS * 512, GFP_KERNEL)) == NULL) {
-			printk("no mem for ");
-			unit[drive].type = &drive_types[num_dr_types - 1]; /* FD_NODRIVE */
-			drives--;
-			nomem = 1;
-		}
-		printk("fd%d ",drive);
+
+		pr_cont(" fd%d",drive);
 		disk->major = FLOPPY_MAJOR;
 		disk->first_minor = drive;
 		disk->fops = &floppy_fops;
@@ -1861,11 +1881,11 @@ static int __init fd_probe_drives(void)
 	}
 	if ((drives > 0) || (nomem == 0)) {
 		if (drives == 0)
-			printk("no drives");
-		printk("\n");
+			pr_cont(" no drives");
+		pr_cont("\n");
 		return drives;
 	}
-	printk("\n");
+	pr_cont("\n");
 	return -ENOMEM;
 }
  
@@ -1948,30 +1968,6 @@ static int __init amiga_floppy_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#if 0 /* not safe to unload */
-static int __exit amiga_floppy_remove(struct platform_device *pdev)
-{
-	int i;
-
-	for( i = 0; i < FD_MAX_UNITS; i++) {
-		if (unit[i].type->code != FD_NODRIVE) {
-			struct request_queue *q = unit[i].gendisk->queue;
-			del_gendisk(unit[i].gendisk);
-			put_disk(unit[i].gendisk);
-			kfree(unit[i].trackbuf);
-			if (q)
-				blk_cleanup_queue(q);
-		}
-	}
-	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
-	free_irq(IRQ_AMIGA_CIAA_TB, NULL);
-	free_irq(IRQ_AMIGA_DSKBLK, NULL);
-	custom.dmacon = DMAF_DISK; /* disable DMA */
-	amiga_chip_free(raw_buf);
-	unregister_blkdev(FLOPPY_MAJOR, "fd");
-}
-#endif
-
 static struct platform_driver amiga_floppy_driver = {
 	.driver   = {
 		.name	= "amiga-floppy",
-- 
2.19.1
