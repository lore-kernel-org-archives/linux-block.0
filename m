Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C62EC7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbjDFOnO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbjDFOmn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16ADAF18
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/NN9mTLcIJNZkr1cMZcXdIavMNmq1jDtesiF3xEWhF4=; b=Sy+5ImSXBQSLvf3U4GiGMBN5T4
        9uqE3E0PRB6Y5BqvYsV1DI6UiKFNGr86Wc4awC8V4YY8M9Qlod+LUl6HZh0rH/HcCrrVpSBlCJnUg
        qXJEscfDDxJUVtm85aD/vZMhOQa5ic20XIkcL2NbIvgpNac1jHlBGvBWJQZWAYvwpjaHDm0JpqzbD
        vSmPICW1A0AfebBOrMj9EJEfhfd7/sA/Yoh9tppd1XG1JrrYb7E8oAzX/3dk1sXvzvdBr45qTSqJ0
        QXZT0YnUc3ASCY2zreMUFOjfQwcmQz/dIsHssrR4g0S3bRhXYrIcrurAA7vW4xB9f1leVjmwlwQ4o
        FnJCtF+Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQnk-007fjd-3A;
        Thu, 06 Apr 2023 14:41:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 08/16] zram: rename __zram_bvec_read to zram_read_page
Date:   Thu,  6 Apr 2023 16:40:54 +0200
Message-Id: <20230406144102.149231-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__zram_bvec_read doesn't get passed a bvec, but always read a whole
page.  Rename it to make the usage more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 86d20011680f52..eb2601d2853f90 100644
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

