Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85052C04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 07:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE9920863
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 07:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SRBXVKKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfEUHB5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 03:01:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfEUHB4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 03:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PK76R5YXJP7s3AD7eJLRJnbrnPYmKnRoB76Z2J8gtE4=; b=SRBXVKKyq/QNLZ7EjJcswMyb19
        jgSHKpz83G94w9MCZgXCoPHArnBzwRq/t39DJ9OTnKO9KSfWiDN7ogZDjXWYOGFgAhTOV5h9zscKX
        Q7Vl7KMdL7qFlz7L7fSBO9M8FkHY5aUF9uCKHxd2/d0aqz4NtJQytjaF429xKZPaxRJM1DNEH8Ssm
        xcFj3VM1w0x8KQ703yhKvPmiKz9m1sHZvH9Kk5zoPqy9uBvYCdGy1za84+1O/h0bOmcvXTJIWE1ee
        u9zZLV8MIULYVbIUb9twnhWSOcbZ9mbXlicXVyAMyxq0+zi1+Cj9CgC9xHw4xVCnuSbmXigmHS9cm
        atcmUkSw==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSymY-0000Yw-5H; Tue, 21 May 2019 07:01:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 1/4] block: don't decrement nr_phys_segments for physically contigous segments
Date:   Tue, 21 May 2019 09:01:40 +0200
Message-Id: <20190521070143.22631-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521070143.22631-1-hch@lst.de>
References: <20190521070143.22631-1-hch@lst.de>
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
__rq_for_each_bio.  This can for example mistrigger the single segment
optimization in the nvme-pci driver, and might lead to mismatching
nr_phys_segments number when recalculating the number of request
when inserting a cloned request.

We could possibly work around this by making the bvec iterators take
the front and back segment size into account, but that would require
moving them from the bio to the bio_iter and spreading this mess
over all users of bvecs.  Or we could simply remove this optimization
under the assumption that most users already build good enough bvecs,
and that the bio merge patch never cared about this optimization
either.  The latter is what this patch does.

dff824b2aadb ("nvme-pci: optimize mapping of small single segment requests").
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
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

