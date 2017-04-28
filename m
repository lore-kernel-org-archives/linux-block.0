Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969576AbdD1PQp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 11:16:45 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/4] blk-mq: introduce blk_mq_get_queue_depth()
Date: Fri, 28 Apr 2017 23:15:37 +0800
Message-Id: <20170428151539.25514-3-ming.lei@redhat.com>
In-Reply-To: <20170428151539.25514-1-ming.lei@redhat.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
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
index e530bc54f0d9..04761fb76ab4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2637,6 +2637,18 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_free_tag_set);
 
+/*
+ * Queue depth can be changed via blk_mq_update_nr_requests(),
+ * so use this helper to retrieve queue's depth.
+ */
+int blk_mq_get_queue_depth(struct request_queue *q)
+{
+	/* All queues have same queue depth */
+	struct blk_mq_tags	*tags = q->tag_set->tags[0];
+
+	return tags->bitmap_tags.sb.depth;
+}
+
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
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
