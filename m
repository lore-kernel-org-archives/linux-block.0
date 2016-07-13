Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13417 "EHLO
	esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbcGMFYX (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 13 Jul 2016 01:24:23 -0400
From: Damien Le Moal <damien.lemoal@hgst.com>
To: <linux-block@vger.kernel.org>, <axboe@fb.com>, <hch@lst.de>,
	<hare@suse.de>
CC: Damien Le Moal <damien.lemoal@hgst.com>
Subject: [PATCH] block: Fix front merge check
Date: Wed, 13 Jul 2016 14:23:33 +0900
Message-ID: <1468387413-2754-1-git-send-email-damien.lemoal@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For a front merge, the maximum number of sectors of the
request must be checked against the front merge BIO sector,
not the current sector of the request.

Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
---
 block/blk-merge.c      | 6 +++---
 include/linux/blkdev.h | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2613531..b736569 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -500,7 +500,7 @@ int ll_back_merge_fn(struct request_queue *q, struct request *req,
 	    integrity_req_gap_back_merge(req, bio))
 		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
-	    blk_rq_get_max_sectors(req)) {
+	    blk_rq_get_max_sectors(req, blk_rq_pos(req))) {
 		req->cmd_flags |= REQ_NOMERGE;
 		if (req == q->last_merge)
 			q->last_merge = NULL;
@@ -524,7 +524,7 @@ int ll_front_merge_fn(struct request_queue *q, struct request *req,
 	    integrity_req_gap_front_merge(req, bio))
 		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
-	    blk_rq_get_max_sectors(req)) {
+	    blk_rq_get_max_sectors(req, bio->bi_iter.bi_sector)) {
 		req->cmd_flags |= REQ_NOMERGE;
 		if (req == q->last_merge)
 			q->last_merge = NULL;
@@ -570,7 +570,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	 * Will it become too large?
 	 */
 	if ((blk_rq_sectors(req) + blk_rq_sectors(next)) >
-	    blk_rq_get_max_sectors(req))
+	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
 		return 0;
 
 	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3d9cf32..b99ef36 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -904,7 +904,8 @@ static inline unsigned int blk_max_size_offset(struct request_queue *q,
 			(offset & (q->limits.chunk_sectors - 1));
 }
 
-static inline unsigned int blk_rq_get_max_sectors(struct request *rq)
+static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
+						  sector_t offset)
 {
 	struct request_queue *q = rq->q;
 
@@ -914,7 +915,7 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq)
 	if (!q->limits.chunk_sectors || (rq->cmd_flags & REQ_DISCARD))
 		return blk_queue_get_max_sectors(q, rq->cmd_flags);
 
-	return min(blk_max_size_offset(q, blk_rq_pos(rq)),
+	return min(blk_max_size_offset(q, offset),
 			blk_queue_get_max_sectors(q, rq->cmd_flags));
 }
 
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.

