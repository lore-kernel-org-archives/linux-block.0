Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994A0C761A6
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjDDPGS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjDDPGQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:06:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E180744A2
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K7DeqUzmghEEQ5YrSPMcpPaMnYhQNpyuFZCy6i2pCpY=; b=q0nC4iaie2YhusxgJKmsEZvoqa
        +UfUc7GcFognfEMz0PQ8phCtJPbAazkI1/7LAggJ90scn8zzfqWJ6Kd9mrolCq5M1CIy+jGEyHPLB
        hbv54ShhoOxOV6IuLD8LsehEvzByGqcI533JW38TXmoEUHAmSnr7hYHHnCKNfYQjvg7C06tyXtvGX
        pKjmUuP+lBg6wi/475Vbh7cVSLgQyu7sNQR5Wfj6+nfl883altlyESR6GsprpjW4kNQlnZ/ltDv/C
        aI7EJfxX8mUeGV5ce7LCGo8yARZiqueQSTYAE9Il99cg6tdRjC6e+vnrO8RbOkNxIxtpzVjCYpYVz
        nmlCMmXA==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiEc-001vtk-0r;
        Tue, 04 Apr 2023 15:06:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 12/16] zram: refactor zram_bdev_write
Date:   Tue,  4 Apr 2023 17:05:32 +0200
Message-Id: <20230404150536.2142108-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
References: <20230404150536.2142108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split the read/modify/write case into a separate helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 38 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1706462495edda..9a3bee1dda01c0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1574,33 +1574,33 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	return ret;
 }
 
-static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
-				u32 index, int offset, struct bio *bio)
+/*
+ * This is a partial IO.  Read the full page before to writing the changes.
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

