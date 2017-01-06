Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:64337 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdAFBcs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Jan 2017 20:32:48 -0500
Subject: [PATCH] block: fix blk_get_backing_dev_info() crash,
 use bdev->bd_queue
From: Dan Williams <dan.j.williams@intel.com>
To: axboe@fb.com
Cc: Andi Kleen <ak@linux.intel.com>, Jan Kara <jack@suse.cz>,
        Rabin Vincent <rabinv@axis.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, Wei Fang <fangwei1@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Date: Thu, 05 Jan 2017 17:17:55 -0800
Message-ID: <148366547505.38941.646379357860772670.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The ->bd_queue member of struct block_device was added in commit
87192a2a49c4 ("vfs: cache request_queue in struct block_device") in
v3.3. However, blk_get_backing_dev_info() has been using
bdev_get_queue() and grabbing the request_queue through the gendisk
since before the git era.

At final __blkdev_put() time ->bd_disk is cleared while ->bd_queue is
not. The queue remains valid until the final put of the parent disk.

The following crash signature results from blk_get_backing_dev_info()
trying to lookup the queue through ->bd_disk after the final put of the
block device. Simply switch bdev_get_queue() to use ->bd_queue directly
which is guaranteed to still be valid at invalidate_partition() time.

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000568
 IP: blk_get_backing_dev_info+0x10/0x20
 [..]
 Call Trace:
  __inode_attach_wb+0x3a7/0x5d0
  __filemap_fdatawrite_range+0xf8/0x100
  filemap_write_and_wait+0x40/0x90
  fsync_bdev+0x54/0x60
  ? bdget_disk+0x30/0x40
  invalidate_partition+0x24/0x50
  del_gendisk+0xfa/0x230

Cc: <stable@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@fb.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Wei Fang <fangwei1@huawei.com>
Cc: Rabin Vincent <rabinv@axis.com>
Cc: Andi Kleen <ak@linux.intel.com>
Fixes: 87192a2a49c4 ("vfs: cache request_queue in struct block_device")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 block/blk-core.c       |    4 ++--
 include/linux/blkdev.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 61ba08c58b64..04737548e1e1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -109,8 +109,8 @@ void blk_queue_congestion_threshold(struct request_queue *q)
  * @bdev:	device
  *
  * Locates the passed device's request queue and returns the address of its
- * backing_dev_info.  This function can only be called if @bdev is opened
- * and the return value is never NULL.
+ * backing_dev_info.  This function can only be called while there is an
+ * active reference against the parent gendisk.
  */
 struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 83695641bd5e..27779709f821 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -962,7 +962,7 @@ bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {
-	return bdev->bd_disk->queue;	/* this is never NULL */
+	return bdev->bd_queue;	/* this is never NULL */
 }
 
 /*

