Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF64C43614
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 08:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255C420659
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 08:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfANIsS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:48:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:48714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbfANIsS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 03:48:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AA3FAE0E;
        Mon, 14 Jan 2019 08:48:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7BB2F1E1580; Mon, 14 Jan 2019 09:48:15 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Josef Bacik <jbacik@fb.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] blockdev: Fix livelocks on loop device
Date:   Mon, 14 Jan 2019 09:48:10 +0100
Message-Id: <20190114084811.14455-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190114084811.14455-1-jack@suse.cz>
References: <20190114084811.14455-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bd_set_size() updates also block device's block size. This is somewhat
unexpected from its name and at this point, only blkdev_open() uses this
functionality. Furthermore, this can result in changing block size under
a filesystem mounted on a loop device which leads to livelocks inside
__getblk_gfp() like:

Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 10863 Comm: syz-executor0 Not tainted 4.18.0-rc5+ #151
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
01/01/2011
RIP: 0010:__sanitizer_cov_trace_pc+0x3f/0x50 kernel/kcov.c:106
...
Call Trace:
 init_page_buffers+0x3e2/0x530 fs/buffer.c:904
 grow_dev_page fs/buffer.c:947 [inline]
 grow_buffers fs/buffer.c:1009 [inline]
 __getblk_slow fs/buffer.c:1036 [inline]
 __getblk_gfp+0x906/0xb10 fs/buffer.c:1313
 __bread_gfp+0x2d/0x310 fs/buffer.c:1347
 sb_bread include/linux/buffer_head.h:307 [inline]
 fat12_ent_bread+0x14e/0x3d0 fs/fat/fatent.c:75
 fat_ent_read_block fs/fat/fatent.c:441 [inline]
 fat_alloc_clusters+0x8ce/0x16e0 fs/fat/fatent.c:489
 fat_add_cluster+0x7a/0x150 fs/fat/inode.c:101
 __fat_get_block fs/fat/inode.c:148 [inline]
...

Trivial reproducer for the problem looks like:

truncate -s 1G /tmp/image
losetup /dev/loop0 /tmp/image
mkfs.ext4 -b 1024 /dev/loop0
mount -t ext4 /dev/loop0 /mnt
losetup -c /dev/loop0
l /mnt

Fix the problem by moving initialization of a block device block size
into a separate function and call it when needed.

Thanks to Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> for help with
debugging the problem.

Reported-by: syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index c546cdce77e6..58a4c1217fa8 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -104,6 +104,20 @@ void invalidate_bdev(struct block_device *bdev)
 }
 EXPORT_SYMBOL(invalidate_bdev);
 
+static void set_init_blocksize(struct block_device *bdev)
+{
+	unsigned bsize = bdev_logical_block_size(bdev);
+	loff_t size = i_size_read(bdev->bd_inode);
+
+	while (bsize < PAGE_SIZE) {
+		if (size & bsize)
+			break;
+		bsize <<= 1;
+	}
+	bdev->bd_block_size = bsize;
+	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+}
+
 int set_blocksize(struct block_device *bdev, int size)
 {
 	/* Size must be a power of two, and between 512 and PAGE_SIZE */
@@ -1431,18 +1445,9 @@ EXPORT_SYMBOL(check_disk_change);
 
 void bd_set_size(struct block_device *bdev, loff_t size)
 {
-	unsigned bsize = bdev_logical_block_size(bdev);
-
 	inode_lock(bdev->bd_inode);
 	i_size_write(bdev->bd_inode, size);
 	inode_unlock(bdev->bd_inode);
-	while (bsize < PAGE_SIZE) {
-		if (size & bsize)
-			break;
-		bsize <<= 1;
-	}
-	bdev->bd_block_size = bsize;
-	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
 }
 EXPORT_SYMBOL(bd_set_size);
 
@@ -1519,8 +1524,10 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 				}
 			}
 
-			if (!ret)
+			if (!ret) {
 				bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
+				set_init_blocksize(bdev);
+			}
 
 			/*
 			 * If the device is invalidated, rescan partition
@@ -1555,6 +1562,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 				goto out_clear;
 			}
 			bd_set_size(bdev, (loff_t)bdev->bd_part->nr_sects << 9);
+			set_init_blocksize(bdev);
 		}
 
 		if (bdev->bd_bdi == &noop_backing_dev_info)
-- 
2.16.4

