Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B1DC77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDKRP4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjDKRPs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39575BB1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mlgREu1NkLtQSezrOrFLEvx95u/tri5z3wNKL/U8AJg=; b=aiLP5hLV9byPCOdgvJET8vzawX
        EPfob8KPnY2NfY+bjJU00vfbKPBqpFqsGhqsuPDd43vG3p1QBlS0ay0XIsCPz/q9jmv0/pvanfrNt
        LiHG9K9AQCqFYNeQ6dVk2b4NTchJS+ngDIJmmQ7donFKXJXbqjoieh799R/Cqrw5y3alHai7M1+Kq
        cr79ZvkfkC1TY4+WS5fZa+Y6ZF6hvMY6LXLJwgaNVO5OarL7lsH49+tiIxadi85XiPFekWn6ZMwRq
        Ofiv7heYmJ8QDd9zqGIJ1L7rFHcq5Ta/6d7CCClZHiUZfVpJ4ayXFi6sxW42XsTnbwMiYCLO5WsTX
        iwSM7/bQ==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHah-000gql-0m;
        Tue, 11 Apr 2023 17:15:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 13/17] zram: refactor zram_bdev_write
Date:   Tue, 11 Apr 2023 19:14:55 +0200
Message-Id: <20230411171459.567614-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split the read/modify/write case into a separate helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 38 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e8b81471be3dfe..74ba5d676e0769 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1568,33 +1568,33 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	return ret;
 }
 
-static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
-				u32 index, int offset, struct bio *bio)
+/*
+ * This is a partial IO. Read the full page before writing the changes.
+ */
+static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
+				   u32 index, int offset, struct bio *bio)
 {
-	struct page *page = bvec->bv_page;
+	struct page *page = alloc_page(GFP_NOIO);
 	int ret;
 
-	if (is_partial_io(bvec)) {
-		/*
-		 * This is a partial IO. We need to read the full page
-		 * before to write the changes.
-		 */
-		page = alloc_page(GFP_NOIO);
-		if (!page)
-			return -ENOMEM;
-
-		ret = zram_read_page(zram, page, index, bio, true);
-		if (ret)
-			goto out;
+	if (!page)
+		return -ENOMEM;
 
+	ret = zram_read_page(zram, page, index, bio, true);
+	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
+		ret = zram_write_page(zram, page, index);
 	}
+	__free_page(page);
+	return ret;
+}
 
-	ret = zram_write_page(zram, page, index);
-out:
+static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
+			   u32 index, int offset, struct bio *bio)
+{
 	if (is_partial_io(bvec))
-		__free_page(page);
-	return ret;
+		return zram_bvec_write_partial(zram, bvec, index, offset, bio);
+	return zram_write_page(zram, bvec->bv_page, index);
 }
 
 #ifdef CONFIG_ZRAM_MULTI_COMP
-- 
2.39.2

