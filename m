Return-Path: <BATV+20fadfe1c4e01d3c2e43+5009+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: abdhalee@linux.vnet.ibm.com,
	martin.petersen@oracle.com,
	linux-block@vger.kernel.org
Subject: [PATCH] block: handle partial completions for special payload requests
Date: Thu, 11 May 2017 12:34:38 +0200
Message-Id: <20170511103438.26717-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

SCSI devices can return short writes on Write Same just like for normal
writes, so we need to handle this case for our special payload requests
as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
---
 block/blk-core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c580b0138a7f..c7068520794b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2644,8 +2644,6 @@ bool blk_update_request(struct request *req, int error, unsigned int nr_bytes)
 		return false;
 	}
 
-	WARN_ON_ONCE(req->rq_flags & RQF_SPECIAL_PAYLOAD);
-
 	req->__data_len -= total_bytes;
 
 	/* update sector only for requests with clear definition of sector */
@@ -2658,17 +2656,19 @@ bool blk_update_request(struct request *req, int error, unsigned int nr_bytes)
 		req->cmd_flags |= req->bio->bi_opf & REQ_FAILFAST_MASK;
 	}
 
-	/*
-	 * If total number of sectors is less than the first segment
-	 * size, something has gone terribly wrong.
-	 */
-	if (blk_rq_bytes(req) < blk_rq_cur_bytes(req)) {
-		blk_dump_rq_flags(req, "request botched");
-		req->__data_len = blk_rq_cur_bytes(req);
-	}
+	if (!(req->rq_flags & RQF_SPECIAL_PAYLOAD)) {
+		/*
+		 * If total number of sectors is less than the first segment
+		 * size, something has gone terribly wrong.
+		 */
+		if (blk_rq_bytes(req) < blk_rq_cur_bytes(req)) {
+			blk_dump_rq_flags(req, "request botched");
+			req->__data_len = blk_rq_cur_bytes(req);
+		}
 
-	/* recalculate the number of segments */
-	blk_recalc_rq_segments(req);
+		/* recalculate the number of segments */
+		blk_recalc_rq_segments(req);
+	}
 
 	return true;
 }
-- 
2.11.0
