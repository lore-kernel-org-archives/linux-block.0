Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025CDC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 10:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDB720882
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 10:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDCK0r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:26:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfDCK0r (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Apr 2019 06:26:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D33037E8F;
        Wed,  3 Apr 2019 10:26:46 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7232E62A14;
        Wed,  3 Apr 2019 10:26:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: [PATCH V3 6/6] SCSI: don't hold device refcount in IO path
Date:   Wed,  3 Apr 2019 18:26:09 +0800
Message-Id: <20190403102609.18707-7-ming.lei@redhat.com>
In-Reply-To: <20190403102609.18707-1-ming.lei@redhat.com>
References: <20190403102609.18707-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 03 Apr 2019 10:26:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

scsi_device's refcount is always grabbed in IO path.

Turns out it isn't necessary, because blk_queue_cleanup() will
drain any in-flight IOs, then cancel timeout/requeue work, and
SCSI's requeue_work is canceled too in __scsi_remove_device().

Also scsi_device won't go away until blk_cleanup_queue() is done.

So don't hold the refcount in IO path, especially the refcount isn't
required in IO path since blk_queue_enter() / blk_queue_exit()
is introduced in the legacy block layer.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Cc: jianchao wang <jianchao.w.wang@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 601b9f1de267..6772d2ae1357 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -141,8 +141,6 @@ scsi_set_blocked(struct scsi_cmnd *cmd, int reason)
 
 static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
 {
-	struct scsi_device *sdev = cmd->device;
-
 	if (cmd->request->rq_flags & RQF_DONTPREP) {
 		cmd->request->rq_flags &= ~RQF_DONTPREP;
 		scsi_mq_uninit_cmd(cmd);
@@ -150,7 +148,6 @@ static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
 		WARN_ON_ONCE(true);
 	}
 	blk_mq_requeue_request(cmd->request, true);
-	put_device(&sdev->sdev_gendev);
 }
 
 /**
@@ -190,18 +187,12 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
 	cmd->result = 0;
 
 	/*
-	 * Before a SCSI command is dispatched,
-	 * get_device(&sdev->sdev_gendev) is called and the host,
-	 * target and device busy counters are increased. Since
-	 * requeuing a request causes these actions to be repeated and
-	 * since scsi_device_unbusy() has already been called,
-	 * put_device(&device->sdev_gendev) must still be called. Call
-	 * put_device() after blk_mq_requeue_request() to avoid that
-	 * removal of the SCSI device can start before requeueing has
-	 * happened.
+	 * Before a SCSI command is dispatched, the host, target and
+	 * device busy counters are increased. Since requeuing a request
+	 * causes these actions to be repeated and since scsi_device_unbusy()
+	 * has already been called.
 	 */
 	blk_mq_requeue_request(cmd->request, true);
-	put_device(&device->sdev_gendev);
 }
 
 /*
@@ -619,7 +610,6 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 		blk_mq_run_hw_queues(q, true);
 
 	percpu_ref_put(&q->q_usage_counter);
-	put_device(&sdev->sdev_gendev);
 	return false;
 }
 
@@ -1613,7 +1603,6 @@ static void scsi_mq_put_budget(struct blk_mq_hw_ctx *hctx)
 	struct scsi_device *sdev = q->queuedata;
 
 	atomic_dec(&sdev->device_busy);
-	put_device(&sdev->sdev_gendev);
 }
 
 static bool scsi_mq_get_budget(struct blk_mq_hw_ctx *hctx)
@@ -1621,16 +1610,9 @@ static bool scsi_mq_get_budget(struct blk_mq_hw_ctx *hctx)
 	struct request_queue *q = hctx->queue;
 	struct scsi_device *sdev = q->queuedata;
 
-	if (!get_device(&sdev->sdev_gendev))
-		goto out;
-	if (!scsi_dev_queue_ready(q, sdev))
-		goto out_put_device;
-
-	return true;
+	if (scsi_dev_queue_ready(q, sdev))
+		return true;
 
-out_put_device:
-	put_device(&sdev->sdev_gendev);
-out:
 	if (atomic_read(&sdev->device_busy) == 0 && !scsi_device_blocked(sdev))
 		blk_mq_delay_run_hw_queue(hctx, SCSI_QUEUE_DELAY);
 	return false;
-- 
2.9.5

