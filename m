Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A319EC76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjDKRPs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDKRPn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFBA5FE1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Br/m5G7K0/F3RbcB/XBOJLorZVyjPiqv5CQSKw3CLT0=; b=hRGXoehtK4O0+4ZYP0S2YQ9dQX
        QeHuZE9EH4USSe8zxHd38vwjJJ93mVrulURByhjunlks2kccWRQrv/N0hfb2X6bVd02+134zFhFy+
        14NCy2uy489hHbVX/rFYhxt5nvn4wyM+a4Tk+FjkwboGyscXVRWz3XT55K1VxKsIEzFgXJZNu1ScZ
        8QiVbP887Lm9YeEMpEcK2tTpwJAvA6y9n0WoCknYnefe4Lk2fjym1LMx3DBuPKjvEXI7tg4MEhRkb
        ccFYhaApROEY5C6p2l7z/JKmc5kV+TXkKGEHvqzdhlsVX8ujDBCR3yCEQh0MiAIB1nYUT2YQE6Ffk
        aNyUXyXw==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHae-000gqL-1g;
        Tue, 11 Apr 2023 17:15:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 12/17] zram: don't pass a bvec to __zram_bvec_write
Date:   Tue, 11 Apr 2023 19:14:54 +0200
Message-Id: <20230411171459.567614-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__zram_bvec_write only extracts the page from __zram_bvec_write and
always expects a full page of input.  Pass the page directly instead
of the bvec and rename the function to zram_write_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f2467ea1699a99..e8b81471be3dfe 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1443,8 +1443,7 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 	return zram_read_page(zram, bvec->bv_page, index, bio, false);
 }
 
-static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
-				u32 index, struct bio *bio)
+static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 {
 	int ret = 0;
 	unsigned long alloced_pages;
@@ -1452,7 +1451,6 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	unsigned int comp_len = 0;
 	void *src, *dst, *mem;
 	struct zcomp_strm *zstrm;
-	struct page *page = bvec->bv_page;
 	unsigned long element = 0;
 	enum zram_pageflags flags = 0;
 
@@ -1573,11 +1571,9 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 				u32 index, int offset, struct bio *bio)
 {
+	struct page *page = bvec->bv_page;
 	int ret;
-	struct page *page = NULL;
-	struct bio_vec vec;
 
-	vec = *bvec;
 	if (is_partial_io(bvec)) {
 		/*
 		 * This is a partial IO. We need to read the full page
@@ -1592,11 +1588,9 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 			goto out;
 
 		memcpy_from_bvec(page_address(page) + offset, bvec);
-
-		bvec_set_page(&vec, page, PAGE_SIZE, 0);
 	}
 
-	ret = __zram_bvec_write(zram, &vec, index, bio);
+	ret = zram_write_page(zram, page, index);
 out:
 	if (is_partial_io(bvec))
 		__free_page(page);
@@ -1711,7 +1705,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 
 	/*
 	 * No direct reclaim (slow path) for handle allocation and no
-	 * re-compression attempt (unlike in __zram_bvec_write()) since
+	 * re-compression attempt (unlike in zram_write_bvec()) since
 	 * we already have stored that object in zsmalloc. If we cannot
 	 * alloc memory for recompressed object then we bail out and
 	 * simply keep the old (existing) object in zsmalloc.
-- 
2.39.2

