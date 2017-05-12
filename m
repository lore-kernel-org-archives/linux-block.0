Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751985AbdELKbc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2017 06:31:32 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 2/4] blk-mq: introduce blk_mq_get_queue_depth()
Date: Fri, 12 May 2017 18:31:01 +0800
Message-Id: <20170512103103.24485-3-ming.lei@redhat.com>
In-Reply-To: <20170512103103.24485-1-ming.lei@redhat.com>
References: <20170512103103.24485-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The hardware queue depth can be resized via blk_mq_update_nr_requests(),
so introduce this helper for retrieving queue's depth easily.

Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 15 +++++++++++++++
 block/blk-mq.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fb2607bc3f05..389d53a6c1d6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2139,6 +2139,21 @@ static void blk_mq_map_swqueue(struct request_queue *q,
 	}
 }
 
+/*
+ * Queue depth can be changed via blk_mq_update_nr_requests(),
+ * so use this helper to retrieve queue's depth.
+ */
+int blk_mq_get_queue_depth(struct request_queue *q)
+{
+	/*
+	 * All queues have same queue depth, need to revisit
+	 * if per hw-queue depth is supported.
+	 */
+	struct blk_mq_tags	*tags = q->tag_set->tags[0];
+
+	return tags->bitmap_tags.sb.depth + tags->breserved_tags.sb.depth;
+}
+
 static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index cc67b48e3551..d49d46de2923 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -138,6 +138,7 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 void blk_mq_finish_request(struct request *rq);
 struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 					unsigned int op);
+int blk_mq_get_queue_depth(struct request_queue *q);
 
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 {
-- 
2.9.3
