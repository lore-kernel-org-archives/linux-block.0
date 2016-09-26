Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3616 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751540AbcIZWtd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2016 18:49:33 -0400
Date: Mon, 26 Sep 2016 19:00:30 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: Return invalid cookie if bio was split
Message-ID: <20160926230030.GB24200@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The only user of polling requires its original request be completed in
its entirety before continuing execution. If the bio needs to be split
and chained for any reason, the direct IO path would have waited for just
that split portion to complete, leading to potential data corruption if
the remaining transfer has not yet completed.

This patch has blk-mq return an invalid cookie if a bio requires splitting
so that polling does not occur.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c207fa9..6385985 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1311,6 +1311,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	unsigned int request_count = 0;
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
+	struct bio *orig = bio;
 	blk_qc_t cookie;
 
 	blk_queue_bounce(q, &bio);
@@ -1389,7 +1390,7 @@ run_queue:
 	}
 	blk_mq_put_ctx(data.ctx);
 done:
-	return cookie;
+	return bio == orig ? cookie : BLK_QC_T_NONE;
 }
 
 /*
@@ -1404,6 +1405,7 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	unsigned int request_count = 0;
 	struct blk_map_ctx data;
 	struct request *rq;
+	struct bio *orig = bio;
 	blk_qc_t cookie;
 
 	blk_queue_bounce(q, &bio);
@@ -1467,7 +1469,7 @@ run_queue:
 	}
 
 	blk_mq_put_ctx(data.ctx);
-	return cookie;
+	return bio == orig ? cookie : BLK_QC_T_NONE;
 }
 
 /*
-- 
2.7.2

