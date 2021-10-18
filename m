Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFBCC43217
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC4761077
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhJRRx1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhJRRx0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 13:53:26 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEBBC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:15 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s17so17219433ioa.13
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFknZAQ8BmeVCGAxMw2E9Pvn0JC2j+fmOPqQbcmwYTI=;
        b=U4gFvTFEXkWmnmgH7WaiwZlMiDi72DxEM9/HKKX67ySJqOn8fi8d/ojfZiE0tk7+Bq
         PcwpE1ilGdsZM2tO4D4lYV/nX38CzItUF++fMxhNXYcnVg+lizWicZt3dPozHgAS6hFk
         GeCAisWomGLJRxN/v16TSnOQMgUKcIMi7rR7wf9NzmybhrzDiLUf7QLWq13G26Gg2Dyi
         F3Ri7Kz1dz8OGy86XB89QULcrqvfjg4G5a/znQUVDYFmM52lIUiBIGTf3jZ0ZAGIYBzx
         83CXTP8hWJ7bntxPqyRr9WZ2GXhx27ski7y2P/T7k79eF1YAQgz1qvopsg96W7xZYB1G
         5PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFknZAQ8BmeVCGAxMw2E9Pvn0JC2j+fmOPqQbcmwYTI=;
        b=NdDSiO26xi5n0Go/8EDUPL69EdxyO18oggEW5WNIQw5AjR39eKrjA11Ap9XKpabE9S
         ajMPTndN+ScGq23V99wOCr4C0b7QBkLNFx5tijFNVwAsY2UwErqBaTKlrmEM+EJm+SR6
         NLi3neF9uqWOsj0FkESymQp2Dugh0ubaIzPOmP5QzW2qSASyk57tNEz05UKFFqfLxrDd
         Hss1dCe+iLHscmqveZGr0kVL5SgCrtp5MI8UPRCoednNiuSYIpMulkxAKF2ClShQ5e9k
         gn+1QA5NKAVTWy+UHbAUhLpTX7o04duEE/lrFhh91k/uG54WvQyAxv1cAaZz+wIxkqN/
         dGzA==
X-Gm-Message-State: AOAM533gCdQftAgkV1B7CoFSJGvtZFMgL2ZIFdylDOemKqROlmw8Ze0/
        WLV7HwJS6z/qAqW9e2ttKPSw73oaTJA2QA==
X-Google-Smtp-Source: ABdhPJzLQy19b6TpTjv/qAi2m6QQnb2g/RPZE8XZipMMWrRjeG5DQkqgfJyRCfeFgOzTtE7gMwcnAg==
X-Received: by 2002:a6b:7604:: with SMTP id g4mr15454564iom.162.1634579474468;
        Mon, 18 Oct 2021 10:51:14 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v17sm7380017ilh.67.2021.10.18.10.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:51:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] block: change plugging to use a singly linked list
Date:   Mon, 18 Oct 2021 11:51:07 -0600
Message-Id: <20211018175109.401292-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018175109.401292-1-axboe@kernel.dk>
References: <20211018175109.401292-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use a singly linked list for the blk_plug. This saves 8 bytes in the
blk_plug struct, and makes for faster list manipulations than doubly
linked lists. As we don't use the doubly linked lists for anything,
singly linked is just fine.

This yields a bump in default (merging enabled) performance from 7.0
to 7.1M IOPS, and ~7.5M IOPS with merging disabled.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       |   5 +-
 block/blk-merge.c      |   4 +-
 block/blk-mq.c         | 140 ++++++++++++++++++++++++++++++-----------
 include/linux/blkdev.h |   6 +-
 4 files changed, 113 insertions(+), 42 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0c2e11411d0..e6ad5b51d0c3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1550,11 +1550,12 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 	if (tsk->plug)
 		return;
 
-	INIT_LIST_HEAD(&plug->mq_list);
+	plug->mq_list = NULL;
 	plug->cached_rq = NULL;
 	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
 	plug->rq_count = 0;
 	plug->multiple_queues = false;
+	plug->has_elevator = false;
 	plug->nowait = false;
 	INIT_LIST_HEAD(&plug->cb_list);
 
@@ -1640,7 +1641,7 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	flush_plug_callbacks(plug, from_schedule);
 
-	if (!list_empty(&plug->mq_list))
+	if (!rq_list_empty(plug->mq_list))
 		blk_mq_flush_plug_list(plug, from_schedule);
 	if (unlikely(!from_schedule && plug->cached_rq))
 		blk_mq_free_plug_rqs(plug);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index c273b58378ce..3e6fa449caff 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1090,11 +1090,11 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	struct request *rq;
 
 	plug = blk_mq_plug(q, bio);
-	if (!plug || list_empty(&plug->mq_list))
+	if (!plug || rq_list_empty(plug->mq_list))
 		return false;
 
 	/* check the previously added entry for a quick merge attempt */
-	rq = list_last_entry(&plug->mq_list, struct request, queuelist);
+	rq = rq_list_peek(&plug->mq_list);
 	if (rq->q == q) {
 		/*
 		 * Only blk-mq multiple hardware queues case checks the rq in
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 58774267dd95..3d5010d93059 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2150,36 +2150,106 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	spin_unlock(&ctx->lock);
 }
 
+static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued,
+			      bool from_schedule)
+{
+	if (hctx->queue->mq_ops->commit_rqs) {
+		trace_block_unplug(hctx->queue, *queued, !from_schedule);
+		hctx->queue->mq_ops->commit_rqs(hctx);
+	}
+	*queued = 0;
+}
+
+static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
+{
+	struct blk_mq_hw_ctx *hctx = NULL;
+	struct request *rq;
+	int queued = 0;
+	int errors = 0;
+
+	while ((rq = rq_list_pop(&plug->mq_list))) {
+		bool last = rq_list_empty(plug->mq_list);
+		blk_status_t ret;
+
+		if (hctx != rq->mq_hctx) {
+			if (hctx)
+				blk_mq_commit_rqs(hctx, &queued, from_schedule);
+			hctx = rq->mq_hctx;
+		}
+
+		ret = blk_mq_request_issue_directly(rq, last);
+		switch (ret) {
+		case BLK_STS_OK:
+			queued++;
+			break;
+		case BLK_STS_RESOURCE:
+		case BLK_STS_DEV_RESOURCE:
+			blk_mq_request_bypass_insert(rq, false, last);
+			blk_mq_commit_rqs(hctx, &queued, from_schedule);
+			return;
+		default:
+			blk_mq_end_request(rq, ret);
+			errors++;
+			break;
+		}
+	}
+
+	/*
+	 * If we didn't flush the entire list, we could have told the driver
+	 * there was more coming, but that turned out to be a lie.
+	 */
+	if (errors)
+		blk_mq_commit_rqs(hctx, &queued, from_schedule);
+}
+
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
+	struct blk_mq_hw_ctx *this_hctx;
+	struct blk_mq_ctx *this_ctx;
+	unsigned int depth;
 	LIST_HEAD(list);
 
-	if (list_empty(&plug->mq_list))
+	if (rq_list_empty(plug->mq_list))
 		return;
-	list_splice_init(&plug->mq_list, &list);
 	plug->rq_count = 0;
 
+	if (!plug->multiple_queues && !plug->has_elevator) {
+		blk_mq_plug_issue_direct(plug, from_schedule);
+		if (rq_list_empty(plug->mq_list))
+			return;
+	}
+
+	this_hctx = NULL;
+	this_ctx = NULL;
+	depth = 0;
 	do {
-		struct list_head rq_list;
-		struct request *rq, *head_rq = list_entry_rq(list.next);
-		struct list_head *pos = &head_rq->queuelist; /* skip first */
-		struct blk_mq_hw_ctx *this_hctx = head_rq->mq_hctx;
-		struct blk_mq_ctx *this_ctx = head_rq->mq_ctx;
-		unsigned int depth = 1;
-
-		list_for_each_continue(pos, &list) {
-			rq = list_entry_rq(pos);
-			BUG_ON(!rq->q);
-			if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx)
-				break;
-			depth++;
+		struct request *rq;
+
+		rq = rq_list_pop(&plug->mq_list);
+
+		if (!this_hctx) {
+			this_hctx = rq->mq_hctx;
+			this_ctx = rq->mq_ctx;
+		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx) {
+			trace_block_unplug(this_hctx->queue, depth,
+						!from_schedule);
+			blk_mq_sched_insert_requests(this_hctx, this_ctx,
+						&list, from_schedule);
+			depth = 0;
+			this_hctx = rq->mq_hctx;
+			this_ctx = rq->mq_ctx;
+
 		}
 
-		list_cut_before(&rq_list, &list, pos);
-		trace_block_unplug(head_rq->q, depth, !from_schedule);
-		blk_mq_sched_insert_requests(this_hctx, this_ctx, &rq_list,
+		list_add(&rq->queuelist, &list);
+		depth++;
+	} while (!rq_list_empty(plug->mq_list));
+
+	if (!list_empty(&list)) {
+		trace_block_unplug(this_hctx->queue, depth, !from_schedule);
+		blk_mq_sched_insert_requests(this_hctx, this_ctx, &list,
 						from_schedule);
-	} while(!list_empty(&list));
+	}
 }
 
 static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
@@ -2359,16 +2429,17 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 
 static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 {
-	list_add_tail(&rq->queuelist, &plug->mq_list);
-	plug->rq_count++;
-	if (!plug->multiple_queues && !list_is_singular(&plug->mq_list)) {
-		struct request *tmp;
+	if (!plug->multiple_queues) {
+		struct request *nxt = rq_list_peek(&plug->mq_list);
 
-		tmp = list_first_entry(&plug->mq_list, struct request,
-						queuelist);
-		if (tmp->q != rq->q)
+		if (nxt && nxt->q != rq->q)
 			plug->multiple_queues = true;
 	}
+	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
+		plug->has_elevator = true;
+	rq->rq_next = NULL;
+	rq_list_add(&plug->mq_list, rq);
+	plug->rq_count++;
 }
 
 /*
@@ -2480,13 +2551,15 @@ void blk_mq_submit_bio(struct bio *bio)
 		unsigned int request_count = plug->rq_count;
 		struct request *last = NULL;
 
-		if (!request_count)
+		if (!request_count) {
 			trace_block_plug(q);
-		else
-			last = list_entry_rq(plug->mq_list.prev);
+		} else if (!blk_queue_nomerges(q)) {
+			last = rq_list_peek(&plug->mq_list);
+			if (blk_rq_bytes(last) < BLK_PLUG_FLUSH_SIZE)
+				last = NULL;
+		}
 
-		if (request_count >= blk_plug_max_rq_count(plug) || (last &&
-		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
+		if (request_count >= blk_plug_max_rq_count(plug) || last) {
 			blk_flush_plug_list(plug, false);
 			trace_block_plug(q);
 		}
@@ -2506,10 +2579,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		 * the plug list is empty, and same_queue_rq is invalid.
 		 */
 		if (same_queue_rq) {
-			next_rq = list_last_entry(&plug->mq_list,
-							struct request,
-							queuelist);
-			list_del_init(&next_rq->queuelist);
+			next_rq = rq_list_pop(&plug->mq_list);
 			plug->rq_count--;
 		}
 		blk_add_rq_to_plug(plug, rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index abe721591e80..2e93682f8f68 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -711,7 +711,7 @@ extern void blk_set_queue_dying(struct request_queue *);
  * schedule() where blk_schedule_flush_plug() is called.
  */
 struct blk_plug {
-	struct list_head mq_list; /* blk-mq requests */
+	struct request *mq_list; /* blk-mq requests */
 
 	/* if ios_left is > 1, we can batch tag/rq allocations */
 	struct request *cached_rq;
@@ -720,6 +720,7 @@ struct blk_plug {
 	unsigned short rq_count;
 
 	bool multiple_queues;
+	bool has_elevator;
 	bool nowait;
 
 	struct list_head cb_list; /* md requires an unplug callback */
@@ -760,8 +761,7 @@ static inline bool blk_needs_flush_plug(struct task_struct *tsk)
 	struct blk_plug *plug = tsk->plug;
 
 	return plug &&
-		 (!list_empty(&plug->mq_list) ||
-		 !list_empty(&plug->cb_list));
+		 (plug->mq_list || !list_empty(&plug->cb_list));
 }
 
 int blkdev_issue_flush(struct block_device *bdev);
-- 
2.33.1

