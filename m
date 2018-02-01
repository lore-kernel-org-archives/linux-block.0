Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Linux Block <linux-block@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH] block: Merge discard requests as a special case
Date: Thu,  1 Feb 2018 11:01:28 -0700
Message-Id: <20180201180128.24470-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

Discard requests operate under different constraints than other operations
and have different rules for merging. This patch will treat such requests
as a special case, using the same criteria and segment accounting used
for merging a discard bio into a reqseut.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-merge.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8452fc7164cc..37186fb02cf1 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -550,6 +550,25 @@ static bool req_no_special_merge(struct request *req)
 	return !q->mq_ops && req->special;
 }
 
+static int req_attempt_discard_merge(struct request_queue *q, struct request *req,
+		struct request *next)
+{
+	unsigned short segments = blk_rq_nr_discard_segments(req);
+
+	if (segments >= queue_max_discard_segments(q))
+		goto no_merge;
+	if (blk_rq_sectors(req) + bio_sectors(next->bio) >
+	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
+		goto no_merge;
+
+	req->nr_phys_segments = segments + blk_rq_nr_discard_segments(next);
+	return 1;
+
+no_merge:
+	req_set_nomerge(q, req);
+	return 0;
+}
+
 static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 				struct request *next)
 {
@@ -564,6 +583,13 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	if (req_no_special_merge(req) || req_no_special_merge(next))
 		return 0;
 
+	/*
+	 * Merging discard requests use different constraints than other
+	 * operations.
+	 */
+	if (req_op(req) == REQ_OP_DISCARD)
+		return req_attempt_discard_merge(q, req, next);
+
 	if (req_gap_back_merge(req, next->bio))
 		return 0;
 
-- 
2.14.3
