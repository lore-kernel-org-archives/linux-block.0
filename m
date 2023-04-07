Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D43C76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 07:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjDGHWn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239610AbjDGHWm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 03:22:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C532993E1
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 00:22:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3621E68D05; Fri,  7 Apr 2023 09:22:25 +0200 (CEST)
Date:   Fri, 7 Apr 2023 09:22:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 15/16] zram: fix synchronous reads
Message-ID: <20230407072224.GA8982@lst.de>
References: <20230406144102.149231-1-hch@lst.de> <20230406144102.149231-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-16-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Meh, turns out this doesn't even compile for PAGE_SIZE > 4096.

Below is the fix, which also removes the #if and instead relies
on compiler dead code elimination.  I wonder if zram should (maybe
optionally) also offer a 512 byte block size, so that we could
also test the smaller than page size I/O path even on x86.

---
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3af04684c11ebb..c989907301d06e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -764,7 +764,6 @@ static ssize_t writeback_store(struct device *dev,
 	return ret;
 }
 
-#if PAGE_SIZE != 4096
 struct zram_work {
 	struct work_struct work;
 	struct zram *zram;
@@ -776,7 +775,7 @@ struct zram_work {
 static void zram_sync_read(struct work_struct *work)
 {
 	struct zram_work *zw = container_of(work, struct zram_work, work);
-	struct bio_bvec bv;
+	struct bio_vec bv;
 	struct bio bio;
 
 	bio_init(&bio, zw->zram->bdev, &bv, 1, REQ_OP_READ);
@@ -795,6 +794,9 @@ static int read_from_bdev_sync(struct zram *zram, struct page *page,
 {
 	struct zram_work work;
 
+	if (WARN_ON_ONCE(PAGE_SIZE != 4096))
+		return -EIO;
+
 	work.page = page;
 	work.zram = zram;
 	work.entry = entry;
@@ -806,14 +808,6 @@ static int read_from_bdev_sync(struct zram *zram, struct page *page,
 
 	return work.error;
 }
-#else
-static int read_from_bdev_sync(struct zram *zram, struct page *page,
-				unsigned long entry)
-{
-	WARN_ON(1);
-	return -EIO;
-}
-#endif
 
 static int read_from_bdev(struct zram *zram, struct page *page,
 			unsigned long entry, struct bio *parent)
