Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56766 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752395AbcIOOpE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 10:45:04 -0400
From: Josef Bacik <jbacik@fb.com>
To: <axboe@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <nbd-general@lists.sourceforge.net>, <w@uter.be>,
        <hch@infradead.org>
Subject: [PATCH][V2] nbd: add multi-connection support
Date: Thu, 15 Sep 2016 10:43:54 -0400
Message-ID: <1473950634-4299-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

NBD can become contended on its single connection.  We have to serialize all
writes and we can only process one read response at a time.  Fix this by
allowing userspace to provide multiple connections to a single nbd device.  This
coupled with block-mq drastically increases performance in multi-process cases.
Thanks,

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
V1->V2:
-Dropped the index from nbd_cmd and just used the hctx->queue_num as HCH
 suggested
-Added the pid attribute back to the /sys/block/nbd*/ directory for the recv
 pid.
-Reworked the disconnect to simply send the command on all connections instead
 of sending a special command through the block layer.
-Fixed some of the disconnect handling to be less verbose when we specifically
 request a disconnect.

 drivers/block/nbd.c | 344 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 206 insertions(+), 138 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4c6dd1a..28e9b93 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -41,26 +41,36 @@
 
 #include <linux/nbd.h>
 
+struct nbd_sock {
+	struct socket *sock;
+	struct mutex tx_lock;
+};
+
 #define NBD_TIMEDOUT			0
 #define NBD_DISCONNECT_REQUESTED	1
+#define NBD_DISCONNECTED		2
+#define NBD_RUNNING			3
 
 struct nbd_device {
 	u32 flags;
 	unsigned long runtime_flags;
-	struct socket * sock;	/* If == NULL, device is not ready, yet	*/
+	struct nbd_sock **socks;
 	int magic;
 
 	struct blk_mq_tag_set tag_set;
 
-	struct mutex tx_lock;
+	struct mutex config_lock;
 	struct gendisk *disk;
+	int num_connections;
+	atomic_t recv_threads;
+	wait_queue_head_t recv_wq;
 	int blksize;
 	loff_t bytesize;
 
 	/* protects initialization and shutdown of the socket */
 	spinlock_t sock_lock;
 	struct task_struct *task_recv;
-	struct task_struct *task_send;
+	struct task_struct *task_setup;
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *dbg_dir;
@@ -69,7 +79,6 @@ struct nbd_device {
 
 struct nbd_cmd {
 	struct nbd_device *nbd;
-	struct list_head list;
 };
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
@@ -159,22 +168,20 @@ static void nbd_end_request(struct nbd_cmd *cmd)
  */
 static void sock_shutdown(struct nbd_device *nbd)
 {
-	struct socket *sock;
-
-	spin_lock(&nbd->sock_lock);
+	int i;
 
-	if (!nbd->sock) {
-		spin_unlock_irq(&nbd->sock_lock);
+	if (nbd->num_connections == 0)
+		return;
+	if (test_and_set_bit(NBD_DISCONNECTED, &nbd->runtime_flags))
 		return;
-	}
-
-	sock = nbd->sock;
-	dev_warn(disk_to_dev(nbd->disk), "shutting down socket\n");
-	nbd->sock = NULL;
-	spin_unlock(&nbd->sock_lock);
 
-	kernel_sock_shutdown(sock, SHUT_RDWR);
-	sockfd_put(sock);
+	for (i = 0; i < nbd->num_connections; i++) {
+		struct nbd_sock *nsock = nbd->socks[i];
+		mutex_lock(&nsock->tx_lock);
+		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
+		mutex_unlock(&nsock->tx_lock);
+	}
+	dev_warn(disk_to_dev(nbd->disk), "shutting down sockets\n");
 }
 
 static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
@@ -182,35 +189,31 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 	struct nbd_device *nbd = cmd->nbd;
-	struct socket *sock = NULL;
-
-	spin_lock(&nbd->sock_lock);
 
+	dev_err(nbd_to_dev(nbd), "Connection timed out, shutting down connection\n");
 	set_bit(NBD_TIMEDOUT, &nbd->runtime_flags);
-
-	if (nbd->sock) {
-		sock = nbd->sock;
-		get_file(sock->file);
-	}
-
-	spin_unlock(&nbd->sock_lock);
-	if (sock) {
-		kernel_sock_shutdown(sock, SHUT_RDWR);
-		sockfd_put(sock);
-	}
-
 	req->errors++;
-	dev_err(nbd_to_dev(nbd), "Connection timed out, shutting down connection\n");
+
+	/*
+	 * If our disconnect packet times out then we're already holding the
+	 * config_lock and could deadlock here, so just set an error and return,
+	 * we'll handle shutting everything down later.
+	 */
+	if (req->cmd_type == REQ_TYPE_DRV_PRIV)
+		return BLK_EH_HANDLED;
+	mutex_lock(&nbd->config_lock);
+	sock_shutdown(nbd);
+	mutex_unlock(&nbd->config_lock);
 	return BLK_EH_HANDLED;
 }
 
 /*
  *  Send or receive packet.
  */
-static int sock_xmit(struct nbd_device *nbd, int send, void *buf, int size,
-		int msg_flags)
+static int sock_xmit(struct nbd_device *nbd, int index, int send, void *buf,
+		     int size, int msg_flags)
 {
-	struct socket *sock = nbd->sock;
+	struct socket *sock = nbd->socks[index]->sock;
 	int result;
 	struct msghdr msg;
 	struct kvec iov;
@@ -254,19 +257,19 @@ static int sock_xmit(struct nbd_device *nbd, int send, void *buf, int size,
 	return result;
 }
 
-static inline int sock_send_bvec(struct nbd_device *nbd, struct bio_vec *bvec,
-		int flags)
+static inline int sock_send_bvec(struct nbd_device *nbd, int index,
+				 struct bio_vec *bvec, int flags)
 {
 	int result;
 	void *kaddr = kmap(bvec->bv_page);
-	result = sock_xmit(nbd, 1, kaddr + bvec->bv_offset,
+	result = sock_xmit(nbd, index, 1, kaddr + bvec->bv_offset,
 			   bvec->bv_len, flags);
 	kunmap(bvec->bv_page);
 	return result;
 }
 
 /* always call with the tx_lock held */
-static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd)
+static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
 	int result, flags;
@@ -274,9 +277,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd)
 	unsigned long size = blk_rq_bytes(req);
 	u32 type;
 
-	if (req->cmd_type == REQ_TYPE_DRV_PRIV)
-		type = NBD_CMD_DISC;
-	else if (req_op(req) == REQ_OP_DISCARD)
+	if (req_op(req) == REQ_OP_DISCARD)
 		type = NBD_CMD_TRIM;
 	else if (req_op(req) == REQ_OP_FLUSH)
 		type = NBD_CMD_FLUSH;
@@ -288,7 +289,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd)
 	memset(&request, 0, sizeof(request));
 	request.magic = htonl(NBD_REQUEST_MAGIC);
 	request.type = htonl(type);
-	if (type != NBD_CMD_FLUSH && type != NBD_CMD_DISC) {
+	if (type != NBD_CMD_FLUSH) {
 		request.from = cpu_to_be64((u64)blk_rq_pos(req) << 9);
 		request.len = htonl(size);
 	}
@@ -297,7 +298,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd)
 	dev_dbg(nbd_to_dev(nbd), "request %p: sending control (%s@%llu,%uB)\n",
 		cmd, nbdcmd_to_ascii(type),
 		(unsigned long long)blk_rq_pos(req) << 9, blk_rq_bytes(req));
-	result = sock_xmit(nbd, 1, &request, sizeof(request),
+	result = sock_xmit(nbd, index, 1, &request, sizeof(request),
 			(type == NBD_CMD_WRITE) ? MSG_MORE : 0);
 	if (result <= 0) {
 		dev_err(disk_to_dev(nbd->disk),
@@ -318,7 +319,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd)
 				flags = MSG_MORE;
 			dev_dbg(nbd_to_dev(nbd), "request %p: sending %d bytes data\n",
 				cmd, bvec.bv_len);
-			result = sock_send_bvec(nbd, &bvec, flags);
+			result = sock_send_bvec(nbd, index, &bvec, flags);
 			if (result <= 0) {
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
@@ -330,18 +331,19 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd)
 	return 0;
 }
 
-static inline int sock_recv_bvec(struct nbd_device *nbd, struct bio_vec *bvec)
+static inline int sock_recv_bvec(struct nbd_device *nbd, int index,
+				 struct bio_vec *bvec)
 {
 	int result;
 	void *kaddr = kmap(bvec->bv_page);
-	result = sock_xmit(nbd, 0, kaddr + bvec->bv_offset, bvec->bv_len,
-			MSG_WAITALL);
+	result = sock_xmit(nbd, index, 0, kaddr + bvec->bv_offset,
+			   bvec->bv_len, MSG_WAITALL);
 	kunmap(bvec->bv_page);
 	return result;
 }
 
 /* NULL returned = something went wrong, inform userspace */
-static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd)
+static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 {
 	int result;
 	struct nbd_reply reply;
@@ -351,10 +353,12 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd)
 	int tag;
 
 	reply.magic = 0;
-	result = sock_xmit(nbd, 0, &reply, sizeof(reply), MSG_WAITALL);
+	result = sock_xmit(nbd, index, 0, &reply, sizeof(reply), MSG_WAITALL);
 	if (result <= 0) {
-		dev_err(disk_to_dev(nbd->disk),
-			"Receive control failed (result %d)\n", result);
+		if (!test_bit(NBD_DISCONNECTED, &nbd->runtime_flags) &&
+		    !test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
+			dev_err(disk_to_dev(nbd->disk),
+				"Receive control failed (result %d)\n", result);
 		return ERR_PTR(result);
 	}
 
@@ -390,7 +394,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd)
 		struct bio_vec bvec;
 
 		rq_for_each_segment(bvec, req, iter) {
-			result = sock_recv_bvec(nbd, &bvec);
+			result = sock_recv_bvec(nbd, index, &bvec);
 			if (result <= 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
 					result);
@@ -418,25 +422,24 @@ static struct device_attribute pid_attr = {
 	.show = pid_show,
 };
 
-static int nbd_thread_recv(struct nbd_device *nbd, struct block_device *bdev)
+struct recv_thread_args {
+	struct work_struct work;
+	struct nbd_device *nbd;
+	int index;
+};
+
+static void recv_work(struct work_struct *work)
 {
+	struct recv_thread_args *args = container_of(work,
+						     struct recv_thread_args,
+						     work);
+	struct nbd_device *nbd = args->nbd;
 	struct nbd_cmd *cmd;
-	int ret;
+	int ret = 0;
 
 	BUG_ON(nbd->magic != NBD_MAGIC);
-
-	sk_set_memalloc(nbd->sock->sk);
-
-	ret = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
-	if (ret) {
-		dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
-		return ret;
-	}
-
-	nbd_size_update(nbd, bdev);
-
 	while (1) {
-		cmd = nbd_read_stat(nbd);
+		cmd = nbd_read_stat(nbd, args->index);
 		if (IS_ERR(cmd)) {
 			ret = PTR_ERR(cmd);
 			break;
@@ -445,10 +448,14 @@ static int nbd_thread_recv(struct nbd_device *nbd, struct block_device *bdev)
 		nbd_end_request(cmd);
 	}
 
-	nbd_size_clear(nbd, bdev);
-
-	device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
-	return ret;
+	/*
+	 * We got an error, shut everybody down if this wasn't the result of a
+	 * disconnect request.
+	 */
+	if (ret && !test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
+		sock_shutdown(nbd);
+	atomic_dec(&nbd->recv_threads);
+	wake_up(&nbd->recv_wq);
 }
 
 static void nbd_clear_req(struct request *req, void *data, bool reserved)
@@ -466,26 +473,35 @@ static void nbd_clear_que(struct nbd_device *nbd)
 {
 	BUG_ON(nbd->magic != NBD_MAGIC);
 
-	/*
-	 * Because we have set nbd->sock to NULL under the tx_lock, all
-	 * modifications to the list must have completed by now.
-	 */
-	BUG_ON(nbd->sock);
-
 	blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_clear_req, NULL);
 	dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
 }
 
 
-static void nbd_handle_cmd(struct nbd_cmd *cmd)
+static void nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
 	struct nbd_device *nbd = cmd->nbd;
+	struct nbd_sock *nsock;
 
-	if (req->cmd_type != REQ_TYPE_FS)
+	if (index >= nbd->num_connections) {
+		dev_err(disk_to_dev(nbd->disk),
+			"Attempted send on invalid socket\n");
+		goto error_out;
+	}
+
+	if (test_bit(NBD_DISCONNECTED, &nbd->runtime_flags)) {
+		dev_err(disk_to_dev(nbd->disk),
+			"Attempted send on closed socket\n");
+		goto error_out;
+	}
+
+	if (req->cmd_type != REQ_TYPE_FS &&
+	    req->cmd_type != REQ_TYPE_DRV_PRIV)
 		goto error_out;
 
-	if (rq_data_dir(req) == WRITE &&
+	if (req->cmd_type == REQ_TYPE_FS &&
+	    rq_data_dir(req) == WRITE &&
 	    (nbd->flags & NBD_FLAG_READ_ONLY)) {
 		dev_err(disk_to_dev(nbd->disk),
 			"Write on read-only\n");
@@ -494,23 +510,22 @@ static void nbd_handle_cmd(struct nbd_cmd *cmd)
 
 	req->errors = 0;
 
-	mutex_lock(&nbd->tx_lock);
-	nbd->task_send = current;
-	if (unlikely(!nbd->sock)) {
-		mutex_unlock(&nbd->tx_lock);
+	nsock = nbd->socks[index];
+	mutex_lock(&nsock->tx_lock);
+	if (unlikely(!nsock->sock)) {
+		mutex_unlock(&nsock->tx_lock);
 		dev_err(disk_to_dev(nbd->disk),
 			"Attempted send on closed socket\n");
 		goto error_out;
 	}
 
-	if (nbd_send_cmd(nbd, cmd) != 0) {
+	if (nbd_send_cmd(nbd, cmd, index) != 0) {
 		dev_err(disk_to_dev(nbd->disk), "Request send failed\n");
 		req->errors++;
 		nbd_end_request(cmd);
 	}
 
-	nbd->task_send = NULL;
-	mutex_unlock(&nbd->tx_lock);
+	mutex_unlock(&nsock->tx_lock);
 
 	return;
 
@@ -525,38 +540,57 @@ static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
 
 	blk_mq_start_request(bd->rq);
-	nbd_handle_cmd(cmd);
+	nbd_handle_cmd(cmd, hctx->queue_num);
 	return BLK_MQ_RQ_QUEUE_OK;
 }
 
-static int nbd_set_socket(struct nbd_device *nbd, struct socket *sock)
+static int nbd_add_socket(struct nbd_device *nbd, struct socket *sock)
 {
-	int ret = 0;
-
-	spin_lock_irq(&nbd->sock_lock);
+	struct nbd_sock **socks;
+	struct nbd_sock *nsock;
 
-	if (nbd->sock) {
-		ret = -EBUSY;
-		goto out;
+	if (!nbd->task_setup)
+		nbd->task_setup = current;
+	if (nbd->task_setup != current) {
+		dev_err(disk_to_dev(nbd->disk),
+			"Device being setup by another task");
+		return -EINVAL;
 	}
 
-	nbd->sock = sock;
+	socks = krealloc(nbd->socks, (nbd->num_connections + 1) *
+			 sizeof(struct nbd_sock *), GFP_KERNEL);
+	if (!socks)
+		return -ENOMEM;
+	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
+	if (!nsock)
+		return -ENOMEM;
+
+	nbd->socks = socks;
 
-out:
-	spin_unlock_irq(&nbd->sock_lock);
+	mutex_init(&nsock->tx_lock);
+	nsock->sock = sock;
+	socks[nbd->num_connections++] = nsock;
 
-	return ret;
+	return 0;
 }
 
 /* Reset all properties of an NBD device */
 static void nbd_reset(struct nbd_device *nbd)
 {
+	int i;
+
+	for (i = 0; i < nbd->num_connections; i++)
+		kfree(nbd->socks[i]);
+	kfree(nbd->socks);
+	nbd->socks = NULL;
 	nbd->runtime_flags = 0;
 	nbd->blksize = 1024;
 	nbd->bytesize = 0;
 	set_capacity(nbd->disk, 0);
 	nbd->flags = 0;
 	nbd->tag_set.timeout = 0;
+	nbd->num_connections = 0;
+	nbd->task_setup = NULL;
 	queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, nbd->disk->queue);
 }
 
@@ -582,48 +616,60 @@ static void nbd_parse_flags(struct nbd_device *nbd, struct block_device *bdev)
 		blk_queue_write_cache(nbd->disk->queue, false, false);
 }
 
+static void send_disconnects(struct nbd_device *nbd)
+{
+	struct nbd_request request = {};
+	int i, ret;
+
+	request.magic = htonl(NBD_REQUEST_MAGIC);
+	request.type = htonl(NBD_CMD_DISC);
+
+	for (i = 0; i < nbd->num_connections; i++) {
+		ret = sock_xmit(nbd, i, 1, &request, sizeof(request), 0);
+		if (ret <= 0)
+			dev_err(disk_to_dev(nbd->disk),
+				"Send disconnect failed %d\n", ret);
+	}
+}
+
 static int nbd_dev_dbg_init(struct nbd_device *nbd);
 static void nbd_dev_dbg_close(struct nbd_device *nbd);
 
-/* Must be called with tx_lock held */
-
+/* Must be called with config_lock held */
 static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		       unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
 	case NBD_DISCONNECT: {
-		struct request *sreq;
-
 		dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
-		if (!nbd->sock)
+		if (!nbd->socks)
 			return -EINVAL;
 
-		sreq = blk_mq_alloc_request(bdev_get_queue(bdev), WRITE, 0);
-		if (!sreq)
-			return -ENOMEM;
-
-		mutex_unlock(&nbd->tx_lock);
+		mutex_unlock(&nbd->config_lock);
 		fsync_bdev(bdev);
-		mutex_lock(&nbd->tx_lock);
-		sreq->cmd_type = REQ_TYPE_DRV_PRIV;
+		mutex_lock(&nbd->config_lock);
 
 		/* Check again after getting mutex back.  */
-		if (!nbd->sock) {
-			blk_mq_free_request(sreq);
+		if (!nbd->socks)
 			return -EINVAL;
-		}
 
-		set_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags);
-
-		nbd_send_cmd(nbd, blk_mq_rq_to_pdu(sreq));
-		blk_mq_free_request(sreq);
+		if (!test_and_set_bit(NBD_DISCONNECT_REQUESTED,
+				      &nbd->runtime_flags))
+			send_disconnects(nbd);
 		return 0;
 	}
- 
+
 	case NBD_CLEAR_SOCK:
 		sock_shutdown(nbd);
 		nbd_clear_que(nbd);
 		kill_bdev(bdev);
+		nbd_bdev_reset(bdev);
+		/*
+		 * We want to let the run thread reset the nbd device so we
+		 * don't prematurely clear the runtime flags.
+		 */
+		if (!test_bit(NBD_RUNNING, &nbd->runtime_flags))
+			nbd_reset(nbd);
 		return 0;
 
 	case NBD_SET_SOCK: {
@@ -633,7 +679,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		if (!sock)
 			return err;
 
-		err = nbd_set_socket(nbd, sock);
+		err = nbd_add_socket(nbd, sock);
 		if (!err && max_part)
 			bdev->bd_invalidated = 1;
 
@@ -662,26 +708,53 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		return 0;
 
 	case NBD_DO_IT: {
-		int error;
+		struct recv_thread_args *args;
+		int num_connections = nbd->num_connections;
+		int error, i;
 
 		if (nbd->task_recv)
 			return -EBUSY;
-		if (!nbd->sock)
+		if (!nbd->socks)
 			return -EINVAL;
 
-		/* We have to claim the device under the lock */
+		set_bit(NBD_RUNNING, &nbd->runtime_flags);
+		blk_mq_update_nr_hw_queues(&nbd->tag_set, nbd->num_connections);
+		args = kcalloc(num_connections, sizeof(*args), GFP_KERNEL);
+		if (!args)
+			goto out_err;
 		nbd->task_recv = current;
-		mutex_unlock(&nbd->tx_lock);
+		mutex_unlock(&nbd->config_lock);
 
 		nbd_parse_flags(nbd, bdev);
 
+		error = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
+		if (error) {
+			dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
+			goto out_recv;
+		}
+
+		nbd_size_update(nbd, bdev);
+
 		nbd_dev_dbg_init(nbd);
-		error = nbd_thread_recv(nbd, bdev);
+		for (i = 0; i < num_connections; i++) {
+			sk_set_memalloc(nbd->socks[i]->sock->sk);
+			atomic_inc(&nbd->recv_threads);
+			INIT_WORK(&args[i].work, recv_work);
+			args[i].nbd = nbd;
+			args[i].index = i;
+			queue_work(system_long_wq, &args[i].work);
+		}
+		wait_event_interruptible(nbd->recv_wq,
+					 atomic_read(&nbd->recv_threads) == 0);
+		for (i = 0; i < num_connections; i++)
+			flush_work(&args[i].work);
 		nbd_dev_dbg_close(nbd);
-
-		mutex_lock(&nbd->tx_lock);
+		nbd_size_clear(nbd, bdev);
+		device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
+out_recv:
+		mutex_lock(&nbd->config_lock);
 		nbd->task_recv = NULL;
-
+out_err:
 		sock_shutdown(nbd);
 		nbd_clear_que(nbd);
 		kill_bdev(bdev);
@@ -694,7 +767,6 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 			error = -ETIMEDOUT;
 
 		nbd_reset(nbd);
-
 		return error;
 	}
 
@@ -726,9 +798,9 @@ static int nbd_ioctl(struct block_device *bdev, fmode_t mode,
 
 	BUG_ON(nbd->magic != NBD_MAGIC);
 
-	mutex_lock(&nbd->tx_lock);
+	mutex_lock(&nbd->config_lock);
 	error = __nbd_ioctl(bdev, nbd, cmd, arg);
-	mutex_unlock(&nbd->tx_lock);
+	mutex_unlock(&nbd->config_lock);
 
 	return error;
 }
@@ -748,8 +820,6 @@ static int nbd_dbg_tasks_show(struct seq_file *s, void *unused)
 
 	if (nbd->task_recv)
 		seq_printf(s, "recv: %d\n", task_pid_nr(nbd->task_recv));
-	if (nbd->task_send)
-		seq_printf(s, "send: %d\n", task_pid_nr(nbd->task_send));
 
 	return 0;
 }
@@ -873,9 +943,7 @@ static int nbd_init_request(void *data, struct request *rq,
 			    unsigned int numa_node)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(rq);
-
 	cmd->nbd = data;
-	INIT_LIST_HEAD(&cmd->list);
 	return 0;
 }
 
@@ -986,13 +1054,13 @@ static int __init nbd_init(void)
 	for (i = 0; i < nbds_max; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
 		nbd_dev[i].magic = NBD_MAGIC;
-		spin_lock_init(&nbd_dev[i].sock_lock);
-		mutex_init(&nbd_dev[i].tx_lock);
+		mutex_init(&nbd_dev[i].config_lock);
 		disk->major = NBD_MAJOR;
 		disk->first_minor = i << part_shift;
 		disk->fops = &nbd_fops;
 		disk->private_data = &nbd_dev[i];
 		sprintf(disk->disk_name, "nbd%d", i);
+		init_waitqueue_head(&nbd_dev[i].recv_wq);
 		nbd_reset(&nbd_dev[i]);
 		add_disk(disk);
 	}
-- 
2.7.4

