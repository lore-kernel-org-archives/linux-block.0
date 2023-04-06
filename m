Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAADC77B71
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbjDFOnN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbjDFOmn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01B6A5ED
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=znXlGEBXgXgz2qYhouwBNtotSqrR5Y8dSYtNL29Q9/w=; b=fs7ZwD6ONspDcZdKCykO2dNMOk
        i12XfwTB5Rqg8bTBo5mYIElNv6kC3FUAXgX2dBkqMLIUjEaLpKKjcRePoNBXd0lCebf2iGx+rkbpg
        RhASX413vMWS1BdA+H72OFCSbX9sOOb+FRj9pb/RVA3XuCDAUAf3eIh4giQ8gRUKSo8BLx0B4fOyN
        9XmaMyR3I6bGEOrZm9QrJlwTdOjteMn3KRo/dcr1J09TEHpPGT90ZznWW+pX5kWqQizYR3S8QjE/K
        d0flkvJ9ooiF6lmGNLMsY4LyVlT+hIvt/NsWADXNjJZtEtdUrW1kfUNTyY4L4yaLtSCYoULeNTzrH
        lXezJthQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQni-007fir-2K;
        Thu, 06 Apr 2023 14:41:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 07/16] zram: don't use highmem for the bounce buffer in zram_bvec_{read,write}
Date:   Thu,  6 Apr 2023 16:40:53 +0200
Message-Id: <20230406144102.149231-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
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
---
 drivers/block/zram/zram_drv.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5e823dcd1975c0..86d20011680f52 100644
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

