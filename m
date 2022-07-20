Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB74C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 14:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiGTOZP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiGTOZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 10:25:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F083D60E7
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mfIijykLsZbROtDyUzJPnF54G2AXQ1KtVO+B8TaubGI=; b=iSayGtnxJ+Ywg1Thbs42XOm2cb
        ZkzFg8sZ11gJjbQn/Z59ZX78loDrXwHXvakFvy4hfP5fG7rE4fUEfKQryM9aV3/p4quRJ2VTVt9nI
        ZGFTHu3o+hOe6djRoFVbqvnjhqgUGkeJUvwPNgFaflvkOFVON/INssDev6oYmPfasb6B5H+ZgwKJV
        ptsovP7bWxmP8YXypi/y/Wtc9giAKAwRHdek/PO7SZJAQwUwBtrb38dxZbQmbrho/XFst570X0DGN
        yco1xeXD+51Gh52Lk0GPqTn6estMbmHVIl2uGyNefDyJaspjwb/WsLkPA43q4GSt/aZta99Boinmt
        2/sIZbJw==;
Received: from [2001:4bb8:18a:6f7a:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEAdU-006nm1-2Y; Wed, 20 Jul 2022 14:25:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 5/5] block: pass struct queue_limits to the bio splitting helpers
Date:   Wed, 20 Jul 2022 16:24:56 +0200
Message-Id: <20220720142456.1414262-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720142456.1414262-1-hch@lst.de>
References: <20220720142456.1414262-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow using the splitting helpers on just a queue_limits instead of
a full request_queue structure.  This will eventuall allow file systems
or remapping drivers to split REQ_OP_ZONE_APPEND bios based on limits
calculated as the minimum common capabilities over multiple devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c |   2 +-
 block/bio.c           |   2 +-
 block/blk-merge.c     | 111 +++++++++++++++++++-----------------------
 block/blk-mq.c        |   4 +-
 block/blk.h           |  24 ++++-----
 5 files changed, 68 insertions(+), 75 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 32929c89ba8a6..3f5685c00e360 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -134,7 +134,7 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 	iv = bip->bip_vec + bip->bip_vcnt;
 
 	if (bip->bip_vcnt &&
-	    bvec_gap_to_prev(bdev_get_queue(bio->bi_bdev),
+	    bvec_gap_to_prev(&bdev_get_queue(bio->bi_bdev)->limits,
 			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
 		return 0;
 
diff --git a/block/bio.c b/block/bio.c
index 6f9f883f9a65a..0d866d44ce533 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -965,7 +965,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		 * would create a gap, disallow it.
 		 */
 		bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
-		if (bvec_gap_to_prev(q, bvec, offset))
+		if (bvec_gap_to_prev(&q->limits, bvec, offset))
 			return 0;
 	}
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 9593a8a617292..d8c99cc4ef362 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -82,7 +82,7 @@ static inline bool bio_will_gap(struct request_queue *q,
 	bio_get_first_bvec(next, &nb);
 	if (biovec_phys_mergeable(q, &pb, &nb))
 		return false;
-	return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
+	return __bvec_gap_to_prev(&q->limits, &pb, nb.bv_offset);
 }
 
 static inline bool req_gap_back_merge(struct request *req, struct bio *bio)
@@ -100,28 +100,25 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
  * is defined as 'unsigned int', meantime it has to aligned to with logical
  * block size which is the minimum accepted unit by hardware.
  */
-static unsigned int bio_allowed_max_sectors(struct request_queue *q)
+static unsigned int bio_allowed_max_sectors(struct queue_limits *lim)
 {
-	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
+	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
 }
 
-static struct bio *blk_bio_discard_split(struct request_queue *q,
-					 struct bio *bio,
-					 struct bio_set *bs,
-					 unsigned *nsegs)
+static struct bio *blk_bio_discard_split(struct queue_limits *lim,
+		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
 {
 	unsigned int max_discard_sectors, granularity;
-	int alignment;
 	sector_t tmp;
 	unsigned split_sectors;
 
 	*nsegs = 1;
 
 	/* Zero-sector (unknown) and one-sector granularities are the same.  */
-	granularity = max(q->limits.discard_granularity >> 9, 1U);
+	granularity = max(lim->discard_granularity >> 9, 1U);
 
-	max_discard_sectors = min(q->limits.max_discard_sectors,
-			bio_allowed_max_sectors(q));
+	max_discard_sectors =
+		min(lim->max_discard_sectors, bio_allowed_max_sectors(lim));
 	max_discard_sectors -= max_discard_sectors % granularity;
 
 	if (unlikely(!max_discard_sectors)) {
@@ -138,9 +135,8 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 	 * If the next starting sector would be misaligned, stop the discard at
 	 * the previous aligned sector.
 	 */
-	alignment = (q->limits.discard_alignment >> 9) % granularity;
-
-	tmp = bio->bi_iter.bi_sector + split_sectors - alignment;
+	tmp = bio->bi_iter.bi_sector + split_sectors -
+		((lim->discard_alignment >> 9) % granularity);
 	tmp = sector_div(tmp, granularity);
 
 	if (split_sectors > tmp)
@@ -149,18 +145,15 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 	return bio_split(bio, split_sectors, GFP_NOIO, bs);
 }
 
-static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
+static struct bio *blk_bio_write_zeroes_split(struct queue_limits *lim,
 		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
 {
 	*nsegs = 0;
-
-	if (!q->limits.max_write_zeroes_sectors)
+	if (!lim->max_write_zeroes_sectors)
 		return NULL;
-
-	if (bio_sectors(bio) <= q->limits.max_write_zeroes_sectors)
+	if (bio_sectors(bio) <= lim->max_write_zeroes_sectors)
 		return NULL;
-
-	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
+	return bio_split(bio, lim->max_write_zeroes_sectors, GFP_NOIO, bs);
 }
 
 /*
@@ -171,17 +164,17 @@ static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
  * requests that are submitted to a block device if the start of a bio is not
  * aligned to a physical block boundary.
  */
-static inline unsigned get_max_io_size(struct request_queue *q,
+static inline unsigned get_max_io_size(struct queue_limits *lim,
 				       struct bio *bio)
 {
-	unsigned pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
-	unsigned lbs = queue_logical_block_size(q) >> SECTOR_SHIFT;
-	unsigned max_sectors = queue_max_sectors(q), start, end;
+	unsigned pbs = lim->physical_block_size >> SECTOR_SHIFT;
+	unsigned lbs = lim->logical_block_size >> SECTOR_SHIFT;
+	unsigned max_sectors = lim->max_sectors, start, end;
 
-	if (q->limits.chunk_sectors) {
+	if (lim->chunk_sectors) {
 		max_sectors = min(max_sectors,
 			blk_chunk_sectors_left(bio->bi_iter.bi_sector,
-					       q->limits.chunk_sectors));
+					       lim->chunk_sectors));
 	}
 
 	start = bio->bi_iter.bi_sector & (pbs - 1);
@@ -191,11 +184,10 @@ static inline unsigned get_max_io_size(struct request_queue *q,
 	return max_sectors & ~(lbs - 1);
 }
 
-static inline unsigned get_max_segment_size(const struct request_queue *q,
-					    struct page *start_page,
-					    unsigned long offset)
+static inline unsigned get_max_segment_size(struct queue_limits *lim,
+		struct page *start_page, unsigned long offset)
 {
-	unsigned long mask = queue_segment_boundary(q);
+	unsigned long mask = lim->seg_boundary_mask;
 
 	offset = mask & (page_to_phys(start_page) + offset);
 
@@ -204,12 +196,12 @@ static inline unsigned get_max_segment_size(const struct request_queue *q,
 	 * on 32bit arch, use queue's max segment size when that happens.
 	 */
 	return min_not_zero(mask - offset + 1,
-			(unsigned long)queue_max_segment_size(q));
+			(unsigned long)lim->max_segment_size);
 }
 
 /**
  * bvec_split_segs - verify whether or not a bvec should be split in the middle
- * @q:        [in] request queue associated with the bio associated with @bv
+ * @lim:      [in] queue limits to split based on
  * @bv:       [in] bvec to examine
  * @nsegs:    [in,out] Number of segments in the bio being built. Incremented
  *            by the number of segments from @bv that may be appended to that
@@ -227,10 +219,9 @@ static inline unsigned get_max_segment_size(const struct request_queue *q,
  * *@nsegs segments and *@sectors sectors would make that bio unacceptable for
  * the block driver.
  */
-static bool bvec_split_segs(const struct request_queue *q,
-			    const struct bio_vec *bv, unsigned *nsegs,
-			    unsigned *bytes, unsigned max_segs,
-			    unsigned max_bytes)
+static bool bvec_split_segs(struct queue_limits *lim, const struct bio_vec *bv,
+		unsigned *nsegs, unsigned *bytes, unsigned max_segs,
+		unsigned max_bytes)
 {
 	unsigned max_len = min(max_bytes, UINT_MAX) - *bytes;
 	unsigned len = min(bv->bv_len, max_len);
@@ -238,7 +229,7 @@ static bool bvec_split_segs(const struct request_queue *q,
 	unsigned seg_size = 0;
 
 	while (len && *nsegs < max_segs) {
-		seg_size = get_max_segment_size(q, bv->bv_page,
+		seg_size = get_max_segment_size(lim, bv->bv_page,
 						bv->bv_offset + total_len);
 		seg_size = min(seg_size, len);
 
@@ -246,7 +237,7 @@ static bool bvec_split_segs(const struct request_queue *q,
 		total_len += seg_size;
 		len -= seg_size;
 
-		if ((bv->bv_offset + total_len) & queue_virt_boundary(q))
+		if ((bv->bv_offset + total_len) & lim->virt_boundary_mask)
 			break;
 	}
 
@@ -258,7 +249,7 @@ static bool bvec_split_segs(const struct request_queue *q,
 
 /**
  * blk_bio_segment_split - split a bio in two bios
- * @q:    [in] request queue pointer
+ * @lim:  [in] queue limits to split based on
  * @bio:  [in] bio to be split
  * @bs:	  [in] bio set to allocate the clone from
  * @segs: [out] number of segments in the bio with the first half of the sectors
@@ -276,31 +267,31 @@ static bool bvec_split_segs(const struct request_queue *q,
  * responsible for ensuring that @bs is only destroyed after processing of the
  * split bio has finished.
  */
-static struct bio *blk_bio_segment_split(struct request_queue *q,
+static struct bio *blk_bio_segment_split(struct queue_limits *lim,
 		struct bio *bio, struct bio_set *bs, unsigned *segs,
 		unsigned max_bytes)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
 	unsigned nsegs = 0, bytes = 0;
-	const unsigned max_segs = queue_max_segments(q);
 
 	bio_for_each_bvec(bv, bio, iter) {
 		/*
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
 		 */
-		if (bvprvp && bvec_gap_to_prev(q, bvprvp, bv.bv_offset))
+		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
 			goto split;
 
-		if (nsegs < max_segs &&
+		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <= max_bytes &&
 		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
 			nsegs++;
 			bytes += bv.bv_len;
-		} else if (bvec_split_segs(q, &bv, &nsegs, &bytes, max_segs,
-					   max_bytes)) {
-			goto split;
+		} else {
+			if (bvec_split_segs(lim, &bv, &nsegs, &bytes,
+					lim->max_segments, max_bytes))
+				goto split;
 		}
 
 		bvprv = bv;
@@ -317,7 +308,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	 * split size so that each bio is properly block size aligned, even if
 	 * we do not use the full hardware limits.
 	 */
-	bytes = ALIGN_DOWN(bytes, queue_logical_block_size(q));
+	bytes = ALIGN_DOWN(bytes, lim->logical_block_size);
 
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
@@ -330,7 +321,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 
 /**
  * __blk_queue_split - split a bio and submit the second half
- * @q:       [in] request_queue new bio is being queued at
+ * @lim:     [in] queue limits to split based on
  * @bio:     [in, out] bio to be split
  * @nr_segs: [out] number of segments in the first bio
  *
@@ -341,7 +332,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
  * responsibility of the caller to ensure that disk->bio_split is only released
  * after processing of the split bio has finished.
  */
-void __blk_queue_split(struct request_queue *q, struct bio **bio,
+void __blk_queue_split(struct queue_limits *lim, struct bio **bio,
 		       unsigned int *nr_segs)
 {
 	struct bio_set *bs = &(*bio)->bi_bdev->bd_disk->bio_split;
@@ -350,14 +341,14 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 	switch (bio_op(*bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
-		split = blk_bio_discard_split(q, *bio, bs, nr_segs);
+		split = blk_bio_discard_split(lim, *bio, bs, nr_segs);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		split = blk_bio_write_zeroes_split(q, *bio, bs, nr_segs);
+		split = blk_bio_write_zeroes_split(lim, *bio, bs, nr_segs);
 		break;
 	default:
-		split = blk_bio_segment_split(q, *bio, bs, nr_segs,
-				get_max_io_size(q, *bio) << SECTOR_SHIFT);
+		split = blk_bio_segment_split(lim, *bio, bs, nr_segs,
+				get_max_io_size(lim, *bio) << SECTOR_SHIFT);
 		break;
 	}
 
@@ -384,11 +375,11 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
  */
 void blk_queue_split(struct bio **bio)
 {
-	struct request_queue *q = bdev_get_queue((*bio)->bi_bdev);
+	struct queue_limits *lim = &bdev_get_queue((*bio)->bi_bdev)->limits;
 	unsigned int nr_segs;
 
-	if (blk_may_split(q, *bio))
-		__blk_queue_split(q, bio, &nr_segs);
+	if (blk_may_split(lim, *bio))
+		__blk_queue_split(lim, bio, &nr_segs);
 }
 EXPORT_SYMBOL(blk_queue_split);
 
@@ -420,7 +411,7 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 	}
 
 	rq_for_each_bvec(bv, rq, iter)
-		bvec_split_segs(rq->q, &bv, &nr_phys_segs, &bytes,
+		bvec_split_segs(&rq->q->limits, &bv, &nr_phys_segs, &bytes,
 				UINT_MAX, UINT_MAX);
 	return nr_phys_segs;
 }
@@ -451,8 +442,8 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
 
 	while (nbytes > 0) {
 		unsigned offset = bvec->bv_offset + total;
-		unsigned len = min(get_max_segment_size(q, bvec->bv_page,
-					offset), nbytes);
+		unsigned len = min(get_max_segment_size(&q->limits,
+				   bvec->bv_page, offset), nbytes);
 		struct page *page = bvec->bv_page;
 
 		/*
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d716b7f3763f3..bd7a14911d5ac 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2816,8 +2816,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	blk_status_t ret;
 
 	blk_queue_bounce(q, &bio);
-	if (blk_may_split(q, bio))
-		__blk_queue_split(q, &bio, &nr_segs);
+	if (blk_may_split(&q->limits, bio))
+		__blk_queue_split(&q->limits, &bio, &nr_segs);
 
 	if (!bio_integrity_prep(bio))
 		return;
diff --git a/block/blk.h b/block/blk.h
index 3026ba81c85f0..94576404953f8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -102,23 +102,23 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 	return true;
 }
 
-static inline bool __bvec_gap_to_prev(struct request_queue *q,
+static inline bool __bvec_gap_to_prev(struct queue_limits *lim,
 		struct bio_vec *bprv, unsigned int offset)
 {
-	return (offset & queue_virt_boundary(q)) ||
-		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
+	return (offset & lim->virt_boundary_mask) ||
+		((bprv->bv_offset + bprv->bv_len) & lim->virt_boundary_mask);
 }
 
 /*
  * Check if adding a bio_vec after bprv with offset would create a gap in
  * the SG list. Most drivers don't care about this, but some do.
  */
-static inline bool bvec_gap_to_prev(struct request_queue *q,
+static inline bool bvec_gap_to_prev(struct queue_limits *lim,
 		struct bio_vec *bprv, unsigned int offset)
 {
-	if (!queue_virt_boundary(q))
+	if (!lim->virt_boundary_mask)
 		return false;
-	return __bvec_gap_to_prev(q, bprv, offset);
+	return __bvec_gap_to_prev(lim, bprv, offset);
 }
 
 static inline bool rq_mergeable(struct request *rq)
@@ -194,7 +194,8 @@ static inline bool integrity_req_gap_back_merge(struct request *req,
 	struct bio_integrity_payload *bip = bio_integrity(req->bio);
 	struct bio_integrity_payload *bip_next = bio_integrity(next);
 
-	return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
+	return bvec_gap_to_prev(&req->q->limits,
+				&bip->bip_vec[bip->bip_vcnt - 1],
 				bip_next->bip_vec[0].bv_offset);
 }
 
@@ -204,7 +205,8 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct bio_integrity_payload *bip_next = bio_integrity(req->bio);
 
-	return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
+	return bvec_gap_to_prev(&req->q->limits,
+				&bip->bip_vec[bip->bip_vcnt - 1],
 				bip_next->bip_vec[0].bv_offset);
 }
 
@@ -293,7 +295,7 @@ ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
 ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
 
-static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
+static inline bool blk_may_split(struct queue_limits *lim, struct bio *bio)
 {
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
@@ -312,11 +314,11 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
 	 * to the performance impact of cloned bios themselves the loop below
 	 * doesn't matter anyway.
 	 */
-	return q->limits.chunk_sectors || bio->bi_vcnt != 1 ||
+	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
 		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
 }
 
-void __blk_queue_split(struct request_queue *q, struct bio **bio,
+void __blk_queue_split(struct queue_limits *lim, struct bio **bio,
 			unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
-- 
2.30.2

