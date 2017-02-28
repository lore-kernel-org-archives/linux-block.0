Return-Path: <prvs=423213d9ff=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <nbd-general@lists.sourceforge.net>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 5/6] nbd: handle ERESTARTSYS properly
Date: Tue, 28 Feb 2017 11:57:10 -0500
Message-ID: <1488301031-3199-6-git-send-email-jbacik@fb.com>
In-Reply-To: <1488301031-3199-1-git-send-email-jbacik@fb.com>
References: <1488301031-3199-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

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
 drivers/block/nbd.c | 138 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 116 insertions(+), 22 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ac5a03a..aba1aba 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -49,6 +49,8 @@ struct nbd_sock {
 	struct mutex tx_lock;
 	bool dead;
 	int fallback_index;
+	struct request *pending;
+	int sent;
 };
 
 struct recv_thread_args {
@@ -145,6 +147,13 @@ static struct device_attribute pid_attr = {
 	.show = pid_show,
 };
 
+static void nbd_mark_nsock_dead(struct nbd_sock *nsock)
+{
+	nsock->dead = true;
+	nsock->pending = NULL;
+	nsock->sent = 0;
+}
+
 static int nbd_get_unless_zero(struct nbd_device *nbd)
 {
 	return atomic_add_unless(&nbd->refs, 1, 0);
@@ -200,8 +209,8 @@ static void sock_shutdown(struct nbd_device *nbd)
 		struct nbd_sock *nsock = nbd->socks[i];
 		mutex_lock(&nsock->tx_lock);
 		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
+		nbd_mark_nsock_dead(nsock);
 		mutex_unlock(&nsock->tx_lock);
-		nsock->dead = true;
 	}
 	dev_warn(disk_to_dev(nbd->disk), "shutting down sockets\n");
 }
@@ -229,8 +238,8 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 				struct nbd_sock *nsock =
 					nbd->socks[cmd->index];
 				mutex_lock(&nsock->tx_lock);
-				nsock->dead = true;
 				kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
+				nbd_mark_nsock_dead(nsock);
 				mutex_unlock(&nsock->tx_lock);
 			}
 			blk_mq_requeue_request(req, true);
@@ -253,7 +262,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
  *  Send or receive packet.
  */
 static int sock_xmit(struct nbd_device *nbd, int index, int send, void *buf,
-		     int size, int msg_flags)
+		     int size, int msg_flags, int *sent)
 {
 	struct socket *sock = nbd->socks[index]->sock;
 	int result;
@@ -292,6 +301,8 @@ static int sock_xmit(struct nbd_device *nbd, int index, int send, void *buf,
 		}
 		size -= result;
 		buf += result;
+		if (sent)
+			*sent += result;
 	} while (size > 0);
 
 	tsk_restore_flags(current, pflags, PF_MEMALLOC);
@@ -300,12 +311,28 @@ static int sock_xmit(struct nbd_device *nbd, int index, int send, void *buf,
 }
 
 static inline int sock_send_bvec(struct nbd_device *nbd, int index,
-				 struct bio_vec *bvec, int flags)
+				 struct bio_vec *bvec, int flags, int *skip,
+				 int *sent)
 {
+	void *kaddr;
+	unsigned int offset = bvec->bv_offset;
+	unsigned int len = bvec->bv_len;
 	int result;
-	void *kaddr = kmap(bvec->bv_page);
-	result = sock_xmit(nbd, index, 1, kaddr + bvec->bv_offset,
-			   bvec->bv_len, flags);
+
+	/* If we had partially sent this request previously we need to skip over
+	 * what we've already sent.
+	 */
+	if (*skip) {
+		if (len <= *skip) {
+			*skip -= len;
+			return len;
+		}
+		offset += *skip;
+		len -= *skip;
+		*skip = 0;
+	}
+	kaddr = kmap(bvec->bv_page);
+	result = sock_xmit(nbd, index, 1, kaddr + offset, len, flags, sent);
 	kunmap(bvec->bv_page);
 	return result;
 }
@@ -314,12 +341,14 @@ static inline int sock_send_bvec(struct nbd_device *nbd, int index,
 static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
+	struct nbd_sock *nsock = nbd->socks[index];
 	int result;
 	struct nbd_request request;
 	unsigned long size = blk_rq_bytes(req);
 	struct bio *bio;
 	u32 type;
 	u32 tag = blk_mq_unique_tag(req);
+	int sent = nsock->sent, skip = 0;
 
 	switch (req_op(req)) {
 	case REQ_OP_DISCARD:
@@ -345,6 +374,15 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		return -EIO;
 	}
 
+	/* We did a partial send previously, and we at least sent the whole
+	 * request struct, so just go and send the rest of the pages in the
+	 * request.
+	 */
+	if (sent && sent >= sizeof(request)) {
+		skip = sent - sizeof(request);
+		goto send_pages;
+	}
+
 	cmd->index = index;
 	memset(&request, 0, sizeof(request));
 	request.magic = htonl(NBD_REQUEST_MAGIC);
@@ -358,16 +396,33 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	dev_dbg(nbd_to_dev(nbd), "request %p: sending control (%s@%llu,%uB)\n",
 		cmd, nbdcmd_to_ascii(type),
 		(unsigned long long)blk_rq_pos(req) << 9, blk_rq_bytes(req));
-	result = sock_xmit(nbd, index, 1, &request, sizeof(request),
-			(type == NBD_CMD_WRITE) ? MSG_MORE : 0);
+
+	/* We may have only partially sent the request previously, so handle
+	 * this horrible, horrible, terrifying possiblity here.
+	 */
+	result = sock_xmit(nbd, index, 1, (void *)(&request) + sent,
+			   sizeof(request) - sent,
+			   (type == NBD_CMD_WRITE) ? MSG_MORE : 0, &sent);
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
 		return -EAGAIN;
 	}
-
+send_pages:
 	if (type != NBD_CMD_WRITE)
-		return 0;
+		goto out;
 
 	bio = req->bio;
 	while (bio) {
@@ -381,8 +436,18 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 
 			dev_dbg(nbd_to_dev(nbd), "request %p: sending %d bytes data\n",
 				cmd, bvec.bv_len);
-			result = sock_send_bvec(nbd, index, &bvec, flags);
+			result = sock_send_bvec(nbd, index, &bvec, flags,
+						&skip, &sent);
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
@@ -399,6 +464,9 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		}
 		bio = next;
 	}
+out:
+	nsock->pending = NULL;
+	nsock->sent = 0;
 	return 0;
 }
 
@@ -408,7 +476,7 @@ static inline int sock_recv_bvec(struct nbd_device *nbd, int index,
 	int result;
 	void *kaddr = kmap(bvec->bv_page);
 	result = sock_xmit(nbd, index, 0, kaddr + bvec->bv_offset,
-			   bvec->bv_len, MSG_WAITALL);
+			   bvec->bv_len, MSG_WAITALL, NULL);
 	kunmap(bvec->bv_page);
 	return result;
 }
@@ -430,7 +498,8 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	u32 tag;
 
 	reply.magic = 0;
-	result = sock_xmit(nbd, index, 0, &reply, sizeof(reply), MSG_WAITALL);
+	result = sock_xmit(nbd, index, 0, &reply, sizeof(reply), MSG_WAITALL,
+			   NULL);
 	if (result <= 0) {
 		if (!nbd_disconnected(nbd))
 			dev_err(disk_to_dev(nbd->disk),
@@ -510,7 +579,10 @@ static void recv_work(struct work_struct *work)
 	while (1) {
 		cmd = nbd_read_stat(nbd, args->index);
 		if (IS_ERR(cmd)) {
-			nbd->socks[args->index]->dead = true;
+			struct nbd_sock *nsock = nbd->socks[args->index];
+			mutex_lock(&nsock->tx_lock);
+			nbd_mark_nsock_dead(nsock);
+			mutex_unlock(&nsock->tx_lock);
 			ret = PTR_ERR(cmd);
 			break;
 		}
@@ -622,14 +694,26 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	 * returns EAGAIN can be retried on a different socket.
 	 */
 	mutex_lock(&nsock->tx_lock);
+
+	/* Handle the case that we have a pending request that was partially
+	 * transmitted that _has_ to be serviced first.  We need to call requeue
+	 * here so that it gets put _after_ the request that is already on the
+	 * dispatch list.
+	 */
+	if (unlikely(nsock->pending && nsock->pending != req)) {
+		blk_mq_requeue_request(req, true);
+		ret = 0;
+		goto out;
+	}
 	ret = nbd_send_cmd(nbd, cmd, index);
 	if (ret == -EAGAIN) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Request send failed trying another connection\n");
-		nsock->dead = true;
+		nbd_mark_nsock_dead(nsock);
 		mutex_unlock(&nsock->tx_lock);
 		goto again;
 	}
+out:
 	mutex_unlock(&nsock->tx_lock);
 	nbd_put(nbd);
 	return ret;
@@ -639,6 +723,7 @@ static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 			const struct blk_mq_queue_data *bd)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
+	int ret;
 
 	/*
 	 * Since we look at the bio's to send the request over the network we
@@ -651,13 +736,20 @@ static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 */
 	init_completion(&cmd->send_complete);
 	blk_mq_start_request(bd->rq);
-	if (nbd_handle_cmd(cmd, hctx->queue_num) != 0) {
-		bd->rq->errors++;
-		nbd_end_request(cmd);
-	}
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
 
 static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg)
@@ -699,6 +791,8 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg)
 	nsock->dead = false;
 	mutex_init(&nsock->tx_lock);
 	nsock->sock = sock;
+	nsock->pending = NULL;
+	nsock->sent = 0;
 	socks[nbd->num_connections++] = nsock;
 
 	err = 0;
@@ -751,7 +845,7 @@ static void send_disconnects(struct nbd_device *nbd)
 	request.type = htonl(NBD_CMD_DISC);
 
 	for (i = 0; i < nbd->num_connections; i++) {
-		ret = sock_xmit(nbd, i, 1, &request, sizeof(request), 0);
+		ret = sock_xmit(nbd, i, 1, &request, sizeof(request), 0, NULL);
 		if (ret <= 0)
 			dev_err(disk_to_dev(nbd->disk),
 				"Send disconnect failed %d\n", ret);
-- 
2.7.4
