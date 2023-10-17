Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75E9CDB483
	for <linux-block@archiver.kernel.org>; Tue, 17 Oct 2023 18:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJQSsi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 14:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjJQSsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 14:48:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82F9F;
        Tue, 17 Oct 2023 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oX4lK1dfp58L5xH7/9zRG/fX7LPq226bYG22aZQTTco=; b=Y3eX7LW/yg1a5UHuEm5j8dX+1w
        54lZBmXwcmu/0mYRF8xdAiRRwmARSOJB4jRUtGOdm9OihJjKmd5LDb1NMi61YNiXV4PYIgYKVhh5Y
        S1UZ1fSzAcMUXqIXt+SSl2MU6D1D1btmeHRXymrQUcTH7Frp1BW8IWU73iAQjfxHlSrtnJKYXc1t8
        PolLzlyWrWt7BcQ12xHEseKTc+5ZbfSJW5exXvtETxsvVAc9mLliBfMNysy27jj6CCfK18onsuVdG
        aTEpBVzUN2P7PA7QpE/2ACPgvHbANLRny5Zc1+sis4zOYSd4pN13erV7qGrO3d+PLVw0vWse/zYjU
        D9R6UvHg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsp7J-00D0Ku-1I;
        Tue, 17 Oct 2023 18:48:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] block: WARN_ON_ONCE() when we remove active partitions
Date:   Tue, 17 Oct 2023 20:48:20 +0200
Message-Id: <20231017184823.1383356-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017184823.1383356-1-hch@lst.de>
References: <20231017184823.1383356-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

The logic for disk->open_partitions is:

blkdev_get_by_*()
-> bdev_is_partition()
   -> blkdev_get_part()
      -> blkdev_get_whole() // bdev_whole->bd_openers++
      -> if (part->bd_openers == 0)
                 disk->open_partitions++
         part->bd_openers

In other words, when we first claim/open a partition we increment
disk->open_partitions and only when all part->bd_openers are closed will
disk->open_partitions be zero. That should mean that
disk->open_partitions is always > 0 as long as there's anyone that
has an open partition.

So the check for disk->open_partitions should meand that we can never
remove an active partition that has a holder and holder ops set. Assert
that in the code. The main disk isn't removed so that check doesn't work
for disk->part0 which is what we want. After all we only care about
partition not about the main disk.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/partitions/core.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index b0585536b407a5..f47ffcfdfcec22 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -274,17 +274,6 @@ void drop_partition(struct block_device *part)
 	put_device(&part->bd_device);
 }
 
-static void delete_partition(struct block_device *part)
-{
-	/*
-	 * Remove the block device from the inode hash, so that it cannot be
-	 * looked up any more even when openers still hold references.
-	 */
-	remove_inode_hash(part->bd_inode);
-	bdev_mark_dead(part, false);
-	drop_partition(part);
-}
-
 static ssize_t whole_disk_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -674,8 +663,23 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 	sync_blockdev(disk->part0);
 	invalidate_bdev(disk->part0);
 
-	xa_for_each_start(&disk->part_tbl, idx, part, 1)
-		delete_partition(part);
+	xa_for_each_start(&disk->part_tbl, idx, part, 1) {
+		/*
+		 * Remove the block device from the inode hash, so that
+		 * it cannot be looked up any more even when openers
+		 * still hold references.
+		 */
+		remove_inode_hash(part->bd_inode);
+
+		/*
+		 * If @disk->open_partitions isn't elevated but there's
+		 * still an active holder of that block device things
+		 * are broken.
+		 */
+		WARN_ON_ONCE(atomic_read(&part->bd_openers));
+		invalidate_bdev(part);
+		drop_partition(part);
+	}
 	clear_bit(GD_NEED_PART_SCAN, &disk->state);
 
 	/*
-- 
2.39.2

