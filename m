Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D6FD51C
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164798; cv=none; b=rU8MH+erQGZD06Ns+6OD/RuOxpmnSLG+oId27+xhN56xiMc/QDDyTpR4ZC6RapYJuIoI4b8mWymsdQVqRBGeKUlAjRzQ4X3dBqDhrRiOVsXn7YBZDMpU4QCwcOh3KRG2YMxiR3WJA0mHP6e8g016swKbHS/hQT+RsqGbiPFcwFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164798; c=relaxed/simple;
	bh=DrFZEom/tjC6u5UF/qKe9FYv7ahFDQxDW715s0oaNhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SUig0zHGiwCaJFcpLZi2ULgHgetQEFRRUokO1zKsKIis2hwsYiytp7eNBgBMLB26i1zqAu1pUdzOnB3nBjaxBzMGgqfgudoftcAvwgydjmaAb9fliML6O35eb6Z8ZYhYVoF4ki9ELmDwC7hUHC8YQjd74Am+o9O8N56gnGtTt68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJQhb8tD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJQhb8tD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730164794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WNMbK6tnCIQzJ9PMcLLLrD6cfAt4KQVqcwg0Zc03tMk=;
	b=BJQhb8tDylBbc9QrBBCt4R4rIFBgcBztL4wuKD3YV6ZSJDFMe9cojqc1gJ3BHZqAkVH5wr
	WJIzKsY3eMNlAFJAvH+7oNT1TwPTVA8GfI8lEUwseCMOVfMeASwsm/oKJ+e07mC3RKASFP
	fBaJthz5HSEKFXlURMbxDRLAdqHU3Jc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681--DC9ZPsLOzCaDUVTnjUf_Q-1; Mon,
 28 Oct 2024 21:19:53 -0400
X-MC-Unique: -DC9ZPsLOzCaDUVTnjUf_Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB88919560AE;
	Tue, 29 Oct 2024 01:19:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.82])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05FDF19560A2;
	Tue, 29 Oct 2024 01:19:48 +0000 (UTC)
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
Subject: [PATCH V3] nbd: fix partial sending
Date: Tue, 29 Oct 2024 09:19:41 +0800
Message-ID: <20241029011941.153037-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
V3:
	- rename nbd_run_pending_work()(Kevin)
	- warning on double schedule(Kevin)
	- cover requeue in handling pending work function

V2:
	- move pending retry to socket work function and return BLK_STS_OK, so that
	userspace can get chance to handle the signal(Kevin)


 drivers/block/nbd.c | 95 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b852050d8a96..a14a454ba0e8 100644
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
@@ -614,6 +624,30 @@ static inline int was_interrupted(int result)
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
+static void nbd_sched_pending_work(struct nbd_device *nbd,
+				   struct nbd_sock *nsock,
+				   struct nbd_cmd *cmd, int sent)
+{
+	struct request *req = blk_mq_rq_from_pdu(cmd);
+
+	/* pending work should be scheduled only once */
+	WARN_ON_ONCE(test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags));
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
@@ -699,8 +733,8 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 			 * completely done.
 			 */
 			if (sent) {
-				nsock->pending = req;
-				nsock->sent = sent;
+				nbd_sched_pending_work(nbd, nsock, cmd, sent);
+				return BLK_STS_OK;
 			}
 			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
 			return BLK_STS_RESOURCE;
@@ -737,14 +771,8 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
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
+					nbd_sched_pending_work(nbd, nsock, cmd, sent);
+					return BLK_STS_OK;
 				}
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
@@ -770,6 +798,14 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 	return BLK_STS_OK;
 
 requeue:
+	/*
+	 * Can't requeue in case we are dealing with partial send
+	 *
+	 * We must run from pending work function.
+	 * */
+	if (test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags))
+		return BLK_STS_OK;
+
 	/* retry on a different socket */
 	dev_err_ratelimited(disk_to_dev(nbd->disk),
 			    "Request send failed, requeueing\n");
@@ -778,6 +814,44 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
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
+	if (WARN_ON_ONCE(!test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags)))
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
@@ -1224,6 +1298,7 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	nsock->pending = NULL;
 	nsock->sent = 0;
 	nsock->cookie = 0;
+	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
 	socks[config->num_connections++] = nsock;
 	atomic_inc(&config->live_connections);
 	blk_mq_unfreeze_queue(nbd->disk->queue);
-- 
2.44.0

