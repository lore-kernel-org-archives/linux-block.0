Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35956 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753925AbdC1G3w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 02:29:52 -0400
Received: by mail-pg0-f45.google.com with SMTP id g2so62646692pge.3
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 23:29:51 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Tim Waugh <tim@cyberelk.net>
Subject: [PATCH 4/6] parport/pf: stop sharing request queue across multiple gendisks
Date: Mon, 27 Mar 2017 23:28:45 -0700
Message-Id: <627567bd2a1a08ca9f8e625c8ac451e023dc2d7f.1490681910.git.osandov@fb.com>
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
 drivers/block/paride/pf.c | 57 +++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index 14c5d32f5d8b..f24ca7315ddc 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -287,6 +287,12 @@ static void __init pf_init_units(void)
 		struct gendisk *disk = alloc_disk(1);
 		if (!disk)
 			continue;
+		disk->queue = blk_init_queue(do_pf_request, &pf_spin_lock);
+		if (!disk->queue) {
+			put_disk(disk);
+			return;
+		}
+		blk_queue_max_segments(disk->queue, cluster);
 		pf->disk = disk;
 		pf->pi = &pf->pia;
 		pf->media_status = PF_NM;
@@ -772,7 +778,28 @@ static int pf_ready(void)
 	return (((status_reg(pf_current) & (STAT_BUSY | pf_mask)) == pf_mask));
 }
 
-static struct request_queue *pf_queue;
+static int pf_queue;
+
+static int set_next_request(void)
+{
+	struct pf_unit *pf;
+	struct request_queue *q;
+	int old_pos = pf_queue;
+
+	do {
+		pf = &units[pf_queue];
+		q = pf->present ? pf->disk->queue : NULL;
+		if (++pf_queue == PF_UNITS)
+			pf_queue = 0;
+		if (q) {
+			pf_req = blk_fetch_request(q);
+			if (pf_req)
+				break;
+		}
+	} while (pf_queue != old_pos);
+
+	return pf_req != NULL;
+}
 
 static void pf_end_request(int err)
 {
@@ -780,16 +807,13 @@ static void pf_end_request(int err)
 		pf_req = NULL;
 }
 
-static void do_pf_request(struct request_queue * q)
+static void pf_request(void)
 {
 	if (pf_busy)
 		return;
 repeat:
-	if (!pf_req) {
-		pf_req = blk_fetch_request(q);
-		if (!pf_req)
-			return;
-	}
+	if (!pf_req && !set_next_request())
+		return;
 
 	pf_current = pf_req->rq_disk->private_data;
 	pf_block = blk_rq_pos(pf_req);
@@ -817,6 +841,11 @@ static void do_pf_request(struct request_queue * q)
 	}
 }
 
+static void do_pf_request(struct request_queue *q)
+{
+	pf_request();
+}
+
 static int pf_next_buf(void)
 {
 	unsigned long saved_flags;
@@ -846,7 +875,7 @@ static inline void next_request(int err)
 	spin_lock_irqsave(&pf_spin_lock, saved_flags);
 	pf_end_request(err);
 	pf_busy = 0;
-	do_pf_request(pf_queue);
+	pf_request();
 	spin_unlock_irqrestore(&pf_spin_lock, saved_flags);
 }
 
@@ -972,15 +1001,6 @@ static int __init pf_init(void)
 			put_disk(pf->disk);
 		return -EBUSY;
 	}
-	pf_queue = blk_init_queue(do_pf_request, &pf_spin_lock);
-	if (!pf_queue) {
-		unregister_blkdev(major, name);
-		for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++)
-			put_disk(pf->disk);
-		return -ENOMEM;
-	}
-
-	blk_queue_max_segments(pf_queue, cluster);
 
 	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
 		struct gendisk *disk = pf->disk;
@@ -988,7 +1008,6 @@ static int __init pf_init(void)
 		if (!pf->present)
 			continue;
 		disk->private_data = pf;
-		disk->queue = pf_queue;
 		add_disk(disk);
 	}
 	return 0;
@@ -1003,10 +1022,10 @@ static void __exit pf_exit(void)
 		if (!pf->present)
 			continue;
 		del_gendisk(pf->disk);
+		blk_cleanup_queue(pf->disk->queue);
 		put_disk(pf->disk);
 		pi_release(pf->pi);
 	}
-	blk_cleanup_queue(pf_queue);
 }
 
 MODULE_LICENSE("GPL");
-- 
2.12.1
