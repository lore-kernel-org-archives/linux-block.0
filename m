Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EDEC636C9
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 09:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D990961165
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 09:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbhGSIzo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbhGSIzo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 04:55:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68027C061762
        for <linux-block@vger.kernel.org>; Mon, 19 Jul 2021 01:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ks5/wMnDCoFoa43UnN3GcKOXhbTy63tpYAP0poxKKqY=; b=Ia9T9yWrVwLNFf49cvTNjYHrtA
        jay8Wjo9MwvxACofM4f91q6WQvwBd2AWBgH2H7i6onGsnKVmgnn3sVhcNB9XY8WiIu8TvvKCexD2W
        e5J8JgXrOpWyiwKupxy/a7pliOXX7zEcn6ZnypYN0dxIFlXBRufqTql6wqN9kseaTfI/tdXfYZY6L
        gn3K6K5aYcrE5mXCi0VSHEHUityaDobuL+nTbx5p9h6XCNOWrAn3oaySH5bua8G17L+TrAXIfaPTT
        NutU2PoaTl2OVkthC2eXue8mDqzwDEk6hJHFiTGHzvTvLS+I/XqOwRd/4gG75nnMM6E1SrzcPKyux
        T+tYSvXg==;
Received: from [2001:4bb8:193:7660:d2a4:8d57:2e55:21d0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5Pgf-006i6p-Ko; Mon, 19 Jul 2021 09:35:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: delay freeing the gendisk
Date:   Mon, 19 Jul 2021 11:35:44 +0200
Message-Id: <20210719093544.431845-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkdev_get_no_open acquires a reference to the block_device through
the block device inode and then tries to acquire a device model
reference to the gendisk.  But at this point the disk migh already
be freed (although the race is free).  Fix this by only freeing the
gendisk from the whole device bdevs ->free_inode callback as well.

Fixes: 22ae8ce8b892 ("block: simplify bdev/disk lookup in blkdev_get")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c  | 3 +--
 fs/block_dev.c | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index af4d2ab4a633..e6d782714ad3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1079,10 +1079,9 @@ static void disk_release(struct device *dev)
 	disk_release_events(disk);
 	kfree(disk->random);
 	xa_destroy(&disk->part_tbl);
-	bdput(disk->part0);
 	if (test_bit(GD_QUEUE_REF, &disk->state) && disk->queue)
 		blk_put_queue(disk->queue);
-	kfree(disk);
+	bdput(disk->part0);
 }
 struct class block_class = {
 	.name		= "block",
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0c424a0cadaa..1d81f9440404 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -812,6 +812,8 @@ static void bdev_free_inode(struct inode *inode)
 	free_percpu(bdev->bd_stats);
 	kfree(bdev->bd_meta_info);
 
+	if (!bdev_is_partition(bdev))
+		kfree(disk);
 	kmem_cache_free(bdev_cachep, BDEV_I(inode));
 }
 
-- 
2.30.2

