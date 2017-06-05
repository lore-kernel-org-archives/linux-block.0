Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbdFEQAq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jun 2017 12:00:46 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 02/11] blk-mq: move blk_mq_quiesce_queue() into include/linux/blk-mq.h
Date: Mon,  5 Jun 2017 23:59:16 +0800
Message-Id: <20170605155925.7896-3-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-1-ming.lei@redhat.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We usually put blk_mq_*() into include/linux/blk-mq.h, so
move this API into there.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blk-mq.h | 1 +
 include/linux/blkdev.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fcd641032f8d..1e480015d172 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -247,6 +247,7 @@ void blk_mq_stop_hw_queues(struct request_queue *q);
 void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
+void blk_mq_quiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 019f18c65098..7178ad6805e3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -966,7 +966,6 @@ extern void __blk_run_queue(struct request_queue *q);
 extern void __blk_run_queue_uncond(struct request_queue *q);
 extern void blk_run_queue(struct request_queue *);
 extern void blk_run_queue_async(struct request_queue *q);
-extern void blk_mq_quiesce_queue(struct request_queue *q);
 extern int blk_rq_map_user(struct request_queue *, struct request *,
 			   struct rq_map_data *, void __user *, unsigned long,
 			   gfp_t);
-- 
2.9.4
