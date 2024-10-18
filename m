Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726213207
	for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260533; cv=none; b=KXQ1tn6TCoAmFdxZHijWw7IRNIkzrYzrijj/xUbxUL9rMKUOO2T5nH/JJCfJXVmI+qQXU1MduIciwidpH+XxDp56odhNaAii3q557gHM/U81a/JsG17uXnqAP6nWBT0LCyhf1KrMpNh7jjOUSKl34JQTsDqaEEjsMGqGNwuCIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260533; c=relaxed/simple;
	bh=fSeg5Xp4DDTE8QjemzrLpZGEltGLWVl9ljjDI68WXaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZ2FPzOypMlrf85cg14xYIvJES/ofsOl+u1GZ/7pUACjalhwh72ISUluCMn66VATulEB6BZ6Z/Z2lb82S0zn/lwzAasgGiWz7w3epfK3knmE21iQQUrPlobE43aGU9uHksD/gC/0xyf4vdNi3SwxEHwqpDFVa42+60udZEzGtIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJSBjJlX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJSBjJlX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729260530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pz7ZHQxjjchXDpKx/w9P5M+hghfxRJUm9JLpFUVefj0=;
	b=DJSBjJlXOV/Hyi+nqu3Jl3ybvDiVb7zw/t05kwsoWFWt+gUWL+n7m7Xq1nLpukXwGv6w4C
	i6FaxQtF6iYIJf2lvfTaibR0DBGf5pba7ZscuiJ+wDj9Ui0/Jm5agW70MjNWovsq0pmC++
	m2vi7yDXUCSr0GZi9dij/puq+l3/Kas=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-aj6ZjEzaP5uaopjSCuVsKw-1; Fri,
 18 Oct 2024 10:08:45 -0400
X-MC-Unique: aj6ZjEzaP5uaopjSCuVsKw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B12451933171;
	Fri, 18 Oct 2024 14:08:40 +0000 (UTC)
Received: from localhost (unknown [10.72.116.23])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58B0219560AD;
	Fri, 18 Oct 2024 14:08:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: josef@toxicpanda.com,
	nbd@other.debian.org,
	eblake@redhat.com,
	Ming Lei <ming.lei@redhat.com>,
	vincent.chen@sifive.com,
	Leon Schuermann <leon@is.currently.online>,
	Bart Van Assche <bvanassche@acm.org>,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH V2] nbd: fix partial sending
Date: Fri, 18 Oct 2024 22:08:31 +0800
Message-ID: <20241018140831.3064135-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

nbd driver sends request header and payload with multiple call of
sock_sendmsg, and partial sending can't be avoided. However, nbd driver
returns BLK_STS_RESOURCE to block core in this situation. This way causes
one issue: request->tag may change in the next run of nbd_queue_rq(), but
the original old tag has been sent as part of header cookie, this way
confuses nbd driver reply handling, since the real request can't be
retrieved any more with the obsolete old tag.

Fix it by retrying sending directly in per-socket work function,
meantime return BLK_STS_OK to block layer core.

Cc: vincent.chen@sifive.com
Cc: Leon Schuermann <leon@is.currently.online>
Cc: Bart Van Assche <bvanassche@acm.org>
Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- move pending retry to socket work function and return BLK_STS_OK, so that
	userspace can get chance to handle the signal(Kevin)

 drivers/block/nbd.c | 89 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 12 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b852050d8a96..855f4a79e37c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -62,6 +62,7 @@ struct nbd_sock {
 	bool dead;
 	int fallback_index;
 	int cookie;
+	struct work_struct work;
 };
 
 struct recv_thread_args {
@@ -141,6 +142,9 @@ struct nbd_device {
  */
 #define NBD_CMD_INFLIGHT	2
 
+/* Just part of request header or data payload is sent successfully */
+#define NBD_CMD_PARTIAL_SEND	3
+
 struct nbd_cmd {
 	struct nbd_device *nbd;
 	struct mutex lock;
@@ -466,6 +470,12 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 	if (!mutex_trylock(&cmd->lock))
 		return BLK_EH_RESET_TIMER;
 
+	/* partial send is handled in nbd_sock's work function */
+	if (test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags)) {
+		mutex_unlock(&cmd->lock);
+		return BLK_EH_RESET_TIMER;
+	}
+
 	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
 		mutex_unlock(&cmd->lock);
 		return BLK_EH_DONE;
@@ -614,6 +624,27 @@ static inline int was_interrupted(int result)
 	return result == -ERESTARTSYS || result == -EINTR;
 }
 
+/*
+ * We've already sent header or part of data payload, have no choice but
+ * to set pending and schedule it in work.
+ *
+ * And we have to return BLK_STS_OK to block core, otherwise this same
+ * request may be re-dispatched with different tag, but our header has
+ * been sent out with old tag, and this way does confuse reply handling.
+ */
+static void nbd_run_pending_work(struct nbd_device *nbd,
+				 struct nbd_sock *nsock,
+				 struct nbd_cmd *cmd, int sent)
+{
+	struct request *req = blk_mq_rq_from_pdu(cmd);
+
+	nsock->pending = req;
+	nsock->sent = sent;
+	set_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
+	refcount_inc(&nbd->config_refs);
+	schedule_work(&nsock->work);
+}
+
 /*
  * Returns BLK_STS_RESOURCE if the caller should retry after a delay.
  * Returns BLK_STS_IOERR if sending failed.
@@ -699,11 +730,12 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 			 * completely done.
 			 */
 			if (sent) {
-				nsock->pending = req;
-				nsock->sent = sent;
+				nbd_run_pending_work(nbd, nsock, cmd, sent);
+				return BLK_STS_OK;
+			} else {
+				set_bit(NBD_CMD_REQUEUED, &cmd->flags);
+				return BLK_STS_RESOURCE;
 			}
-			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-			return BLK_STS_RESOURCE;
 		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
@@ -737,14 +769,8 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 			result = sock_xmit(nbd, index, 1, &from, flags, &sent);
 			if (result < 0) {
 				if (was_interrupted(result)) {
-					/* We've already sent the header, we
-					 * have no choice but to set pending and
-					 * return BUSY.
-					 */
-					nsock->pending = req;
-					nsock->sent = sent;
-					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-					return BLK_STS_RESOURCE;
+					nbd_run_pending_work(nbd, nsock, cmd, sent);
+					return BLK_STS_OK;
 				}
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
@@ -778,6 +804,44 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 	return BLK_STS_OK;
 }
 
+/* handle partial sending */
+static void nbd_pending_cmd_work(struct work_struct *work)
+{
+	struct nbd_sock *nsock = container_of(work, struct nbd_sock, work);
+	struct request *req = nsock->pending;
+	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
+	struct nbd_device *nbd = cmd->nbd;
+	unsigned long deadline = READ_ONCE(req->deadline);
+	unsigned int wait_ms = 2;
+
+	mutex_lock(&cmd->lock);
+
+	WARN_ON_ONCE(test_bit(NBD_CMD_REQUEUED, &cmd->flags));
+	if (!test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags))
+		goto out;
+
+	mutex_lock(&nsock->tx_lock);
+	while (true) {
+		nbd_send_cmd(nbd, cmd, cmd->index);
+		if (!nsock->pending)
+			break;
+
+		/* don't bother timeout handler for partial sending */
+		if (READ_ONCE(jiffies) + msecs_to_jiffies(wait_ms) >= deadline) {
+			cmd->status = BLK_STS_IOERR;
+			blk_mq_complete_request(req);
+			break;
+		}
+		msleep(wait_ms);
+		wait_ms *= 2;
+	}
+	mutex_unlock(&nsock->tx_lock);
+	clear_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
+out:
+	mutex_unlock(&cmd->lock);
+	nbd_config_put(nbd);
+}
+
 static int nbd_read_reply(struct nbd_device *nbd, struct socket *sock,
 			  struct nbd_reply *reply)
 {
@@ -1224,6 +1288,7 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	nsock->pending = NULL;
 	nsock->sent = 0;
 	nsock->cookie = 0;
+	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
 	socks[config->num_connections++] = nsock;
 	atomic_inc(&config->live_connections);
 	blk_mq_unfreeze_queue(nbd->disk->queue);
-- 
2.44.0

