Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AC2C0015E
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 16:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGXQyk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGXQyj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 12:54:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED0F10F5
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+wZ6RZIImLBGbn4gu+hmurcknkaqcxp6cNAZ4SE8xjs=; b=bwaSONhL3b8YYZoKbwAnmCQFB7
        bHxzp2mzcJauWLwMxetkGm8b0fUrNX6RRgW+bA+vBlUJUlHH23p8K2lB66gk+t72T3Gy2I5DRQgjw
        nTeJukBiqZ1HOVIQF2mTiACya0e68CT/sStfUAbb1WERFG1xdue/jyiTGfT3ziq3ZhcCjigxHiI4l
        /AHbJWGqVFmrltEUVEoOKSUC75LpRAWNKS77zeCv+4OUhC4y1MnuTJ4AgpqPsLJga4OMoMHYVr+57
        xjqTWJIH/Ejok6W/+NC1xnatVWxy9tlB/1z8eDGBNYs5XkEew15BkJZxoulbp5ch15WRLsNJUX1Bh
        SBu4JmMQ==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNypP-004vvB-0B;
        Mon, 24 Jul 2023 16:54:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 8/8] block: don't pass a bio to bio_try_merge_hw_seg
Date:   Mon, 24 Jul 2023 09:54:33 -0700
Message-Id: <20230724165433.117645-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724165433.117645-1-hch@lst.de>
References: <20230724165433.117645-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no good reason to pass the bio to bio_try_merge_hw_seg.  Just
pass the current bvec and rename the function to bvec_try_merge_hw_page.
This will allow reusing this function for supporting multi-page integrity
payload bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 23b7a001b5005d..c92dda962449b0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -934,11 +934,10 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
  * size limit.  This is not for normal read/write bios, but for passthrough
  * or Zone Append operations that we can't split.
  */
-static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
-				 struct page *page, unsigned len,
-				 unsigned offset, bool *same_page)
+static bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
+		struct page *page, unsigned len, unsigned offset,
+		bool *same_page)
 {
-	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 	unsigned long mask = queue_segment_boundary(q);
 	phys_addr_t addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
 	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
@@ -967,8 +966,6 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page)
 {
-	struct bio_vec *bvec;
-
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
@@ -976,7 +973,9 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-		if (bio_try_merge_hw_seg(q, bio, page, len, offset,
+		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
 				same_page)) {
 			bio->bi_iter.bi_size += len;
 			return len;
@@ -990,8 +989,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		 * If the queue doesn't support SG gaps and adding this segment
 		 * would create a gap, disallow it.
 		 */
-		bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
-		if (bvec_gap_to_prev(&q->limits, bvec, offset))
+		if (bvec_gap_to_prev(&q->limits, bv, offset))
 			return 0;
 	}
 
-- 
2.39.2

