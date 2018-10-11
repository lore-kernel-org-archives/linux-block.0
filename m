Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/17] paride: convert pcd to blk-mq
Date: Thu, 11 Oct 2018 10:58:56 -0600
Message-Id: <20181011165909.32615-5-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-1-axboe@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/paride/pcd.c | 98 +++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 32 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index a026211afb51..f2b82e3510d8 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -137,7 +137,7 @@ enum {D_PRT, D_PRO, D_UNI, D_MOD, D_SLV, D_DLY};
 #include <linux/delay.h>
 #include <linux/cdrom.h>
 #include <linux/spinlock.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/mutex.h>
 #include <linux/uaccess.h>
 
@@ -186,7 +186,8 @@ static int pcd_packet(struct cdrom_device_info *cdi,
 static int pcd_detect(void);
 static void pcd_probe_capabilities(void);
 static void do_pcd_read_drq(void);
-static void do_pcd_request(struct request_queue * q);
+static blk_status_t pcd_queue_rq(struct blk_mq_hw_ctx *hctx,
+				 const struct blk_mq_queue_data *bd);
 static void do_pcd_read(void);
 
 struct pcd_unit {
@@ -199,6 +200,8 @@ struct pcd_unit {
 	char *name;		/* pcd0, pcd1, etc */
 	struct cdrom_device_info info;	/* uniform cdrom interface */
 	struct gendisk *disk;
+	struct blk_mq_tag_set tag_set;
+	struct list_head rq_list;
 };
 
 static struct pcd_unit pcd[PCD_UNITS];
@@ -292,6 +295,10 @@ static const struct cdrom_device_ops pcd_dops = {
 			  CDC_CD_RW,
 };
 
+static const struct blk_mq_ops pcd_mq_ops = {
+	.queue_rq	= pcd_queue_rq,
+};
+
 static void pcd_init_units(void)
 {
 	struct pcd_unit *cd;
@@ -300,13 +307,29 @@ static void pcd_init_units(void)
 	pcd_drive_count = 0;
 	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
 		struct gendisk *disk = alloc_disk(1);
+		struct blk_mq_tag_set *set;
+
 		if (!disk)
 			continue;
-		disk->queue = blk_init_queue(do_pcd_request, &pcd_lock);
-		if (!disk->queue) {
-			put_disk(disk);
+
+		set = &cd->tag_set;
+		set->ops = &pcd_mq_ops;
+		set->nr_hw_queues = 1;
+		set->queue_depth = 1;
+		set->numa_node = NUMA_NO_NODE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		if (blk_mq_alloc_tag_set(set))
+			continue;
+
+		disk->queue = blk_mq_init_queue(set);
+		if (IS_ERR(disk->queue)) {
+			blk_mq_free_tag_set(set);
+			disk->queue = NULL;
 			continue;
 		}
+
+		INIT_LIST_HEAD(&cd->rq_list);
+		disk->queue->queuedata = cd;
 		blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
 		cd->disk = disk;
 		cd->pi = &cd->pia;
@@ -748,18 +771,18 @@ static int pcd_queue;
 static int set_next_request(void)
 {
 	struct pcd_unit *cd;
-	struct request_queue *q;
 	int old_pos = pcd_queue;
 
 	do {
 		cd = &pcd[pcd_queue];
-		q = cd->present ? cd->disk->queue : NULL;
 		if (++pcd_queue == PCD_UNITS)
 			pcd_queue = 0;
-		if (q) {
-			pcd_req = blk_fetch_request(q);
-			if (pcd_req)
-				break;
+		if (cd->present && !list_empty(&cd->rq_list)) {
+			pcd_req = list_first_entry(&cd->rq_list, struct request,
+							queuelist);
+			list_del_init(&pcd_req->queuelist);
+			blk_mq_start_request(pcd_req);
+			break;
 		}
 	} while (pcd_queue != old_pos);
 
@@ -768,33 +791,41 @@ static int set_next_request(void)
 
 static void pcd_request(void)
 {
+	struct pcd_unit *cd;
+
 	if (pcd_busy)
 		return;
-	while (1) {
-		if (!pcd_req && !set_next_request())
-			return;
 
-		if (rq_data_dir(pcd_req) == READ) {
-			struct pcd_unit *cd = pcd_req->rq_disk->private_data;
-			if (cd != pcd_current)
-				pcd_bufblk = -1;
-			pcd_current = cd;
-			pcd_sector = blk_rq_pos(pcd_req);
-			pcd_count = blk_rq_cur_sectors(pcd_req);
-			pcd_buf = bio_data(pcd_req->bio);
-			pcd_busy = 1;
-			ps_set_intr(do_pcd_read, NULL, 0, nice);
-			return;
-		} else {
-			__blk_end_request_all(pcd_req, BLK_STS_IOERR);
-			pcd_req = NULL;
-		}
-	}
+	if (!pcd_req && !set_next_request())
+		return;
+
+	cd = pcd_req->rq_disk->private_data;
+	if (cd != pcd_current)
+		pcd_bufblk = -1;
+	pcd_current = cd;
+	pcd_sector = blk_rq_pos(pcd_req);
+	pcd_count = blk_rq_cur_sectors(pcd_req);
+	pcd_buf = bio_data(pcd_req->bio);
+	pcd_busy = 1;
+	ps_set_intr(do_pcd_read, NULL, 0, nice);
 }
 
-static void do_pcd_request(struct request_queue *q)
+static blk_status_t pcd_queue_rq(struct blk_mq_hw_ctx *hctx,
+				 const struct blk_mq_queue_data *bd)
 {
+	struct pcd_unit *cd = hctx->queue->queuedata;
+
+	if (rq_data_dir(bd->rq) != READ) {
+		blk_mq_start_request(bd->rq);
+		return BLK_STS_IOERR;
+	}
+
+	spin_lock_irq(&pcd_lock);
+	list_add_tail(&bd->rq->queuelist, &cd->rq_list);
 	pcd_request();
+	spin_unlock_irq(&pcd_lock);
+
+	return BLK_STS_OK;
 }
 
 static inline void next_request(blk_status_t err)
@@ -802,8 +833,10 @@ static inline void next_request(blk_status_t err)
 	unsigned long saved_flags;
 
 	spin_lock_irqsave(&pcd_lock, saved_flags);
-	if (!__blk_end_request_cur(pcd_req, err))
+	if (!blk_update_request(pcd_req, err, blk_rq_cur_bytes(pcd_req))) {
+		__blk_mq_end_request(pcd_req, err);
 		pcd_req = NULL;
+	}
 	pcd_busy = 0;
 	pcd_request();
 	spin_unlock_irqrestore(&pcd_lock, saved_flags);
@@ -1010,6 +1043,7 @@ static void __exit pcd_exit(void)
 			pi_release(cd->pi);
 			unregister_cdrom(&cd->info);
 		}
+		blk_mq_free_tag_set(&cd->tag_set);
 		blk_cleanup_queue(cd->disk->queue);
 		put_disk(cd->disk);
 	}
-- 
2.17.1
