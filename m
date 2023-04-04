Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854B5C6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjDDPGF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjDDPGE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:06:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75ED40F9
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UCfHBZgPzLq5TY68QDamp27NnqgWab+PmtQajQRfCuE=; b=RLL4VDM8RlmEIdwZnWZ2huSJz4
        jexBOVv6/KJI2ly5egslwa1D4VY34eiOGQzP2HOfuw9Ubst1RJ76VbY0RgeIoih3Ef2HnFIHV0xcr
        tZeZIYCPZRBNMAiDgvUurf/ae2rfHnBUaomq8pvPU/l48olJ2adhTVscS8geHomNFrKHFnA/Nlzkk
        OSL18y1qygtDwaR0BAEHxh3odFg+UCF4Zd//3PUnlvFaPjP1wlWo93SBq7pQj1VyDmAVWDwi2JABO
        2ngQ8uzCzY3mbmC88vBwZCN8ZTprWPZZMFxhvW2OhDK5P6oBja3XTk4BUa2nYM4xNfF7wbBOFK47i
        P902HXaQ==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiES-001vsD-0Z;
        Tue, 04 Apr 2023 15:06:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 08/16] zram: rename __zram_bvec_read to zram_read_page
Date:   Tue,  4 Apr 2023 17:05:28 +0200
Message-Id: <20230404150536.2142108-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
References: <20230404150536.2142108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__zram_bvec_read doesn't get passed a bvec, but always read a whole
page.  Rename it to make the usage more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0e91e94f24cd09..6187e41a346fd8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1403,8 +1403,8 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 	return ret;
 }
 
-static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
-			    struct bio *bio, bool partial_io)
+static int zram_read_page(struct zram *zram, struct page *page, u32 index,
+			  struct bio *bio, bool partial_io)
 {
 	int ret;
 
@@ -1442,7 +1442,7 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 			return -ENOMEM;
 	}
 
-	ret = __zram_bvec_read(zram, page, index, bio, is_partial_io(bvec));
+	ret = zram_read_page(zram, page, index, bio, is_partial_io(bvec));
 	if (unlikely(ret))
 		goto out;
 
@@ -1599,7 +1599,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		if (!page)
 			return -ENOMEM;
 
-		ret = __zram_bvec_read(zram, page, index, bio, true);
+		ret = zram_read_page(zram, page, index, bio, true);
 		if (ret)
 			goto out;
 
-- 
2.39.2

