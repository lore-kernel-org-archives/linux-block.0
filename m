Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/17] paride: convert pf to blk-mq
Date: Thu, 11 Oct 2018 10:58:58 -0600
Message-Id: <20181011165909.32615-7-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-1-axboe@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/paride/pf.c | 68 +++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index eef7a91f667d..58866cf495f8 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -152,7 +152,7 @@ enum {D_PRT, D_PRO, D_UNI, D_MOD, D_SLV, D_LUN, D_DLY};
 #include <linux/hdreg.h>
 #include <linux/cdrom.h>
 #include <linux/spinlock.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/blkpg.h>
 #include <linux/mutex.h>
 #include <linux/uaccess.h>
@@ -206,7 +206,8 @@ module_param_array(drive3, int, NULL, 0);
 #define ATAPI_WRITE_10		0x2a
 
 static int pf_open(struct block_device *bdev, fmode_t mode);
-static void do_pf_request(struct request_queue * q);
+static blk_status_t pf_queue_rq(struct blk_mq_hw_ctx *hctx,
+				const struct blk_mq_queue_data *bd);
 static int pf_ioctl(struct block_device *bdev, fmode_t mode,
 		    unsigned int cmd, unsigned long arg);
 static int pf_getgeo(struct block_device *bdev, struct hd_geometry *geo);
@@ -238,6 +239,8 @@ struct pf_unit {
 	int present;		/* device present ? */
 	char name[PF_NAMELEN];	/* pf0, pf1, ... */
 	struct gendisk *disk;
+	struct blk_mq_tag_set tag_set;
+	struct list_head rq_list;
 };
 
 static struct pf_unit units[PF_UNITS];
@@ -277,6 +280,10 @@ static const struct block_device_operations pf_fops = {
 	.check_events	= pf_check_events,
 };
 
+static const struct blk_mq_ops pf_mq_ops = {
+	.queue_rq	= pf_queue_rq,
+};
+
 static void __init pf_init_units(void)
 {
 	struct pf_unit *pf;
@@ -284,14 +291,34 @@ static void __init pf_init_units(void)
 
 	pf_drive_count = 0;
 	for (unit = 0, pf = units; unit < PF_UNITS; unit++, pf++) {
-		struct gendisk *disk = alloc_disk(1);
+		struct blk_mq_tag_set *set;
+		struct gendisk *disk;
+
+		disk = alloc_disk(1);
 		if (!disk)
 			continue;
-		disk->queue = blk_init_queue(do_pf_request, &pf_spin_lock);
-		if (!disk->queue) {
+
+		set = &pf->tag_set;
+		set->ops = &pf_mq_ops;
+		set->nr_hw_queues = 1;
+		set->queue_depth = 1;
+		set->numa_node = NUMA_NO_NODE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		if (blk_mq_alloc_tag_set(set)) {
 			put_disk(disk);
-			return;
+			continue;
 		}
+
+		disk->queue = blk_mq_init_queue(set);
+		if (IS_ERR(disk->queue)) {
+			blk_mq_free_tag_set(set);
+			put_disk(disk);
+			disk->queue = NULL;
+			continue;
+		}
+
+		INIT_LIST_HEAD(&pf->rq_list);
+		disk->queue->queuedata = pf;
 		blk_queue_max_segments(disk->queue, cluster);
 		blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
 		pf->disk = disk;
@@ -784,18 +811,18 @@ static int pf_queue;
 static int set_next_request(void)
 {
 	struct pf_unit *pf;
-	struct request_queue *q;
 	int old_pos = pf_queue;
 
 	do {
 		pf = &units[pf_queue];
-		q = pf->present ? pf->disk->queue : NULL;
 		if (++pf_queue == PF_UNITS)
 			pf_queue = 0;
-		if (q) {
-			pf_req = blk_fetch_request(q);
-			if (pf_req)
-				break;
+		if (pf->present && !list_empty(&pf->rq_list)) {
+			pf_req = list_first_entry(&pf->rq_list, struct request,
+							queuelist);
+			list_del_init(&pf_req->queuelist);
+			blk_mq_start_request(pf_req);
+			break;
 		}
 	} while (pf_queue != old_pos);
 
@@ -804,8 +831,12 @@ static int set_next_request(void)
 
 static void pf_end_request(blk_status_t err)
 {
-	if (pf_req && !__blk_end_request_cur(pf_req, err))
+	if (!pf_req)
+		return;
+	if (!blk_update_request(pf_req, err, blk_rq_cur_bytes(pf_req))) {
+		__blk_mq_end_request(pf_req, err);
 		pf_req = NULL;
+	}
 }
 
 static void pf_request(void)
@@ -842,9 +873,17 @@ static void pf_request(void)
 	}
 }
 
-static void do_pf_request(struct request_queue *q)
+static blk_status_t pf_queue_rq(struct blk_mq_hw_ctx *hctx,
+				const struct blk_mq_queue_data *bd)
 {
+	struct pf_unit *pf = hctx->queue->queuedata;
+	
+	spin_lock_irq(&pf_spin_lock);
+	list_add_tail(&bd->rq->queuelist, &pf->rq_list);
 	pf_request();
+	spin_unlock_irq(&pf_spin_lock);
+
+	return BLK_STS_OK;
 }
 
 static int pf_next_buf(void)
@@ -1023,6 +1062,7 @@ static void __exit pf_exit(void)
 		if (!pf->present)
 			continue;
 		del_gendisk(pf->disk);
+		blk_mq_free_tag_set(&pf->tag_set);
 		blk_cleanup_queue(pf->disk->queue);
 		put_disk(pf->disk);
 		pi_release(pf->pi);
-- 
2.17.1
