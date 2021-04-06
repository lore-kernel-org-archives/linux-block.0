Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E0DC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 06:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D27E61369
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 06:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhDFGRA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhDFGQ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 02:16:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EC9C06174A
        for <linux-block@vger.kernel.org>; Mon,  5 Apr 2021 23:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CKI2EnLchT7bFhg3F856Iw/iLSgJTDGxVAZRttJbKH0=; b=3LDwGsp6s8YYNRUxhCpvzC2YEn
        S2NujulkqezDgBKsVKi+Nzv9xLt1frpBhYOis+vfNnT/6uceYJ6xSFQmIJEqJ/A/0sRJLLjLmG1GA
        RakME+yWci5tC8lJshggrs61e0+siKQuUxQoBMbKkdcMh4W9Lue3rDp0Fmo9byea57aWDjGYk2ptv
        ixQSZTKXiV7PeJHZUd3PegETAR9Bvc7L39xLzCw2iBvalepacSDnbJcWMGtAC/WVv2D8ANwOsWCAs
        rEIq5zpoI1AQe+vgtKYRPZYfVvFcG15ZjdMFiohKWXUj4v34JamYdC0jz+qG+v25bUOEqp9x1tucF
        QATG1xaQ==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf18-007o02-PB; Tue, 06 Apr 2021 06:16:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] gdrom: support highmem
Date:   Tue,  6 Apr 2021 08:16:48 +0200
Message-Id: <20210406061648.811275-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The gdrom driver only has a single reference to the virtual address of
the bio data, and uses that only to get the physical address.  Switch
to deriving the physical address from the page directly and thus avoid
bounce buffering highmem data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/cdrom/gdrom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 9874fc1c815b53..e7717d09086841 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -583,7 +583,8 @@ static blk_status_t gdrom_readdisk_dma(struct request *req)
 	read_command->cmd[1] = 0x20;
 	block = blk_rq_pos(req)/GD_TO_BLK + GD_SESSION_OFFSET;
 	block_cnt = blk_rq_sectors(req)/GD_TO_BLK;
-	__raw_writel(virt_to_phys(bio_data(req->bio)), GDROM_DMA_STARTADDR_REG);
+	__raw_writel(page_to_phys(bio_page(req->bio)) + bio_offset(rq->bio),
+			GDROM_DMA_STARTADDR_REG);
 	__raw_writel(block_cnt * GDROM_HARD_SECTOR, GDROM_DMA_LENGTH_REG);
 	__raw_writel(1, GDROM_DMA_DIRECTION_REG);
 	__raw_writel(1, GDROM_DMA_ENABLE_REG);
@@ -789,8 +790,6 @@ static int probe_gdrom(struct platform_device *devptr)
 		goto probe_fail_requestq;
 	}
 
-	blk_queue_bounce_limit(gd.gdrom_rq, BLK_BOUNCE_HIGH);
-
 	err = probe_gdrom_setupqueue();
 	if (err)
 		goto probe_fail_toc;
-- 
2.30.1

