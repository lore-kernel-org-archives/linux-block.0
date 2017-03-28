Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33367 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754306AbdC1G36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 02:29:58 -0400
Received: by mail-pg0-f53.google.com with SMTP id n5so55447567pgh.0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 23:29:52 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 5/6] swim: stop sharing request queue across multiple gendisks
Date: Mon, 27 Mar 2017 23:28:46 -0700
Message-Id: <6edfbcdd4cdc1e1225819b2412eff15c9074df45.1490681910.git.osandov@fb.com>
In-Reply-To: <cover.1490681910.git.osandov@fb.com>
References: <cover.1490681910.git.osandov@fb.com>
In-Reply-To: <cover.1490681910.git.osandov@fb.com>
References: <cover.1490681910.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Compile-tested only (by hacking it to compile on x86).

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/swim.c | 55 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index b5afd495d482..3064be6cf375 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -211,7 +211,7 @@ enum head {
 struct swim_priv {
 	struct swim __iomem *base;
 	spinlock_t lock;
-	struct request_queue *queue;
+	int fdc_queue;
 	int floppy_count;
 	struct floppy_state unit[FD_MAX_UNIT];
 };
@@ -525,12 +525,33 @@ static int floppy_read_sectors(struct floppy_state *fs,
 	return 0;
 }
 
-static void redo_fd_request(struct request_queue *q)
+static struct request *swim_next_request(struct swim_priv *swd)
 {
+	struct request_queue *q;
+	struct request *rq;
+	int old_pos = swd->fdc_queue;
+
+	do {
+		q = swd->unit[swd->fdc_queue].disk->queue;
+		if (++swd->fdc_queue == swd->floppy_count)
+			swd->fdc_queue = 0;
+		if (q) {
+			rq = blk_fetch_request(q);
+			if (rq)
+				return rq;
+		}
+	} while (swd->fdc_queue != old_pos);
+
+	return NULL;
+}
+
+static void do_fd_request(struct request_queue *q)
+{
+	struct swim_priv *swd = q->queuedata;
 	struct request *req;
 	struct floppy_state *fs;
 
-	req = blk_fetch_request(q);
+	req = swim_next_request(swd);
 	while (req) {
 		int err = -EIO;
 
@@ -554,15 +575,10 @@ static void redo_fd_request(struct request_queue *q)
 		}
 	done:
 		if (!__blk_end_request_cur(req, err))
-			req = blk_fetch_request(q);
+			req = swim_next_request(swd);
 	}
 }
 
-static void do_fd_request(struct request_queue *q)
-{
-	redo_fd_request(q);
-}
-
 static struct floppy_struct floppy_type[4] = {
 	{    0,  0, 0,  0, 0, 0x00, 0x00, 0x00, 0x00, NULL }, /* no testing   */
 	{  720,  9, 1, 80, 0, 0x2A, 0x02, 0xDF, 0x50, NULL }, /* 360KB SS 3.5"*/
@@ -833,22 +849,25 @@ static int swim_floppy_init(struct swim_priv *swd)
 		return -EBUSY;
 	}
 
+	spin_lock_init(&swd->lock);
+
 	for (drive = 0; drive < swd->floppy_count; drive++) {
 		swd->unit[drive].disk = alloc_disk(1);
 		if (swd->unit[drive].disk == NULL) {
 			err = -ENOMEM;
 			goto exit_put_disks;
 		}
+		swd->unit[drive].disk->queue = blk_init_queue(do_fd_request,
+							      &swd->lock);
+		if (!swd->unit[drive].disk->queue) {
+			err = -ENOMEM;
+			put_disk(swd->unit[drive].disk);
+			goto exit_put_disks;
+		}
+		swd->unit[drive].disk->queue->queuedata = swd;
 		swd->unit[drive].swd = swd;
 	}
 
-	spin_lock_init(&swd->lock);
-	swd->queue = blk_init_queue(do_fd_request, &swd->lock);
-	if (!swd->queue) {
-		err = -ENOMEM;
-		goto exit_put_disks;
-	}
-
 	for (drive = 0; drive < swd->floppy_count; drive++) {
 		swd->unit[drive].disk->flags = GENHD_FL_REMOVABLE;
 		swd->unit[drive].disk->major = FLOPPY_MAJOR;
@@ -856,7 +875,6 @@ static int swim_floppy_init(struct swim_priv *swd)
 		sprintf(swd->unit[drive].disk->disk_name, "fd%d", drive);
 		swd->unit[drive].disk->fops = &floppy_fops;
 		swd->unit[drive].disk->private_data = &swd->unit[drive];
-		swd->unit[drive].disk->queue = swd->queue;
 		set_capacity(swd->unit[drive].disk, 2880);
 		add_disk(swd->unit[drive].disk);
 	}
@@ -943,13 +961,12 @@ static int swim_remove(struct platform_device *dev)
 
 	for (drive = 0; drive < swd->floppy_count; drive++) {
 		del_gendisk(swd->unit[drive].disk);
+		blk_cleanup_queue(swd->unit[drive].disk->queue);
 		put_disk(swd->unit[drive].disk);
 	}
 
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 
-	blk_cleanup_queue(swd->queue);
-
 	/* eject floppies */
 
 	for (drive = 0; drive < swd->floppy_count; drive++)
-- 
2.12.1
