Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B794EB64D0
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 15:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbjFMPnU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 11:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbjFMPnU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 11:43:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531CCD1
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wKb1k35Kc8tGymeul9a4tTfJkCMeFZNxGqzd6oBhb5o=; b=zkKAvBD2C9KSow+vQ1xaJDCGjD
        QfLWr9YXnx7nZdTSSa8BHja1ZV9CDeAzQJQAIJcK9ZHyfplk4vHtS2+vSRayScvR9OvqUnqHJHCUj
        1G469W/3cQcDvcZ901X2/E1KVQWpXSWzEF+66kfU8qQvWs16W15vTVWdn9Xa5Rb5AWJSOZ7NXhDHl
        b+sJF3HMI8crAi0gRQmdQmhllrJXIeOEw2QlzGrnP2m1Ea5JtxV2FWjF21LmF9u23AgmuAQ3Cr15R
        WWNXBaKXl4IcRF/sR2FmVz5DMUV9YhZPUL6sAGpLV7fGxfLrigiuQrhMy5tkQNcOnfdK2eywKUowU
        Yfsuc46Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q96Aw-008VOh-2D;
        Tue, 13 Jun 2023 15:43:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] swim3: fix the floppy_locked_ioctl prototype
Date:   Tue, 13 Jun 2023 17:43:09 +0200
Message-Id: <20230613154309.327557-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add back the accidentally dropped mode parameter.

Fixes: b60f7635788a ("swim3: fix the floppy_locked_ioctl prototype")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/swim3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 945a0315425070..dc43a63b346946 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -882,7 +882,7 @@ static int fd_eject(struct floppy_state *fs)
 static struct floppy_struct floppy_type =
 	{ 2880,18,2,80,0,0x1B,0x00,0xCF,0x6C,NULL };	/*  7 1.44MB 3.5"   */
 
-static int floppy_locked_ioctl(struct block_device *bdev,
+static int floppy_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 			unsigned int cmd, unsigned long param)
 {
 	struct floppy_state *fs = bdev->bd_disk->private_data;
-- 
2.39.2

