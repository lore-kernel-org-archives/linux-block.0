Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 03/12] nbd: separate out the config information
Date: Thu,  6 Apr 2017 17:01:58 -0400
Message-Id: <1491512527-4286-4-git-send-email-jbacik@fb.com>
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

In order to properly refcount the various aspects of a NBD device we
need to separate out the configuration elements of the nbd device.  The
configuration of a NBD device has a different lifetime from the actual
device, so it doesn't make sense to bundle these two concepts.  Add a
config_refs to keep track of the configuration structure, that way we
can be sure that we never access it when we've torn down the device.
Add a new nbd_config structure to hold all of the transient
configuration information.  Finally create this when we open the device
so that it is in place when we start to configure the device.  This has
a nice side-effect of fixing a long standing problem where you could end
up with a half-configured nbd device that needed to be "disconnected" in
order to be usable again.  Now once we close our device the
configuration will be discarded.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 437 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 263 insertions(+), 174 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4e64d60..c2d9923 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -53,35 +53,45 @@ struct nbd_sock {
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
+#define NBD_HAS_PID_FILE		3
 
-struct nbd_device {
+struct nbd_config {
 	u32 flags;
 	unsigned long runtime_flags;
-	struct nbd_sock **socks;
-	int magic;
-
-	struct blk_mq_tag_set tag_set;
 
-	struct mutex config_lock;
-	struct gendisk *disk;
+	struct nbd_sock **socks;
 	int num_connections;
+
 	atomic_t recv_threads;
 	wait_queue_head_t recv_wq;
 	loff_t blksize;
 	loff_t bytesize;
-
-	struct task_struct *task_recv;
-	struct task_struct *task_setup;
-
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *dbg_dir;
 #endif
 };
 
+struct nbd_device {
+	struct blk_mq_tag_set tag_set;
+
+	refcount_t config_refs;
+	struct nbd_config *config;
+	struct mutex config_lock;
+	struct gendisk *disk;
+
+	struct task_struct *task_recv;
+	struct task_struct *task_setup;
+};
+
 struct nbd_cmd {
 	struct nbd_device *nbd;
 	int index;
@@ -103,7 +113,7 @@ static int part_shift;
 
 static int nbd_dev_dbg_init(struct nbd_device *nbd);
 static void nbd_dev_dbg_close(struct nbd_device *nbd);
-
+static void nbd_config_put(struct nbd_device *nbd);
 
 static inline struct device *nbd_to_dev(struct nbd_device *nbd)
 {
@@ -127,6 +137,20 @@ static const char *nbdcmd_to_ascii(int cmd)
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
 static void nbd_mark_nsock_dead(struct nbd_sock *nsock)
 {
 	if (!nsock->dead)
@@ -138,28 +162,32 @@ static void nbd_mark_nsock_dead(struct nbd_sock *nsock)
 
 static int nbd_size_clear(struct nbd_device *nbd, struct block_device *bdev)
 {
-	if (bdev->bd_openers <= 1)
-		bd_set_size(bdev, 0);
-	set_capacity(nbd->disk, 0);
-	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
+	if (nbd->config->bytesize) {
+		if (bdev->bd_openers <= 1)
+			bd_set_size(bdev, 0);
+		set_capacity(nbd->disk, 0);
+		kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
+	}
 
 	return 0;
 }
 
 static void nbd_size_update(struct nbd_device *nbd, struct block_device *bdev)
 {
-	blk_queue_logical_block_size(nbd->disk->queue, nbd->blksize);
-	blk_queue_physical_block_size(nbd->disk->queue, nbd->blksize);
-	bd_set_size(bdev, nbd->bytesize);
-	set_capacity(nbd->disk, nbd->bytesize >> 9);
+	struct nbd_config *config = nbd->config;
+	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
+	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
+	bd_set_size(bdev, config->bytesize);
+	set_capacity(nbd->disk, config->bytesize >> 9);
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 }
 
 static void nbd_size_set(struct nbd_device *nbd, struct block_device *bdev,
 			loff_t blocksize, loff_t nr_blocks)
 {
-	nbd->blksize = blocksize;
-	nbd->bytesize = blocksize * nr_blocks;
+	struct nbd_config *config = nbd->config;
+	config->blksize = blocksize;
+	config->bytesize = blocksize * nr_blocks;
 	if (nbd_is_connected(nbd))
 		nbd_size_update(nbd, bdev);
 }
@@ -181,17 +209,19 @@ static void nbd_end_request(struct nbd_cmd *cmd)
  */
 static void sock_shutdown(struct nbd_device *nbd)
 {
+	struct nbd_config *config = nbd->config;
 	int i;
 
-	if (nbd->num_connections == 0)
+	if (config->num_connections == 0)
 		return;
-	if (test_and_set_bit(NBD_DISCONNECTED, &nbd->runtime_flags))
+	if (test_and_set_bit(NBD_DISCONNECTED, &config->runtime_flags))
 		return;
 
-	for (i = 0; i < nbd->num_connections; i++) {
-		struct nbd_sock *nsock = nbd->socks[i];
+	for (i = 0; i < config->num_connections; i++) {
+		struct nbd_sock *nsock = config->socks[i];
 		mutex_lock(&nsock->tx_lock);
 		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
+		nbd_mark_nsock_dead(nsock);
 		mutex_unlock(&nsock->tx_lock);
 	}
 	dev_warn(disk_to_dev(nbd->disk), "shutting down sockets\n");
@@ -202,38 +232,43 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 	struct nbd_device *nbd = cmd->nbd;
+	struct nbd_config *config;
+
+	if (!refcount_inc_not_zero(&nbd->config_refs)) {
+		req->errors = -EIO;
+		return BLK_EH_HANDLED;
+	}
 
-	if (nbd->num_connections > 1) {
+	config = nbd->config;
+
+	if (config->num_connections > 1) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out, retrying\n");
-		mutex_lock(&nbd->config_lock);
 		/*
 		 * Hooray we have more connections, requeue this IO, the submit
 		 * path will put it on a real connection.
 		 */
-		if (nbd->socks && nbd->num_connections > 1) {
-			if (cmd->index < nbd->num_connections) {
+		if (config->socks && config->num_connections > 1) {
+			if (cmd->index < config->num_connections) {
 				struct nbd_sock *nsock =
-					nbd->socks[cmd->index];
+					config->socks[cmd->index];
 				mutex_lock(&nsock->tx_lock);
 				nbd_mark_nsock_dead(nsock);
 				mutex_unlock(&nsock->tx_lock);
 			}
-			mutex_unlock(&nbd->config_lock);
 			blk_mq_requeue_request(req, true);
+			nbd_config_put(nbd);
 			return BLK_EH_NOT_HANDLED;
 		}
-		mutex_unlock(&nbd->config_lock);
 	} else {
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out\n");
 	}
-	set_bit(NBD_TIMEDOUT, &nbd->runtime_flags);
+	set_bit(NBD_TIMEDOUT, &config->runtime_flags);
 	req->errors = -EIO;
-
-	mutex_lock(&nbd->config_lock);
 	sock_shutdown(nbd);
-	mutex_unlock(&nbd->config_lock);
+	nbd_config_put(nbd);
+
 	return BLK_EH_HANDLED;
 }
 
@@ -243,7 +278,8 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 static int sock_xmit(struct nbd_device *nbd, int index, int send,
 		     struct iov_iter *iter, int msg_flags, int *sent)
 {
-	struct socket *sock = nbd->socks[index]->sock;
+	struct nbd_config *config = nbd->config;
+	struct socket *sock = config->socks[index]->sock;
 	int result;
 	struct msghdr msg;
 	unsigned long pflags = current->flags;
@@ -289,7 +325,8 @@ static int sock_xmit(struct nbd_device *nbd, int index, int send,
 static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
-	struct nbd_sock *nsock = nbd->socks[index];
+	struct nbd_config *config = nbd->config;
+	struct nbd_sock *nsock = config->socks[index];
 	int result;
 	struct nbd_request request = {.magic = htonl(NBD_REQUEST_MAGIC)};
 	struct kvec iov = {.iov_base = &request, .iov_len = sizeof(request)};
@@ -320,7 +357,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	}
 
 	if (rq_data_dir(req) == WRITE &&
-	    (nbd->flags & NBD_FLAG_READ_ONLY)) {
+	    (config->flags & NBD_FLAG_READ_ONLY)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Write on read-only\n");
 		return -EIO;
@@ -426,15 +463,16 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	return 0;
 }
 
-static int nbd_disconnected(struct nbd_device *nbd)
+static int nbd_disconnected(struct nbd_config *config)
 {
-	return test_bit(NBD_DISCONNECTED, &nbd->runtime_flags) ||
-		test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags);
+	return test_bit(NBD_DISCONNECTED, &config->runtime_flags) ||
+		test_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags);
 }
 
 /* NULL returned = something went wrong, inform userspace */
 static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 {
+	struct nbd_config *config = nbd->config;
 	int result;
 	struct nbd_reply reply;
 	struct nbd_cmd *cmd;
@@ -448,7 +486,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	iov_iter_kvec(&to, READ | ITER_KVEC, &iov, 1, sizeof(reply));
 	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 	if (result <= 0) {
-		if (!nbd_disconnected(nbd))
+		if (!nbd_disconnected(config))
 			dev_err(disk_to_dev(nbd->disk),
 				"Receive control failed (result %d)\n", result);
 		return ERR_PTR(result);
@@ -498,8 +536,8 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 				 * and let the timeout stuff handle resubmitting
 				 * this request onto another connection.
 				 */
-				if (nbd_disconnected(nbd) ||
-				    nbd->num_connections <= 1) {
+				if (nbd_disconnected(config) ||
+				    config->num_connections <= 1) {
 					req->errors = -EIO;
 					return cmd;
 				}
@@ -515,40 +553,20 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
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
 						     struct recv_thread_args,
 						     work);
 	struct nbd_device *nbd = args->nbd;
+	struct nbd_config *config = nbd->config;
 	struct nbd_cmd *cmd;
 	int ret = 0;
 
-	BUG_ON(nbd->magic != NBD_MAGIC);
 	while (1) {
 		cmd = nbd_read_stat(nbd, args->index);
 		if (IS_ERR(cmd)) {
-			struct nbd_sock *nsock = nbd->socks[args->index];
+			struct nbd_sock *nsock = config->socks[args->index];
 
 			mutex_lock(&nsock->tx_lock);
 			nbd_mark_nsock_dead(nsock);
@@ -559,8 +577,10 @@ static void recv_work(struct work_struct *work)
 
 		nbd_end_request(cmd);
 	}
-	atomic_dec(&nbd->recv_threads);
-	wake_up(&nbd->recv_wq);
+	atomic_dec(&config->recv_threads);
+	wake_up(&config->recv_wq);
+	nbd_config_put(nbd);
+	kfree(args);
 }
 
 static void nbd_clear_req(struct request *req, void *data, bool reserved)
@@ -576,39 +596,38 @@ static void nbd_clear_req(struct request *req, void *data, bool reserved)
 
 static void nbd_clear_que(struct nbd_device *nbd)
 {
-	BUG_ON(nbd->magic != NBD_MAGIC);
-
 	blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_clear_req, NULL);
 	dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
 }
 
 static int find_fallback(struct nbd_device *nbd, int index)
 {
+	struct nbd_config *config = nbd->config;
 	int new_index = -1;
-	struct nbd_sock *nsock = nbd->socks[index];
+	struct nbd_sock *nsock = config->socks[index];
 	int fallback = nsock->fallback_index;
 
-	if (test_bit(NBD_DISCONNECTED, &nbd->runtime_flags))
+	if (test_bit(NBD_DISCONNECTED, &config->runtime_flags))
 		return new_index;
 
-	if (nbd->num_connections <= 1) {
+	if (config->num_connections <= 1) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
 		return new_index;
 	}
 
-	if (fallback >= 0 && fallback < nbd->num_connections &&
-	    !nbd->socks[fallback]->dead)
+	if (fallback >= 0 && fallback < config->num_connections &&
+	    !config->socks[fallback]->dead)
 		return fallback;
 
 	if (nsock->fallback_index < 0 ||
-	    nsock->fallback_index >= nbd->num_connections ||
-	    nbd->socks[nsock->fallback_index]->dead) {
+	    nsock->fallback_index >= config->num_connections ||
+	    config->socks[nsock->fallback_index]->dead) {
 		int i;
-		for (i = 0; i < nbd->num_connections; i++) {
+		for (i = 0; i < config->num_connections; i++) {
 			if (i == index)
 				continue;
-			if (!nbd->socks[i]->dead) {
+			if (!config->socks[i]->dead) {
 				new_index = i;
 				break;
 			}
@@ -628,23 +647,34 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
 	struct nbd_device *nbd = cmd->nbd;
+	struct nbd_config *config;
 	struct nbd_sock *nsock;
 	int ret;
 
-	if (index >= nbd->num_connections) {
+	if (!refcount_inc_not_zero(&nbd->config_refs)) {
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Socks array is empty\n");
+		return -EINVAL;
+	}
+	config = nbd->config;
+
+	if (index >= config->num_connections) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
+		nbd_config_put(nbd);
 		return -EINVAL;
 	}
 	req->errors = 0;
 again:
-	nsock = nbd->socks[index];
+	nsock = config->socks[index];
 	mutex_lock(&nsock->tx_lock);
 	if (nsock->dead) {
 		index = find_fallback(nbd, index);
+		if (index < 0) {
+			ret = -EIO;
+			goto out;
+		}
 		mutex_unlock(&nsock->tx_lock);
-		if (index < 0)
-			return -EIO;
 		goto again;
 	}
 
@@ -672,6 +702,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	}
 out:
 	mutex_unlock(&nsock->tx_lock);
+	nbd_config_put(nbd);
 	return ret;
 }
 
@@ -711,6 +742,7 @@ static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 			  unsigned long arg)
 {
+	struct nbd_config *config = nbd->config;
 	struct socket *sock;
 	struct nbd_sock **socks;
 	struct nbd_sock *nsock;
@@ -729,7 +761,7 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 		return -EINVAL;
 	}
 
-	socks = krealloc(nbd->socks, (nbd->num_connections + 1) *
+	socks = krealloc(config->socks, (config->num_connections + 1) *
 			 sizeof(struct nbd_sock *), GFP_KERNEL);
 	if (!socks) {
 		sockfd_put(sock);
@@ -741,7 +773,7 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 		return -ENOMEM;
 	}
 
-	nbd->socks = socks;
+	config->socks = socks;
 
 	nsock->fallback_index = -1;
 	nsock->dead = false;
@@ -749,7 +781,7 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 	nsock->sock = sock;
 	nsock->pending = NULL;
 	nsock->sent = 0;
-	socks[nbd->num_connections++] = nsock;
+	socks[config->num_connections++] = nsock;
 
 	if (max_part)
 		bdev->bd_invalidated = 1;
@@ -759,11 +791,7 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 /* Reset all properties of an NBD device */
 static void nbd_reset(struct nbd_device *nbd)
 {
-	nbd->runtime_flags = 0;
-	nbd->blksize = 1024;
-	nbd->bytesize = 0;
-	set_capacity(nbd->disk, 0);
-	nbd->flags = 0;
+	nbd->config = NULL;
 	nbd->tag_set.timeout = 0;
 	queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, nbd->disk->queue);
 }
@@ -782,11 +810,12 @@ static void nbd_bdev_reset(struct block_device *bdev)
 
 static void nbd_parse_flags(struct nbd_device *nbd, struct block_device *bdev)
 {
-	if (nbd->flags & NBD_FLAG_READ_ONLY)
+	struct nbd_config *config = nbd->config;
+	if (config->flags & NBD_FLAG_READ_ONLY)
 		set_device_ro(bdev, true);
-	if (nbd->flags & NBD_FLAG_SEND_TRIM)
+	if (config->flags & NBD_FLAG_SEND_TRIM)
 		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, nbd->disk->queue);
-	if (nbd->flags & NBD_FLAG_SEND_FLUSH)
+	if (config->flags & NBD_FLAG_SEND_FLUSH)
 		blk_queue_write_cache(nbd->disk->queue, true, false);
 	else
 		blk_queue_write_cache(nbd->disk->queue, false, false);
@@ -794,6 +823,7 @@ static void nbd_parse_flags(struct nbd_device *nbd, struct block_device *bdev)
 
 static void send_disconnects(struct nbd_device *nbd)
 {
+	struct nbd_config *config = nbd->config;
 	struct nbd_request request = {
 		.magic = htonl(NBD_REQUEST_MAGIC),
 		.type = htonl(NBD_CMD_DISC),
@@ -802,7 +832,7 @@ static void send_disconnects(struct nbd_device *nbd)
 	struct iov_iter from;
 	int i, ret;
 
-	for (i = 0; i < nbd->num_connections; i++) {
+	for (i = 0; i < config->num_connections; i++) {
 		iov_iter_kvec(&from, WRITE | ITER_KVEC, &iov, 1, sizeof(request));
 		ret = sock_xmit(nbd, i, 1, &from, 0, NULL);
 		if (ret <= 0)
@@ -813,20 +843,15 @@ static void send_disconnects(struct nbd_device *nbd)
 
 static int nbd_disconnect(struct nbd_device *nbd, struct block_device *bdev)
 {
-	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
-	if (!nbd->socks)
-		return -EINVAL;
+	struct nbd_config *config = nbd->config;
 
+	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
 	mutex_unlock(&nbd->config_lock);
 	fsync_bdev(bdev);
 	mutex_lock(&nbd->config_lock);
 
-	/* Check again after getting mutex back.  */
-	if (!nbd->socks)
-		return -EINVAL;
-
 	if (!test_and_set_bit(NBD_DISCONNECT_REQUESTED,
-			      &nbd->runtime_flags))
+			      &config->runtime_flags))
 		send_disconnects(nbd);
 	return 0;
 }
@@ -838,51 +863,63 @@ static int nbd_clear_sock(struct nbd_device *nbd, struct block_device *bdev)
 
 	__invalidate_device(bdev, true);
 	nbd_bdev_reset(bdev);
-	/*
-	 * We want to give the run thread a chance to wait for everybody
-	 * to clean up and then do it's own cleanup.
-	 */
-	if (!test_bit(NBD_RUNNING, &nbd->runtime_flags) &&
-	    nbd->num_connections) {
-		int i;
+	nbd->task_setup = NULL;
+	return 0;
+}
+
+static void nbd_config_put(struct nbd_device *nbd)
+{
+	if (refcount_dec_and_mutex_lock(&nbd->config_refs,
+					&nbd->config_lock)) {
+		struct block_device *bdev;
+		struct nbd_config *config = nbd->config;
 
-		for (i = 0; i < nbd->num_connections; i++) {
-			sockfd_put(nbd->socks[i]->sock);
-			kfree(nbd->socks[i]);
+		bdev = bdget_disk(nbd->disk, 0);
+		if (!bdev) {
+			mutex_unlock(&nbd->config_lock);
+			return;
 		}
-		kfree(nbd->socks);
-		nbd->socks = NULL;
-		nbd->num_connections = 0;
-	}
-	nbd->task_setup = NULL;
 
-	return 0;
+		nbd_dev_dbg_close(nbd);
+		nbd_size_clear(nbd, bdev);
+		if (test_and_clear_bit(NBD_HAS_PID_FILE,
+				       &config->runtime_flags))
+			device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
+		nbd->task_recv = NULL;
+		nbd_clear_sock(nbd, bdev);
+		if (config->num_connections) {
+			int i;
+			for (i = 0; i < config->num_connections; i++) {
+				sockfd_put(config->socks[i]->sock);
+				kfree(config->socks[i]);
+			}
+			kfree(config->socks);
+		}
+		nbd_reset(nbd);
+		mutex_unlock(&nbd->config_lock);
+		bdput(bdev);
+		module_put(THIS_MODULE);
+	}
 }
 
 static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 {
-	struct recv_thread_args *args;
-	int num_connections = nbd->num_connections;
+	struct nbd_config *config = nbd->config;
+	int num_connections = config->num_connections;
 	int error = 0, i;
 
 	if (nbd->task_recv)
 		return -EBUSY;
-	if (!nbd->socks)
+	if (!config->socks)
 		return -EINVAL;
+
 	if (num_connections > 1 &&
-	    !(nbd->flags & NBD_FLAG_CAN_MULTI_CONN)) {
+	    !(config->flags & NBD_FLAG_CAN_MULTI_CONN)) {
 		dev_err(disk_to_dev(nbd->disk), "server does not support multiple connections per device.\n");
-		error = -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 
-	set_bit(NBD_RUNNING, &nbd->runtime_flags);
-	blk_mq_update_nr_hw_queues(&nbd->tag_set, nbd->num_connections);
-	args = kcalloc(num_connections, sizeof(*args), GFP_KERNEL);
-	if (!args) {
-		error = -ENOMEM;
-		goto out_err;
-	}
+	blk_mq_update_nr_hw_queues(&nbd->tag_set, config->num_connections);
 	nbd->task_recv = current;
 	mutex_unlock(&nbd->config_lock);
 
@@ -891,41 +928,40 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 	error = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
 	if (error) {
 		dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
-		goto out_recv;
+		return error;
 	}
+	set_bit(NBD_HAS_PID_FILE, &config->runtime_flags);
 
 	nbd_size_update(nbd, bdev);
 
 	nbd_dev_dbg_init(nbd);
 	for (i = 0; i < num_connections; i++) {
-		sk_set_memalloc(nbd->socks[i]->sock->sk);
-		atomic_inc(&nbd->recv_threads);
-		INIT_WORK(&args[i].work, recv_work);
-		args[i].nbd = nbd;
-		args[i].index = i;
-		queue_work(recv_workqueue, &args[i].work);
+		struct recv_thread_args *args;
+
+		args = kzalloc(sizeof(*args), GFP_KERNEL);
+		if (!args) {
+			sock_shutdown(nbd);
+			return -ENOMEM;
+		}
+		sk_set_memalloc(config->socks[i]->sock->sk);
+		atomic_inc(&config->recv_threads);
+		refcount_inc(&nbd->config_refs);
+		INIT_WORK(&args->work, recv_work);
+		args->nbd = nbd;
+		args->index = i;
+		queue_work(recv_workqueue, &args->work);
 	}
-	wait_event_interruptible(nbd->recv_wq,
-				 atomic_read(&nbd->recv_threads) == 0);
-	for (i = 0; i < num_connections; i++)
-		flush_work(&args[i].work);
-	nbd_dev_dbg_close(nbd);
-	nbd_size_clear(nbd, bdev);
-	device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
-out_recv:
+	error = wait_event_interruptible(config->recv_wq,
+					 atomic_read(&config->recv_threads) == 0);
+	if (error)
+		sock_shutdown(nbd);
 	mutex_lock(&nbd->config_lock);
-	nbd->task_recv = NULL;
-out_err:
-	clear_bit(NBD_RUNNING, &nbd->runtime_flags);
-	nbd_clear_sock(nbd, bdev);
 
 	/* user requested, ignore socket errors */
-	if (test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
+	if (test_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags))
 		error = 0;
-	if (test_bit(NBD_TIMEDOUT, &nbd->runtime_flags))
+	if (test_bit(NBD_TIMEDOUT, &config->runtime_flags))
 		error = -ETIMEDOUT;
-
-	nbd_reset(nbd);
 	return error;
 }
 
@@ -933,6 +969,8 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		       unsigned int cmd, unsigned long arg)
 {
+	struct nbd_config *config = nbd->config;
+
 	switch (cmd) {
 	case NBD_DISCONNECT:
 		return nbd_disconnect(nbd, bdev);
@@ -942,14 +980,14 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		return nbd_add_socket(nbd, bdev, arg);
 	case NBD_SET_BLKSIZE:
 		nbd_size_set(nbd, bdev, arg,
-			     div_s64(nbd->bytesize, arg));
+			     div_s64(config->bytesize, arg));
 		return 0;
 	case NBD_SET_SIZE:
-		nbd_size_set(nbd, bdev, nbd->blksize,
-			     div_s64(arg, nbd->blksize));
+		nbd_size_set(nbd, bdev, config->blksize,
+			     div_s64(arg, config->blksize));
 		return 0;
 	case NBD_SET_SIZE_BLOCKS:
-		nbd_size_set(nbd, bdev, nbd->blksize, arg);
+		nbd_size_set(nbd, bdev, config->blksize, arg);
 		return 0;
 	case NBD_SET_TIMEOUT:
 		if (arg) {
@@ -959,7 +997,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		return 0;
 
 	case NBD_SET_FLAGS:
-		nbd->flags = arg;
+		config->flags = arg;
 		return 0;
 	case NBD_DO_IT:
 		return nbd_start_device(nbd, bdev);
@@ -988,18 +1026,70 @@ static int nbd_ioctl(struct block_device *bdev, fmode_t mode,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	BUG_ON(nbd->magic != NBD_MAGIC);
-
 	mutex_lock(&nbd->config_lock);
 	error = __nbd_ioctl(bdev, nbd, cmd, arg);
 	mutex_unlock(&nbd->config_lock);
-
 	return error;
 }
 
+static struct nbd_config *nbd_alloc_config(void)
+{
+	struct nbd_config *config;
+
+	config = kzalloc(sizeof(struct nbd_config), GFP_NOFS);
+	if (!config)
+		return NULL;
+	atomic_set(&config->recv_threads, 0);
+	init_waitqueue_head(&config->recv_wq);
+	config->blksize = 1024;
+	try_module_get(THIS_MODULE);
+	return config;
+}
+
+static int nbd_open(struct block_device *bdev, fmode_t mode)
+{
+	struct nbd_device *nbd;
+	int ret = 0;
+
+	mutex_lock(&nbd_index_mutex);
+	nbd = bdev->bd_disk->private_data;
+	if (!nbd) {
+		ret = -ENXIO;
+		goto out;
+	}
+	if (!refcount_inc_not_zero(&nbd->config_refs)) {
+		struct nbd_config *config;
+
+		mutex_lock(&nbd->config_lock);
+		if (refcount_inc_not_zero(&nbd->config_refs)) {
+			mutex_unlock(&nbd->config_lock);
+			goto out;
+		}
+		config = nbd->config = nbd_alloc_config();
+		if (!config) {
+			ret = -ENOMEM;
+			mutex_unlock(&nbd->config_lock);
+			goto out;
+		}
+		refcount_set(&nbd->config_refs, 1);
+		mutex_unlock(&nbd->config_lock);
+	}
+out:
+	mutex_unlock(&nbd_index_mutex);
+	return ret;
+}
+
+static void nbd_release(struct gendisk *disk, fmode_t mode)
+{
+	struct nbd_device *nbd = disk->private_data;
+	nbd_config_put(nbd);
+}
+
 static const struct block_device_operations nbd_fops =
 {
 	.owner =	THIS_MODULE,
+	.open =		nbd_open,
+	.release =	nbd_release,
 	.ioctl =	nbd_ioctl,
 	.compat_ioctl =	nbd_ioctl,
 };
@@ -1031,7 +1121,7 @@ static const struct file_operations nbd_dbg_tasks_ops = {
 static int nbd_dbg_flags_show(struct seq_file *s, void *unused)
 {
 	struct nbd_device *nbd = s->private;
-	u32 flags = nbd->flags;
+	u32 flags = nbd->config->flags;
 
 	seq_printf(s, "Hex: 0x%08x\n\n", flags);
 
@@ -1064,6 +1154,7 @@ static const struct file_operations nbd_dbg_flags_ops = {
 static int nbd_dev_dbg_init(struct nbd_device *nbd)
 {
 	struct dentry *dir;
+	struct nbd_config *config = nbd->config;
 
 	if (!nbd_dbg_dir)
 		return -EIO;
@@ -1074,12 +1165,12 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 			nbd_name(nbd));
 		return -EIO;
 	}
-	nbd->dbg_dir = dir;
+	config->dbg_dir = dir;
 
 	debugfs_create_file("tasks", 0444, dir, nbd, &nbd_dbg_tasks_ops);
-	debugfs_create_u64("size_bytes", 0444, dir, &nbd->bytesize);
+	debugfs_create_u64("size_bytes", 0444, dir, &config->bytesize);
 	debugfs_create_u32("timeout", 0444, dir, &nbd->tag_set.timeout);
-	debugfs_create_u64("blocksize", 0444, dir, &nbd->blksize);
+	debugfs_create_u64("blocksize", 0444, dir, &config->blksize);
 	debugfs_create_file("flags", 0444, dir, nbd, &nbd_dbg_flags_ops);
 
 	return 0;
@@ -1087,7 +1178,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 
 static void nbd_dev_dbg_close(struct nbd_device *nbd)
 {
-	debugfs_remove_recursive(nbd->dbg_dir);
+	debugfs_remove_recursive(nbd->config->dbg_dir);
 }
 
 static int nbd_dbg_init(void)
@@ -1148,7 +1239,6 @@ static const struct blk_mq_ops nbd_mq_ops = {
 static void nbd_dev_remove(struct nbd_device *nbd)
 {
 	struct gendisk *disk = nbd->disk;
-	nbd->magic = 0;
 	if (disk) {
 		del_gendisk(disk);
 		blk_cleanup_queue(disk->queue);
@@ -1218,14 +1308,13 @@ static int nbd_dev_add(int index)
 	blk_queue_max_hw_sectors(disk->queue, 65536);
 	disk->queue->limits.max_sectors = 256;
 
-	nbd->magic = NBD_MAGIC;
 	mutex_init(&nbd->config_lock);
+	refcount_set(&nbd->config_refs, 0);
 	disk->major = NBD_MAJOR;
 	disk->first_minor = index << part_shift;
 	disk->fops = &nbd_fops;
 	disk->private_data = nbd;
 	sprintf(disk->disk_name, "nbd%d", index);
-	init_waitqueue_head(&nbd->recv_wq);
 	nbd_reset(nbd);
 	add_disk(disk);
 	return index;
-- 
2.7.4
