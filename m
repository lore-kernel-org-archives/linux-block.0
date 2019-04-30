Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87064C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 17:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4688B21734
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 17:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W/pTzRWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfD3R4x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:56:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfD3R4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 13:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nnCfruNuQlKJuMIlZx3nmjn383Fsnp32cs81TYygLdk=; b=W/pTzRWZWs0QYnHZoFjOhVxw+
        fnoOF9gzcsuPrO1g5n09WFsGheudkskKlgLXCilumI/PhcsVwv0zrFSl+wYWioLFL2Ps/CeBYvk/w
        pDNaUpMv9dlpIKRHUa6Katn0DMN0GoERoo37hUTR3Ef16p79aH6NF9z1vJ0gHOFxquMfKYvwWTxKa
        vS9ppbHVN/42LixAdWzVPv8a60iMvH7T4QyPnQssB6EyQISLYKq+XA/yI21ZxnefqsiPScET3z38R
        jxBT2/hH6wX+PIGPynMqt8sPvfjJq+DoDg0DfbruO3INQF31YPPwM3M8cRnBAM6fOfIJaIVvAlp1s
        ldJDnQLWg==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLWzs-0000LN-TL; Tue, 30 Apr 2019 17:56:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: remove the unused blk_queue_dma_pad function
Date:   Tue, 30 Apr 2019 13:56:16 -0400
Message-Id: <20190430175616.26639-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c   | 16 ----------------
 include/linux/blkdev.h |  1 -
 2 files changed, 17 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 6375afaedcec..e8889e48b032 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -662,22 +662,6 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 }
 EXPORT_SYMBOL(disk_stack_limits);
 
-/**
- * blk_queue_dma_pad - set pad mask
- * @q:     the request queue for the device
- * @mask:  pad mask
- *
- * Set dma pad mask.
- *
- * Appending pad buffer to a request modifies the last entry of a
- * scatter list such that it includes the pad buffer.
- **/
-void blk_queue_dma_pad(struct request_queue *q, unsigned int mask)
-{
-	q->dma_pad_mask = mask;
-}
-EXPORT_SYMBOL(blk_queue_dma_pad);
-
 /**
  * blk_queue_update_dma_pad - update pad mask
  * @q:     the request queue for the device
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99aa98f60b9e..bd3e3f09bfa0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1069,7 +1069,6 @@ extern int bdev_stack_limits(struct queue_limits *t, struct block_device *bdev,
 extern void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 			      sector_t offset);
 extern void blk_queue_stack_limits(struct request_queue *t, struct request_queue *b);
-extern void blk_queue_dma_pad(struct request_queue *, unsigned int);
 extern void blk_queue_update_dma_pad(struct request_queue *, unsigned int);
 extern int blk_queue_dma_drain(struct request_queue *q,
 			       dma_drain_needed_fn *dma_drain_needed,
-- 
2.20.1

