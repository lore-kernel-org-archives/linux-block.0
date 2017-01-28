Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:57126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdA1Jcq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2017 04:32:46 -0500
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>, mst@redhat.com, jasowang@redhat.com
Cc: linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 2/5] skd: implement trivial scsi ioctls directly
Date: Sat, 28 Jan 2017 09:32:50 +0100
Message-Id: <1485592373-29837-3-git-send-email-hch@lst.de>
In-Reply-To: <1485592373-29837-1-git-send-email-hch@lst.de>
References: <1485592373-29837-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This way there is no need to drag in a dependency on the
BLOCK_PC code, which is going to become optional.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/skd_main.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index abf805e..27833e4 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -1204,10 +1204,11 @@ static void skd_complete_special(struct skd_device *skdev,
 static int skd_bdev_ioctl(struct block_device *bdev, fmode_t mode,
 			  uint cmd_in, ulong arg)
 {
-	int rc = 0;
+	static const int sg_version_num = 30527;
+	int rc = 0, timeout;
 	struct gendisk *disk = bdev->bd_disk;
 	struct skd_device *skdev = disk->private_data;
-	void __user *p = (void *)arg;
+	int __user *p = (int __user *)arg;
 
 	pr_debug("%s:%s:%d %s: CMD[%s] ioctl  mode 0x%x, cmd 0x%x arg %0lx\n",
 		 skdev->name, __func__, __LINE__,
@@ -1218,12 +1219,18 @@ static int skd_bdev_ioctl(struct block_device *bdev, fmode_t mode,
 
 	switch (cmd_in) {
 	case SG_SET_TIMEOUT:
+		rc = get_user(timeout, p);
+		if (!rc)
+			disk->queue->sg_timeout = clock_t_to_jiffies(timeout);
+		break;
 	case SG_GET_TIMEOUT:
+		rc = jiffies_to_clock_t(disk->queue->sg_timeout);
+		break;
 	case SG_GET_VERSION_NUM:
-		rc = scsi_cmd_ioctl(disk->queue, disk, mode, cmd_in, p);
+		rc = put_user(sg_version_num, p);
 		break;
 	case SG_IO:
-		rc = skd_ioctl_sg_io(skdev, mode, p);
+		rc = skd_ioctl_sg_io(skdev, mode, (void __user *)arg);
 		break;
 
 	default:
-- 
2.1.4

