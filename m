Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF70C77B70
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDKRQC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjDKRP4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA394EDC
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hlVB+qT0X7UoAn6AyRquYGWIcRCbcfFPR45gcY/AxFM=; b=YKYWcLyA5NxQf3AYwEpTz2EXrv
        i6tOwPBZuejC3lPTt3wbnrFycABxp7GhG4/Z5YvcXtemqzuOZl5cThZXtypw+2NpCm9jcVfWCsnam
        Yej9MxND7vBQUmTIdkynQj6XUKxLS4uZMBrhp12qmfHFMt9WS4l+AIUzsA6KNqQZEYaqnrEjT2ph9
        +uA5gXk8PGOmzldwHCdt4nzE0FDg5VJxXCigmc5y06qjy80sZjWjXCDDRRvqinbdILAgrtP2Skv13
        yqkknvXChujR/LNCGqCbRwCRVxOpKDoJ4EL2kA8orKAx77e909HMBZwmiR7gV1b/GfeG9HAgDJioB
        vgAj/ODA==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHam-000grp-1s;
        Tue, 11 Apr 2023 17:15:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 15/17] zram: don't return errors from read_from_bdev_async
Date:   Tue, 11 Apr 2023 19:14:57 +0200
Message-Id: <20230411171459.567614-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_alloc will never return a NULL bio when it is allowed to sleep,
and adding a single page to bio with a single vector also can't
fail, so switch to the asserting __bio_add_page variant and drop the
error returns.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a63f09e8aa2225..07ebce1fde581b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -585,24 +585,16 @@ static void zram_page_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-/*
- * Returns 1 if the submission is successful.
- */
-static int read_from_bdev_async(struct zram *zram, struct page *page,
+static void read_from_bdev_async(struct zram *zram, struct page *page,
 			unsigned long entry, struct bio *parent)
 {
 	struct bio *bio;
 
 	bio = bio_alloc(zram->bdev, 1, parent ? parent->bi_opf : REQ_OP_READ,
 			GFP_NOIO);
-	if (!bio)
-		return -ENOMEM;
 
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
-	if (!bio_add_page(bio, page, PAGE_SIZE, 0)) {
-		bio_put(bio);
-		return -EIO;
-	}
+	__bio_add_page(bio, page, PAGE_SIZE, 0);
 
 	if (!parent)
 		bio->bi_end_io = zram_page_end_io;
@@ -610,7 +602,6 @@ static int read_from_bdev_async(struct zram *zram, struct page *page,
 		bio_chain(bio, parent);
 
 	submit_bio(bio);
-	return 1;
 }
 
 #define PAGE_WB_SIG "page_index="
@@ -840,7 +831,8 @@ static int read_from_bdev(struct zram *zram, struct page *page,
 			return -EIO;
 		return read_from_bdev_sync(zram, page, entry, parent);
 	}
-	return read_from_bdev_async(zram, page, entry, parent);
+	read_from_bdev_async(zram, page, entry, parent);
+	return 1;
 }
 #else
 static inline void reset_bdev(struct zram *zram) {};
-- 
2.39.2

