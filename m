Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757636AbdECT7M (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 May 2017 15:59:12 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/5] blk-mq: introduce blk_mq_get_queue_depth()
Date: Thu,  4 May 2017 03:58:36 +0800
Message-Id: <20170503195839.6539-3-ming.lei@redhat.com>
In-Reply-To: <20170503195839.6539-1-ming.lei@redhat.com>
References: <20170503195839.6539-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The hardware queue depth can be resized via blk_mq_update_nr_requests(),
so introduce this helper for retrieving queue's depth easily.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 12 ++++++++++++
 block/blk-mq.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 095099df041f..be475ad112ec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2120,6 +2120,18 @@ static void blk_mq_map_swqueue(struct request_queue *q,
 	}
 }
 
+/*
+ * Queue depth can be changed via blk_mq_update_nr_requests(),
+ * so use this helper to retrieve queue's depth.
+ */
+int blk_mq_get_queue_depth(struct request_queue *q)
+{
+	/* All queues have same queue depth */
+	struct blk_mq_tags	*tags = q->tag_set->tags[0];
+
+	return tags->bitmap_tags.sb.depth + tags->breserved_tags.sb.depth;
+}
+
 static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 2814a14e529c..8085d5989cf5 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -166,6 +166,7 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 void blk_mq_finish_request(struct request *rq);
 struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 					unsigned int op);
+int blk_mq_get_queue_depth(struct request_queue *q);
 
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 {
-- 
2.9.3
