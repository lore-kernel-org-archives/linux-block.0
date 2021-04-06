Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589FAC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 06:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265BD613AF
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 06:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhDFGRf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhDFGRf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 02:17:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E9C06174A
        for <linux-block@vger.kernel.org>; Mon,  5 Apr 2021 23:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=q/rD2pjdggckvMxnskvKDSxvQXZbHhjM2M4+LkaAmxU=; b=HgMhJ7TGHSEaR7UUd4+WiA+M7A
        AHqjpdcg28EPtr5UENQhyxNLcEszUztwlwCSAk0JgaIn+TJ/gh+sBPCi2fq9L/XETdoXIHQQuypEG
        xwapL/cnrz6q85qSakH4EMQ7u3Z4Co7up7qXa6/wZPXxQXRCNSIR+NAihE5dEV4tdGmgGIp/LqUS5
        FIITYJSiAzOGcI7o0a7XPWSHGsej1KDNnL9QEXOgK9+MMrRbF5fmGOPBgE6sVuZl7TGEg2tt3ftw7
        d08/BT6O4S9nkxAVeJrm2F2x8dvgdoPrxnjZYRNSwbCTEcJQURUuJpF5LeIliEGfNlxIdpy7FM9pu
        z8N8QQuA==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf1j-007o0k-G8; Tue, 06 Apr 2021 06:17:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] swim: don't call blk_queue_bounce_limit
Date:   Tue,  6 Apr 2021 08:17:25 +0200
Message-Id: <20210406061725.811389-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

m68k doesn't support highmem, so don't bother enabling the block layer
bounce buffer code.  Just for safety throw in a depend on !HIGHMEM.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/Kconfig | 2 +-
 drivers/block/swim.c  | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index fd236158f32d99..cbc9f7a18c99e9 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -50,7 +50,7 @@ config MAC_FLOPPY
 
 config BLK_DEV_SWIM
 	tristate "Support for SWIM Macintosh floppy"
-	depends on M68K && MAC
+	depends on M68K && MAC && !HIGHMEM
 	help
 	  You should select this option if you want floppy support
 	  and you don't have a II, IIfx, Q900, Q950 or AV series.
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index cc6a0bc6c005a7..2917b21f48ff27 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -816,8 +816,6 @@ static int swim_floppy_init(struct swim_priv *swd)
 		}
 
 		swd->unit[drive].disk->queue = q;
-		blk_queue_bounce_limit(swd->unit[drive].disk->queue,
-				BLK_BOUNCE_HIGH);
 		swd->unit[drive].disk->queue->queuedata = &swd->unit[drive];
 		swd->unit[drive].swd = swd;
 	}
-- 
2.30.1

