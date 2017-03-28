Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34917 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754313AbdC1GaG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 02:30:06 -0400
Received: by mail-pg0-f46.google.com with SMTP id 81so48593237pgh.2
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 23:30:05 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Tim Waugh <tim@cyberelk.net>
Subject: [PATCH 3/6] parport/pcd: stop sharing request queue across multiple gendisks
Date: Mon, 27 Mar 2017 23:28:44 -0700
Message-Id: <eb020bd8bbba9fb1d913b4cd2cb3aee285bf5a5b.1490681910.git.osandov@fb.com>
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
 drivers/block/paride/pcd.c | 57 ++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 939641d6e262..b1267ef34d5a 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -300,6 +300,11 @@ static void pcd_init_units(void)
 		struct gendisk *disk = alloc_disk(1);
 		if (!disk)
 			continue;
+		disk->queue = blk_init_queue(do_pcd_request, &pcd_lock);
+		if (!disk->queue) {
+			put_disk(disk);
+			continue;
+		}
 		cd->disk = disk;
 		cd->pi = &cd->pia;
 		cd->present = 0;
@@ -735,18 +740,36 @@ static int pcd_detect(void)
 }
 
 /* I/O request processing */
-static struct request_queue *pcd_queue;
+static int pcd_queue;
+
+static int set_next_request(void)
+{
+	struct pcd_unit *cd;
+	struct request_queue *q;
+	int old_pos = pcd_queue;
+
+	do {
+		cd = &pcd[pcd_queue];
+		q = cd->present ? cd->disk->queue : NULL;
+		if (++pcd_queue == PCD_UNITS)
+			pcd_queue = 0;
+		if (q) {
+			pcd_req = blk_fetch_request(q);
+			if (pcd_req)
+				break;
+		}
+	} while (pcd_queue != old_pos);
+
+	return pcd_req != NULL;
+}
 
-static void do_pcd_request(struct request_queue * q)
+static void pcd_request(void)
 {
 	if (pcd_busy)
 		return;
 	while (1) {
-		if (!pcd_req) {
-			pcd_req = blk_fetch_request(q);
-			if (!pcd_req)
-				return;
-		}
+		if (!pcd_req && !set_next_request())
+			return;
 
 		if (rq_data_dir(pcd_req) == READ) {
 			struct pcd_unit *cd = pcd_req->rq_disk->private_data;
@@ -766,6 +789,11 @@ static void do_pcd_request(struct request_queue * q)
 	}
 }
 
+static void do_pcd_request(struct request_queue *q)
+{
+	pcd_request();
+}
+
 static inline void next_request(int err)
 {
 	unsigned long saved_flags;
@@ -774,7 +802,7 @@ static inline void next_request(int err)
 	if (!__blk_end_request_cur(pcd_req, err))
 		pcd_req = NULL;
 	pcd_busy = 0;
-	do_pcd_request(pcd_queue);
+	pcd_request();
 	spin_unlock_irqrestore(&pcd_lock, saved_flags);
 }
 
@@ -849,7 +877,7 @@ static void do_pcd_read_drq(void)
 
 	do_pcd_read();
 	spin_lock_irqsave(&pcd_lock, saved_flags);
-	do_pcd_request(pcd_queue);
+	pcd_request();
 	spin_unlock_irqrestore(&pcd_lock, saved_flags);
 }
 
@@ -957,19 +985,10 @@ static int __init pcd_init(void)
 		return -EBUSY;
 	}
 
-	pcd_queue = blk_init_queue(do_pcd_request, &pcd_lock);
-	if (!pcd_queue) {
-		unregister_blkdev(major, name);
-		for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++)
-			put_disk(cd->disk);
-		return -ENOMEM;
-	}
-
 	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
 		if (cd->present) {
 			register_cdrom(&cd->info);
 			cd->disk->private_data = cd;
-			cd->disk->queue = pcd_queue;
 			add_disk(cd->disk);
 		}
 	}
@@ -988,9 +1007,9 @@ static void __exit pcd_exit(void)
 			pi_release(cd->pi);
 			unregister_cdrom(&cd->info);
 		}
+		blk_cleanup_queue(cd->disk->queue);
 		put_disk(cd->disk);
 	}
-	blk_cleanup_queue(pcd_queue);
 	unregister_blkdev(major, name);
 	pi_unregister_driver(par_drv);
 }
-- 
2.12.1
