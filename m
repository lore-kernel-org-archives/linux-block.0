Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/7] nbd: fix nbd device deletion
Date: Wed, 16 May 2018 14:51:17 -0400
Message-Id: <20180516185122.18590-2-josef@toxicpanda.com>
In-Reply-To: <20180516185122.18590-1-josef@toxicpanda.com>
References: <20180516185122.18590-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

This fixes a use after free bug, we shouldn't be doing disk->queue right
after we do del_gendisk(disk).  Save the queue and do the cleanup after
the del_gendisk.

Fixes: c6a4759ea0c9 ("nbd: add device refcounting")
cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index afbc202ca6fd..9710a0c338b0 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -173,9 +173,12 @@ static const struct device_attribute pid_attr = {
 static void nbd_dev_remove(struct nbd_device *nbd)
 {
 	struct gendisk *disk = nbd->disk;
+	struct request_queue *q;
+
 	if (disk) {
+		q = disk->queue;
 		del_gendisk(disk);
-		blk_cleanup_queue(disk->queue);
+		blk_cleanup_queue(q);
 		blk_mq_free_tag_set(&nbd->tag_set);
 		disk->private_data = NULL;
 		put_disk(disk);
-- 
2.14.3
