Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/17] paride: convert pd to blk-mq
Date: Thu, 11 Oct 2018 10:58:57 -0600
Message-Id: <20181011165909.32615-6-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-1-axboe@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/paride/pd.c | 109 ++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 47 deletions(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 7cf947586fe4..87636d6ce191 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -151,7 +151,7 @@ enum {D_PRT, D_PRO, D_UNI, D_MOD, D_GEO, D_SBY, D_DLY, D_SLV};
 #include <linux/delay.h>
 #include <linux/hdreg.h>
 #include <linux/cdrom.h>	/* for the eject ioctl */
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/blkpg.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
@@ -236,6 +236,7 @@ struct pd_unit {
 	int alt_geom;
 	char name[PD_NAMELEN];	/* pda, pdb, etc ... */
 	struct gendisk *gd;
+	struct blk_mq_tag_set tag_set;
 };
 
 static struct pd_unit pd[PD_UNITS];
@@ -355,25 +356,6 @@ enum action {Fail = 0, Ok = 1, Hold, Wait};
 static struct request *pd_req;	/* current request */
 static enum action (*phase)(void);
 
-static void run_fsm(void);
-
-static void ps_tq_int(struct work_struct *work);
-
-static DECLARE_DELAYED_WORK(fsm_tq, ps_tq_int);
-
-static void schedule_fsm(void)
-{
-	if (!nice)
-		schedule_delayed_work(&fsm_tq, 0);
-	else
-		schedule_delayed_work(&fsm_tq, nice-1);
-}
-
-static void ps_tq_int(struct work_struct *work)
-{
-	run_fsm();
-}
-
 static enum action do_pd_io_start(void);
 static enum action pd_special(void);
 static enum action do_pd_read_start(void);
@@ -387,7 +369,7 @@ static int pd_claimed;
 static struct pd_unit *pd_current; /* current request's drive */
 static PIA *pi_current; /* current request's PIA */
 
-static int set_next_request(void)
+static int run_next_queue(void)
 {
 	struct gendisk *disk;
 	struct request_queue *q;
@@ -398,11 +380,8 @@ static int set_next_request(void)
 		q = disk ? disk->queue : NULL;
 		if (++pd_queue == PD_UNITS)
 			pd_queue = 0;
-		if (q) {
-			pd_req = blk_fetch_request(q);
-			if (pd_req)
-				break;
-		}
+		if (q)
+			blk_mq_run_hw_queues(q, true);
 	} while (pd_queue != old_pos);
 
 	return pd_req != NULL;
@@ -438,17 +417,20 @@ static void run_fsm(void)
 				pd_claimed = 0;
 				phase = NULL;
 				spin_lock_irqsave(&pd_lock, saved_flags);
-				if (!__blk_end_request_cur(pd_req,
-						res == Ok ? 0 : BLK_STS_IOERR)) {
-					if (!set_next_request())
-						stop = 1;
+				if (!blk_update_request(pd_req,
+						res == Ok ? 0 : BLK_STS_IOERR,
+						blk_rq_cur_bytes(pd_req))) {
+					__blk_mq_end_request(pd_req,
+						res == Ok ? 0 : BLK_STS_IOERR);
+					run_next_queue();
+					stop = 1;
 				}
 				spin_unlock_irqrestore(&pd_lock, saved_flags);
 				if (stop)
 					return;
 				/* fall through */
 			case Hold:
-				schedule_fsm();
+				blk_mq_run_hw_queues(pd_req->q, true);
 				return;
 			case Wait:
 				pi_disconnect(pi_current);
@@ -505,11 +487,17 @@ static int pd_next_buf(void)
 	if (pd_count)
 		return 0;
 	spin_lock_irqsave(&pd_lock, saved_flags);
-	__blk_end_request_cur(pd_req, 0);
-	pd_count = blk_rq_cur_sectors(pd_req);
-	pd_buf = bio_data(pd_req->bio);
+	if (!blk_update_request(pd_req, 0, blk_rq_cur_bytes(pd_req))) {
+		__blk_mq_end_request(pd_req, 0);
+		pd_req = NULL;
+		pd_count = 0;
+		pd_buf = NULL;
+	} else {
+		pd_count = blk_rq_cur_sectors(pd_req);
+		pd_buf = bio_data(pd_req->bio);
+	}
 	spin_unlock_irqrestore(&pd_lock, saved_flags);
-	return 0;
+	return !pd_count;
 }
 
 static unsigned long pd_timeout;
@@ -726,15 +714,22 @@ static enum action pd_identify(struct pd_unit *disk)
 
 /* end of io request engine */
 
-static void do_pd_request(struct request_queue * q)
+static blk_status_t pd_queue_rq(struct blk_mq_hw_ctx *hctx,
+				const struct blk_mq_queue_data *bd)
 {
-	if (pd_req)
-		return;
-	pd_req = blk_fetch_request(q);
-	if (!pd_req)
-		return;
+	spin_lock_irq(&pd_lock);
 
-	schedule_fsm();
+	/* this should not be possible */
+	if (pd_req) {
+		spin_unlock_irq(&pd_lock);
+		return BLK_STS_DEV_RESOURCE;
+	}
+
+	pd_req = bd->rq;
+	spin_unlock_irq(&pd_lock);
+	blk_mq_start_request(bd->rq);
+	run_fsm();
+	return BLK_STS_OK;
 }
 
 static int pd_special_command(struct pd_unit *disk,
@@ -847,23 +842,42 @@ static const struct block_device_operations pd_fops = {
 
 /* probing */
 
+static const struct blk_mq_ops pd_mq_ops = {
+	.queue_rq	= pd_queue_rq,
+};
+
 static void pd_probe_drive(struct pd_unit *disk)
 {
-	struct gendisk *p = alloc_disk(1 << PD_BITS);
+	struct blk_mq_tag_set *set;
+	struct gendisk *p;
+
+	p = alloc_disk(1 << PD_BITS);
 	if (!p)
 		return;
+
 	strcpy(p->disk_name, disk->name);
 	p->fops = &pd_fops;
 	p->major = major;
 	p->first_minor = (disk - pd) << PD_BITS;
 	disk->gd = p;
 	p->private_data = disk;
-	p->queue = blk_init_queue(do_pd_request, &pd_lock);
-	if (!p->queue) {
-		disk->gd = NULL;
-		put_disk(p);
+
+	set = &disk->tag_set;
+	set->ops = &pd_mq_ops;
+	set->nr_hw_queues = 1;
+	set->queue_depth = 1;
+	set->numa_node = NUMA_NO_NODE;
+	set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+	if (blk_mq_alloc_tag_set(set))
+		return;
+
+	p->queue = blk_mq_init_queue(set);
+	if (IS_ERR(p->queue)) {
+		blk_mq_free_tag_set(set);
+		p->queue = NULL;
 		return;
 	}
+
 	blk_queue_max_hw_sectors(p->queue, cluster);
 	blk_queue_bounce_limit(p->queue, BLK_BOUNCE_HIGH);
 
@@ -971,6 +985,7 @@ static void __exit pd_exit(void)
 		if (p) {
 			disk->gd = NULL;
 			del_gendisk(p);
+			blk_mq_free_tag_set(&disk->tag_set);
 			blk_cleanup_queue(p->queue);
 			put_disk(p);
 			pi_release(disk->pi);
-- 
2.17.1
