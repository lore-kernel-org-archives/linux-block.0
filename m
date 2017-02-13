Return-Path: <prvs=3217d0f3de=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <kernel-team@fb.com>,
        <nbd-general@lists.sourceforge.net>
Subject: [PATCH V2] nbd: set the logical and physical blocksize properly
Date: Mon, 13 Feb 2017 10:39:47 -0500
Message-ID: <1487000387-1372-1-git-send-email-jbacik@fb.com>
In-Reply-To: <1486750004-2988-1-git-send-email-jbacik@fb.com>
References: <1486750004-2988-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

We noticed when trying to do O_DIRECT to an export on the server side
that we were getting requests smaller than the 4k sectorsize of the
device.  This is because the client isn't setting the logical and
physical blocksizes properly for the underlying device.  Fix this up by
setting the queue blocksizes and then calling bd_set_size.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
V1->V2:
-remove an debug printk that I forgot to delete.

 drivers/block/nbd.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index afb1353..25891a1 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -152,7 +152,7 @@ static void nbd_socks_put(struct nbd_device *nbd)
 
 static int nbd_size_clear(struct nbd_device *nbd, struct block_device *bdev)
 {
-	bdev->bd_inode->i_size = 0;
+	bd_set_size(bdev, 0);
 	set_capacity(nbd->disk, 0);
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 
@@ -161,29 +161,20 @@ static int nbd_size_clear(struct nbd_device *nbd, struct block_device *bdev)
 
 static void nbd_size_update(struct nbd_device *nbd, struct block_device *bdev)
 {
-	if (!nbd_is_connected(nbd))
-		return;
-
-	bdev->bd_inode->i_size = nbd->bytesize;
+	blk_queue_logical_block_size(nbd->disk->queue, nbd->blksize);
+	blk_queue_physical_block_size(nbd->disk->queue, nbd->blksize);
+	bd_set_size(bdev, nbd->bytesize);
 	set_capacity(nbd->disk, nbd->bytesize >> 9);
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 }
 
-static int nbd_size_set(struct nbd_device *nbd, struct block_device *bdev,
+static void nbd_size_set(struct nbd_device *nbd, struct block_device *bdev,
 			loff_t blocksize, loff_t nr_blocks)
 {
-	int ret;
-
-	ret = set_blocksize(bdev, blocksize);
-	if (ret)
-		return ret;
-
 	nbd->blksize = blocksize;
 	nbd->bytesize = blocksize * nr_blocks;
-
-	nbd_size_update(nbd, bdev);
-
-	return 0;
+	if (nbd_is_connected(nbd))
+		nbd_size_update(nbd, bdev);
 }
 
 static void nbd_end_request(struct nbd_cmd *cmd)
@@ -926,15 +917,16 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 	case NBD_SET_SOCK:
 		return nbd_add_socket(nbd, bdev, arg);
 	case NBD_SET_BLKSIZE:
-		return nbd_size_set(nbd, bdev, arg,
-				    div_s64(nbd->bytesize, arg));
+		nbd_size_set(nbd, bdev, arg,
+			     div_s64(nbd->bytesize, arg));
+		return 0;
 	case NBD_SET_SIZE:
-		return nbd_size_set(nbd, bdev, nbd->blksize,
-					div_s64(arg, nbd->blksize));
-
+		nbd_size_set(nbd, bdev, nbd->blksize,
+			     div_s64(arg, nbd->blksize));
+		return 0;
 	case NBD_SET_SIZE_BLOCKS:
-		return nbd_size_set(nbd, bdev, nbd->blksize, arg);
-
+		nbd_size_set(nbd, bdev, nbd->blksize, arg);
+		return 0;
 	case NBD_SET_TIMEOUT:
 		nbd->tag_set.timeout = arg * HZ;
 		return 0;
-- 
2.7.4
