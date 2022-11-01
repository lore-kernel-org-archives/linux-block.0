Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB7AC433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 15:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiKAPIv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiKAPIe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:08:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CE11EACA
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LKSp7sTVrN/SlopF/xOv1f/B3XQWGZ/lAzcwBtezQBE=; b=M1GNlE5waHTMcKk0HQFjnrFDh8
        d7q3mFNaq+QTAeqAbv/CKX4vnlmQqgEGKy6T2X+2T5nevUSB7UL7+YK4sPE6PETIx+XodPh1RhsR/
        STjcSTjfSWYY+fUe9IMlCvEj1XuEcYxq1fPe199FGHt0W+qgIgvbnR0UJ27IXmrguwJuJHYtJLFEe
        M9QlzQrbdfAQC98dYObqMOigHQfcscaksRai8o4j6a4E/yj8PaH5AvQ7F6U0UDZGIjRKDRiQ387a3
        dTnQPXWSytYfpetKxjsfiYUgh1KD1q5zKrTPeS82dJ+JRrDrO76XNONBloKIBIhLAxoRoywggRZXE
        V/+2+R+g==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opslf-005gvW-Q4; Tue, 01 Nov 2022 15:01:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 12/14] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Date:   Tue,  1 Nov 2022 16:00:48 +0100
Message-Id: <20221101150050.3510-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nothing in blk_mq_wait_quiesce_done needs the request_queue now, so just
pass the tagset, and move the non-mq check into the only caller that
needs it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c           | 16 +++++++++-------
 drivers/nvme/host/core.c |  4 ++--
 drivers/scsi/scsi_lib.c  |  2 +-
 include/linux/blk-mq.h   |  2 +-
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3479325fc86c3..b358328a1dce3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -254,15 +254,17 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
 /**
  * blk_mq_wait_quiesce_done() - wait until in-progress quiesce is done
- * @q: request queue.
+ * @set: tag_set to wait on
  *
  * Note: it is driver's responsibility for making sure that quiesce has
- * been started.
+ * been started on or more of the request_queues of the tag_set.  This
+ * function only waits for the quiesce on those request_queues that had
+ * the quiesce flag set using blk_mq_quiesce_queue_nowait.
  */
-void blk_mq_wait_quiesce_done(struct request_queue *q)
+void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set)
 {
-	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
-		synchronize_srcu(q->tag_set->srcu);
+	if (set->flags & BLK_MQ_F_BLOCKING)
+		synchronize_srcu(set->srcu);
 	else
 		synchronize_rcu();
 }
@@ -282,7 +284,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	blk_mq_quiesce_queue_nowait(q);
 	/* nothing to wait for non-mq queues */
 	if (queue_is_mq(q))
-		blk_mq_wait_quiesce_done(q);
+		blk_mq_wait_quiesce_done(q->tag_set);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
@@ -1623,7 +1625,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 		 * uses srcu or rcu, wait for a synchronization point to
 		 * ensure all running submits have finished
 		 */
-		blk_mq_wait_quiesce_done(q);
+		blk_mq_wait_quiesce_done(q->tag_set);
 
 		expired.next = 0;
 		blk_mq_queue_tag_busy_iter(q, blk_mq_handle_expired, &expired);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ed06fcb87f93a..66b0b6e110024 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5107,7 +5107,7 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
 		blk_mq_quiesce_queue(ns->queue);
 	else
-		blk_mq_wait_quiesce_done(ns->queue);
+		blk_mq_wait_quiesce_done(ns->queue->tag_set);
 }
 
 /* let I/O to all namespaces fail in preparation for surprise removal */
@@ -5197,7 +5197,7 @@ void nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
 	if (!test_and_set_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->flags))
 		blk_mq_quiesce_queue(ctrl->admin_q);
 	else
-		blk_mq_wait_quiesce_done(ctrl->admin_q);
+		blk_mq_wait_quiesce_done(ctrl->admin_q->tag_set);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_admin_queue);
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 8b89fab7c4206..249757ddd8fea 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2735,7 +2735,7 @@ static void scsi_stop_queue(struct scsi_device *sdev, bool nowait)
 			blk_mq_quiesce_queue(sdev->request_queue);
 	} else {
 		if (!nowait)
-			blk_mq_wait_quiesce_done(sdev->request_queue);
+			blk_mq_wait_quiesce_done(sdev->request_queue->tag_set);
 	}
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f059edebb11d8..061ea6e7af017 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -880,7 +880,7 @@ void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_quiesce_queue(struct request_queue *q);
-void blk_mq_wait_quiesce_done(struct request_queue *q);
+void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set);
 void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
-- 
2.30.2

