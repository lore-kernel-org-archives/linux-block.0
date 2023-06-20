Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65579EB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 04:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjFTEfl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 00:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFTEfk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 00:35:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AF710C7
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2023 21:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=TUJJhlESLSnfcffLczsdfZkDsYdPlyHUArNd5zvuHIY=; b=JBQx0Yd5WJ3dxM+80NZPr0HUpw
        Zt2OFt37FYvRFj60PARFupP9rw5yA6RIRvOE47P6UtaCUYsY5HnnyysCGIpB8A9KFcxW0OVylJzS0
        L6wJ7tlZ4x6Bsubc5+2k4atW/LVMuLXrJS9HEykEWsw4M1ZISmGq4OlQAECRDDp1iwvy/MnPww6Ww
        19EVs4rNqrQt0B+sRCIJaryd4X1FyvDXNzemqFVOlUOyTp6BNmEkYn00WMtm6Xj17qcaCF65ChasN
        GjUGucF5KYIxL+m0sgKnLGPpdSjcnVrZi1F9GAw6mQPJR2wf4jGxymO5eJYCaI4xF8NwgT7dYWWRb
        D2rtStGQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBT5e-00A8Av-13;
        Tue, 20 Jun 2023 04:35:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] block: document the holder argument to blkdev_get_by_path
Date:   Tue, 20 Jun 2023 06:35:36 +0200
Message-Id: <20230620043536.707249-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bdev.c b/block/bdev.c
index bd558a9ba3cd97..9bb54d9d02a687 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -850,6 +850,7 @@ EXPORT_SYMBOL(blkdev_get_by_dev);
  * @path: path to the block device to open
  * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
+ * @hops: holder operations
  *
  * Open the block device described by the device file at @path.  If @holder is
  * not %NULL, the block device is opened with exclusive access.  Exclusive opens
-- 
2.39.2

