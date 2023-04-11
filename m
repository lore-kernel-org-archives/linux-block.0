Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE649C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjDKRQF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjDKRP6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A1340FA
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bT8CN9qA97rzqZcb5O209yuHANBEKszUCS1gX5fPJYM=; b=iurpIo50B/MyPpPB5iNHm53igf
        RGI836ODTty92V0M9rLIAp/XYncfvM8UtaLI29zmAgH7pcajLTT3JB/sEmZrgbf9a38xSqTdFl5JI
        RnkGEbVyl63iWPEs9U5QdHt10BesTcJlvnjWNq06I7Z0Bea+ivgNhwZhj7RM4LJTRhnReKz45ceh6
        jIqbYV4dXWu9/AspZfAv9StKMqemZ+UGy60yZ02sA/4nZWgrFT3hSn377OupxIX2F26b5phTaIn8C
        yRvNR1UEEE+2OOx0YAFCE+B93G0Yu3fFTgdHa/lgptt+tT3+G/5cYbJOnwPVVNVxwJG1tYD7tHnK+
        JfGH0TpQ==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHar-000gtJ-24;
        Tue, 11 Apr 2023 17:15:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 17/17] zram: return errors from read_from_bdev_sync
Date:   Tue, 11 Apr 2023 19:14:59 +0200
Message-Id: <20230411171459.567614-18-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Propagate read errors to the caller instead of dropping them on
the floor, and stop returning the somewhat dangerous 1 on success
from read_from_bdev*.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 07114607c1ea11..095549c99f9f13 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -770,6 +770,7 @@ struct zram_work {
 	struct zram *zram;
 	unsigned long entry;
 	struct page *page;
+	int error;
 };
 
 static void zram_sync_read(struct work_struct *work)
@@ -781,7 +782,7 @@ static void zram_sync_read(struct work_struct *work)
 	bio_init(&bio, zw->zram->bdev, &bv, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = zw->entry * (PAGE_SIZE >> 9);
 	__bio_add_page(&bio, zw->page, PAGE_SIZE, 0);
-	submit_bio_wait(&bio);
+	zw->error = submit_bio_wait(&bio);
 }
 
 /*
@@ -803,7 +804,7 @@ static int read_from_bdev_sync(struct zram *zram, struct page *page,
 	flush_work(&work.work);
 	destroy_work_on_stack(&work.work);
 
-	return 1;
+	return work.error;
 }
 
 static int read_from_bdev(struct zram *zram, struct page *page,
@@ -816,7 +817,7 @@ static int read_from_bdev(struct zram *zram, struct page *page,
 		return read_from_bdev_sync(zram, page, entry);
 	}
 	read_from_bdev_async(zram, page, entry, parent);
-	return 1;
+	return 0;
 }
 #else
 static inline void reset_bdev(struct zram *zram) {};
-- 
2.39.2

