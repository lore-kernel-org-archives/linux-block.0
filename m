Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3495C77B6C
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 23:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDGX6w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDGX6v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 19:58:51 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A01EFB3
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 16:58:48 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso2602132pjm.3
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 16:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911928; x=1683503928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVd5wUXmRsxnNJj2KiM91aTH9y1P0rN3yll+bZuK3Wo=;
        b=ytlT0wuoZyK8ZnrpROGkTJaORqj40R0kmXmUlfgYaRUy1VEhH2LvRtm4Cb9bDNhMSz
         4WEPUp/ftxYTCQKZOUg6K0u/ZC8BoP7cw/0iJo4bdhNhTS6W43mb78aaFIqLxqJaoqWt
         wjzzu+YsC7RvrwgUUjBmLPoDjt4slM3AXY2ao4NP6dNO9wHOUZTCSJM/VCts8VlvQHqZ
         +XtIma1EbJx459V9jAuOYMG+PUf6haD6lBxDAYVppuoRfdr/Y89mU7uu6d22PBBXg6cH
         zHEh9NQZIYLoNVdMPvXfmmEjaC1AnOXoIkMIJMVFmUfVuj8ScuQw+exUoseK3c2wyeUH
         6uIg==
X-Gm-Message-State: AAQBX9eHxci+t8zf9ZiBaSecIc6luCksNlGD0rXRj05bhydyRxf6CgSe
        CFbgpQpH45hEf6Gxs/wYfGY=
X-Google-Smtp-Source: AKy350YjKJ70JDL8SiGTQTnvR22Ip3RrTUEIq/heWq5DUOaOTCqfLHehQxfnaLN2OpOlzRg4SZ10kw==
X-Received: by 2002:a05:6a20:a928:b0:cd:fc47:ddbf with SMTP id cd40-20020a056a20a92800b000cdfc47ddbfmr4141685pzb.47.1680911928099;
        Fri, 07 Apr 2023 16:58:48 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm3556003pfh.56.2023.04.07.16.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:58:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 06/12] block: Preserve the order of requeued requests
Date:   Fri,  7 Apr 2023 16:58:16 -0700
Message-Id: <20230407235822.1672286-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407235822.1672286-1-bvanassche@acm.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a queue is run before all requeued requests have been sent to the I/O
scheduler, the I/O scheduler may dispatch the wrong request. Fix this by
making __blk_mq_run_hw_queue() process the requeue_list instead of
blk_mq_requeue_work().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         | 35 ++++++++++-------------------------
 include/linux/blk-mq.h |  1 -
 2 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index deb3d08a6b26..562868dff43f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -64,6 +64,7 @@ static inline blk_qc_t blk_rq_to_qc(struct request *rq)
 static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 {
 	return !list_empty_careful(&hctx->dispatch) ||
+		!list_empty_careful(&hctx->requeue_list) ||
 		sbitmap_any_bit_set(&hctx->ctx_map) ||
 			blk_mq_sched_has_work(hctx);
 }
@@ -1409,10 +1410,8 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 }
 EXPORT_SYMBOL(blk_mq_requeue_request);
 
-static void blk_mq_requeue_work(struct work_struct *work)
+static void blk_mq_process_requeue_list(struct blk_mq_hw_ctx *hctx)
 {
-	struct blk_mq_hw_ctx *hctx =
-		container_of(work, struct blk_mq_hw_ctx, requeue_work.work);
 	LIST_HEAD(rq_list);
 	struct request *rq, *next;
 
@@ -1437,8 +1436,6 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		list_del_init(&rq->queuelist);
 		blk_mq_sched_insert_request(rq, false, false, false);
 	}
-
-	blk_mq_run_hw_queue(hctx, false);
 }
 
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
@@ -1464,30 +1461,19 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 	spin_unlock_irqrestore(&hctx->requeue_lock, flags);
 
 	if (kick_requeue_list)
-		blk_mq_kick_requeue_list(rq->q);
+		blk_mq_run_hw_queue(hctx, /*async=*/true);
 }
 
 void blk_mq_kick_requeue_list(struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
-	unsigned long i;
-
-	queue_for_each_hw_ctx(q, hctx, i)
-		kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND,
-					    &hctx->requeue_work, 0);
+	blk_mq_run_hw_queues(q, true);
 }
 EXPORT_SYMBOL(blk_mq_kick_requeue_list);
 
 void blk_mq_delay_kick_requeue_list(struct request_queue *q,
 				    unsigned long msecs)
 {
-	struct blk_mq_hw_ctx *hctx;
-	unsigned long i;
-
-	queue_for_each_hw_ctx(q, hctx, i)
-		kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND,
-					    &hctx->requeue_work,
-					    msecs_to_jiffies(msecs));
+	blk_mq_delay_run_hw_queues(q, msecs);
 }
 EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
@@ -2146,6 +2132,8 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	 */
 	WARN_ON_ONCE(in_interrupt());
 
+	blk_mq_process_requeue_list(hctx);
+
 	blk_mq_run_dispatch_ops(hctx->queue,
 			blk_mq_sched_dispatch_requests(hctx));
 }
@@ -2317,7 +2305,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 		 * scheduler.
 		 */
 		if (!sq_hctx || sq_hctx == hctx ||
-		    !list_empty_careful(&hctx->dispatch))
+		    blk_mq_hctx_has_pending(hctx))
 			blk_mq_run_hw_queue(hctx, async);
 	}
 }
@@ -2353,7 +2341,7 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
 		 * scheduler.
 		 */
 		if (!sq_hctx || sq_hctx == hctx ||
-		    !list_empty_careful(&hctx->dispatch))
+		    blk_mq_hctx_has_pending(hctx))
 			blk_mq_delay_run_hw_queue(hctx, msecs);
 	}
 }
@@ -3608,7 +3596,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
 {
-	INIT_DELAYED_WORK(&hctx->requeue_work, blk_mq_requeue_work);
 	INIT_LIST_HEAD(&hctx->requeue_list);
 	spin_lock_init(&hctx->requeue_lock);
 
@@ -4771,10 +4758,8 @@ void blk_mq_cancel_work_sync(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		cancel_delayed_work_sync(&hctx->requeue_work);
+	queue_for_each_hw_ctx(q, hctx, i)
 		cancel_delayed_work_sync(&hctx->run_work);
-	}
 }
 
 static int __init blk_mq_init(void)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0157f1569980..e62feb17af96 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -313,7 +313,6 @@ struct blk_mq_hw_ctx {
 
 	struct list_head	requeue_list;
 	spinlock_t		requeue_lock;
-	struct delayed_work	requeue_work;
 
 	/**
 	 * @run_work: Used for scheduling a hardware queue run at a later time.
