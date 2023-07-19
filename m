Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE57C0015E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 18:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjGSSXU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjGSSXT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 14:23:19 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FFE1FD9
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 11:23:18 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b89e10d356so46235515ad.3
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 11:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689790997; x=1692382997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieODJHKrtRMWFM3HYy2VJVeJK1X6Tdhz5Qq8QKeRaN0=;
        b=Za+5W60vceIdfu01OFA8tlgdjqGGIlxmdrx8MtA2b5QRBb7TOYIwHLrFhRbzNW4pcm
         zErCQ+9465P2hrxwnbOs3B9bUi0r3pJEu4zLaZx7ris8ydagLUNzGkY6ISludop7WoTp
         fBYgkhC0zq7fSj8noNFG6+WGOokkT+fFaGEYgBHsTHMmE+KUTAIIgLwWrU7v0EJ2Ahyp
         +zVst2NTxrrb0BQrU1aZ6Dqk7TBTqMdPmdkHx0D+HfiMA8+xt7oEbRzqD/b+11FaLjDm
         yoX6wnW71Gyo9BPhA4ZG0tBmJ/poMgVdY1QBxfhu536WYBarkH8+7lcRxPLhPRwT5/8R
         4bdA==
X-Gm-Message-State: ABy/qLZ5bYlLvuqprfop1X4Lk34t4M2ZIvcm+mid3yFwtG+8BrjtOWwt
        Nd+mpGCTAkVYoJMAiYXAR4o=
X-Google-Smtp-Source: APBJJlFRQGO/WyivZOhv1uh7JpVAJNgR1y/Iiqcm+HSV+E1qZwx9xTJzvrE/JCsBRxjiTGV8iFVdqw==
X-Received: by 2002:a17:902:c3d5:b0:1b3:b3c5:1d1f with SMTP id j21-20020a170902c3d500b001b3b3c51d1fmr5638008plj.8.1689790997353;
        Wed, 19 Jul 2023 11:23:17 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a2ab:183f:c76c:d30d])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001bb33ee4057sm4316061pls.43.2023.07.19.11.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:23:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 3/3] block: Improve performance for BLK_MQ_F_BLOCKING drivers
Date:   Wed, 19 Jul 2023 11:22:42 -0700
Message-ID: <20230719182243.2810134-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230719182243.2810134-1-bvanassche@acm.org>
References: <20230719182243.2810134-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_run_queue() runs the queue asynchronously if BLK_MQ_F_BLOCKING
has been set. This is suboptimal since running the queue asynchronously
is slower than running the queue synchronously. This patch modifies
blk_mq_run_queue() as follows if BLK_MQ_F_BLOCKING has been set:
- Run the queue synchronously if it is allowed to sleep.
- Run the queue asynchronously if it is not allowed to sleep.
Additionally, blk_mq_run_hw_queue(hctx, false) calls are modified into
blk_mq_run_hw_queue(hctx, hctx->flags & BLK_MQ_F_BLOCKING) if the caller
may be invoked from atomic context.

The following caller chains have been reviewed:

blk_mq_run_hw_queue(hctx, false)
  blk_mq_get_tag()      /* may sleep, hence the functions it calls may also sleep */
  blk_execute_rq_nowait()
    nvme_*()            /* the NVMe driver does not set BLK_MQ_F_BLOCKING */
    scsi_eh_lock_door() /* may sleep */
    sg_common_write()   /* implements an ioctl and hence may sleep */
    st_scsi_execute()   /* may sleep */
    pscsi_execute_cmd() /* may sleep */
    ufshpb_execute_umap_req()  /* may sleep */
    ufshbp_execute_map_req()   /* may sleep */
  blk_execute_rq()             /* may sleep */
  blk_mq_run_hw_queues(q, async=false)
    blk_freeze_queue_start()   /* may sleep */
    blk_mq_requeue_work()      /* may sleep */
    scsi_kick_queue()
      scsi_requeue_run_queue() /* may sleep */
      scsi_run_host_queues()
        scsi_ioctl_reset()     /* may sleep */
  blk_mq_insert_requests(hctx, ctx, list, run_queue_async=false)
    blk_mq_dispatch_plug_list(plug, from_sched=false)
      blk_mq_flush_plug_list(plug, from_schedule=false)
        __blk_flush_plug(plug, from_schedule=false)
	blk_add_rq_to_plug()
	  blk_execute_rq_nowait() /* see above */
	  blk_mq_submit_bio()  /* may sleep if REQ_NOWAIT has not been set */
  blk_mq_plug_issue_direct()
    blk_mq_flush_plug_list()   /* see above */
  blk_mq_dispatch_plug_list(plug, from_sched=false)
    blk_mq_flush_plug_list()   /* see above */
  blk_mq_try_issue_directly()
    blk_mq_submit_bio()        /* may sleep if REQ_NOWAIT has not been set */
  blk_mq_try_issue_list_directly(hctx, list)
    blk_mq_insert_requests() /* see above */

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c          | 17 +++++++++++------
 drivers/scsi/scsi_lib.c |  3 ++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5504719b970d..d5ab0bd8b472 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1289,7 +1289,8 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
  *
  * Description:
  *    Insert a fully prepared request at the back of the I/O scheduler queue
- *    for execution.  Don't wait for completion.
+ *    for execution. Don't wait for completion. May sleep if BLK_MQ_F_BLOCKING
+ *    has been set.
  *
  * Note:
  *    This function will invoke @done directly if the queue is dead.
@@ -2213,6 +2214,8 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	 */
 	WARN_ON_ONCE(!async && in_interrupt());
 
+	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
+
 	/*
 	 * When queue is quiesced, we may be switching io scheduler, or
 	 * updating nr_hw_queues, or other things, and we can't run queue
@@ -2228,8 +2231,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	if (!need_run)
 		return;
 
-	if (async || (hctx->flags & BLK_MQ_F_BLOCKING) ||
-	    !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
+	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 		blk_mq_delay_run_hw_queue(hctx, 0);
 		return;
 	}
@@ -2364,7 +2366,7 @@ void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
 	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
 
-	blk_mq_run_hw_queue(hctx, false);
+	blk_mq_run_hw_queue(hctx, hctx->flags & BLK_MQ_F_BLOCKING);
 }
 EXPORT_SYMBOL(blk_mq_start_hw_queue);
 
@@ -2394,7 +2396,8 @@ void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async)
 	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_start_stopped_hw_queue(hctx, async);
+		blk_mq_start_stopped_hw_queue(hctx, async ||
+					(hctx->flags & BLK_MQ_F_BLOCKING));
 }
 EXPORT_SYMBOL(blk_mq_start_stopped_hw_queues);
 
@@ -2452,6 +2455,8 @@ static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
 	list_for_each_entry(rq, list, queuelist) {
 		BUG_ON(rq->mq_ctx != ctx);
 		trace_block_rq_insert(rq);
+		if (rq->cmd_flags & REQ_NOWAIT)
+			run_queue_async = true;
 	}
 
 	spin_lock(&ctx->lock);
@@ -2612,7 +2617,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	if ((rq->rq_flags & RQF_USE_SCHED) || !blk_mq_get_budget_and_tag(rq)) {
 		blk_mq_insert_request(rq, 0);
-		blk_mq_run_hw_queue(hctx, false);
+		blk_mq_run_hw_queue(hctx, rq->cmd_flags & REQ_NOWAIT);
 		return;
 	}
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 7043ca0f4da9..84fb0feb047f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -335,7 +335,8 @@ static void scsi_single_lun_run(struct scsi_device *current_sdev)
 	 * but in most cases, we will be first. Ideally, each LU on the
 	 * target would get some limited time or requests on the target.
 	 */
-	blk_mq_run_hw_queues(current_sdev->request_queue, false);
+	blk_mq_run_hw_queues(current_sdev->request_queue,
+			     shost->queuecommand_may_block);
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	if (!starget->starget_sdev_user)
