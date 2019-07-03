Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448BFC06513
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 13:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0C6218A3
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 13:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rMOKc9c0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfGCNAq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:00:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCNAq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 09:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jCSitBxDTnnPnfavDdA8LwduSs3p4uBrAPPT5ncg/qE=; b=rMOKc9c0VFons9yr2hbvWbZpNV
        gIVxBzCQIVHNdYoGAT3o4kiwvT6Bg5UEFNF11V1sqHgbaOvvYIJKVlaIV/su0G8cvOXsGaJSiJ8Je
        KmMFm1niEnofR5UXkfgi8KDSFYdMMXYU19tPNJ1/vIh9UpT0NAEiP0T3o/SuUDAD7ZrizsIV5renb
        ldioKa5ckdmb5HioPYRPowC8g/aIyzoCynawoRUBxB5oANZGs74toCZWgSKjOohXLUdtJKB+pPCVi
        6GVYsAIjtc1/bi3MjrO9bbARfwR8g4mH2uvqCEbmXhyKihnkzrn21dkFnhFfe1luJUWb7K2aOBeMH
        IkBsSU9w==;
Received: from [12.46.110.2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiesP-0006Yu-6e; Wed, 03 Jul 2019 13:00:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: create bio_try_merge_pc_page helper __bio_add_pc_page
Date:   Wed,  3 Jul 2019 06:00:35 -0700
Message-Id: <20190703130036.4105-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703130036.4105-1-hch@lst.de>
References: <20190703130036.4105-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Passsthrough bio handling should be the same as normal bio handling,
except that we need to take hardware limitations into account.  Thus
use the common try_merge implementation after checking the hardware
limits.  This changes behavior in that we now also check segment
and dma boundary settings for same page merges, which is a little
more work but has no effect as those need to be larger than the
page size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 6be22b8477ce..1db626f99bcb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -645,25 +645,20 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	return true;
 }
 
-/*
- * Check if the @page can be added to the current segment(@bv), and make
- * sure to call it only if page_is_mergeable(@bv, @page) is true
- */
-static bool can_add_page_to_seg(struct request_queue *q,
-		struct bio_vec *bv, struct page *page, unsigned len,
-		unsigned offset)
+static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned len, unsigned offset,
+		bool *same_page)
 {
+	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 	unsigned long mask = queue_segment_boundary(q);
 	phys_addr_t addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
 	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
 
 	if ((addr1 | mask) != (addr2 | mask))
 		return false;
-
 	if (bv->bv_len + len > queue_max_segment_size(q))
 		return false;
-
-	return true;
+	return __bio_try_merge_page(bio, page, len, offset, same_page);
 }
 
 /**
@@ -699,26 +694,18 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-		bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
-		if (page == bvec->bv_page &&
-		    offset == bvec->bv_offset + bvec->bv_len) {
-			if (put_same_page)
+		if (bio_try_merge_pc_page(q, bio, page, len, offset,
+				&same_page)) {
+			if (put_same_page && same_page)
 				put_page(page);
-			bvec->bv_len += len;
-			goto done;
-		}
-
-		if (page_is_mergeable(bvec, page, len, offset, &same_page) &&
-		    can_add_page_to_seg(q, bvec, page, len, offset)) {
-			bvec->bv_len += len;
-			goto done;
+			return len;
 		}
 
 		/*
 		 * If the queue doesn't support SG gaps and adding this segment
 		 * would create a gap, disallow it.
 		 */
+		bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
 		if (bvec_gap_to_prev(q, bvec, offset))
 			return 0;
 	}
@@ -734,7 +721,6 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	bvec->bv_len = len;
 	bvec->bv_offset = offset;
 	bio->bi_vcnt++;
- done:
 	bio->bi_iter.bi_size += len;
 	return len;
 }
-- 
2.20.1

