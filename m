Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B182C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA422251B
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA422251B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbeKNBO1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:14:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387822AbeKNBO1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:14:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDAF763144;
        Tue, 13 Nov 2018 15:15:52 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C42145D961;
        Tue, 13 Nov 2018 15:15:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V9 04/19] block: use bio_for_each_bvec() to map sg
Date:   Tue, 13 Nov 2018 23:14:50 +0800
Message-Id: <20181113151505.15498-5-ming.lei@redhat.com>
In-Reply-To: <20181113151505.15498-1-ming.lei@redhat.com>
References: <20181113151505.15498-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 13 Nov 2018 15:15:53 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is more efficient to use bio_for_each_bvec() to map sg, meantime
we have to consider splitting multipage bvec as done in blk_bio_segment_split().

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 72 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6f7deb94a23f..cb9f49bcfd36 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -473,6 +473,56 @@ static int blk_phys_contig_segment(struct request_queue *q, struct bio *bio,
 	return biovec_phys_mergeable(q, &end_bv, &nxt_bv);
 }
 
+static struct scatterlist *blk_next_sg(struct scatterlist **sg,
+		struct scatterlist *sglist)
+{
+	if (!*sg)
+		return sglist;
+	else {
+		/*
+		 * If the driver previously mapped a shorter
+		 * list, we could see a termination bit
+		 * prematurely unless it fully inits the sg
+		 * table on each mapping. We KNOW that there
+		 * must be more entries here or the driver
+		 * would be buggy, so force clear the
+		 * termination bit to avoid doing a full
+		 * sg_init_table() in drivers for each command.
+		 */
+		sg_unmark_end(*sg);
+		return sg_next(*sg);
+	}
+}
+
+static unsigned blk_bvec_map_sg(struct request_queue *q,
+		struct bio_vec *bvec, struct scatterlist *sglist,
+		struct scatterlist **sg)
+{
+	unsigned nbytes = bvec->bv_len;
+	unsigned nsegs = 0, total = 0;
+
+	while (nbytes > 0) {
+		unsigned seg_size;
+		struct page *pg;
+		unsigned offset, idx;
+
+		*sg = blk_next_sg(sg, sglist);
+
+		seg_size = min(nbytes, queue_max_segment_size(q));
+		offset = (total + bvec->bv_offset) % PAGE_SIZE;
+		idx = (total + bvec->bv_offset) / PAGE_SIZE;
+		pg = nth_page(bvec->bv_page, idx);
+
+		sg_set_page(*sg, pg, seg_size, offset);
+
+		total += seg_size;
+		nbytes -= seg_size;
+		nsegs++;
+	}
+
+	return nsegs;
+}
+
 static inline void
 __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 		     struct scatterlist *sglist, struct bio_vec *bvprv,
@@ -490,25 +540,7 @@ __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 		(*sg)->length += nbytes;
 	} else {
 new_segment:
-		if (!*sg)
-			*sg = sglist;
-		else {
-			/*
-			 * If the driver previously mapped a shorter
-			 * list, we could see a termination bit
-			 * prematurely unless it fully inits the sg
-			 * table on each mapping. We KNOW that there
-			 * must be more entries here or the driver
-			 * would be buggy, so force clear the
-			 * termination bit to avoid doing a full
-			 * sg_init_table() in drivers for each command.
-			 */
-			sg_unmark_end(*sg);
-			*sg = sg_next(*sg);
-		}
-
-		sg_set_page(*sg, bvec->bv_page, nbytes, bvec->bv_offset);
-		(*nsegs)++;
+		(*nsegs) += blk_bvec_map_sg(q, bvec, sglist, sg);
 	}
 	*bvprv = *bvec;
 }
@@ -530,7 +562,7 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 	int cluster = blk_queue_cluster(q), nsegs = 0;
 
 	for_each_bio(bio)
-		bio_for_each_segment(bvec, bio, iter)
+		bio_for_each_bvec(bvec, bio, iter)
 			__blk_segment_map_sg(q, &bvec, sglist, &bvprv, sg,
 					     &nsegs, &cluster);
 
-- 
2.9.5

