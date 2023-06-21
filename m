Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99933EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 20:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFUUMw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjFUUMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 16:12:51 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E32C19A3
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:49 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6b46e61638eso3761164a34.0
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378369; x=1689970369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Clbav+Trh8rV2/QmiqkhRbWinTcibsRagbDuQgd11cs=;
        b=S7I8h22hnSSYOXQQVC5Zr9L0Z1g+c4/0TX5HYPyg1XOScT0Ao4VwbVLWjGoPbXLWdn
         tiE4nsFyrWDZ3tRG7yRMCl20KqQGsxrRIGmS2GsmzbdwGd150yY8iEefNUm0Bv0XBw3i
         z2YMfccpHzxPeWtopJr1dAkukXLRfU1SQOHRDln6esqB/tN+7MuVW+qclUpSzKaGEfVm
         lCR+xh2NZkrofFyuz2zd5d4S9L2L9sPa/Nwbey4wOddmfvpBnp3g8v3hJYiU0zSelzlk
         Nf13pU97HjWlr2SzyMO412X9VwwM8qxyK3AsQzvxbvyj6sWy/hIX3byNeAOOc3+9A45Y
         TkWA==
X-Gm-Message-State: AC+VfDx4i4fTvbmP3i1X5pKyIsHLiVLS6FaT8vGaQTtGD8ef5in8gXgx
        mb4+qqH63YbuooqcBP6gTsM=
X-Google-Smtp-Source: ACHHUZ4RGSrHQ9PSNSwaEbdYMZ/1zUWXYafiRw8wXK45sy8Ll5/aLAQGJvfl4TFZjAyBs4Wj5MEozA==
X-Received: by 2002:a05:6358:c6a3:b0:131:eb9:2916 with SMTP id fe35-20020a056358c6a300b001310eb92916mr3076287rwb.27.1687378368792;
        Wed, 21 Jun 2023 13:12:48 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c0b7:6a6f:751b:b854])
        by smtp.gmail.com with ESMTPSA id h8-20020a63df48000000b00548fb73874asm3522983pgj.37.2023.06.21.13.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:12:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v4 5/7] block: Preserve the order of requeued requests
Date:   Wed, 21 Jun 2023 13:12:32 -0700
Message-ID: <20230621201237.796902-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230621201237.796902-1-bvanassche@acm.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
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
 block/blk-mq.c         | 31 +++++++++----------------------
 include/linux/blk-mq.h |  1 -
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c359a28d9b25..de39984d17c4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -68,6 +68,8 @@ static inline blk_qc_t blk_rq_to_qc(struct request *rq)
 static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 {
 	return !list_empty_careful(&hctx->dispatch) ||
+		!list_empty_careful(&hctx->requeue_list) ||
+		!list_empty_careful(&hctx->flush_list) ||
 		sbitmap_any_bit_set(&hctx->ctx_map) ||
 			blk_mq_sched_has_work(hctx);
 }
@@ -1438,10 +1440,8 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 }
 EXPORT_SYMBOL(blk_mq_requeue_request);
 
-static void blk_mq_requeue_work(struct work_struct *work)
+static void blk_mq_process_requeue_list(struct blk_mq_hw_ctx *hctx)
 {
-	struct blk_mq_hw_ctx *hctx =
-		container_of(work, struct blk_mq_hw_ctx, requeue_work.work);
 	LIST_HEAD(requeue_list);
 	LIST_HEAD(flush_list);
 	struct request *rq;
@@ -1471,31 +1471,18 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		list_del_init(&rq->queuelist);
 		blk_mq_insert_request(rq, 0);
 	}
-
-	blk_mq_run_hw_queue(hctx, false);
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
 
@@ -2248,6 +2235,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		return;
 	}
 
+	blk_mq_process_requeue_list(hctx);
 	blk_mq_run_dispatch_ops(hctx->queue,
 				blk_mq_sched_dispatch_requests(hctx));
 }
@@ -2296,7 +2284,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 		 * scheduler.
 		 */
 		if (!sq_hctx || sq_hctx == hctx ||
-		    !list_empty_careful(&hctx->dispatch))
+		    blk_mq_hctx_has_pending(hctx))
 			blk_mq_run_hw_queue(hctx, async);
 	}
 }
@@ -2332,7 +2320,7 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
 		 * scheduler.
 		 */
 		if (!sq_hctx || sq_hctx == hctx ||
-		    !list_empty_careful(&hctx->dispatch))
+		    blk_mq_hctx_has_pending(hctx))
 			blk_mq_delay_run_hw_queue(hctx, msecs);
 	}
 }
@@ -2417,6 +2405,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 	struct blk_mq_hw_ctx *hctx =
 		container_of(work, struct blk_mq_hw_ctx, run_work.work);
 
+	blk_mq_process_requeue_list(hctx);
 	blk_mq_run_dispatch_ops(hctx->queue,
 				blk_mq_sched_dispatch_requests(hctx));
 }
@@ -3625,7 +3614,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
 {
-	INIT_DELAYED_WORK(&hctx->requeue_work, blk_mq_requeue_work);
 	INIT_LIST_HEAD(&hctx->flush_list);
 	INIT_LIST_HEAD(&hctx->requeue_list);
 	spin_lock_init(&hctx->requeue_lock);
@@ -4794,7 +4782,6 @@ void blk_mq_cancel_work_sync(struct request_queue *q)
 	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		cancel_delayed_work_sync(&hctx->requeue_work);
 		cancel_delayed_work_sync(&hctx->run_work);
 	}
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 672e8880f9e2..b919de53dc28 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -312,7 +312,6 @@ struct blk_mq_hw_ctx {
 
 	struct list_head	requeue_list;
 	spinlock_t		requeue_lock;
-	struct delayed_work	requeue_work;
 
 	/**
 	 * @run_work: Used for scheduling a hardware queue run at a later time.
