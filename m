Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	efault@gmx.de,
	paolo.valente@linaro.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] blk-mq-sched: inform sbitmap of shallow depth changes
Date: Wed,  9 May 2018 09:36:04 -0600
Message-Id: <1525880164-11943-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1525880164-11943-1-git-send-email-axboe@kernel.dk>
References: <1525880164-11943-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

If the scheduler returns a new shallow depth setting, then inform
sbitmap so it can update the wait batch counts.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-sched.c | 26 ++++++++++++++++++++++++++
 block/blk-mq-sched.h |  3 +++
 block/blk-mq.c       |  8 +-------
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 25c14c58385c..0c53a254671f 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -16,6 +16,32 @@
 #include "blk-mq-tag.h"
 #include "blk-wbt.h"
 
+void blk_mq_sched_limit_depth(struct elevator_queue *e,
+			      struct blk_mq_alloc_data *data, unsigned int op)
+{
+	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
+	struct sbitmap_queue *bt;
+	int ret;
+
+	/*
+	 * Flush requests are special and go directly to the
+	 * dispatch list.
+	 */
+	if (op_is_flush(op) || !e->type->ops.mq.limit_depth)
+		return;
+
+	ret = e->type->ops.mq.limit_depth(op, data);
+	if (!ret)
+		return;
+
+	if (data->flags & BLK_MQ_REQ_RESERVED)
+		bt = &tags->breserved_tags;
+	else
+		bt = &tags->bitmap_tags;
+
+	sbitmap_queue_shallow_depth(bt, ret);
+}
+
 void blk_mq_sched_free_hctx_data(struct request_queue *q,
 				 void (*exit)(struct blk_mq_hw_ctx *))
 {
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1e9c9018ace1..6abebc1b9ae0 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -5,6 +5,9 @@
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 
+void blk_mq_sched_limit_depth(struct elevator_queue *e,
+			      struct blk_mq_alloc_data *data, unsigned int op);
+
 void blk_mq_sched_free_hctx_data(struct request_queue *q,
 				 void (*exit)(struct blk_mq_hw_ctx *));
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e9d83594cca..1bb7aa40c192 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -357,13 +357,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 	if (e) {
 		data->flags |= BLK_MQ_REQ_INTERNAL;
-
-		/*
-		 * Flush requests are special and go directly to the
-		 * dispatch list.
-		 */
-		if (!op_is_flush(op) && e->type->ops.mq.limit_depth)
-			e->type->ops.mq.limit_depth(op, data);
+		blk_mq_sched_limit_depth(e, data, op);
 	}
 
 	tag = blk_mq_get_tag(data);
-- 
2.7.4
