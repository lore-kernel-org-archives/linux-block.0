Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59506 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754898AbcIHVMi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Sep 2016 17:12:38 -0400
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <mpa@pengutronix.de>,
        <nbd-general@lists.sourceforge.net>
Subject: [PATCH 1/5] nbd: convert to blkmq
Date: Thu, 8 Sep 2016 17:12:06 -0400
Message-ID: <1473369130-22986-2-git-send-email-jbacik@fb.com>
In-Reply-To: <1473369130-22986-1-git-send-email-jbacik@fb.com>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This moves NBD over to using blkmq, which allows us to get rid of the NBD
wide queue lock and the async submit kthread.  We will start with 1 hw
queue for now, but I plan to add multiple tcp connection support in the
future and we'll fix how we set the hwqueue's.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 337 ++++++++++++++++++++--------------------------------
 1 file changed, 129 insertions(+), 208 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a9e3980..15e7c67 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -34,6 +34,7 @@
 #include <linux/kthread.h>
 #include <linux/types.h>
 #include <linux/debugfs.h>
+#include <linux/blk-mq.h>
 
 #include <asm/uaccess.h>
 #include <asm/types.h>
@@ -45,12 +46,8 @@ struct nbd_device {
 	struct socket * sock;	/* If == NULL, device is not ready, yet	*/
 	int magic;
 
-	spinlock_t queue_lock;
-	struct list_head queue_head;	/* Requests waiting result */
-	struct request *active_req;
-	wait_queue_head_t active_wq;
-	struct list_head waiting_queue;	/* Requests to be sent */
-	wait_queue_head_t waiting_wq;
+	atomic_t outstanding_cmds;
+	struct blk_mq_tag_set tag_set;
 
 	struct mutex tx_lock;
 	struct gendisk *disk;
@@ -71,6 +68,11 @@ struct nbd_device {
 #endif
 };
 
+struct nbd_cmd {
+	struct nbd_device *nbd;
+	struct list_head list;
+};
+
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 static struct dentry *nbd_dbg_dir;
 #endif
@@ -83,18 +85,6 @@ static unsigned int nbds_max = 16;
 static struct nbd_device *nbd_dev;
 static int max_part;
 
-/*
- * Use just one lock (or at most 1 per NIC). Two arguments for this:
- * 1. Each NIC is essentially a synchronization point for all servers
- *    accessed through that NIC so there's no need to have more locks
- *    than NICs anyway.
- * 2. More locks lead to more "Dirty cache line bouncing" which will slow
- *    down each lock to the point where they're actually slower than just
- *    a single lock.
- * Thanks go to Jens Axboe and Al Viro for their LKML emails explaining this!
- */
-static DEFINE_SPINLOCK(nbd_lock);
-
 static inline struct device *nbd_to_dev(struct nbd_device *nbd)
 {
 	return disk_to_dev(nbd->disk);
@@ -153,18 +143,17 @@ static int nbd_size_set(struct nbd_device *nbd, struct block_device *bdev,
 	return 0;
 }
 
-static void nbd_end_request(struct nbd_device *nbd, struct request *req)
+static void nbd_end_request(struct nbd_cmd *cmd)
 {
+	struct nbd_device *nbd = cmd->nbd;
+	struct request *req = blk_mq_rq_from_pdu(cmd);
 	int error = req->errors ? -EIO : 0;
-	struct request_queue *q = req->q;
-	unsigned long flags;
 
-	dev_dbg(nbd_to_dev(nbd), "request %p: %s\n", req,
+	dev_dbg(nbd_to_dev(nbd), "request %p: %s\n", cmd,
 		error ? "failed" : "done");
 
-	spin_lock_irqsave(q->queue_lock, flags);
-	__blk_end_request_all(req, error);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	atomic_dec(&nbd->outstanding_cmds);
+	blk_mq_complete_request(req, error);
 }
 
 /*
@@ -193,7 +182,7 @@ static void nbd_xmit_timeout(unsigned long arg)
 	struct nbd_device *nbd = (struct nbd_device *)arg;
 	unsigned long flags;
 
-	if (list_empty(&nbd->queue_head))
+	if (!atomic_read(&nbd->outstanding_cmds))
 		return;
 
 	spin_lock_irqsave(&nbd->sock_lock, flags);
@@ -273,8 +262,9 @@ static inline int sock_send_bvec(struct nbd_device *nbd, struct bio_vec *bvec,
 }
 
 /* always call with the tx_lock held */
-static int nbd_send_req(struct nbd_device *nbd, struct request *req)
+static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd)
 {
+	struct request *req = blk_mq_rq_from_pdu(cmd);
 	int result, flags;
 	struct nbd_request request;
 	unsigned long size = blk_rq_bytes(req);
@@ -298,10 +288,10 @@ static int nbd_send_req(struct nbd_device *nbd, struct request *req)
 		request.from = cpu_to_be64((u64)blk_rq_pos(req) << 9);
 		request.len = htonl(size);
 	}
-	memcpy(request.handle, &req, sizeof(req));
+	memcpy(request.handle, &req->tag, sizeof(req->tag));
 
 	dev_dbg(nbd_to_dev(nbd), "request %p: sending control (%s@%llu,%uB)\n",
-		req, nbdcmd_to_ascii(type),
+		cmd, nbdcmd_to_ascii(type),
 		(unsigned long long)blk_rq_pos(req) << 9, blk_rq_bytes(req));
 	result = sock_xmit(nbd, 1, &request, sizeof(request),
 			(type == NBD_CMD_WRITE) ? MSG_MORE : 0);
@@ -323,7 +313,7 @@ static int nbd_send_req(struct nbd_device *nbd, struct request *req)
 			if (!rq_iter_last(bvec, iter))
 				flags = MSG_MORE;
 			dev_dbg(nbd_to_dev(nbd), "request %p: sending %d bytes data\n",
-				req, bvec.bv_len);
+				cmd, bvec.bv_len);
 			result = sock_send_bvec(nbd, &bvec, flags);
 			if (result <= 0) {
 				dev_err(disk_to_dev(nbd->disk),
@@ -336,29 +326,6 @@ static int nbd_send_req(struct nbd_device *nbd, struct request *req)
 	return 0;
 }
 
-static struct request *nbd_find_request(struct nbd_device *nbd,
-					struct request *xreq)
-{
-	struct request *req, *tmp;
-	int err;
-
-	err = wait_event_interruptible(nbd->active_wq, nbd->active_req != xreq);
-	if (unlikely(err))
-		return ERR_PTR(err);
-
-	spin_lock(&nbd->queue_lock);
-	list_for_each_entry_safe(req, tmp, &nbd->queue_head, queuelist) {
-		if (req != xreq)
-			continue;
-		list_del_init(&req->queuelist);
-		spin_unlock(&nbd->queue_lock);
-		return req;
-	}
-	spin_unlock(&nbd->queue_lock);
-
-	return ERR_PTR(-ENOENT);
-}
-
 static inline int sock_recv_bvec(struct nbd_device *nbd, struct bio_vec *bvec)
 {
 	int result;
@@ -370,11 +337,14 @@ static inline int sock_recv_bvec(struct nbd_device *nbd, struct bio_vec *bvec)
 }
 
 /* NULL returned = something went wrong, inform userspace */
-static struct request *nbd_read_stat(struct nbd_device *nbd)
+static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd)
 {
 	int result;
 	struct nbd_reply reply;
-	struct request *req;
+	struct nbd_cmd *cmd;
+	struct request *req = NULL;
+	u16 hwq;
+	int tag;
 
 	reply.magic = 0;
 	result = sock_xmit(nbd, 0, &reply, sizeof(reply), MSG_WAITALL);
@@ -390,25 +360,27 @@ static struct request *nbd_read_stat(struct nbd_device *nbd)
 		return ERR_PTR(-EPROTO);
 	}
 
-	req = nbd_find_request(nbd, *(struct request **)reply.handle);
-	if (IS_ERR(req)) {
-		result = PTR_ERR(req);
-		if (result != -ENOENT)
-			return ERR_PTR(result);
+	memcpy(&tag, reply.handle, sizeof(int));
 
-		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%p)\n",
-			reply.handle);
-		return ERR_PTR(-EBADR);
+	hwq = blk_mq_unique_tag_to_hwq(tag);
+	if (hwq < nbd->tag_set.nr_hw_queues)
+		req = blk_mq_tag_to_rq(nbd->tag_set.tags[hwq],
+				       blk_mq_unique_tag_to_tag(tag));
+	if (!req || !blk_mq_request_started(req)) {
+		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%d) %p\n",
+			tag, req);
+		return ERR_PTR(-ENOENT);
 	}
+	cmd = blk_mq_rq_to_pdu(req);
 
 	if (ntohl(reply.error)) {
 		dev_err(disk_to_dev(nbd->disk), "Other side returned error (%d)\n",
 			ntohl(reply.error));
 		req->errors++;
-		return req;
+		return cmd;
 	}
 
-	dev_dbg(nbd_to_dev(nbd), "request %p: got reply\n", req);
+	dev_dbg(nbd_to_dev(nbd), "request %p: got reply\n", cmd);
 	if (rq_data_dir(req) != WRITE) {
 		struct req_iterator iter;
 		struct bio_vec bvec;
@@ -419,13 +391,13 @@ static struct request *nbd_read_stat(struct nbd_device *nbd)
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
 					result);
 				req->errors++;
-				return req;
+				return cmd;
 			}
 			dev_dbg(nbd_to_dev(nbd), "request %p: got %d bytes data\n",
-				req, bvec.bv_len);
+				cmd, bvec.bv_len);
 		}
 	}
-	return req;
+	return cmd;
 }
 
 static ssize_t pid_show(struct device *dev,
@@ -444,7 +416,7 @@ static struct device_attribute pid_attr = {
 
 static int nbd_thread_recv(struct nbd_device *nbd, struct block_device *bdev)
 {
-	struct request *req;
+	struct nbd_cmd *cmd;
 	int ret;
 
 	BUG_ON(nbd->magic != NBD_MAGIC);
@@ -460,13 +432,13 @@ static int nbd_thread_recv(struct nbd_device *nbd, struct block_device *bdev)
 	nbd_size_update(nbd, bdev);
 
 	while (1) {
-		req = nbd_read_stat(nbd);
-		if (IS_ERR(req)) {
-			ret = PTR_ERR(req);
+		cmd = nbd_read_stat(nbd);
+		if (IS_ERR(cmd)) {
+			ret = PTR_ERR(cmd);
 			break;
 		}
 
-		nbd_end_request(nbd, req);
+		nbd_end_request(cmd);
 	}
 
 	nbd_size_clear(nbd, bdev);
@@ -475,44 +447,37 @@ static int nbd_thread_recv(struct nbd_device *nbd, struct block_device *bdev)
 	return ret;
 }
 
-static void nbd_clear_que(struct nbd_device *nbd)
+static void nbd_clear_req(struct request *req, void *data, bool reserved)
 {
-	struct request *req;
+	struct nbd_cmd *cmd;
 
+	if (!blk_mq_request_started(req))
+		return;
+	cmd = blk_mq_rq_to_pdu(req);
+	req->errors++;
+	nbd_end_request(cmd);
+}
+
+static void nbd_clear_que(struct nbd_device *nbd)
+{
 	BUG_ON(nbd->magic != NBD_MAGIC);
 
 	/*
 	 * Because we have set nbd->sock to NULL under the tx_lock, all
-	 * modifications to the list must have completed by now.  For
-	 * the same reason, the active_req must be NULL.
-	 *
-	 * As a consequence, we don't need to take the spin lock while
-	 * purging the list here.
+	 * modifications to the list must have completed by now.
 	 */
 	BUG_ON(nbd->sock);
-	BUG_ON(nbd->active_req);
 
-	while (!list_empty(&nbd->queue_head)) {
-		req = list_entry(nbd->queue_head.next, struct request,
-				 queuelist);
-		list_del_init(&req->queuelist);
-		req->errors++;
-		nbd_end_request(nbd, req);
-	}
-
-	while (!list_empty(&nbd->waiting_queue)) {
-		req = list_entry(nbd->waiting_queue.next, struct request,
-				 queuelist);
-		list_del_init(&req->queuelist);
-		req->errors++;
-		nbd_end_request(nbd, req);
-	}
+	blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_clear_req, NULL);
 	dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
 }
 
 
-static void nbd_handle_req(struct nbd_device *nbd, struct request *req)
+static void nbd_handle_cmd(struct nbd_cmd *cmd)
 {
+	struct request *req = blk_mq_rq_from_pdu(cmd);
+	struct nbd_device *nbd = cmd->nbd;
+
 	if (req->cmd_type != REQ_TYPE_FS)
 		goto error_out;
 
@@ -526,6 +491,7 @@ static void nbd_handle_req(struct nbd_device *nbd, struct request *req)
 	req->errors = 0;
 
 	mutex_lock(&nbd->tx_lock);
+	nbd->task_send = current;
 	if (unlikely(!nbd->sock)) {
 		mutex_unlock(&nbd->tx_lock);
 		dev_err(disk_to_dev(nbd->disk),
@@ -533,106 +499,34 @@ static void nbd_handle_req(struct nbd_device *nbd, struct request *req)
 		goto error_out;
 	}
 
-	nbd->active_req = req;
-
-	if (nbd->xmit_timeout && list_empty_careful(&nbd->queue_head))
+	if (nbd->xmit_timeout && !atomic_read(&nbd->outstanding_cmds))
 		mod_timer(&nbd->timeout_timer, jiffies + nbd->xmit_timeout);
 
-	if (nbd_send_req(nbd, req) != 0) {
+	atomic_inc(&nbd->outstanding_cmds);
+	if (nbd_send_cmd(nbd, cmd) != 0) {
 		dev_err(disk_to_dev(nbd->disk), "Request send failed\n");
 		req->errors++;
-		nbd_end_request(nbd, req);
-	} else {
-		spin_lock(&nbd->queue_lock);
-		list_add_tail(&req->queuelist, &nbd->queue_head);
-		spin_unlock(&nbd->queue_lock);
+		nbd_end_request(cmd);
 	}
 
-	nbd->active_req = NULL;
+	nbd->task_send = NULL;
 	mutex_unlock(&nbd->tx_lock);
-	wake_up_all(&nbd->active_wq);
 
 	return;
 
 error_out:
 	req->errors++;
-	nbd_end_request(nbd, req);
-}
-
-static int nbd_thread_send(void *data)
-{
-	struct nbd_device *nbd = data;
-	struct request *req;
-
-	nbd->task_send = current;
-
-	set_user_nice(current, MIN_NICE);
-	while (!kthread_should_stop() || !list_empty(&nbd->waiting_queue)) {
-		/* wait for something to do */
-		wait_event_interruptible(nbd->waiting_wq,
-					 kthread_should_stop() ||
-					 !list_empty(&nbd->waiting_queue));
-
-		/* extract request */
-		if (list_empty(&nbd->waiting_queue))
-			continue;
-
-		spin_lock_irq(&nbd->queue_lock);
-		req = list_entry(nbd->waiting_queue.next, struct request,
-				 queuelist);
-		list_del_init(&req->queuelist);
-		spin_unlock_irq(&nbd->queue_lock);
-
-		/* handle request */
-		nbd_handle_req(nbd, req);
-	}
-
-	nbd->task_send = NULL;
-
-	return 0;
+	nbd_end_request(cmd);
 }
 
-/*
- * We always wait for result of write, for now. It would be nice to make it optional
- * in future
- * if ((rq_data_dir(req) == WRITE) && (nbd->flags & NBD_WRITE_NOCHK))
- *   { printk( "Warning: Ignoring result!\n"); nbd_end_request( req ); }
- */
-
-static void nbd_request_handler(struct request_queue *q)
-		__releases(q->queue_lock) __acquires(q->queue_lock)
+static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
+			const struct blk_mq_queue_data *bd)
 {
-	struct request *req;
-	
-	while ((req = blk_fetch_request(q)) != NULL) {
-		struct nbd_device *nbd;
-
-		spin_unlock_irq(q->queue_lock);
-
-		nbd = req->rq_disk->private_data;
-
-		BUG_ON(nbd->magic != NBD_MAGIC);
+	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
 
-		dev_dbg(nbd_to_dev(nbd), "request %p: dequeued (flags=%x)\n",
-			req, req->cmd_type);
-
-		if (unlikely(!nbd->sock)) {
-			dev_err_ratelimited(disk_to_dev(nbd->disk),
-					    "Attempted send on closed socket\n");
-			req->errors++;
-			nbd_end_request(nbd, req);
-			spin_lock_irq(q->queue_lock);
-			continue;
-		}
-
-		spin_lock_irq(&nbd->queue_lock);
-		list_add_tail(&req->queuelist, &nbd->waiting_queue);
-		spin_unlock_irq(&nbd->queue_lock);
-
-		wake_up(&nbd->waiting_wq);
-
-		spin_lock_irq(q->queue_lock);
-	}
+	blk_mq_start_request(bd->rq);
+	nbd_handle_cmd(cmd);
+	return BLK_MQ_RQ_QUEUE_OK;
 }
 
 static int nbd_set_socket(struct nbd_device *nbd, struct socket *sock)
@@ -700,33 +594,37 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 {
 	switch (cmd) {
 	case NBD_DISCONNECT: {
-		struct request sreq;
+		struct request *sreq;
 
 		dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
 		if (!nbd->sock)
 			return -EINVAL;
 
+		sreq = blk_mq_alloc_request(bdev_get_queue(bdev), WRITE, 0);
+		if (!sreq)
+			return -ENOMEM;
+
 		mutex_unlock(&nbd->tx_lock);
 		fsync_bdev(bdev);
 		mutex_lock(&nbd->tx_lock);
-		blk_rq_init(NULL, &sreq);
-		sreq.cmd_type = REQ_TYPE_DRV_PRIV;
+		sreq->cmd_type = REQ_TYPE_DRV_PRIV;
 
 		/* Check again after getting mutex back.  */
-		if (!nbd->sock)
+		if (!nbd->sock) {
+			blk_mq_free_request(sreq);
 			return -EINVAL;
+		}
 
 		nbd->disconnect = true;
 
-		nbd_send_req(nbd, &sreq);
+		nbd_send_cmd(nbd, blk_mq_rq_to_pdu(sreq));
+		blk_mq_free_request(sreq);
 		return 0;
 	}
  
 	case NBD_CLEAR_SOCK:
 		sock_shutdown(nbd);
 		nbd_clear_que(nbd);
-		BUG_ON(!list_empty(&nbd->queue_head));
-		BUG_ON(!list_empty(&nbd->waiting_queue));
 		kill_bdev(bdev);
 		return 0;
 
@@ -772,7 +670,6 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		return 0;
 
 	case NBD_DO_IT: {
-		struct task_struct *thread;
 		int error;
 
 		if (nbd->task_recv)
@@ -786,18 +683,9 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 
 		nbd_parse_flags(nbd, bdev);
 
-		thread = kthread_run(nbd_thread_send, nbd, "%s",
-				     nbd_name(nbd));
-		if (IS_ERR(thread)) {
-			mutex_lock(&nbd->tx_lock);
-			nbd->task_recv = NULL;
-			return PTR_ERR(thread);
-		}
-
 		nbd_dev_dbg_init(nbd);
 		error = nbd_thread_recv(nbd, bdev);
 		nbd_dev_dbg_close(nbd);
-		kthread_stop(thread);
 
 		mutex_lock(&nbd->tx_lock);
 		nbd->task_recv = NULL;
@@ -825,10 +713,10 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		return 0;
 
 	case NBD_PRINT_DEBUG:
-		dev_info(disk_to_dev(nbd->disk),
-			"next = %p, prev = %p, head = %p\n",
-			nbd->queue_head.next, nbd->queue_head.prev,
-			&nbd->queue_head);
+		/*
+		 * For compatibility only, we no longer keep a list of
+		 * outstanding requests.
+		 */
 		return 0;
 	}
 	return -ENOTTY;
@@ -987,6 +875,23 @@ static void nbd_dbg_close(void)
 
 #endif
 
+static int nbd_init_request(void *data, struct request *rq,
+			    unsigned int hctx_idx, unsigned int request_idx,
+			    unsigned int numa_node)
+{
+	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(rq);
+
+	cmd->nbd = data;
+	INIT_LIST_HEAD(&cmd->list);
+	return 0;
+}
+
+static struct blk_mq_ops nbd_mq_ops = {
+	.queue_rq	= nbd_queue_rq,
+	.map_queue	= blk_mq_map_queue,
+	.init_request	= nbd_init_request,
+};
+
 /*
  * And here should be modules and kernel interface 
  *  (Just smiley confuses emacs :-)
@@ -1035,16 +940,34 @@ static int __init nbd_init(void)
 		if (!disk)
 			goto out;
 		nbd_dev[i].disk = disk;
+
+		nbd_dev[i].tag_set.ops = &nbd_mq_ops;
+		nbd_dev[i].tag_set.nr_hw_queues = 1;
+		nbd_dev[i].tag_set.queue_depth = 128;
+		nbd_dev[i].tag_set.numa_node = NUMA_NO_NODE;
+		nbd_dev[i].tag_set.cmd_size = sizeof(struct nbd_cmd);
+		nbd_dev[i].tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
+			BLK_MQ_F_SG_MERGE;
+		nbd_dev[i].tag_set.driver_data = &nbd_dev[i];
+
+		err = blk_mq_alloc_tag_set(&nbd_dev[i].tag_set);
+		if (err) {
+			put_disk(disk);
+			goto out;
+		}
+
 		/*
 		 * The new linux 2.5 block layer implementation requires
 		 * every gendisk to have its very own request_queue struct.
 		 * These structs are big so we dynamically allocate them.
 		 */
-		disk->queue = blk_init_queue(nbd_request_handler, &nbd_lock);
+		disk->queue = blk_mq_init_queue(&nbd_dev[i].tag_set);
 		if (!disk->queue) {
+			blk_mq_free_tag_set(&nbd_dev[i].tag_set);
 			put_disk(disk);
 			goto out;
 		}
+
 		/*
 		 * Tell the block layer that we are not a rotational device
 		 */
@@ -1069,16 +992,12 @@ static int __init nbd_init(void)
 	for (i = 0; i < nbds_max; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
 		nbd_dev[i].magic = NBD_MAGIC;
-		INIT_LIST_HEAD(&nbd_dev[i].waiting_queue);
-		spin_lock_init(&nbd_dev[i].queue_lock);
 		spin_lock_init(&nbd_dev[i].sock_lock);
-		INIT_LIST_HEAD(&nbd_dev[i].queue_head);
 		mutex_init(&nbd_dev[i].tx_lock);
 		init_timer(&nbd_dev[i].timeout_timer);
 		nbd_dev[i].timeout_timer.function = nbd_xmit_timeout;
 		nbd_dev[i].timeout_timer.data = (unsigned long)&nbd_dev[i];
-		init_waitqueue_head(&nbd_dev[i].active_wq);
-		init_waitqueue_head(&nbd_dev[i].waiting_wq);
+		atomic_set(&nbd_dev[i].outstanding_cmds, 0);
 		disk->major = NBD_MAJOR;
 		disk->first_minor = i << part_shift;
 		disk->fops = &nbd_fops;
@@ -1091,6 +1010,7 @@ static int __init nbd_init(void)
 	return 0;
 out:
 	while (i--) {
+		blk_mq_free_tag_set(&nbd_dev[i].tag_set);
 		blk_cleanup_queue(nbd_dev[i].disk->queue);
 		put_disk(nbd_dev[i].disk);
 	}
@@ -1110,6 +1030,7 @@ static void __exit nbd_cleanup(void)
 		if (disk) {
 			del_gendisk(disk);
 			blk_cleanup_queue(disk->queue);
+			blk_mq_free_tag_set(&nbd_dev[i].tag_set);
 			put_disk(disk);
 		}
 	}
-- 
2.8.0.rc2

