Return-Path: <prvs=3212d1f655=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <kernel-team@fb.com>,
        <nbd-general@lists.sourceforge.net>, <axboe@kernel.dk>
Subject: [PATCH V2] nbd: ref count the socks array
Date: Wed, 8 Feb 2017 10:05:05 -0500
Message-ID: <1486566305-10039-1-git-send-email-jbacik@fb.com>
In-Reply-To: <1486505453-2976-1-git-send-email-jbacik@fb.com>
References: <1486505453-2976-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

In preparation for allowing seamless reconnects we need a way to make
sure that we don't free the socks array out from underneath ourselves.
So a socks_ref counter in order to keep track of who is using the socks
array, and only free it and change num_connections once our reference
reduces to zero.

We also need to make sure that somebody calling SET_SOCK isn't coming in
before we're done with our socks array, so add a waitqueue to wait on
previous users of the socks array before initiating a new socks array.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
V1->V2:
-req->errors++ in the timeout handler if we can't get a ref on our socks.
-drop another use of nbd->config_lock in the timeout handler I missed.

 drivers/block/nbd.c | 131 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 93 insertions(+), 38 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1914ba2..afb1353 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -54,19 +54,24 @@ struct nbd_sock {
 #define NBD_TIMEDOUT			0
 #define NBD_DISCONNECT_REQUESTED	1
 #define NBD_DISCONNECTED		2
-#define NBD_RUNNING			3
+#define NBD_HAS_SOCKS_REF		3
 
 struct nbd_device {
 	u32 flags;
 	unsigned long runtime_flags;
+
+	struct mutex socks_lock;
 	struct nbd_sock **socks;
+	atomic_t socks_ref;
+	wait_queue_head_t socks_wq;
+	int num_connections;
+
 	int magic;
 
 	struct blk_mq_tag_set tag_set;
 
 	struct mutex config_lock;
 	struct gendisk *disk;
-	int num_connections;
 	atomic_t recv_threads;
 	wait_queue_head_t recv_wq;
 	loff_t blksize;
@@ -102,7 +107,6 @@ static int part_shift;
 static int nbd_dev_dbg_init(struct nbd_device *nbd);
 static void nbd_dev_dbg_close(struct nbd_device *nbd);
 
-
 static inline struct device *nbd_to_dev(struct nbd_device *nbd)
 {
 	return disk_to_dev(nbd->disk);
@@ -125,6 +129,27 @@ static const char *nbdcmd_to_ascii(int cmd)
 	return "invalid";
 }
 
+static int nbd_socks_get_unless_zero(struct nbd_device *nbd)
+{
+	return atomic_add_unless(&nbd->socks_ref, 1, 0);
+}
+
+static void nbd_socks_put(struct nbd_device *nbd)
+{
+	if (atomic_dec_and_test(&nbd->socks_ref)) {
+		mutex_lock(&nbd->socks_lock);
+		if (nbd->num_connections) {
+			int i;
+			for (i = 0; i < nbd->num_connections; i++)
+				kfree(nbd->socks[i]);
+			kfree(nbd->socks);
+			nbd->num_connections = 0;
+			nbd->socks = NULL;
+		}
+		mutex_unlock(&nbd->socks_lock);
+	}
+}
+
 static int nbd_size_clear(struct nbd_device *nbd, struct block_device *bdev)
 {
 	bdev->bd_inode->i_size = 0;
@@ -190,6 +215,7 @@ static void sock_shutdown(struct nbd_device *nbd)
 		mutex_lock(&nsock->tx_lock);
 		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
 		mutex_unlock(&nsock->tx_lock);
+		nsock->dead = true;
 	}
 	dev_warn(disk_to_dev(nbd->disk), "shutting down sockets\n");
 }
@@ -200,10 +226,14 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 	struct nbd_device *nbd = cmd->nbd;
 
+	if (!nbd_socks_get_unless_zero(nbd)) {
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
@@ -217,21 +247,19 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 				kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
 				mutex_unlock(&nsock->tx_lock);
 			}
-			mutex_unlock(&nbd->config_lock);
 			blk_mq_requeue_request(req, true);
+			nbd_socks_put(nbd);
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
+	nbd_socks_put(nbd);
+
 	return BLK_EH_HANDLED;
 }
 
@@ -523,6 +551,7 @@ static void recv_work(struct work_struct *work)
 
 		nbd_end_request(cmd);
 	}
+	nbd_socks_put(nbd);
 	atomic_dec(&nbd->recv_threads);
 	wake_up(&nbd->recv_wq);
 }
@@ -598,9 +627,16 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	struct nbd_sock *nsock;
 	int ret;
 
+	if (!nbd_socks_get_unless_zero(nbd)) {
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Socks array is empty\n");
+		return -EINVAL;
+	}
+
 	if (index >= nbd->num_connections) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
+		nbd_socks_put(nbd);
 		return -EINVAL;
 	}
 	req->errors = 0;
@@ -608,8 +644,10 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	nsock = nbd->socks[index];
 	if (nsock->dead) {
 		index = find_fallback(nbd, index);
-		if (index < 0)
+		if (index < 0) {
+			nbd_socks_put(nbd);
 			return -EIO;
+		}
 		nsock = nbd->socks[index];
 	}
 
@@ -627,7 +665,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		goto again;
 	}
 	mutex_unlock(&nsock->tx_lock);
-
+	nbd_socks_put(nbd);
 	return ret;
 }
 
@@ -656,6 +694,25 @@ static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_MQ_RQ_QUEUE_OK;
 }
 
+static int nbd_wait_for_socks(struct nbd_device *nbd)
+{
+	int ret;
+
+	if (!atomic_read(&nbd->socks_ref))
+		return 0;
+
+	do {
+		mutex_unlock(&nbd->socks_lock);
+		mutex_unlock(&nbd->config_lock);
+		ret = wait_event_interruptible(nbd->socks_wq,
+				atomic_read(&nbd->socks_ref) == 0);
+		mutex_lock(&nbd->config_lock);
+		mutex_lock(&nbd->socks_lock);
+	} while (!ret && atomic_read(&nbd->socks_ref));
+
+	return ret;
+}
+
 static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 			  unsigned long arg)
 {
@@ -668,21 +725,30 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 	if (!sock)
 		return err;
 
-	if (!nbd->task_setup)
+	err = -EINVAL;
+	mutex_lock(&nbd->socks_lock);
+	if (!nbd->task_setup) {
 		nbd->task_setup = current;
+		if (nbd_wait_for_socks(nbd))
+			goto out;
+		atomic_inc(&nbd->socks_ref);
+		set_bit(NBD_HAS_SOCKS_REF, &nbd->runtime_flags);
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
 
@@ -694,7 +760,10 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 
 	if (max_part)
 		bdev->bd_invalidated = 1;
-	return 0;
+	err = 0;
+out:
+	mutex_unlock(&nbd->socks_lock);
+	return err;
 }
 
 /* Reset all properties of an NBD device */
@@ -750,20 +819,17 @@ static void send_disconnects(struct nbd_device *nbd)
 static int nbd_disconnect(struct nbd_device *nbd, struct block_device *bdev)
 {
 	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
-	if (!nbd->socks)
+	if (!nbd_socks_get_unless_zero(nbd))
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
+	nbd_socks_put(nbd);
 	return 0;
 }
 
@@ -773,22 +839,9 @@ static int nbd_clear_sock(struct nbd_device *nbd, struct block_device *bdev)
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
+		nbd_socks_put(nbd);
 	return 0;
 }
 
@@ -809,7 +862,6 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 		goto out_err;
 	}
 
-	set_bit(NBD_RUNNING, &nbd->runtime_flags);
 	blk_mq_update_nr_hw_queues(&nbd->tag_set, nbd->num_connections);
 	args = kcalloc(num_connections, sizeof(*args), GFP_KERNEL);
 	if (!args) {
@@ -833,6 +885,7 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 	for (i = 0; i < num_connections; i++) {
 		sk_set_memalloc(nbd->socks[i]->sock->sk);
 		atomic_inc(&nbd->recv_threads);
+		atomic_inc(&nbd->socks_ref);
 		INIT_WORK(&args[i].work, recv_work);
 		args[i].nbd = nbd;
 		args[i].index = i;
@@ -849,7 +902,6 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 	mutex_lock(&nbd->config_lock);
 	nbd->task_recv = NULL;
 out_err:
-	clear_bit(NBD_RUNNING, &nbd->runtime_flags);
 	nbd_clear_sock(nbd, bdev);
 
 	/* user requested, ignore socket errors */
@@ -1149,12 +1201,15 @@ static int nbd_dev_add(int index)
 
 	nbd->magic = NBD_MAGIC;
 	mutex_init(&nbd->config_lock);
+	mutex_init(&nbd->socks_lock);
+	atomic_set(&nbd->socks_ref, 0);
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
