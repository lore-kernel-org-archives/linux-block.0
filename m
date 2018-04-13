Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com,
	alex@iss-integration.com
Cc: Josef Bacik <jbacik@fb.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] nbd: use bd_set_size when updating disk size
Date: Fri, 13 Apr 2018 12:03:34 -0400
Message-Id: <20180413160334.5496-3-josef@toxicpanda.com>
In-Reply-To: <20180413160334.5496-1-josef@toxicpanda.com>
References: <20180413160334.5496-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

When we stopped relying on the bdev everywhere I broke updating the
block device size on the fly, which ceph relies on.  We can't just do
set_capacity, we also have to do bd_set_size so things like parted will
notice the device size change.

Fixes: 29eaadc ("nbd: stop using the bdev everywhere")
cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1520383b12f6..61dd95aa47fa 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -231,9 +231,15 @@ static void nbd_size_clear(struct nbd_device *nbd)
 static void nbd_size_update(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
+	struct block_device *bdev = bdget_disk(nbd->disk, 0);
+
 	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
 	set_capacity(nbd->disk, config->bytesize >> 9);
+	if (bdev) {
+		bd_set_size(bdev, config->bytesize);
+		bdput(bdev);
+	}
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 }
 
@@ -1111,7 +1117,6 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 	if (ret)
 		return ret;
 
-	bd_set_size(bdev, config->bytesize);
 	if (max_part)
 		bdev->bd_invalidated = 1;
 	mutex_unlock(&nbd->config_lock);
-- 
2.14.3
