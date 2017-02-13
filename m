Return-Path: <prvs=3217d0f3de=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <nbd-general@lists.sourceforge.net>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH] nbd: use bdget_disk to get bdev
Date: Mon, 13 Feb 2017 12:31:40 -0500
Message-ID: <1487007100-6847-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

In preparation for the upcoming netlink interface we need to not rely on
already having the bdev for the NBD device we are doing operations on.
Instead of passing the bdev from the bdev ioctl around, use bdget_disk()
wherever we need the bdev and pass that down to the helpers as
necessary.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 88 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 25891a1..0623f8f 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -168,13 +168,18 @@ static void nbd_size_update(struct nbd_device *nbd, struct block_device *bdev)
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 }
 
-static void nbd_size_set(struct nbd_device *nbd, struct block_device *bdev,
-			loff_t blocksize, loff_t nr_blocks)
+static int nbd_size_set(struct nbd_device *nbd, loff_t blocksize,
+			loff_t nr_blocks)
 {
+	struct block_device *bdev = bdget_disk(nbd->disk, 0);
+	if (!bdev)
+		return -EINVAL;
 	nbd->blksize = blocksize;
 	nbd->bytesize = blocksize * nr_blocks;
 	if (nbd_is_connected(nbd))
 		nbd_size_update(nbd, bdev);
+	bdput(bdev);
+	return 0;
 }
 
 static void nbd_end_request(struct nbd_cmd *cmd)
@@ -704,8 +709,7 @@ static int nbd_wait_for_socks(struct nbd_device *nbd)
 	return ret;
 }
 
-static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
-			  unsigned long arg)
+static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg)
 {
 	struct socket *sock;
 	struct nbd_sock **socks;
@@ -749,8 +753,6 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 	nsock->sock = sock;
 	socks[nbd->num_connections++] = nsock;
 
-	if (max_part)
-		bdev->bd_invalidated = 1;
 	err = 0;
 out:
 	mutex_unlock(&nbd->socks_lock);
@@ -771,18 +773,19 @@ static void nbd_reset(struct nbd_device *nbd)
 
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
@@ -807,16 +810,11 @@ static void send_disconnects(struct nbd_device *nbd)
 	}
 }
 
-static int nbd_disconnect(struct nbd_device *nbd, struct block_device *bdev)
+static int nbd_disconnect(struct nbd_device *nbd)
 {
 	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
 	if (!nbd_socks_get_unless_zero(nbd))
 		return -EINVAL;
-
-	mutex_unlock(&nbd->config_lock);
-	fsync_bdev(bdev);
-	mutex_lock(&nbd->config_lock);
-
 	if (!test_and_set_bit(NBD_DISCONNECT_REQUESTED,
 			      &nbd->runtime_flags))
 		send_disconnects(nbd);
@@ -824,28 +822,40 @@ static int nbd_disconnect(struct nbd_device *nbd, struct block_device *bdev)
 	return 0;
 }
 
-static int nbd_clear_sock(struct nbd_device *nbd, struct block_device *bdev)
+static int nbd_clear_sock(struct nbd_device *nbd)
 {
+	struct block_device *bdev = bdget_disk(nbd->disk, 0);
+
 	sock_shutdown(nbd);
 	nbd_clear_que(nbd);
-	kill_bdev(bdev);
-	nbd_bdev_reset(bdev);
+	if (bdev) {
+		kill_bdev(bdev);
+		nbd_bdev_reset(bdev);
+		bdput(bdev);
+	}
 	nbd->task_setup = NULL;
 	if (test_and_clear_bit(NBD_HAS_SOCKS_REF, &nbd->runtime_flags))
 		nbd_socks_put(nbd);
 	return 0;
 }
 
-static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
+static int nbd_start_device(struct nbd_device *nbd)
 {
 	struct recv_thread_args *args;
+	struct block_device *bdev = bdget_disk(nbd->disk, 0);
 	int num_connections = nbd->num_connections;
 	int error = 0, i;
 
-	if (nbd->task_recv)
+	if (!bdev)
+		return -EINVAL;
+	if (nbd->task_recv) {
+		bdput(bdev);
 		return -EBUSY;
-	if (!nbd->socks)
+	}
+	if (!nbd->socks) {
+		bdput(bdev);
 		return -EINVAL;
+	}
 	if (num_connections > 1 &&
 	    !(nbd->flags & NBD_FLAG_CAN_MULTI_CONN)) {
 		dev_err(disk_to_dev(nbd->disk), "server does not support multiple connections per device.\n");
@@ -853,6 +863,9 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 		goto out_err;
 	}
 
+	if (max_part)
+		bdev->bd_invalidated = 1;
+
 	blk_mq_update_nr_hw_queues(&nbd->tag_set, nbd->num_connections);
 	args = kcalloc(num_connections, sizeof(*args), GFP_KERNEL);
 	if (!args) {
@@ -862,7 +875,7 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 	nbd->task_recv = current;
 	mutex_unlock(&nbd->config_lock);
 
-	nbd_parse_flags(nbd, bdev);
+	nbd_parse_flags(nbd);
 
 	error = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
 	if (error) {
@@ -893,7 +906,7 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 	mutex_lock(&nbd->config_lock);
 	nbd->task_recv = NULL;
 out_err:
-	nbd_clear_sock(nbd, bdev);
+	nbd_clear_sock(nbd);
 
 	/* user requested, ignore socket errors */
 	if (test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
@@ -902,31 +915,30 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 		error = -ETIMEDOUT;
 
 	nbd_reset(nbd);
+	bdput(bdev);
 	return error;
 }
 
 /* Must be called with config_lock held */
-static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
-		       unsigned int cmd, unsigned long arg)
+static int __nbd_ioctl(struct nbd_device *nbd, unsigned int cmd,
+		       unsigned long arg)
 {
 	switch (cmd) {
 	case NBD_DISCONNECT:
-		return nbd_disconnect(nbd, bdev);
+		return nbd_disconnect(nbd);
 	case NBD_CLEAR_SOCK:
-		return nbd_clear_sock(nbd, bdev);
+		return nbd_clear_sock(nbd);
 	case NBD_SET_SOCK:
-		return nbd_add_socket(nbd, bdev, arg);
+		return nbd_add_socket(nbd, arg);
 	case NBD_SET_BLKSIZE:
-		nbd_size_set(nbd, bdev, arg,
-			     div_s64(nbd->bytesize, arg));
+		return nbd_size_set(nbd, arg,
+				    div_s64(nbd->bytesize, arg));
 		return 0;
 	case NBD_SET_SIZE:
-		nbd_size_set(nbd, bdev, nbd->blksize,
-			     div_s64(arg, nbd->blksize));
-		return 0;
+		return nbd_size_set(nbd, nbd->blksize,
+				    div_s64(arg, nbd->blksize));
 	case NBD_SET_SIZE_BLOCKS:
-		nbd_size_set(nbd, bdev, nbd->blksize, arg);
-		return 0;
+		return nbd_size_set(nbd, nbd->blksize, arg);
 	case NBD_SET_TIMEOUT:
 		nbd->tag_set.timeout = arg * HZ;
 		return 0;
@@ -935,7 +947,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		nbd->flags = arg;
 		return 0;
 	case NBD_DO_IT:
-		return nbd_start_device(nbd, bdev);
+		return nbd_start_device(nbd);
 	case NBD_CLEAR_QUE:
 		/*
 		 * This is for compatibility only.  The queue is always cleared
@@ -964,7 +976,7 @@ static int nbd_ioctl(struct block_device *bdev, fmode_t mode,
 	BUG_ON(nbd->magic != NBD_MAGIC);
 
 	mutex_lock(&nbd->config_lock);
-	error = __nbd_ioctl(bdev, nbd, cmd, arg);
+	error = __nbd_ioctl(nbd, cmd, arg);
 	mutex_unlock(&nbd->config_lock);
 
 	return error;
-- 
2.7.4
