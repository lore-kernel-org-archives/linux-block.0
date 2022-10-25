Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D57DFA3740
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 19:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiJYTS2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiJYTSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 15:18:09 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457DFD7E39
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 12:18:08 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso8378356pjg.5
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 12:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6E1Dkvre7IAeczJ6otkEuA9GseH5waLrf8HQ2jKfCE=;
        b=jm24yWtYGmCGdVpAlBXF924a1Ep2yu3tQa0ImwZoKLS4AF77Fm1uKT4IZuxutOQAUh
         n/DHyf3ruChQ5hWnDplK7De0k6RAOIXpe7EzLJOJHRwl32Dm2pwa0bncNa231gOOqvK7
         bjiQGhDCbvb+R1wVThTlU8J9vtx8OgTcOVgGi06Me+0sQbN9mFnp8YAOiFj4tYd6S5GJ
         efdkFRPHzQLRyeNHxNt/DpQ3L85eNGBSva6MC/fHks3GfBSsOWxb8kVM10nBcRacKxzx
         UfmX8g1VLU/hLvRPsJkjQJJ3w72RpRCLxVdgcwyDihKtiQkShICyTBLima2qBC+oPUWv
         WBKw==
X-Gm-Message-State: ACrzQf3VHll2TgJfxnwU9gL/3F6parJffSz5Ham41Do4rULP9DLBiIzL
        SCNuyNtzldxzQ115PYUthL0=
X-Google-Smtp-Source: AMsMyM7IuCqQHwTZrhErUNOi7CIACXIlMuVzISxUDUH4xBJJ7+17ONRrqfqtXyhytt1rUUnrL34dqQ==
X-Received: by 2002:a17:90b:33c3:b0:20a:ebc3:6514 with SMTP id lk3-20020a17090b33c300b0020aebc36514mr81186440pjb.147.1666725487659;
        Tue, 25 Oct 2022 12:18:07 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:58c7:bc96:4597:61cd])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902d89700b00186a8beec78sm1540737plz.52.2022.10.25.12.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 12:18:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 2/3] block: Constify most queue limits pointers
Date:   Tue, 25 Oct 2022 12:17:54 -0700
Message-Id: <20221025191755.1711437-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221025191755.1711437-1-bvanassche@acm.org>
References: <20221025191755.1711437-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Document which functions do not modify the queue limits.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-map.c      |  2 +-
 block/blk-merge.c    | 29 ++++++++++++++++-------------
 block/blk-settings.c |  6 +++---
 block/blk.h          | 11 ++++++-----
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 34735626b00f..46688e70b141 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -555,7 +555,7 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 	size_t nr_iter = iov_iter_count(iter);
 	size_t nr_segs = iter->nr_segs;
 	struct bio_vec *bvecs, *bvprvp = NULL;
-	struct queue_limits *lim = &q->limits;
+	const struct queue_limits *lim = &q->limits;
 	unsigned int nsegs = 0, bytes = 0;
 	struct bio *bio;
 	size_t i;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index ff04e9290715..58fdc3f8905b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -100,13 +100,14 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
  * is defined as 'unsigned int', meantime it has to be aligned to with the
  * logical block size, which is the minimum accepted unit by hardware.
  */
-static unsigned int bio_allowed_max_sectors(struct queue_limits *lim)
+static unsigned int bio_allowed_max_sectors(const struct queue_limits *lim)
 {
 	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
 }
 
-static struct bio *bio_split_discard(struct bio *bio, struct queue_limits *lim,
-		unsigned *nsegs, struct bio_set *bs)
+static struct bio *bio_split_discard(struct bio *bio,
+				     const struct queue_limits *lim,
+				     unsigned *nsegs, struct bio_set *bs)
 {
 	unsigned int max_discard_sectors, granularity;
 	sector_t tmp;
@@ -146,7 +147,8 @@ static struct bio *bio_split_discard(struct bio *bio, struct queue_limits *lim,
 }
 
 static struct bio *bio_split_write_zeroes(struct bio *bio,
-		struct queue_limits *lim, unsigned *nsegs, struct bio_set *bs)
+					  const struct queue_limits *lim,
+					  unsigned *nsegs, struct bio_set *bs)
 {
 	*nsegs = 0;
 	if (!lim->max_write_zeroes_sectors)
@@ -165,7 +167,7 @@ static struct bio *bio_split_write_zeroes(struct bio *bio,
  * aligned to a physical block boundary.
  */
 static inline unsigned get_max_io_size(struct bio *bio,
-		struct queue_limits *lim)
+				       const struct queue_limits *lim)
 {
 	unsigned pbs = lim->physical_block_size >> SECTOR_SHIFT;
 	unsigned lbs = lim->logical_block_size >> SECTOR_SHIFT;
@@ -184,7 +186,7 @@ static inline unsigned get_max_io_size(struct bio *bio,
 	return max_sectors & ~(lbs - 1);
 }
 
-static inline unsigned get_max_segment_size(struct queue_limits *lim,
+static inline unsigned get_max_segment_size(const struct queue_limits *lim,
 		struct page *start_page, unsigned long offset)
 {
 	unsigned long mask = lim->seg_boundary_mask;
@@ -219,9 +221,9 @@ static inline unsigned get_max_segment_size(struct queue_limits *lim,
  * *@nsegs segments and *@sectors sectors would make that bio unacceptable for
  * the block driver.
  */
-static bool bvec_split_segs(struct queue_limits *lim, const struct bio_vec *bv,
-		unsigned *nsegs, unsigned *bytes, unsigned max_segs,
-		unsigned max_bytes)
+static bool bvec_split_segs(const struct queue_limits *lim,
+		const struct bio_vec *bv, unsigned *nsegs, unsigned *bytes,
+		unsigned max_segs, unsigned max_bytes)
 {
 	unsigned max_len = min(max_bytes, UINT_MAX) - *bytes;
 	unsigned len = min(bv->bv_len, max_len);
@@ -267,7 +269,7 @@ static bool bvec_split_segs(struct queue_limits *lim, const struct bio_vec *bv,
  * responsible for ensuring that @bs is only destroyed after processing of the
  * split bio has finished.
  */
-static struct bio *bio_split_rw(struct bio *bio, struct queue_limits *lim,
+static struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 		unsigned *segs, struct bio_set *bs, unsigned max_bytes)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
@@ -331,8 +333,9 @@ static struct bio *bio_split_rw(struct bio *bio, struct queue_limits *lim,
  * The split bio is allocated from @q->bio_split, which is provided by the
  * block layer.
  */
-struct bio *__bio_split_to_limits(struct bio *bio, struct queue_limits *lim,
-		       unsigned int *nr_segs)
+struct bio *__bio_split_to_limits(struct bio *bio,
+				  const struct queue_limits *lim,
+				  unsigned int *nr_segs)
 {
 	struct bio_set *bs = &bio->bi_bdev->bd_disk->bio_split;
 	struct bio *split;
@@ -377,7 +380,7 @@ struct bio *__bio_split_to_limits(struct bio *bio, struct queue_limits *lim,
  */
 struct bio *bio_split_to_limits(struct bio *bio)
 {
-	struct queue_limits *lim = &bdev_get_queue(bio->bi_bdev)->limits;
+	const struct queue_limits *lim = &bdev_get_queue(bio->bi_bdev)->limits;
 	unsigned int nr_segs;
 
 	if (bio_may_exceed_limits(bio, lim))
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8bb9eef5310e..1cba5c2a2796 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -481,7 +481,7 @@ void blk_queue_io_opt(struct request_queue *q, unsigned int opt)
 }
 EXPORT_SYMBOL(blk_queue_io_opt);
 
-static int queue_limit_alignment_offset(struct queue_limits *lim,
+static int queue_limit_alignment_offset(const struct queue_limits *lim,
 		sector_t sector)
 {
 	unsigned int granularity = max(lim->physical_block_size, lim->io_min);
@@ -491,8 +491,8 @@ static int queue_limit_alignment_offset(struct queue_limits *lim,
 	return (granularity + lim->alignment_offset - alignment) % granularity;
 }
 
-static unsigned int queue_limit_discard_alignment(struct queue_limits *lim,
-		sector_t sector)
+static unsigned int queue_limit_discard_alignment(
+		const struct queue_limits *lim, sector_t sector)
 {
 	unsigned int alignment, granularity, offset;
 
diff --git a/block/blk.h b/block/blk.h
index d6ea0d1a6db0..7f9e089ab1f7 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -104,7 +104,7 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 	return true;
 }
 
-static inline bool __bvec_gap_to_prev(struct queue_limits *lim,
+static inline bool __bvec_gap_to_prev(const struct queue_limits *lim,
 		struct bio_vec *bprv, unsigned int offset)
 {
 	return (offset & lim->virt_boundary_mask) ||
@@ -115,7 +115,7 @@ static inline bool __bvec_gap_to_prev(struct queue_limits *lim,
  * Check if adding a bio_vec after bprv with offset would create a gap in
  * the SG list. Most drivers don't care about this, but some do.
  */
-static inline bool bvec_gap_to_prev(struct queue_limits *lim,
+static inline bool bvec_gap_to_prev(const struct queue_limits *lim,
 		struct bio_vec *bprv, unsigned int offset)
 {
 	if (!lim->virt_boundary_mask)
@@ -297,7 +297,7 @@ ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
 
 static inline bool bio_may_exceed_limits(struct bio *bio,
-		struct queue_limits *lim)
+					 const struct queue_limits *lim)
 {
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
@@ -320,8 +320,9 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
 		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
 }
 
-struct bio *__bio_split_to_limits(struct bio *bio, struct queue_limits *lim,
-		       unsigned int *nr_segs);
+struct bio *__bio_split_to_limits(struct bio *bio,
+				  const struct queue_limits *lim,
+				  unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
