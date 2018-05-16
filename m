Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 2/5] nbd: do queue cleanup after del_gendisk
Date: Wed, 16 May 2018 14:36:02 -0400
Message-Id: <20180516183605.16159-2-josef@toxicpanda.com>
In-Reply-To: <20180516183605.16159-1-josef@toxicpanda.com>
References: <20180516183605.16159-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

Apparently del_gendisk is actually supposed to happen first to cleanup
the sysfs stuff.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7b7b6143a126..7e83d6364b35 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -173,9 +173,12 @@ static const struct device_attribute pid_attr = {
 static void nbd_dev_remove(struct nbd_device *nbd)
 {
 	struct gendisk *disk = nbd->disk;
+	struct request_queue *q;
+
 	if (disk) {
-		blk_cleanup_queue(disk->queue);
+		q = disk->queue;
 		del_gendisk(disk);
+		blk_cleanup_queue(q);
 		blk_mq_free_tag_set(&nbd->tag_set);
 		disk->private_data = NULL;
 		put_disk(disk);
-- 
2.14.3
