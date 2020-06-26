Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1663C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 08:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFC02080C
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 08:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SQz2Doyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgFZIC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgFZICZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 04:02:25 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5416C08C5DC;
        Fri, 26 Jun 2020 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=skgjZNjZFXWr2WMevdTakzxqSkNOHAzF+vYdGSjzejg=; b=SQz2DoyzuT2Kt4EqYRMmazNc+B
        J93iFKFd/X7PfsiqeHP4etAWOHn1Kf+S6YYZXsJI/SeIm0YtheB12U+k6ZF862mKLRO90jdwjD9qt
        sXpr5BG1hP1YCHfB4QPp9cpTUDUTI4ARBNYIRTq7ft/ckQC8ordsuawOuA8Y98BkPl2Vto0bsXu05
        /EMBcWWLrDvFnlunJgg8g05aqllM0lcbCEXc9HfKcPuziu3bwiSsdT6HWaZl/U2Xe78fkruK/pBKF
        5GR/EQjhG18UhBmgVnnR5myqnuzCVAOTgrTXBxcw9jk9li2zi8UjWUnV8EC0A7CiYO1lX92Sy2st+
        A0dFtkJA==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojJH-0007Uk-9E; Fri, 26 Jun 2020 08:02:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] block: remove the all_bdevs list
Date:   Fri, 26 Jun 2020 10:01:58 +0200
Message-Id: <20200626080158.1998621-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626080158.1998621-1-hch@lst.de>
References: <20200626080158.1998621-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead just iterate over the inodes for the block device superblock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c            | 22 +++++++---------------
 include/linux/blk_types.h |  1 -
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 68cb08bc1b7a65..2d2fcb50e78eac 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -773,7 +773,6 @@ static void init_once(void *foo)
 
 	memset(bdev, 0, sizeof(*bdev));
 	mutex_init(&bdev->bd_mutex);
-	INIT_LIST_HEAD(&bdev->bd_list);
 #ifdef CONFIG_SYSFS
 	INIT_LIST_HEAD(&bdev->bd_holder_disks);
 #endif
@@ -789,9 +788,6 @@ static void bdev_evict_inode(struct inode *inode)
 	truncate_inode_pages_final(&inode->i_data);
 	invalidate_inode_buffers(inode); /* is it needed here? */
 	clear_inode(inode);
-	spin_lock(&bdev_lock);
-	list_del_init(&bdev->bd_list);
-	spin_unlock(&bdev_lock);
 	/* Detach inode from wb early as bdi_put() may free bdi->wb */
 	inode_detach_wb(inode);
 	if (bdev->bd_bdi != &noop_backing_dev_info) {
@@ -866,8 +862,6 @@ static int bdev_set(struct inode *inode, void *data)
 	return 0;
 }
 
-static LIST_HEAD(all_bdevs);
-
 struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
@@ -892,9 +886,6 @@ struct block_device *bdget(dev_t dev)
 		inode->i_bdev = bdev;
 		inode->i_data.a_ops = &def_blk_aops;
 		mapping_set_gfp_mask(&inode->i_data, GFP_USER);
-		spin_lock(&bdev_lock);
-		list_add(&bdev->bd_list, &all_bdevs);
-		spin_unlock(&bdev_lock);
 		unlock_new_inode(inode);
 	}
 	return bdev;
@@ -915,13 +906,14 @@ EXPORT_SYMBOL(bdgrab);
 
 long nr_blockdev_pages(void)
 {
-	struct block_device *bdev;
+	struct inode *inode;
 	long ret = 0;
-	spin_lock(&bdev_lock);
-	list_for_each_entry(bdev, &all_bdevs, bd_list) {
-		ret += bdev->bd_inode->i_mapping->nrpages;
-	}
-	spin_unlock(&bdev_lock);
+
+	spin_lock(&blockdev_superblock->s_inode_list_lock);
+	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list)
+		ret += inode->i_mapping->nrpages;
+	spin_unlock(&blockdev_superblock->s_inode_list_lock);
+
 	return ret;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index b5f7105806e492..07facaf62b727d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -40,7 +40,6 @@ struct block_device {
 	int			bd_invalidated;
 	struct gendisk *	bd_disk;
 	struct backing_dev_info *bd_bdi;
-	struct list_head	bd_list;
 
 	/* The counter of freeze processes */
 	int			bd_fsfreeze_count;
-- 
2.26.2

