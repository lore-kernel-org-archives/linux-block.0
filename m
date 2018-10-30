Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/16] blk-mq: improve plug list sorting
Date: Tue, 30 Oct 2018 12:32:47 -0600
Message-Id: <20181030183252.17857-12-axboe@kernel.dk>
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Currently we only look at the software queue, but with support
for multiple maps, we should also look at the hardware queue.
This is important since we'll flush out the request list if
either the software queue or hardware queue don't match.

This sorts by software queue first, then hardware queue if
that differs. Finally we sort by request location like before.
This minimizes the flush points per plug list.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 51b8166959b9..5a34c9374dc7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1611,14 +1611,21 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	spin_unlock(&ctx->lock);
 }
 
-static int plug_ctx_cmp(void *priv, struct list_head *a, struct list_head *b)
+static int plug_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
 	struct request *rqa = container_of(a, struct request, queuelist);
 	struct request *rqb = container_of(b, struct request, queuelist);
 
-	return !(rqa->mq_ctx < rqb->mq_ctx ||
-		 (rqa->mq_ctx == rqb->mq_ctx &&
-		  blk_rq_pos(rqa) < blk_rq_pos(rqb)));
+	if (rqa->mq_ctx < rqb->mq_ctx)
+		return -1;
+	else if (rqa->mq_ctx > rqb->mq_ctx)
+		return 1;
+	else if (rqa->mq_hctx < rqb->mq_hctx)
+		return -1;
+	else if (rqa->mq_hctx > rqb->mq_hctx)
+		return 1;
+
+	return blk_rq_pos(rqa) > blk_rq_pos(rqb);
 }
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
@@ -1633,7 +1640,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 
 	list_splice_init(&plug->mq_list, &list);
 
-	list_sort(NULL, &list, plug_ctx_cmp);
+	list_sort(NULL, &list, plug_rq_cmp);
 
 	this_q = NULL;
 	this_hctx = NULL;
-- 
2.17.1
