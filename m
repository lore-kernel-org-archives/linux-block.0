Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D74BC43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 01:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763BF20851
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 01:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfCIBrn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:47:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfCIBrn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 20:47:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84E7B5AFE9;
        Sat,  9 Mar 2019 01:47:43 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2B2061529;
        Sat,  9 Mar 2019 01:38:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/6] block: don't check if adjacent bvecs in one bio can be mergeable
Date:   Sat,  9 Mar 2019 09:37:37 +0800
Message-Id: <20190309013737.27741-7-ming.lei@redhat.com>
In-Reply-To: <20190309013737.27741-1-ming.lei@redhat.com>
References: <20190309013737.27741-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 09 Mar 2019 01:47:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now both passthrough and FS IO have supported multi-page bvec, and
bvec merging has been handled actually when adding page to bio, then
adjacent bvecs won't be mergeable any more if they belong to same bio.

So only try to merge bvecs if they are from different bios.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 81 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index aa9164eb7187..5c52141eee7d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -354,11 +354,11 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 					     struct bio *bio)
 {
 	struct bio_vec bv, bvprv = { NULL };
-	int prev = 0;
 	unsigned int seg_size, nr_phys_segs;
 	unsigned front_seg_size;
 	struct bio *fbio, *bbio;
 	struct bvec_iter iter;
+	bool new_bio;
 
 	if (!bio)
 		return 0;
@@ -377,9 +377,10 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	fbio = bio;
 	seg_size = 0;
 	nr_phys_segs = 0;
+	new_bio = false;
 	for_each_bio(bio) {
 		bio_for_each_bvec(bv, bio, iter) {
-			if (prev) {
+			if (new_bio) {
 				if (seg_size + bv.bv_len
 				    > queue_max_segment_size(q))
 					goto new_segment;
@@ -387,7 +388,6 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 					goto new_segment;
 
 				seg_size += bv.bv_len;
-				bvprv = bv;
 
 				if (nr_phys_segs == 1 && seg_size >
 						front_seg_size)
@@ -396,12 +396,13 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 				continue;
 			}
 new_segment:
-			bvprv = bv;
-			prev = 1;
 			bvec_split_segs(q, &bv, &nr_phys_segs, &seg_size,
 					&front_seg_size, NULL, UINT_MAX);
+			new_bio = false;
 		}
 		bbio = bio;
+		bvprv = bv;
+		new_bio = true;
 	}
 
 	fbio->bi_seg_front_size = front_seg_size;
@@ -493,31 +494,38 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
 	return nsegs;
 }
 
-static inline void
-__blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
-		     struct scatterlist *sglist, struct bio_vec *bvprv,
-		     struct scatterlist **sg, int *nsegs)
+/* only try to merge bvecs into one sg if they are from two bios */
+static inline bool
+__blk_segment_map_sg_merge(struct request_queue *q, struct bio_vec *bvec,
+			   struct bio_vec *bvprv, struct scatterlist **sg)
 {
-
 	int nbytes = bvec->bv_len;
 
-	if (*sg) {
-		if ((*sg)->length + nbytes > queue_max_segment_size(q))
-			goto new_segment;
-		if (!biovec_phys_mergeable(q, bvprv, bvec))
-			goto new_segment;
+	if (!*sg)
+		return false;
 
-		(*sg)->length += nbytes;
-	} else {
-new_segment:
-		if (bvec->bv_offset + bvec->bv_len <= PAGE_SIZE) {
-			*sg = blk_next_sg(sg, sglist);
-			sg_set_page(*sg, bvec->bv_page, nbytes, bvec->bv_offset);
-			(*nsegs) += 1;
-		} else
-			(*nsegs) += blk_bvec_map_sg(q, bvec, sglist, sg);
-	}
-	*bvprv = *bvec;
+	if ((*sg)->length + nbytes > queue_max_segment_size(q))
+		return false;
+
+	if (!biovec_phys_mergeable(q, bvprv, bvec))
+		return false;
+
+	(*sg)->length += nbytes;
+
+	return true;
+}
+
+static inline void
+__blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
+		     struct scatterlist *sglist, struct scatterlist **sg,
+		     int *nsegs)
+{
+	if (bvec->bv_offset + bvec->bv_len <= PAGE_SIZE) {
+		*sg = blk_next_sg(sg, sglist);
+		sg_set_page(*sg, bvec->bv_page, bvec->bv_len, bvec->bv_offset);
+		(*nsegs) += 1;
+	} else
+		(*nsegs) += blk_bvec_map_sg(q, bvec, sglist, sg);
 }
 
 static inline int __blk_bvec_map_sg(struct request_queue *q, struct bio_vec bv,
@@ -535,11 +543,24 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 	struct bio_vec bvec, bvprv = { NULL };
 	struct bvec_iter iter;
 	int nsegs = 0;
+	bool new_bio = false;
 
-	for_each_bio(bio)
-		bio_for_each_bvec(bvec, bio, iter)
-			__blk_segment_map_sg(q, &bvec, sglist, &bvprv, sg,
-					     &nsegs);
+	for_each_bio(bio) {
+		bio_for_each_bvec(bvec, bio, iter) {
+			/*
+			 * Only try to merge bvecs from two bios given we
+			 * have done bio internal merge when adding pages
+			 * to bio
+			 */
+			if (!new_bio || !__blk_segment_map_sg_merge(q,
+						&bvec, &bvprv, sg))
+				__blk_segment_map_sg(q, &bvec, sglist, sg,
+						     &nsegs);
+			new_bio = false;
+		}
+		bvprv = bvec;
+		new_bio = true;
+	}
 
 	return nsegs;
 }
-- 
2.9.5

