Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A0AC4332F
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B109610C8
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhJRRxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbhJRRxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 13:53:25 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3477C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:13 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y67so17227253iof.10
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHdWo5JlPcrT5ny9e2xXLs7Ss2obuQA7vRyruQpssLs=;
        b=dh+8RZ+gUJBSgu3ijYn8rYkrAMNcTC1VEK2abmNh6zBMaNjF24PxT3h4z++MyjvYH1
         TCrkqkZ5X8MR44nhaWzYPuwRVZmnSWqwcs3LSGJULSSmO53Vp+SITASt3Ghlc44jFNb7
         CykIXr7XuKx+NHAXp7u6vtDl3v7JV3Xf5Jn2kr91nUOmHWlZSKqH0q9NDS8W+HW4q3Mc
         V4zPnDsAZbmypH0cFuA/svtwTs96yh1yaSB2jocP6wIFoNavINQJa5OeytRx7lbFIoA5
         1lBRwZzF+dJQx3lRmusKC8OEswZKmJ/T7mxLhREmJB2Twqoz0x22Ku6K7GdYoWgXUR8D
         csPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHdWo5JlPcrT5ny9e2xXLs7Ss2obuQA7vRyruQpssLs=;
        b=dM8NE6m0tcmysXyGIaKjEG/zbMJRr55FaVy2kGSO9IzFQOUHhakffh6aIlZYkDRJqH
         dQCdV7GrHiqYdrhbZ5U/hGu7vUDTRMZN/x6hZA1KhzEiY/ETkAGC3xYk3iuEj1vAC2Ap
         lfBeNkqb/e3QmUf69/+JEXfgi5f069sohFU/dwV0eyo0ILDYV+XLa+bk0/bGEjFUWMPx
         3Ul4agDVUoB9qWAt+vkkkcyJZTPL26xqgn9+uH6QEVtZ4LR3uQsUgZ9m3/c91M+99mDE
         Rswj4PfLLcBP7izA7opwjo+qyxK1kd3jEGVUxDVEZQvZ088qDZK7nowlRBHz5d3vIkVs
         L/WA==
X-Gm-Message-State: AOAM530ZBPUdH95G6ggxgFhrSZgzZi1t5jynC0hvd0EuIp61jOdLfFWY
        wkZfVcLiaFLyzBICG5jNwyKyJOS9Og4T/A==
X-Google-Smtp-Source: ABdhPJxa/HaNYOdtT2bPcoWkljamtjQ+kisWTeNylgcFXnep42QnNj+4W5IVt3CGtIdeMJ5dUFPXIA==
X-Received: by 2002:a05:6602:1546:: with SMTP id h6mr15133840iow.125.1634579473143;
        Mon, 18 Oct 2021 10:51:13 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v17sm7380017ilh.67.2021.10.18.10.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:51:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] block: return whether or not to unplug through boolean
Date:   Mon, 18 Oct 2021 11:51:05 -0600
Message-Id: <20211018175109.401292-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018175109.401292-1-axboe@kernel.dk>
References: <20211018175109.401292-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of returning the same queue request through a request pointer,
use a boolean to accomplish the same.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-merge.c | 11 +++++------
 block/blk-mq.c    | 16 +++++++++-------
 block/blk.h       |  2 +-
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index ec727234ac48..c273b58378ce 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1067,9 +1067,8 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
  * @q: request_queue new bio is being queued at
  * @bio: new bio being queued
  * @nr_segs: number of segments in @bio
- * @same_queue_rq: pointer to &struct request that gets filled in when
- * another request associated with @q is found on the plug list
- * (optional, may be %NULL)
+ * @same_queue_rq: output value, will be true if there's an existing request
+ * from the passed in @q already in the plug list
  *
  * Determine whether @bio being queued on @q can be merged with the previous
  * request on %current's plugged list.  Returns %true if merge was successful,
@@ -1085,7 +1084,7 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
  * Caller must ensure !blk_queue_nomerges(q) beforehand.
  */
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs, struct request **same_queue_rq)
+		unsigned int nr_segs, bool *same_queue_rq)
 {
 	struct blk_plug *plug;
 	struct request *rq;
@@ -1096,12 +1095,12 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 
 	/* check the previously added entry for a quick merge attempt */
 	rq = list_last_entry(&plug->mq_list, struct request, queuelist);
-	if (rq->q == q && same_queue_rq) {
+	if (rq->q == q) {
 		/*
 		 * Only blk-mq multiple hardware queues case checks the rq in
 		 * the same queue, there should be only one such rq in a queue
 		 */
-		*same_queue_rq = rq;
+		*same_queue_rq = true;
 	}
 	if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK)
 		return true;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3ef55f76701..d957b6812a98 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2422,7 +2422,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
 	struct request *rq;
 	struct blk_plug *plug;
-	struct request *same_queue_rq = NULL;
+	bool same_queue_rq = false;
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
@@ -2515,6 +2515,8 @@ void blk_mq_submit_bio(struct bio *bio)
 		/* Insert the request at the IO scheduler queue */
 		blk_mq_sched_insert_request(rq, false, true, true);
 	} else if (plug && !blk_queue_nomerges(q)) {
+		struct request *next_rq = NULL;
+
 		/*
 		 * We do limited plugging. If the bio can be merged, do that.
 		 * Otherwise the existing request in the plug list will be
@@ -2522,19 +2524,19 @@ void blk_mq_submit_bio(struct bio *bio)
 		 * The plug list might get flushed before this. If that happens,
 		 * the plug list is empty, and same_queue_rq is invalid.
 		 */
-		if (list_empty(&plug->mq_list))
-			same_queue_rq = NULL;
 		if (same_queue_rq) {
-			list_del_init(&same_queue_rq->queuelist);
+			next_rq = list_last_entry(&plug->mq_list,
+							struct request,
+							queuelist);
+			list_del_init(&next_rq->queuelist);
 			plug->rq_count--;
 		}
 		blk_add_rq_to_plug(plug, rq);
 		trace_block_plug(q);
 
-		if (same_queue_rq) {
+		if (next_rq) {
 			trace_block_unplug(q, 1, true);
-			blk_mq_try_issue_directly(same_queue_rq->mq_hctx,
-						  same_queue_rq);
+			blk_mq_try_issue_directly(next_rq->mq_hctx, next_rq);
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) ||
 		   !rq->mq_hctx->dispatch_busy) {
diff --git a/block/blk.h b/block/blk.h
index e80350327e6d..b9729c12fd62 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -218,7 +218,7 @@ void blk_add_timer(struct request *req);
 void blk_print_req_error(struct request *req, blk_status_t status);
 
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs, struct request **same_queue_rq);
+		unsigned int nr_segs, bool *same_queue_rq);
 bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 			struct bio *bio, unsigned int nr_segs);
 
-- 
2.33.1

