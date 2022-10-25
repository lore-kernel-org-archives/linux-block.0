Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E8FC04A95
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 15:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiJYP7T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiJYP7R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 11:59:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC2217C570
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Lsq7KyhPZFOEaSmOToUcDByLDkvv2ua6Zsf/JXWw3HU=; b=NffMZSTT3PNPtMiN2oVUy+jvvR
        qENcrcN+jQocswo14QmHTSZ46Le4jgYc1/EyyEqlz/jkYqbc3MsXZI4wOy3iGs03FnNgcIF3mi+b2
        O9jnVxPsmzJadG/D2xi8OpMpy1x4V2cpXCmQtfcYHWxa06I3goxhTonOzZGSd3QIxoUaERQ5Usuca
        4kD24F+CSllw8Fj72dAUJgVuumHOFcRqRQEEHbUuLSd0JO59uYKfmW4r2Wc3s9SeKifbDa6ZOoSPZ
        yCuf16jZEuputzc/oCDSQrdTgM+X8ZE5ISf6nKgMeyjHcfpzmTS1xq+V7sQNkr3Z1OGJMCvArD5W8
        SVOdIEMA==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onMKi-006Ceg-BV; Tue, 25 Oct 2022 15:59:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: remove bio_start_io_acct_time
Date:   Tue, 25 Oct 2022 08:59:16 -0700
Message-Id: <20221025155916.270303-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_start_io_acct_time is not actually used anywhere, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 12 ------------
 include/linux/blkdev.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 17667159482e0..5d50dd16e2a59 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -945,18 +945,6 @@ unsigned long bdev_start_io_acct(struct block_device *bdev,
 }
 EXPORT_SYMBOL(bdev_start_io_acct);
 
-/**
- * bio_start_io_acct_time - start I/O accounting for bio based drivers
- * @bio:	bio to start account for
- * @start_time:	start time that should be passed back to bio_end_io_acct().
- */
-void bio_start_io_acct_time(struct bio *bio, unsigned long start_time)
-{
-	bdev_start_io_acct(bio->bi_bdev, bio_sectors(bio),
-			   bio_op(bio), start_time);
-}
-EXPORT_SYMBOL_GPL(bio_start_io_acct_time);
-
 /**
  * bio_start_io_acct - start I/O accounting for bio based drivers
  * @bio:	bio to start account for
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50e358a19d986..57ed49f20d2eb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1458,7 +1458,6 @@ unsigned long bdev_start_io_acct(struct block_device *bdev,
 void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 		unsigned long start_time);
 
-void bio_start_io_acct_time(struct bio *bio, unsigned long start_time);
 unsigned long bio_start_io_acct(struct bio *bio);
 void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
 		struct block_device *orig_bdev);
-- 
2.30.2

