Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCEBC6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjDDPGB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjDDPGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:06:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE683C3E
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SY+wti8btETa+xXWtZBnpEq14h3gWuvgNOEXxRjIPuY=; b=eL91Gd3/or7Ss1YgjL98RjYlKS
        3AH2cJSDAd26VLnkweOpS76W6WavqckTm45n7rmSEPR6j6DUMgDz04V/hRjLjFurPjUcnz1hM2jcS
        sPJzBTZSbYaOY4pUwiPUZv8lIcpZBkJLDCQpAoWYtUcwLREXbxkbiH0eKcv+fHqHbBzNgvzZOD/YE
        2I20/yCNVjeZxgGsOGIEjAjiV/zW4gGCtTJu8AjHLpIwJyDN5g29sIniH406dcrwnLOPPTKQIE1N5
        sEUVE+Z9pLRX23Y9gcWO0MIIsRE0TLT9OM7MdGSSeJNKcadxoe194xCsV/eiwV3jF9riR1VIUUUAu
        DHUgs3Dw==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiEP-001vrn-1z;
        Tue, 04 Apr 2023 15:05:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 07/16] zram: don't use highmem for the bounce buffer in zram_bvec_{read,write}
Date:   Tue,  4 Apr 2023 17:05:27 +0200
Message-Id: <20230404150536.2142108-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
References: <20230404150536.2142108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no point in allocation a highmem page when we instantly need
to copy from it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 83991cb61edaf6..0e91e94f24cd09 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1437,7 +1437,7 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 	page = bvec->bv_page;
 	if (is_partial_io(bvec)) {
 		/* Use a temporary buffer to decompress the page */
-		page = alloc_page(GFP_NOIO|__GFP_HIGHMEM);
+		page = alloc_page(GFP_NOIO);
 		if (!page)
 			return -ENOMEM;
 	}
@@ -1446,12 +1446,8 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
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
@@ -1595,12 +1591,11 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 
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
 
@@ -1608,9 +1603,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
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

