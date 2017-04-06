Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 02/12] nbd: handle single path failures gracefully
Date: Thu,  6 Apr 2017 17:01:57 -0400
Message-Id: <1491512527-4286-3-git-send-email-jbacik@fb.com>
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

Currently if we have multiple connections and one of them goes down we will tear
down the whole device.  However there's no reason we need to do this as we
could have other connections that are working fine.  Deal with this by keeping
track of the state of the different connections, and if we lose one we mark it
as dead and send all IO destined for that socket to one of the other healthy
sockets.  Any outstanding requests that were on the dead socket will timeout and
be re-submitted properly.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 151 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 125 insertions(+), 26 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a4fd82e..4e64d60 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -49,6 +49,8 @@ struct nbd_sock {
 	struct mutex tx_lock;
 	struct request *pending;
 	int sent;
+	bool dead;
+	int fallback_index;
 };
 
 #define NBD_TIMEDOUT			0
@@ -82,6 +84,7 @@ struct nbd_device {
 
 struct nbd_cmd {
 	struct nbd_device *nbd;
+	int index;
 	struct completion send_complete;
 };
 
@@ -124,6 +127,15 @@ static const char *nbdcmd_to_ascii(int cmd)
 	return "invalid";
 }
 
+static void nbd_mark_nsock_dead(struct nbd_sock *nsock)
+{
+	if (!nsock->dead)
+		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
+	nsock->dead = true;
+	nsock->pending = NULL;
+	nsock->sent = 0;
+}
+
 static int nbd_size_clear(struct nbd_device *nbd, struct block_device *bdev)
 {
 	if (bdev->bd_openers <= 1)
@@ -191,7 +203,31 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 	struct nbd_device *nbd = cmd->nbd;
 
-	dev_err(nbd_to_dev(nbd), "Connection timed out, shutting down connection\n");
+	if (nbd->num_connections > 1) {
+		dev_err_ratelimited(nbd_to_dev(nbd),
+				    "Connection timed out, retrying\n");
+		mutex_lock(&nbd->config_lock);
+		/*
+		 * Hooray we have more connections, requeue this IO, the submit
+		 * path will put it on a real connection.
+		 */
+		if (nbd->socks && nbd->num_connections > 1) {
+			if (cmd->index < nbd->num_connections) {
+				struct nbd_sock *nsock =
+					nbd->socks[cmd->index];
+				mutex_lock(&nsock->tx_lock);
+				nbd_mark_nsock_dead(nsock);
+				mutex_unlock(&nsock->tx_lock);
+			}
+			mutex_unlock(&nbd->config_lock);
+			blk_mq_requeue_request(req, true);
+			return BLK_EH_NOT_HANDLED;
+		}
+		mutex_unlock(&nbd->config_lock);
+	} else {
+		dev_err_ratelimited(nbd_to_dev(nbd),
+				    "Connection timed out\n");
+	}
 	set_bit(NBD_TIMEDOUT, &nbd->runtime_flags);
 	req->errors = -EIO;
 
@@ -301,6 +337,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		}
 		iov_iter_advance(&from, sent);
 	}
+	cmd->index = index;
 	request.type = htonl(type);
 	if (type != NBD_CMD_FLUSH) {
 		request.from = cpu_to_be64((u64)blk_rq_pos(req) << 9);
@@ -328,7 +365,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
-		return -EIO;
+		return -EAGAIN;
 	}
 send_pages:
 	if (type != NBD_CMD_WRITE)
@@ -370,7 +407,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
 					result);
-				return -EIO;
+				return -EAGAIN;
 			}
 			/*
 			 * The completion might already have come in,
@@ -389,6 +426,12 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	return 0;
 }
 
+static int nbd_disconnected(struct nbd_device *nbd)
+{
+	return test_bit(NBD_DISCONNECTED, &nbd->runtime_flags) ||
+		test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags);
+}
+
 /* NULL returned = something went wrong, inform userspace */
 static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 {
@@ -405,8 +448,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	iov_iter_kvec(&to, READ | ITER_KVEC, &iov, 1, sizeof(reply));
 	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 	if (result <= 0) {
-		if (!test_bit(NBD_DISCONNECTED, &nbd->runtime_flags) &&
-		    !test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
+		if (!nbd_disconnected(nbd))
 			dev_err(disk_to_dev(nbd->disk),
 				"Receive control failed (result %d)\n", result);
 		return ERR_PTR(result);
@@ -449,8 +491,19 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 			if (result <= 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
 					result);
-				req->errors = -EIO;
-				return cmd;
+				/*
+				 * If we've disconnected or we only have 1
+				 * connection then we need to make sure we
+				 * complete this request, otherwise error out
+				 * and let the timeout stuff handle resubmitting
+				 * this request onto another connection.
+				 */
+				if (nbd_disconnected(nbd) ||
+				    nbd->num_connections <= 1) {
+					req->errors = -EIO;
+					return cmd;
+				}
+				return ERR_PTR(-EIO);
 			}
 			dev_dbg(nbd_to_dev(nbd), "request %p: got %d bytes data\n",
 				cmd, bvec.bv_len);
@@ -495,19 +548,17 @@ static void recv_work(struct work_struct *work)
 	while (1) {
 		cmd = nbd_read_stat(nbd, args->index);
 		if (IS_ERR(cmd)) {
+			struct nbd_sock *nsock = nbd->socks[args->index];
+
+			mutex_lock(&nsock->tx_lock);
+			nbd_mark_nsock_dead(nsock);
+			mutex_unlock(&nsock->tx_lock);
 			ret = PTR_ERR(cmd);
 			break;
 		}
 
 		nbd_end_request(cmd);
 	}
-
-	/*
-	 * We got an error, shut everybody down if this wasn't the result of a
-	 * disconnect request.
-	 */
-	if (ret && !test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
-		sock_shutdown(nbd);
 	atomic_dec(&nbd->recv_threads);
 	wake_up(&nbd->recv_wq);
 }
@@ -531,6 +582,47 @@ static void nbd_clear_que(struct nbd_device *nbd)
 	dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
 }
 
+static int find_fallback(struct nbd_device *nbd, int index)
+{
+	int new_index = -1;
+	struct nbd_sock *nsock = nbd->socks[index];
+	int fallback = nsock->fallback_index;
+
+	if (test_bit(NBD_DISCONNECTED, &nbd->runtime_flags))
+		return new_index;
+
+	if (nbd->num_connections <= 1) {
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Attempted send on invalid socket\n");
+		return new_index;
+	}
+
+	if (fallback >= 0 && fallback < nbd->num_connections &&
+	    !nbd->socks[fallback]->dead)
+		return fallback;
+
+	if (nsock->fallback_index < 0 ||
+	    nsock->fallback_index >= nbd->num_connections ||
+	    nbd->socks[nsock->fallback_index]->dead) {
+		int i;
+		for (i = 0; i < nbd->num_connections; i++) {
+			if (i == index)
+				continue;
+			if (!nbd->socks[i]->dead) {
+				new_index = i;
+				break;
+			}
+		}
+		nsock->fallback_index = new_index;
+		if (new_index < 0) {
+			dev_err_ratelimited(disk_to_dev(nbd->disk),
+					    "Dead connection, failed to find a fallback\n");
+			return new_index;
+		}
+	}
+	new_index = nsock->fallback_index;
+	return new_index;
+}
 
 static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 {
@@ -544,22 +636,16 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 				    "Attempted send on invalid socket\n");
 		return -EINVAL;
 	}
-
-	if (test_bit(NBD_DISCONNECTED, &nbd->runtime_flags)) {
-		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Attempted send on closed socket\n");
-		return -EINVAL;
-	}
-
 	req->errors = 0;
-
+again:
 	nsock = nbd->socks[index];
 	mutex_lock(&nsock->tx_lock);
-	if (unlikely(!nsock->sock)) {
+	if (nsock->dead) {
+		index = find_fallback(nbd, index);
 		mutex_unlock(&nsock->tx_lock);
-		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Attempted send on closed socket\n");
-		return -EINVAL;
+		if (index < 0)
+			return -EIO;
+		goto again;
 	}
 
 	/* Handle the case that we have a pending request that was partially
@@ -572,7 +658,18 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		ret = 0;
 		goto out;
 	}
+	/*
+	 * Some failures are related to the link going down, so anything that
+	 * returns EAGAIN can be retried on a different socket.
+	 */
 	ret = nbd_send_cmd(nbd, cmd, index);
+	if (ret == -EAGAIN) {
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Request send failed trying another connection\n");
+		nbd_mark_nsock_dead(nsock);
+		mutex_unlock(&nsock->tx_lock);
+		goto again;
+	}
 out:
 	mutex_unlock(&nsock->tx_lock);
 	return ret;
@@ -646,6 +743,8 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 
 	nbd->socks = socks;
 
+	nsock->fallback_index = -1;
+	nsock->dead = false;
 	mutex_init(&nsock->tx_lock);
 	nsock->sock = sock;
 	nsock->pending = NULL;
-- 
2.7.4
