Return-Path: <SRS0=Q27d=RG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816E6C43381
	for <linux-block@archiver.kernel.org>; Sun,  3 Mar 2019 13:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553D620863
	for <linux-block@archiver.kernel.org>; Sun,  3 Mar 2019 13:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfCCNR4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:17:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51969 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfCCNR4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 3 Mar 2019 08:17:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD6D7308424B;
        Sun,  3 Mar 2019 13:17:55 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8D1560147;
        Sun,  3 Mar 2019 13:17:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH] block: fix segment calculation for passthrough IO
Date:   Sun,  3 Mar 2019 21:17:48 +0800
Message-Id: <20190303131748.24646-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 03 Mar 2019 13:17:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_recount_segments() can be called in bio_add_pc_page() for
calculating how many segments this bio will has after one page is added
to this bio. If the resulted segment number is beyond the queue limit,
the added page will be removed.

The try-and-fix policy requires blk_recount_segments(__blk_recalc_rq_segments)
to not consider the segment number limit. Unfortunately bvec_split_segs()
does check this limit, and causes small segment number returned to
bio_add_pc_page(), then page still may be added to the bio even though
segment number limit becomes broken.

Fixes this issue by not considering segment number limit when calcualting
bio's segment number.

Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 22467f475ab4..1c9d4f0f96ea 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -180,7 +180,7 @@ static unsigned get_max_segment_size(struct request_queue *q,
  */
 static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
 		unsigned *nsegs, unsigned *last_seg_size,
-		unsigned *front_seg_size, unsigned *sectors)
+		unsigned *front_seg_size, unsigned *sectors, unsigned max_segs)
 {
 	unsigned len = bv->bv_len;
 	unsigned total_len = 0;
@@ -190,7 +190,7 @@ static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
 	 * Multi-page bvec may be too big to hold in one segment, so the
 	 * current bvec has to be splitted as multiple segments.
 	 */
-	while (len && new_nsegs + *nsegs < queue_max_segments(q)) {
+	while (len && new_nsegs + *nsegs < max_segs) {
 		seg_size = get_max_segment_size(q, bv->bv_offset + total_len);
 		seg_size = min(seg_size, len);
 
@@ -240,6 +240,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	bool do_split = true;
 	struct bio *new = NULL;
 	const unsigned max_sectors = get_max_io_size(q, bio);
+	const unsigned max_segs = queue_max_segments(q);
 
 	bio_for_each_bvec(bv, bio, iter) {
 		/*
@@ -254,14 +255,14 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 			 * Consider this a new segment if we're splitting in
 			 * the middle of this vector.
 			 */
-			if (nsegs < queue_max_segments(q) &&
+			if (nsegs < max_segs &&
 			    sectors < max_sectors) {
 				/* split in the middle of bvec */
 				bv.bv_len = (max_sectors - sectors) << 9;
 				bvec_split_segs(q, &bv, &nsegs,
 						&seg_size,
 						&front_seg_size,
-						&sectors);
+						&sectors, max_segs);
 			}
 			goto split;
 		}
@@ -283,7 +284,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 			continue;
 		}
 new_segment:
-		if (nsegs == queue_max_segments(q))
+		if (nsegs == max_segs)
 			goto split;
 
 		bvprv = bv;
@@ -296,7 +297,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 			if (nsegs == 1 && seg_size > front_seg_size)
 				front_seg_size = seg_size;
 		} else if (bvec_split_segs(q, &bv, &nsegs, &seg_size,
-				    &front_seg_size, &sectors)) {
+				    &front_seg_size, &sectors, max_segs)) {
 			goto split;
 		}
 	}
@@ -415,7 +416,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 			bvprv = bv;
 			prev = 1;
 			bvec_split_segs(q, &bv, &nr_phys_segs, &seg_size,
-					&front_seg_size, NULL);
+					&front_seg_size, NULL, UINT_MAX);
 		}
 		bbio = bio;
 	}
-- 
2.9.5

