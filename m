Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6B8C2D0A3
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 17:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A11216C4
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 17:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pu4M0Lfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbgKIRbC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731467AbgKIRbB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 12:31:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69AFC0613CF
        for <linux-block@vger.kernel.org>; Mon,  9 Nov 2020 09:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QXTsp1tlKAI6ByHHFT44pQ9qFbymesTDA4cZ1owCOag=; b=Pu4M0Lfg7btzDIdiEBLzZHHgG5
        0bEcun9hWz6zQS0rddvf3V42lTnfO6XKX6SRMmscdkzPrdBLe3TJP4eTxC+7XoIq/x8WbJ4ewrFJy
        WG/+2+55/vKoa6xTttYBNA+VkBFq5A/R2lQ9ac7KlaD94c/noLBykOnXF02SOoDj8P+BJVeIdg5Ft
        pWvKnV1oQ2aJ/Bn0CGw3/f+skAv8FODPd3BVTs254IKR0qv9q6J6EvKgXzHjw42VZMPnu5H4YGW1w
        lAmLajOIq7fhjpxAL9KJknc4piaLgu2M5COXtXUxyi1ZHxeeth1sj1EmzO6JVL3rudCxQE9FJLxUN
        gTR2OmlQ==;
Received: from [2001:4bb8:180:6600:e0a4:2604:c520:8624] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcB0N-00056p-Og; Mon, 09 Nov 2020 17:31:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH] nbd: fix a block_device refcount leak in nbd_release
Date:   Mon,  9 Nov 2020 18:30:59 +0100
Message-Id: <20201109173059.2500429-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bdget_disk needs to be paired with bdput to not leak a reference
on the block device inode.

Fixes: 08ba91ee6e2c ("nbd: Add the nbd NBD_DISCONNECT_ON_CLOSE config flag.")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a6f51934391edb..45b0423ef2c53d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1493,6 +1493,7 @@ static void nbd_release(struct gendisk *disk, fmode_t mode)
 	if (test_bit(NBD_RT_DISCONNECT_ON_CLOSE, &nbd->config->runtime_flags) &&
 			bdev->bd_openers == 0)
 		nbd_disconnect_and_put(nbd);
+	bdput(bdev);
 
 	nbd_config_put(nbd);
 	nbd_put(nbd);
-- 
2.28.0

