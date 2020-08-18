Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D461CC433E4
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 05:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B354F20738
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 05:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHRFpr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:45:47 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:38120 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726583AbgHRFpq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 01:45:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U67402O_1597729538;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U67402O_1597729538)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Aug 2020 13:45:39 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] block: Add a new helper to attempt to merge a bio
Date:   Tue, 18 Aug 2020 13:45:29 +0800
Message-Id: <7749d6068b9e5404ef59bacfcb278d604f84af75.1597727255.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1597727255.git.baolin.wang@linux.alibaba.com>
References: <cover.1597727255.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1597727255.git.baolin.wang@linux.alibaba.com>
References: <cover.1597727255.git.baolin.wang@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are lots of duplicated code when trying to merge a bio from
plug list and sw queue, we can introduce a new helper to attempt
to merge a bio, which can simplify the blk_mq_bio_list_merge()
and blk_attempt_plug_merge().

Meanwhile move the blk_mq_bio_list_merge() into blk-merge.c and
rename it as a generic name.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-merge.c      | 101 +++++++++++++++++++++++++++++++++++--------------
 block/blk-mq-sched.c   |  52 ++-----------------------
 block/blk.h            |  23 ++++++++---
 block/kyber-iosched.c  |   2 +-
 include/linux/blk-mq.h |   2 -
 5 files changed, 95 insertions(+), 85 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3619f2f..6868961 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -900,13 +900,14 @@ static void blk_account_io_merge_bio(struct request *req)
 	part_stat_unlock();
 }
 
-bool bio_attempt_back_merge(struct request *req, struct bio *bio,
-		unsigned int nr_segs)
+enum bio_merge_status bio_attempt_back_merge(struct request *req,
+					     struct bio *bio,
+					     unsigned int nr_segs)
 {
 	const int ff = bio->bi_opf & REQ_FAILFAST_MASK;
 
 	if (!ll_back_merge_fn(req, bio, nr_segs))
-		return false;
+		return BIO_MERGE_FAILED;
 
 	trace_block_bio_backmerge(req->q, req, bio);
 	rq_qos_merge(req->q, req, bio);
@@ -921,16 +922,17 @@ bool bio_attempt_back_merge(struct request *req, struct bio *bio,
 	bio_crypt_free_ctx(bio);
 
 	blk_account_io_merge_bio(req);
-	return true;
+	return BIO_MERGE_OK;
 }
 
-bool bio_attempt_front_merge(struct request *req, struct bio *bio,
-		unsigned int nr_segs)
+enum bio_merge_status bio_attempt_front_merge(struct request *req,
+					      struct bio *bio,
+					      unsigned int nr_segs)
 {
 	const int ff = bio->bi_opf & REQ_FAILFAST_MASK;
 
 	if (!ll_front_merge_fn(req, bio, nr_segs))
-		return false;
+		return BIO_MERGE_FAILED;
 
 	trace_block_bio_frontmerge(req->q, req, bio);
 	rq_qos_merge(req->q, req, bio);
@@ -947,11 +949,12 @@ bool bio_attempt_front_merge(struct request *req, struct bio *bio,
 	bio_crypt_do_front_merge(req, bio);
 
 	blk_account_io_merge_bio(req);
-	return true;
+	return BIO_MERGE_OK;
 }
 
-bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
-		struct bio *bio)
+enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
+						struct request *req,
+						struct bio *bio)
 {
 	unsigned short segments = blk_rq_nr_discard_segments(req);
 
@@ -969,10 +972,39 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
 	req->nr_phys_segments = segments + 1;
 
 	blk_account_io_merge_bio(req);
-	return true;
+	return BIO_MERGE_OK;
 no_merge:
 	req_set_nomerge(q, req);
-	return false;
+	return BIO_MERGE_FAILED;
+}
+
+static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
+						   struct request *rq,
+						   struct bio *bio,
+						   unsigned int nr_segs,
+						   bool sched_allow_merge)
+{
+	if (!blk_rq_merge_ok(rq, bio))
+		return BIO_MERGE_NONE;
+
+	switch (blk_try_merge(rq, bio)) {
+	case ELEVATOR_BACK_MERGE:
+		if (!sched_allow_merge ||
+		    (sched_allow_merge && blk_mq_sched_allow_merge(q, rq, bio)))
+			return bio_attempt_back_merge(rq, bio, nr_segs);
+		break;
+	case ELEVATOR_FRONT_MERGE:
+		if (!sched_allow_merge ||
+		    (sched_allow_merge && blk_mq_sched_allow_merge(q, rq, bio)))
+			return bio_attempt_front_merge(rq, bio, nr_segs);
+		break;
+	case ELEVATOR_DISCARD_MERGE:
+		return bio_attempt_discard_merge(q, rq, bio);
+	default:
+		return BIO_MERGE_NONE;
+	}
+
+	return BIO_MERGE_FAILED;
 }
 
 /**
@@ -1011,8 +1043,6 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	plug_list = &plug->mq_list;
 
 	list_for_each_entry_reverse(rq, plug_list, queuelist) {
-		bool merged = false;
-
 		if (rq->q == q && same_queue_rq) {
 			/*
 			 * Only blk-mq multiple hardware queues case checks the
@@ -1022,26 +1052,41 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 			*same_queue_rq = rq;
 		}
 
-		if (rq->q != q || !blk_rq_merge_ok(rq, bio))
+		if (rq->q != q)
 			continue;
 
-		switch (blk_try_merge(rq, bio)) {
-		case ELEVATOR_BACK_MERGE:
-			merged = bio_attempt_back_merge(rq, bio, nr_segs);
-			break;
-		case ELEVATOR_FRONT_MERGE:
-			merged = bio_attempt_front_merge(rq, bio, nr_segs);
-			break;
-		case ELEVATOR_DISCARD_MERGE:
-			merged = bio_attempt_discard_merge(q, rq, bio);
-			break;
-		default:
+		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Iterate list of requests and see if we can merge this bio with any
+ * of them.
+ */
+bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
+			struct bio *bio, unsigned int nr_segs)
+{
+	struct request *rq;
+	int checked = 8;
+
+	list_for_each_entry_reverse(rq, list, queuelist) {
+		if (!checked--)
 			break;
-		}
 
-		if (merged)
+		switch (blk_attempt_bio_merge(q, rq, bio, nr_segs, true)) {
+		default:
+		case BIO_MERGE_NONE:
+			continue;
+		case BIO_MERGE_OK:
 			return true;
+		case BIO_MERGE_FAILED:
+			return false;
+		}
 	}
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(blk_bio_list_merge);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a19cdf1..5e63ede 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -359,7 +359,7 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 	case ELEVATOR_BACK_MERGE:
 		if (!blk_mq_sched_allow_merge(q, rq, bio))
 			return false;
-		if (!bio_attempt_back_merge(rq, bio, nr_segs))
+		if (bio_attempt_back_merge(rq, bio, nr_segs) != BIO_MERGE_OK)
 			return false;
 		*merged_request = attempt_back_merge(q, rq);
 		if (!*merged_request)
@@ -368,14 +368,14 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 	case ELEVATOR_FRONT_MERGE:
 		if (!blk_mq_sched_allow_merge(q, rq, bio))
 			return false;
-		if (!bio_attempt_front_merge(rq, bio, nr_segs))
+		if (bio_attempt_front_merge(rq, bio, nr_segs) != BIO_MERGE_OK)
 			return false;
 		*merged_request = attempt_front_merge(q, rq);
 		if (!*merged_request)
 			elv_merged_request(q, rq, ELEVATOR_FRONT_MERGE);
 		return true;
 	case ELEVATOR_DISCARD_MERGE:
-		return bio_attempt_discard_merge(q, rq, bio);
+		return bio_attempt_discard_merge(q, rq, bio) == BIO_MERGE_OK;
 	default:
 		return false;
 	}
@@ -383,50 +383,6 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
 
 /*
- * Iterate list of requests and see if we can merge this bio with any
- * of them.
- */
-bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
-			   struct bio *bio, unsigned int nr_segs)
-{
-	struct request *rq;
-	int checked = 8;
-
-	list_for_each_entry_reverse(rq, list, queuelist) {
-		bool merged = false;
-
-		if (!checked--)
-			break;
-
-		if (!blk_rq_merge_ok(rq, bio))
-			continue;
-
-		switch (blk_try_merge(rq, bio)) {
-		case ELEVATOR_BACK_MERGE:
-			if (blk_mq_sched_allow_merge(q, rq, bio))
-				merged = bio_attempt_back_merge(rq, bio,
-						nr_segs);
-			break;
-		case ELEVATOR_FRONT_MERGE:
-			if (blk_mq_sched_allow_merge(q, rq, bio))
-				merged = bio_attempt_front_merge(rq, bio,
-						nr_segs);
-			break;
-		case ELEVATOR_DISCARD_MERGE:
-			merged = bio_attempt_discard_merge(q, rq, bio);
-			break;
-		default:
-			continue;
-		}
-
-		return merged;
-	}
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(blk_mq_bio_list_merge);
-
-/*
  * Reverse check our software queue for entries that we could potentially
  * merge with. Currently includes a hand-wavy stop count of 8, to not spend
  * too much time checking for merges.
@@ -440,7 +396,7 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 
 	lockdep_assert_held(&ctx->lock);
 
-	if (blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
+	if (blk_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
 		ctx->rq_merged++;
 		return true;
 	}
diff --git a/block/blk.h b/block/blk.h
index 49e2928..a180443 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -29,6 +29,12 @@ struct blk_flush_queue {
 	spinlock_t		mq_flush_lock;
 };
 
+enum bio_merge_status {
+	BIO_MERGE_OK,
+	BIO_MERGE_NONE,
+	BIO_MERGE_FAILED,
+};
+
 extern struct kmem_cache *blk_requestq_cachep;
 extern struct kobj_type blk_queue_ktype;
 extern struct ida blk_queue_ida;
@@ -169,14 +175,19 @@ static inline void blk_integrity_del(struct gendisk *disk)
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
 
-bool bio_attempt_front_merge(struct request *req, struct bio *bio,
-		unsigned int nr_segs);
-bool bio_attempt_back_merge(struct request *req, struct bio *bio,
-		unsigned int nr_segs);
-bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
-		struct bio *bio);
+enum bio_merge_status bio_attempt_front_merge(struct request *req,
+					      struct bio *bio,
+					      unsigned int nr_segs);
+enum bio_merge_status bio_attempt_back_merge(struct request *req,
+					     struct bio *bio,
+					     unsigned int nr_segs);
+enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
+						struct request *req,
+						struct bio *bio);
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **same_queue_rq);
+bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
+			struct bio *bio, unsigned int nr_segs);
 
 void blk_account_io_start(struct request *req);
 void blk_account_io_done(struct request *req, u64 now);
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index a38c5ab..6d4ba0e 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -573,7 +573,7 @@ static bool kyber_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio,
 	bool merged;
 
 	spin_lock(&kcq->lock);
-	merged = blk_mq_bio_list_merge(hctx->queue, rq_list, bio, nr_segs);
+	merged = blk_bio_list_merge(hctx->queue, rq_list, bio, nr_segs);
 	spin_unlock(&kcq->lock);
 
 	return merged;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9d2d5ad..21a02e0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -489,8 +489,6 @@ static inline int blk_mq_request_completed(struct request *rq)
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
 bool blk_mq_complete_request_remote(struct request *rq);
-bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
-			   struct bio *bio, unsigned int nr_segs);
 bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
-- 
1.8.3.1

