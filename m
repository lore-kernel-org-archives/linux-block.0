Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301F5C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0AD208A3
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uzbRax3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0AD208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeKPSVh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:21:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPSVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9K/1WWS47tApTIbqzAHltuA+xOBp3fzSdDsbzCUsvqM=; b=uzbRax3DeccAMuR74O3oc4UzMM
        cLf+5Q9wfqj3gpQG1197IZAwaTjXXY5enG47qBRy+maJp5Yxr2xmV/I5T3ZHZk8SK84g2yt3TGxbG
        kxFrmWKLK25TAQNPSPgzvT/FgLwoWNJAPzMXqf8x9LFsjT2/jojChPkPu/gp1ciCnrOd/RscA+hLQ
        4baKJ9CQEYx3gO2eygcd1BgUfCurJg9fav75lssCFz4GpUeldGrN9letZhMYbqSg3g4aEmct2opJ5
        F3hAh9r0h7oWIqQN8pibuROkC8ulDrr7LSUooOMzSkWKuLlXRLsUH86Xlpnh5kplXFCYo31juppF4
        4DdZKamQ==;
Received: from 089144201193.atnat0010.highway.a1.net ([89.144.201.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZCl-0002dD-7A; Fri, 16 Nov 2018 08:10:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 4/6] ide: don't acquire queue lock in ide_pm_execute_rq
Date:   Fri, 16 Nov 2018 09:10:04 +0100
Message-Id: <20181116081006.5083-5-hch@lst.de>
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

There is nothing we can synchronize against over a call to
blk_queue_dying.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-pm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index 51fe10ac02fa..56690f523100 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -44,15 +44,12 @@ static int ide_pm_execute_rq(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
-	spin_lock_irq(&q->queue_lock);
 	if (unlikely(blk_queue_dying(q))) {
 		rq->rq_flags |= RQF_QUIET;
 		scsi_req(rq)->result = -ENXIO;
-		spin_unlock_irq(&q->queue_lock);
 		blk_mq_end_request(rq, BLK_STS_OK);
 		return -ENXIO;
 	}
-	spin_unlock_irq(&q->queue_lock);
 	blk_execute_rq(q, NULL, rq, true);
 
 	return scsi_req(rq)->result ? -EIO : 0;
-- 
2.19.1

