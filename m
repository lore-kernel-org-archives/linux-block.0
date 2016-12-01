Return-Path: <riteshh@codeaurora.org>
From: Ritesh Harjani <riteshh@codeaurora.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH] block: Factor out req_set_nomerge
Date: Thu,  1 Dec 2016 15:57:38 +0530
Message-Id: <1480588058-29998-1-git-send-email-riteshh@codeaurora.org>
List-ID: <linux-block@vger.kernel.org>

Factor out common code for setting REQ_NOMERGE
flag which is being used out at certain places
and make it a helper instead (req_set_nomerge).

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 block/blk-merge.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2642e5f..4549fec 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -492,6 +492,14 @@ int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(blk_rq_map_sg);
 
+static inline void req_set_nomerge(struct request_queue *q,
+				   struct request *req)
+{
+	req->cmd_flags |= REQ_NOMERGE;
+	if (req == q->last_merge)
+		q->last_merge = NULL;
+}
+
 static inline int ll_new_hw_segment(struct request_queue *q,
 				    struct request *req,
 				    struct bio *bio)
@@ -512,9 +520,7 @@ static inline int ll_new_hw_segment(struct request_queue *q,
 	return 1;
 
 no_merge:
-	req->cmd_flags |= REQ_NOMERGE;
-	if (req == q->last_merge)
-		q->last_merge = NULL;
+	req_set_nomerge(q, req);
 	return 0;
 }
 
@@ -528,9 +534,7 @@ int ll_back_merge_fn(struct request_queue *q, struct request *req,
 		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req, blk_rq_pos(req))) {
-		req->cmd_flags |= REQ_NOMERGE;
-		if (req == q->last_merge)
-			q->last_merge = NULL;
+		req_set_nomerge(q, req);
 		return 0;
 	}
 	if (!bio_flagged(req->biotail, BIO_SEG_VALID))
@@ -552,9 +556,7 @@ int ll_front_merge_fn(struct request_queue *q, struct request *req,
 		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req, bio->bi_iter.bi_sector)) {
-		req->cmd_flags |= REQ_NOMERGE;
-		if (req == q->last_merge)
-			q->last_merge = NULL;
+		req_set_nomerge(q, req);
 		return 0;
 	}
 	if (!bio_flagged(bio, BIO_SEG_VALID))
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
