Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 1/4] nbd: handle ERESTARTSYS properly
Date: Fri, 24 Mar 2017 14:08:26 -0400
Message-Id: <1490378909-4056-2-git-send-email-josef@toxicpanda.com>
In-Reply-To: <1490378909-4056-1-git-send-email-josef@toxicpanda.com>
References: <1490378909-4056-1-git-send-email-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

We can submit IO in a processes context, which means there can be
pending signals.  This isn't a fatal error for NBD, but it does require
some finesse.  If the signal happens before we transmit anything then we
are ok, just requeue the request and carry on.  However if we've done a
partial transmit we can't allow anything else to be transmitted on this
socket until we transmit the remaining part of the request.  Deal with
this by keeping track of how much we've sent for the current request,
and if we get an ERESTARTSYS during any part of our transmission save
the state of that request and requeue the IO.  If anybody tries to
submit a request that isn't our pending request then requeue that
request until we are able to service the one that is pending.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 115 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 89 insertions(+), 26 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7e4287b..3d1fc37a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -47,6 +47,8 @@ static DEFINE_MUTEX(nbd_index_mutex);
 struct nbd_sock {
 	struct socket *sock;
 	struct mutex tx_lock;
+	struct request *pending;
+	int sent;
 };
 
 #define NBD_TIMEDOUT			0
@@ -202,7 +204,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
  *  Send or receive packet.
  */
 static int sock_xmit(struct nbd_device *nbd, int index, int send,
-		     struct iov_iter *iter, int msg_flags)
+		     struct iov_iter *iter, int msg_flags, int *sent)
 {
 	struct socket *sock = nbd->socks[index]->sock;
 	int result;
@@ -237,6 +239,8 @@ static int sock_xmit(struct nbd_device *nbd, int index, int send,
 				result = -EPIPE; /* short read */
 			break;
 		}
+		if (sent)
+			*sent += result;
 	} while (msg_data_left(&msg));
 
 	tsk_restore_flags(current, pflags, PF_MEMALLOC);
@@ -248,6 +252,7 @@ static int sock_xmit(struct nbd_device *nbd, int index, int send,
 static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
+	struct nbd_sock *nsock = nbd->socks[index];
 	int result;
 	struct nbd_request request = {.magic = htonl(NBD_REQUEST_MAGIC)};
 	struct kvec iov = {.iov_base = &request, .iov_len = sizeof(request)};
@@ -256,6 +261,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	struct bio *bio;
 	u32 type;
 	u32 tag = blk_mq_unique_tag(req);
+	int sent = nsock->sent, skip = 0;
 
 	iov_iter_kvec(&from, WRITE | ITER_KVEC, &iov, 1, sizeof(request));
 
@@ -283,6 +289,17 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		return -EIO;
 	}
 
+	/* We did a partial send previously, and we at least sent the whole
+	 * request struct, so just go and send the rest of the pages in the
+	 * request.
+	 */
+	if (sent) {
+		if (sent >= sizeof(request)) {
+			skip = sent - sizeof(request);
+			goto send_pages;
+		}
+		iov_iter_advance(&from, sent);
+	}
 	request.type = htonl(type);
 	if (type != NBD_CMD_FLUSH) {
 		request.from = cpu_to_be64((u64)blk_rq_pos(req) << 9);
@@ -294,15 +311,27 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		cmd, nbdcmd_to_ascii(type),
 		(unsigned long long)blk_rq_pos(req) << 9, blk_rq_bytes(req));
 	result = sock_xmit(nbd, index, 1, &from,
-			(type == NBD_CMD_WRITE) ? MSG_MORE : 0);
+			(type == NBD_CMD_WRITE) ? MSG_MORE : 0, &sent);
 	if (result <= 0) {
+		if (result == -ERESTARTSYS) {
+			/* If we havne't sent anything we can just return BUSY,
+			 * however if we have sent something we need to make
+			 * sure we only allow this req to be sent until we are
+			 * completely done.
+			 */
+			if (sent) {
+				nsock->pending = req;
+				nsock->sent = sent;
+			}
+			return BLK_MQ_RQ_QUEUE_BUSY;
+		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
 		return -EIO;
 	}
-
+send_pages:
 	if (type != NBD_CMD_WRITE)
-		return 0;
+		goto out;
 
 	bio = req->bio;
 	while (bio) {
@@ -318,8 +347,25 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 				cmd, bvec.bv_len);
 			iov_iter_bvec(&from, ITER_BVEC | WRITE,
 				      &bvec, 1, bvec.bv_len);
-			result = sock_xmit(nbd, index, 1, &from, flags);
+			if (skip) {
+				if (skip >= iov_iter_count(&from)) {
+					skip -= iov_iter_count(&from);
+					continue;
+				}
+				iov_iter_advance(&from, skip);
+				skip = 0;
+			}
+			result = sock_xmit(nbd, index, 1, &from, flags, &sent);
 			if (result <= 0) {
+				if (result == -ERESTARTSYS) {
+					/* We've already sent the header, we
+					 * have no choice but to set pending and
+					 * return BUSY.
+					 */
+					nsock->pending = req;
+					nsock->sent = sent;
+					return BLK_MQ_RQ_QUEUE_BUSY;
+				}
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
 					result);
@@ -336,6 +382,9 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		}
 		bio = next;
 	}
+out:
+	nsock->pending = NULL;
+	nsock->sent = 0;
 	return 0;
 }
 
@@ -353,7 +402,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 
 	reply.magic = 0;
 	iov_iter_kvec(&to, READ | ITER_KVEC, &iov, 1, sizeof(reply));
-	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL);
+	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 	if (result <= 0) {
 		if (!test_bit(NBD_DISCONNECTED, &nbd->runtime_flags) &&
 		    !test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
@@ -395,7 +444,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 		rq_for_each_segment(bvec, req, iter) {
 			iov_iter_bvec(&to, ITER_BVEC | READ,
 				      &bvec, 1, bvec.bv_len);
-			result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL);
+			result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 			if (result <= 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
 					result);
@@ -482,22 +531,23 @@ static void nbd_clear_que(struct nbd_device *nbd)
 }
 
 
-static void nbd_handle_cmd(struct nbd_cmd *cmd, int index)
+static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
 	struct nbd_device *nbd = cmd->nbd;
 	struct nbd_sock *nsock;
+	int ret;
 
 	if (index >= nbd->num_connections) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
-		goto error_out;
+		return -EINVAL;
 	}
 
 	if (test_bit(NBD_DISCONNECTED, &nbd->runtime_flags)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on closed socket\n");
-		goto error_out;
+		return -EINVAL;
 	}
 
 	req->errors = 0;
@@ -508,29 +558,30 @@ static void nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		mutex_unlock(&nsock->tx_lock);
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on closed socket\n");
-		goto error_out;
+		return -EINVAL;
 	}
 
-	if (nbd_send_cmd(nbd, cmd, index) != 0) {
-		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Request send failed\n");
-		req->errors++;
-		nbd_end_request(cmd);
+	/* Handle the case that we have a pending request that was partially
+	 * transmitted that _has_ to be serviced first.  We need to call requeue
+	 * here so that it gets put _after_ the request that is already on the
+	 * dispatch list.
+	 */
+	if (unlikely(nsock->pending && nsock->pending != req)) {
+		blk_mq_requeue_request(req, true);
+		ret = 0;
+		goto out;
 	}
-
+	ret = nbd_send_cmd(nbd, cmd, index);
+out:
 	mutex_unlock(&nsock->tx_lock);
-
-	return;
-
-error_out:
-	req->errors++;
-	nbd_end_request(cmd);
+	return ret;
 }
 
 static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 			const struct blk_mq_queue_data *bd)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
+	int ret;
 
 	/*
 	 * Since we look at the bio's to send the request over the network we
@@ -543,10 +594,20 @@ static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 */
 	init_completion(&cmd->send_complete);
 	blk_mq_start_request(bd->rq);
-	nbd_handle_cmd(cmd, hctx->queue_num);
+
+	/* We can be called directly from the user space process, which means we
+	 * could possibly have signals pending so our sendmsg will fail.  In
+	 * this case we need to return that we are busy, otherwise error out as
+	 * appropriate.
+	 */
+	ret = nbd_handle_cmd(cmd, hctx->queue_num);
+	if (ret < 0)
+		ret = BLK_MQ_RQ_QUEUE_ERROR;
+	if (!ret)
+		ret = BLK_MQ_RQ_QUEUE_OK;
 	complete(&cmd->send_complete);
 
-	return BLK_MQ_RQ_QUEUE_OK;
+	return ret;
 }
 
 static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
@@ -581,6 +642,8 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 
 	mutex_init(&nsock->tx_lock);
 	nsock->sock = sock;
+	nsock->pending = NULL;
+	nsock->sent = 0;
 	socks[nbd->num_connections++] = nsock;
 
 	if (max_part)
@@ -634,7 +697,7 @@ static void send_disconnects(struct nbd_device *nbd)
 
 	for (i = 0; i < nbd->num_connections; i++) {
 		iov_iter_kvec(&from, WRITE | ITER_KVEC, &iov, 1, sizeof(request));
-		ret = sock_xmit(nbd, i, 1, &from, 0);
+		ret = sock_xmit(nbd, i, 1, &from, 0, NULL);
 		if (ret <= 0)
 			dev_err(disk_to_dev(nbd->disk),
 				"Send disconnect failed %d\n", ret);
-- 
2.7.4
