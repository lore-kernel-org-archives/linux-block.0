Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C2CC4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 07:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FEA6101E
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 07:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhHLHfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 03:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhHLHfJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 03:35:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E38C061765
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ipbrx4HDbqOt1/hAquAb0QPm3sQdDVe7cF5HDLwe6YQ=; b=u77bieM7p4W6Lz+rzaLZVT6RY5
        jaRHilVVkgUWcHF0qVimtodBpvh+ZAU8UMe6WalF+86i9ljcEvp11+XI/djH0b++bmpf9ccC+Gk+b
        ZdmDKOBVDGgqP2rMkYkrYT4yG1zD0EnqwG/zxlRCdfDAtS9unmotpQe5Z/6vZ+2q1yP2TFTqMZdPP
        APqS7QyTqr/mjoBaS1jVI+LJazJTbFzz4hEEE7TRGWFULmy9MN4Gj9tU+QIwqlwE1wBc3B8SNGQDL
        sPhomyWrfpMQ1SsAo8y4A+YTKjoIiF+8y0aTIqS6p1RsUjIFC4dznutmP3/cSpMQEa0zp0CjAaUI5
        cKfI6PZQ==;
Received: from [2001:4bb8:184:6215:d7d:1904:40de:694d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mE5Dt-00EI9u-3M; Thu, 12 Aug 2021 07:34:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] block: ensure the bdi is freed after inode_detach_wb
Date:   Thu, 12 Aug 2021 09:33:52 +0200
Message-Id: <20210812073352.18310-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

inode_detach_wb references the "main" bdi of the inode.  With the
recent change to move the bdi from the request_queue to the gendisk
this causes a guaranteed use after free when using certain cgroup
configurations.  The big itself is older through as any non-default
inode reference (e.g. an open file descriptor) could have injected
this use after free even before that.

Fixes: 52ebea749aae ("writeback: make backing_dev_info host cgroup-specific bdi_writebacks")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Qian Cai <quic_qiancai@quicinc.com>
---
 block/genhd.c  | 1 -
 fs/block_dev.c | 5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9e60722e9ce7..3c1ca21ab2ee 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1051,7 +1051,6 @@ static void disk_release(struct device *dev)
 
 	might_sleep();
 
-	bdi_put(disk->bdi);
 	if (MAJOR(dev->devt) == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(MINOR(dev->devt));
 	disk_release_events(disk);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index a2c3d11eda5e..a61273ff1dcf 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -826,11 +826,14 @@ static void init_once(void *data)
 
 static void bdev_evict_inode(struct inode *inode)
 {
+	struct block_device *bdev = I_BDEV(inode);
+
 	truncate_inode_pages_final(&inode->i_data);
 	invalidate_inode_buffers(inode); /* is it needed here? */
 	clear_inode(inode);
-	/* Detach inode from wb early as bdi_put() may free bdi->wb */
 	inode_detach_wb(inode);
+	if (!bdev_is_partition(bdev))
+		bdi_put(bdev->bd_disk->bdi);
 }
 
 static const struct super_operations bdev_sops = {
-- 
2.30.2

