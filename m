Return-Path: <prvs=3211f4b139=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <kernel-team@fb.com>,
        <nbd-general@lists.sourceforge.net>, <axboe@kernel.dk>
Subject: [PATCH] nbd: cleanup ioctl handling
Date: Tue, 7 Feb 2017 17:10:22 -0500
Message-ID: <1486505422-2850-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Break the ioctl handling out into helper functions, some of these things
are getting pretty big and unwieldy.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 265 ++++++++++++++++++++++++++--------------------------
 1 file changed, 130 insertions(+), 135 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 164a548..1914ba2 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -99,6 +99,10 @@ static int max_part;
 static struct workqueue_struct *recv_workqueue;
 static int part_shift;
 
+static int nbd_dev_dbg_init(struct nbd_device *nbd);
+static void nbd_dev_dbg_close(struct nbd_device *nbd);
+
+
 static inline struct device *nbd_to_dev(struct nbd_device *nbd)
 {
 	return disk_to_dev(nbd->disk);
@@ -652,10 +656,17 @@ static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_MQ_RQ_QUEUE_OK;
 }
 
-static int nbd_add_socket(struct nbd_device *nbd, struct socket *sock)
+static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
+			  unsigned long arg)
 {
+	struct socket *sock;
 	struct nbd_sock **socks;
 	struct nbd_sock *nsock;
+	int err;
+
+	sock = sockfd_lookup(arg, &err);
+	if (!sock)
+		return err;
 
 	if (!nbd->task_setup)
 		nbd->task_setup = current;
@@ -681,26 +692,20 @@ static int nbd_add_socket(struct nbd_device *nbd, struct socket *sock)
 	nsock->sock = sock;
 	socks[nbd->num_connections++] = nsock;
 
+	if (max_part)
+		bdev->bd_invalidated = 1;
 	return 0;
 }
 
 /* Reset all properties of an NBD device */
 static void nbd_reset(struct nbd_device *nbd)
 {
-	int i;
-
-	for (i = 0; i < nbd->num_connections; i++)
-		kfree(nbd->socks[i]);
-	kfree(nbd->socks);
-	nbd->socks = NULL;
 	nbd->runtime_flags = 0;
 	nbd->blksize = 1024;
 	nbd->bytesize = 0;
 	set_capacity(nbd->disk, 0);
 	nbd->flags = 0;
 	nbd->tag_set.timeout = 0;
-	nbd->num_connections = 0;
-	nbd->task_setup = NULL;
 	queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, nbd->disk->queue);
 }
 
@@ -742,74 +747,135 @@ static void send_disconnects(struct nbd_device *nbd)
 	}
 }
 
-static int nbd_dev_dbg_init(struct nbd_device *nbd);
-static void nbd_dev_dbg_close(struct nbd_device *nbd);
-
-/* Must be called with config_lock held */
-static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
-		       unsigned int cmd, unsigned long arg)
+static int nbd_disconnect(struct nbd_device *nbd, struct block_device *bdev)
 {
-	switch (cmd) {
-	case NBD_DISCONNECT: {
-		dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
-		if (!nbd->socks)
-			return -EINVAL;
+	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
+	if (!nbd->socks)
+		return -EINVAL;
 
-		mutex_unlock(&nbd->config_lock);
-		fsync_bdev(bdev);
-		mutex_lock(&nbd->config_lock);
+	mutex_unlock(&nbd->config_lock);
+	fsync_bdev(bdev);
+	mutex_lock(&nbd->config_lock);
 
-		/* Check again after getting mutex back.  */
-		if (!nbd->socks)
-			return -EINVAL;
+	/* Check again after getting mutex back.  */
+	if (!nbd->socks)
+		return -EINVAL;
 
-		if (!test_and_set_bit(NBD_DISCONNECT_REQUESTED,
-				      &nbd->runtime_flags))
-			send_disconnects(nbd);
-		return 0;
+	if (!test_and_set_bit(NBD_DISCONNECT_REQUESTED,
+			      &nbd->runtime_flags))
+		send_disconnects(nbd);
+	return 0;
+}
+
+static int nbd_clear_sock(struct nbd_device *nbd, struct block_device *bdev)
+{
+	sock_shutdown(nbd);
+	nbd_clear_que(nbd);
+	kill_bdev(bdev);
+	nbd_bdev_reset(bdev);
+	/*
+	 * We want to give the run thread a chance to wait for everybody
+	 * to clean up and then do it's own cleanup.
+	 */
+	if (!test_bit(NBD_RUNNING, &nbd->runtime_flags) &&
+	    nbd->num_connections) {
+		int i;
+
+		for (i = 0; i < nbd->num_connections; i++)
+			kfree(nbd->socks[i]);
+		kfree(nbd->socks);
+		nbd->socks = NULL;
+		nbd->num_connections = 0;
 	}
+	nbd->task_setup = NULL;
 
-	case NBD_CLEAR_SOCK:
-		sock_shutdown(nbd);
-		nbd_clear_que(nbd);
-		kill_bdev(bdev);
-		nbd_bdev_reset(bdev);
-		/*
-		 * We want to give the run thread a chance to wait for everybody
-		 * to clean up and then do it's own cleanup.
-		 */
-		if (!test_bit(NBD_RUNNING, &nbd->runtime_flags)) {
-			int i;
-
-			for (i = 0; i < nbd->num_connections; i++)
-				kfree(nbd->socks[i]);
-			kfree(nbd->socks);
-			nbd->socks = NULL;
-			nbd->num_connections = 0;
-			nbd->task_setup = NULL;
-		}
-		return 0;
+	return 0;
+}
 
-	case NBD_SET_SOCK: {
-		int err;
-		struct socket *sock = sockfd_lookup(arg, &err);
+static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
+{
+	struct recv_thread_args *args;
+	int num_connections = nbd->num_connections;
+	int error = 0, i;
 
-		if (!sock)
-			return err;
+	if (nbd->task_recv)
+		return -EBUSY;
+	if (!nbd->socks)
+		return -EINVAL;
+	if (num_connections > 1 &&
+	    !(nbd->flags & NBD_FLAG_CAN_MULTI_CONN)) {
+		dev_err(disk_to_dev(nbd->disk), "server does not support multiple connections per device.\n");
+		error = -EINVAL;
+		goto out_err;
+	}
 
-		err = nbd_add_socket(nbd, sock);
-		if (!err && max_part)
-			bdev->bd_invalidated = 1;
+	set_bit(NBD_RUNNING, &nbd->runtime_flags);
+	blk_mq_update_nr_hw_queues(&nbd->tag_set, nbd->num_connections);
+	args = kcalloc(num_connections, sizeof(*args), GFP_KERNEL);
+	if (!args) {
+		error = -ENOMEM;
+		goto out_err;
+	}
+	nbd->task_recv = current;
+	mutex_unlock(&nbd->config_lock);
 
-		return err;
+	nbd_parse_flags(nbd, bdev);
+
+	error = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
+	if (error) {
+		dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
+		goto out_recv;
 	}
 
-	case NBD_SET_BLKSIZE: {
-		loff_t bsize = div_s64(nbd->bytesize, arg);
+	nbd_size_update(nbd, bdev);
 
-		return nbd_size_set(nbd, bdev, arg, bsize);
+	nbd_dev_dbg_init(nbd);
+	for (i = 0; i < num_connections; i++) {
+		sk_set_memalloc(nbd->socks[i]->sock->sk);
+		atomic_inc(&nbd->recv_threads);
+		INIT_WORK(&args[i].work, recv_work);
+		args[i].nbd = nbd;
+		args[i].index = i;
+		queue_work(recv_workqueue, &args[i].work);
 	}
+	wait_event_interruptible(nbd->recv_wq,
+				 atomic_read(&nbd->recv_threads) == 0);
+	for (i = 0; i < num_connections; i++)
+		flush_work(&args[i].work);
+	nbd_dev_dbg_close(nbd);
+	nbd_size_clear(nbd, bdev);
+	device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
+out_recv:
+	mutex_lock(&nbd->config_lock);
+	nbd->task_recv = NULL;
+out_err:
+	clear_bit(NBD_RUNNING, &nbd->runtime_flags);
+	nbd_clear_sock(nbd, bdev);
+
+	/* user requested, ignore socket errors */
+	if (test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
+		error = 0;
+	if (test_bit(NBD_TIMEDOUT, &nbd->runtime_flags))
+		error = -ETIMEDOUT;
+
+	nbd_reset(nbd);
+	return error;
+}
 
+/* Must be called with config_lock held */
+static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
+		       unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case NBD_DISCONNECT:
+		return nbd_disconnect(nbd, bdev);
+	case NBD_CLEAR_SOCK:
+		return nbd_clear_sock(nbd, bdev);
+	case NBD_SET_SOCK:
+		return nbd_add_socket(nbd, bdev, arg);
+	case NBD_SET_BLKSIZE:
+		return nbd_size_set(nbd, bdev, arg,
+				    div_s64(nbd->bytesize, arg));
 	case NBD_SET_SIZE:
 		return nbd_size_set(nbd, bdev, nbd->blksize,
 					div_s64(arg, nbd->blksize));
@@ -824,85 +890,14 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 	case NBD_SET_FLAGS:
 		nbd->flags = arg;
 		return 0;
-
-	case NBD_DO_IT: {
-		struct recv_thread_args *args;
-		int num_connections = nbd->num_connections;
-		int error = 0, i;
-
-		if (nbd->task_recv)
-			return -EBUSY;
-		if (!nbd->socks)
-			return -EINVAL;
-		if (num_connections > 1 &&
-		    !(nbd->flags & NBD_FLAG_CAN_MULTI_CONN)) {
-			dev_err(disk_to_dev(nbd->disk), "server does not support multiple connections per device.\n");
-			error = -EINVAL;
-			goto out_err;
-		}
-
-		set_bit(NBD_RUNNING, &nbd->runtime_flags);
-		blk_mq_update_nr_hw_queues(&nbd->tag_set, nbd->num_connections);
-		args = kcalloc(num_connections, sizeof(*args), GFP_KERNEL);
-		if (!args) {
-			error = -ENOMEM;
-			goto out_err;
-		}
-		nbd->task_recv = current;
-		mutex_unlock(&nbd->config_lock);
-
-		nbd_parse_flags(nbd, bdev);
-
-		error = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
-		if (error) {
-			dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
-			goto out_recv;
-		}
-
-		nbd_size_update(nbd, bdev);
-
-		nbd_dev_dbg_init(nbd);
-		for (i = 0; i < num_connections; i++) {
-			sk_set_memalloc(nbd->socks[i]->sock->sk);
-			atomic_inc(&nbd->recv_threads);
-			INIT_WORK(&args[i].work, recv_work);
-			args[i].nbd = nbd;
-			args[i].index = i;
-			queue_work(recv_workqueue, &args[i].work);
-		}
-		wait_event_interruptible(nbd->recv_wq,
-					 atomic_read(&nbd->recv_threads) == 0);
-		for (i = 0; i < num_connections; i++)
-			flush_work(&args[i].work);
-		nbd_dev_dbg_close(nbd);
-		nbd_size_clear(nbd, bdev);
-		device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
-out_recv:
-		mutex_lock(&nbd->config_lock);
-		nbd->task_recv = NULL;
-out_err:
-		sock_shutdown(nbd);
-		nbd_clear_que(nbd);
-		kill_bdev(bdev);
-		nbd_bdev_reset(bdev);
-
-		/* user requested, ignore socket errors */
-		if (test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
-			error = 0;
-		if (test_bit(NBD_TIMEDOUT, &nbd->runtime_flags))
-			error = -ETIMEDOUT;
-
-		nbd_reset(nbd);
-		return error;
-	}
-
+	case NBD_DO_IT:
+		return nbd_start_device(nbd, bdev);
 	case NBD_CLEAR_QUE:
 		/*
 		 * This is for compatibility only.  The queue is always cleared
 		 * by NBD_DO_IT or NBD_CLEAR_SOCK.
 		 */
 		return 0;
-
 	case NBD_PRINT_DEBUG:
 		/*
 		 * For compatibility only, we no longer keep a list of
-- 
2.7.4
