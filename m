Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33460 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752955AbdAKVkM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 16:40:12 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <osandov@osandov.com>, <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 02/10] blk-mq: make mq_ops a const pointer
Date: Wed, 11 Jan 2017 14:39:55 -0700
Message-ID: <1484170803-9311-3-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-1-git-send-email-axboe@fb.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We never change it, make that clear.

Signed-off-by: Jens Axboe <axboe@fb.com>
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 block/blk-mq.c         | 2 +-
 include/linux/blk-mq.h | 2 +-
 include/linux/blkdev.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a8e67a155d04..79e1cb0f7b15 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -639,7 +639,7 @@ struct blk_mq_timeout_data {
 
 void blk_mq_rq_timed_out(struct request *req, bool reserved)
 {
-	struct blk_mq_ops *ops = req->q->mq_ops;
+	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
 
 	/*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4a2ab5d99ff7..afc81d77e471 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -60,7 +60,7 @@ struct blk_mq_hw_ctx {
 
 struct blk_mq_tag_set {
 	unsigned int		*mq_map;
-	struct blk_mq_ops	*ops;
+	const struct blk_mq_ops	*ops;
 	unsigned int		nr_hw_queues;
 	unsigned int		queue_depth;	/* max hw supported */
 	unsigned int		reserved_tags;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 83695641bd5e..e19fc8e01fb2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -407,7 +407,7 @@ struct request_queue {
 	dma_drain_needed_fn	*dma_drain_needed;
 	lld_busy_fn		*lld_busy_fn;
 
-	struct blk_mq_ops	*mq_ops;
+	const struct blk_mq_ops	*mq_ops;
 
 	unsigned int		*mq_map;
 
-- 
2.7.4

