Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BBDC388F7
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0CC1206CA
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 08:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iBHaN211"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgKMIrP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 03:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKMIrP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 03:47:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1015DC0613D1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 00:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9lKq2FkXB8aVs50m97W/1b21gdL/YzMgPQj+/cAVyjQ=; b=iBHaN211dm4Rmk56aMwxwz4znD
        enc8SgVwQb+L5EbZggqPcIdM7cFsxO7HrvH/cfJQuapWQvdL9JjYCI3Y6RdvQ4iUlsnmSG1XpW1ly
        B1+jH4VBvH2sl52oapQnFPD9sc+y182HnR/Ov3vZOGky6EARqsz0tWZyR2W9MikGQ3Ko2BLZ1Rkwb
        FYTKdwpv52qKULTsGsEdnHq71FMUmyQTzaH05Tb9qhCypAoAmF2CanoCQ6VsAs+POP1qkRueklC2R
        UPNJz7yAhcCsj9OB+PXRV7tB1QkUk4fAdUFUdE9f4qLLtQGeRIoPtE9HesRf3HPkG/xCo/BilaTnz
        xPTL1how==;
Received: from [2001:4bb8:180:6600:bcb2:53c8:d87f:72a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdUja-0000QZ-6t; Fri, 13 Nov 2020 08:47:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org
Subject: [PATCH 2/3] rbd: remove the ->set_read_only methods
Date:   Fri, 13 Nov 2020 09:47:01 +0100
Message-Id: <20201113084702.4164912-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113084702.4164912-1-hch@lst.de>
References: <20201113084702.4164912-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that the hardware read-only state can't be changed by the BLKROSET
ioctl, the code in this method is not required anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rbd.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 671733e459cf47..6ff1193d3d06d0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -692,29 +692,10 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
 	put_device(&rbd_dev->dev);
 }
 
-static int rbd_set_read_only(struct block_device *bdev, bool ro)
-{
-	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
-
-	/*
-	 * Both images mapped read-only and snapshots can't be marked
-	 * read-write.
-	 */
-	if (!ro) {
-		if (rbd_is_ro(rbd_dev))
-			return -EROFS;
-
-		rbd_assert(!rbd_is_snap(rbd_dev));
-	}
-
-	return 0;
-}
-
 static const struct block_device_operations rbd_bd_ops = {
 	.owner			= THIS_MODULE,
 	.open			= rbd_open,
 	.release		= rbd_release,
-	.set_read_only		= rbd_set_read_only,
 };
 
 /*
-- 
2.28.0

