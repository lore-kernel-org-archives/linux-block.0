Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F73C680
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EFzNJfeu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=id1Q5RlcTDJAcfEqqnUyePvcOdwcBu5Q3OBGxwGlS68=; b=EFzNJfeuGicJV4+zVnR/5Dxo7y
	CXqr5PF/VC2LiEQGno3ms25kkUAxgqbqiqtWI36f/y/xdWG1azxqnBnO7/4b1AWhAL5XvgvkoeXmo
	y/gkCXtktLfsB28jJbaPpkKjceicGdGqEa02uWxItopLbh3K28VJj2E8x9YSKOUVOso6rpTdat6J3
	zLEGP5D9DwbDSOcSZD115qT8LAhFlyEE2l1Btl9kXlYHoyS0QUqOzq4xEO3FxeL1MZccsp+akucfP
	J7jLtx52AW4Ag6Tb7+fEk0dXVCmKU0zY71qWPy7ygeM14+016Tc+6/eZ3UpZGE47ggX5T/RJjsG16
	nY9qhoOA==;
Received: from [2001:4bb8:191:2f6b:63ff:a340:8ed1:7cd5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNvYb-000ETt-2R;
	Thu, 11 Jan 2024 13:57:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held when splitting bios
Date: Thu, 11 Jan 2024 14:57:05 +0100
Message-Id: <20240111135705.2155518-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111135705.2155518-1-hch@lst.de>
References: <20240111135705.2155518-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

q_usage_counter is the only thing preventing us from the limits changing
under us in __bio_split_to_limits, but blk_mq_submit_bio doesn't hold it.

Change __submit_bio to always acquire the q_usage_counter counter before
branching out into bio vs request based helper, and let blk_mq_submit_bio
tell it if it consumed the reference by handing it off to the request.

Fixes: 9d497e2941c3 ("block: don't protect submit_bio_checks by q_usage_counter")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 14 ++++++++-----
 block/blk-mq.c   | 52 +++++++++++++++++++++---------------------------
 block/blk-mq.h   |  2 +-
 3 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9520ccab305007..885ba6bb58556f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -592,17 +592,21 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 
 static void __submit_bio(struct bio *bio)
 {
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+
 	if (unlikely(!blk_crypto_bio_prep(&bio)))
 		return;
+	if (unlikely(bio_queue_enter(bio)))
+		return;
 
 	if (!bio->bi_bdev->bd_has_submit_bio) {
-		blk_mq_submit_bio(bio);
-	} else if (likely(bio_queue_enter(bio) == 0)) {
-		struct gendisk *disk = bio->bi_bdev->bd_disk;
-
+		if (blk_mq_submit_bio(bio))
+			return;
+	} else {
 		disk->fops->submit_bio(bio);
-		blk_queue_exit(disk->queue);
 	}
+
+	blk_queue_exit(disk->queue);
 }
 
 /*
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a6731cacd0132c..421db29535ba50 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2936,14 +2936,17 @@ static void bio_set_ioprio(struct bio *bio)
  *
  * It will not queue the request if there is an error with the bio, or at the
  * request creation.
+ *
+ * Returns %true if the q_usage_counter usage is consumed, or %false if it
+ * isn't.
  */
-void blk_mq_submit_bio(struct bio *bio)
+bool blk_mq_submit_bio(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct blk_plug *plug = blk_mq_plug(bio);
 	const int is_sync = op_is_sync(bio->bi_opf);
 	struct blk_mq_hw_ctx *hctx;
-	struct request *rq = NULL;
+	struct request *rq;
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
@@ -2951,39 +2954,28 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (bio_may_exceed_limits(bio, &q->limits)) {
 		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
 		if (!bio)
-			return;
+			return false;
 	}
 
 	bio_set_ioprio(bio);
 
+	if (!bio_integrity_prep(bio))
+		return false;
+
 	if (plug) {
 		rq = rq_list_peek(&plug->cached_rq);
-		if (rq && rq->q != q)
-			rq = NULL;
-	}
-	if (rq) {
-		if (!bio_integrity_prep(bio))
-			return;
-		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
-			return;
-		if (blk_mq_use_cached_rq(rq, plug, bio))
-			goto done;
-		percpu_ref_get(&q->q_usage_counter);
-	} else {
-		if (unlikely(bio_queue_enter(bio)))
-			return;
-		if (!bio_integrity_prep(bio))
-			goto fail;
+		if (rq && rq->q == q) {
+			if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
+				return false;
+			if (blk_mq_use_cached_rq(rq, plug, bio))
+				goto has_rq;
+		}
 	}
 
 	rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
-	if (unlikely(!rq)) {
-fail:
-		blk_queue_exit(q);
-		return;
-	}
-
-done:
+	if (unlikely(!rq))
+		return false;
+has_rq:
 	trace_block_getrq(bio);
 
 	rq_qos_track(q, rq, bio);
@@ -2995,15 +2987,15 @@ void blk_mq_submit_bio(struct bio *bio)
 		bio->bi_status = ret;
 		bio_endio(bio);
 		blk_mq_free_request(rq);
-		return;
+		return true;
 	}
 
 	if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
-		return;
+		return true;
 
 	if (plug) {
 		blk_add_rq_to_plug(plug, rq);
-		return;
+		return true;
 	}
 
 	hctx = rq->mq_hctx;
@@ -3014,6 +3006,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	} else {
 		blk_mq_run_dispatch_ops(q, blk_mq_try_issue_directly(hctx, rq));
 	}
+
+	return true;
 }
 
 #ifdef CONFIG_BLK_MQ_STACKING
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f75a9ecfebde1b..d45f222f117748 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -39,7 +39,7 @@ enum {
 typedef unsigned int __bitwise blk_insert_t;
 #define BLK_MQ_INSERT_AT_HEAD		((__force blk_insert_t)0x01)
 
-void blk_mq_submit_bio(struct bio *bio);
+bool blk_mq_submit_bio(struct bio *bio);
 int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp_batch *iob,
 		unsigned int flags);
 void blk_mq_exit_queue(struct request_queue *q);
-- 
2.39.2

