Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD3EEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 20:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjFUUM4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjFUUMy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 16:12:54 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062421994
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:52 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-666e97fcc60so3034060b3a.3
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378372; x=1689970372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlNqtMA/NLqFLwOLH5w19sbFOyjaSkPm1pgBbFRwCwo=;
        b=kgphPZlN/AvUl9unI6ja3zJtmuF6iBzJVfmY9jJZsZg+y6OSlYgqKuEmTf5zkM5aRS
         5ZyGGsAWVS8AQKSq1qR7JpHKJbQk7iDh7/leLUIM/HQSvMdYV3HLr+ptQlXU+d+DrV8x
         cL+2CIhe9T6EBODpOcmRo3HXLbeYKUc3G5hMEow+QnEwI1/aM8eFsEWxvTG59kIhv86o
         FgjzVFPcsGpDEmKbRSZJX9ATgoQhbYszFaiT0ZkZmYlGdsXJ0hW9/GoOifC8WsmdPHEh
         kn6uyULK8m12BhkeU91TfkCvEL/wUy3atz5yI7zlLM5nHFsgq5SD0toAeQ3qGXi7uaai
         z0sA==
X-Gm-Message-State: AC+VfDyTsh1n3lPV6DHf4lnFCPSXLGMWJWmnOQOWy9bH0QJX2sNT7bya
        iitGSzu2AWA01RN4KSIYTL4=
X-Google-Smtp-Source: ACHHUZ5ScI1xhmFseEuHks0MXawYs1iBXGYhYjiJDkfmZjrFYb/s5rvVMocvDowZDgPcgNEkU0kTIQ==
X-Received: by 2002:a05:6a00:2daa:b0:668:71a1:2e85 with SMTP id fb42-20020a056a002daa00b0066871a12e85mr9217574pfb.8.1687378372212;
        Wed, 21 Jun 2023 13:12:52 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c0b7:6a6f:751b:b854])
        by smtp.gmail.com with ESMTPSA id h8-20020a63df48000000b00548fb73874asm3522983pgj.37.2023.06.21.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:12:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v4 7/7] block: Inline blk_mq_{,delay_}kick_requeue_list()
Date:   Wed, 21 Jun 2023 13:12:34 -0700
Message-ID: <20230621201237.796902-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230621201237.796902-1-bvanassche@acm.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch "block: Preserve the order of requeued requests" changed
blk_mq_kick_requeue_list() and blk_mq_delay_kick_requeue_list() into
blk_mq_run_hw_queues() and blk_mq_delay_run_hw_queues() calls
respectively. Inline blk_mq_{,delay_}kick_requeue_list() because these
functions are now too short to keep these as separate functions.

Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com> [ for the s390 changes ]
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-flush.c            |  4 ++--
 block/blk-mq-debugfs.c       |  2 +-
 block/blk-mq.c               | 15 +--------------
 drivers/block/ublk_drv.c     |  6 +++---
 drivers/block/xen-blkfront.c |  1 -
 drivers/md/dm-rq.c           |  6 +++---
 drivers/nvme/host/core.c     |  2 +-
 drivers/s390/block/scm_blk.c |  2 +-
 drivers/scsi/scsi_lib.c      |  2 +-
 include/linux/blk-mq.h       |  2 --
 10 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 4bfb92f58aa9..157b86fd9ccb 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -192,7 +192,7 @@ static void blk_flush_complete_seq(struct request *rq,
 		spin_lock(&hctx->requeue_lock);
 		list_add_tail(&rq->queuelist, &hctx->flush_list);
 		spin_unlock(&hctx->requeue_lock);
-		blk_mq_kick_requeue_list(q);
+		blk_mq_run_hw_queues(q, true);
 		break;
 
 	case REQ_FSEQ_DONE:
@@ -354,7 +354,7 @@ static void blk_kick_flush(struct blk_mq_hw_ctx *hctx,
 	list_add_tail(&flush_rq->queuelist, &hctx->flush_list);
 	spin_unlock(&hctx->requeue_lock);
 
-	blk_mq_kick_requeue_list(q);
+	blk_mq_run_hw_queues(q, true);
 }
 
 static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 787bdff3cc64..76792ebab935 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -114,7 +114,7 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 	} else if (strcmp(op, "start") == 0) {
 		blk_mq_start_stopped_hw_queues(q, true);
 	} else if (strcmp(op, "kick") == 0) {
-		blk_mq_kick_requeue_list(q);
+		blk_mq_run_hw_queues(q, true);
 	} else {
 		pr_err("%s: unsupported operation '%s'\n", __func__, op);
 inval:
diff --git a/block/blk-mq.c b/block/blk-mq.c
index de39984d17c4..12fd8b65b930 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1436,7 +1436,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 	spin_unlock_irqrestore(&hctx->requeue_lock, flags);
 
 	if (kick_requeue_list)
-		blk_mq_kick_requeue_list(q);
+		blk_mq_run_hw_queues(q, true);
 }
 EXPORT_SYMBOL(blk_mq_requeue_request);
 
@@ -1473,19 +1473,6 @@ static void blk_mq_process_requeue_list(struct blk_mq_hw_ctx *hctx)
 	}
 }
 
-void blk_mq_kick_requeue_list(struct request_queue *q)
-{
-	blk_mq_run_hw_queues(q, true);
-}
-EXPORT_SYMBOL(blk_mq_kick_requeue_list);
-
-void blk_mq_delay_kick_requeue_list(struct request_queue *q,
-				    unsigned long msecs)
-{
-	blk_mq_delay_run_hw_queues(q, msecs);
-}
-EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
-
 static bool blk_mq_rq_inflight(struct request *rq, void *priv)
 {
 	/*
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1c823750c95a..cddbbdc9b199 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -902,7 +902,7 @@ static inline void __ublk_rq_task_work(struct request *req,
 		 */
 		if (unlikely(!mapped_bytes)) {
 			blk_mq_requeue_request(req, false);
-			blk_mq_delay_kick_requeue_list(req->q,
+			blk_mq_delay_run_hw_queues(req->q,
 					UBLK_REQUEUE_DELAY_MS);
 			return;
 		}
@@ -1297,7 +1297,7 @@ static void ublk_unquiesce_dev(struct ublk_device *ub)
 
 	blk_mq_unquiesce_queue(ub->ub_disk->queue);
 	/* We may have requeued some rqs in ublk_quiesce_queue() */
-	blk_mq_kick_requeue_list(ub->ub_disk->queue);
+	blk_mq_run_hw_queues(ub->ub_disk->queue, true);
 }
 
 static void ublk_stop_dev(struct ublk_device *ub)
@@ -2341,7 +2341,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	blk_mq_unquiesce_queue(ub->ub_disk->queue);
 	pr_devel("%s: queue unquiesced, dev id %d.\n",
 			__func__, header->dev_id);
-	blk_mq_kick_requeue_list(ub->ub_disk->queue);
+	blk_mq_run_hw_queues(ub->ub_disk->queue, true);
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
 	ret = 0;
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 52e74adbaad6..b8ac217c92b6 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2040,7 +2040,6 @@ static int blkif_recover(struct blkfront_info *info)
 		blk_mq_requeue_request(req, false);
 	}
 	blk_mq_start_stopped_hw_queues(info->rq, true);
-	blk_mq_kick_requeue_list(info->rq);
 
 	while ((bio = bio_list_pop(&info->bio_list)) != NULL) {
 		/* Traverse the list of pending bios and re-queue them */
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index bbe1e2ea0aa4..6421cc2c9852 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -64,7 +64,7 @@ int dm_request_based(struct mapped_device *md)
 void dm_start_queue(struct request_queue *q)
 {
 	blk_mq_unquiesce_queue(q);
-	blk_mq_kick_requeue_list(q);
+	blk_mq_run_hw_queues(q, true);
 }
 
 void dm_stop_queue(struct request_queue *q)
@@ -170,14 +170,14 @@ static void dm_end_request(struct request *clone, blk_status_t error)
 
 void dm_mq_kick_requeue_list(struct mapped_device *md)
 {
-	blk_mq_kick_requeue_list(md->queue);
+	blk_mq_run_hw_queues(md->queue, true);
 }
 EXPORT_SYMBOL(dm_mq_kick_requeue_list);
 
 static void dm_mq_delay_requeue_request(struct request *rq, unsigned long msecs)
 {
 	blk_mq_requeue_request(rq, false);
-	blk_mq_delay_kick_requeue_list(rq->q, msecs);
+	blk_mq_delay_run_hw_queues(rq->q, msecs);
 }
 
 static void dm_requeue_original_request(struct dm_rq_target_io *tio, bool delay_requeue)
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5dd6d8c7e1d..9b923d52e41c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -303,7 +303,7 @@ static void nvme_retry_req(struct request *req)
 
 	nvme_req(req)->retries++;
 	blk_mq_requeue_request(req, false);
-	blk_mq_delay_kick_requeue_list(req->q, delay);
+	blk_mq_delay_run_hw_queues(req->q, delay);
 }
 
 static void nvme_log_error(struct request *req)
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 0c1df1d5f1ac..fe5937d28fdc 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -243,7 +243,7 @@ static void scm_request_requeue(struct scm_request *scmrq)
 
 	atomic_dec(&bdev->queued_reqs);
 	scm_request_done(scmrq);
-	blk_mq_kick_requeue_list(bdev->rq);
+	blk_mq_run_hw_queues(bdev->rq, true);
 }
 
 static void scm_request_finish(struct scm_request *scmrq)
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0226c9279cef..2aa3c147e12f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -124,7 +124,7 @@ static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd, unsigned long msecs)
 
 	if (msecs) {
 		blk_mq_requeue_request(rq, false);
-		blk_mq_delay_kick_requeue_list(rq->q, msecs);
+		blk_mq_delay_run_hw_queues(rq->q, msecs);
 	} else
 		blk_mq_requeue_request(rq, true);
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b919de53dc28..80761e7c4ea5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -871,8 +871,6 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 }
 
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
-void blk_mq_kick_requeue_list(struct request_queue *q);
-void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
 bool blk_mq_complete_request_remote(struct request *rq);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
