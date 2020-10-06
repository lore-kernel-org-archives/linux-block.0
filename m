Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491D0C46466
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 07:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5C420789
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 07:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fXxp2Md7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgJFHH2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 03:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgJFHH2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 03:07:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45705C061755
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=b4c/PPQgiIo5w44oJfiaLxdplqQNYi0qhjxufCK3Q9U=; b=fXxp2Md7Omwk/kV5/Ozw6ORfcC
        tjnK5kRFzKnSWhKOJbHn4QCSDmmwuNj1j/N+qhHvYV3oPtfoFY4gFUR22uOxavbym1mk0jLouWvVu
        KvwSnM9cziAWtGROQXVds3vSqNLCPILrySR+NBLggRbsyovWy6dPoq7RAOy2p/onFe1zBpdGe5W4g
        354d2lC6WqDPyQ6gv1jsnDzn98c8Fm2T2LymRchq8b4bvNFOYvgo5xtCqszjJYPeNlPtWu+NqA1e5
        bAtFhoxIxv1k9d+rhieP2DMciofgSB0M2mhI8+xp1YAVWG/dMMLOmw7Jw1ye4moVv1/6N/myegVtb
        kl1uGhKg==;
Received: from [2001:4bb8:184:92a2:9ae2:c87f:2c64:2882] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPh4H-0002Xi-B4; Tue, 06 Oct 2020 07:07:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: move blk_mq_sched_try_merge to blk-merge.c
Date:   Tue,  6 Oct 2020 09:07:19 +0200
Message-Id: <20201006070719.427627-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006070719.427627-1-hch@lst.de>
References: <20201006070719.427627-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move blk_mq_sched_try_merge to blk-merge.c, which allows to mark
a lot of the merge infrastructure static there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c    | 62 +++++++++++++++++++++++++++++++++++---------
 block/blk-mq-sched.c | 32 -----------------------
 block/blk.h          | 19 --------------
 3 files changed, 50 insertions(+), 63 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6ed715835d45f6..bcf5e458060337 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -580,7 +580,8 @@ int ll_back_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs)
 	return ll_new_hw_segment(req, bio, nr_segs);
 }
 
-int ll_front_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs)
+static int ll_front_merge_fn(struct request *req, struct bio *bio,
+		unsigned int nr_segs)
 {
 	if (req_gap_front_merge(req, bio))
 		return 0;
@@ -810,7 +811,8 @@ static struct request *attempt_merge(struct request_queue *q,
 	return next;
 }
 
-struct request *attempt_back_merge(struct request_queue *q, struct request *rq)
+static struct request *attempt_back_merge(struct request_queue *q,
+		struct request *rq)
 {
 	struct request *next = elv_latter_request(q, rq);
 
@@ -820,7 +822,8 @@ struct request *attempt_back_merge(struct request_queue *q, struct request *rq)
 	return NULL;
 }
 
-struct request *attempt_front_merge(struct request_queue *q, struct request *rq)
+static struct request *attempt_front_merge(struct request_queue *q,
+		struct request *rq)
 {
 	struct request *prev = elv_former_request(q, rq);
 
@@ -907,9 +910,14 @@ static void blk_account_io_merge_bio(struct request *req)
 	part_stat_unlock();
 }
 
-enum bio_merge_status bio_attempt_back_merge(struct request *req,
-					     struct bio *bio,
-					     unsigned int nr_segs)
+enum bio_merge_status {
+	BIO_MERGE_OK,
+	BIO_MERGE_NONE,
+	BIO_MERGE_FAILED,
+};
+
+static enum bio_merge_status bio_attempt_back_merge(struct request *req,
+		struct bio *bio, unsigned int nr_segs)
 {
 	const int ff = bio->bi_opf & REQ_FAILFAST_MASK;
 
@@ -932,9 +940,8 @@ enum bio_merge_status bio_attempt_back_merge(struct request *req,
 	return BIO_MERGE_OK;
 }
 
-enum bio_merge_status bio_attempt_front_merge(struct request *req,
-					      struct bio *bio,
-					      unsigned int nr_segs)
+static enum bio_merge_status bio_attempt_front_merge(struct request *req,
+		struct bio *bio, unsigned int nr_segs)
 {
 	const int ff = bio->bi_opf & REQ_FAILFAST_MASK;
 
@@ -959,9 +966,8 @@ enum bio_merge_status bio_attempt_front_merge(struct request *req,
 	return BIO_MERGE_OK;
 }
 
-enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
-						struct request *req,
-						struct bio *bio)
+static enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
+		struct request *req, struct bio *bio)
 {
 	unsigned short segments = blk_rq_nr_discard_segments(req);
 
@@ -1096,3 +1102,35 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 	return false;
 }
 EXPORT_SYMBOL_GPL(blk_bio_list_merge);
+
+bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
+		unsigned int nr_segs, struct request **merged_request)
+{
+	struct request *rq;
+
+	switch (elv_merge(q, &rq, bio)) {
+	case ELEVATOR_BACK_MERGE:
+		if (!blk_mq_sched_allow_merge(q, rq, bio))
+			return false;
+		if (bio_attempt_back_merge(rq, bio, nr_segs) != BIO_MERGE_OK)
+			return false;
+		*merged_request = attempt_back_merge(q, rq);
+		if (!*merged_request)
+			elv_merged_request(q, rq, ELEVATOR_BACK_MERGE);
+		return true;
+	case ELEVATOR_FRONT_MERGE:
+		if (!blk_mq_sched_allow_merge(q, rq, bio))
+			return false;
+		if (bio_attempt_front_merge(rq, bio, nr_segs) != BIO_MERGE_OK)
+			return false;
+		*merged_request = attempt_front_merge(q, rq);
+		if (!*merged_request)
+			elv_merged_request(q, rq, ELEVATOR_FRONT_MERGE);
+		return true;
+	case ELEVATOR_DISCARD_MERGE:
+		return bio_attempt_discard_merge(q, rq, bio) == BIO_MERGE_OK;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 3e9596738852e1..e7a690ae86c9d6 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -344,38 +344,6 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	}
 }
 
-bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs, struct request **merged_request)
-{
-	struct request *rq;
-
-	switch (elv_merge(q, &rq, bio)) {
-	case ELEVATOR_BACK_MERGE:
-		if (!blk_mq_sched_allow_merge(q, rq, bio))
-			return false;
-		if (bio_attempt_back_merge(rq, bio, nr_segs) != BIO_MERGE_OK)
-			return false;
-		*merged_request = attempt_back_merge(q, rq);
-		if (!*merged_request)
-			elv_merged_request(q, rq, ELEVATOR_BACK_MERGE);
-		return true;
-	case ELEVATOR_FRONT_MERGE:
-		if (!blk_mq_sched_allow_merge(q, rq, bio))
-			return false;
-		if (bio_attempt_front_merge(rq, bio, nr_segs) != BIO_MERGE_OK)
-			return false;
-		*merged_request = attempt_front_merge(q, rq);
-		if (!*merged_request)
-			elv_merged_request(q, rq, ELEVATOR_FRONT_MERGE);
-		return true;
-	case ELEVATOR_DISCARD_MERGE:
-		return bio_attempt_discard_merge(q, rq, bio) == BIO_MERGE_OK;
-	default:
-		return false;
-	}
-}
-EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
-
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
diff --git a/block/blk.h b/block/blk.h
index 8fcb146d30034f..dfab98465db9a5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -29,12 +29,6 @@ struct blk_flush_queue {
 	spinlock_t		mq_flush_lock;
 };
 
-enum bio_merge_status {
-	BIO_MERGE_OK,
-	BIO_MERGE_NONE,
-	BIO_MERGE_FAILED,
-};
-
 extern struct kmem_cache *blk_requestq_cachep;
 extern struct kobj_type blk_queue_ktype;
 extern struct ida blk_queue_ida;
@@ -190,15 +184,6 @@ static inline void blk_integrity_del(struct gendisk *disk)
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
 
-enum bio_merge_status bio_attempt_front_merge(struct request *req,
-					      struct bio *bio,
-					      unsigned int nr_segs);
-enum bio_merge_status bio_attempt_back_merge(struct request *req,
-					     struct bio *bio,
-					     unsigned int nr_segs);
-enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
-						struct request *req,
-						struct bio *bio);
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **same_queue_rq);
 bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
@@ -249,10 +234,6 @@ ssize_t part_timeout_store(struct device *, struct device_attribute *,
 void __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
-int ll_front_merge_fn(struct request *req,  struct bio *bio,
-		unsigned int nr_segs);
-struct request *attempt_back_merge(struct request_queue *q, struct request *rq);
-struct request *attempt_front_merge(struct request_queue *q, struct request *rq);
 int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 				struct request *next);
 unsigned int blk_recalc_rq_segments(struct request *rq);
-- 
2.28.0

