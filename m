Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC70DC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4A4208A3
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K3UMraWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4A4208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeKPSVb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:21:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPSVb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MI1i0xQzqN3tr+cfBlxsGlOlMa1NqCtA/ZsCgRQ0/ns=; b=K3UMraWMZjpcC0IHdYspLEOfW4
        TKv0Ll926cfRLxcq5ljMGrUZFRYfqGLN/S/keFox/nhhsQ0I/CCPswCeTZru2rDTi9jGKHCa+PF6j
        W2C0gYDQWH9sdWiQN7uuCTD28sn5qAq1wC3oETp937jlCOtOH5FOfokgNPhJ/h0RnZ4OtCYh3lFBy
        pzowgLNAc8lN8mAAhuMkQuHlAFu0y+pM7yr+bM7rmBUJhrwzdg4jqn0c3qppkzWb2wX5jR2GJqPl4
        8JG9J1wFx5YUd+oCCiNbQjakjrXqcw6+jVG5q3D+cSAVhLRrW+9DRhq32tPrl+Xe19qcyzJO3XcjB
        kTKcvpcQ==;
Received: from 089144201193.atnat0010.highway.a1.net ([89.144.201.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZCf-0002bm-Pv; Fri, 16 Nov 2018 08:10:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 2/6] floppy: remove queue_lock around floppy_end_request
Date:   Fri, 16 Nov 2018 09:10:02 +0100
Message-Id: <20181116081006.5083-3-hch@lst.de>
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

There is nothing the queue_lock could protect inside floppy_end_request,
so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/floppy.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index eeb4be8d000b..218099dd8e44 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2254,10 +2254,7 @@ static void request_done(int uptodate)
 		if (block > _floppy->sect)
 			DRS->maxtrack = 1;
 
-		/* unlock chained buffers */
-		spin_lock_irqsave(&q->queue_lock, flags);
 		floppy_end_request(req, 0);
-		spin_unlock_irqrestore(&q->queue_lock, flags);
 	} else {
 		if (rq_data_dir(req) == WRITE) {
 			/* record write error information */
@@ -2269,9 +2266,7 @@ static void request_done(int uptodate)
 			DRWE->last_error_sector = blk_rq_pos(req);
 			DRWE->last_error_generation = DRS->generation;
 		}
-		spin_lock_irqsave(&q->queue_lock, flags);
 		floppy_end_request(req, BLK_STS_IOERR);
-		spin_unlock_irqrestore(&q->queue_lock, flags);
 	}
 }
 
-- 
2.19.1

