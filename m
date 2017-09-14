Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751370AbdINQnO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Sep 2017 12:43:14 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/6] blk-mq: move __blk_mq_put_driver_tag() into blk-mq.h
Date: Fri, 15 Sep 2017 00:42:12 +0800
Message-Id: <20170914164213.17859-6-ming.lei@redhat.com>
In-Reply-To: <20170914164213.17859-1-ming.lei@redhat.com>
References: <20170914164213.17859-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We need this helper to put the tag for flash rq, since
we will not share tag in the flush request sequences
in case of I/O scheduler.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 12 ------------
 block/blk-mq.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 21331e785919..46d561e26774 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -920,18 +920,6 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
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
 static void blk_mq_put_driver_tag_hctx(struct blk_mq_hw_ctx *hctx,
 				       struct request *rq)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 038bdeb84629..383f1624c34f 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -2,6 +2,7 @@
 #define INT_BLK_MQ_H
 
 #include "blk-stat.h"
+#include "blk-mq-tag.h"
 
 struct blk_mq_tag_set;
 
@@ -137,4 +138,16 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
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
 #endif
-- 
2.9.5
