Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36446 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdDFIU4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 04:20:56 -0400
Received: by mail-pg0-f45.google.com with SMTP id g2so28979423pge.3
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2017 01:20:56 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <minlei@redhat.com>, kernel-team@fb.com
Subject: [RFC PATCH] loop: set queue logical block size
Date: Thu,  6 Apr 2017 01:19:45 -0700
Message-Id: <07d6b9266284b98aa3a4706062bd135275220d38.1491466688.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The request queue created when we create a loop device has the default
logical block size of 512. When we associate the device with an fd, we
set the block size on the block_device but don't update the logical
block size of the request_queue. This makes it impossibe to use direct
I/O with a backing file on a device with a block size >512, as the
following check in __loop_update_dio() fails:

	sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev);
	if (queue_logical_block_size(lo->lo_queue) >= sb_bsize &&
	    ...

Fix it by updating the logical block size when we set the fd.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cc981f34e017..1bb22903ad1a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -941,6 +941,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	/* let user-space know about the new size */
 	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
 
+	blk_queue_logical_block_size(lo->lo_queue, lo_blocksize);
 	set_blocksize(bdev, lo_blocksize);
 
 	lo->lo_state = Lo_bound;
-- 
2.12.2
