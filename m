Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50897C433EC
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 06:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30AF22080D
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 06:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gNyTj+y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgGTGM4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgGTGM4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 02:12:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC47C0619D4
        for <linux-block@vger.kernel.org>; Sun, 19 Jul 2020 23:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F0w4gm+r/ZCjW2UZaGj48qh6lACFSmhuiNmBnlVqUUw=; b=gNyTj+y2AeJKACkPqR7hSsEn9k
        zf3tBGLvzP/J9+qAiXqvr2qY5pW4q6epcBe32qyKVwk6ldmf8xATLfvZPFDsp6GN28f8eZP0ImiAW
        9lskuAOXb45pJZWTrPtYlxCLUD9kT35ugMMxKCpNEYDTrJW4jPagAQVXs7t0k9/FE4ass0Mr7k7um
        G0+wRpKEXYpRR3G4Uhwvd8Og+DltTSvBkstEbohunpkKcqyo+5KY8biaUfIyj6FidR8Ewd4FiWW33
        fqjXwCicTCAb8BYkI+SH3E+brQGMVpfsinZO73cjZ//8pzqzkN1mLV/Oh2nB3X+AY3pupW740CL9E
        E7qkT4Nw==;
Received: from [2001:4bb8:105:4a81:b96b:120c:c0c5:74fd] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxP2j-0006g6-1O; Mon, 20 Jul 2020 06:12:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 1/3] block: inherit the zoned characteristics in blk_stack_limits
Date:   Mon, 20 Jul 2020 08:12:49 +0200
Message-Id: <20200720061251.652457-2-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720061251.652457-1-hch@lst.de>
References: <20200720061251.652457-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Lift the code from device mapper into blk_stack_limits to inherity
the stacking limitations.  This ensures we do the right thing for
all stacked zoned block devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c   |  1 +
 drivers/md/dm-table.c  | 19 -------------------
 include/linux/blkdev.h |  9 ++++++---
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9a2c23cd970073..9cddbd73647405 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -609,6 +609,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		t->chunk_sectors = min_not_zero(t->chunk_sectors,
 						b->chunk_sectors);
 
+	t->zoned = max(t->zoned, b->zoned);
 	return ret;
 }
 EXPORT_SYMBOL(blk_stack_limits);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0ea5b7367179ff..ec5364133cef7f 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -467,9 +467,6 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
 		       q->limits.logical_block_size,
 		       q->limits.alignment_offset,
 		       (unsigned long long) start << SECTOR_SHIFT);
-
-	limits->zoned = blk_queue_zoned_model(q);
-
 	return 0;
 }
 
@@ -1528,22 +1525,6 @@ int dm_calculate_queue_limits(struct dm_table *table,
 			       dm_device_name(table->md),
 			       (unsigned long long) ti->begin,
 			       (unsigned long long) ti->len);
-
-		/*
-		 * FIXME: this should likely be moved to blk_stack_limits(), would
-		 * also eliminate limits->zoned stacking hack in dm_set_device_limits()
-		 */
-		if (limits->zoned == BLK_ZONED_NONE && ti_limits.zoned != BLK_ZONED_NONE) {
-			/*
-			 * By default, the stacked limits zoned model is set to
-			 * BLK_ZONED_NONE in blk_set_stacking_limits(). Update
-			 * this model using the first target model reported
-			 * that is not BLK_ZONED_NONE. This will be either the
-			 * first target device zoned model or the model reported
-			 * by the target .io_hints.
-			 */
-			limits->zoned = ti_limits.zoned;
-		}
 	}
 
 	/*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 06995b96e94679..67b9ccc1da3560 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -306,11 +306,14 @@ enum blk_queue_state {
 
 /*
  * Zoned block device models (zoned limit).
+ *
+ * Note: This needs to be ordered from the least to the most severe
+ * restrictions for the inheritance in blk_stack_limits() to work.
  */
 enum blk_zoned_model {
-	BLK_ZONED_NONE,	/* Regular block device */
-	BLK_ZONED_HA,	/* Host-aware zoned block device */
-	BLK_ZONED_HM,	/* Host-managed zoned block device */
+	BLK_ZONED_NONE = 0,	/* Regular block device */
+	BLK_ZONED_HA,		/* Host-aware zoned block device */
+	BLK_ZONED_HM,		/* Host-managed zoned block device */
 };
 
 struct queue_limits {
-- 
2.27.0

