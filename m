Return-Path: <BATV+add76be85c7e68b62602+4917+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] block: move req_set_nomerge to blk.h
Date: Wed,  8 Feb 2017 14:13:40 +0100
Message-Id: <20170208131343.4003-2-hch@lst.de>
In-Reply-To: <20170208131343.4003-1-hch@lst.de>
References: <20170208131343.4003-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This makes it available outside of blk-merge.c, and inlining such a trivial
helper seems pretty useful to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 7 -------
 block/blk.h       | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index a373416dbc9a..c956d9e7aafd 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -482,13 +482,6 @@ int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(blk_rq_map_sg);
 
-static void req_set_nomerge(struct request_queue *q, struct request *req)
-{
-	req->cmd_flags |= REQ_NOMERGE;
-	if (req == q->last_merge)
-		q->last_merge = NULL;
-}
-
 static inline int ll_new_hw_segment(struct request_queue *q,
 				    struct request *req,
 				    struct bio *bio)
diff --git a/block/blk.h b/block/blk.h
index 4972b98d47e1..3e08703902a9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -256,6 +256,13 @@ static inline int blk_do_io_stat(struct request *rq)
 		!blk_rq_is_passthrough(rq);
 }
 
+static inline void req_set_nomerge(struct request_queue *q, struct request *req)
+{
+	req->cmd_flags |= REQ_NOMERGE;
+	if (req == q->last_merge)
+		q->last_merge = NULL;
+}
+
 /*
  * Internal io_context interface
  */
-- 
2.11.0
