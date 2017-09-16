Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751257AbdIPDGa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 23:06:30 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/7] blk-mq: move blk_mq_put_driver_tag*() into blk-mq.h
Date: Sat, 16 Sep 2017 11:03:49 +0800
Message-Id: <20170916030351.28019-7-ming.lei@redhat.com>
In-Reply-To: <20170916030351.28019-1-ming.lei@redhat.com>
References: <20170916030351.28019-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We need this helper to put the tag for flush rq, since
we will not share tag in the flush request sequences
in case of I/O scheduler.

Also the driver tag need to be released before requeuing.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 32 --------------------------------
 block/blk-mq.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 21331e785919..b799d4e22c0b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -920,38 +920,6 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 	return rq->tag != -1;
 }
 
-static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
-				    struct request *rq)
-{
-	blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
-	rq->tag = -1;
-
-	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
-		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
-		atomic_dec(&hctx->nr_active);
-	}
-}
-
-static void blk_mq_put_driver_tag_hctx(struct blk_mq_hw_ctx *hctx,
-				       struct request *rq)
-{
-	if (rq->tag == -1 || rq->internal_tag == -1)
-		return;
-
-	__blk_mq_put_driver_tag(hctx, rq);
-}
-
-static void blk_mq_put_driver_tag(struct request *rq)
-{
-	struct blk_mq_hw_ctx *hctx;
-
-	if (rq->tag == -1 || rq->internal_tag == -1)
-		return;
-
-	hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu);
-	__blk_mq_put_driver_tag(hctx, rq);
-}
-
 /*
  * If we fail getting a driver tag because all the driver tags are already
  * assigned and on the dispatch list, BUT the first entry does not have a
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 038bdeb84629..2bef2d0cca7b 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -2,6 +2,7 @@
 #define INT_BLK_MQ_H
 
 #include "blk-stat.h"
+#include "blk-mq-tag.h"
 
 struct blk_mq_tag_set;
 
@@ -137,4 +138,36 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
 			unsigned int inflight[2]);
 
+static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
+					   struct request *rq)
+{
+	blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
+	rq->tag = -1;
+
+	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
+		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
+		atomic_dec(&hctx->nr_active);
+	}
+}
+
+static inline void blk_mq_put_driver_tag_hctx(struct blk_mq_hw_ctx *hctx,
+				       struct request *rq)
+{
+	if (rq->tag == -1 || rq->internal_tag == -1)
+		return;
+
+	__blk_mq_put_driver_tag(hctx, rq);
+}
+
+static inline void blk_mq_put_driver_tag(struct request *rq)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	if (rq->tag == -1 || rq->internal_tag == -1)
+		return;
+
+	hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu);
+	__blk_mq_put_driver_tag(hctx, rq);
+}
+
 #endif
-- 
2.9.5
