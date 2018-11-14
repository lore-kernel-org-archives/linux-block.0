Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A606EC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656B0208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d+ejy/83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656B0208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387573AbeKOCGp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbeKOCGp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ro9Z1mxySHMOZPQzQNxPeu1CfarThUmwHyQ4AR0wLyg=; b=d+ejy/83UU1tmpIPtwEAozSN5/
        NThRLKWhMStnSOt0JlmfblLKqSit2tOekj6E80/GZee/odahcKWxahRlSA2jPZHsDUdsczi7mm91X
        oBj7gSJ3xN+FyXJNOAG2ngGVSTuzsYC8qDHIW6VOkllrYdTgmf4yjr/znxNEioAak58okAIZcZrud
        Wbs6TR2GSXUXMvelC11qL6PwtoHppi0I8E8/oeX/kWvV/0p1KWBBO3A+zbj5zs18+6X2TxzU592oL
        tUMPIw665TXXTZ+NFPU2BJby2+W3VLXbGRG0i9gZ1BqyYqzhMDDh2jMYs8rE++buenUGFKXEUHJsF
        FXQ2lYAg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxd0-0006Iv-Sy; Wed, 14 Nov 2018 16:02:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 12/16] umem: don't override the queue_lock
Date:   Wed, 14 Nov 2018 17:02:15 +0100
Message-Id: <20181114160219.28328-13-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The umem card->lock and the block layer queue_lock are used for entirely
different resources.  Stop using card->lock as the block layer
queue_lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/umem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index be3e3ab79950..8a27b5adc2b3 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -888,8 +888,7 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	card->biotail = &card->bio;
 	spin_lock_init(&card->lock);
 
-	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE,
-					   &card->lock);
+	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
 	if (!card->queue)
 		goto failed_alloc;
 
-- 
2.19.1

