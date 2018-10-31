Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 27/30] block: remove req_no_special_merge() from merging code
Date: Wed, 31 Oct 2018 11:59:19 -0600
Message-Id: <20181031175922.8849-28-axboe@kernel.dk>
In-Reply-To: <20181031175922.8849-1-axboe@kernel.dk>
References: <20181031175922.8849-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

It'll always be false at this point, just remove it.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-merge.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7fedc0391610..3561dcce2260 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -595,17 +595,6 @@ int ll_front_merge_fn(struct request_queue *q, struct request *req,
 	return ll_new_hw_segment(q, req, bio);
 }
 
-/*
- * blk-mq uses req->special to carry normal driver per-request payload, it
- * does not indicate a prepared command that we cannot merge with.
- */
-static bool req_no_special_merge(struct request *req)
-{
-	struct request_queue *q = req->q;
-
-	return !q->mq_ops && req->special;
-}
-
 static bool req_attempt_discard_merge(struct request_queue *q, struct request *req,
 		struct request *next)
 {
@@ -631,13 +620,6 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	unsigned int seg_size =
 		req->biotail->bi_seg_back_size + next->bio->bi_seg_front_size;
 
-	/*
-	 * First check if the either of the requests are re-queued
-	 * requests.  Can't merge them if they are.
-	 */
-	if (req_no_special_merge(req) || req_no_special_merge(next))
-		return 0;
-
 	if (req_gap_back_merge(req, next->bio))
 		return 0;
 
@@ -738,8 +720,7 @@ static struct request *attempt_merge(struct request_queue *q,
 		return NULL;
 
 	if (rq_data_dir(req) != rq_data_dir(next)
-	    || req->rq_disk != next->rq_disk
-	    || req_no_special_merge(next))
+	    || req->rq_disk != next->rq_disk)
 		return NULL;
 
 	if (req_op(req) == REQ_OP_WRITE_SAME &&
@@ -858,8 +839,8 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (bio_data_dir(bio) != rq_data_dir(rq))
 		return false;
 
-	/* must be same device and not a special request */
-	if (rq->rq_disk != bio->bi_disk || req_no_special_merge(rq))
+	/* must be same device */
+	if (rq->rq_disk != bio->bi_disk)
 		return false;
 
 	/* only merge integrity protected bio into ditto rq */
-- 
2.17.1
