Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/28] dm: remove legacy IO path
Date: Thu, 25 Oct 2018 15:10:20 -0600
Message-Id: <20181025211039.11559-10-axboe@kernel.dk>
In-Reply-To: <20181025211039.11559-1-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

dm supports both, and since we're killing off the legacy path
in general, get rid of it in dm as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/md/Kconfig    |  11 --
 drivers/md/dm-core.h  |  10 --
 drivers/md/dm-mpath.c |  14 +-
 drivers/md/dm-rq.c    | 293 ++++--------------------------------------
 drivers/md/dm-rq.h    |   4 -
 drivers/md/dm-sysfs.c |   3 +-
 drivers/md/dm-table.c |  36 +-----
 drivers/md/dm.c       |  21 +--
 drivers/md/dm.h       |   1 -
 9 files changed, 35 insertions(+), 358 deletions(-)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 8b8c123cae66..3db222509e44 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -215,17 +215,6 @@ config BLK_DEV_DM
 
 	  If unsure, say N.
 
-config DM_MQ_DEFAULT
-	bool "request-based DM: use blk-mq I/O path by default"
-	depends on BLK_DEV_DM
-	---help---
-	  This option enables the blk-mq based I/O path for request-based
-	  DM devices by default.  With the option the dm_mod.use_blk_mq
-	  module/boot option defaults to Y, without it to N, but it can
-	  still be overriden either way.
-
-	  If unsure say N.
-
 config DM_DEBUG
 	bool "Device mapper debugging support"
 	depends on BLK_DEV_DM
diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 7d480c930eaf..224d44503a06 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -112,18 +112,8 @@ struct mapped_device {
 
 	struct dm_stats stats;
 
-	struct kthread_worker kworker;
-	struct task_struct *kworker_task;
-
-	/* for request-based merge heuristic in dm_request_fn() */
-	unsigned seq_rq_merge_deadline_usecs;
-	int last_rq_rw;
-	sector_t last_rq_pos;
-	ktime_t last_rq_start_time;
-
 	/* for blk-mq request-based DM support */
 	struct blk_mq_tag_set *tag_set;
-	bool use_blk_mq:1;
 	bool init_tio_pdu:1;
 
 	struct srcu_struct io_barrier;
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 419362c2d8ac..a24ed3973e7c 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -203,14 +203,7 @@ static struct multipath *alloc_multipath(struct dm_target *ti)
 static int alloc_multipath_stage2(struct dm_target *ti, struct multipath *m)
 {
 	if (m->queue_mode == DM_TYPE_NONE) {
-		/*
-		 * Default to request-based.
-		 */
-		if (dm_use_blk_mq(dm_table_get_md(ti->table)))
-			m->queue_mode = DM_TYPE_MQ_REQUEST_BASED;
-		else
-			m->queue_mode = DM_TYPE_REQUEST_BASED;
-
+		m->queue_mode = DM_TYPE_MQ_REQUEST_BASED;
 	} else if (m->queue_mode == DM_TYPE_BIO_BASED) {
 		INIT_WORK(&m->process_queued_bios, process_queued_bios);
 		/*
@@ -537,10 +530,7 @@ static int multipath_clone_and_map(struct dm_target *ti, struct request *rq,
 		 * get the queue busy feedback (via BLK_STS_RESOURCE),
 		 * otherwise I/O merging can suffer.
 		 */
-		if (q->mq_ops)
-			return DM_MAPIO_REQUEUE;
-		else
-			return DM_MAPIO_DELAY_REQUEUE;
+		return DM_MAPIO_REQUEUE;
 	}
 	clone->bio = clone->biotail = NULL;
 	clone->rq_disk = bdev->bd_disk;
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 6e547b8dd298..37192b396473 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -23,19 +23,6 @@ static unsigned dm_mq_queue_depth = DM_MQ_QUEUE_DEPTH;
 #define RESERVED_REQUEST_BASED_IOS	256
 static unsigned reserved_rq_based_ios = RESERVED_REQUEST_BASED_IOS;
 
-static bool use_blk_mq = IS_ENABLED(CONFIG_DM_MQ_DEFAULT);
-
-bool dm_use_blk_mq_default(void)
-{
-	return use_blk_mq;
-}
-
-bool dm_use_blk_mq(struct mapped_device *md)
-{
-	return md->use_blk_mq;
-}
-EXPORT_SYMBOL_GPL(dm_use_blk_mq);
-
 unsigned dm_get_reserved_rq_based_ios(void)
 {
 	return __dm_get_module_param(&reserved_rq_based_ios,
@@ -59,16 +46,6 @@ int dm_request_based(struct mapped_device *md)
 	return queue_is_rq_based(md->queue);
 }
 
-static void dm_old_start_queue(struct request_queue *q)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	if (blk_queue_stopped(q))
-		blk_start_queue(q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-}
-
 static void dm_mq_start_queue(struct request_queue *q)
 {
 	blk_mq_unquiesce_queue(q);
@@ -77,20 +54,7 @@ static void dm_mq_start_queue(struct request_queue *q)
 
 void dm_start_queue(struct request_queue *q)
 {
-	if (!q->mq_ops)
-		dm_old_start_queue(q);
-	else
-		dm_mq_start_queue(q);
-}
-
-static void dm_old_stop_queue(struct request_queue *q)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	if (!blk_queue_stopped(q))
-		blk_stop_queue(q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	dm_mq_start_queue(q);
 }
 
 static void dm_mq_stop_queue(struct request_queue *q)
@@ -103,10 +67,7 @@ static void dm_mq_stop_queue(struct request_queue *q)
 
 void dm_stop_queue(struct request_queue *q)
 {
-	if (!q->mq_ops)
-		dm_old_stop_queue(q);
-	else
-		dm_mq_stop_queue(q);
+	dm_mq_stop_queue(q);
 }
 
 /*
@@ -179,27 +140,12 @@ static void rq_end_stats(struct mapped_device *md, struct request *orig)
  */
 static void rq_completed(struct mapped_device *md, int rw, bool run_queue)
 {
-	struct request_queue *q = md->queue;
-	unsigned long flags;
-
 	atomic_dec(&md->pending[rw]);
 
 	/* nudge anyone waiting on suspend queue */
 	if (!md_in_flight(md))
 		wake_up(&md->wait);
 
-	/*
-	 * Run this off this callpath, as drivers could invoke end_io while
-	 * inside their request_fn (and holding the queue lock). Calling
-	 * back into ->request_fn() could deadlock attempting to grab the
-	 * queue lock again.
-	 */
-	if (!q->mq_ops && run_queue) {
-		spin_lock_irqsave(q->queue_lock, flags);
-		blk_run_queue_async(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-	}
-
 	/*
 	 * dm_put() must be at the end of this function. See the comment above
 	 */
@@ -222,27 +168,10 @@ static void dm_end_request(struct request *clone, blk_status_t error)
 	tio->ti->type->release_clone_rq(clone);
 
 	rq_end_stats(md, rq);
-	if (!rq->q->mq_ops)
-		blk_end_request_all(rq, error);
-	else
-		blk_mq_end_request(rq, error);
+	blk_mq_end_request(rq, error);
 	rq_completed(md, rw, true);
 }
 
-/*
- * Requeue the original request of a clone.
- */
-static void dm_old_requeue_request(struct request *rq, unsigned long delay_ms)
-{
-	struct request_queue *q = rq->q;
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	blk_requeue_request(q, rq);
-	blk_delay_queue(q, delay_ms);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-}
-
 static void __dm_mq_kick_requeue_list(struct request_queue *q, unsigned long msecs)
 {
 	blk_mq_delay_kick_requeue_list(q, msecs);
@@ -273,11 +202,7 @@ static void dm_requeue_original_request(struct dm_rq_target_io *tio, bool delay_
 		tio->ti->type->release_clone_rq(tio->clone);
 	}
 
-	if (!rq->q->mq_ops)
-		dm_old_requeue_request(rq, delay_ms);
-	else
-		dm_mq_delay_requeue_request(rq, delay_ms);
-
+	dm_mq_delay_requeue_request(rq, delay_ms);
 	rq_completed(md, rw, false);
 }
 
@@ -340,10 +265,7 @@ static void dm_softirq_done(struct request *rq)
 
 		rq_end_stats(md, rq);
 		rw = rq_data_dir(rq);
-		if (!rq->q->mq_ops)
-			blk_end_request_all(rq, tio->error);
-		else
-			blk_mq_end_request(rq, tio->error);
+		blk_mq_end_request(rq, tio->error);
 		rq_completed(md, rw, false);
 		return;
 	}
@@ -363,10 +285,7 @@ static void dm_complete_request(struct request *rq, blk_status_t error)
 	struct dm_rq_target_io *tio = tio_from_request(rq);
 
 	tio->error = error;
-	if (!rq->q->mq_ops)
-		blk_complete_request(rq);
-	else
-		blk_mq_complete_request(rq);
+	blk_mq_complete_request(rq);
 }
 
 /*
@@ -446,8 +365,6 @@ static int setup_clone(struct request *clone, struct request *rq,
 	return 0;
 }
 
-static void map_tio_request(struct kthread_work *work);
-
 static void init_tio(struct dm_rq_target_io *tio, struct request *rq,
 		     struct mapped_device *md)
 {
@@ -464,8 +381,6 @@ static void init_tio(struct dm_rq_target_io *tio, struct request *rq,
 	 */
 	if (!md->init_tio_pdu)
 		memset(&tio->info, 0, sizeof(tio->info));
-	if (md->kworker_task)
-		kthread_init_work(&tio->work, map_tio_request);
 }
 
 /*
@@ -504,10 +419,7 @@ static int map_request(struct dm_rq_target_io *tio)
 			blk_rq_unprep_clone(clone);
 			tio->ti->type->release_clone_rq(clone);
 			tio->clone = NULL;
-			if (!rq->q->mq_ops)
-				r = DM_MAPIO_DELAY_REQUEUE;
-			else
-				r = DM_MAPIO_REQUEUE;
+			r = DM_MAPIO_REQUEUE;
 			goto check_again;
 		}
 		break;
@@ -530,20 +442,23 @@ static int map_request(struct dm_rq_target_io *tio)
 	return r;
 }
 
+/* DEPRECATED: previously used for request-based merge heuristic in dm_request_fn() */
+ssize_t dm_attr_rq_based_seq_io_merge_deadline_show(struct mapped_device *md, char *buf)
+{
+	return sprintf(buf, "%u\n", 0);
+}
+
+ssize_t dm_attr_rq_based_seq_io_merge_deadline_store(struct mapped_device *md,
+						     const char *buf, size_t count)
+{
+	return count;
+}
+
 static void dm_start_request(struct mapped_device *md, struct request *orig)
 {
-	if (!orig->q->mq_ops)
-		blk_start_request(orig);
-	else
-		blk_mq_start_request(orig);
+	blk_mq_start_request(orig);
 	atomic_inc(&md->pending[rq_data_dir(orig)]);
 
-	if (md->seq_rq_merge_deadline_usecs) {
-		md->last_rq_pos = rq_end_sector(orig);
-		md->last_rq_rw = rq_data_dir(orig);
-		md->last_rq_start_time = ktime_get();
-	}
-
 	if (unlikely(dm_stats_used(&md->stats))) {
 		struct dm_rq_target_io *tio = tio_from_request(orig);
 		tio->duration_jiffies = jiffies;
@@ -563,8 +478,10 @@ static void dm_start_request(struct mapped_device *md, struct request *orig)
 	dm_get(md);
 }
 
-static int __dm_rq_init_rq(struct mapped_device *md, struct request *rq)
+static int dm_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
+			      unsigned int hctx_idx, unsigned int numa_node)
 {
+	struct mapped_device *md = set->driver_data;
 	struct dm_rq_target_io *tio = blk_mq_rq_to_pdu(rq);
 
 	/*
@@ -581,163 +498,6 @@ static int __dm_rq_init_rq(struct mapped_device *md, struct request *rq)
 	return 0;
 }
 
-static int dm_rq_init_rq(struct request_queue *q, struct request *rq, gfp_t gfp)
-{
-	return __dm_rq_init_rq(q->rq_alloc_data, rq);
-}
-
-static void map_tio_request(struct kthread_work *work)
-{
-	struct dm_rq_target_io *tio = container_of(work, struct dm_rq_target_io, work);
-
-	if (map_request(tio) == DM_MAPIO_REQUEUE)
-		dm_requeue_original_request(tio, false);
-}
-
-ssize_t dm_attr_rq_based_seq_io_merge_deadline_show(struct mapped_device *md, char *buf)
-{
-	return sprintf(buf, "%u\n", md->seq_rq_merge_deadline_usecs);
-}
-
-#define MAX_SEQ_RQ_MERGE_DEADLINE_USECS 100000
-
-ssize_t dm_attr_rq_based_seq_io_merge_deadline_store(struct mapped_device *md,
-						     const char *buf, size_t count)
-{
-	unsigned deadline;
-
-	if (dm_get_md_type(md) != DM_TYPE_REQUEST_BASED)
-		return count;
-
-	if (kstrtouint(buf, 10, &deadline))
-		return -EINVAL;
-
-	if (deadline > MAX_SEQ_RQ_MERGE_DEADLINE_USECS)
-		deadline = MAX_SEQ_RQ_MERGE_DEADLINE_USECS;
-
-	md->seq_rq_merge_deadline_usecs = deadline;
-
-	return count;
-}
-
-static bool dm_old_request_peeked_before_merge_deadline(struct mapped_device *md)
-{
-	ktime_t kt_deadline;
-
-	if (!md->seq_rq_merge_deadline_usecs)
-		return false;
-
-	kt_deadline = ns_to_ktime((u64)md->seq_rq_merge_deadline_usecs * NSEC_PER_USEC);
-	kt_deadline = ktime_add_safe(md->last_rq_start_time, kt_deadline);
-
-	return !ktime_after(ktime_get(), kt_deadline);
-}
-
-/*
- * q->request_fn for old request-based dm.
- * Called with the queue lock held.
- */
-static void dm_old_request_fn(struct request_queue *q)
-{
-	struct mapped_device *md = q->queuedata;
-	struct dm_target *ti = md->immutable_target;
-	struct request *rq;
-	struct dm_rq_target_io *tio;
-	sector_t pos = 0;
-
-	if (unlikely(!ti)) {
-		int srcu_idx;
-		struct dm_table *map = dm_get_live_table(md, &srcu_idx);
-
-		if (unlikely(!map)) {
-			dm_put_live_table(md, srcu_idx);
-			return;
-		}
-		ti = dm_table_find_target(map, pos);
-		dm_put_live_table(md, srcu_idx);
-	}
-
-	/*
-	 * For suspend, check blk_queue_stopped() and increment
-	 * ->pending within a single queue_lock not to increment the
-	 * number of in-flight I/Os after the queue is stopped in
-	 * dm_suspend().
-	 */
-	while (!blk_queue_stopped(q)) {
-		rq = blk_peek_request(q);
-		if (!rq)
-			return;
-
-		/* always use block 0 to find the target for flushes for now */
-		pos = 0;
-		if (req_op(rq) != REQ_OP_FLUSH)
-			pos = blk_rq_pos(rq);
-
-		if ((dm_old_request_peeked_before_merge_deadline(md) &&
-		     md_in_flight(md) && rq->bio && !bio_multiple_segments(rq->bio) &&
-		     md->last_rq_pos == pos && md->last_rq_rw == rq_data_dir(rq)) ||
-		    (ti->type->busy && ti->type->busy(ti))) {
-			blk_delay_queue(q, 10);
-			return;
-		}
-
-		dm_start_request(md, rq);
-
-		tio = tio_from_request(rq);
-		init_tio(tio, rq, md);
-		/* Establish tio->ti before queuing work (map_tio_request) */
-		tio->ti = ti;
-		kthread_queue_work(&md->kworker, &tio->work);
-		BUG_ON(!irqs_disabled());
-	}
-}
-
-/*
- * Fully initialize a .request_fn request-based queue.
- */
-int dm_old_init_request_queue(struct mapped_device *md, struct dm_table *t)
-{
-	struct dm_target *immutable_tgt;
-
-	/* Fully initialize the queue */
-	md->queue->cmd_size = sizeof(struct dm_rq_target_io);
-	md->queue->rq_alloc_data = md;
-	md->queue->request_fn = dm_old_request_fn;
-	md->queue->init_rq_fn = dm_rq_init_rq;
-
-	immutable_tgt = dm_table_get_immutable_target(t);
-	if (immutable_tgt && immutable_tgt->per_io_data_size) {
-		/* any target-specific per-io data is immediately after the tio */
-		md->queue->cmd_size += immutable_tgt->per_io_data_size;
-		md->init_tio_pdu = true;
-	}
-	if (blk_init_allocated_queue(md->queue) < 0)
-		return -EINVAL;
-
-	/* disable dm_old_request_fn's merge heuristic by default */
-	md->seq_rq_merge_deadline_usecs = 0;
-
-	blk_queue_softirq_done(md->queue, dm_softirq_done);
-
-	/* Initialize the request-based DM worker thread */
-	kthread_init_worker(&md->kworker);
-	md->kworker_task = kthread_run(kthread_worker_fn, &md->kworker,
-				       "kdmwork-%s", dm_device_name(md));
-	if (IS_ERR(md->kworker_task)) {
-		int error = PTR_ERR(md->kworker_task);
-		md->kworker_task = NULL;
-		return error;
-	}
-
-	return 0;
-}
-
-static int dm_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
-		unsigned int hctx_idx, unsigned int numa_node)
-{
-	return __dm_rq_init_rq(set->driver_data, rq);
-}
-
 static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 			  const struct blk_mq_queue_data *bd)
 {
@@ -790,11 +550,6 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
 	struct dm_target *immutable_tgt;
 	int err;
 
-	if (!dm_table_all_blk_mq_devices(t)) {
-		DMERR("request-based dm-mq may only be stacked on blk-mq device(s)");
-		return -EINVAL;
-	}
-
 	md->tag_set = kzalloc_node(sizeof(struct blk_mq_tag_set), GFP_KERNEL, md->numa_node_id);
 	if (!md->tag_set)
 		return -ENOMEM;
@@ -845,6 +600,8 @@ void dm_mq_cleanup_mapped_device(struct mapped_device *md)
 module_param(reserved_rq_based_ios, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(reserved_rq_based_ios, "Reserved IOs in request-based mempools");
 
+/* Unused, but preserved for userspace compatibility */
+static bool use_blk_mq = true;
 module_param(use_blk_mq, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(use_blk_mq, "Use block multiqueue for request-based DM devices");
 
diff --git a/drivers/md/dm-rq.h b/drivers/md/dm-rq.h
index f43c45460aac..b39245545229 100644
--- a/drivers/md/dm-rq.h
+++ b/drivers/md/dm-rq.h
@@ -46,10 +46,6 @@ struct dm_rq_clone_bio_info {
 	struct bio clone;
 };
 
-bool dm_use_blk_mq_default(void);
-bool dm_use_blk_mq(struct mapped_device *md);
-
-int dm_old_init_request_queue(struct mapped_device *md, struct dm_table *t);
 int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t);
 void dm_mq_cleanup_mapped_device(struct mapped_device *md);
 
diff --git a/drivers/md/dm-sysfs.c b/drivers/md/dm-sysfs.c
index c209b8a19b84..a05fcd50e1b9 100644
--- a/drivers/md/dm-sysfs.c
+++ b/drivers/md/dm-sysfs.c
@@ -92,7 +92,8 @@ static ssize_t dm_attr_suspended_show(struct mapped_device *md, char *buf)
 
 static ssize_t dm_attr_use_blk_mq_show(struct mapped_device *md, char *buf)
 {
-	sprintf(buf, "%d\n", dm_use_blk_mq(md));
+	/* Purely for userspace compatibility */
+	sprintf(buf, "%d\n", true);
 
 	return strlen(buf);
 }
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index fb4bea20657b..aa01277cc0d1 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -47,7 +47,6 @@ struct dm_table {
 
 	bool integrity_supported:1;
 	bool singleton:1;
-	bool all_blk_mq:1;
 	unsigned integrity_added:1;
 
 	/*
@@ -921,10 +920,7 @@ static int device_is_rq_based(struct dm_target *ti, struct dm_dev *dev,
 	struct request_queue *q = bdev_get_queue(dev->bdev);
 	struct verify_rq_based_data *v = data;
 
-	if (q->mq_ops)
-		v->mq_count++;
-	else
-		v->sq_count++;
+	v->mq_count++;
 
 	return queue_is_rq_based(q);
 }
@@ -1022,11 +1018,9 @@ static int dm_table_determine_type(struct dm_table *t)
 		int srcu_idx;
 		struct dm_table *live_table = dm_get_live_table(t->md, &srcu_idx);
 
-		/* inherit live table's type and all_blk_mq */
-		if (live_table) {
+		/* inherit live table's type */
+		if (live_table)
 			t->type = live_table->type;
-			t->all_blk_mq = live_table->all_blk_mq;
-		}
 		dm_put_live_table(t->md, srcu_idx);
 		return 0;
 	}
@@ -1050,13 +1044,6 @@ static int dm_table_determine_type(struct dm_table *t)
 		DMERR("table load rejected: not all devices are blk-mq request-stackable");
 		return -EINVAL;
 	}
-	t->all_blk_mq = v.mq_count > 0;
-
-	if (!t->all_blk_mq &&
-	    (t->type == DM_TYPE_MQ_REQUEST_BASED || t->type == DM_TYPE_NVME_BIO_BASED)) {
-		DMERR("table load rejected: all devices are not blk-mq request-stackable");
-		return -EINVAL;
-	}
 
 	return 0;
 }
@@ -1105,11 +1092,6 @@ bool dm_table_request_based(struct dm_table *t)
 	return __table_type_request_based(dm_table_get_type(t));
 }
 
-bool dm_table_all_blk_mq_devices(struct dm_table *t)
-{
-	return t->all_blk_mq;
-}
-
 static int dm_table_alloc_md_mempools(struct dm_table *t, struct mapped_device *md)
 {
 	enum dm_queue_mode type = dm_table_get_type(t);
@@ -2093,22 +2075,14 @@ void dm_table_run_md_queue_async(struct dm_table *t)
 {
 	struct mapped_device *md;
 	struct request_queue *queue;
-	unsigned long flags;
 
 	if (!dm_table_request_based(t))
 		return;
 
 	md = dm_table_get_md(t);
 	queue = dm_get_md_queue(md);
-	if (queue) {
-		if (queue->mq_ops)
-			blk_mq_run_hw_queues(queue, true);
-		else {
-			spin_lock_irqsave(queue->queue_lock, flags);
-			blk_run_queue_async(queue);
-			spin_unlock_irqrestore(queue->queue_lock, flags);
-		}
-	}
+	if (queue)
+		blk_mq_run_hw_queues(queue, true);
 }
 EXPORT_SYMBOL(dm_table_run_md_queue_async);
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 6be21dc210a1..224aabd997df 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1806,8 +1806,6 @@ static void dm_wq_work(struct work_struct *work);
 
 static void dm_init_normal_md_queue(struct mapped_device *md)
 {
-	md->use_blk_mq = false;
-
 	/*
 	 * Initialize aspects of queue that aren't relevant for blk-mq
 	 */
@@ -1818,8 +1816,6 @@ static void cleanup_mapped_device(struct mapped_device *md)
 {
 	if (md->wq)
 		destroy_workqueue(md->wq);
-	if (md->kworker_task)
-		kthread_stop(md->kworker_task);
 	bioset_exit(&md->bs);
 	bioset_exit(&md->io_bs);
 
@@ -1886,7 +1882,6 @@ static struct mapped_device *alloc_dev(int minor)
 		goto bad_io_barrier;
 
 	md->numa_node_id = numa_node_id;
-	md->use_blk_mq = dm_use_blk_mq_default();
 	md->init_tio_pdu = false;
 	md->type = DM_TYPE_NONE;
 	mutex_init(&md->suspend_lock);
@@ -1917,7 +1912,6 @@ static struct mapped_device *alloc_dev(int minor)
 	INIT_WORK(&md->work, dm_wq_work);
 	init_waitqueue_head(&md->eventq);
 	init_completion(&md->kobj_holder.completion);
-	md->kworker_task = NULL;
 
 	md->disk->major = _major;
 	md->disk->first_minor = minor;
@@ -2217,13 +2211,6 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 
 	switch (type) {
 	case DM_TYPE_REQUEST_BASED:
-		dm_init_normal_md_queue(md);
-		r = dm_old_init_request_queue(md, t);
-		if (r) {
-			DMERR("Cannot initialize queue for request-based mapped device");
-			return r;
-		}
-		break;
 	case DM_TYPE_MQ_REQUEST_BASED:
 		r = dm_mq_init_request_queue(md, t);
 		if (r) {
@@ -2329,9 +2316,6 @@ static void __dm_destroy(struct mapped_device *md, bool wait)
 
 	blk_set_queue_dying(md->queue);
 
-	if (dm_request_based(md) && md->kworker_task)
-		kthread_flush_worker(&md->kworker);
-
 	/*
 	 * Take suspend_lock so that presuspend and postsuspend methods
 	 * do not race with internal suspend.
@@ -2584,11 +2568,8 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	 * Stop md->queue before flushing md->wq in case request-based
 	 * dm defers requests to md->wq from md->queue.
 	 */
-	if (dm_request_based(md)) {
+	if (dm_request_based(md))
 		dm_stop_queue(md->queue);
-		if (md->kworker_task)
-			kthread_flush_worker(&md->kworker);
-	}
 
 	flush_workqueue(md->wq);
 
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 114a81b27c37..2d539b82ec08 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -70,7 +70,6 @@ struct dm_target *dm_table_get_immutable_target(struct dm_table *t);
 struct dm_target *dm_table_get_wildcard_target(struct dm_table *t);
 bool dm_table_bio_based(struct dm_table *t);
 bool dm_table_request_based(struct dm_table *t);
-bool dm_table_all_blk_mq_devices(struct dm_table *t);
 void dm_table_free_md_mempools(struct dm_table *t);
 struct dm_md_mempools *dm_table_get_md_mempools(struct dm_table *t);
 
-- 
2.17.1
