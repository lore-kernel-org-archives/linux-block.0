Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E35CC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27472133F
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M85yOWeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeLQLQf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:16:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeLQLQf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 06:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Mq1XE6sOlGG7H622Ru+1eMmqu5Mw9VFat3HqFvoNeEo=; b=M85yOWeDRkYuy/bYHfMt1s8lsB
        +GMBTjYG5xw0Va00yzTjHEalBeFlqnpkS/foiDnVxk9A8v0iXHXr5H5VXaJJV/yE4rX4ryseIRXFh
        68AhONh2nCXQ26dEnAwavaKy6dolK9tR+DoFXkjwJz/4V4jFjgSeGgQj4UhWx6WFiG+qxlo5jlnGV
        KiycjcemK/6BXMAjjxyLqqPcF5xVC6eqZEjDdTEwFlrgRuGFzcGvuyGR3CsB9nR8oBCaTpDde242U
        J59eTWO41SVKuU+BxSqF6lCA4jEbWTeVs5uSjxHHpqs0UWjgk+s1PEaqAv4HvIb7FXxfsYedOvmC/
        EHisT1qw==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYqsz-0000t2-F9; Mon, 17 Dec 2018 11:16:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-pci: don't share queue maps
Date:   Mon, 17 Dec 2018 12:16:27 +0100
Message-Id: <20181217111627.22635-2-hch@lst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217111627.22635-1-hch@lst.de>
References: <20181217111627.22635-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that the block layer checks if a queue map has any queues inside
it there is no more reason to duplicate the maps for the non-default
types.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fb9d8270f32c..698b350b38cf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -496,11 +496,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		map->nr_queues = dev->io_queues[i];
 		if (!map->nr_queues) {
 			BUG_ON(i == HCTX_TYPE_DEFAULT);
-
-			/* shared set, resuse read set parameters */
-			map->nr_queues = dev->io_queues[HCTX_TYPE_DEFAULT];
-			qoff = 0;
-			offset = queue_irq_offset(dev);
+			continue;
 		}
 
 		/*
-- 
2.19.2

