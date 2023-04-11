Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BB3C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjDKRPa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjDKRP0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6AE59FF
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J+5aQb+09nxJm4igUD3XUroxFh6/Gpfn5gsTkEIsY98=; b=vTsBRXCGJ76WAOvitXxfkK+lt6
        S6Nv7WX+YUUy0MKhEoud9XnnEkdGULafxK6CMk7XdEZ/3gwKVmU8EMTkUIqVlSExyBDDEUpGnUqGm
        tWymsrmmokWVDLGmT+vvgjhs3L2U0gUtksjdyv9sQ6oiDBqLXM4gRcLTX853+V83zR7CuaFzfjXtO
        is0XeEciiOUZdelABJJQ1oRq54TjFkYjblzTH/eD5HJvntrytKwHhtV7+XVrzYq80vf2EF0fWCkkb
        U1KX/Czg2h/+uSDB5CKO7k+zTERXMmM9l05GzpRqMICaTD/ZAlWuXuoqQuM6FBaQAJ6IsWBR21Giu
        QBy7dm4Q==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHaT-000gnl-2q;
        Tue, 11 Apr 2023 17:15:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 08/17] zram: don't use highmem for the bounce buffer in zram_bvec_{read,write}
Date:   Tue, 11 Apr 2023 19:14:50 +0200
Message-Id: <20230411171459.567614-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no point in allocation a highmem page when we instantly need
to copy from it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 2d0154489f0327..0182316b2a901d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1431,7 +1431,7 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 	page = bvec->bv_page;
 	if (is_partial_io(bvec)) {
 		/* Use a temporary buffer to decompress the page */
-		page = alloc_page(GFP_NOIO|__GFP_HIGHMEM);
+		page = alloc_page(GFP_NOIO);
 		if (!page)
 			return -ENOMEM;
 	}
@@ -1440,12 +1440,8 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 	if (unlikely(ret))
 		goto out;
 
-	if (is_partial_io(bvec)) {
-		void *src = kmap_atomic(page);
-
-		memcpy_to_bvec(bvec, src + offset);
-		kunmap_atomic(src);
-	}
+	if (is_partial_io(bvec))
+		memcpy_to_bvec(bvec, page_address(page) + offset);
 out:
 	if (is_partial_io(bvec))
 		__free_page(page);
@@ -1589,12 +1585,11 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 
 	vec = *bvec;
 	if (is_partial_io(bvec)) {
-		void *dst;
 		/*
 		 * This is a partial IO. We need to read the full page
 		 * before to write the changes.
 		 */
-		page = alloc_page(GFP_NOIO|__GFP_HIGHMEM);
+		page = alloc_page(GFP_NOIO);
 		if (!page)
 			return -ENOMEM;
 
@@ -1602,9 +1597,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		if (ret)
 			goto out;
 
-		dst = kmap_atomic(page);
-		memcpy_from_bvec(dst + offset, bvec);
-		kunmap_atomic(dst);
+		memcpy_from_bvec(page_address(page) + offset, bvec);
 
 		bvec_set_page(&vec, page, PAGE_SIZE, 0);
 	}
-- 
2.39.2

