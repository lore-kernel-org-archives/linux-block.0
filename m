Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536856B7A
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407184; cv=none; b=WVHSEigfxdlCgX6MGTvYd3Eylrudeyz/WYhxtKRAafR7dkFS1eEFHA8cwaRukq5YEfNWgYjctl95nfw9OS92Em36BQmKOjHyyvQTfkKmzsdFli6YebFZ3Lxsx0M5dOWR96K+ss2Yuzhdqmk1c58lggJo/TuIYJZpSCUyzEnWTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407184; c=relaxed/simple;
	bh=mobJj2r85FHFrJNhFgOKlhpYaPSRN0DJW/N0HohdXFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lsBRMp6cFTXE+cWZoGE/M1oAsX3XyuZr0qsJEpx3lG/QYESiLSX3gpzzXyltbutvlqEkwwbNG0/Divl6NpxAF4ufjqp172fHJqviBpHQaGAsvThyg7+ddTRXeIT66t0o2hkuHeiRcVGrSWD0aVXZDWyoZM5A6kNsSNqwyV+zKkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i5v5TdRE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i5v5TdRE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2seuk3B+b+9Goo0kksQWyUI4qZuS/qnSGf3qjxeBWdg=; b=i5v5TdREg8fo9rE7aU9cDEi2MT
	e8SZMe8aG3WjDJWKaVT3Mgzam9zZLY7W5XtuFdMyJgOO6PI6+Te5H+/Exfa+kFTVqIpXyuBz3Awz7
	NFK++90ybCVhcsEMpdfiC9iSdx/53Y1O7kLlAq9K/+upSBIYQ5QZj+Y268aH2RD6HJcD3xixXjn2l
	toqP78t2sbSm/hvwqQ1rIX0c3ZH/cWB0QaRurForEbJboMGaELe2Tg8bxcO9gn7anzcSOwnfG4xNr
	2ueYcimNIWaL1eg7nEMwWYENQNhjPn8IUjUGQon3OdLFS7EAGerztHaHmJQuCaj6erFlGgtWXaDFu
	yeKCIevA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcIkW-0000000DDqa-1yy3;
	Tue, 20 Feb 2024 05:33:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/5] null_blk: remove the bio based I/O path
Date: Tue, 20 Feb 2024 06:32:59 +0100
Message-Id: <20240220053303.3211004-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220053303.3211004-1-hch@lst.de>
References: <20240220053303.3211004-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The bio based I/O path complicates null_blk and also make various
data structures, including the per-command one way bigger than
required for the main request based interface.   As the bio-based
path is mostly used by stacking drivers and simple memory based
drivers, and brd is a good example driver for the latter there is
no need to have a bio based path in null_blk.  Remove the path
to simplify the driver and make future block layer API changes
simpler by not having to deal with the complex two API setup in
null_blk.

Note that the queue_mode field in struct nullb_device is kept as
that is simpler than having two different places to check the
value and fully open coding the debugfs helpers as the existing
ones won't work without a named struct member.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c     | 365 ++++++------------------------
 drivers/block/null_blk/null_blk.h |  17 --
 drivers/block/null_blk/trace.h    |   5 +-
 drivers/block/null_blk/zoned.c    |  10 +-
 4 files changed, 69 insertions(+), 328 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index baf2b228d00801..d6836327eefb42 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -115,6 +115,18 @@ module_param_string(init_hctx, g_init_hctx_str, sizeof(g_init_hctx_str), 0444);
 MODULE_PARM_DESC(init_hctx, "Fault injection to fail hctx init. init_hctx=<interval>,<probability>,<space>,<times>");
 #endif
 
+/*
+ * Historic queue modes.
+ *
+ * These days nothing but NULL_Q_MQ is actually supported, but we keep it the
+ * enum for error reporting.
+ */
+enum {
+	NULL_Q_BIO	= 0,
+	NULL_Q_RQ	= 1,
+	NULL_Q_MQ	= 2,
+};
+
 static int g_queue_mode = NULL_Q_MQ;
 
 static int null_param_store_val(const char *str, int *val, int min, int max)
@@ -756,98 +768,11 @@ static void null_free_dev(struct nullb_device *dev)
 	kfree(dev);
 }
 
-static void put_tag(struct nullb_queue *nq, unsigned int tag)
-{
-	clear_bit_unlock(tag, nq->tag_map);
-
-	if (waitqueue_active(&nq->wait))
-		wake_up(&nq->wait);
-}
-
-static unsigned int get_tag(struct nullb_queue *nq)
-{
-	unsigned int tag;
-
-	do {
-		tag = find_first_zero_bit(nq->tag_map, nq->queue_depth);
-		if (tag >= nq->queue_depth)
-			return -1U;
-	} while (test_and_set_bit_lock(tag, nq->tag_map));
-
-	return tag;
-}
-
-static void free_cmd(struct nullb_cmd *cmd)
-{
-	put_tag(cmd->nq, cmd->tag);
-}
-
-static enum hrtimer_restart null_cmd_timer_expired(struct hrtimer *timer);
-
-static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
-{
-	struct nullb_cmd *cmd;
-	unsigned int tag;
-
-	tag = get_tag(nq);
-	if (tag != -1U) {
-		cmd = &nq->cmds[tag];
-		cmd->tag = tag;
-		cmd->error = BLK_STS_OK;
-		cmd->nq = nq;
-		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
-			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
-				     HRTIMER_MODE_REL);
-			cmd->timer.function = null_cmd_timer_expired;
-		}
-		return cmd;
-	}
-
-	return NULL;
-}
-
-static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)
-{
-	struct nullb_cmd *cmd;
-	DEFINE_WAIT(wait);
-
-	do {
-		/*
-		 * This avoids multiple return statements, multiple calls to
-		 * __alloc_cmd() and a fast path call to prepare_to_wait().
-		 */
-		cmd = __alloc_cmd(nq);
-		if (cmd) {
-			cmd->bio = bio;
-			return cmd;
-		}
-		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
-		io_schedule();
-		finish_wait(&nq->wait, &wait);
-	} while (1);
-}
-
-static void end_cmd(struct nullb_cmd *cmd)
-{
-	int queue_mode = cmd->nq->dev->queue_mode;
-
-	switch (queue_mode)  {
-	case NULL_Q_MQ:
-		blk_mq_end_request(cmd->rq, cmd->error);
-		return;
-	case NULL_Q_BIO:
-		cmd->bio->bi_status = cmd->error;
-		bio_endio(cmd->bio);
-		break;
-	}
-
-	free_cmd(cmd);
-}
-
 static enum hrtimer_restart null_cmd_timer_expired(struct hrtimer *timer)
 {
-	end_cmd(container_of(timer, struct nullb_cmd, timer));
+	struct nullb_cmd *cmd = container_of(timer, struct nullb_cmd, timer);
 
+	blk_mq_end_request(blk_mq_rq_from_pdu(cmd), cmd->error);
 	return HRTIMER_NORESTART;
 }
 
@@ -860,7 +785,9 @@ static void null_cmd_end_timer(struct nullb_cmd *cmd)
 
 static void null_complete_rq(struct request *rq)
 {
-	end_cmd(blk_mq_rq_to_pdu(rq));
+	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
+
+	blk_mq_end_request(rq, cmd->error);
 }
 
 static struct nullb_page *null_alloc_page(void)
@@ -1277,7 +1204,7 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 
 static int null_handle_rq(struct nullb_cmd *cmd)
 {
-	struct request *rq = cmd->rq;
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	struct nullb *nullb = cmd->nq->dev->nullb;
 	int err;
 	unsigned int len;
@@ -1302,63 +1229,21 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 	return 0;
 }
 
-static int null_handle_bio(struct nullb_cmd *cmd)
-{
-	struct bio *bio = cmd->bio;
-	struct nullb *nullb = cmd->nq->dev->nullb;
-	int err;
-	unsigned int len;
-	sector_t sector = bio->bi_iter.bi_sector;
-	struct bio_vec bvec;
-	struct bvec_iter iter;
-
-	spin_lock_irq(&nullb->lock);
-	bio_for_each_segment(bvec, bio, iter) {
-		len = bvec.bv_len;
-		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
-				     op_is_write(bio_op(bio)), sector,
-				     bio->bi_opf & REQ_FUA);
-		if (err) {
-			spin_unlock_irq(&nullb->lock);
-			return err;
-		}
-		sector += len >> SECTOR_SHIFT;
-	}
-	spin_unlock_irq(&nullb->lock);
-	return 0;
-}
-
-static void null_stop_queue(struct nullb *nullb)
-{
-	struct request_queue *q = nullb->q;
-
-	if (nullb->dev->queue_mode == NULL_Q_MQ)
-		blk_mq_stop_hw_queues(q);
-}
-
-static void null_restart_queue_async(struct nullb *nullb)
-{
-	struct request_queue *q = nullb->q;
-
-	if (nullb->dev->queue_mode == NULL_Q_MQ)
-		blk_mq_start_stopped_hw_queues(q, true);
-}
-
 static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	struct nullb *nullb = dev->nullb;
 	blk_status_t sts = BLK_STS_OK;
-	struct request *rq = cmd->rq;
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
 
 	if (!hrtimer_active(&nullb->bw_timer))
 		hrtimer_restart(&nullb->bw_timer);
 
 	if (atomic_long_sub_return(blk_rq_bytes(rq), &nullb->cur_bytes) < 0) {
-		null_stop_queue(nullb);
+		blk_mq_stop_hw_queues(nullb->q);
 		/* race with timer */
 		if (atomic_long_read(&nullb->cur_bytes) > 0)
-			null_restart_queue_async(nullb);
+			blk_mq_start_stopped_hw_queues(nullb->q, true);
 		/* requeue request */
 		sts = BLK_STS_DEV_RESOURCE;
 	}
@@ -1385,37 +1270,29 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
 						     sector_t nr_sectors)
 {
 	struct nullb_device *dev = cmd->nq->dev;
-	int err;
 
 	if (op == REQ_OP_DISCARD)
 		return null_handle_discard(dev, sector, nr_sectors);
+	return errno_to_blk_status(null_handle_rq(cmd));
 
-	if (dev->queue_mode == NULL_Q_BIO)
-		err = null_handle_bio(cmd);
-	else
-		err = null_handle_rq(cmd);
-
-	return errno_to_blk_status(err);
 }
 
 static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)
 {
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	struct nullb_device *dev = cmd->nq->dev;
 	struct bio *bio;
 
-	if (dev->memory_backed)
-		return;
-
-	if (dev->queue_mode == NULL_Q_BIO && bio_op(cmd->bio) == REQ_OP_READ) {
-		zero_fill_bio(cmd->bio);
-	} else if (req_op(cmd->rq) == REQ_OP_READ) {
-		__rq_for_each_bio(bio, cmd->rq)
+	if (!dev->memory_backed && req_op(rq) == REQ_OP_READ) {
+		__rq_for_each_bio(bio, rq)
 			zero_fill_bio(bio);
 	}
 }
 
 static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
 {
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+
 	/*
 	 * Since root privileges are required to configure the null_blk
 	 * driver, it is fine that this driver does not initialize the
@@ -1429,20 +1306,10 @@ static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
 	/* Complete IO by inline, softirq or timer */
 	switch (cmd->nq->dev->irqmode) {
 	case NULL_IRQ_SOFTIRQ:
-		switch (cmd->nq->dev->queue_mode) {
-		case NULL_Q_MQ:
-			blk_mq_complete_request(cmd->rq);
-			break;
-		case NULL_Q_BIO:
-			/*
-			 * XXX: no proper submitting cpu information available.
-			 */
-			end_cmd(cmd);
-			break;
-		}
+		blk_mq_complete_request(rq);
 		break;
 	case NULL_IRQ_NONE:
-		end_cmd(cmd);
+		blk_mq_end_request(rq, cmd->error);
 		break;
 	case NULL_IRQ_TIMER:
 		null_cmd_end_timer(cmd);
@@ -1503,7 +1370,7 @@ static enum hrtimer_restart nullb_bwtimer_fn(struct hrtimer *timer)
 		return HRTIMER_NORESTART;
 
 	atomic_long_set(&nullb->cur_bytes, mb_per_tick(mbps));
-	null_restart_queue_async(nullb);
+	blk_mq_start_stopped_hw_queues(nullb->q, true);
 
 	hrtimer_forward_now(&nullb->bw_timer, timer_interval);
 
@@ -1520,26 +1387,6 @@ static void nullb_setup_bwtimer(struct nullb *nullb)
 	hrtimer_start(&nullb->bw_timer, timer_interval, HRTIMER_MODE_REL);
 }
 
-static struct nullb_queue *nullb_to_queue(struct nullb *nullb)
-{
-	int index = 0;
-
-	if (nullb->nr_queues != 1)
-		index = raw_smp_processor_id() / ((nr_cpu_ids + nullb->nr_queues - 1) / nullb->nr_queues);
-
-	return &nullb->queues[index];
-}
-
-static void null_submit_bio(struct bio *bio)
-{
-	sector_t sector = bio->bi_iter.bi_sector;
-	sector_t nr_sectors = bio_sectors(bio);
-	struct nullb *nullb = bio->bi_bdev->bd_disk->private_data;
-	struct nullb_queue *nq = nullb_to_queue(nullb);
-
-	null_handle_cmd(alloc_cmd(nq, bio), sector, nr_sectors, bio_op(bio));
-}
-
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
 
 static bool should_timeout_request(struct request *rq)
@@ -1659,7 +1506,7 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 						blk_rq_sectors(req));
 		if (!blk_mq_add_to_batch(req, iob, (__force int) cmd->error,
 					blk_mq_end_request_batch))
-			end_cmd(cmd);
+			blk_mq_end_request(req, cmd->error);
 		nr++;
 	}
 
@@ -1715,7 +1562,6 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		cmd->timer.function = null_cmd_timer_expired;
 	}
-	cmd->rq = rq;
 	cmd->error = BLK_STS_OK;
 	cmd->nq = nq;
 	cmd->fake_timeout = should_timeout_request(rq) ||
@@ -1774,22 +1620,6 @@ static void null_queue_rqs(struct request **rqlist)
 	*rqlist = requeue_list;
 }
 
-static void cleanup_queue(struct nullb_queue *nq)
-{
-	bitmap_free(nq->tag_map);
-	kfree(nq->cmds);
-}
-
-static void cleanup_queues(struct nullb *nullb)
-{
-	int i;
-
-	for (i = 0; i < nullb->nr_queues; i++)
-		cleanup_queue(&nullb->queues[i]);
-
-	kfree(nullb->queues);
-}
-
 static void null_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
 	struct nullb_queue *nq = hctx->driver_data;
@@ -1800,8 +1630,6 @@ static void null_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 
 static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
 {
-	init_waitqueue_head(&nq->wait);
-	nq->queue_depth = nullb->queue_depth;
 	nq->dev = nullb->dev;
 	INIT_LIST_HEAD(&nq->poll_list);
 	spin_lock_init(&nq->poll_lock);
@@ -1853,14 +1681,13 @@ static void null_del_dev(struct nullb *nullb)
 	if (test_bit(NULLB_DEV_FL_THROTTLED, &nullb->dev->flags)) {
 		hrtimer_cancel(&nullb->bw_timer);
 		atomic_long_set(&nullb->cur_bytes, LONG_MAX);
-		null_restart_queue_async(nullb);
+		blk_mq_start_stopped_hw_queues(nullb->q, true);
 	}
 
 	put_disk(nullb->disk);
-	if (dev->queue_mode == NULL_Q_MQ &&
-	    nullb->tag_set == &nullb->__tag_set)
+	if (nullb->tag_set == &nullb->__tag_set)
 		blk_mq_free_tag_set(nullb->tag_set);
-	cleanup_queues(nullb);
+	kfree(nullb->queues);
 	if (null_cache_active(nullb))
 		null_free_device_storage(nullb->dev, true);
 	kfree(nullb);
@@ -1887,40 +1714,11 @@ static void null_config_discard(struct nullb *nullb)
 	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
 }
 
-static const struct block_device_operations null_bio_ops = {
+static const struct block_device_operations null_ops = {
 	.owner		= THIS_MODULE,
-	.submit_bio	= null_submit_bio,
 	.report_zones	= null_report_zones,
 };
 
-static const struct block_device_operations null_rq_ops = {
-	.owner		= THIS_MODULE,
-	.report_zones	= null_report_zones,
-};
-
-static int setup_commands(struct nullb_queue *nq)
-{
-	struct nullb_cmd *cmd;
-	int i;
-
-	nq->cmds = kcalloc(nq->queue_depth, sizeof(*cmd), GFP_KERNEL);
-	if (!nq->cmds)
-		return -ENOMEM;
-
-	nq->tag_map = bitmap_zalloc(nq->queue_depth, GFP_KERNEL);
-	if (!nq->tag_map) {
-		kfree(nq->cmds);
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < nq->queue_depth; i++) {
-		cmd = &nq->cmds[i];
-		cmd->tag = -1U;
-	}
-
-	return 0;
-}
-
 static int setup_queues(struct nullb *nullb)
 {
 	int nqueues = nr_cpu_ids;
@@ -1937,24 +1735,6 @@ static int setup_queues(struct nullb *nullb)
 	return 0;
 }
 
-static int init_driver_queues(struct nullb *nullb)
-{
-	struct nullb_queue *nq;
-	int i, ret = 0;
-
-	for (i = 0; i < nullb->dev->submit_queues; i++) {
-		nq = &nullb->queues[i];
-
-		null_init_queue(nullb, nq);
-
-		ret = setup_commands(nq);
-		if (ret)
-			return ret;
-		nullb->nr_queues++;
-	}
-	return 0;
-}
-
 static int null_gendisk_register(struct nullb *nullb)
 {
 	sector_t size = ((sector_t)nullb->dev->size * SZ_1M) >> SECTOR_SHIFT;
@@ -1965,10 +1745,7 @@ static int null_gendisk_register(struct nullb *nullb)
 	disk->major		= null_major;
 	disk->first_minor	= nullb->index;
 	disk->minors		= 1;
-	if (queue_is_mq(nullb->q))
-		disk->fops		= &null_rq_ops;
-	else
-		disk->fops		= &null_bio_ops;
+	disk->fops		= &null_ops;
 	disk->private_data	= nullb;
 	strscpy_pad(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
@@ -2036,11 +1813,15 @@ static int null_validate_conf(struct nullb_device *dev)
 		pr_err("legacy IO path is no longer available\n");
 		return -EINVAL;
 	}
+	if (dev->queue_mode == NULL_Q_BIO) {
+		pr_err("BIO-based IO path is no longer available, using blk-mq instead.\n");
+		dev->queue_mode = NULL_Q_MQ;
+	}
 
 	dev->blocksize = round_down(dev->blocksize, 512);
 	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
 
-	if (dev->queue_mode == NULL_Q_MQ && dev->use_per_node_hctx) {
+	if (dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)
 			dev->submit_queues = nr_online_nodes;
 	} else if (dev->submit_queues > nr_cpu_ids)
@@ -2052,8 +1833,6 @@ static int null_validate_conf(struct nullb_device *dev)
 	if (dev->poll_queues > g_poll_queues)
 		dev->poll_queues = g_poll_queues;
 	dev->prev_poll_queues = dev->poll_queues;
-
-	dev->queue_mode = min_t(unsigned int, dev->queue_mode, NULL_Q_MQ);
 	dev->irqmode = min_t(unsigned int, dev->irqmode, NULL_IRQ_TIMER);
 
 	/* Do memory allocation, so set blocking */
@@ -2064,9 +1843,6 @@ static int null_validate_conf(struct nullb_device *dev)
 	dev->cache_size = min_t(unsigned long, ULONG_MAX / 1024 / 1024,
 						dev->cache_size);
 	dev->mbps = min_t(unsigned int, 1024 * 40, dev->mbps);
-	/* can not stop a queue */
-	if (dev->queue_mode == NULL_Q_BIO)
-		dev->mbps = 0;
 
 	if (dev->zoned &&
 	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
@@ -2127,44 +1903,31 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		goto out_free_nullb;
 
-	if (dev->queue_mode == NULL_Q_MQ) {
-		if (dev->shared_tags) {
-			if (!tag_set.ops) {
-				rv = null_init_tag_set(NULL, &tag_set);
-				if (rv) {
-					tag_set.ops = NULL;
-					goto out_cleanup_queues;
-				}
+	if (dev->shared_tags) {
+		if (!tag_set.ops) {
+			rv = null_init_tag_set(NULL, &tag_set);
+			if (rv) {
+				tag_set.ops = NULL;
+				goto out_cleanup_queues;
 			}
-			nullb->tag_set = &tag_set;
-			rv = 0;
-		} else {
-			nullb->tag_set = &nullb->__tag_set;
-			rv = null_init_tag_set(nullb, nullb->tag_set);
 		}
+		nullb->tag_set = &tag_set;
+		rv = 0;
+	} else {
+		nullb->tag_set = &nullb->__tag_set;
+		rv = null_init_tag_set(nullb, nullb->tag_set);
+	}
 
-		if (rv)
-			goto out_cleanup_queues;
-
-		nullb->tag_set->timeout = 5 * HZ;
-		nullb->disk = blk_mq_alloc_disk(nullb->tag_set, NULL, nullb);
-		if (IS_ERR(nullb->disk)) {
-			rv = PTR_ERR(nullb->disk);
-			goto out_cleanup_tags;
-		}
-		nullb->q = nullb->disk->queue;
-	} else if (dev->queue_mode == NULL_Q_BIO) {
-		nullb->disk = blk_alloc_disk(NULL, nullb->dev->home_node);
-		if (IS_ERR(nullb->disk)) {
-			rv = PTR_ERR(nullb->disk);
-			goto out_cleanup_queues;
-		}
+	if (rv)
+		goto out_cleanup_queues;
 
-		nullb->q = nullb->disk->queue;
-		rv = init_driver_queues(nullb);
-		if (rv)
-			goto out_cleanup_disk;
+	nullb->tag_set->timeout = 5 * HZ;
+	nullb->disk = blk_mq_alloc_disk(nullb->tag_set, NULL, nullb);
+	if (IS_ERR(nullb->disk)) {
+		rv = PTR_ERR(nullb->disk);
+		goto out_cleanup_tags;
 	}
+	nullb->q = nullb->disk->queue;
 
 	if (dev->mbps) {
 		set_bit(NULLB_DEV_FL_THROTTLED, &dev->flags);
@@ -2232,10 +1995,10 @@ static int null_add_dev(struct nullb_device *dev)
 out_cleanup_disk:
 	put_disk(nullb->disk);
 out_cleanup_tags:
-	if (dev->queue_mode == NULL_Q_MQ && nullb->tag_set == &nullb->__tag_set)
+	if (nullb->tag_set == &nullb->__tag_set)
 		blk_mq_free_tag_set(nullb->tag_set);
 out_cleanup_queues:
-	cleanup_queues(nullb);
+	kfree(nullb->queues);
 out_free_nullb:
 	kfree(nullb);
 	dev->nullb = NULL;
@@ -2311,7 +2074,7 @@ static int __init null_init(void)
 		return -EINVAL;
 	}
 
-	if (g_queue_mode == NULL_Q_MQ && g_use_per_node_hctx) {
+	if (g_use_per_node_hctx) {
 		if (g_submit_queues != nr_online_nodes) {
 			pr_warn("submit_queues param is set to %u.\n",
 				nr_online_nodes);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 7bcfc0922ae821..7c618d53d8fd06 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -16,11 +16,6 @@
 #include <linux/mutex.h>
 
 struct nullb_cmd {
-	union {
-		struct request *rq;
-		struct bio *bio;
-	};
-	unsigned int tag;
 	blk_status_t error;
 	bool fake_timeout;
 	struct nullb_queue *nq;
@@ -28,16 +23,11 @@ struct nullb_cmd {
 };
 
 struct nullb_queue {
-	unsigned long *tag_map;
-	wait_queue_head_t wait;
-	unsigned int queue_depth;
 	struct nullb_device *dev;
 	unsigned int requeue_selection;
 
 	struct list_head poll_list;
 	spinlock_t poll_lock;
-
-	struct nullb_cmd *cmds;
 };
 
 struct nullb_zone {
@@ -60,13 +50,6 @@ struct nullb_zone {
 	unsigned int capacity;
 };
 
-/* Queue modes */
-enum {
-	NULL_Q_BIO	= 0,
-	NULL_Q_RQ	= 1,
-	NULL_Q_MQ	= 2,
-};
-
 struct nullb_device {
 	struct nullb *nullb;
 	struct config_group group;
diff --git a/drivers/block/null_blk/trace.h b/drivers/block/null_blk/trace.h
index 6b2b370e786f5f..ef2d05d5f0df7e 100644
--- a/drivers/block/null_blk/trace.h
+++ b/drivers/block/null_blk/trace.h
@@ -41,10 +41,11 @@ TRACE_EVENT(nullb_zone_op,
 		__field(unsigned int, zone_cond)
 	    ),
 	    TP_fast_assign(
-		__entry->op = req_op(cmd->rq);
+		__entry->op = req_op(blk_mq_rq_from_pdu(cmd));
 		__entry->zone_no = zone_no;
 		__entry->zone_cond = zone_cond;
-		__assign_disk_name(__entry->disk, cmd->rq->q->disk);
+		__assign_disk_name(__entry->disk,
+			blk_mq_rq_from_pdu(cmd)->q->disk);
 	    ),
 	    TP_printk("%s req=%-15s zone_no=%u zone_cond=%-10s",
 		      __print_disk_name(__entry->disk),
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 6f5e0994862eae..3605afe105dac9 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -168,10 +168,7 @@ int null_register_zoned_dev(struct nullb *nullb)
 	disk_set_max_open_zones(nullb->disk, dev->zone_max_open);
 	disk_set_max_active_zones(nullb->disk, dev->zone_max_active);
 
-	if (queue_is_mq(q))
-		return blk_revalidate_disk_zones(nullb->disk, NULL);
-
-	return 0;
+	return blk_revalidate_disk_zones(nullb->disk, NULL);
 }
 
 void null_free_zoned_dev(struct nullb_device *dev)
@@ -394,10 +391,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	 */
 	if (append) {
 		sector = zone->wp;
-		if (dev->queue_mode == NULL_Q_MQ)
-			cmd->rq->__sector = sector;
-		else
-			cmd->bio->bi_iter.bi_sector = sector;
+		blk_mq_rq_from_pdu(cmd)->__sector = sector;
 	} else if (sector != zone->wp) {
 		ret = BLK_STS_IOERR;
 		goto unlock;
-- 
2.39.2

