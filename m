Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E87C77B70
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbjDFOnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbjDFOmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39324B441
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mq4F1kyDJd/dgfEDJELYNz4bj09Cn4aGLiY06lw0NfM=; b=HPxHmszMI1PiIXqIwH8rE0fWbf
        WvjCSJVOjyqwK9L8KoHc/+Otc12fDpO3DCRwOLnPoOVmAsTMrblY6FlGgmiOGmKYbXsgJ85psLETp
        JnHeedl6HfWWHs+WcUEMZwvtohUnjlwUzW0D8TRx0byDNmaoI6rwFc9CXKnTM1BZQPcwaEfeA3Yhh
        gmKOPoeHe2fU4dgE2wcN7u6owBiMjo34GPYX+x2X4cv4Y9SFaHZ56UknHTp+AT5Ub3SKWht9v1ZVa
        ofvIiF9E/Anf4ED2sYSjg0aTjkrrAIiwU7YUTTiNNniwewWkPpugbcCnF1lge51dR+a6OLgFlbpu/
        3r+tEoGw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQnp-007fl8-1b;
        Thu, 06 Apr 2023 14:41:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 10/16] zram: refactor zram_bdev_read
Date:   Thu,  6 Apr 2023 16:40:56 +0200
Message-Id: <20230406144102.149231-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split the partial read into a separate helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ad648886e6398c..ccc222cc7aae6d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1422,33 +1422,33 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
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

