Return-Path: <prvs=423213d9ff=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <nbd-general@lists.sourceforge.net>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 3/6] nbd: stop using the bdev everywhere
Date: Tue, 28 Feb 2017 11:57:08 -0500
Message-ID: <1488301031-3199-4-git-send-email-jbacik@fb.com>
In-Reply-To: <1488301031-3199-1-git-send-email-jbacik@fb.com>
References: <1488301031-3199-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

In preparation for the upcoming netlink interface we need to not rely on
already having the bdev for the NBD device we are doing operations on.
Instead of passing the bdev around, just use it in places where we know
we already have the bdev.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 93 ++++++++++++++++++++++-------------------------------
 1 file changed, 39 insertions(+), 54 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6760ee5..059c80a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -119,11 +119,6 @@ static inline struct device *nbd_to_dev(struct nbd_device *nbd)
 	return disk_to_dev(nbd->disk);
 }
 
-static bool nbd_is_connected(struct nbd_device *nbd)
-{
-	return !!nbd->task_recv;
-}
-
 static const char *nbdcmd_to_ascii(int cmd)
 {
 	switch (cmd) {
@@ -155,31 +150,26 @@ static int nbd_get_unless_zero(struct nbd_device *nbd)
 	return atomic_add_unless(&nbd->refs, 1, 0);
 }
 
-static int nbd_size_clear(struct nbd_device *nbd, struct block_device *bdev)
+static void nbd_size_clear(struct nbd_device *nbd)
 {
-	bd_set_size(bdev, 0);
 	set_capacity(nbd->disk, 0);
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
-
-	return 0;
 }
 
-static void nbd_size_update(struct nbd_device *nbd, struct block_device *bdev)
+static void nbd_size_update(struct nbd_device *nbd)
 {
 	blk_queue_logical_block_size(nbd->disk->queue, nbd->blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, nbd->blksize);
-	bd_set_size(bdev, nbd->bytesize);
 	set_capacity(nbd->disk, nbd->bytesize >> 9);
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 }
 
-static void nbd_size_set(struct nbd_device *nbd, struct block_device *bdev,
-			loff_t blocksize, loff_t nr_blocks)
+static void nbd_size_set(struct nbd_device *nbd, loff_t blocksize,
+			 loff_t nr_blocks)
 {
 	nbd->blksize = blocksize;
 	nbd->bytesize = blocksize * nr_blocks;
-	if (nbd_is_connected(nbd))
-		nbd_size_update(nbd, bdev);
+	nbd_size_update(nbd);
 }
 
 static void nbd_end_request(struct nbd_cmd *cmd)
@@ -670,8 +660,7 @@ static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_MQ_RQ_QUEUE_OK;
 }
 
-static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
-			  unsigned long arg)
+static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg)
 {
 	struct socket *sock;
 	struct nbd_sock **socks;
@@ -712,8 +701,6 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 	nsock->sock = sock;
 	socks[nbd->num_connections++] = nsock;
 
-	if (max_part)
-		bdev->bd_invalidated = 1;
 	err = 0;
 out:
 	return err;
@@ -734,18 +721,19 @@ static void nbd_reset(struct nbd_device *nbd)
 
 static void nbd_bdev_reset(struct block_device *bdev)
 {
-	set_device_ro(bdev, false);
-	bdev->bd_inode->i_size = 0;
+	bd_set_size(bdev, 0);
 	if (max_part > 0) {
 		blkdev_reread_part(bdev);
 		bdev->bd_invalidated = 1;
 	}
 }
 
-static void nbd_parse_flags(struct nbd_device *nbd, struct block_device *bdev)
+static void nbd_parse_flags(struct nbd_device *nbd)
 {
 	if (nbd->flags & NBD_FLAG_READ_ONLY)
-		set_device_ro(bdev, true);
+		set_disk_ro(nbd->disk, true);
+	else
+		set_disk_ro(nbd->disk, false);
 	if (nbd->flags & NBD_FLAG_SEND_TRIM)
 		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, nbd->disk->queue);
 	if (nbd->flags & NBD_FLAG_SEND_FLUSH)
@@ -770,16 +758,11 @@ static void send_disconnects(struct nbd_device *nbd)
 	}
 }
 
-static int nbd_disconnect(struct nbd_device *nbd, struct block_device *bdev)
+static int nbd_disconnect(struct nbd_device *nbd)
 {
 	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
 	if (!nbd_get_unless_zero(nbd))
 		return -EINVAL;
-
-	mutex_unlock(&nbd->config_lock);
-	fsync_bdev(bdev);
-	mutex_lock(&nbd->config_lock);
-
 	if (!test_and_set_bit(NBD_DISCONNECT_REQUESTED,
 			      &nbd->runtime_flags))
 		send_disconnects(nbd);
@@ -787,33 +770,22 @@ static int nbd_disconnect(struct nbd_device *nbd, struct block_device *bdev)
 	return 0;
 }
 
-static int nbd_clear_sock(struct nbd_device *nbd, struct block_device *bdev)
+static void nbd_clear_sock(struct nbd_device *nbd)
 {
 	sock_shutdown(nbd);
 	nbd_clear_que(nbd);
-	kill_bdev(bdev);
-	nbd_bdev_reset(bdev);
 	nbd->task_setup = NULL;
-	if (test_and_clear_bit(NBD_HAS_SOCKS_REF, &nbd->runtime_flags))
-		nbd_put(nbd);
-	return 0;
 }
 
 static void nbd_put(struct nbd_device *nbd)
 {
 	if (atomic_dec_and_test(&nbd->refs)) {
-		struct block_device *bdev;
-
-		bdev = bdget_disk(nbd->disk, 0);
-		if (!bdev)
-			return;
-
 		mutex_lock(&nbd->config_lock);
 		nbd_dev_dbg_close(nbd);
-		nbd_size_clear(nbd, bdev);
+		nbd_size_clear(nbd);
 		device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
 		nbd->task_recv = NULL;
-		nbd_clear_sock(nbd, bdev);
+		nbd_clear_sock(nbd);
 		if (nbd->num_connections) {
 			int i;
 			for (i = 0; i < nbd->num_connections; i++)
@@ -825,7 +797,6 @@ static void nbd_put(struct nbd_device *nbd)
 		kfree(nbd->args);
 		nbd_reset(nbd);
 		mutex_unlock(&nbd->config_lock);
-		bdput(bdev);
 		module_put(THIS_MODULE);
 	}
 }
@@ -846,7 +817,6 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 		error = -EINVAL;
 		goto out;
 	}
-
 	if (num_connections > 1 &&
 	    !(nbd->flags & NBD_FLAG_CAN_MULTI_CONN)) {
 		dev_err(disk_to_dev(nbd->disk), "server does not support multiple connections per device.\n");
@@ -854,6 +824,9 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 		goto out;
 	}
 
+	if (max_part)
+		bdev->bd_invalidated = 1;
+
 	blk_mq_update_nr_hw_queues(&nbd->tag_set, nbd->num_connections);
 	args = kcalloc(num_connections, sizeof(*args), GFP_KERNEL);
 	if (!args) {
@@ -864,15 +837,16 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 	nbd->task_recv = current;
 	mutex_unlock(&nbd->config_lock);
 
-	nbd_parse_flags(nbd, bdev);
+	nbd_parse_flags(nbd);
 
 	error = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
 	if (error) {
 		dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
 		goto out;
 	}
-
-	nbd_size_update(nbd, bdev);
+	if (max_part)
+		bdev->bd_invalidated = 1;
+	bd_set_size(bdev, nbd->bytesize);
 
 	nbd_dev_dbg_init(nbd);
 	for (i = 0; i < num_connections; i++) {
@@ -901,27 +875,38 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 	return error;
 }
 
+static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
+				 struct block_device *bdev)
+{
+	nbd_clear_sock(nbd);
+	kill_bdev(bdev);
+	nbd_bdev_reset(bdev);
+	if (test_and_clear_bit(NBD_HAS_SOCKS_REF, &nbd->runtime_flags))
+		nbd_put(nbd);
+}
+
 /* Must be called with config_lock held */
 static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		       unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
 	case NBD_DISCONNECT:
-		return nbd_disconnect(nbd, bdev);
+		return nbd_disconnect(nbd);
 	case NBD_CLEAR_SOCK:
-		return nbd_clear_sock(nbd, bdev);
+		nbd_clear_sock_ioctl(nbd, bdev);
+		return 0;
 	case NBD_SET_SOCK:
-		return nbd_add_socket(nbd, bdev, arg);
+		return nbd_add_socket(nbd, arg);
 	case NBD_SET_BLKSIZE:
-		nbd_size_set(nbd, bdev, arg,
+		nbd_size_set(nbd, arg,
 			     div_s64(nbd->bytesize, arg));
 		return 0;
 	case NBD_SET_SIZE:
-		nbd_size_set(nbd, bdev, nbd->blksize,
+		nbd_size_set(nbd, nbd->blksize,
 			     div_s64(arg, nbd->blksize));
 		return 0;
 	case NBD_SET_SIZE_BLOCKS:
-		nbd_size_set(nbd, bdev, nbd->blksize, arg);
+		nbd_size_set(nbd, nbd->blksize, arg);
 		return 0;
 	case NBD_SET_TIMEOUT:
 		nbd->tag_set.timeout = arg * HZ;
-- 
2.7.4
