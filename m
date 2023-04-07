Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6D2C77B6C
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjDGAR1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjDGARY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:24 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBF5A268
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:23 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso7046558pjc.1
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826642; x=1683418642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVHpa3RBUUBBIeyy2cZDzappozjgYO7NgaywNZc71qk=;
        b=YLw7R+hB5BRdWNIAf7H+qANQnVASyuyVHeKDu4oKyNt4ygzIfgPlSSBlXuDlyQ6Ci/
         LJ+43mxPTFG0IdcZHI8mR4GAoPChPlD9aD9vOD1ZZ9kJDXEPPsbjhaHSTUyeM9Vpp6Tt
         i3k8mxD3Ur0bk649Wkf9lppOiSmlXdA5ekndfOW32VswJkjk39/1WWKiDb64/bd3DV4O
         anWB0mwlplPY2/OAd+CiSkVg2PqzZwwLi6SjX08+zKdYhdH6QH3WFcFrrjz4sjReLVFd
         ib8kWx5aVPh5MxBPXAoHUPF0nlaD/IoFXjnGGA5adfE7umO8QfwDqrSJsD9a8O8HSptA
         Rr3g==
X-Gm-Message-State: AAQBX9dsbtwtFv419Wl4c1cD7hd7aOLntHs2veSchkVICwfa2cedWEDO
        zacmMdAwO4wE1zNCmGqlhR4=
X-Google-Smtp-Source: AKy350ZBGqjFxPPQt1uT8NyhT3UxswMD4gri3uf63iYHcBhMPGC+hKXAk5HS5Qh3A/q009ef6yydcA==
X-Received: by 2002:a17:903:2308:b0:1a1:a6e5:764b with SMTP id d8-20020a170903230800b001a1a6e5764bmr772143plh.60.1680826642553;
        Thu, 06 Apr 2023 17:17:22 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 06/12] block: Preserve the order of requeued requests
Date:   Thu,  6 Apr 2023 17:17:04 -0700
Message-Id: <20230407001710.104169-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407001710.104169-1-bvanassche@acm.org>
References: <20230407001710.104169-1-bvanassche@acm.org>
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
index 1e285b0cfba3..2cf317d49f56 100644
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
@@ -1465,30 +1462,19 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 	spin_unlock_irqrestore(&hctx->requeue_lock, flags);
 
 	if (kick_requeue_list)
-		blk_mq_kick_requeue_list(q);
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
 
@@ -2148,6 +2134,8 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	 */
 	WARN_ON_ONCE(in_interrupt());
 
+	blk_mq_process_requeue_list(hctx);
+
 	blk_mq_run_dispatch_ops(hctx->queue,
 			blk_mq_sched_dispatch_requests(hctx));
 }
@@ -2319,7 +2307,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 		 * scheduler.
 		 */
 		if (!sq_hctx || sq_hctx == hctx ||
-		    !list_empty_careful(&hctx->dispatch))
+		    blk_mq_hctx_has_pending(hctx))
 			blk_mq_run_hw_queue(hctx, async);
 	}
 }
@@ -2355,7 +2343,7 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
 		 * scheduler.
 		 */
 		if (!sq_hctx || sq_hctx == hctx ||
-		    !list_empty_careful(&hctx->dispatch))
+		    blk_mq_hctx_has_pending(hctx))
 			blk_mq_delay_run_hw_queue(hctx, msecs);
 	}
 }
@@ -3610,7 +3598,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
 {
-	INIT_DELAYED_WORK(&hctx->requeue_work, blk_mq_requeue_work);
 	INIT_LIST_HEAD(&hctx->requeue_list);
 	spin_lock_init(&hctx->requeue_lock);
 
@@ -4773,10 +4760,8 @@ void blk_mq_cancel_work_sync(struct request_queue *q)
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
