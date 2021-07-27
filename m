Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B430C4320A
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4FA61131
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhG0Gbe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 02:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhG0Gbe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 02:31:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83609C061757
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 23:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zgLN6u1pQT5+6UVRmgiDaj/l2aWdVOEfD6Q37eZi1Ac=; b=cxS7BszZooweuLeiHdtEHQRL5/
        yVgvdu//Nj3c1LndMdS2mMFgECL9th7se+rieTsKdFdfJPgJ4wFg9ta2Wm/E5ZvDxJ/pdO1CUDVoz
        YAvoO48HlN7L1mYRxpe2UxpyA6IznfelOCNMzfX4ScZUojQ+1dloy9RZ6yCcasvF4ZOhWkeYkcctb
        r2LLxi5R1M8Bm/Lz1EkZC/JjNgkqUFdtN39oWpnFBJPe8iPVx95qXUSxa7gHaNuEPiDVRzW/UWDrK
        ltm0CrzXgET/UexxNa33srbSvk9gdW3uiiAg9Ofy43JHAErAenNvYgLDOh59YF3j9mmLYE7yPBQ/u
        /EtBdBDA==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8Gbc-00EkXR-BZ; Tue, 27 Jul 2021 06:30:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 4/6] block: simplify printing the device names disk_stack_limits
Date:   Tue, 27 Jul 2021 08:25:16 +0200
Message-Id: <20210727062518.122108-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727062518.122108-1-hch@lst.de>
References: <20210727062518.122108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Printk ->disk_name directly for the disk and use the %pg format specifier
for the block device, which is equivalent to a bdevname call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 902c40d67120..109012719aa0 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -661,15 +661,9 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 	struct request_queue *t = disk->queue;
 
 	if (blk_stack_limits(&t->limits, &bdev_get_queue(bdev)->limits,
-			get_start_sect(bdev) + (offset >> 9)) < 0) {
-		char top[BDEVNAME_SIZE], bottom[BDEVNAME_SIZE];
-
-		disk_name(disk, 0, top);
-		bdevname(bdev, bottom);
-
-		printk(KERN_NOTICE "%s: Warning: Device %s is misaligned\n",
-		       top, bottom);
-	}
+			get_start_sect(bdev) + (offset >> 9)) < 0)
+		pr_notice("%s: Warning: Device %pg is misaligned\n",
+			disk->disk_name, bdev);
 
 	blk_queue_update_readahead(disk->queue);
 }
-- 
2.30.2

