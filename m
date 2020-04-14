Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C469C352BE
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B43C206E9
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JR5Z7k7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406601AbgDNH3i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:29:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390797AbgDNH3g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 03:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=h6L8qe8CLhfRfBQB93wPXOSvNk4Jso8JkIvEH7OeOJs=; b=JR5Z7k7BDo/0cXHAGhEDbGKqc/
        IhQovb976xAy+Eqhz7DO4wKv41nZeZOAbeXWtyCdJhlGs1MS+d+1fn9S+db5BUNvch9DDjSzjSG7n
        I3P1iLKQfcIN5LoU4SI2DqaEz2ip87oUjdi+JsCIx7wNaOGObaaaeapo6ej6rCXCiLcS8pxMKcxwj
        fEtTKzKVKQVuNzLGcK7ud/+3zNiBwIzr/ZF3oAZ3Uc0gCN4h0A+l35OXUcq9KBIgiBdBRztxzTrS0
        1dJVQW6I3NEKzFeuP8HS33g8mdZehvmf4yPvCSpU/2LId7TFg0N3iosG3OnvwcQk/e1QMsfBqX7Rr
        R1rkIQ2g==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOG0l-0005cK-4C; Tue, 14 Apr 2020 07:29:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 10/10] block: fold bdev_unhash_inode into invalidate_partition
Date:   Tue, 14 Apr 2020 09:29:02 +0200
Message-Id: <20200414072902.324936-11-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
References: <20200414072902.324936-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

invalidate_partition and bdev_unhash_inode are always paired, and
invalidate_partition already does an icache lookup for the block device
inode.  Piggy back on that to remove the inode from the hash.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/genhd.c      |  8 ++++++--
 fs/block_dev.c     | 15 ---------------
 include/linux/fs.h |  1 -
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 980a4609d4a5..c05d509877fa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -888,6 +888,12 @@ static void invalidate_partition(struct gendisk *disk, int partno)
 
 	fsync_bdev(bdev);
 	__invalidate_device(bdev, true);
+
+	/*
+	 * Unhash the bdev inode for this device so that it gets evicted as soon
+	 * as last inode reference is dropped.
+	 */
+	remove_inode_hash(bdev->bd_inode);
 	bdput(bdev);
 }
 
@@ -909,13 +915,11 @@ void del_gendisk(struct gendisk *disk)
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
 	while ((part = disk_part_iter_next(&piter))) {
 		invalidate_partition(disk, part->partno);
-		bdev_unhash_inode(part_devt(part));
 		delete_partition(disk, part);
 	}
 	disk_part_iter_exit(&piter);
 
 	invalidate_partition(disk, 0);
-	bdev_unhash_inode(disk_devt(disk));
 	set_capacity(disk, 0);
 	disk->flags &= ~GENHD_FL_UP;
 	up_write(&disk->lookup_sem);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9c8de54fa0c9..998820174d3e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -883,21 +883,6 @@ static int bdev_set(struct inode *inode, void *data)
 
 static LIST_HEAD(all_bdevs);
 
-/*
- * If there is a bdev inode for this device, unhash it so that it gets evicted
- * as soon as last inode reference is dropped.
- */
-void bdev_unhash_inode(dev_t dev)
-{
-	struct inode *inode;
-
-	inode = ilookup5(blockdev_superblock, hash(dev), bdev_test, &dev);
-	if (inode) {
-		remove_inode_hash(inode);
-		iput(inode);
-	}
-}
-
 struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2b4e9f86b151..1a95e5158811 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2581,7 +2581,6 @@ extern struct kmem_cache *names_cachep;
 #ifdef CONFIG_BLOCK
 extern int register_blkdev(unsigned int, const char *);
 extern void unregister_blkdev(unsigned int, const char *);
-extern void bdev_unhash_inode(dev_t dev);
 extern struct block_device *bdget(dev_t);
 extern struct block_device *bdgrab(struct block_device *bdev);
 extern void bd_set_size(struct block_device *, loff_t size);
-- 
2.25.1

