Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/5] block: Use pointer to backing_dev_info from request_queue
Date: Thu,  2 Feb 2017 15:56:50 +0100
Message-Id: <20170202145653.19614-3-jack@suse.cz>
In-Reply-To: <20170202145653.19614-1-jack@suse.cz>
References: <20170202145653.19614-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

We will want to have struct backing_dev_info allocated separately from
struct request_queue. As the first step add pointer to backing_dev_info
to request_queue and convert all users touching it. No functional
changes in this patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-cgroup.c             |  6 +++---
 block/blk-core.c               | 27 ++++++++++++++-------------
 block/blk-integrity.c          |  4 ++--
 block/blk-settings.c           |  2 +-
 block/blk-sysfs.c              |  8 ++++----
 block/blk-wbt.c                |  8 ++++----
 block/genhd.c                  |  2 +-
 drivers/block/aoe/aoeblk.c     |  4 ++--
 drivers/block/drbd/drbd_main.c |  6 +++---
 drivers/block/drbd/drbd_nl.c   | 12 +++++++-----
 drivers/block/drbd/drbd_proc.c |  2 +-
 drivers/block/drbd/drbd_req.c  |  2 +-
 drivers/block/pktcdvd.c        |  4 ++--
 drivers/block/rbd.c            |  2 +-
 drivers/md/bcache/request.c    | 10 +++++-----
 drivers/md/bcache/super.c      |  8 ++++----
 drivers/md/dm-cache-target.c   |  2 +-
 drivers/md/dm-era-target.c     |  2 +-
 drivers/md/dm-table.c          |  2 +-
 drivers/md/dm-thin.c           |  2 +-
 drivers/md/dm.c                |  6 +++---
 drivers/md/linear.c            |  2 +-
 drivers/md/md.c                |  6 +++---
 drivers/md/multipath.c         |  2 +-
 drivers/md/raid0.c             |  6 +++---
 drivers/md/raid1.c             |  4 ++--
 drivers/md/raid10.c            | 10 +++++-----
 drivers/md/raid5.c             | 12 ++++++------
 fs/gfs2/ops_fstype.c           |  2 +-
 fs/nilfs2/super.c              |  2 +-
 fs/super.c                     |  2 +-
 include/linux/blkdev.h         |  3 ++-
 mm/page-writeback.c            |  4 ++--
 33 files changed, 90 insertions(+), 86 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8ba0af780e88..d673a69b61b4 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -184,7 +184,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		goto err_free_blkg;
 	}
 
-	wb_congested = wb_congested_get_create(&q->backing_dev_info,
+	wb_congested = wb_congested_get_create(q->backing_dev_info,
 					       blkcg->css.id,
 					       GFP_NOWAIT | __GFP_NOWARN);
 	if (!wb_congested) {
@@ -469,8 +469,8 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 const char *blkg_dev_name(struct blkcg_gq *blkg)
 {
 	/* some drivers (floppy) instantiate a queue w/o disk registered */
-	if (blkg->q->backing_dev_info.dev)
-		return dev_name(blkg->q->backing_dev_info.dev);
+	if (blkg->q->backing_dev_info->dev)
+		return dev_name(blkg->q->backing_dev_info->dev);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(blkg_dev_name);
diff --git a/block/blk-core.c b/block/blk-core.c
index 61ba08c58b64..a9ff1b919ae7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -74,7 +74,7 @@ static void blk_clear_congested(struct request_list *rl, int sync)
 	 * flip its congestion state for events on other blkcgs.
 	 */
 	if (rl == &rl->q->root_rl)
-		clear_wb_congested(rl->q->backing_dev_info.wb.congested, sync);
+		clear_wb_congested(rl->q->backing_dev_info->wb.congested, sync);
 #endif
 }
 
@@ -85,7 +85,7 @@ static void blk_set_congested(struct request_list *rl, int sync)
 #else
 	/* see blk_clear_congested() */
 	if (rl == &rl->q->root_rl)
-		set_wb_congested(rl->q->backing_dev_info.wb.congested, sync);
+		set_wb_congested(rl->q->backing_dev_info->wb.congested, sync);
 #endif
 }
 
@@ -116,7 +116,7 @@ struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	return &q->backing_dev_info;
+	return q->backing_dev_info;
 }
 EXPORT_SYMBOL(blk_get_backing_dev_info);
 
@@ -584,7 +584,7 @@ void blk_cleanup_queue(struct request_queue *q)
 	blk_flush_integrity();
 
 	/* @q won't process any more request, flush async actions */
-	del_timer_sync(&q->backing_dev_info.laptop_mode_wb_timer);
+	del_timer_sync(&q->backing_dev_info->laptop_mode_wb_timer);
 	blk_sync_queue(q);
 
 	if (q->mq_ops)
@@ -596,7 +596,7 @@ void blk_cleanup_queue(struct request_queue *q)
 		q->queue_lock = &q->__queue_lock;
 	spin_unlock_irq(lock);
 
-	bdi_unregister(&q->backing_dev_info);
+	bdi_unregister(q->backing_dev_info);
 
 	/* @q is and will stay empty, shutdown and put */
 	blk_put_queue(q);
@@ -708,17 +708,18 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	if (!q->bio_split)
 		goto fail_id;
 
-	q->backing_dev_info.ra_pages =
+	q->backing_dev_info = &q->_backing_dev_info;
+	q->backing_dev_info->ra_pages =
 			(VM_MAX_READAHEAD * 1024) / PAGE_SIZE;
-	q->backing_dev_info.capabilities = BDI_CAP_CGROUP_WRITEBACK;
-	q->backing_dev_info.name = "block";
+	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
+	q->backing_dev_info->name = "block";
 	q->node = node_id;
 
-	err = bdi_init(&q->backing_dev_info);
+	err = bdi_init(q->backing_dev_info);
 	if (err)
 		goto fail_split;
 
-	setup_timer(&q->backing_dev_info.laptop_mode_wb_timer,
+	setup_timer(&q->backing_dev_info->laptop_mode_wb_timer,
 		    laptop_mode_timer_fn, (unsigned long) q);
 	setup_timer(&q->timeout, blk_rq_timed_out_timer, (unsigned long) q);
 	INIT_LIST_HEAD(&q->queue_head);
@@ -768,7 +769,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 fail_ref:
 	percpu_ref_exit(&q->q_usage_counter);
 fail_bdi:
-	bdi_destroy(&q->backing_dev_info);
+	bdi_destroy(q->backing_dev_info);
 fail_split:
 	bioset_free(q->bio_split);
 fail_id:
@@ -1196,7 +1197,7 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
 	 * disturb iosched and blkcg but weird is bettern than dead.
 	 */
 	printk_ratelimited(KERN_WARNING "%s: dev %s: request aux data allocation failed, iosched may be disturbed\n",
-			   __func__, dev_name(q->backing_dev_info.dev));
+			   __func__, dev_name(q->backing_dev_info->dev));
 
 	rq->rq_flags &= ~RQF_ELVPRIV;
 	rq->elv.icq = NULL;
@@ -2696,7 +2697,7 @@ void blk_finish_request(struct request *req, int error)
 	BUG_ON(blk_queued_rq(req));
 
 	if (unlikely(laptop_mode) && req->cmd_type == REQ_TYPE_FS)
-		laptop_io_completion(&req->q->backing_dev_info);
+		laptop_io_completion(req->q->backing_dev_info);
 
 	blk_delete_timer(req);
 
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index d69c5c79f98e..9f0ff5ba4f84 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -443,10 +443,10 @@ void blk_integrity_revalidate(struct gendisk *disk)
 		return;
 
 	if (bi->profile)
-		disk->queue->backing_dev_info.capabilities |=
+		disk->queue->backing_dev_info->capabilities |=
 			BDI_CAP_STABLE_WRITES;
 	else
-		disk->queue->backing_dev_info.capabilities &=
+		disk->queue->backing_dev_info->capabilities &=
 			~BDI_CAP_STABLE_WRITES;
 }
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 529e55f52a03..6eb19bcbf3cb 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -253,7 +253,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 	max_sectors = min_not_zero(max_hw_sectors, limits->max_dev_sectors);
 	max_sectors = min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
 	limits->max_sectors = max_sectors;
-	q->backing_dev_info.io_pages = max_sectors >> (PAGE_SHIFT - 9);
+	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
 }
 EXPORT_SYMBOL(blk_queue_max_hw_sectors);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1dbce057592d..64fb54c6b41c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -89,7 +89,7 @@ queue_requests_store(struct request_queue *q, const char *page, size_t count)
 
 static ssize_t queue_ra_show(struct request_queue *q, char *page)
 {
-	unsigned long ra_kb = q->backing_dev_info.ra_pages <<
+	unsigned long ra_kb = q->backing_dev_info->ra_pages <<
 					(PAGE_SHIFT - 10);
 
 	return queue_var_show(ra_kb, (page));
@@ -104,7 +104,7 @@ queue_ra_store(struct request_queue *q, const char *page, size_t count)
 	if (ret < 0)
 		return ret;
 
-	q->backing_dev_info.ra_pages = ra_kb >> (PAGE_SHIFT - 10);
+	q->backing_dev_info->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
 
 	return ret;
 }
@@ -236,7 +236,7 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 
 	spin_lock_irq(q->queue_lock);
 	q->limits.max_sectors = max_sectors_kb << 1;
-	q->backing_dev_info.io_pages = max_sectors_kb >> (PAGE_SHIFT - 10);
+	q->backing_dev_info->io_pages = max_sectors_kb >> (PAGE_SHIFT - 10);
 	spin_unlock_irq(q->queue_lock);
 
 	return ret;
@@ -799,7 +799,7 @@ static void blk_release_queue(struct kobject *kobj)
 		container_of(kobj, struct request_queue, kobj);
 
 	wbt_exit(q);
-	bdi_exit(&q->backing_dev_info);
+	bdi_exit(q->backing_dev_info);
 	blkcg_exit_queue(q);
 
 	if (q->elevator) {
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index f0a9c07b4c7a..1aedb1f7ee0c 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -96,7 +96,7 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
  */
 static bool wb_recent_wait(struct rq_wb *rwb)
 {
-	struct bdi_writeback *wb = &rwb->queue->backing_dev_info.wb;
+	struct bdi_writeback *wb = &rwb->queue->backing_dev_info->wb;
 
 	return time_before(jiffies, wb->dirty_sleep + HZ);
 }
@@ -279,7 +279,7 @@ enum {
 
 static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 {
-	struct backing_dev_info *bdi = &rwb->queue->backing_dev_info;
+	struct backing_dev_info *bdi = rwb->queue->backing_dev_info;
 	u64 thislat;
 
 	/*
@@ -339,7 +339,7 @@ static int latency_exceeded(struct rq_wb *rwb)
 
 static void rwb_trace_step(struct rq_wb *rwb, const char *msg)
 {
-	struct backing_dev_info *bdi = &rwb->queue->backing_dev_info;
+	struct backing_dev_info *bdi = rwb->queue->backing_dev_info;
 
 	trace_wbt_step(bdi, msg, rwb->scale_step, rwb->cur_win_nsec,
 			rwb->wb_background, rwb->wb_normal, rwb->wb_max);
@@ -423,7 +423,7 @@ static void wb_timer_fn(unsigned long data)
 
 	status = latency_exceeded(rwb);
 
-	trace_wbt_timer(&rwb->queue->backing_dev_info, status, rwb->scale_step,
+	trace_wbt_timer(rwb->queue->backing_dev_info, status, rwb->scale_step,
 			inflight);
 
 	/*
diff --git a/block/genhd.c b/block/genhd.c
index f2f22d0e8e14..d9ccd42f3675 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -613,7 +613,7 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 	disk_alloc_events(disk);
 
 	/* Register BDI before referencing it from bdev */
-	bdi = &disk->queue->backing_dev_info;
+	bdi = disk->queue->backing_dev_info;
 	bdi_register_owner(bdi, disk_to_dev(disk));
 
 	blk_register_region(disk_devt(disk), disk->minors, NULL,
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index ec9d8610b25f..027b876370bc 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -396,8 +396,8 @@ aoeblk_gdalloc(void *vp)
 	WARN_ON(d->gd);
 	WARN_ON(d->flags & DEVFL_UP);
 	blk_queue_max_hw_sectors(q, BLK_DEF_MAX_SECTORS);
-	q->backing_dev_info.name = "aoe";
-	q->backing_dev_info.ra_pages = READ_AHEAD / PAGE_SIZE;
+	q->backing_dev_info->name = "aoe";
+	q->backing_dev_info->ra_pages = READ_AHEAD / PAGE_SIZE;
 	d->bufpool = mp;
 	d->blkq = gd->queue = q;
 	q->queuedata = d;
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 83482721bc01..d305f05be648 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2462,7 +2462,7 @@ static int drbd_congested(void *congested_data, int bdi_bits)
 
 	if (get_ldev(device)) {
 		q = bdev_get_queue(device->ldev->backing_bdev);
-		r = bdi_congested(&q->backing_dev_info, bdi_bits);
+		r = bdi_congested(q->backing_dev_info, bdi_bits);
 		put_ldev(device);
 		if (r)
 			reason = 'b';
@@ -2834,8 +2834,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	/* we have no partitions. we contain only ourselves. */
 	device->this_bdev->bd_contains = device->this_bdev;
 
-	q->backing_dev_info.congested_fn = drbd_congested;
-	q->backing_dev_info.congested_data = device;
+	q->backing_dev_info->congested_fn = drbd_congested;
+	q->backing_dev_info->congested_data = device;
 
 	blk_queue_make_request(q, drbd_make_request);
 	blk_queue_write_cache(q, true, true);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f35db29cac76..908c704e20aa 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1328,11 +1328,13 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	if (b) {
 		blk_queue_stack_limits(q, b);
 
-		if (q->backing_dev_info.ra_pages != b->backing_dev_info.ra_pages) {
+		if (q->backing_dev_info->ra_pages !=
+		    b->backing_dev_info->ra_pages) {
 			drbd_info(device, "Adjusting my ra_pages to backing device's (%lu -> %lu)\n",
-				 q->backing_dev_info.ra_pages,
-				 b->backing_dev_info.ra_pages);
-			q->backing_dev_info.ra_pages = b->backing_dev_info.ra_pages;
+				 q->backing_dev_info->ra_pages,
+				 b->backing_dev_info->ra_pages);
+			q->backing_dev_info->ra_pages =
+						b->backing_dev_info->ra_pages;
 		}
 	}
 	fixup_discard_if_not_supported(q);
@@ -3345,7 +3347,7 @@ static void device_to_statistics(struct device_statistics *s,
 		s->dev_disk_flags = md->flags;
 		q = bdev_get_queue(device->ldev->backing_bdev);
 		s->dev_lower_blocked =
-			bdi_congested(&q->backing_dev_info,
+			bdi_congested(q->backing_dev_info,
 				      (1 << WB_async_congested) |
 				      (1 << WB_sync_congested));
 		put_ldev(device);
diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index be2b93fd2c11..8378142f7a55 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -288,7 +288,7 @@ static int drbd_seq_show(struct seq_file *seq, void *v)
 			seq_printf(seq, "%2d: cs:Unconfigured\n", i);
 		} else {
 			/* reset device->congestion_reason */
-			bdi_rw_congested(&device->rq_queue->backing_dev_info);
+			bdi_rw_congested(device->rq_queue->backing_dev_info);
 
 			nc = rcu_dereference(first_peer_device(device)->connection->net_conf);
 			wp = nc ? nc->wire_protocol - DRBD_PROT_A + 'A' : ' ';
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index de279fe4e4fd..cb6bdb75d52d 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -938,7 +938,7 @@ static bool remote_due_to_read_balancing(struct drbd_device *device, sector_t se
 
 	switch (rbm) {
 	case RB_CONGESTED_REMOTE:
-		bdi = &device->ldev->backing_bdev->bd_disk->queue->backing_dev_info;
+		bdi = device->ldev->backing_bdev->bd_disk->queue->backing_dev_info;
 		return bdi_read_congested(bdi);
 	case RB_LEAST_PENDING:
 		return atomic_read(&device->local_cnt) >
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 1b94c1ca5c5f..f735c1e48549 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1243,7 +1243,7 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	 		&& pd->bio_queue_size <= pd->write_congestion_off);
 	spin_unlock(&pd->lock);
 	if (wakeup) {
-		clear_bdi_congested(&pd->disk->queue->backing_dev_info,
+		clear_bdi_congested(pd->disk->queue->backing_dev_info,
 					BLK_RW_ASYNC);
 	}
 
@@ -2370,7 +2370,7 @@ static void pkt_make_request_write(struct request_queue *q, struct bio *bio)
 	spin_lock(&pd->lock);
 	if (pd->write_congestion_on > 0
 	    && pd->bio_queue_size >= pd->write_congestion_on) {
-		set_bdi_congested(&q->backing_dev_info, BLK_RW_ASYNC);
+		set_bdi_congested(q->backing_dev_info, BLK_RW_ASYNC);
 		do {
 			spin_unlock(&pd->lock);
 			congestion_wait(BLK_RW_ASYNC, HZ);
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 36d2b9f4e836..82afc56a5614 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4524,7 +4524,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	q->limits.discard_zeroes_data = 1;
 
 	if (!ceph_test_opt(rbd_dev->rbd_client->client, NOCRC))
-		q->backing_dev_info.capabilities |= BDI_CAP_STABLE_WRITES;
+		q->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
 
 	disk->queue = q;
 
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 76d20875503c..15f2a2c58e97 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1009,7 +1009,7 @@ static int cached_dev_congested(void *data, int bits)
 	struct request_queue *q = bdev_get_queue(dc->bdev);
 	int ret = 0;
 
-	if (bdi_congested(&q->backing_dev_info, bits))
+	if (bdi_congested(q->backing_dev_info, bits))
 		return 1;
 
 	if (cached_dev_get(dc)) {
@@ -1018,7 +1018,7 @@ static int cached_dev_congested(void *data, int bits)
 
 		for_each_cache(ca, d->c, i) {
 			q = bdev_get_queue(ca->bdev);
-			ret |= bdi_congested(&q->backing_dev_info, bits);
+			ret |= bdi_congested(q->backing_dev_info, bits);
 		}
 
 		cached_dev_put(dc);
@@ -1032,7 +1032,7 @@ void bch_cached_dev_request_init(struct cached_dev *dc)
 	struct gendisk *g = dc->disk.disk;
 
 	g->queue->make_request_fn		= cached_dev_make_request;
-	g->queue->backing_dev_info.congested_fn = cached_dev_congested;
+	g->queue->backing_dev_info->congested_fn = cached_dev_congested;
 	dc->disk.cache_miss			= cached_dev_cache_miss;
 	dc->disk.ioctl				= cached_dev_ioctl;
 }
@@ -1125,7 +1125,7 @@ static int flash_dev_congested(void *data, int bits)
 
 	for_each_cache(ca, d->c, i) {
 		q = bdev_get_queue(ca->bdev);
-		ret |= bdi_congested(&q->backing_dev_info, bits);
+		ret |= bdi_congested(q->backing_dev_info, bits);
 	}
 
 	return ret;
@@ -1136,7 +1136,7 @@ void bch_flash_dev_request_init(struct bcache_device *d)
 	struct gendisk *g = d->disk;
 
 	g->queue->make_request_fn		= flash_dev_make_request;
-	g->queue->backing_dev_info.congested_fn = flash_dev_congested;
+	g->queue->backing_dev_info->congested_fn = flash_dev_congested;
 	d->cache_miss				= flash_dev_cache_miss;
 	d->ioctl				= flash_dev_ioctl;
 }
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 3a19cbc8b230..85e3f21c2514 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -807,7 +807,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 	blk_queue_make_request(q, NULL);
 	d->disk->queue			= q;
 	q->queuedata			= d;
-	q->backing_dev_info.congested_data = d;
+	q->backing_dev_info->congested_data = d;
 	q->limits.max_hw_sectors	= UINT_MAX;
 	q->limits.max_sectors		= UINT_MAX;
 	q->limits.max_segment_size	= UINT_MAX;
@@ -1132,9 +1132,9 @@ static int cached_dev_init(struct cached_dev *dc, unsigned block_size)
 	set_capacity(dc->disk.disk,
 		     dc->bdev->bd_part->nr_sects - dc->sb.data_offset);
 
-	dc->disk.disk->queue->backing_dev_info.ra_pages =
-		max(dc->disk.disk->queue->backing_dev_info.ra_pages,
-		    q->backing_dev_info.ra_pages);
+	dc->disk.disk->queue->backing_dev_info->ra_pages =
+		max(dc->disk.disk->queue->backing_dev_info->ra_pages,
+		    q->backing_dev_info->ra_pages);
 
 	bch_cached_dev_request_init(dc);
 	bch_cached_dev_writeback_init(dc);
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index e04c61e0839e..fa255d66ca2f 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2291,7 +2291,7 @@ static void do_waker(struct work_struct *ws)
 static int is_congested(struct dm_dev *dev, int bdi_bits)
 {
 	struct request_queue *q = bdev_get_queue(dev->bdev);
-	return bdi_congested(&q->backing_dev_info, bdi_bits);
+	return bdi_congested(q->backing_dev_info, bdi_bits);
 }
 
 static int cache_is_congested(struct dm_target_callbacks *cb, int bdi_bits)
diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index bf2b2676cb8a..9fab33b113c4 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1379,7 +1379,7 @@ static void stop_worker(struct era *era)
 static int dev_is_congested(struct dm_dev *dev, int bdi_bits)
 {
 	struct request_queue *q = bdev_get_queue(dev->bdev);
-	return bdi_congested(&q->backing_dev_info, bdi_bits);
+	return bdi_congested(q->backing_dev_info, bdi_bits);
 }
 
 static int era_is_congested(struct dm_target_callbacks *cb, int bdi_bits)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0a427de23ed2..3ad16d9c9d5a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1750,7 +1750,7 @@ int dm_table_any_congested(struct dm_table *t, int bdi_bits)
 		char b[BDEVNAME_SIZE];
 
 		if (likely(q))
-			r |= bdi_congested(&q->backing_dev_info, bdi_bits);
+			r |= bdi_congested(q->backing_dev_info, bdi_bits);
 		else
 			DMWARN_LIMIT("%s: any_congested: nonexistent device %s",
 				     dm_device_name(t->md),
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index d1c05c12a9db..95dfa3904975 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2714,7 +2714,7 @@ static int pool_is_congested(struct dm_target_callbacks *cb, int bdi_bits)
 		return 1;
 
 	q = bdev_get_queue(pt->data_dev->bdev);
-	return bdi_congested(&q->backing_dev_info, bdi_bits);
+	return bdi_congested(q->backing_dev_info, bdi_bits);
 }
 
 static void requeue_bios(struct pool *pool)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3086da5664f3..db934b1dba9d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1314,7 +1314,7 @@ static int dm_any_congested(void *congested_data, int bdi_bits)
 			 * With request-based DM we only need to check the
 			 * top-level queue for congestion.
 			 */
-			r = md->queue->backing_dev_info.wb.state & bdi_bits;
+			r = md->queue->backing_dev_info->wb.state & bdi_bits;
 		} else {
 			map = dm_get_live_table_fast(md);
 			if (map)
@@ -1397,7 +1397,7 @@ void dm_init_md_queue(struct mapped_device *md)
 	 * - must do so here (in alloc_dev callchain) before queue is used
 	 */
 	md->queue->queuedata = md;
-	md->queue->backing_dev_info.congested_data = md;
+	md->queue->backing_dev_info->congested_data = md;
 }
 
 void dm_init_normal_md_queue(struct mapped_device *md)
@@ -1408,7 +1408,7 @@ void dm_init_normal_md_queue(struct mapped_device *md)
 	/*
 	 * Initialize aspects of queue that aren't relevant for blk-mq
 	 */
-	md->queue->backing_dev_info.congested_fn = dm_any_congested;
+	md->queue->backing_dev_info->congested_fn = dm_any_congested;
 	blk_queue_bounce_limit(md->queue, BLK_BOUNCE_ANY);
 }
 
diff --git a/drivers/md/linear.c b/drivers/md/linear.c
index 5975c9915684..f1c7bbac31a5 100644
--- a/drivers/md/linear.c
+++ b/drivers/md/linear.c
@@ -62,7 +62,7 @@ static int linear_congested(struct mddev *mddev, int bits)
 
 	for (i = 0; i < mddev->raid_disks && !ret ; i++) {
 		struct request_queue *q = bdev_get_queue(conf->disks[i].rdev->bdev);
-		ret |= bdi_congested(&q->backing_dev_info, bits);
+		ret |= bdi_congested(q->backing_dev_info, bits);
 	}
 
 	return ret;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 82821ee0d57f..ede3b2ad45db 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5341,8 +5341,8 @@ int md_run(struct mddev *mddev)
 			queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mddev->queue);
 		else
 			queue_flag_clear_unlocked(QUEUE_FLAG_NONROT, mddev->queue);
-		mddev->queue->backing_dev_info.congested_data = mddev;
-		mddev->queue->backing_dev_info.congested_fn = md_congested;
+		mddev->queue->backing_dev_info->congested_data = mddev;
+		mddev->queue->backing_dev_info->congested_fn = md_congested;
 	}
 	if (pers->sync_request) {
 		if (mddev->kobj.sd &&
@@ -5699,7 +5699,7 @@ static int do_md_stop(struct mddev *mddev, int mode,
 
 		__md_stop_writes(mddev);
 		__md_stop(mddev);
-		mddev->queue->backing_dev_info.congested_fn = NULL;
+		mddev->queue->backing_dev_info->congested_fn = NULL;
 
 		/* tell userspace to handle 'inactive' */
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
diff --git a/drivers/md/multipath.c b/drivers/md/multipath.c
index aa8c4e5c1ee2..d457afa672d5 100644
--- a/drivers/md/multipath.c
+++ b/drivers/md/multipath.c
@@ -169,7 +169,7 @@ static int multipath_congested(struct mddev *mddev, int bits)
 		if (rdev && !test_bit(Faulty, &rdev->flags)) {
 			struct request_queue *q = bdev_get_queue(rdev->bdev);
 
-			ret |= bdi_congested(&q->backing_dev_info, bits);
+			ret |= bdi_congested(q->backing_dev_info, bits);
 			/* Just like multipath_map, we just check the
 			 * first available device
 			 */
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index a162fedeb51a..1ec22cdac8cb 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -36,7 +36,7 @@ static int raid0_congested(struct mddev *mddev, int bits)
 	for (i = 0; i < raid_disks && !ret ; i++) {
 		struct request_queue *q = bdev_get_queue(devlist[i]->bdev);
 
-		ret |= bdi_congested(&q->backing_dev_info, bits);
+		ret |= bdi_congested(q->backing_dev_info, bits);
 	}
 	return ret;
 }
@@ -415,8 +415,8 @@ static int raid0_run(struct mddev *mddev)
 		 */
 		int stripe = mddev->raid_disks *
 			(mddev->chunk_sectors << 9) / PAGE_SIZE;
-		if (mddev->queue->backing_dev_info.ra_pages < 2* stripe)
-			mddev->queue->backing_dev_info.ra_pages = 2* stripe;
+		if (mddev->queue->backing_dev_info->ra_pages < 2* stripe)
+			mddev->queue->backing_dev_info->ra_pages = 2* stripe;
 	}
 
 	dump_zones(mddev);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index a1f3fbed9100..c5a128ec03fb 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -740,9 +740,9 @@ static int raid1_congested(struct mddev *mddev, int bits)
 			 * non-congested targets, it can be removed
 			 */
 			if ((bits & (1 << WB_async_congested)) || 1)
-				ret |= bdi_congested(&q->backing_dev_info, bits);
+				ret |= bdi_congested(q->backing_dev_info, bits);
 			else
-				ret &= bdi_congested(&q->backing_dev_info, bits);
+				ret &= bdi_congested(q->backing_dev_info, bits);
 		}
 	}
 	rcu_read_unlock();
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index ab5e86209322..d15028f63095 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -860,7 +860,7 @@ static int raid10_congested(struct mddev *mddev, int bits)
 		if (rdev && !test_bit(Faulty, &rdev->flags)) {
 			struct request_queue *q = bdev_get_queue(rdev->bdev);
 
-			ret |= bdi_congested(&q->backing_dev_info, bits);
+			ret |= bdi_congested(q->backing_dev_info, bits);
 		}
 	}
 	rcu_read_unlock();
@@ -3806,8 +3806,8 @@ static int raid10_run(struct mddev *mddev)
 		 * maybe...
 		 */
 		stripe /= conf->geo.near_copies;
-		if (mddev->queue->backing_dev_info.ra_pages < 2 * stripe)
-			mddev->queue->backing_dev_info.ra_pages = 2 * stripe;
+		if (mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
+			mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
 	}
 
 	if (md_integrity_register(mddev))
@@ -4608,8 +4608,8 @@ static void end_reshape(struct r10conf *conf)
 		int stripe = conf->geo.raid_disks *
 			((conf->mddev->chunk_sectors << 9) / PAGE_SIZE);
 		stripe /= conf->geo.near_copies;
-		if (conf->mddev->queue->backing_dev_info.ra_pages < 2 * stripe)
-			conf->mddev->queue->backing_dev_info.ra_pages = 2 * stripe;
+		if (conf->mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
+			conf->mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
 	}
 	conf->fullsync = 0;
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 06d7279bdd04..e075cdae5b5d 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6262,10 +6262,10 @@ raid5_store_skip_copy(struct mddev *mddev, const char *page, size_t len)
 		mddev_suspend(mddev);
 		conf->skip_copy = new;
 		if (new)
-			mddev->queue->backing_dev_info.capabilities |=
+			mddev->queue->backing_dev_info->capabilities |=
 				BDI_CAP_STABLE_WRITES;
 		else
-			mddev->queue->backing_dev_info.capabilities &=
+			mddev->queue->backing_dev_info->capabilities &=
 				~BDI_CAP_STABLE_WRITES;
 		mddev_resume(mddev);
 	}
@@ -7084,8 +7084,8 @@ static int raid5_run(struct mddev *mddev)
 		int data_disks = conf->previous_raid_disks - conf->max_degraded;
 		int stripe = data_disks *
 			((mddev->chunk_sectors << 9) / PAGE_SIZE);
-		if (mddev->queue->backing_dev_info.ra_pages < 2 * stripe)
-			mddev->queue->backing_dev_info.ra_pages = 2 * stripe;
+		if (mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
+			mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
 
 		chunk_size = mddev->chunk_sectors << 9;
 		blk_queue_io_min(mddev->queue, chunk_size);
@@ -7694,8 +7694,8 @@ static void end_reshape(struct r5conf *conf)
 			int data_disks = conf->raid_disks - conf->max_degraded;
 			int stripe = data_disks * ((conf->chunk_sectors << 9)
 						   / PAGE_SIZE);
-			if (conf->mddev->queue->backing_dev_info.ra_pages < 2 * stripe)
-				conf->mddev->queue->backing_dev_info.ra_pages = 2 * stripe;
+			if (conf->mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
+				conf->mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
 		}
 	}
 }
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index a34308df927f..c0e5b9a8bf5f 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1226,7 +1226,7 @@ static int set_gfs2_super(struct super_block *s, void *data)
 	 * We set the bdi here to the queue backing, file systems can
 	 * overwrite this in ->fill_super()
 	 */
-	s->s_bdi = &bdev_get_queue(s->s_bdev)->backing_dev_info;
+	s->s_bdi = bdev_get_queue(s->s_bdev)->backing_dev_info;
 	return 0;
 }
 
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 12eeae62a2b1..e1872f36147f 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1068,7 +1068,7 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_time_gran = 1;
 	sb->s_max_links = NILFS_LINK_MAX;
 
-	sb->s_bdi = &bdev_get_queue(sb->s_bdev)->backing_dev_info;
+	sb->s_bdi = bdev_get_queue(sb->s_bdev)->backing_dev_info;
 
 	err = load_nilfs(nilfs, sb);
 	if (err)
diff --git a/fs/super.c b/fs/super.c
index 1709ed029a2c..ea662b0e5e78 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1047,7 +1047,7 @@ static int set_bdev_super(struct super_block *s, void *data)
 	 * We set the bdi here to the queue backing, file systems can
 	 * overwrite this in ->fill_super()
 	 */
-	s->s_bdi = &bdev_get_queue(s->s_bdev)->backing_dev_info;
+	s->s_bdi = bdev_get_queue(s->s_bdev)->backing_dev_info;
 	return 0;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 83695641bd5e..069e4a102a73 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -432,7 +432,8 @@ struct request_queue {
 	 */
 	struct delayed_work	delay_work;
 
-	struct backing_dev_info	backing_dev_info;
+	struct backing_dev_info	*backing_dev_info;
+	struct backing_dev_info	_backing_dev_info;
 
 	/*
 	 * The queue owner gets to use this for whatever they like.
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 290e8b7d3181..216449825859 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1988,11 +1988,11 @@ void laptop_mode_timer_fn(unsigned long data)
 	 * We want to write everything out, not just down to the dirty
 	 * threshold
 	 */
-	if (!bdi_has_dirty_io(&q->backing_dev_info))
+	if (!bdi_has_dirty_io(q->backing_dev_info))
 		return;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(wb, &q->backing_dev_info.wb_list, bdi_node)
+	list_for_each_entry_rcu(wb, &q->backing_dev_info->wb_list, bdi_node)
 		if (wb_has_dirty_io(wb))
 			wb_start_writeback(wb, nr_pages, true,
 					   WB_REASON_LAPTOP_TIMER);
-- 
2.10.2
