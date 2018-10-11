Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	kernel-team@fb.com
Subject: [PATCH v2 03/11] swim3: add real error handling in setup
Date: Thu, 11 Oct 2018 12:20:43 -0700
Message-Id: <1a5a67d3d1b59bcecdabd99ea23e2bbbe1a5b28d.1539284959.git.osandov@fb.com>
In-Reply-To: <cover.1539284959.git.osandov@fb.com>
References: <cover.1539284959.git.osandov@fb.com>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

The driver doesn't have support for removing a device that has already
been configured, but with more careful ordering we can avoid the need
for that and make sure that we don't leak generic resources.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/swim3.c | 60 ++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 469541c1e51e..df7ebe016e2c 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1202,47 +1202,59 @@ static int swim3_add_device(struct macio_dev *mdev, int index)
 static int swim3_attach(struct macio_dev *mdev,
 			const struct of_device_id *match)
 {
+	struct floppy_state *fs;
 	struct gendisk *disk;
-	int index, rc;
+	int rc;
 
-	index = floppy_count++;
-	if (index >= MAX_FLOPPIES)
+	if (floppy_count >= MAX_FLOPPIES)
 		return -ENXIO;
 
-	/* Add the drive */
-	rc = swim3_add_device(mdev, index);
-	if (rc)
-		return rc;
-	/* Now register that disk. Same comment about failure handling */
-	disk = disks[index] = alloc_disk(1);
-	if (disk == NULL)
-		return -ENOMEM;
+	if (floppy_count == 0) {
+		rc = register_blkdev(FLOPPY_MAJOR, "fd");
+		if (rc)
+			return rc;
+	}
+
+	fs = &floppy_states[floppy_count];
+
+	disk = alloc_disk(1);
+	if (disk == NULL) {
+		rc = -ENOMEM;
+		goto out_unregister;
+	}
 	disk->queue = blk_init_queue(do_fd_request, &swim3_lock);
 	if (disk->queue == NULL) {
-		put_disk(disk);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out_put_disk;
 	}
 	blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
-	disk->queue->queuedata = &floppy_states[index];
+	disk->queue->queuedata = fs;
 
-	if (index == 0) {
-		/* If we failed, there isn't much we can do as the driver is still
-		 * too dumb to remove the device, just bail out
-		 */
-		if (register_blkdev(FLOPPY_MAJOR, "fd"))
-			return 0;
-	}
+	rc = swim3_add_device(mdev, floppy_count);
+	if (rc)
+		goto out_cleanup_queue;
 
 	disk->major = FLOPPY_MAJOR;
-	disk->first_minor = index;
+	disk->first_minor = floppy_count;
 	disk->fops = &floppy_fops;
-	disk->private_data = &floppy_states[index];
+	disk->private_data = fs;
 	disk->flags |= GENHD_FL_REMOVABLE;
-	sprintf(disk->disk_name, "fd%d", index);
+	sprintf(disk->disk_name, "fd%d", floppy_count);
 	set_capacity(disk, 2880);
 	add_disk(disk);
 
+	disks[floppy_count++] = disk;
 	return 0;
+
+out_cleanup_queue:
+	blk_cleanup_queue(disk->queue);
+	disk->queue = NULL;
+out_put_disk:
+	put_disk(disk);
+out_unregister:
+	if (floppy_count == 0)
+		unregister_blkdev(FLOPPY_MAJOR, "fd");
+	return rc;
 }
 
 static const struct of_device_id swim3_match[] =
-- 
2.19.1
