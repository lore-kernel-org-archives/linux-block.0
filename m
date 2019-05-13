Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03A8C04AB1
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4BE20879
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B9WoMLhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfEMGi6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 02:38:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfEMGi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 02:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PRsSu0QIfJ2u60RA6gD6KXDLNGrqA5Va1mXvlG5llMw=; b=B9WoMLhr66YdSCgls0EVSq2Jad
        /jq5o8tjF14KB5OYGuVMY5nxhOiw2ETNZWGHvAqVrHxxJ9gTp8CFfw8CNNynsoJnu1wTSkyC7mIkm
        Qys6CvbJ4Pvkp4QuajhVwg9REApKYOjIcM7RkPoHOzaSyCynAv7aw8OT9x0xlhYsL4PxSiQIzC9ju
        5eGyIaX8y/4Ocz9k7S9tCGIKsXNuYqMZOGRJZKfac3xn3TZ8JkvuaYII6EhxlVXtUV/iIbJ5wJFyG
        pMFsWGrCP/alpUiObEzIZAhfpHszdrT+xisMzTNJAiW5srkLxe1eNLp0DweQK1Wv/qyUcmxyVR5PO
        fFOny1Wg==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ4bv-0007Qj-A8; Mon, 13 May 2019 06:38:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: [PATCH 07/10] block: remove the bi_phys_segments field in struct bio
Date:   Mon, 13 May 2019 08:37:51 +0200
Message-Id: <20190513063754.1520-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513063754.1520-1-hch@lst.de>
References: <20190513063754.1520-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We only need the number of segments in the blk-mq submission path.
Remove the field from struct bio, and return it from a variant of
blk_queue_split instead of that it can passed as an argument to
those functions that need the value.

This also means we stop recounting segments except for cloning
and partial segments.

To keep the number of arguments in this how path down remove
pointless struct request_queue arguments from any of the functions
that had it and grew a nr_segs argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/block/biodoc.txt |  1 -
 block/bfq-iosched.c            |  5 ++-
 block/bio.c                    | 15 +------
 block/blk-core.c               | 32 +++++++--------
 block/blk-map.c                | 10 ++++-
 block/blk-merge.c              | 75 ++++++++++++----------------------
 block/blk-mq-sched.c           | 26 +++++++-----
 block/blk-mq-sched.h           | 10 +++--
 block/blk-mq.c                 | 23 ++++++-----
 block/blk.h                    | 23 ++++++-----
 block/kyber-iosched.c          |  5 ++-
 block/mq-deadline.c            |  5 ++-
 drivers/md/raid5.c             |  1 -
 include/linux/bio.h            |  1 -
 include/linux/blk-mq.h         |  2 +-
 include/linux/blk_types.h      |  6 ---
 include/linux/blkdev.h         |  1 -
 include/linux/elevator.h       |  2 +-
 18 files changed, 106 insertions(+), 137 deletions(-)

diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
index ac18b488cb5e..31c177663ed5 100644
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.txt
@@ -436,7 +436,6 @@ struct bio {
        struct bvec_iter	bi_iter;	/* current index into bio_vec array */
 
        unsigned int	bi_size;     /* total size in bytes */
-       unsigned short 	bi_phys_segments; /* segments after physaddr coalesce*/
        unsigned short	bi_hw_segments; /* segments after DMA remapping */
        unsigned int	bi_max;	     /* max bio_vecs we can hold
                                         used as index into pool */
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f8d430f88d25..a6bf842cbe16 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2027,7 +2027,8 @@ static void bfq_remove_request(struct request_queue *q,
 
 }
 
-static bool bfq_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
+static bool bfq_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio,
+		unsigned int nr_segs)
 {
 	struct request_queue *q = hctx->queue;
 	struct bfq_data *bfqd = q->elevator->elevator_data;
@@ -2050,7 +2051,7 @@ static bool bfq_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
 		bfqd->bio_bfqq = NULL;
 	bfqd->bio_bic = bic;
 
-	ret = blk_mq_sched_try_merge(q, bio, &free);
+	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
 
 	if (free)
 		blk_mq_free_request(free);
diff --git a/block/bio.c b/block/bio.c
index 683cbb40f051..d550d36392e9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -558,14 +558,6 @@ void bio_put(struct bio *bio)
 }
 EXPORT_SYMBOL(bio_put);
 
-int bio_phys_segments(struct request_queue *q, struct bio *bio)
-{
-	if (unlikely(!bio_flagged(bio, BIO_SEG_VALID)))
-		blk_recount_segments(q, bio);
-
-	return bio->bi_phys_segments;
-}
-
 /**
  * 	__bio_clone_fast - clone a bio that shares the original bio's biovec
  * 	@bio: destination bio
@@ -739,7 +731,7 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	if (bio_full(bio))
 		return 0;
 
-	if (bio->bi_phys_segments >= queue_max_segments(q))
+	if (bio->bi_vcnt >= queue_max_segments(q))
 		return 0;
 
 	bvec = &bio->bi_io_vec[bio->bi_vcnt];
@@ -749,8 +741,6 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	bio->bi_vcnt++;
  done:
 	bio->bi_iter.bi_size += len;
-	bio->bi_phys_segments = bio->bi_vcnt;
-	bio_set_flag(bio, BIO_SEG_VALID);
 	return len;
 }
 
@@ -1910,10 +1900,7 @@ void bio_trim(struct bio *bio, int offset, int size)
 	if (offset == 0 && size == bio->bi_iter.bi_size)
 		return;
 
-	bio_clear_flag(bio, BIO_SEG_VALID);
-
 	bio_advance(bio, offset << 9);
-
 	bio->bi_iter.bi_size = size;
 
 	if (bio_integrity(bio))
diff --git a/block/blk-core.c b/block/blk-core.c
index b46ea531cb07..84118411626c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -573,15 +573,15 @@ void blk_put_request(struct request *req)
 }
 EXPORT_SYMBOL(blk_put_request);
 
-bool bio_attempt_back_merge(struct request_queue *q, struct request *req,
-			    struct bio *bio)
+bool bio_attempt_back_merge(struct request *req, struct bio *bio,
+		unsigned int nr_segs)
 {
 	const int ff = bio->bi_opf & REQ_FAILFAST_MASK;
 
-	if (!ll_back_merge_fn(q, req, bio))
+	if (!ll_back_merge_fn(req, bio, nr_segs))
 		return false;
 
-	trace_block_bio_backmerge(q, req, bio);
+	trace_block_bio_backmerge(req->q, req, bio);
 
 	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
 		blk_rq_set_mixed_merge(req);
@@ -594,15 +594,15 @@ bool bio_attempt_back_merge(struct request_queue *q, struct request *req,
 	return true;
 }
 
-bool bio_attempt_front_merge(struct request_queue *q, struct request *req,
-			     struct bio *bio)
+bool bio_attempt_front_merge(struct request *req, struct bio *bio,
+		unsigned int nr_segs)
 {
 	const int ff = bio->bi_opf & REQ_FAILFAST_MASK;
 
-	if (!ll_front_merge_fn(q, req, bio))
+	if (!ll_front_merge_fn(req, bio, nr_segs))
 		return false;
 
-	trace_block_bio_frontmerge(q, req, bio);
+	trace_block_bio_frontmerge(req->q, req, bio);
 
 	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
 		blk_rq_set_mixed_merge(req);
@@ -644,6 +644,7 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
  * blk_attempt_plug_merge - try to merge with %current's plugged list
  * @q: request_queue new bio is being queued at
  * @bio: new bio being queued
+ * @nr_segs: number of segments in @bio
  * @same_queue_rq: pointer to &struct request that gets filled in when
  * another request associated with @q is found on the plug list
  * (optional, may be %NULL)
@@ -662,7 +663,7 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
  * Caller must ensure !blk_queue_nomerges(q) beforehand.
  */
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-			    struct request **same_queue_rq)
+		unsigned int nr_segs, struct request **same_queue_rq)
 {
 	struct blk_plug *plug;
 	struct request *rq;
@@ -691,10 +692,10 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 
 		switch (blk_try_merge(rq, bio)) {
 		case ELEVATOR_BACK_MERGE:
-			merged = bio_attempt_back_merge(q, rq, bio);
+			merged = bio_attempt_back_merge(rq, bio, nr_segs);
 			break;
 		case ELEVATOR_FRONT_MERGE:
-			merged = bio_attempt_front_merge(q, rq, bio);
+			merged = bio_attempt_front_merge(rq, bio, nr_segs);
 			break;
 		case ELEVATOR_DISCARD_MERGE:
 			merged = bio_attempt_discard_merge(q, rq, bio);
@@ -1472,14 +1473,9 @@ bool blk_update_request(struct request *req, blk_status_t error,
 }
 EXPORT_SYMBOL_GPL(blk_update_request);
 
-void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
-		     struct bio *bio)
+void blk_rq_bio_prep(struct request *rq, struct bio *bio, unsigned int nr_segs)
 {
-	if (bio_has_data(bio))
-		rq->nr_phys_segments = bio_phys_segments(q, bio);
-	else if (bio_op(bio) == REQ_OP_DISCARD)
-		rq->nr_phys_segments = 1;
-
+	rq->nr_phys_segments = nr_segs;
 	rq->__data_len = bio->bi_iter.bi_size;
 	rq->bio = rq->biotail = bio;
 	rq->ioprio = bio_prio(bio);
diff --git a/block/blk-map.c b/block/blk-map.c
index db9373bd31ac..3a62e471d81b 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -18,13 +18,19 @@
 int blk_rq_append_bio(struct request *rq, struct bio **bio)
 {
 	struct bio *orig_bio = *bio;
+	struct bvec_iter iter;
+	struct bio_vec bv;
+	unsigned int nr_segs = 0;
 
 	blk_queue_bounce(rq->q, bio);
 
+	bio_for_each_bvec(bv, *bio, iter)
+		nr_segs++;
+
 	if (!rq->bio) {
-		blk_rq_bio_prep(rq->q, rq, *bio);
+		blk_rq_bio_prep(rq, *bio, nr_segs);
 	} else {
-		if (!ll_back_merge_fn(rq->q, rq, *bio)) {
+		if (!ll_back_merge_fn(rq, *bio, nr_segs)) {
 			if (orig_bio != *bio) {
 				bio_put(*bio);
 				*bio = orig_bio;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 17713d7d98d5..72b4fd89a22d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -258,32 +258,29 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return do_split ? new : NULL;
 }
 
-void blk_queue_split(struct request_queue *q, struct bio **bio)
+void __blk_queue_split(struct request_queue *q, struct bio **bio,
+		unsigned int *nr_segs)
 {
-	struct bio *split, *res;
-	unsigned nsegs;
+	struct bio *split;
 
 	switch (bio_op(*bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
-		split = blk_bio_discard_split(q, *bio, &q->bio_split, &nsegs);
+		split = blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split, &nsegs);
+		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
+				nr_segs);
 		break;
 	case REQ_OP_WRITE_SAME:
-		split = blk_bio_write_same_split(q, *bio, &q->bio_split, &nsegs);
+		split = blk_bio_write_same_split(q, *bio, &q->bio_split,
+				nr_segs);
 		break;
 	default:
-		split = blk_bio_segment_split(q, *bio, &q->bio_split, &nsegs);
+		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
 		break;
 	}
 
-	/* physical segments can be figured out during splitting */
-	res = split ? split : *bio;
-	res->bi_phys_segments = nsegs;
-	bio_set_flag(res, BIO_SEG_VALID);
-
 	if (split) {
 		/* there isn't chance to merge the splitted bio */
 		split->bi_opf |= REQ_NOMERGE;
@@ -304,6 +301,13 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
 		*bio = split;
 	}
 }
+
+void blk_queue_split(struct request_queue *q, struct bio **bio)
+{
+	unsigned int nr_segs;
+
+	__blk_queue_split(q, bio, &nr_segs);
+}
 EXPORT_SYMBOL(blk_queue_split);
 
 static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
@@ -338,17 +342,6 @@ void blk_recalc_rq_segments(struct request *rq)
 	rq->nr_phys_segments = __blk_recalc_rq_segments(rq->q, rq->bio);
 }
 
-void blk_recount_segments(struct request_queue *q, struct bio *bio)
-{
-	struct bio *nxt = bio->bi_next;
-
-	bio->bi_next = NULL;
-	bio->bi_phys_segments = __blk_recalc_rq_segments(q, bio);
-	bio->bi_next = nxt;
-
-	bio_set_flag(bio, BIO_SEG_VALID);
-}
-
 static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
 		struct scatterlist *sglist)
 {
@@ -519,16 +512,13 @@ int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(blk_rq_map_sg);
 
-static inline int ll_new_hw_segment(struct request_queue *q,
-				    struct request *req,
-				    struct bio *bio)
+static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
+		unsigned int nr_phys_segs)
 {
-	int nr_phys_segs = bio_phys_segments(q, bio);
-
-	if (req->nr_phys_segments + nr_phys_segs > queue_max_segments(q))
+	if (req->nr_phys_segments + nr_phys_segs > queue_max_segments(req->q))
 		goto no_merge;
 
-	if (blk_integrity_merge_bio(q, req, bio) == false)
+	if (blk_integrity_merge_bio(req->q, req, bio) == false)
 		goto no_merge;
 
 	/*
@@ -539,12 +529,11 @@ static inline int ll_new_hw_segment(struct request_queue *q,
 	return 1;
 
 no_merge:
-	req_set_nomerge(q, req);
+	req_set_nomerge(req->q, req);
 	return 0;
 }
 
-int ll_back_merge_fn(struct request_queue *q, struct request *req,
-		     struct bio *bio)
+int ll_back_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs)
 {
 	if (req_gap_back_merge(req, bio))
 		return 0;
@@ -553,21 +542,15 @@ int ll_back_merge_fn(struct request_queue *q, struct request *req,
 		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req, blk_rq_pos(req))) {
-		req_set_nomerge(q, req);
+		req_set_nomerge(req->q, req);
 		return 0;
 	}
-	if (!bio_flagged(req->biotail, BIO_SEG_VALID))
-		blk_recount_segments(q, req->biotail);
-	if (!bio_flagged(bio, BIO_SEG_VALID))
-		blk_recount_segments(q, bio);
 
-	return ll_new_hw_segment(q, req, bio);
+	return ll_new_hw_segment(req, bio, nr_segs);
 }
 
-int ll_front_merge_fn(struct request_queue *q, struct request *req,
-		      struct bio *bio)
+int ll_front_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs)
 {
-
 	if (req_gap_front_merge(req, bio))
 		return 0;
 	if (blk_integrity_rq(req) &&
@@ -575,15 +558,11 @@ int ll_front_merge_fn(struct request_queue *q, struct request *req,
 		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req, bio->bi_iter.bi_sector)) {
-		req_set_nomerge(q, req);
+		req_set_nomerge(req->q, req);
 		return 0;
 	}
-	if (!bio_flagged(bio, BIO_SEG_VALID))
-		blk_recount_segments(q, bio);
-	if (!bio_flagged(req->bio, BIO_SEG_VALID))
-		blk_recount_segments(q, req->bio);
 
-	return ll_new_hw_segment(q, req, bio);
+	return ll_new_hw_segment(req, bio, nr_segs);
 }
 
 static bool req_attempt_discard_merge(struct request_queue *q, struct request *req,
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 74c6bb871f7e..72124d76b96a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -224,7 +224,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 }
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
-			    struct request **merged_request)
+		unsigned int nr_segs, struct request **merged_request)
 {
 	struct request *rq;
 
@@ -232,7 +232,7 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 	case ELEVATOR_BACK_MERGE:
 		if (!blk_mq_sched_allow_merge(q, rq, bio))
 			return false;
-		if (!bio_attempt_back_merge(q, rq, bio))
+		if (!bio_attempt_back_merge(rq, bio, nr_segs))
 			return false;
 		*merged_request = attempt_back_merge(q, rq);
 		if (!*merged_request)
@@ -241,7 +241,7 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 	case ELEVATOR_FRONT_MERGE:
 		if (!blk_mq_sched_allow_merge(q, rq, bio))
 			return false;
-		if (!bio_attempt_front_merge(q, rq, bio))
+		if (!bio_attempt_front_merge(rq, bio, nr_segs))
 			return false;
 		*merged_request = attempt_front_merge(q, rq);
 		if (!*merged_request)
@@ -260,7 +260,7 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
  * of them.
  */
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
-			   struct bio *bio)
+			   struct bio *bio, unsigned int nr_segs)
 {
 	struct request *rq;
 	int checked = 8;
@@ -277,11 +277,13 @@ bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 		switch (blk_try_merge(rq, bio)) {
 		case ELEVATOR_BACK_MERGE:
 			if (blk_mq_sched_allow_merge(q, rq, bio))
-				merged = bio_attempt_back_merge(q, rq, bio);
+				merged = bio_attempt_back_merge(rq, bio,
+						nr_segs);
 			break;
 		case ELEVATOR_FRONT_MERGE:
 			if (blk_mq_sched_allow_merge(q, rq, bio))
-				merged = bio_attempt_front_merge(q, rq, bio);
+				merged = bio_attempt_front_merge(rq, bio,
+						nr_segs);
 			break;
 		case ELEVATOR_DISCARD_MERGE:
 			merged = bio_attempt_discard_merge(q, rq, bio);
@@ -304,13 +306,14 @@ EXPORT_SYMBOL_GPL(blk_mq_bio_list_merge);
  */
 static bool blk_mq_attempt_merge(struct request_queue *q,
 				 struct blk_mq_hw_ctx *hctx,
-				 struct blk_mq_ctx *ctx, struct bio *bio)
+				 struct blk_mq_ctx *ctx, struct bio *bio,
+				 unsigned int nr_segs)
 {
 	enum hctx_type type = hctx->type;
 
 	lockdep_assert_held(&ctx->lock);
 
-	if (blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio)) {
+	if (blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
 		ctx->rq_merged++;
 		return true;
 	}
@@ -318,7 +321,8 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 	return false;
 }
 
-bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
+bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
+		unsigned int nr_segs)
 {
 	struct elevator_queue *e = q->elevator;
 	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
@@ -328,7 +332,7 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 
 	if (e && e->type->ops.bio_merge) {
 		blk_mq_put_ctx(ctx);
-		return e->type->ops.bio_merge(hctx, bio);
+		return e->type->ops.bio_merge(hctx, bio, nr_segs);
 	}
 
 	type = hctx->type;
@@ -336,7 +340,7 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 			!list_empty_careful(&ctx->rq_lists[type])) {
 		/* default per sw-queue merge */
 		spin_lock(&ctx->lock);
-		ret = blk_mq_attempt_merge(q, hctx, ctx, bio);
+		ret = blk_mq_attempt_merge(q, hctx, ctx, bio, nr_segs);
 		spin_unlock(&ctx->lock);
 	}
 
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index c7bdb52367ac..a1e5850ffb1d 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -12,8 +12,9 @@ void blk_mq_sched_assign_ioc(struct request *rq);
 
 void blk_mq_sched_request_inserted(struct request *rq);
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
-				struct request **merged_request);
-bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio);
+		unsigned int nr_segs, struct request **merged_request);
+bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
+		unsigned int nr_segs);
 bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq);
 void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
 void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
@@ -30,12 +31,13 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 
 static inline bool
-blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
+blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
+		unsigned int nr_segs)
 {
 	if (blk_queue_nomerges(q) || !bio_mergeable(bio))
 		return false;
 
-	return __blk_mq_sched_bio_merge(q, bio);
+	return __blk_mq_sched_bio_merge(q, bio, nr_segs);
 }
 
 static inline bool
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c0e5132d9103..dbb58c50654b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1763,14 +1763,15 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	}
 }
 
-static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
+static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
+		unsigned int nr_segs)
 {
 	if (bio->bi_opf & REQ_RAHEAD)
 		rq->cmd_flags |= REQ_FAILFAST_MASK;
 
 	rq->__sector = bio->bi_iter.bi_sector;
 	rq->write_hint = bio->bi_write_hint;
-	blk_rq_bio_prep(rq->q, rq, bio);
+	blk_rq_bio_prep(rq, bio, nr_segs);
 
 	blk_account_io_start(rq, true);
 }
@@ -1940,20 +1941,20 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	struct request *rq;
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
+	unsigned int nr_segs;
 	blk_qc_t cookie;
 
 	blk_queue_bounce(q, &bio);
-
-	blk_queue_split(q, &bio);
+	__blk_queue_split(q, &bio, &nr_segs);
 
 	if (!bio_integrity_prep(bio))
 		return BLK_QC_T_NONE;
 
 	if (!is_flush_fua && !blk_queue_nomerges(q) &&
-	    blk_attempt_plug_merge(q, bio, &same_queue_rq))
+	    blk_attempt_plug_merge(q, bio, nr_segs, &same_queue_rq))
 		return BLK_QC_T_NONE;
 
-	if (blk_mq_sched_bio_merge(q, bio))
+	if (blk_mq_sched_bio_merge(q, bio, nr_segs))
 		return BLK_QC_T_NONE;
 
 	rq_qos_throttle(q, bio);
@@ -1976,7 +1977,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	plug = current->plug;
 	if (unlikely(is_flush_fua)) {
 		blk_mq_put_ctx(data.ctx);
-		blk_mq_bio_to_request(rq, bio);
+		blk_mq_bio_to_request(rq, bio, nr_segs);
 
 		/* bypass scheduler for flush rq */
 		blk_insert_flush(rq);
@@ -1990,7 +1991,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		struct request *last = NULL;
 
 		blk_mq_put_ctx(data.ctx);
-		blk_mq_bio_to_request(rq, bio);
+		blk_mq_bio_to_request(rq, bio, nr_segs);
 
 		if (!request_count)
 			trace_block_plug(q);
@@ -2005,7 +2006,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 		blk_add_rq_to_plug(plug, rq);
 	} else if (plug && !blk_queue_nomerges(q)) {
-		blk_mq_bio_to_request(rq, bio);
+		blk_mq_bio_to_request(rq, bio, nr_segs);
 
 		/*
 		 * We do limited plugging. If the bio can be merged, do that.
@@ -2034,11 +2035,11 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
 			!data.hctx->dispatch_busy)) {
 		blk_mq_put_ctx(data.ctx);
-		blk_mq_bio_to_request(rq, bio);
+		blk_mq_bio_to_request(rq, bio, nr_segs);
 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
 	} else {
 		blk_mq_put_ctx(data.ctx);
-		blk_mq_bio_to_request(rq, bio);
+		blk_mq_bio_to_request(rq, bio, nr_segs);
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
 
diff --git a/block/blk.h b/block/blk.h
index e27fd1512e4b..a18d0b9fe353 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -51,8 +51,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_exit_queue(struct request_queue *q);
-void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
-			struct bio *bio);
+void blk_rq_bio_prep(struct request *rq, struct bio *bio, unsigned int nr_segs);
 void blk_freeze_queue(struct request_queue *q);
 
 static inline void blk_queue_enter_live(struct request_queue *q)
@@ -154,14 +153,14 @@ static inline bool bio_integrity_endio(struct bio *bio)
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
 
-bool bio_attempt_front_merge(struct request_queue *q, struct request *req,
-			     struct bio *bio);
-bool bio_attempt_back_merge(struct request_queue *q, struct request *req,
-			    struct bio *bio);
+bool bio_attempt_front_merge(struct request *req, struct bio *bio,
+		unsigned int nr_segs);
+bool bio_attempt_back_merge(struct request *req, struct bio *bio,
+		unsigned int nr_segs);
 bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
 		struct bio *bio);
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-			    struct request **same_queue_rq);
+		unsigned int nr_segs, struct request **same_queue_rq);
 
 void blk_account_io_start(struct request *req, bool new_io);
 void blk_account_io_completion(struct request *req, unsigned int bytes);
@@ -195,10 +194,12 @@ static inline int blk_should_fake_timeout(struct request_queue *q)
 }
 #endif
 
-int ll_back_merge_fn(struct request_queue *q, struct request *req,
-		     struct bio *bio);
-int ll_front_merge_fn(struct request_queue *q, struct request *req, 
-		      struct bio *bio);
+void __blk_queue_split(struct request_queue *q, struct bio **bio,
+		unsigned int *nr_segs);
+int ll_back_merge_fn(struct request *req, struct bio *bio,
+		unsigned int nr_segs);
+int ll_front_merge_fn(struct request *req,  struct bio *bio,
+		unsigned int nr_segs);
 struct request *attempt_back_merge(struct request_queue *q, struct request *rq);
 struct request *attempt_front_merge(struct request_queue *q, struct request *rq);
 int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index c3b05119cebd..3c2602601741 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -562,7 +562,8 @@ static void kyber_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 	}
 }
 
-static bool kyber_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
+static bool kyber_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio,
+		unsigned int nr_segs)
 {
 	struct kyber_hctx_data *khd = hctx->sched_data;
 	struct blk_mq_ctx *ctx = blk_mq_get_ctx(hctx->queue);
@@ -572,7 +573,7 @@ static bool kyber_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
 	bool merged;
 
 	spin_lock(&kcq->lock);
-	merged = blk_mq_bio_list_merge(hctx->queue, rq_list, bio);
+	merged = blk_mq_bio_list_merge(hctx->queue, rq_list, bio, nr_segs);
 	spin_unlock(&kcq->lock);
 	blk_mq_put_ctx(ctx);
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1876f5712bfd..b8a682b5a1bb 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -469,7 +469,8 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 	return ELEVATOR_NO_MERGE;
 }
 
-static bool dd_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
+static bool dd_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio,
+		unsigned int nr_segs)
 {
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
@@ -477,7 +478,7 @@ static bool dd_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
 	bool ret;
 
 	spin_lock(&dd->lock);
-	ret = blk_mq_sched_try_merge(q, bio, &free);
+	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
 	spin_unlock(&dd->lock);
 
 	if (free)
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7fde645d2e90..16358fdd1850 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5259,7 +5259,6 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 		rcu_read_unlock();
 		raid_bio->bi_next = (void*)rdev;
 		bio_set_dev(align_bi, rdev->bdev);
-		bio_clear_flag(align_bi, BIO_SEG_VALID);
 
 		if (is_badblock(rdev, align_bi->bi_iter.bi_sector,
 				bio_sectors(align_bi),
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ea73df36529a..e0f3b8898a81 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -408,7 +408,6 @@ static inline void bio_wouldblock_error(struct bio *bio)
 }
 
 struct request_queue;
-extern int bio_phys_segments(struct request_queue *, struct bio *);
 
 extern int submit_bio_wait(struct bio *bio);
 extern void bio_advance(struct bio *, unsigned);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 15d1aa53d96c..3fa1fa59f9b2 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -306,7 +306,7 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs
 bool blk_mq_complete_request(struct request *rq);
 void blk_mq_complete_request_sync(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
-			   struct bio *bio);
+			   struct bio *bio, unsigned int nr_segs);
 bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 95202f80676c..6a53799c3fe2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -154,11 +154,6 @@ struct bio {
 	blk_status_t		bi_status;
 	u8			bi_partno;
 
-	/* Number of segments in this BIO after
-	 * physical address coalescing is performed.
-	 */
-	unsigned int		bi_phys_segments;
-
 	struct bvec_iter	bi_iter;
 
 	atomic_t		__bi_remaining;
@@ -210,7 +205,6 @@ struct bio {
  */
 enum {
 	BIO_NO_PAGE_REF,	/* don't put release vec pages */
-	BIO_SEG_VALID,		/* bi_phys_segments valid */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_USER_MAPPED,	/* contains user pages */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05bc85cdbc25..96edfdf34cd3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -836,7 +836,6 @@ extern blk_status_t blk_insert_cloned_request(struct request_queue *q,
 				     struct request *rq);
 extern int blk_rq_append_bio(struct request *rq, struct bio **bio);
 extern void blk_queue_split(struct request_queue *, struct bio **);
-extern void blk_recount_segments(struct request_queue *, struct bio *);
 extern int scsi_verify_blk_ioctl(struct block_device *, unsigned int);
 extern int scsi_cmd_blk_ioctl(struct block_device *, fmode_t,
 			      unsigned int, void __user *);
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 6e8bc53740f0..169bb2e02516 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -34,7 +34,7 @@ struct elevator_mq_ops {
 	void (*depth_updated)(struct blk_mq_hw_ctx *);
 
 	bool (*allow_merge)(struct request_queue *, struct request *, struct bio *);
-	bool (*bio_merge)(struct blk_mq_hw_ctx *, struct bio *);
+	bool (*bio_merge)(struct blk_mq_hw_ctx *, struct bio *, unsigned int);
 	int (*request_merge)(struct request_queue *q, struct request **, struct bio *);
 	void (*request_merged)(struct request_queue *, struct request *, enum elv_merge);
 	void (*requests_merged)(struct request_queue *, struct request *, struct request *);
-- 
2.20.1

