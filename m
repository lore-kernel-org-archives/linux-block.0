Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0E3C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbjDFOnR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbjDFOmy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C1C9768
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0WucdEfGx81cBHcQr2bMhSrLOdvatgVHMOoBSLULKJY=; b=ZFQj5krgyZKtRXScmluA7F9c68
        q8qAW555UcKZ0+xtPoQe9U7oIFnaYvlQthIeiyRlqqAEgTkO9H7nw+BakKEvRJApLmDTw8mb7uDv1
        ufyPbXGuRh5wttwlCAstuLiDqJg2aMmNahQoJEyzgC4NlkpsArnFmwnl1+NcMK9ZFO7Ex3py3QnXJ
        sTWFmyaThuR5rLtGSNO2OuR9DTIvop0ksZuRh+D4/LlqSfZxLyidDxObaEOtV7mK21J2D0p9znae9
        p7Bpt+f5Bc/4izcb5HS9Asx2h/UGxZhkZANHnWm616cFlGGlHMetB/3qhZLMeI/U5l6u0aTKiVbqz
        hl5GBlBg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQnr-007fm0-2S;
        Thu, 06 Apr 2023 14:41:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 11/16] zram: don't pass a bvec to __zram_bvec_write
Date:   Thu,  6 Apr 2023 16:40:57 +0200
Message-Id: <20230406144102.149231-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
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
---
 drivers/block/zram/zram_drv.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ccc222cc7aae6d..efda86abaf35c9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1449,8 +1449,7 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 	return zram_read_page(zram, bvec->bv_page, index, bio, false);
 }
 
-static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
-				u32 index, struct bio *bio)
+static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 {
 	int ret = 0;
 	unsigned long alloced_pages;
@@ -1458,7 +1457,6 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	unsigned int comp_len = 0;
 	void *src, *dst, *mem;
 	struct zcomp_strm *zstrm;
-	struct page *page = bvec->bv_page;
 	unsigned long element = 0;
 	enum zram_pageflags flags = 0;
 
@@ -1579,11 +1577,9 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
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
@@ -1598,11 +1594,9 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
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
@@ -1717,7 +1711,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 
 	/*
 	 * No direct reclaim (slow path) for handle allocation and no
-	 * re-compression attempt (unlike in __zram_bvec_write()) since
+	 * re-compression attempt (unlike in zram_write_bvec()) since
 	 * we already have stored that object in zsmalloc. If we cannot
 	 * alloc memory for recompressed object then we bail out and
 	 * simply keep the old (existing) object in zsmalloc.
-- 
2.39.2

