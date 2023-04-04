Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6855EC77B60
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjDDPG3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjDDPG2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:06:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184024208
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Z31TaxcmBcQbY5YTlosn00gPAt+82xXlAsoIcw5In2M=; b=uQ9UTzJVgXvGcIfJtsQA8bK/hc
        Ik4zIFgliSiyNq035wr81VbaIGiwmPYye+JoeN9kS1mms+IWJp3b09Lz1baLKLykkApRx/gCRnd8S
        519ZbpInoYEx+qREpiRAS3EUtb+hs66/6g27debBn5UQJyON+VTEnhdCFEle4g8E/PO1e3YFeFRym
        0mCKM5+TZqMBEZon0xoy1FCkKC0cIeLm29oelyGNcxklQGpVJz+5GPvZD2PxcGL2fjIYKjRH84ics
        ZLJl9Ym1nTjTY2b9Sf4ffAHX8MbLYmQmLLxpVQagIA1UVtKRlcsnwksLDKzfeUPV28tvmZhiX+TfP
        HqyJP5WQ==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiEm-001vvr-1T;
        Tue, 04 Apr 2023 15:06:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 16/16] zram: return errors from read_from_bdev_sync
Date:   Tue,  4 Apr 2023 17:05:36 +0200
Message-Id: <20230404150536.2142108-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
References: <20230404150536.2142108-1-hch@lst.de>
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
---
 drivers/block/zram/zram_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0a98a0ba14607a..0be1633b0f4e94 100644
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

