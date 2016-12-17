Return-Path: <prvs=1159fc908b=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/8] blk-mq: make mq_ops a const pointer
Date: Fri, 16 Dec 2016 17:12:10 -0700
Message-ID: <1481933536-12844-3-git-send-email-axboe@fb.com>
In-Reply-To: <1481933536-12844-1-git-send-email-axboe@fb.com>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

We never change it, make that clear.

Signed-off-by: Jens Axboe <axboe@fb.com>
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 block/blk-mq.c         | 2 +-
 include/linux/blk-mq.h | 2 +-
 include/linux/blkdev.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d79fdc11b1ee..87b7eaa1cb74 100644
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
index 286b2a264383..7c40fb838b44 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -408,7 +408,7 @@ struct request_queue {
 	dma_drain_needed_fn	*dma_drain_needed;
 	lld_busy_fn		*lld_busy_fn;
 
-	struct blk_mq_ops	*mq_ops;
+	const struct blk_mq_ops	*mq_ops;
 
 	unsigned int		*mq_map;
 
-- 
2.7.4
