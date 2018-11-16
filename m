Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15015C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C766E208A3
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MxxbM1cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C766E208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeKPSVj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:21:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPSVj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZYPe9pZk5dh3TIT4QYW8UXm0Gwg1HrGIIZpoqnDaRls=; b=MxxbM1cc9C3VnzAScvMbFK+iRb
        GMmXHAh69kfX0gvKTpg5TtX5zp9xWSqYVATvoLLc6Qi10joiQFG0KH4z2xCzdXog436NidTT2+LIQ
        CHyykfXxBrta+umc8nBA4DDgqFaLcA++DYO5qvAR841TV2tvpotoRmHhRQYCqgtLxpRujXoooviOG
        sqhfZByybbxrjjiwZblB28Y2qE/sFtLOKBkrjsBA08/yXYuvAsTWbmFQObEK6J22KOZQJX/bO0ND7
        gweinuf4BFnSJ/z7MiQn7aeqbXWF/nSsgluXuOr/PAiFxxrLagspsAKTEnVe7BJcNABOFWqJY2Pdb
        WnRLUWBg==;
Received: from 089144201193.atnat0010.highway.a1.net ([89.144.201.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZCn-0002dn-T7; Fri, 16 Nov 2018 08:10:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 5/6] ide: don't acquire queue_lock in ide_complete_pm_rq
Date:   Fri, 16 Nov 2018 09:10:05 +0100
Message-Id: <20181116081006.5083-6-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116081006.5083-1-hch@lst.de>
References: <20181116081006.5083-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_stop_hw_queues doesn't need any locking, and the ide
dev_flags field isn't protected by it either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-pm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index 56690f523100..192e6c65d34e 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -201,7 +201,6 @@ void ide_complete_pm_rq(ide_drive_t *drive, struct request *rq)
 {
 	struct request_queue *q = drive->queue;
 	struct ide_pm_state *pm = ide_req(rq)->special;
-	unsigned long flags;
 
 	ide_complete_power_step(drive, rq);
 	if (pm->pm_step != IDE_PM_COMPLETED)
@@ -211,12 +210,10 @@ void ide_complete_pm_rq(ide_drive_t *drive, struct request *rq)
 	printk("%s: completing PM request, %s\n", drive->name,
 	       (ide_req(rq)->type == ATA_PRIV_PM_SUSPEND) ? "suspend" : "resume");
 #endif
-	spin_lock_irqsave(&q->queue_lock, flags);
 	if (ide_req(rq)->type == ATA_PRIV_PM_SUSPEND)
 		blk_mq_stop_hw_queues(q);
 	else
 		drive->dev_flags &= ~IDE_DFLAG_BLOCKED;
-	spin_unlock_irqrestore(&q->queue_lock, flags);
 
 	drive->hwif->rq = NULL;
 
-- 
2.19.1

