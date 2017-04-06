Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 04/12] nbd: stop using the bdev everywhere
Date: Thu,  6 Apr 2017 17:01:59 -0400
Message-Id: <1491512527-4286-5-git-send-email-jbacik@fb.com>
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

In preparation for the upcoming netlink interface we need to not rely on
already having the bdev for the NBD device we are doing operations on.
Instead of passing the bdev around, just use it in places where we know
we already have the bdev.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 92 +++++++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 55 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c2d9923..8891889 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -120,11 +120,6 @@ static inline struct device *nbd_to_dev(struct nbd_device *nbd)
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
@@ -160,36 +155,30 @@ static void nbd_mark_nsock_dead(struct nbd_sock *nsock)
 	nsock->sent = 0;
 }
 
-static int nbd_size_clear(struct nbd_device *nbd, struct block_device *bdev)
+static void nbd_size_clear(struct nbd_device *nbd)
 {
 	if (nbd->config->bytesize) {
-		if (bdev->bd_openers <= 1)
-			bd_set_size(bdev, 0);
 		set_capacity(nbd->disk, 0);
 		kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 	}
-
-	return 0;
 }
 
-static void nbd_size_update(struct nbd_device *nbd, struct block_device *bdev)
+static void nbd_size_update(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
 	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
-	bd_set_size(bdev, config->bytesize);
 	set_capacity(nbd->disk, config->bytesize >> 9);
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 }
 
-static void nbd_size_set(struct nbd_device *nbd, struct block_device *bdev,
-			loff_t blocksize, loff_t nr_blocks)
+static void nbd_size_set(struct nbd_device *nbd, loff_t blocksize,
+			 loff_t nr_blocks)
 {
 	struct nbd_config *config = nbd->config;
 	config->blksize = blocksize;
 	config->bytesize = blocksize * nr_blocks;
-	if (nbd_is_connected(nbd))
-		nbd_size_update(nbd, bdev);
+	nbd_size_update(nbd);
 }
 
 static void nbd_end_request(struct nbd_cmd *cmd)
@@ -739,8 +728,7 @@ static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
-			  unsigned long arg)
+static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg)
 {
 	struct nbd_config *config = nbd->config;
 	struct socket *sock;
@@ -783,8 +771,6 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 	nsock->sent = 0;
 	socks[config->num_connections++] = nsock;
 
-	if (max_part)
-		bdev->bd_invalidated = 1;
 	return 0;
 }
 
@@ -800,19 +786,20 @@ static void nbd_bdev_reset(struct block_device *bdev)
 {
 	if (bdev->bd_openers > 1)
 		return;
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
 	struct nbd_config *config = nbd->config;
 	if (config->flags & NBD_FLAG_READ_ONLY)
-		set_device_ro(bdev, true);
+		set_disk_ro(nbd->disk, true);
+	else
+		set_disk_ro(nbd->disk, false);
 	if (config->flags & NBD_FLAG_SEND_TRIM)
 		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, nbd->disk->queue);
 	if (config->flags & NBD_FLAG_SEND_FLUSH)
@@ -841,52 +828,36 @@ static void send_disconnects(struct nbd_device *nbd)
 	}
 }
 
-static int nbd_disconnect(struct nbd_device *nbd, struct block_device *bdev)
+static int nbd_disconnect(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
 
 	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
-	mutex_unlock(&nbd->config_lock);
-	fsync_bdev(bdev);
-	mutex_lock(&nbd->config_lock);
-
 	if (!test_and_set_bit(NBD_DISCONNECT_REQUESTED,
 			      &config->runtime_flags))
 		send_disconnects(nbd);
 	return 0;
 }
 
-static int nbd_clear_sock(struct nbd_device *nbd, struct block_device *bdev)
+static void nbd_clear_sock(struct nbd_device *nbd)
 {
 	sock_shutdown(nbd);
 	nbd_clear_que(nbd);
-
-	__invalidate_device(bdev, true);
-	nbd_bdev_reset(bdev);
 	nbd->task_setup = NULL;
-	return 0;
 }
 
 static void nbd_config_put(struct nbd_device *nbd)
 {
 	if (refcount_dec_and_mutex_lock(&nbd->config_refs,
 					&nbd->config_lock)) {
-		struct block_device *bdev;
 		struct nbd_config *config = nbd->config;
-
-		bdev = bdget_disk(nbd->disk, 0);
-		if (!bdev) {
-			mutex_unlock(&nbd->config_lock);
-			return;
-		}
-
 		nbd_dev_dbg_close(nbd);
-		nbd_size_clear(nbd, bdev);
+		nbd_size_clear(nbd);
 		if (test_and_clear_bit(NBD_HAS_PID_FILE,
 				       &config->runtime_flags))
 			device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
 		nbd->task_recv = NULL;
-		nbd_clear_sock(nbd, bdev);
+		nbd_clear_sock(nbd);
 		if (config->num_connections) {
 			int i;
 			for (i = 0; i < config->num_connections; i++) {
@@ -897,7 +868,6 @@ static void nbd_config_put(struct nbd_device *nbd)
 		}
 		nbd_reset(nbd);
 		mutex_unlock(&nbd->config_lock);
-		bdput(bdev);
 		module_put(THIS_MODULE);
 	}
 }
@@ -912,27 +882,30 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 		return -EBUSY;
 	if (!config->socks)
 		return -EINVAL;
-
 	if (num_connections > 1 &&
 	    !(config->flags & NBD_FLAG_CAN_MULTI_CONN)) {
 		dev_err(disk_to_dev(nbd->disk), "server does not support multiple connections per device.\n");
 		return -EINVAL;
 	}
 
+	if (max_part)
+		bdev->bd_invalidated = 1;
 	blk_mq_update_nr_hw_queues(&nbd->tag_set, config->num_connections);
 	nbd->task_recv = current;
 	mutex_unlock(&nbd->config_lock);
 
-	nbd_parse_flags(nbd, bdev);
+	nbd_parse_flags(nbd);
 
 	error = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
 	if (error) {
 		dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
 		return error;
 	}
-	set_bit(NBD_HAS_PID_FILE, &config->runtime_flags);
 
-	nbd_size_update(nbd, bdev);
+	set_bit(NBD_HAS_PID_FILE, &config->runtime_flags);
+	if (max_part)
+		bdev->bd_invalidated = 1;
+	bd_set_size(bdev, config->bytesize);
 
 	nbd_dev_dbg_init(nbd);
 	for (i = 0; i < num_connections; i++) {
@@ -965,6 +938,14 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 	return error;
 }
 
+static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
+				 struct block_device *bdev)
+{
+	nbd_clear_sock(nbd);
+	kill_bdev(bdev);
+	nbd_bdev_reset(bdev);
+}
+
 /* Must be called with config_lock held */
 static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		       unsigned int cmd, unsigned long arg)
@@ -973,21 +954,22 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 
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
 			     div_s64(config->bytesize, arg));
 		return 0;
 	case NBD_SET_SIZE:
-		nbd_size_set(nbd, bdev, config->blksize,
+		nbd_size_set(nbd, config->blksize,
 			     div_s64(arg, config->blksize));
 		return 0;
 	case NBD_SET_SIZE_BLOCKS:
-		nbd_size_set(nbd, bdev, config->blksize, arg);
+		nbd_size_set(nbd, config->blksize, arg);
 		return 0;
 	case NBD_SET_TIMEOUT:
 		if (arg) {
-- 
2.7.4
