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
Subject: [PATCH 1/3] nbd: del_gendisk after we cleanup the queue
Date: Fri, 13 Apr 2018 12:03:32 -0400
Message-Id: <20180413160334.5496-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

This fixes a use after free bug, we need to do the del_gendisk after we
cleanup the queue on the device.

Fixes: c6a4759ea0c9 ("nbd: add device refcounting")
cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 86258b00a1d4..e33da3e6aa20 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -174,8 +174,8 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 {
 	struct gendisk *disk = nbd->disk;
 	if (disk) {
-		del_gendisk(disk);
 		blk_cleanup_queue(disk->queue);
+		del_gendisk(disk);
 		blk_mq_free_tag_set(&nbd->tag_set);
 		disk->private_data = NULL;
 		put_disk(disk);
-- 
2.14.3
