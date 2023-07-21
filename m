Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4AFEB64DD
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 17:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGUR2A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjGUR1u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 13:27:50 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2618B1FD9
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:27:49 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1bb7b8390e8so685745ad.2
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960468; x=1690565268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVdtnGKSr4h+e2qX45wC9nqs5jgWEn/YAZFfZBMbJNE=;
        b=IexKfK7Orrm9fBjrHZ1teAPR/S+gxEIitnyFVDMYuZIWKAeZWHiGbbOccnm+dsWZlX
         K/glbHbAYDNG6ChZsjElvP/K5YbDBWA95P9cA+2KHzj/5Pt2Vmt9W5fScA8n/3q8fpdN
         M+LI1vaGkUKYDkMCd2CCCZY23XTnrMjItbJ/vomxhk3XBWR70AfCUlFkQJX1expF49Wt
         O/nA1A9WyiUyOAPto2b06m+wJm6xj5PGQM/jwzajt0FPX0puFz18AQHar2HhuV7Wul1U
         MV7nIDiZtiaHWgRzn8j28AnX7ldq59F32F+qpxJav/tZq+Vw1G7tVDMN8m/dUw9sAQgQ
         QfFg==
X-Gm-Message-State: ABy/qLYSD2kcyXj+xv8uHgXyVH5u/Z4xvrHeHwCIi8mfHfT2fh/Cn8jH
        xTuhHajclxBbCAtI/H0AeWM=
X-Google-Smtp-Source: APBJJlHxDYkNiRD/OqztopU978dnltSxt/5E9As89muBdXHyTB904+MNYhSv4xAh9g5f0Jj87iKBVA==
X-Received: by 2002:a17:902:d2c7:b0:1ae:626b:475f with SMTP id n7-20020a170902d2c700b001ae626b475fmr2274465plc.12.1689960468463;
        Fri, 21 Jul 2023 10:27:48 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5043:9124:70cb:43f9])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001b83db0bcf2sm3790961plb.141.2023.07.21.10.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:27:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 3/3] block: Improve performance for BLK_MQ_F_BLOCKING drivers
Date:   Fri, 21 Jul 2023 10:27:30 -0700
Message-ID: <20230721172731.955724-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230721172731.955724-1-bvanassche@acm.org>
References: <20230721172731.955724-1-bvanassche@acm.org>
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
 block/blk-mq.c          | 16 ++++++++++------
 drivers/scsi/scsi_lib.c |  3 ++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d98654869615..687ec3f4f10d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1323,7 +1323,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 	}
 
 	blk_mq_insert_request(rq, at_head ? BLK_MQ_INSERT_AT_HEAD : 0);
-	blk_mq_run_hw_queue(hctx, false);
+	blk_mq_run_hw_queue(hctx, hctx->flags & BLK_MQ_F_BLOCKING);
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
@@ -2222,6 +2222,8 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	 */
 	WARN_ON_ONCE(!async && in_interrupt());
 
+	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
+
 	/*
 	 * When queue is quiesced, we may be switching io scheduler, or
 	 * updating nr_hw_queues, or other things, and we can't run queue
@@ -2237,8 +2239,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	if (!need_run)
 		return;
 
-	if (async || (hctx->flags & BLK_MQ_F_BLOCKING) ||
-	    !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
+	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 		blk_mq_delay_run_hw_queue(hctx, 0);
 		return;
 	}
@@ -2373,7 +2374,7 @@ void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
 	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
 
-	blk_mq_run_hw_queue(hctx, false);
+	blk_mq_run_hw_queue(hctx, hctx->flags & BLK_MQ_F_BLOCKING);
 }
 EXPORT_SYMBOL(blk_mq_start_hw_queue);
 
@@ -2403,7 +2404,8 @@ void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async)
 	unsigned long i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_start_stopped_hw_queue(hctx, async);
+		blk_mq_start_stopped_hw_queue(hctx, async ||
+					(hctx->flags & BLK_MQ_F_BLOCKING));
 }
 EXPORT_SYMBOL(blk_mq_start_stopped_hw_queues);
 
@@ -2461,6 +2463,8 @@ static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
 	list_for_each_entry(rq, list, queuelist) {
 		BUG_ON(rq->mq_ctx != ctx);
 		trace_block_rq_insert(rq);
+		if (rq->cmd_flags & REQ_NOWAIT)
+			run_queue_async = true;
 	}
 
 	spin_lock(&ctx->lock);
@@ -2621,7 +2625,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	if ((rq->rq_flags & RQF_USE_SCHED) || !blk_mq_get_budget_and_tag(rq)) {
 		blk_mq_insert_request(rq, 0);
-		blk_mq_run_hw_queue(hctx, false);
+		blk_mq_run_hw_queue(hctx, rq->cmd_flags & REQ_NOWAIT);
 		return;
 	}
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d4c514ab9fe8..59176946ab56 100644
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
