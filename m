Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8DAC433E0
	for <linux-block@archiver.kernel.org>; Sat,  9 Jan 2021 11:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2EF12137B
	for <linux-block@archiver.kernel.org>; Sat,  9 Jan 2021 11:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbhAILOg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Jan 2021 06:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbhAILOf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Jan 2021 06:14:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62413C061786
        for <linux-block@vger.kernel.org>; Sat,  9 Jan 2021 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TizawMQlpyDy+c7WQQFbGwAX4oVptaFEIhlSwddxiT4=; b=IVLA8TqPt6YoDIqeXzaLFREVq5
        VPYcB3vrVVq3MvAuZY+tYyNA642HA7mgcVhvlb0ZVKeeBbV6jjucDH0nWvjkTvHeVNtUqbw6NUV5O
        Z6bYUrsXun0dZBDuvtnYvRa/Hp8rfiNQlajyA2fc+c1SkVMR5P/zHywqTMjXeb8eiYni8jmD/qvST
        DIIvRJSOgiAZ8yB01i04T2qa2B134gnbBlVLdLuAg38smj/XSRx/f3AKNEbXUoiN1PTYhjRibigZJ
        2lkiv8BWV73xOiNx9cPTQU/zdC6JbRpsyNLJiHkMYqy9OPVgpeUEfJFIY2nRbeRcc+5ELCJJyeF3h
        1ma+fW4g==;
Received: from [2001:4bb8:19b:e528:4197:a20:99de:e7b0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kyCBZ-000UeN-1J; Sat, 09 Jan 2021 11:13:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: unexport truncate_bdev_range
Date:   Sat,  9 Jan 2021 12:13:32 +0100
Message-Id: <20210109111332.1132424-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

truncate_bdev_range is only used in always built-in block layer code,
so remove the export and the !CONFIG_BLOCK stub.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c         | 1 -
 include/linux/blkdev.h | 9 ++-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 3e5b02f6606c42..41a9b0cb2d8a16 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -126,7 +126,6 @@ int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
 		bd_abort_claiming(bdev, truncate_bdev_range);
 	return 0;
 }
-EXPORT_SYMBOL(truncate_bdev_range);
 
 static void set_init_blocksize(struct block_device *bdev)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e015e..22fc4f3141d555 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2012,21 +2012,16 @@ void bdev_add(struct block_device *bdev, dev_t dev);
 struct block_device *I_BDEV(struct inode *inode);
 struct block_device *bdgrab(struct block_device *bdev);
 void bdput(struct block_device *);
+int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
+		loff_t lend);
 
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
-int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
-			loff_t lend);
 int sync_blockdev(struct block_device *bdev);
 #else
 static inline void invalidate_bdev(struct block_device *bdev)
 {
 }
-static inline int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
-				      loff_t lstart, loff_t lend)
-{
-	return 0;
-}
 static inline int sync_blockdev(struct block_device *bdev)
 {
 	return 0;
-- 
2.29.2

