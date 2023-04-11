Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF807C77B75
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDKRPl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjDKRPk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E386184
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TwWj4VFBEJHFExdLR4ZiBMbusjO4xwclep5hB6mvlww=; b=Tx0G2pD1gZl4H/1XEzCmk8nz3c
        qoQcTt9p7ZTSCmENa99GaBuxhH/NfiJ9Lda78wHuyIYef0SdXTRnnZUKMHVGEmaMpIrXqrblk0u8E
        Oo2iKLs5HiOPCAZTckC/A5M63jdL+PrOoL+JxXcdfPaCfA+8AdhjqhUiv/9ntooqT+d0s3TMVKzW6
        8I69y/9Z6miDE7ZpI7qKTy6ZXXjHextULbkvnbcOJeTSofrP4vNpIVgDFnggFaT80jb95oXGcdZX7
        Yk3J0jzixhr6lJi9GD7gRJlW3UlhEA6YNqWvQ//58SKRiyuv2k6/i1XPhIWDuE+LaWX0XQAQkVVgo
        HixUIqOw==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHab-000gpz-2k;
        Tue, 11 Apr 2023 17:15:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 11/17] zram: refactor zram_bdev_read
Date:   Tue, 11 Apr 2023 19:14:53 +0200
Message-Id: <20230411171459.567614-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split the partial read into a separate helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 67b88e9a978d9e..f2467ea1699a99 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1416,33 +1416,33 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 	return ret;
 }
 
-static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
-			  u32 index, int offset, struct bio *bio)
+/*
+ * Use a temporary buffer to decompress the page, as the decompressor
+ * always expects a full page for the output.
+ */
+static int zram_bvec_read_partial(struct zram *zram, struct bio_vec *bvec,
+				  u32 index, int offset, struct bio *bio)
 {
+	struct page *page = alloc_page(GFP_NOIO);
 	int ret;
-	struct page *page;
-
-	page = bvec->bv_page;
-	if (is_partial_io(bvec)) {
-		/* Use a temporary buffer to decompress the page */
-		page = alloc_page(GFP_NOIO);
-		if (!page)
-			return -ENOMEM;
-	}
-
-	ret = zram_read_page(zram, page, index, bio, is_partial_io(bvec));
-	if (unlikely(ret))
-		goto out;
 
-	if (is_partial_io(bvec))
+	if (!page)
+		return -ENOMEM;
+	ret = zram_read_page(zram, page, index, bio, true);
+	if (likely(!ret))
 		memcpy_to_bvec(bvec, page_address(page) + offset);
-out:
-	if (is_partial_io(bvec))
-		__free_page(page);
-
+	__free_page(page);
 	return ret;
 }
 
+static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
+			  u32 index, int offset, struct bio *bio)
+{
+	if (is_partial_io(bvec))
+		return zram_bvec_read_partial(zram, bvec, index, offset, bio);
+	return zram_read_page(zram, bvec->bv_page, index, bio, false);
+}
+
 static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 				u32 index, struct bio *bio)
 {
-- 
2.39.2

