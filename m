Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 4/5] nbd: fix how we set bd_invalidated
Date: Wed, 16 May 2018 14:36:04 -0400
Message-Id: <20180516183605.16159-4-josef@toxicpanda.com>
In-Reply-To: <20180516183605.16159-1-josef@toxicpanda.com>
References: <20180516183605.16159-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

bd_invalidated is kind of a pain wrt partitions as it really only
triggers the partition rescan if it is set after bd_ops->open() runs, so
setting it when we reset the device isn't useful.  We also sporadically
would still have partitions left over in some disconnect cases, so fix
this by always setting bd_invalidated on open if there's no
configuration or if we've had a disconnect action happen, that way the
partition table gets invalidated and rescanned properly.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index bc47bae9697a..24788bd10c8b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -240,7 +240,10 @@ static void nbd_size_update(struct nbd_device *nbd)
 	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
 	set_capacity(nbd->disk, config->bytesize >> 9);
 	if (bdev) {
-		bd_set_size(bdev, config->bytesize);
+		if (bdev->bd_disk)
+			bd_set_size(bdev, config->bytesize);
+		else
+			bdev->bd_invalidated = 1;
 		bdput(bdev);
 	}
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
@@ -961,10 +964,6 @@ static void nbd_bdev_reset(struct block_device *bdev)
 	if (bdev->bd_openers > 1)
 		return;
 	bd_set_size(bdev, 0);
-	if (max_part > 0) {
-		blkdev_reread_part(bdev);
-		bdev->bd_invalidated = 1;
-	}
 }
 
 static void nbd_parse_flags(struct nbd_device *nbd)
@@ -1279,6 +1278,9 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
 		refcount_set(&nbd->config_refs, 1);
 		refcount_inc(&nbd->refs);
 		mutex_unlock(&nbd->config_lock);
+		bdev->bd_invalidated = 1;
+	} else if (nbd_disconnected(nbd->config)) {
+		bdev->bd_invalidated = 1;
 	}
 out:
 	mutex_unlock(&nbd_index_mutex);
-- 
2.14.3
