Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D85BC433DB
	for <linux-block@archiver.kernel.org>; Sat,  9 Jan 2021 04:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B5823A69
	for <linux-block@archiver.kernel.org>; Sat,  9 Jan 2021 04:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbhAIEPy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jan 2021 23:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbhAIEPy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jan 2021 23:15:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A85C061574
        for <linux-block@vger.kernel.org>; Fri,  8 Jan 2021 20:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bMDL66xrafPJWzUH+tkGex9APQxbaqYWSL/B03SVy1I=; b=sBP5gIEcEJn/g92z7mCbPvyiS5
        tRBl6BBB+V63EdTZMkbbYppTul+IHsCYu9rPVYzjy+mFf8EFzucs1pwEWOTWw269s2ka5cSft+mw6
        G006RQbVPAzIlbLMwqsuAVSFzqLc1XSnASb7wl9lAUAoM9l2AdBwae8PSHXSHRtySHCCJOfdYCoLo
        2xWbIDM4qBo2fXdSCUyyl4hVNvJXtmNSx2dvfVADFv116Ey0/3G17bGuLOuL2jZDBY8fobkx1rcEI
        4INs39Hdn+PMOqQVh3sKt4C+gDoPAr3eLYaCuo9XiXqbm5glaD55Z6srUetMDSuvrkoKvrf7kkPL6
        wAPagbKQ==;
Received: from 213-225-33-181.nat.highway.a1.net ([213.225.33.181] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxaBQ-000Kes-EE; Thu, 07 Jan 2021 18:40:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     aik@ozlabs.ru, linux-block@vger.kernel.org, jack@suse.cz
Subject: [PATCH] block: pre-initialize struct block_device in bdev_alloc_inode
Date:   Thu,  7 Jan 2021 19:36:40 +0100
Message-Id: <20210107183640.849336-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bdev_evict_inode and bdev_free_inode are also called for the root inode
of bdevfs, for which bdev_alloc is never called.  Move the zeroing o
f struct block_device and the initialization of the bd_bdi field into
bdev_alloc_inode to make sure they are initialized for the root inode
as well.

Fixes: e6cb53827ed6 ("block: initialize struct block_device in bdev_alloc")
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 3e5b02f6606c42..b79ddda11ee317 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -774,8 +774,11 @@ static struct kmem_cache * bdev_cachep __read_mostly;
 static struct inode *bdev_alloc_inode(struct super_block *sb)
 {
 	struct bdev_inode *ei = kmem_cache_alloc(bdev_cachep, GFP_KERNEL);
+
 	if (!ei)
 		return NULL;
+	memset(&ei->bdev, 0, sizeof(ei->bdev));
+	ei->bdev.bd_bdi = &noop_backing_dev_info;
 	return &ei->vfs_inode;
 }
 
@@ -869,14 +872,12 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	mapping_set_gfp_mask(&inode->i_data, GFP_USER);
 
 	bdev = I_BDEV(inode);
-	memset(bdev, 0, sizeof(*bdev));
 	mutex_init(&bdev->bd_mutex);
 	mutex_init(&bdev->bd_fsfreeze_mutex);
 	spin_lock_init(&bdev->bd_size_lock);
 	bdev->bd_disk = disk;
 	bdev->bd_partno = partno;
 	bdev->bd_inode = inode;
-	bdev->bd_bdi = &noop_backing_dev_info;
 #ifdef CONFIG_SYSFS
 	INIT_LIST_HEAD(&bdev->bd_holder_disks);
 #endif
-- 
2.29.2

