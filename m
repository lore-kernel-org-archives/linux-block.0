Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D5C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AA361038
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhJSMKx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhJSMKw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 08:10:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03C7C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:08:39 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 188so19963202iou.12
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qE1z0eF+PLVqckQ04amAftWukEv9qsM1arfuWw2SztM=;
        b=rmvun2dB7DiXY/hxJx8/7bA09PKmV7fEFfstVdDHipzFMODpANqMDAoOWbb3kVk4NB
         v5f6ake3f/czY9XisAc+LE/CYKvSl7y/QkwotQb0OZs3v+P9sTVbn4iv9rvNjEU8m6Ce
         hxiUCGQfunDHPKAB5dZ+bg9Z0TVOOaDavCT5ME3e4Hjk482LgXTrKE8WjunKf6Xrh7z0
         GCSqxbMOvjIrnTFDB0bWuBZbstHjzlVFwExuzlEOkHKwpSLuapGI32xiknRqaanfnLJG
         gMWj086hH7V8RPzn+USdgfXkMuV1Zu+Sj9ViKZmo/2H2TM1jPh7InV+rWHmVPFpXxlR8
         t8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qE1z0eF+PLVqckQ04amAftWukEv9qsM1arfuWw2SztM=;
        b=UEU29yN3NJFJtsLFkryMJrLe9ST1ZTbIV8gKLpQHHom6kNSn7SQZAoONkZO/w2K//Y
         zbGqAlL6T9B/9OshxLNLIQildVJArst/emQov22a2qih/n/SxZjUSPdhpMOggXvooLse
         etJNfSzJOS4NjtDWZ+CHsXN5ZFjtReXHCQUg1owo+jHcyoeJVx3zTbfnie1hnxbWC+ot
         wo7RtL3eUk9MmRb3f6BvqwYzjjL5PRolBpdWbh7Ib6LJEwp32/2BUelneNEj+k64uMLK
         y3uOaO/LZAc1ctVMTfFXJbAy8rBfO1utUGwwSPgQN2BBiEcUeIs8eSpL9SUxqXhRsEju
         ydLw==
X-Gm-Message-State: AOAM532rf2WauL8hkbbjJBbsG4I1jf5v2VS2zOK7E37HbOpVMTSYd4jS
        WiOIa6Ov0q9YpI8VTVgdXHD23Z17MyC4hg==
X-Google-Smtp-Source: ABdhPJyHZlc/wKZVNiGVVK5v6GMvC0T272KKee0SGWMzIEu8O5+QDbwSKuX3pulgf7EhvOdSb9R5eA==
X-Received: by 2002:a02:c761:: with SMTP id k1mr3918208jao.74.1634645318919;
        Tue, 19 Oct 2021 05:08:38 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m10sm8622544ila.13.2021.10.19.05.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:08:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: change plugging to use a singly linked list
Date:   Tue, 19 Oct 2021 06:08:33 -0600
Message-Id: <20211019120834.595160-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019120834.595160-1-axboe@kernel.dk>
References: <20211019120834.595160-1-axboe@kernel.dk>
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
 block/blk-core.c       |  4 +--
 block/blk-merge.c      |  4 +--
 block/blk-mq.c         | 80 ++++++++++++++++++++++++------------------
 include/linux/blkdev.h |  5 ++-
 4 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0c2e11411d0..14d20909f61a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1550,7 +1550,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 	if (tsk->plug)
 		return;
 
-	INIT_LIST_HEAD(&plug->mq_list);
+	plug->mq_list = NULL;
 	plug->cached_rq = NULL;
 	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
 	plug->rq_count = 0;
@@ -1640,7 +1640,7 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
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
index 82d8ad837057..620233b85af2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2149,34 +2149,46 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 
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
@@ -2356,16 +2368,15 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 
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
+	rq->rq_next = NULL;
+	rq_list_add(&plug->mq_list, rq);
+	plug->rq_count++;
 }
 
 /*
@@ -2477,13 +2488,15 @@ void blk_mq_submit_bio(struct bio *bio)
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
@@ -2503,10 +2516,7 @@ void blk_mq_submit_bio(struct bio *bio)
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
index abe721591e80..80668e316eea 100644
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
@@ -760,8 +760,7 @@ static inline bool blk_needs_flush_plug(struct task_struct *tsk)
 	struct blk_plug *plug = tsk->plug;
 
 	return plug &&
-		 (!list_empty(&plug->mq_list) ||
-		 !list_empty(&plug->cb_list));
+		 (plug->mq_list || !list_empty(&plug->cb_list));
 }
 
 int blkdev_issue_flush(struct block_device *bdev);
-- 
2.33.1

