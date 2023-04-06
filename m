Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F271C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbjDFOnU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbjDFOm4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB8AB759
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5EZfOmE2b1W/ywhljFNHHDwu0HAanieDjaM3Yj6Ay5M=; b=4uSsDdUM+Mbzb/4m93Ckpjmfvr
        g35X7lbOHgHWM1ymqNsj6OSRUn5e8m6y/gRlZBvZQ9SY5YN4OSPIMVSOYxA19njcsoRR8GyB4gTKd
        W9Di+0U/urwEhUppCgCBO2UorxsF1kHUFKq02wWUCv9OXG+6OuDfgxIzNW2lFWFSuXaEjTWAUisJh
        dTZv7KeCs0Y/xBbEltjHPWMxs/o+F73gOraZsGQ9a6FK9yVmuQA4KdCDlY7Oo2ejuolXk+r+lhadX
        zac6XZz1aL7S7inZze91EPN7j/CIE27KA0Y1HZBRPIl2iD6UAZybDvUXLKWioPmA0wbjrR9ySLMB1
        vsMuiTtg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQo3-007fp9-0K;
        Thu, 06 Apr 2023 14:41:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 16/16] zram: return errors from read_from_bdev_sync
Date:   Thu,  6 Apr 2023 16:41:02 +0200
Message-Id: <20230406144102.149231-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
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
---
 drivers/block/zram/zram_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5259b647010afe..3af04684c11ebb 100644
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
 #else
 static int read_from_bdev_sync(struct zram *zram, struct page *page,
@@ -821,7 +822,7 @@ static int read_from_bdev(struct zram *zram, struct page *page,
 	if (!parent)
 		return read_from_bdev_sync(zram, page, entry);
 	read_from_bdev_async(zram, page, entry, parent);
-	return 1;
+	return 0;
 }
 #else
 static inline void reset_bdev(struct zram *zram) {};
-- 
2.39.2

