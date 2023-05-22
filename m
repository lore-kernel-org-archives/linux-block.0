Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32009C7EE2D
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 18:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjEVSjY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 14:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjEVSjX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 14:39:23 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F96184
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:15 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-253340db64fso5893100a91.2
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780755; x=1687372755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyQCuSdlfQ9MwF7hqKkfSrkphJLREhUYyUpnterRbAg=;
        b=lkZjpUoA2Zv7g+IFu90QtwyexPmzl/Q/8EfXiv3ernroH4SiXCMOqlrfd09WqfSWMV
         8lb49ihtXqa5ZVLUnRmpkdCNIn/yTtw4nCp5JfgOeLc5K264EF5o3ELTX8gn7QYwMRzw
         7DCBybLEkcFzxlhAiQt741zHEBkm/ILcV+/gGNyXRmM8JUZ3/dnklUAZh8vxy9XjzQSp
         QjunkWnSa1qrvWAjsSpgJi8rSw8F/OgBV9DlUGw4Lm662JOqus96Au9njP6wAA5d3Cyv
         /MC2Wuv/hbqGHtDvKRFC9qtDL7TWSEsaQ1KjpcYjLxJUZbBTywT+l/umWQnYhpHqyxfR
         9LAQ==
X-Gm-Message-State: AC+VfDzJ1gkPQE1sC5VzLex3U9UbYxG8IU7B9uUz8/hw4lr+b1sBUkE3
        aZvyKSNpV+0F8gS1spZseCEMPwQHpVw=
X-Google-Smtp-Source: ACHHUZ7dfP1SLpxOQiXbSsHySg6jSEKrWZ0j92dmlwHDEJ1ThDBz8UYk4WyugsUcreFsoZylYqIAbw==
X-Received: by 2002:a17:90b:4a0a:b0:253:4409:3c4a with SMTP id kk10-20020a17090b4a0a00b0025344093c4amr11990813pjb.28.1684780754722;
        Mon, 22 May 2023 11:39:14 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id d61-20020a17090a6f4300b0024dfbac9e2fsm6710335pjk.21.2023.05.22.11.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:39:14 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 5/7] block: Preserve the order of requeued requests
Date:   Mon, 22 May 2023 11:38:40 -0700
Message-ID: <20230522183845.354920-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522183845.354920-1-bvanassche@acm.org>
References: <20230522183845.354920-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a queue is run before all requeued requests have been sent to the I/O
scheduler, the I/O scheduler may dispatch the wrong request. Fix this by
making blk_mq_run_hw_queue() process the requeue_list instead of
blk_mq_requeue_work().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         | 63 +++++++++++++++++++++---------------------
 include/linux/blkdev.h |  1 -
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9ef6fa5d7471..52dffdc70480 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -68,6 +68,8 @@ static inline blk_qc_t blk_rq_to_qc(struct request *rq)
 static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 {
 	return !list_empty_careful(&hctx->dispatch) ||
+		!list_empty_careful(&hctx->queue->requeue_list) ||
+		!list_empty_careful(&hctx->queue->flush_list) ||
 		sbitmap_any_bit_set(&hctx->ctx_map) ||
 			blk_mq_sched_has_work(hctx);
 }
@@ -1432,52 +1434,52 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 }
 EXPORT_SYMBOL(blk_mq_requeue_request);
 
-static void blk_mq_requeue_work(struct work_struct *work)
+static void blk_mq_process_requeue_list(struct blk_mq_hw_ctx *hctx)
 {
-	struct request_queue *q =
-		container_of(work, struct request_queue, requeue_work.work);
-	LIST_HEAD(requeue_list);
-	LIST_HEAD(flush_list);
+	struct request_queue *q = hctx->queue;
 	struct request *rq, *next;
+	LIST_HEAD(at_head);
+	LIST_HEAD(at_tail);
 
-	spin_lock_irq(&q->requeue_lock);
-	list_splice_init(&q->requeue_list, &requeue_list);
-	list_splice_init(&q->flush_list, &flush_list);
-	spin_unlock_irq(&q->requeue_lock);
+	if (list_empty_careful(&q->requeue_list) &&
+	    list_empty_careful(&q->flush_list))
+		return;
 
-	list_for_each_entry_safe(rq, next, &requeue_list, queuelist) {
-		if (!(rq->rq_flags & RQF_DONTPREP)) {
+	spin_lock_irq(&q->requeue_lock);
+	list_for_each_entry_safe(rq, next, &q->requeue_list, queuelist) {
+		if (!blk_queue_sq_sched(q) && rq->mq_hctx != hctx)
+			continue;
+		if (rq->rq_flags & RQF_DONTPREP) {
+			list_move_tail(&rq->queuelist, &at_tail);
+		} else {
 			list_del_init(&rq->queuelist);
-			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
+			list_move_tail(&rq->queuelist, &at_head);
 		}
 	}
-
-	while (!list_empty(&requeue_list)) {
-		rq = list_entry(requeue_list.next, struct request, queuelist);
-		list_del_init(&rq->queuelist);
-		blk_mq_insert_request(rq, 0);
+	list_for_each_entry_safe(rq, next, &q->flush_list, queuelist) {
+		if (!blk_queue_sq_sched(q) && rq->mq_hctx != hctx)
+			continue;
+		list_move_tail(&rq->queuelist, &at_tail);
 	}
+	spin_unlock_irq(&q->requeue_lock);
 
-	while (!list_empty(&flush_list)) {
-		rq = list_entry(flush_list.next, struct request, queuelist);
-		list_del_init(&rq->queuelist);
-		blk_mq_insert_request(rq, 0);
-	}
+	list_for_each_entry_safe(rq, next, &at_head, queuelist)
+		blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
 
-	blk_mq_run_hw_queues(q, false);
+	list_for_each_entry_safe(rq, next, &at_tail, queuelist)
+		blk_mq_insert_request(rq, 0);
 }
 
 void blk_mq_kick_requeue_list(struct request_queue *q)
 {
-	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work, 0);
+	blk_mq_run_hw_queues(q, true);
 }
 EXPORT_SYMBOL(blk_mq_kick_requeue_list);
 
 void blk_mq_delay_kick_requeue_list(struct request_queue *q,
 				    unsigned long msecs)
 {
-	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work,
-				    msecs_to_jiffies(msecs));
+	blk_mq_delay_run_hw_queues(q, msecs);
 }
 EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
@@ -2244,6 +2246,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		return;
 	}
 
+	blk_mq_process_requeue_list(hctx);
 	blk_mq_run_dispatch_ops(hctx->queue,
 				blk_mq_sched_dispatch_requests(hctx));
 }
@@ -2292,7 +2295,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 		 * scheduler.
 		 */
 		if (!sq_hctx || sq_hctx == hctx ||
-		    !list_empty_careful(&hctx->dispatch))
+		    blk_mq_hctx_has_pending(hctx))
 			blk_mq_run_hw_queue(hctx, async);
 	}
 }
@@ -2328,7 +2331,7 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
 		 * scheduler.
 		 */
 		if (!sq_hctx || sq_hctx == hctx ||
-		    !list_empty_careful(&hctx->dispatch))
+		    blk_mq_hctx_has_pending(hctx))
 			blk_mq_delay_run_hw_queue(hctx, msecs);
 	}
 }
@@ -2413,6 +2416,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 	struct blk_mq_hw_ctx *hctx =
 		container_of(work, struct blk_mq_hw_ctx, run_work.work);
 
+	blk_mq_process_requeue_list(hctx);
 	blk_mq_run_dispatch_ops(hctx->queue,
 				blk_mq_sched_dispatch_requests(hctx));
 }
@@ -4237,7 +4241,6 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 	blk_mq_update_poll_flag(q);
 
-	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
 	INIT_LIST_HEAD(&q->flush_list);
 	INIT_LIST_HEAD(&q->requeue_list);
 	spin_lock_init(&q->requeue_lock);
@@ -4786,8 +4789,6 @@ void blk_mq_cancel_work_sync(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	cancel_delayed_work_sync(&q->requeue_work);
-
 	queue_for_each_hw_ctx(q, hctx, i)
 		cancel_delayed_work_sync(&hctx->run_work);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fe99948688df..f410cce7289b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -491,7 +491,6 @@ struct request_queue {
 
 	struct list_head	requeue_list;
 	spinlock_t		requeue_lock;
-	struct delayed_work	requeue_work;
 
 	struct mutex		sysfs_lock;
 	struct mutex		sysfs_dir_lock;
