Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE67C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C29208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dcOjCytx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C29208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbeKOCGm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42174 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387548AbeKOCGm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Mvc7d994EYq//vTG97jyHl4+GUCsmlaNedyzuuqdPkc=; b=dcOjCytxxZm2T5dqmW7I/SDJqe
        KH1bJJcC9aEOXIbPrz8iRzzCrLN32PzGdfQnnUT2yKcQpq52MFisAJ7cy7ZRQ2gQHBOO2Z68GQcOl
        ZIqsjgpP/kopJbobCwT19ClnxdsxAwOPOvcP3CRlLDyDEY6MQJaXGWLq+3fxWXH064DYOI0R2Uwg/
        vBUW9E9DlrxyMnOyqUrkdZyw8ofn8G6hgov2DfzdI72DpNDBh0PkPUsWi8SrWG93998rDjIbrulmG
        dZhum7tPtes9lAJnMjf2IDdRxAPfYS3c4soJRXsmUv5w4uYlGE1ZqqGFi9lCnYhhrfKNqAg04vS78
        gWUVKtcA==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxcy-0006FK-16; Wed, 14 Nov 2018 16:02:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 11/16] drbd: don't override the queue_lock
Date:   Wed, 14 Nov 2018 17:02:14 +0100
Message-Id: <20181114160219.28328-12-hch@lst.de>
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

The DRBD req_lock and block layer queue_lock are used for entirely
different resources.  Stop using the req_lock as the block layer
queue_lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index fa8204214ac0..b66c59ce6260 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2792,7 +2792,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	drbd_init_set_defaults(device);
 
-	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, &resource->req_lock);
+	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
 	if (!q)
 		goto out_no_q;
 	device->rq_queue = q;
-- 
2.19.1

