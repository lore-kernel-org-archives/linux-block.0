Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82ABC63697
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 21:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948D722240
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 21:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YIwSTpF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgKPVUb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 16:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgKPVUb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 16:20:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D79EC0613D2
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 13:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=q5VEN3b+/NuaC3nLa7Ob8T2zF/1/3On5f5TLNt/sEKk=; b=YIwSTpF5kzhKmmKiqpPGukWFxz
        A7aCWJI0852003AaLLOHw/IHeQWP55bg/FJeYU7F1xFZ7/HM7j7jYTjpDLsFWPQMR0bib6SYGn7C/
        vhTa06Yge43BftvOPmcoivLExDjz/umIe7WPDefb33oPtpwcH0Vnc9gFZtvY3CpTCkrGy65G1tVfY
        dHQOu4sciUJGGudQ/Gi4syngn3bEgucV9cNFGPzlp0/v+rjCaENkvgv9or0710un00fi3lUogtZvd
        gGFQ4zsG+7Jr8jVTSWAQnZM1o9Z3rDCHzVQwrjug9KXZES2hRx5L3x79HjruhRVJ0N/gAcb5mItB3
        yKXR8HVw==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kelvE-0007Ot-Jt; Mon, 16 Nov 2020 21:20:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 3/6] zram: do not call set_blocksize
Date:   Mon, 16 Nov 2020 22:20:17 +0100
Message-Id: <20201116212020.1099154-4-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116212020.1099154-1-hch@lst.de>
References: <20201116212020.1099154-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

set_blocksize is used by file systems to use their preferred buffer cache
block size.  Block drivers should not set it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 11 +----------
 drivers/block/zram/zram_drv.h |  1 -
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 2e6d75ec1afddb..88baa6158eaee1 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -403,13 +403,10 @@ static void reset_bdev(struct zram *zram)
 		return;
 
 	bdev = zram->bdev;
-	if (zram->old_block_size)
-		set_blocksize(bdev, zram->old_block_size);
 	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
 	/* hope filp_close flush all of IO */
 	filp_close(zram->backing_dev, NULL);
 	zram->backing_dev = NULL;
-	zram->old_block_size = 0;
 	zram->bdev = NULL;
 	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
@@ -454,7 +451,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	struct file *backing_dev = NULL;
 	struct inode *inode;
 	struct address_space *mapping;
-	unsigned int bitmap_sz, old_block_size = 0;
+	unsigned int bitmap_sz;
 	unsigned long nr_pages, *bitmap = NULL;
 	struct block_device *bdev = NULL;
 	int err;
@@ -509,14 +506,8 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	old_block_size = block_size(bdev);
-	err = set_blocksize(bdev, PAGE_SIZE);
-	if (err)
-		goto out;
-
 	reset_bdev(zram);
 
-	zram->old_block_size = old_block_size;
 	zram->bdev = bdev;
 	zram->backing_dev = backing_dev;
 	zram->bitmap = bitmap;
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index f2fd46daa76045..712354a4207c77 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -118,7 +118,6 @@ struct zram {
 	bool wb_limit_enable;
 	u64 bd_wb_limit;
 	struct block_device *bdev;
-	unsigned int old_block_size;
 	unsigned long *bitmap;
 	unsigned long nr_pages;
 #endif
-- 
2.29.2

