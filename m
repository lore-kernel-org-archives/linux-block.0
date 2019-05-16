Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D28FC04AB4
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BEF205C9
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EVkAqY2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfEPIl5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 04:41:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfEPIl5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 04:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0DlO/ZJViAQMFXmbIEg6CUy1mjJz06SizGC4RpWQPWY=; b=EVkAqY2HYoaG6J9AmAX0CveZJG
        eWuZXIvCCIUUmJVDy40/s0wd8n9RY2MTEbuPre0tSPwLsLNoD5lFOcXd02T03AAAB9Y9cXqhfpT75
        4fF8RM+NBhH/n4K4uZBWUaIt/2uMnGUxY5VaaYEEm3+ZPOVejWS8yPhIlqoCz3bVGazr67h6fTnf8
        /55lDlJqkYt6AoMLRQQifzHvy0sZ4TMrHnd8bMImeVLFFsSPXSchbyeo+ZdXgPO+aZPpIzJjomcUW
        M1gWPxm9eOzQA0s1QjLjawrmm0J/Tgz8WUBV5w3QXGHDVnX/iGOX6YNVlqbjyKP6aIRHmJZDg2mZR
        c9UMS1Ig==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRBxc-0005SA-1L; Thu, 16 May 2019 08:41:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: remove the bi_seg_{front,back}_size fields in struct bio
Date:   Thu, 16 May 2019 10:40:58 +0200
Message-Id: <20190516084058.20678-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516084058.20678-1-hch@lst.de>
References: <20190516084058.20678-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

At this point these fields aren't used for anything, so we can remove
them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c         | 94 +++++----------------------------------
 include/linux/blk_types.h |  7 ---
 2 files changed, 12 insertions(+), 89 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index eee2c02c50ce..17713d7d98d5 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -162,8 +162,7 @@ static unsigned get_max_segment_size(struct request_queue *q,
  * variables.
  */
 static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
-		unsigned *nsegs, unsigned *last_seg_size,
-		unsigned *front_seg_size, unsigned *sectors, unsigned max_segs)
+		unsigned *nsegs, unsigned *sectors, unsigned max_segs)
 {
 	unsigned len = bv->bv_len;
 	unsigned total_len = 0;
@@ -185,28 +184,12 @@ static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
 			break;
 	}
 
-	if (!new_nsegs)
-		return !!len;
-
-	/* update front segment size */
-	if (!*nsegs) {
-		unsigned first_seg_size;
-
-		if (new_nsegs == 1)
-			first_seg_size = get_max_segment_size(q, bv->bv_offset);
-		else
-			first_seg_size = queue_max_segment_size(q);
-
-		if (*front_seg_size < first_seg_size)
-			*front_seg_size = first_seg_size;
+	if (new_nsegs) {
+		*nsegs += new_nsegs;
+		if (sectors)
+			*sectors += total_len >> 9;
 	}
 
-	/* update other varibles */
-	*last_seg_size = seg_size;
-	*nsegs += new_nsegs;
-	if (sectors)
-		*sectors += total_len >> 9;
-
 	/* split in the middle of the bvec if len != 0 */
 	return !!len;
 }
@@ -218,8 +201,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
-	unsigned seg_size = 0, nsegs = 0, sectors = 0;
-	unsigned front_seg_size = bio->bi_seg_front_size;
+	unsigned nsegs = 0, sectors = 0;
 	bool do_split = true;
 	struct bio *new = NULL;
 	const unsigned max_sectors = get_max_io_size(q, bio);
@@ -243,8 +225,6 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 				/* split in the middle of bvec */
 				bv.bv_len = (max_sectors - sectors) << 9;
 				bvec_split_segs(q, &bv, &nsegs,
-						&seg_size,
-						&front_seg_size,
 						&sectors, max_segs);
 			}
 			goto split;
@@ -258,12 +238,9 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 
 		if (bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
 			nsegs++;
-			seg_size = bv.bv_len;
 			sectors += bv.bv_len >> 9;
-			if (nsegs == 1 && seg_size > front_seg_size)
-				front_seg_size = seg_size;
-		} else if (bvec_split_segs(q, &bv, &nsegs, &seg_size,
-				    &front_seg_size, &sectors, max_segs)) {
+		} else if (bvec_split_segs(q, &bv, &nsegs, &sectors,
+				max_segs)) {
 			goto split;
 		}
 	}
@@ -278,10 +255,6 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 			bio = new;
 	}
 
-	bio->bi_seg_front_size = front_seg_size;
-	if (seg_size > bio->bi_seg_back_size)
-		bio->bi_seg_back_size = seg_size;
-
 	return do_split ? new : NULL;
 }
 
@@ -336,17 +309,13 @@ EXPORT_SYMBOL(blk_queue_split);
 static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 					     struct bio *bio)
 {
-	struct bio_vec uninitialized_var(bv), bvprv = { NULL };
-	unsigned int seg_size, nr_phys_segs;
-	unsigned front_seg_size;
-	struct bio *fbio, *bbio;
+	unsigned int nr_phys_segs = 0;
 	struct bvec_iter iter;
+	struct bio_vec bv;
 
 	if (!bio)
 		return 0;
 
-	front_seg_size = bio->bi_seg_front_size;
-
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
@@ -356,23 +325,11 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 		return 1;
 	}
 
-	fbio = bio;
-	seg_size = 0;
-	nr_phys_segs = 0;
 	for_each_bio(bio) {
-		bio_for_each_bvec(bv, bio, iter) {
-			bvec_split_segs(q, &bv, &nr_phys_segs, &seg_size,
-					&front_seg_size, NULL, UINT_MAX);
-		}
-		bbio = bio;
-		if (likely(bio->bi_iter.bi_size))
-			bvprv = bv;
+		bio_for_each_bvec(bv, bio, iter)
+			bvec_split_segs(q, &bv, &nr_phys_segs, NULL, UINT_MAX);
 	}
 
-	fbio->bi_seg_front_size = front_seg_size;
-	if (seg_size > bbio->bi_seg_back_size)
-		bbio->bi_seg_back_size = seg_size;
-
 	return nr_phys_segs;
 }
 
@@ -392,24 +349,6 @@ void blk_recount_segments(struct request_queue *q, struct bio *bio)
 	bio_set_flag(bio, BIO_SEG_VALID);
 }
 
-static int blk_phys_contig_segment(struct request_queue *q, struct bio *bio,
-				   struct bio *nxt)
-{
-	struct bio_vec end_bv = { NULL }, nxt_bv;
-
-	if (bio->bi_seg_back_size + nxt->bi_seg_front_size >
-	    queue_max_segment_size(q))
-		return 0;
-
-	if (!bio_has_data(bio))
-		return 1;
-
-	bio_get_last_bvec(bio, &end_bv);
-	bio_get_first_bvec(nxt, &nxt_bv);
-
-	return biovec_phys_mergeable(q, &end_bv, &nxt_bv);
-}
-
 static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
 		struct scatterlist *sglist)
 {
@@ -669,8 +608,6 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 				struct request *next)
 {
 	int total_phys_segments;
-	unsigned int seg_size =
-		req->biotail->bi_seg_back_size + next->bio->bi_seg_front_size;
 
 	if (req_gap_back_merge(req, next->bio))
 		return 0;
@@ -683,13 +620,6 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 		return 0;
 
 	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
-	if (blk_phys_contig_segment(q, req->biotail, next->bio)) {
-		if (req->nr_phys_segments == 1)
-			req->bio->bi_seg_front_size = seg_size;
-		if (next->nr_phys_segments == 1)
-			next->biotail->bi_seg_back_size = seg_size;
-	}
-
 	if (total_phys_segments > queue_max_segments(q))
 		return 0;
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index be418275763c..95202f80676c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -159,13 +159,6 @@ struct bio {
 	 */
 	unsigned int		bi_phys_segments;
 
-	/*
-	 * To keep track of the max segment size, we account for the
-	 * sizes of the first and last mergeable segments in this bio.
-	 */
-	unsigned int		bi_seg_front_size;
-	unsigned int		bi_seg_back_size;
-
 	struct bvec_iter	bi_iter;
 
 	atomic_t		__bi_remaining;
-- 
2.20.1

