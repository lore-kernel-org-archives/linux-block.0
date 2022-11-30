Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6162BC47089
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 17:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiK3R5I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 12:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiK3R5D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 12:57:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E59F48418
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 09:57:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 10DD01F37C;
        Wed, 30 Nov 2022 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669831020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ya1I8eYntPOk9IKKMe0Ay3HgTFq5reky7CgOCZKf+mU=;
        b=FzMU9nTQf7870rTf7iwHLAcGsk9cNa3ou4dgY5HfHc3v89vfIoBFYfxmSFd/Aq3Ne8eOiV
        9HDr+Cy2Y5efD6CaZFYICKlBkheQMpLfB50lGjVYMxN2zb7idkke1KxWJUoIXzMfrIlHDj
        uEdcGtnT/GblKqAAZT92WcHDZXGJCLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669831020;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ya1I8eYntPOk9IKKMe0Ay3HgTFq5reky7CgOCZKf+mU=;
        b=jRi2kNOJ1EYUtGJwhwXXdoBnU3I5i6KQjKh4dK5e/sLWzf+oypittDKsUr+opr4v1Wz9GH
        kHl3qr2hmH07ogCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E81181331F;
        Wed, 30 Nov 2022 17:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KpCeOGuZh2NbaQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 17:56:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4D770A0710; Wed, 30 Nov 2022 18:56:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] block: Do not reread partition table on exclusively open device
Date:   Wed, 30 Nov 2022 18:56:53 +0100
Message-Id: <20221130175653.24299-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4411; i=jack@suse.cz; h=from:subject; bh=YVvm+uKs5+ejuBxyI1CVvd8oZJC1LBuk0Tgq1jWwINA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjh5lVhCkkV7Z1AFFiharf7D/8mxo6Zm558qyRqfDH RF1N+dSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4eZVQAKCRCcnaoHP2RA2Q2wB/ 9iGpwT4+o0K1GUTvNx+sAfPW9dH6FMUC8ifXAC6pX0afKucwjWxUaiBQ1mu2oYCqwUXWbuuCVDLYid pANfhenJV6Xk73ax3l3qz0Tv93IDY8NyXuZLE76Dg7c8I+uSt+Jp42S33XomwCMLmh2OSp+xSiQbGR GbkhQNg9X+nEOQJtv2Jpygno+2YpCgRysbHHrW84GEfpMTOttmOz8mzZFji444S0zjyNijOv7oV0fg 8va2k741zF/zGMvZldgJJu+J6ZjM1ogLMWkf6MCHPX3gKV7SwxCrph4pWc5/t/0goQKrXaxte7Unab 0HhUms2zzDRtwrd7vNaZiLm7FDxKcf
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 10c70d95c0f2 ("block: remove the bd_openers checks in
blk_drop_partitions") we allow rereading of partition table although
there are users of the block device. This has an undesirable consequence
that e.g. if sda and sdb are assembled to a RAID1 device md0 with
partitions, BLKRRPART ioctl on sda will rescan partition table and
create sda1 device. This partition device under a raid device confuses
some programs (such as libstorage-ng used for initial partitioning for
distribution installation) leading to failures.

Fix the problem refusing to rescan partitions if there is another user
that has the block device exclusively open.

Link: https://lore.kernel.org/all/20221130135344.2ul4cyfstfs3znxg@quack3
Fixes: 10c70d95c0f2 ("block: remove the bd_openers checks in blk_drop_partitions")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk.h   |  2 +-
 block/genhd.c |  7 +++++--
 block/ioctl.c | 12 +++++++-----
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index a186ea20f39d..8b75a95b28d6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -436,7 +436,7 @@ static inline struct kmem_cache *blk_get_queue_kmem_cache(bool srcu)
 }
 struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu);
 
-int disk_scan_partitions(struct gendisk *disk, fmode_t mode);
+int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner);
 
 int disk_alloc_events(struct gendisk *disk);
 void disk_add_events(struct gendisk *disk);
diff --git a/block/genhd.c b/block/genhd.c
index 0f9769db2de8..012529d36f5b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -356,7 +356,7 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action)
 }
 EXPORT_SYMBOL_GPL(disk_uevent);
 
-int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
+int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner)
 {
 	struct block_device *bdev;
 
@@ -366,6 +366,9 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 		return -EINVAL;
 	if (disk->open_partitions)
 		return -EBUSY;
+	/* Someone else has bdev exclusively open? */
+	if (disk->part0->bd_holder != owner)
+		return -EBUSY;
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
 	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);
@@ -500,7 +503,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 
 		bdev_add(disk->part0, ddev->devt);
 		if (get_capacity(disk))
-			disk_scan_partitions(disk, FMODE_READ);
+			disk_scan_partitions(disk, FMODE_READ, NULL);
 
 		/*
 		 * Announce the disk and partitions after all partitions are
diff --git a/block/ioctl.c b/block/ioctl.c
index 60121e89052b..96617512982e 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -467,9 +467,10 @@ static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
  * user space. Note the separate arg/argp parameters that are needed
  * to deal with the compat_ptr() conversion.
  */
-static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
-				unsigned cmd, unsigned long arg, void __user *argp)
+static int blkdev_common_ioctl(struct file *file, fmode_t mode, unsigned cmd,
+			       unsigned long arg, void __user *argp)
 {
+	struct block_device *bdev = I_BDEV(file->f_mapping->host);
 	unsigned int max_sectors;
 
 	switch (cmd) {
@@ -527,7 +528,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 			return -EACCES;
 		if (bdev_is_partition(bdev))
 			return -EINVAL;
-		return disk_scan_partitions(bdev->bd_disk, mode & ~FMODE_EXCL);
+		return disk_scan_partitions(bdev->bd_disk, mode & ~FMODE_EXCL,
+					    file);
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
@@ -605,7 +607,7 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		break;
 	}
 
-	ret = blkdev_common_ioctl(bdev, mode, cmd, arg, argp);
+	ret = blkdev_common_ioctl(file, mode, cmd, arg, argp);
 	if (ret != -ENOIOCTLCMD)
 		return ret;
 
@@ -674,7 +676,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		break;
 	}
 
-	ret = blkdev_common_ioctl(bdev, mode, cmd, arg, argp);
+	ret = blkdev_common_ioctl(file, mode, cmd, arg, argp);
 	if (ret == -ENOIOCTLCMD && disk->fops->compat_ioctl)
 		ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
 
-- 
2.35.3

