Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDCAC7EE2F
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 13:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbjELNjX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 09:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241299AbjELNjS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 09:39:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F9A124B8
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NypuyImQg9oREjLzD6jqxIwGbXT3DZrzWS9cwrXtmQk=; b=p69MSwq1dAj6oMkU9rcZcqsEW+
        IgZcLXSYy3XKGEduSq/PXBKtVrnMV6jjbmKtvi6MLcl0vNlmV4Eg/v0bZqHafEXfeOWZFPy7vQ/SP
        DlOEDv9O7JyrFesMFUTv/Gx5utg6L+e/qddo1aiGixddUQ5DPbHiOxUaWDoo/yxul5pFj9lEBSN7N
        YOG3adJvwG+fy3Y+NwFP9Izag9D9+fHrw/XJexXZGGS62vN1qEe07AgJjrL/Gzs08qKBGdtePwFcx
        KXYyqZbw5M/ZuL97+RpHLCwpbAK6jv/FpJ7hLqaVtujeonM35rOsH9NW2FMcTbfvrEYU+tEasS+Jz
        3PdylS8Q==;
Received: from [204.239.251.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSzM-00C2ij-0D;
        Fri, 12 May 2023 13:39:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 8/8] block: don't pass a bio to bio_try_merge_hw_seg
Date:   Fri, 12 May 2023 06:39:01 -0700
Message-Id: <20230512133901.1053543-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512133901.1053543-1-hch@lst.de>
References: <20230512133901.1053543-1-hch@lst.de>
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
---
 block/bio.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 106009707ca1c5..79e8aa600ddbe2 100644
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

