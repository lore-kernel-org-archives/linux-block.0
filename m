Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f179.google.com ([209.85.215.179]:43932 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbeJLB7L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Oct 2018 21:59:11 -0400
Received: by mail-pg1-f179.google.com with SMTP id 80-v6so4561915pgh.10
        for <linux-block@vger.kernel.org>; Thu, 11 Oct 2018 11:30:46 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 10/13] ataflop: fix error handling during setup
Date: Thu, 11 Oct 2018 11:30:20 -0700
Message-Id: <22892297ed4f1b951dfb06c0c20752cc6956cb1a.1539282366.git.osandov@fb.com>
In-Reply-To: <cover.1539282366.git.osandov@fb.com>
References: <cover.1539282366.git.osandov@fb.com>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Move queue allocation next to disk allocation to fix a couple of issues:

- If add_disk() hasn't been called, we should clear disk->queue before
  calling put_disk().
- If we fail to allocate a request queue, we still need to put all of
  the disks, not just the ones that we allocated queues for.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/ataflop.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 17df631c5d85..0144d598ac47 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2014,6 +2014,11 @@ static int __init atari_floppy_init (void)
 		unit[i].disk = alloc_disk(1);
 		if (!unit[i].disk)
 			goto Enomem;
+
+		unit[i].disk->queue = blk_init_queue(do_fd_request,
+						     &ataflop_lock);
+		if (!unit[i].disk->queue)
+			goto Enomem;
 	}
 
 	if (UseTrackbuffer < 0)
@@ -2045,10 +2050,6 @@ static int __init atari_floppy_init (void)
 		sprintf(unit[i].disk->disk_name, "fd%d", i);
 		unit[i].disk->fops = &floppy_fops;
 		unit[i].disk->private_data = &unit[i];
-		unit[i].disk->queue = blk_init_queue(do_fd_request,
-					&ataflop_lock);
-		if (!unit[i].disk->queue)
-			goto Enomem;
 		set_capacity(unit[i].disk, MAX_DISK_SIZE * 2);
 		add_disk(unit[i].disk);
 	}
@@ -2063,13 +2064,17 @@ static int __init atari_floppy_init (void)
 
 	return 0;
 Enomem:
-	while (i--) {
-		struct request_queue *q = unit[i].disk->queue;
+	do {
+		struct gendisk *disk = unit[i].disk;
 
-		put_disk(unit[i].disk);
-		if (q)
-			blk_cleanup_queue(q);
-	}
+		if (disk) {
+			if (disk->queue) {
+				blk_cleanup_queue(disk->queue);
+				disk->queue = NULL;
+			}
+			put_disk(unit[i].disk);
+		}
+	} while (i--);
 
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 	return -ENOMEM;
-- 
2.19.1
