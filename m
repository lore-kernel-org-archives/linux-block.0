Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBEAC4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 12:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BC363261
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 12:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhHPM3Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 08:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhHPM3P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 08:29:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A022C061764
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 05:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Fbbz0WyXXP8x18GZUbK+HEd27UCc0KX1RoE3YEIEcbA=; b=X0pVAIhIeudsSfKnxcYKHfm+uJ
        ldnC4ugwJF4PjiIViwoL/K7r10YTuJ8TkGjk9s0q5uH4lFDZsburlZppmL+vdqDv61+bNfYjgtKso
        68aPnBAmoBZAMBYNwqGbaI3eK+jnLCp5egS5aB97QCpnhNoma12ueQUCgXrR/QWHdxQubtg2prRSh
        uPd9wIiETuy54DaPA2Q1yKHmyYra+k5w1lgGHNjwFu4Ei9vPlamz5P5Y2/TjHXbaFUxXoBjF1VLnu
        nU5RQHNQSWmM6XL2f7hopjy+c1LR7aNJinZNGZzHfkAxytaSC5xnudWFnI8Tvix1o3jRsMcW2XXOK
        lp8nJ9OA==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFbiF-001L8R-0U; Mon, 16 Aug 2021 12:27:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: free the extended dev_t minor later
Date:   Mon, 16 Aug 2021 14:26:13 +0200
Message-Id: <20210816122614.601358-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210816122614.601358-1-hch@lst.de>
References: <20210816122614.601358-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The dev_t is used as the inode hash, so we should only released it
once then block device inode is gone from the inode cache.  Move it
to bdev_free_inode to ensure that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           | 2 --
 block/partitions/core.c | 2 --
 fs/block_dev.c          | 5 +++++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9d6b3aeea288..ed58ddf6258b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1085,8 +1085,6 @@ static void disk_release(struct device *dev)
 	might_sleep();
 
 	bdi_put(disk->bdi);
-	if (MAJOR(dev->devt) == BLOCK_EXT_MAJOR)
-		blk_free_ext_minor(MINOR(dev->devt));
 	disk_release_events(disk);
 	kfree(disk->random);
 	xa_destroy(&disk->part_tbl);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 9265936df77e..58c4c362c94f 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -259,8 +259,6 @@ static const struct attribute_group *part_attr_groups[] = {
 
 static void part_release(struct device *dev)
 {
-	if (MAJOR(dev->devt) == BLOCK_EXT_MAJOR)
-		blk_free_ext_minor(MINOR(dev->devt));
 	put_disk(dev_to_bdev(dev)->bd_disk);
 	iput(dev_to_bdev(dev)->bd_inode);
 }
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 38a8b0e04a0c..4bd2a632c79c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -35,6 +35,7 @@
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
 #include "internal.h"
+#include "../block/blk.h"
 
 struct bdev_inode {
 	struct block_device bdev;
@@ -813,6 +814,10 @@ static void bdev_free_inode(struct inode *inode)
 
 	if (!bdev_is_partition(bdev))
 		kfree(bdev->bd_disk);
+
+	if (MAJOR(bdev->bd_dev) == BLOCK_EXT_MAJOR)
+		blk_free_ext_minor(MINOR(bdev->bd_dev));
+
 	kmem_cache_free(bdev_cachep, BDEV_I(inode));
 }
 
-- 
2.30.2

