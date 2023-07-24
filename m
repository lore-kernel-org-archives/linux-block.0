Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114A8C001DF
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 16:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGXQyi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjGXQyg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 12:54:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F71B1
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vetIgRUHufwzeRnjuJRycXGyA7SLucCmRaJ2A15U1u8=; b=xSkP9s5cnMw2rm25qOatBP0QlI
        se9gm7sy3SBWozr3rlLVXieAGQnHKRnzID/YgcLLs/b1VLKHs5RCZDiZBT+H+xLxrfS/JSU9zGjbV
        2idcuJfhVgMBqd7wAav2OynKlQ+ERyubjCWToA1xvVnZLKCn5Y61e1iQofYI4yV8KiGnxv27Om1Lb
        97/CwqLkAxINcCaJbp1fiO2V3N/NOftuJXkdkCbVSD9EI/C2N6zEHDSk5UjAGnu1Fo0CXEXTN+KEX
        z2oICr2dnUENcr8QgixWbjXQxS12gfWlnWOKMM5q47Pe9ffs+ior/+l+GPrsbs2LSVdtnur37gVPz
        HrHfSk4g==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNypO-004vuJ-0a;
        Mon, 24 Jul 2023 16:54:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/8] block: move the bi_vcnt check out of __bio_try_merge_page
Date:   Mon, 24 Jul 2023 09:54:29 -0700
Message-Id: <20230724165433.117645-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724165433.117645-1-hch@lst.de>
References: <20230724165433.117645-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the bi_vcnt out of __bio_try_merge_page and into the two callers
that don't already have it in preparation for additional changes to
__bio_try_merge_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3ac72e60e7f11c..3dcbe98580dcef 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -945,20 +945,17 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 static bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool *same_page)
 {
-	if (bio->bi_vcnt > 0) {
-		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
-		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len) {
-				*same_page = false;
-				return false;
-			}
-			bv->bv_len += len;
-			bio->bi_iter.bi_size += len;
-			return true;
-		}
+	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+	if (!page_is_mergeable(bv, page, len, off, same_page))
+		return false;
+	if (bio->bi_iter.bi_size > UINT_MAX - len) {
+		*same_page = false;
+		return false;
 	}
-	return false;
+	bv->bv_len += len;
+	bio->bi_iter.bi_size += len;
+	return true;
 }
 
 /*
@@ -1127,11 +1124,13 @@ int bio_add_page(struct bio *bio, struct page *page,
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
-	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
-		if (bio_full(bio, len))
-			return 0;
-		__bio_add_page(bio, page, len, offset);
-	}
+	if (bio->bi_vcnt > 0 &&
+	    __bio_try_merge_page(bio, page, len, offset, &same_page))
+		return len;
+
+	if (bio_full(bio, len))
+		return 0;
+	__bio_add_page(bio, page, len, offset);
 	return len;
 }
 EXPORT_SYMBOL(bio_add_page);
@@ -1205,13 +1204,13 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 {
 	bool same_page = false;
 
-	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
-		__bio_add_page(bio, page, len, offset);
+	if (bio->bi_vcnt > 0 &&
+	    __bio_try_merge_page(bio, page, len, offset, &same_page)) {
+		if (same_page)
+			bio_release_page(bio, page);
 		return 0;
 	}
-
-	if (same_page)
-		bio_release_page(bio, page);
+	__bio_add_page(bio, page, len, offset);
 	return 0;
 }
 
-- 
2.39.2

