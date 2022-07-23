Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7191C433EF
	for <linux-block@archiver.kernel.org>; Sat, 23 Jul 2022 06:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiGWG2Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Jul 2022 02:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiGWG2X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Jul 2022 02:28:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6C112610
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 23:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=t8b2I6Cww+21S7yJXuMJP6mmdYZxNAmyhJ6AgDjmGZA=; b=SX1m07ifbP9oz0xKVPhMpFRvYK
        QPJjvhd6sGpO/EU7pKQ2zl2dw3p0xEpn+KO57b1QLAtP3nzDOCMJc+UjvrfmVv6pzXxVb+VWlA6/T
        ZDjRfsyTuV3NcUggKrO9YPxEnLXc57yuWS4sGhQ5oblbyRuH2WCLIg1CAtt37HzR0uyM0Ypb6e6m5
        k1YsnNC5Tf/sDWGPwX+F9xDOZC0VipnUYnEXT0sbxPGNm6SFa+IRaBzC80iVE3fenn+qT9vxui7Lr
        fKEtdynqHXlzeWCGQMmls3zqG5XuiM4/rqFuQevxS8v+/nNUIE5rakbxiQhHKxpWiljBqRErvQZ1E
        hS2D5qEg==;
Received: from [2001:4bb8:199:fe1f:951f:1322:520f:5e75] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oF8cf-00GLeM-4N; Sat, 23 Jul 2022 06:28:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/6] block: change the blk_queue_split calling convention
Date:   Sat, 23 Jul 2022 08:28:11 +0200
Message-Id: <20220723062816.2210784-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220723062816.2210784-1-hch@lst.de>
References: <20220723062816.2210784-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The double indirect bio leads to somewhat suboptimal code generation.
Instead return the (original or split) bio, and make sure the
request_queue arguments to the lower level helpers is passed after the
bio to avoid constant reshuffling of the argument passing registers.

Also give it and the helpers used to implement it more descriptive names.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c             | 99 +++++++++++++++++------------------
 block/blk-mq.c                |  4 +-
 block/blk.h                   |  6 +--
 drivers/block/drbd/drbd_req.c |  2 +-
 drivers/block/pktcdvd.c       |  2 +-
 drivers/block/ps3vram.c       |  2 +-
 drivers/md/dm.c               |  6 +--
 drivers/md/md.c               |  2 +-
 drivers/nvme/host/multipath.c |  2 +-
 drivers/s390/block/dcssblk.c  |  2 +-
 include/linux/blkdev.h        |  2 +-
 11 files changed, 63 insertions(+), 66 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3c3f785f558af..95c0f2d72c741 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -95,10 +95,8 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
 	return bio_will_gap(req->q, NULL, bio, req->bio);
 }
 
-static struct bio *blk_bio_discard_split(struct request_queue *q,
-					 struct bio *bio,
-					 struct bio_set *bs,
-					 unsigned *nsegs)
+static struct bio *bio_split_discard(struct bio *bio, struct request_queue *q,
+		unsigned *nsegs, struct bio_set *bs)
 {
 	unsigned int max_discard_sectors, granularity;
 	int alignment;
@@ -139,8 +137,8 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 	return bio_split(bio, split_sectors, GFP_NOIO, bs);
 }
 
-static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
-		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
+static struct bio *bio_split_write_zeroes(struct bio *bio,
+		struct request_queue *q, unsigned *nsegs, struct bio_set *bs)
 {
 	*nsegs = 0;
 
@@ -161,8 +159,8 @@ static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
  * requests that are submitted to a block device if the start of a bio is not
  * aligned to a physical block boundary.
  */
-static inline unsigned get_max_io_size(struct request_queue *q,
-				       struct bio *bio)
+static inline unsigned get_max_io_size(struct bio *bio,
+		struct request_queue *q)
 {
 	unsigned pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
 	unsigned lbs = queue_logical_block_size(q) >> SECTOR_SHIFT;
@@ -247,16 +245,16 @@ static bool bvec_split_segs(const struct request_queue *q,
 }
 
 /**
- * blk_bio_segment_split - split a bio in two bios
- * @q:    [in] request queue pointer
+ * bio_split_rw - split a bio in two bios
  * @bio:  [in] bio to be split
- * @bs:	  [in] bio set to allocate the clone from
+ * @q:    [in] request queue pointer
  * @segs: [out] number of segments in the bio with the first half of the sectors
+ * @bs:	  [in] bio set to allocate the clone from
  *
  * Clone @bio, update the bi_iter of the clone to represent the first sectors
  * of @bio and update @bio->bi_iter to represent the remaining sectors. The
  * following is guaranteed for the cloned bio:
- * - That it has at most get_max_io_size(@q, @bio) sectors.
+ * - That it has at most get_max_io_size(@bio, @q) sectors.
  * - That it has at most queue_max_segments(@q) segments.
  *
  * Except for discard requests the cloned bio will point at the bi_io_vec of
@@ -265,15 +263,13 @@ static bool bvec_split_segs(const struct request_queue *q,
  * responsible for ensuring that @bs is only destroyed after processing of the
  * split bio has finished.
  */
-static struct bio *blk_bio_segment_split(struct request_queue *q,
-					 struct bio *bio,
-					 struct bio_set *bs,
-					 unsigned *segs)
+static struct bio *bio_split_rw(struct bio *bio, struct request_queue *q,
+		unsigned *segs, struct bio_set *bs)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
 	unsigned nsegs = 0, bytes = 0;
-	const unsigned max_bytes = get_max_io_size(q, bio) << 9;
+	const unsigned max_bytes = get_max_io_size(bio, q) << 9;
 	const unsigned max_segs = queue_max_segments(q);
 
 	bio_for_each_bvec(bv, bio, iter) {
@@ -320,67 +316,68 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 }
 
 /**
- * __blk_queue_split - split a bio and submit the second half
- * @q:       [in] request_queue new bio is being queued at
- * @bio:     [in, out] bio to be split
- * @nr_segs: [out] number of segments in the first bio
+ * __bio_split_to_limits - split a bio to fit the queue limits
+ * @bio:     bio to be split
+ * @q:       request_queue new bio is being queued at
+ * @nr_segs: returns the number of segments in the returned bio
  *
- * Split a bio into two bios, chain the two bios, submit the second half and
- * store a pointer to the first half in *@bio. If the second bio is still too
- * big it will be split by a recursive call to this function. Since this
- * function may allocate a new bio from q->bio_split, it is the responsibility
- * of the caller to ensure that q->bio_split is only released after processing
- * of the split bio has finished.
+ * Check if @bio needs splitting based on the queue limits, and if so split off
+ * a bio fitting the limits from the beginning of @bio and return it.  @bio is
+ * shortened to the remainder and re-submitted.
+ *
+ * The split bio is allocated from @q->bio_split, which is provided by the
+ * block layer.
  */
-void __blk_queue_split(struct request_queue *q, struct bio **bio,
+struct bio *__bio_split_to_limits(struct bio *bio, struct request_queue *q,
 		       unsigned int *nr_segs)
 {
-	struct bio *split = NULL;
+	struct bio *split;
 
-	switch (bio_op(*bio)) {
+	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
-		split = blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);
+		split = bio_split_discard(bio, q, nr_segs, &q->bio_split);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
-				nr_segs);
+		split = bio_split_write_zeroes(bio, q, nr_segs, &q->bio_split);
 		break;
 	default:
-		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
+		split = bio_split_rw(bio, q, nr_segs, &q->bio_split);
 		break;
 	}
 
 	if (split) {
 		/* there isn't chance to merge the splitted bio */
 		split->bi_opf |= REQ_NOMERGE;
-
-		bio_chain(split, *bio);
-		trace_block_split(split, (*bio)->bi_iter.bi_sector);
-		submit_bio_noacct(*bio);
-		*bio = split;
+		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
+		submit_bio_noacct(bio);
+		return split;
 	}
+	return bio;
 }
 
 /**
- * blk_queue_split - split a bio and submit the second half
- * @bio: [in, out] bio to be split
+ * bio_split_to_limits - split a bio to fit the queue limits
+ * @bio:     bio to be split
+ *
+ * Check if @bio needs splitting based on the queue limits of @bio->bi_bdev, and
+ * if so split off a bio fitting the limits from the beginning of @bio and
+ * return it.  @bio is shortened to the remainder and re-submitted.
  *
- * Split a bio into two bios, chains the two bios, submit the second half and
- * store a pointer to the first half in *@bio. Since this function may allocate
- * a new bio from q->bio_split, it is the responsibility of the caller to ensure
- * that q->bio_split is only released after processing of the split bio has
- * finished.
+ * The split bio is allocated from @q->bio_split, which is provided by the
+ * block layer.
  */
-void blk_queue_split(struct bio **bio)
+struct bio *bio_split_to_limits(struct bio *bio)
 {
-	struct request_queue *q = bdev_get_queue((*bio)->bi_bdev);
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	unsigned int nr_segs;
 
-	if (blk_may_split(q, *bio))
-		__blk_queue_split(q, bio, &nr_segs);
+	if (bio_may_exceed_limits(bio, q))
+		return __bio_split_to_limits(bio, q, &nr_segs);
+	return bio;
 }
-EXPORT_SYMBOL(blk_queue_split);
+EXPORT_SYMBOL(bio_split_to_limits);
 
 unsigned int blk_recalc_rq_segments(struct request *rq)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 70177ee74295b..790f55453f1b1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2816,8 +2816,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	blk_status_t ret;
 
 	blk_queue_bounce(q, &bio);
-	if (blk_may_split(q, bio))
-		__blk_queue_split(q, &bio, &nr_segs);
+	if (bio_may_exceed_limits(bio, q))
+		bio = __bio_split_to_limits(bio, q, &nr_segs);
 
 	if (!bio_integrity_prep(bio))
 		return;
diff --git a/block/blk.h b/block/blk.h
index 1d83b1d41cd10..623be4c2e60c1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -288,7 +288,7 @@ ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
 ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
 
-static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
+static inline bool bio_may_exceed_limits(struct bio *bio, struct request_queue *q)
 {
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
@@ -311,8 +311,8 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
 		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
 }
 
-void __blk_queue_split(struct request_queue *q, struct bio **bio,
-			unsigned int *nr_segs);
+struct bio *__bio_split_to_limits(struct bio *bio, struct request_queue *q,
+		       unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 6d8dd14458c69..8f7f144e54f3a 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1608,7 +1608,7 @@ void drbd_submit_bio(struct bio *bio)
 {
 	struct drbd_device *device = bio->bi_bdev->bd_disk->private_data;
 
-	blk_queue_split(&bio);
+	bio = bio_split_to_limits(bio);
 
 	/*
 	 * what we "blindly" assume:
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 01a15dbd9cde2..4cea3b08087ed 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2399,7 +2399,7 @@ static void pkt_submit_bio(struct bio *bio)
 	struct pktcdvd_device *pd = bio->bi_bdev->bd_disk->queue->queuedata;
 	struct bio *split;
 
-	blk_queue_split(&bio);
+	bio = bio_split_to_limits(bio);
 
 	pkt_dbg(2, pd, "start = %6llx stop = %6llx\n",
 		(unsigned long long)bio->bi_iter.bi_sector,
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index d1e0fefec90ba..e1d080f680edf 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -586,7 +586,7 @@ static void ps3vram_submit_bio(struct bio *bio)
 
 	dev_dbg(&dev->core, "%s\n", __func__);
 
-	blk_queue_split(&bio);
+	bio = bio_split_to_limits(bio);
 
 	spin_lock_irq(&priv->lock);
 	busy = !bio_list_empty(&priv->list);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 54c2a23f4e55c..a014a002298bd 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1091,7 +1091,7 @@ static sector_t max_io_len(struct dm_target *ti, sector_t sector)
 	 * Does the target need to split IO even further?
 	 * - varied (per target) IO splitting is a tenet of DM; this
 	 *   explains why stacked chunk_sectors based splitting via
-	 *   blk_queue_split() isn't possible here.
+	 *   bio_split_to_limits() isn't possible here.
 	 */
 	if (!ti->max_io_len)
 		return len;
@@ -1669,10 +1669,10 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 	is_abnormal = is_abnormal_io(bio);
 	if (unlikely(is_abnormal)) {
 		/*
-		 * Use blk_queue_split() for abnormal IO (e.g. discard, etc)
+		 * Use bio_split_to_limits() for abnormal IO (e.g. discard, etc)
 		 * otherwise associated queue_limits won't be imposed.
 		 */
-		blk_queue_split(&bio);
+		bio = bio_split_to_limits(bio);
 	}
 
 	init_clone_info(&ci, md, map, bio, is_abnormal);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4df78e30b76a5..79d7e4a89d6e3 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -464,7 +464,7 @@ static void md_submit_bio(struct bio *bio)
 		return;
 	}
 
-	blk_queue_split(&bio);
+	bio = bio_split_to_limits(bio);
 
 	if (mddev->ro == 1 && unlikely(rw == WRITE)) {
 		if (bio_sectors(bio) != 0)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f26640ccb9555..bf30ed33e1126 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -346,7 +346,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 	 * different queue via blk_steal_bios(), so we need to use the bio_split
 	 * pool from the original queue to allocate the bvecs from.
 	 */
-	blk_queue_split(&bio);
+	bio = bio_split_to_limits(bio);
 
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 4d8d1759775ae..5187705bd0f39 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -863,7 +863,7 @@ dcssblk_submit_bio(struct bio *bio)
 	unsigned long source_addr;
 	unsigned long bytes_done;
 
-	blk_queue_split(&bio);
+	bio = bio_split_to_limits(bio);
 
 	bytes_done = 0;
 	dev_info = bio->bi_bdev->bd_disk->private_data;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d04bdf549efa9..5eef8d2eddc1c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -864,9 +864,9 @@ void blk_request_module(dev_t devt);
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 void submit_bio_noacct(struct bio *bio);
+struct bio *bio_split_to_limits(struct bio *bio);
 
 extern int blk_lld_busy(struct request_queue *q);
-extern void blk_queue_split(struct bio **);
 extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);
 extern void blk_queue_exit(struct request_queue *q);
 extern void blk_sync_queue(struct request_queue *q);
-- 
2.30.2

