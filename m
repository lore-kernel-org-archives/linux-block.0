Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37203 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752331AbdBCVSk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Feb 2017 16:18:40 -0500
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <kernel-team@fb.com>,
        <nbd-general@lists.sourceforge.net>
Subject: [PATCH] nbd: handle single path failures gracefully
Date: Fri, 3 Feb 2017 16:18:22 -0500
Message-ID: <1486156702-9417-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently if we have multiple connections and one of them goes down we will tear
down the whole device.  However there's no reason we need to do this as we
could have other connections that are working fine.  Deal with this by keeping
track of the state of the different connections, and if we lose one we mark it
as dead and send all IO destined for that socket to one of the other healthy
sockets.  Any outstanding requests that were on the dead socket will timeout and
be re-submitted properly.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 165 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 124 insertions(+), 41 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 0be84a3..164a548 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -47,6 +47,8 @@ static DEFINE_MUTEX(nbd_index_mutex);
 struct nbd_sock {
 	struct socket *sock;
 	struct mutex tx_lock;
+	bool dead;
+	int fallback_index;
 };
 
 #define NBD_TIMEDOUT			0
@@ -80,6 +82,7 @@ struct nbd_device {
 
 struct nbd_cmd {
 	struct nbd_device *nbd;
+	int index;
 	struct completion send_complete;
 };
 
@@ -193,7 +196,32 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
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
+				nsock->dead = true;
+				kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
+				mutex_unlock(&nsock->tx_lock);
+			}
+			mutex_unlock(&nbd->config_lock);
+			blk_mq_requeue_request(req, true);
+			return BLK_EH_RESET_TIMER;
+		}
+		mutex_unlock(&nbd->config_lock);
+	} else {
+		dev_err_ratelimited(nbd_to_dev(nbd),
+				    "Connection timed out\n");
+	}
 	set_bit(NBD_TIMEDOUT, &nbd->runtime_flags);
 	req->errors++;
 
@@ -299,6 +327,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		return -EIO;
 	}
 
+	cmd->index = index;
 	memset(&request, 0, sizeof(request));
 	request.magic = htonl(NBD_REQUEST_MAGIC);
 	request.type = htonl(type);
@@ -316,7 +345,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	if (result <= 0) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
-		return -EIO;
+		return -EAGAIN;
 	}
 
 	if (type != NBD_CMD_WRITE)
@@ -339,7 +368,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
 					result);
-				return -EIO;
+				return -EAGAIN;
 			}
 			/*
 			 * The completion might already have come in,
@@ -366,6 +395,12 @@ static inline int sock_recv_bvec(struct nbd_device *nbd, int index,
 	return result;
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
@@ -379,8 +414,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	reply.magic = 0;
 	result = sock_xmit(nbd, index, 0, &reply, sizeof(reply), MSG_WAITALL);
 	if (result <= 0) {
-		if (!test_bit(NBD_DISCONNECTED, &nbd->runtime_flags) &&
-		    !test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
+		if (!nbd_disconnected(nbd))
 			dev_err(disk_to_dev(nbd->disk),
 				"Receive control failed (result %d)\n", result);
 		return ERR_PTR(result);
@@ -421,8 +455,19 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 			if (result <= 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
 					result);
-				req->errors++;
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
+					req->errors++;
+					return cmd;
+				}
+				return ERR_PTR(-EIO);
 			}
 			dev_dbg(nbd_to_dev(nbd), "request %p: got %d bytes data\n",
 				cmd, bvec.bv_len);
@@ -467,19 +512,13 @@ static void recv_work(struct work_struct *work)
 	while (1) {
 		cmd = nbd_read_stat(nbd, args->index);
 		if (IS_ERR(cmd)) {
+			nbd->socks[args->index]->dead = true;
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
@@ -503,50 +542,89 @@ static void nbd_clear_que(struct nbd_device *nbd)
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
 
-static void nbd_handle_cmd(struct nbd_cmd *cmd, int index)
+	mutex_lock(&nsock->tx_lock);
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
+		if (new_index < 0) {
+			mutex_unlock(&nsock->tx_lock);
+			dev_err_ratelimited(disk_to_dev(nbd->disk),
+					    "Dead connection, failed to find a fallback\n");
+			return new_index;
+		}
+		nsock->fallback_index = new_index;
+	}
+	new_index = nsock->fallback_index;
+	mutex_unlock(&nsock->tx_lock);
+	return new_index;
+}
+
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
-	}
-
-	if (test_bit(NBD_DISCONNECTED, &nbd->runtime_flags)) {
-		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Attempted send on closed socket\n");
-		goto error_out;
+		return -EINVAL;
 	}
-
 	req->errors = 0;
-
+again:
 	nsock = nbd->socks[index];
-	mutex_lock(&nsock->tx_lock);
-	if (unlikely(!nsock->sock)) {
-		mutex_unlock(&nsock->tx_lock);
-		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Attempted send on closed socket\n");
-		goto error_out;
+	if (nsock->dead) {
+		index = find_fallback(nbd, index);
+		if (index < 0)
+			return -EIO;
+		nsock = nbd->socks[index];
 	}
 
-	if (nbd_send_cmd(nbd, cmd, index) != 0) {
+	/*
+	 * Some failures are related to the link going down, so anything that
+	 * returns EAGAIN can be retried on a different socket.
+	 */
+	mutex_lock(&nsock->tx_lock);
+	ret = nbd_send_cmd(nbd, cmd, index);
+	if (ret == -EAGAIN) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Request send failed\n");
-		req->errors++;
-		nbd_end_request(cmd);
+				    "Request send failed trying another connection\n");
+		nsock->dead = true;
+		mutex_unlock(&nsock->tx_lock);
+		goto again;
 	}
-
 	mutex_unlock(&nsock->tx_lock);
 
-	return;
-
-error_out:
-	req->errors++;
-	nbd_end_request(cmd);
+	return ret;
 }
 
 static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -565,7 +643,10 @@ static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 */
 	init_completion(&cmd->send_complete);
 	blk_mq_start_request(bd->rq);
-	nbd_handle_cmd(cmd, hctx->queue_num);
+	if (nbd_handle_cmd(cmd, hctx->queue_num) != 0) {
+		bd->rq->errors++;
+		nbd_end_request(cmd);
+	}
 	complete(&cmd->send_complete);
 
 	return BLK_MQ_RQ_QUEUE_OK;
@@ -594,6 +675,8 @@ static int nbd_add_socket(struct nbd_device *nbd, struct socket *sock)
 
 	nbd->socks = socks;
 
+	nsock->fallback_index = -1;
+	nsock->dead = false;
 	mutex_init(&nsock->tx_lock);
 	nsock->sock = sock;
 	socks[nbd->num_connections++] = nsock;
-- 
2.7.4
