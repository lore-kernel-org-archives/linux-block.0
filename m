Return-Path: <prvs=423213d9ff=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <nbd-general@lists.sourceforge.net>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 2/6] nbd: ref count the nbd device
Date: Tue, 28 Feb 2017 11:57:07 -0500
Message-ID: <1488301031-3199-3-git-send-email-jbacik@fb.com>
In-Reply-To: <1488301031-3199-1-git-send-email-jbacik@fb.com>
References: <1488301031-3199-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

In preparation for seamless reconnects and the netlink configuration
interface we need a way to make sure our nbd device configuration
doesn't disappear until we are finished with it.  So add a ref counter,
and on the final put we do all of the cleanup work on the nbd device.
At configuration time we only allow a device to be configured if it's
ref count is currently 0.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 210 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 133 insertions(+), 77 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7a91c8f..6760ee5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -51,22 +51,33 @@ struct nbd_sock {
 	int fallback_index;
 };
 
+struct recv_thread_args {
+	struct work_struct work;
+	struct nbd_device *nbd;
+	int index;
+};
+
 #define NBD_TIMEDOUT			0
 #define NBD_DISCONNECT_REQUESTED	1
 #define NBD_DISCONNECTED		2
-#define NBD_RUNNING			3
+#define NBD_HAS_SOCKS_REF		3
 
 struct nbd_device {
 	u32 flags;
 	unsigned long runtime_flags;
+
 	struct nbd_sock **socks;
+	atomic_t refs;
+	wait_queue_head_t socks_wq;
+	int num_connections;
+
+	struct recv_thread_args *args;
 	int magic;
 
 	struct blk_mq_tag_set tag_set;
 
 	struct mutex config_lock;
 	struct gendisk *disk;
-	int num_connections;
 	atomic_t recv_threads;
 	wait_queue_head_t recv_wq;
 	loff_t blksize;
@@ -101,7 +112,7 @@ static int part_shift;
 
 static int nbd_dev_dbg_init(struct nbd_device *nbd);
 static void nbd_dev_dbg_close(struct nbd_device *nbd);
-
+static void nbd_put(struct nbd_device *nbd);
 
 static inline struct device *nbd_to_dev(struct nbd_device *nbd)
 {
@@ -125,6 +136,25 @@ static const char *nbdcmd_to_ascii(int cmd)
 	return "invalid";
 }
 
+static ssize_t pid_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nbd_device *nbd = (struct nbd_device *)disk->private_data;
+
+	return sprintf(buf, "%d\n", task_pid_nr(nbd->task_recv));
+}
+
+static struct device_attribute pid_attr = {
+	.attr = { .name = "pid", .mode = S_IRUGO},
+	.show = pid_show,
+};
+
+static int nbd_get_unless_zero(struct nbd_device *nbd)
+{
+	return atomic_add_unless(&nbd->refs, 1, 0);
+}
+
 static int nbd_size_clear(struct nbd_device *nbd, struct block_device *bdev)
 {
 	bd_set_size(bdev, 0);
@@ -181,6 +211,7 @@ static void sock_shutdown(struct nbd_device *nbd)
 		mutex_lock(&nsock->tx_lock);
 		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
 		mutex_unlock(&nsock->tx_lock);
+		nsock->dead = true;
 	}
 	dev_warn(disk_to_dev(nbd->disk), "shutting down sockets\n");
 }
@@ -191,10 +222,14 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 	struct nbd_device *nbd = cmd->nbd;
 
+	if (!nbd_get_unless_zero(nbd)) {
+		req->errors++;
+		return BLK_EH_HANDLED;
+	}
+
 	if (nbd->num_connections > 1) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out, retrying\n");
-		mutex_lock(&nbd->config_lock);
 		/*
 		 * Hooray we have more connections, requeue this IO, the submit
 		 * path will put it on a real connection.
@@ -208,21 +243,19 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 				kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
 				mutex_unlock(&nsock->tx_lock);
 			}
-			mutex_unlock(&nbd->config_lock);
 			blk_mq_requeue_request(req, true);
+			nbd_put(nbd);
 			return BLK_EH_RESET_TIMER;
 		}
-		mutex_unlock(&nbd->config_lock);
 	} else {
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out\n");
 	}
 	set_bit(NBD_TIMEDOUT, &nbd->runtime_flags);
 	req->errors++;
-
-	mutex_lock(&nbd->config_lock);
 	sock_shutdown(nbd);
-	mutex_unlock(&nbd->config_lock);
+	nbd_put(nbd);
+
 	return BLK_EH_HANDLED;
 }
 
@@ -474,26 +507,6 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	return cmd;
 }
 
-static ssize_t pid_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	struct gendisk *disk = dev_to_disk(dev);
-	struct nbd_device *nbd = (struct nbd_device *)disk->private_data;
-
-	return sprintf(buf, "%d\n", task_pid_nr(nbd->task_recv));
-}
-
-static struct device_attribute pid_attr = {
-	.attr = { .name = "pid", .mode = S_IRUGO},
-	.show = pid_show,
-};
-
-struct recv_thread_args {
-	struct work_struct work;
-	struct nbd_device *nbd;
-	int index;
-};
-
 static void recv_work(struct work_struct *work)
 {
 	struct recv_thread_args *args = container_of(work,
@@ -516,6 +529,7 @@ static void recv_work(struct work_struct *work)
 	}
 	atomic_dec(&nbd->recv_threads);
 	wake_up(&nbd->recv_wq);
+	nbd_put(nbd);
 }
 
 static void nbd_clear_req(struct request *req, void *data, bool reserved)
@@ -589,9 +603,16 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	struct nbd_sock *nsock;
 	int ret;
 
+	if (!nbd_get_unless_zero(nbd)) {
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Socks array is empty\n");
+		return -EINVAL;
+	}
+
 	if (index >= nbd->num_connections) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
+		nbd_put(nbd);
 		return -EINVAL;
 	}
 	req->errors = 0;
@@ -599,8 +620,10 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	nsock = nbd->socks[index];
 	if (nsock->dead) {
 		index = find_fallback(nbd, index);
-		if (index < 0)
+		if (index < 0) {
+			nbd_put(nbd);
 			return -EIO;
+		}
 		nsock = nbd->socks[index];
 	}
 
@@ -618,7 +641,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		goto again;
 	}
 	mutex_unlock(&nsock->tx_lock);
-
+	nbd_put(nbd);
 	return ret;
 }
 
@@ -659,21 +682,27 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 	if (!sock)
 		return err;
 
-	if (!nbd->task_setup)
+	err = -EINVAL;
+	if (!nbd->task_setup && !atomic_cmpxchg(&nbd->refs, 0, 1)) {
 		nbd->task_setup = current;
+		set_bit(NBD_HAS_SOCKS_REF, &nbd->runtime_flags);
+		try_module_get(THIS_MODULE);
+	}
+
 	if (nbd->task_setup != current) {
 		dev_err(disk_to_dev(nbd->disk),
 			"Device being setup by another task");
-		return -EINVAL;
+		goto out;
 	}
 
+	err = -ENOMEM;
 	socks = krealloc(nbd->socks, (nbd->num_connections + 1) *
 			 sizeof(struct nbd_sock *), GFP_KERNEL);
 	if (!socks)
-		return -ENOMEM;
+		goto out;
 	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
 	if (!nsock)
-		return -ENOMEM;
+		goto out;
 
 	nbd->socks = socks;
 
@@ -685,7 +714,9 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 
 	if (max_part)
 		bdev->bd_invalidated = 1;
-	return 0;
+	err = 0;
+out:
+	return err;
 }
 
 /* Reset all properties of an NBD device */
@@ -697,6 +728,7 @@ static void nbd_reset(struct nbd_device *nbd)
 	set_capacity(nbd->disk, 0);
 	nbd->flags = 0;
 	nbd->tag_set.timeout = 0;
+	nbd->args = NULL;
 	queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, nbd->disk->queue);
 }
 
@@ -741,20 +773,17 @@ static void send_disconnects(struct nbd_device *nbd)
 static int nbd_disconnect(struct nbd_device *nbd, struct block_device *bdev)
 {
 	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
-	if (!nbd->socks)
+	if (!nbd_get_unless_zero(nbd))
 		return -EINVAL;
 
 	mutex_unlock(&nbd->config_lock);
 	fsync_bdev(bdev);
 	mutex_lock(&nbd->config_lock);
 
-	/* Check again after getting mutex back.  */
-	if (!nbd->socks)
-		return -EINVAL;
-
 	if (!test_and_set_bit(NBD_DISCONNECT_REQUESTED,
 			      &nbd->runtime_flags))
 		send_disconnects(nbd);
+	nbd_put(nbd);
 	return 0;
 }
 
@@ -764,49 +793,74 @@ static int nbd_clear_sock(struct nbd_device *nbd, struct block_device *bdev)
 	nbd_clear_que(nbd);
 	kill_bdev(bdev);
 	nbd_bdev_reset(bdev);
-	/*
-	 * We want to give the run thread a chance to wait for everybody
-	 * to clean up and then do it's own cleanup.
-	 */
-	if (!test_bit(NBD_RUNNING, &nbd->runtime_flags) &&
-	    nbd->num_connections) {
-		int i;
-
-		for (i = 0; i < nbd->num_connections; i++)
-			kfree(nbd->socks[i]);
-		kfree(nbd->socks);
-		nbd->socks = NULL;
-		nbd->num_connections = 0;
-	}
 	nbd->task_setup = NULL;
-
+	if (test_and_clear_bit(NBD_HAS_SOCKS_REF, &nbd->runtime_flags))
+		nbd_put(nbd);
 	return 0;
 }
 
+static void nbd_put(struct nbd_device *nbd)
+{
+	if (atomic_dec_and_test(&nbd->refs)) {
+		struct block_device *bdev;
+
+		bdev = bdget_disk(nbd->disk, 0);
+		if (!bdev)
+			return;
+
+		mutex_lock(&nbd->config_lock);
+		nbd_dev_dbg_close(nbd);
+		nbd_size_clear(nbd, bdev);
+		device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
+		nbd->task_recv = NULL;
+		nbd_clear_sock(nbd, bdev);
+		if (nbd->num_connections) {
+			int i;
+			for (i = 0; i < nbd->num_connections; i++)
+				kfree(nbd->socks[i]);
+			kfree(nbd->socks);
+			nbd->num_connections = 0;
+			nbd->socks = NULL;
+		}
+		kfree(nbd->args);
+		nbd_reset(nbd);
+		mutex_unlock(&nbd->config_lock);
+		bdput(bdev);
+		module_put(THIS_MODULE);
+	}
+}
+
 static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 {
 	struct recv_thread_args *args;
 	int num_connections = nbd->num_connections;
 	int error = 0, i;
 
-	if (nbd->task_recv)
-		return -EBUSY;
-	if (!nbd->socks)
+	if (!nbd_get_unless_zero(nbd))
 		return -EINVAL;
+	if (nbd->task_recv) {
+		error = -EBUSY;
+		goto out;
+	}
+	if (!nbd->socks) {
+		error = -EINVAL;
+		goto out;
+	}
+
 	if (num_connections > 1 &&
 	    !(nbd->flags & NBD_FLAG_CAN_MULTI_CONN)) {
 		dev_err(disk_to_dev(nbd->disk), "server does not support multiple connections per device.\n");
 		error = -EINVAL;
-		goto out_err;
+		goto out;
 	}
 
-	set_bit(NBD_RUNNING, &nbd->runtime_flags);
 	blk_mq_update_nr_hw_queues(&nbd->tag_set, nbd->num_connections);
 	args = kcalloc(num_connections, sizeof(*args), GFP_KERNEL);
 	if (!args) {
 		error = -ENOMEM;
-		goto out_err;
+		goto out;
 	}
+	nbd->args = args;
 	nbd->task_recv = current;
 	mutex_unlock(&nbd->config_lock);
 
@@ -815,7 +869,7 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 	error = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
 	if (error) {
 		dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
-		goto out_recv;
+		goto out;
 	}
 
 	nbd_size_update(nbd, bdev);
@@ -824,32 +878,26 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 	for (i = 0; i < num_connections; i++) {
 		sk_set_memalloc(nbd->socks[i]->sock->sk);
 		atomic_inc(&nbd->recv_threads);
+		atomic_inc(&nbd->refs);
 		INIT_WORK(&args[i].work, recv_work);
 		args[i].nbd = nbd;
 		args[i].index = i;
 		queue_work(recv_workqueue, &args[i].work);
 	}
-	wait_event_interruptible(nbd->recv_wq,
-				 atomic_read(&nbd->recv_threads) == 0);
+	error = wait_event_interruptible(nbd->recv_wq,
+					 atomic_read(&nbd->recv_threads) == 0);
+	if (error)
+		sock_shutdown(nbd);
 	for (i = 0; i < num_connections; i++)
 		flush_work(&args[i].work);
-	nbd_dev_dbg_close(nbd);
-	nbd_size_clear(nbd, bdev);
-	device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
-out_recv:
 	mutex_lock(&nbd->config_lock);
-	nbd->task_recv = NULL;
-out_err:
-	clear_bit(NBD_RUNNING, &nbd->runtime_flags);
-	nbd_clear_sock(nbd, bdev);
-
+out:
 	/* user requested, ignore socket errors */
 	if (test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
 		error = 0;
 	if (test_bit(NBD_TIMEDOUT, &nbd->runtime_flags))
 		error = -ETIMEDOUT;
-
-	nbd_reset(nbd);
+	nbd_put(nbd);
 	return error;
 }
 
@@ -905,16 +953,21 @@ static int nbd_ioctl(struct block_device *bdev, fmode_t mode,
 {
 	struct nbd_device *nbd = bdev->bd_disk->private_data;
 	int error;
+	bool need_put = false;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	BUG_ON(nbd->magic != NBD_MAGIC);
 
+	/* This is to keep us from doing the final put under the config_lock. */
+	if (nbd_get_unless_zero(nbd))
+		need_put = true;
 	mutex_lock(&nbd->config_lock);
 	error = __nbd_ioctl(bdev, nbd, cmd, arg);
 	mutex_unlock(&nbd->config_lock);
-
+	if (need_put)
+		nbd_put(nbd);
 	return error;
 }
 
@@ -1141,12 +1194,15 @@ static int nbd_dev_add(int index)
 
 	nbd->magic = NBD_MAGIC;
 	mutex_init(&nbd->config_lock);
+	atomic_set(&nbd->refs, 0);
+	nbd->args = NULL;
 	disk->major = NBD_MAJOR;
 	disk->first_minor = index << part_shift;
 	disk->fops = &nbd_fops;
 	disk->private_data = nbd;
 	sprintf(disk->disk_name, "nbd%d", index);
 	init_waitqueue_head(&nbd->recv_wq);
+	init_waitqueue_head(&nbd->socks_wq);
 	nbd_reset(nbd);
 	add_disk(disk);
 	return index;
-- 
2.7.4
