Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D754C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B889208A3
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hE2Bwoud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B889208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeKPSVe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:21:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPSVe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jGBoo/fCNltlxiTvLvFZG4zIVSdMCcAKdKwQ0fXsw7o=; b=hE2Bwoudi4doWtvLQx68Q4KXMe
        L+cl2gPO8bHvUaOOafrgPGfwv8EOXCEb9YDJbZA3et9KH+wR63vlTLi4xncUMkuf6A3ej9cCpPO9h
        IDg1e5bwI7MGIhNTJpxK0u30+SepEJba0FI2UeFLMNwgru5LDB7FfXlzkRr/h7p0zvGRNYM4ywhYP
        rQuejsJrpi7xvpvnGbbMNp6bP564s3vlG4VqlpoUrWUuTxGsc+TjHnsRJoxRQncPPEEX/yMdwVjwo
        /eTFrFtf+PKskZW0xlP589TUfACNIkCwARDqDjo/QDgVT82wJzdbLNgyr+ciqnoO/g4e3SD6GolKP
        jc+do3bQ==;
Received: from 089144201193.atnat0010.highway.a1.net ([89.144.201.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZCi-0002ch-Iq; Fri, 16 Nov 2018 08:10:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 3/6] pktcdvd: remove queue_lock around blk_queue_max_hw_sectors
Date:   Fri, 16 Nov 2018 09:10:03 +0100
Message-Id: <20181116081006.5083-4-hch@lst.de>
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

blk_queue_max_hw_sectors can't do anything with queue_lock protection
so don't hold it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/pktcdvd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 4adf4c8861cd..f5a71023f76c 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2203,9 +2203,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 		 * Some CDRW drives can not handle writes larger than one packet,
 		 * even if the size is a multiple of the packet size.
 		 */
-		spin_lock_irq(&q->queue_lock);
 		blk_queue_max_hw_sectors(q, pd->settings.size);
-		spin_unlock_irq(&q->queue_lock);
 		set_bit(PACKET_WRITABLE, &pd->flags);
 	} else {
 		pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
-- 
2.19.1

