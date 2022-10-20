Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45EDC433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 10:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiJTK5D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 06:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiJTK47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 06:56:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACE01E098E
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 03:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wNna0csQg4XqfA4yMEOY3g/dFHaJ0Tup2zE6h8GAfK4=; b=d7Vk/5f3XqO83/rVHC7qTHvSQB
        LcySJ7JMaEv8Ry1SXXRZAmzJ9FILL0NpyoR5jfhgGGTjEzeK7wgmenNnSlNpag8F1hKKO3AXZJC7v
        14Krkmbz2oFdve/z1flPzJ/m9bFiDjjtPPY1xDhIc2n7X7CtYvIuNRcORSzMFNDDsWIuEX/WJq67b
        BHwpDGxlnZmNvMJgY8PTbjbuwY9RZRQpdMZA0koAwaL6zPgzT2cZ6GQSD/938Klq1mbFCtw6KP9Ws
        UF5f9JI7JorbUV3v9Ho9AbpFMjm9RTqLzoukS++GuvmJHgtFQqYREBWTLwD3GHdc5NxZWetvOakk5
        V5UJfJCg==;
Received: from [88.128.92.117] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTDz-00Dqir-QY; Thu, 20 Oct 2022 10:56:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 4/8] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Date:   Thu, 20 Oct 2022 12:56:04 +0200
Message-Id: <20221020105608.1581940-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
References: <20221020105608.1581940-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Noting in blk_mq_wait_quiesce_done needs the request_queue now, so just
pass the tagset, and move the non-mq check into the only caller that
needs it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c           | 10 +++++-----
 drivers/nvme/host/core.c |  4 ++--
 drivers/scsi/scsi_lib.c  |  2 +-
 include/linux/blk-mq.h   |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4a81a2da43328..cf8f9f9a96c35 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -254,15 +254,15 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
 /**
  * blk_mq_wait_quiesce_done() - wait until in-progress quiesce is done
- * @q: request queue.
+ * @set: tag_set to wait on
  *
  * Note: it is driver's responsibility for making sure that quiesce has
  * been started.
  */
-void blk_mq_wait_quiesce_done(struct request_queue *q)
+void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set)
 {
-	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
-		synchronize_srcu(&q->tag_set->srcu);
+	if (set->flags & BLK_MQ_F_BLOCKING)
+		synchronize_srcu(&set->srcu);
 	else
 		synchronize_rcu();
 }
@@ -282,7 +282,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	blk_mq_quiesce_queue_nowait(q);
 	/* nothing to wait for non-mq queues */
 	if (queue_is_mq(q))
-		blk_mq_wait_quiesce_done(q);
+		blk_mq_wait_quiesce_done(q->tag_set);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 44a5321743128..a74212a4f1a5f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5100,7 +5100,7 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
 		blk_mq_quiesce_queue(ns->queue);
 	else
-		blk_mq_wait_quiesce_done(ns->queue);
+		blk_mq_wait_quiesce_done(ns->queue->tag_set);
 }
 
 /*
@@ -5216,7 +5216,7 @@ void nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
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
index f040a7cab5dbf..dfd565c4fb84e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -881,7 +881,7 @@ void blk_mq_start_hw_queues(struct request_queue *q);
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

