Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E11CC04E84
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2909205C9
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nhApb9PR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfEPIlu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 04:41:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfEPIlu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 04:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GXS5wrg0/DH/Il1G2fICdRWPEVWTbYLuvgIjSui3vGs=; b=nhApb9PRC3WzDFAgKfegg/Ba0J
        iJ3+7oqAL+go9u09LxYMQ7I3cdQhOCDY1PTaBBZO/ib9liuddAAwkipL+2dhW0CkNA+mY2bnyEwj3
        nWjYipWHvoBU3lQGc/LYFUWM3nMP5QfoInzKB1WV/hwXURZOlHXkIsy6WZvgMhADFe49e5et90Cnf
        SXzT3kSKY/HvTgM1Efgdg7J0jYVpNp68ZRMsTNonvep2jBqDW2Q9S97/j8dDN07ZxP4fHb2YYBKho
        R1a+6IV8RoeYpuIuROAB73ji6POcMo2r4c98vsdmEHdMti/F1TGLIUbnDns08RlAmpJYBkEgCJowr
        yOHNNsGQ==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRBxU-0005Oe-DH; Thu, 16 May 2019 08:41:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 1/4] block: don't decrement nr_phys_segments for physically contigous segments
Date:   Thu, 16 May 2019 10:40:55 +0200
Message-Id: <20190516084058.20678-2-hch@lst.de>
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

Currently ll_merge_requests_fn, unlike all other merge functions,
reduces nr_phys_segments by one if the last segment of the previous,
and the first segment of the next segement are contigous.  While this
seems like a nice solution to avoid building smaller than possible
requests it causes a mismatch between the segments actually present
in the request and those iterated over by the bvec iterators, including
__rq_for_each_bio.  This could cause overwrites of too small kmalloc
allocations in any driver using ranged discard, or also mistrigger
the single segment optimization in the nvme-pci driver.

We could possibly work around this by making the bvec iterators take
the front and back segment size into account, but that would require
moving them from the bio to the bio_iter and spreading this mess
over all users of bvecs.  Or we could simply remove this optimization
under the assumption that most users already build good enough bvecs,
and that the bio merge patch never cared about this optimization
either.  The latter is what this patch does.

Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
Fixes: 297910571f08 ("nvme-pci: optimize mapping single segment requests using SGLs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 21e87a714a73..80a5a0facb87 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -358,7 +358,6 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	unsigned front_seg_size;
 	struct bio *fbio, *bbio;
 	struct bvec_iter iter;
-	bool new_bio = false;
 
 	if (!bio)
 		return 0;
@@ -379,31 +378,12 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	nr_phys_segs = 0;
 	for_each_bio(bio) {
 		bio_for_each_bvec(bv, bio, iter) {
-			if (new_bio) {
-				if (seg_size + bv.bv_len
-				    > queue_max_segment_size(q))
-					goto new_segment;
-				if (!biovec_phys_mergeable(q, &bvprv, &bv))
-					goto new_segment;
-
-				seg_size += bv.bv_len;
-
-				if (nr_phys_segs == 1 && seg_size >
-						front_seg_size)
-					front_seg_size = seg_size;
-
-				continue;
-			}
-new_segment:
 			bvec_split_segs(q, &bv, &nr_phys_segs, &seg_size,
 					&front_seg_size, NULL, UINT_MAX);
-			new_bio = false;
 		}
 		bbio = bio;
-		if (likely(bio->bi_iter.bi_size)) {
+		if (likely(bio->bi_iter.bi_size))
 			bvprv = bv;
-			new_bio = true;
-		}
 	}
 
 	fbio->bi_seg_front_size = front_seg_size;
@@ -725,7 +705,6 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 			req->bio->bi_seg_front_size = seg_size;
 		if (next->nr_phys_segments == 1)
 			next->biotail->bi_seg_back_size = seg_size;
-		total_phys_segments--;
 	}
 
 	if (total_phys_segments > queue_max_segments(q))
-- 
2.20.1

