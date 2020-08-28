Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DCAC433E7
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 02:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D54E2080C
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 02:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgH1Cx0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 22:53:26 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:44590 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgH1CxV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 22:53:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U73Y1vy_1598583196;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U73Y1vy_1598583196)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Aug 2020 10:53:17 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] block: Add a new helper to attempt to merge a bio
Date:   Fri, 28 Aug 2020 10:52:56 +0800
Message-Id: <7e4bc05d74f5e71f4680921810a876e5b2d8b85e.1598580324.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
References: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
References: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are lots of duplicated code when trying to merge a bio from
plug list and sw queue, we can introduce a new helper to attempt
to merge a bio, which can simplify the blk_bio_list_merge()
and blk_attempt_plug_merge().

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-merge.c    | 104 ++++++++++++++++++++++++++-------------------------
 block/blk-mq-sched.c |   6 +--
 block/blk.h          |  21 ++++++++---
 3 files changed, 71 insertions(+), 60 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index b09e9fc..80c9744 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -907,13 +907,14 @@ static void blk_account_io_merge_bio(struct request *req)
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
@@ -928,16 +929,17 @@ bool bio_attempt_back_merge(struct request *req, struct bio *bio,
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
@@ -954,11 +956,12 @@ bool bio_attempt_front_merge(struct request *req, struct bio *bio,
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
 
@@ -976,10 +979,39 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
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
@@ -1018,8 +1050,6 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	plug_list = &plug->mq_list;
 
 	list_for_each_entry_reverse(rq, plug_list, queuelist) {
-		bool merged = false;
-
 		if (rq->q == q && same_queue_rq) {
 			/*
 			 * Only blk-mq multiple hardware queues case checks the
@@ -1029,24 +1059,11 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
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
-			break;
-		}
-
-		if (merged)
+		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
+		    BIO_MERGE_OK)
 			return true;
 	}
 
@@ -1064,33 +1081,18 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 	int checked = 8;
 
 	list_for_each_entry_reverse(rq, list, queuelist) {
-		bool merged = false;
-
 		if (!checked--)
 			break;
 
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
+		switch (blk_attempt_bio_merge(q, rq, bio, nr_segs, true)) {
+		case BIO_MERGE_NONE:
 			continue;
+		case BIO_MERGE_OK:
+			return true;
+		case BIO_MERGE_FAILED:
+			return false;
 		}
 
-		return merged;
 	}
 
 	return false;
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 82acff9..94db0c9 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -368,7 +368,7 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 	case ELEVATOR_BACK_MERGE:
 		if (!blk_mq_sched_allow_merge(q, rq, bio))
 			return false;
-		if (!bio_attempt_back_merge(rq, bio, nr_segs))
+		if (bio_attempt_back_merge(rq, bio, nr_segs) != BIO_MERGE_OK)
 			return false;
 		*merged_request = attempt_back_merge(q, rq);
 		if (!*merged_request)
@@ -377,14 +377,14 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
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
diff --git a/block/blk.h b/block/blk.h
index d6152d2..a180443 100644
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
@@ -169,12 +175,15 @@ static inline void blk_integrity_del(struct gendisk *disk)
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
 bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
-- 
1.8.3.1

