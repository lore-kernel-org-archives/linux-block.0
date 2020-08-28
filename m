Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9D7C43461
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 02:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5DD820872
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 02:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgH1Cx0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 22:53:26 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54206 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727909AbgH1CxV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 22:53:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U736P4p_1598583195;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U736P4p_1598583195)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Aug 2020 10:53:16 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] block: Move bio merge related functions into blk-merge.c
Date:   Fri, 28 Aug 2020 10:52:54 +0800
Message-Id: <9e9924752ead8df42467559b86e667bc502390ec.1598580324.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
References: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
References: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's better to move bio merge related functions into blk-merge.c,
which contains all merge related functions.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c  | 156 -----------------------------------------------------
 block/blk-merge.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 156 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d9d6326..ed79109 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -642,162 +642,6 @@ void blk_put_request(struct request *req)
 }
 EXPORT_SYMBOL(blk_put_request);
 
-static void blk_account_io_merge_bio(struct request *req)
-{
-	if (!blk_do_io_stat(req))
-		return;
-
-	part_stat_lock();
-	part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
-	part_stat_unlock();
-}
-
-bool bio_attempt_back_merge(struct request *req, struct bio *bio,
-		unsigned int nr_segs)
-{
-	const int ff = bio->bi_opf & REQ_FAILFAST_MASK;
-
-	if (!ll_back_merge_fn(req, bio, nr_segs))
-		return false;
-
-	trace_block_bio_backmerge(req->q, req, bio);
-	rq_qos_merge(req->q, req, bio);
-
-	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
-		blk_rq_set_mixed_merge(req);
-
-	req->biotail->bi_next = bio;
-	req->biotail = bio;
-	req->__data_len += bio->bi_iter.bi_size;
-
-	bio_crypt_free_ctx(bio);
-
-	blk_account_io_merge_bio(req);
-	return true;
-}
-
-bool bio_attempt_front_merge(struct request *req, struct bio *bio,
-		unsigned int nr_segs)
-{
-	const int ff = bio->bi_opf & REQ_FAILFAST_MASK;
-
-	if (!ll_front_merge_fn(req, bio, nr_segs))
-		return false;
-
-	trace_block_bio_frontmerge(req->q, req, bio);
-	rq_qos_merge(req->q, req, bio);
-
-	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
-		blk_rq_set_mixed_merge(req);
-
-	bio->bi_next = req->bio;
-	req->bio = bio;
-
-	req->__sector = bio->bi_iter.bi_sector;
-	req->__data_len += bio->bi_iter.bi_size;
-
-	bio_crypt_do_front_merge(req, bio);
-
-	blk_account_io_merge_bio(req);
-	return true;
-}
-
-bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
-		struct bio *bio)
-{
-	unsigned short segments = blk_rq_nr_discard_segments(req);
-
-	if (segments >= queue_max_discard_segments(q))
-		goto no_merge;
-	if (blk_rq_sectors(req) + bio_sectors(bio) >
-	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
-		goto no_merge;
-
-	rq_qos_merge(q, req, bio);
-
-	req->biotail->bi_next = bio;
-	req->biotail = bio;
-	req->__data_len += bio->bi_iter.bi_size;
-	req->nr_phys_segments = segments + 1;
-
-	blk_account_io_merge_bio(req);
-	return true;
-no_merge:
-	req_set_nomerge(q, req);
-	return false;
-}
-
-/**
- * blk_attempt_plug_merge - try to merge with %current's plugged list
- * @q: request_queue new bio is being queued at
- * @bio: new bio being queued
- * @nr_segs: number of segments in @bio
- * @same_queue_rq: pointer to &struct request that gets filled in when
- * another request associated with @q is found on the plug list
- * (optional, may be %NULL)
- *
- * Determine whether @bio being queued on @q can be merged with a request
- * on %current's plugged list.  Returns %true if merge was successful,
- * otherwise %false.
- *
- * Plugging coalesces IOs from the same issuer for the same purpose without
- * going through @q->queue_lock.  As such it's more of an issuing mechanism
- * than scheduling, and the request, while may have elvpriv data, is not
- * added on the elevator at this point.  In addition, we don't have
- * reliable access to the elevator outside queue lock.  Only check basic
- * merging parameters without querying the elevator.
- *
- * Caller must ensure !blk_queue_nomerges(q) beforehand.
- */
-bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs, struct request **same_queue_rq)
-{
-	struct blk_plug *plug;
-	struct request *rq;
-	struct list_head *plug_list;
-
-	plug = blk_mq_plug(q, bio);
-	if (!plug)
-		return false;
-
-	plug_list = &plug->mq_list;
-
-	list_for_each_entry_reverse(rq, plug_list, queuelist) {
-		bool merged = false;
-
-		if (rq->q == q && same_queue_rq) {
-			/*
-			 * Only blk-mq multiple hardware queues case checks the
-			 * rq in the same queue, there should be only one such
-			 * rq in a queue
-			 **/
-			*same_queue_rq = rq;
-		}
-
-		if (rq->q != q || !blk_rq_merge_ok(rq, bio))
-			continue;
-
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
-			return true;
-	}
-
-	return false;
-}
-
 static void handle_bad_sector(struct bio *bio, sector_t maxsector)
 {
 	char b[BDEVNAME_SIZE];
diff --git a/block/blk-merge.c b/block/blk-merge.c
index f685d63..3aa2de5 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -11,6 +11,7 @@
 #include <trace/events/block.h>
 
 #include "blk.h"
+#include "blk-rq-qos.h"
 
 static inline bool bio_will_gap(struct request_queue *q,
 		struct request *prev_rq, struct bio *prev, struct bio *next)
@@ -895,3 +896,159 @@ enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 		return ELEVATOR_FRONT_MERGE;
 	return ELEVATOR_NO_MERGE;
 }
+
+static void blk_account_io_merge_bio(struct request *req)
+{
+	if (!blk_do_io_stat(req))
+		return;
+
+	part_stat_lock();
+	part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
+	part_stat_unlock();
+}
+
+bool bio_attempt_back_merge(struct request *req, struct bio *bio,
+		unsigned int nr_segs)
+{
+	const int ff = bio->bi_opf & REQ_FAILFAST_MASK;
+
+	if (!ll_back_merge_fn(req, bio, nr_segs))
+		return false;
+
+	trace_block_bio_backmerge(req->q, req, bio);
+	rq_qos_merge(req->q, req, bio);
+
+	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
+		blk_rq_set_mixed_merge(req);
+
+	req->biotail->bi_next = bio;
+	req->biotail = bio;
+	req->__data_len += bio->bi_iter.bi_size;
+
+	bio_crypt_free_ctx(bio);
+
+	blk_account_io_merge_bio(req);
+	return true;
+}
+
+bool bio_attempt_front_merge(struct request *req, struct bio *bio,
+		unsigned int nr_segs)
+{
+	const int ff = bio->bi_opf & REQ_FAILFAST_MASK;
+
+	if (!ll_front_merge_fn(req, bio, nr_segs))
+		return false;
+
+	trace_block_bio_frontmerge(req->q, req, bio);
+	rq_qos_merge(req->q, req, bio);
+
+	if ((req->cmd_flags & REQ_FAILFAST_MASK) != ff)
+		blk_rq_set_mixed_merge(req);
+
+	bio->bi_next = req->bio;
+	req->bio = bio;
+
+	req->__sector = bio->bi_iter.bi_sector;
+	req->__data_len += bio->bi_iter.bi_size;
+
+	bio_crypt_do_front_merge(req, bio);
+
+	blk_account_io_merge_bio(req);
+	return true;
+}
+
+bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
+		struct bio *bio)
+{
+	unsigned short segments = blk_rq_nr_discard_segments(req);
+
+	if (segments >= queue_max_discard_segments(q))
+		goto no_merge;
+	if (blk_rq_sectors(req) + bio_sectors(bio) >
+	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
+		goto no_merge;
+
+	rq_qos_merge(q, req, bio);
+
+	req->biotail->bi_next = bio;
+	req->biotail = bio;
+	req->__data_len += bio->bi_iter.bi_size;
+	req->nr_phys_segments = segments + 1;
+
+	blk_account_io_merge_bio(req);
+	return true;
+no_merge:
+	req_set_nomerge(q, req);
+	return false;
+}
+
+/**
+ * blk_attempt_plug_merge - try to merge with %current's plugged list
+ * @q: request_queue new bio is being queued at
+ * @bio: new bio being queued
+ * @nr_segs: number of segments in @bio
+ * @same_queue_rq: pointer to &struct request that gets filled in when
+ * another request associated with @q is found on the plug list
+ * (optional, may be %NULL)
+ *
+ * Determine whether @bio being queued on @q can be merged with a request
+ * on %current's plugged list.  Returns %true if merge was successful,
+ * otherwise %false.
+ *
+ * Plugging coalesces IOs from the same issuer for the same purpose without
+ * going through @q->queue_lock.  As such it's more of an issuing mechanism
+ * than scheduling, and the request, while may have elvpriv data, is not
+ * added on the elevator at this point.  In addition, we don't have
+ * reliable access to the elevator outside queue lock.  Only check basic
+ * merging parameters without querying the elevator.
+ *
+ * Caller must ensure !blk_queue_nomerges(q) beforehand.
+ */
+bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
+		unsigned int nr_segs, struct request **same_queue_rq)
+{
+	struct blk_plug *plug;
+	struct request *rq;
+	struct list_head *plug_list;
+
+	plug = blk_mq_plug(q, bio);
+	if (!plug)
+		return false;
+
+	plug_list = &plug->mq_list;
+
+	list_for_each_entry_reverse(rq, plug_list, queuelist) {
+		bool merged = false;
+
+		if (rq->q == q && same_queue_rq) {
+			/*
+			 * Only blk-mq multiple hardware queues case checks the
+			 * rq in the same queue, there should be only one such
+			 * rq in a queue
+			 **/
+			*same_queue_rq = rq;
+		}
+
+		if (rq->q != q || !blk_rq_merge_ok(rq, bio))
+			continue;
+
+		switch (blk_try_merge(rq, bio)) {
+		case ELEVATOR_BACK_MERGE:
+			merged = bio_attempt_back_merge(rq, bio, nr_segs);
+			break;
+		case ELEVATOR_FRONT_MERGE:
+			merged = bio_attempt_front_merge(rq, bio, nr_segs);
+			break;
+		case ELEVATOR_DISCARD_MERGE:
+			merged = bio_attempt_discard_merge(q, rq, bio);
+			break;
+		default:
+			break;
+		}
+
+		if (merged)
+			return true;
+	}
+
+	return false;
+}
-- 
1.8.3.1

