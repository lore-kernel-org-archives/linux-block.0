Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ABCC77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjDKRPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjDKRP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA845FF6
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lJe4ctwNnT+7juo8OW1ShS+6XeD28mMEUfnMIlQv8kQ=; b=mxDGWUUAVDC+xPzEiIa/C/xo8h
        zBd3MpVXUCNzC9Fwm/Kt85bRgHWFsjsrxuettm5bE0p8BA6C2aa5rHlw34BVJC7/c3fXyAIKDSLCF
        za6zjlDZY06XRtJMCoo7V46SXtsZtm2TdRjYJSjkXzZ33sJXp6G+Z9aYU/tVkTUAIvTRIzgGJQCmK
        8LSc06UuHinAVqMvzCwlXhgsTFfCbgFV6ieLMDl+5neRlz5qb9ugZvVB3mNtrARhDgM/d9pDaRcJz
        S7qiJvMab2ldASrjGrBIIwdH5KGnMUBTvtjK7iJFOwz6wimq3hVQHa3jN51fJF11jfAgqF3IQICpt
        ip9kP4hQ==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHaW-000goX-1g;
        Tue, 11 Apr 2023 17:15:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 09/17] zram: rename __zram_bvec_read to zram_read_page
Date:   Tue, 11 Apr 2023 19:14:51 +0200
Message-Id: <20230411171459.567614-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
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
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0182316b2a901d..414343b46ade8d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1397,8 +1397,8 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 	return ret;
 }
 
-static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
-			    struct bio *bio, bool partial_io)
+static int zram_read_page(struct zram *zram, struct page *page, u32 index,
+			  struct bio *bio, bool partial_io)
 {
 	int ret;
 
@@ -1436,7 +1436,7 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 			return -ENOMEM;
 	}
 
-	ret = __zram_bvec_read(zram, page, index, bio, is_partial_io(bvec));
+	ret = zram_read_page(zram, page, index, bio, is_partial_io(bvec));
 	if (unlikely(ret))
 		goto out;
 
@@ -1593,7 +1593,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		if (!page)
 			return -ENOMEM;
 
-		ret = __zram_bvec_read(zram, page, index, bio, true);
+		ret = zram_read_page(zram, page, index, bio, true);
 		if (ret)
 			goto out;
 
-- 
2.39.2

