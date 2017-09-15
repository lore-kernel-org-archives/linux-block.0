Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:23752 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdIOHKl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 03:10:41 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: [PATCH] block: move sanity checking ahead of bi_front/back_seg_size updating
Date: Sat, 16 Sep 2017 07:10:30 +0800
Message-Id: <1505517030-29287-1-git-send-email-jianchao.w.wang@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If the bio_integrity_merge_rq() return false or nr_phys_segments exceeds
the max_segments, the merging fails, but the bi_front/back_seg_size may
have been modified. To avoid it, move the sanity checking ahead.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-merge.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 99038830..14b6e37 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -553,6 +553,7 @@ static bool req_no_special_merge(struct request *req)
 static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 				struct request *next)
 {
+	bool contig;
 	int total_phys_segments;
 	unsigned int seg_size =
 		req->biotail->bi_seg_back_size + next->bio->bi_seg_front_size;
@@ -575,13 +576,9 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 		return 0;
 
 	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
-	if (blk_phys_contig_segment(q, req->biotail, next->bio)) {
-		if (req->nr_phys_segments == 1)
-			req->bio->bi_seg_front_size = seg_size;
-		if (next->nr_phys_segments == 1)
-			next->biotail->bi_seg_back_size = seg_size;
+	contig = blk_phys_contig_segment(q, req->biotail, next->bio);
+	if (contig)
 		total_phys_segments--;
-	}
 
 	if (total_phys_segments > queue_max_segments(q))
 		return 0;
@@ -589,6 +586,13 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	if (blk_integrity_merge_rq(q, req, next) == false)
 		return 0;
 
+	if (contig) {
+		if (req->nr_phys_segments == 1)
+			req->bio->bi_seg_front_size = seg_size;
+		if (next->nr_phys_segments == 1)
+			next->biotail->bi_seg_back_size = seg_size;
+	}
+
 	/* Merge is OK... */
 	req->nr_phys_segments = total_phys_segments;
 	return 1;
-- 
2.7.4
