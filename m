Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865708;
	b=P7IwpzA6uZCEzE+VdzZB5FhVXKSWJHRN0UDY+LzEdu0Voy8yx4EOu2tZpqgzKb/mzjFb
	 LuH5DUkksiwZilHuciNOL7jZE4Y2LHpQKUxooUKf74uG3gZXFuiKYhW6+wtFc/Gc2wTR2
	 R8kJaemd900p702DotNYKGOkzvNuBuTH1XSoueqeBENW1GYSSX/o7sIvnlzvEQXiJcfXQ
	 zG1T88kqPxH5NCVp3BmsVGpBLnDqjbUYQrQLZb+83vtr8i6xSrEb18FhVnnzD5Z/HZ8GU
	 NLkwGaq0AUYqXZWOVpRMPPDEuZ0tgJb9qU1VgJm7lByJfZ1U3UOPnqNFy1WETZBhvqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=SA+ugrH06z9Kyf3DVP9ZAFZyQyDdMdcbBTuzq5d9rr0=;
	b=fsEu99Hhrmaar6MqkRmFd6qVwVEOXog+cpJTLePJ+GeN/KPIZBGQ7BccvVe4MipTFW9+
	 RKfeLpuRfThJyg3rvk56xhc0qt4rZH7jfpYjOC4wbwrWdUqNotX2lsrM+PgihoSP45xM+
	 iSGwYesGzQg38fLaYJNIdcRO2YpNcFcVD30z+XCKU2mYK63t9H+WAiabeQYWtexSf5JC1
	 5LbzAIK67NiLR1h/blirIpUWub3z2xuGFe2hGMzU5nGgrcdgV4XYUJLlz+CL+xUTgXFIe
	 r49RiVYFE7EnfDPsi79DJcmq3pZEplBnNUt362jDMAF5gZkMxDjcwIYh5ApPEiINW2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=xCypnHZl;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83B606A323
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 21:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F83B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=xCypnHZl
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jT1hC0SgfzlpHwn;
	Mon, 16 Nov 2026 21:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794865699; x=1797457700; bh=SA+ug
	rH06z9Kyf3DVP9ZAFZyQyDdMdcbBTuzq5d9rr0=; b=xCypnHZlMM2LTh+lzKU5R
	oi9Xbdy3yqra5WrctJqdbUuDFf0isubaEgRh5i4HXJxZdFLapDtJTBsIYgjRVY42
	JkWif7GuCiGnv8FaLxaHptGba1b8JS136QXoBxkALwAuUvaY+EPtpiWRYFktuSr9
	AkpMxNqTKSoQ83b0OGbBpbZOOn1zLlSpuSs45eWv3Xv9rrpUkDLu5PJmPKLSCkFM
	eUNYTtt6x28++U2BaEAykBqN7KmPyhvYO05nDiadx7NiuOwBpO9nrC9dAYacz3Tx
	2xfx8lXY6lY0jDayqia/8mHGrFgpdcz6pnUqQPDUc8SlvJBv2yvzZNgILqf4Lgb2
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wqjuQD8UzGkc; Mon, 16 Nov 2026 21:48:19 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jT1h21NnCzlpHxm;
	Mon, 16 Nov 2026 21:48:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Aibing Chen <chenaibing@cmss.chinamobile.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 7/8] nbd: Remove the partial-send handling
Date: Mon, 16 Nov 2026 13:48:07 -0800
Message-ID: <9edeabfb42318663d06c640604bb113aed3e8a9f.1794865298.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <cover.1794865298.git.bvanassche@acm.org>
References: <cover.1794865298.git.bvanassche@acm.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove was_interrupted(), nbd_sched_pending_work(),
nbd_pending_cmd_work(), NBD_CMD_PARTIAL_SEND and the nsock->pending,
nsock->sent and nsock->work members. Treat a failure of sock_xmit() in
nbd_send_cmd() the same way regardless of the error code: mark the socket
dead and requeue the request.

The partial-send handling was introduced for the case where sendmsg()
fails with -ERESTARTSYS or -EINTR because a signal is pending in the task
that called nbd_queue_rq(). Since requests are now transmitted from
nbd_tx_work(), which runs on a kernel worker thread, no signal can be
pending while sending and that code is unreachable. Other send errors,
including a send timeout after part of a request has been sent, already
mark the socket dead and requeue the request, so a truncated request is
never followed by another request on the same socket.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 178 +-------------------------------------------
 1 file changed, 3 insertions(+), 175 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index f713779b5a5d..3d834e4e1349 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -57,12 +57,9 @@ static int nbd_total_devices =3D 0;
 struct nbd_sock {
 	struct socket *sock;
 	struct mutex tx_lock;
-	struct request *pending;
-	int sent;
 	bool dead;
 	int fallback_index;
 	int cookie;
-	struct work_struct work;
 	spinlock_t cmd_lock;
 	struct list_head cmd_list;
 	struct work_struct tx_work;
@@ -147,9 +144,6 @@ struct nbd_device {
  */
 #define NBD_CMD_INFLIGHT	2
=20
-/* Just part of request header or data payload is sent successfully */
-#define NBD_CMD_PARTIAL_SEND	3
-
 struct nbd_cmd {
 	struct nbd_device *nbd;
 	struct mutex lock;
@@ -336,8 +330,6 @@ static void nbd_mark_nsock_dead(struct nbd_device *nb=
d, struct nbd_sock *nsock,
 		}
 	}
 	WRITE_ONCE(nsock->dead, true);
-	nsock->pending =3D NULL;
-	nsock->sent =3D 0;
 }
=20
 static void nbd_apply_limits(struct queue_limits *lim, u32 flags)
@@ -475,12 +467,6 @@ static enum blk_eh_timer_return nbd_xmit_timeout(str=
uct request *req)
 	if (!mutex_trylock(&cmd->lock))
 		return BLK_EH_RESET_TIMER;
=20
-	/* partial send is handled in nbd_sock's work function */
-	if (test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags)) {
-		mutex_unlock(&cmd->lock);
-		return BLK_EH_RESET_TIMER;
-	}
-
 	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
 		mutex_unlock(&cmd->lock);
 		return BLK_EH_DONE;
@@ -623,47 +609,6 @@ static int sock_xmit(struct nbd_device *nbd, int ind=
ex, int send,
 	return __sock_xmit(nbd, sock, send, iter, msg_flags, sent);
 }
=20
-/*
- * Different settings for sk->sk_sndtimeo can result in different return=
 values
- * if there is a signal pending when we enter sendmsg, because reasons?
- */
-static inline int was_interrupted(int result)
-{
-	return result =3D=3D -ERESTARTSYS || result =3D=3D -EINTR;
-}
-
-/*
- * We've already sent header or part of data payload, have no choice but
- * to set pending and schedule it in work.
- *
- * The request must not be requeued, otherwise this same request may be
- * re-dispatched with different tag, but our header has been sent out wi=
th
- * old tag, and this way does confuse reply handling.
- *
- * Returns true if nsock->work has been scheduled. Returns false if no
- * config_refs reference could be obtained because the device is being t=
orn
- * down. In that case the caller must mark @nsock dead, since a truncate=
d
- * request has been sent, and fail the request.
- */
-static bool nbd_sched_pending_work(struct nbd_device *nbd,
-				   struct nbd_sock *nsock,
-				   struct nbd_cmd *cmd, int sent)
-{
-	struct request *req =3D blk_mq_rq_from_pdu(cmd);
-
-	/* pending work should be scheduled only once */
-	WARN_ON_ONCE(test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags));
-
-	if (!refcount_inc_not_zero(&nbd->config_refs))
-		return false;
-
-	nsock->pending =3D req;
-	nsock->sent =3D sent;
-	set_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
-	schedule_work(&nsock->work);
-	return true;
-}
-
 /*
  * Returns BLK_STS_IOERR if sending failed and cannot be retried.
  */
@@ -681,7 +626,6 @@ static blk_status_t nbd_send_cmd(struct nbd_device *n=
bd, struct nbd_cmd *cmd,
 	u64 handle;
 	u32 type;
 	u32 nbd_cmd_flags =3D 0;
-	int sent =3D nsock->sent, skip =3D 0;
=20
 	lockdep_assert_held(&cmd->lock);
 	lockdep_assert_held(&nsock->tx_lock);
@@ -704,23 +648,7 @@ static blk_status_t nbd_send_cmd(struct nbd_device *=
nbd, struct nbd_cmd *cmd,
 	if ((req->cmd_flags & REQ_NOUNMAP) && (type =3D=3D NBD_CMD_WRITE_ZEROES=
))
 		nbd_cmd_flags |=3D NBD_CMD_FLAG_NO_HOLE;
=20
-	/* We did a partial send previously, and we at least sent the whole
-	 * request struct, so just go and send the rest of the pages in the
-	 * request.
-	 */
-	if (sent) {
-		if (sent >=3D sizeof(request)) {
-			skip =3D sent - sizeof(request);
-
-			/* initialize handle for tracing purposes */
-			handle =3D nbd_cmd_handle(cmd);
-
-			goto send_pages;
-		}
-		iov_iter_advance(&from, sent);
-	} else {
-		cmd->cmd_cookie++;
-	}
+	cmd->cmd_cookie++;
 	cmd->index =3D index;
 	cmd->cookie =3D nsock->cookie;
 	cmd->retries =3D 0;
@@ -738,36 +666,13 @@ static blk_status_t nbd_send_cmd(struct nbd_device =
*nbd, struct nbd_cmd *cmd,
 		req, nbdcmd_to_ascii(type),
 		(unsigned long long)blk_rq_pos(req) << 9, blk_rq_bytes(req));
 	result =3D sock_xmit(nbd, index, 1, &from,
-			(type =3D=3D NBD_CMD_WRITE) ? MSG_MORE : 0, &sent);
+			(type =3D=3D NBD_CMD_WRITE) ? MSG_MORE : 0, NULL);
 	trace_nbd_header_sent(req, handle);
 	if (result < 0) {
-		if (was_interrupted(result)) {
-			/*
-			 * If we haven't sent anything we can just requeue,
-			 * however if we have sent something we need to make
-			 * sure we only allow this req to be sent until we are
-			 * completely done.
-			 */
-			if (sent) {
-				if (nbd_sched_pending_work(nbd, nsock, cmd,
-							   sent))
-					return BLK_STS_OK;
-				/*
-				 * Don't send anything after a truncated request.
-				 * The device is being torn down, so don't notify
-				 * user space that the link is dead.
-				 */
-				nbd_mark_nsock_dead(nbd, nsock, 0);
-				return BLK_STS_IOERR;
-			}
-			nbd_requeue_cmd(cmd);
-			return BLK_STS_OK;
-		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
 		goto requeue;
 	}
-send_pages:
 	if (type !=3D NBD_CMD_WRITE)
 		goto out;
=20
@@ -784,23 +689,8 @@ static blk_status_t nbd_send_cmd(struct nbd_device *=
nbd, struct nbd_cmd *cmd,
 			dev_dbg(nbd_to_dev(nbd), "request %p: sending %d bytes data\n",
 				req, bvec.bv_len);
 			iov_iter_bvec(&from, ITER_SOURCE, &bvec, 1, bvec.bv_len);
-			if (skip) {
-				if (skip >=3D iov_iter_count(&from)) {
-					skip -=3D iov_iter_count(&from);
-					continue;
-				}
-				iov_iter_advance(&from, skip);
-				skip =3D 0;
-			}
-			result =3D sock_xmit(nbd, index, 1, &from, flags, &sent);
+			result =3D sock_xmit(nbd, index, 1, &from, flags, NULL);
 			if (result < 0) {
-				if (was_interrupted(result)) {
-					if (nbd_sched_pending_work(nbd, nsock,
-								   cmd, sent))
-						return BLK_STS_OK;
-					nbd_mark_nsock_dead(nbd, nsock, 0);
-					return BLK_STS_IOERR;
-				}
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
 					result);
@@ -819,20 +709,10 @@ static blk_status_t nbd_send_cmd(struct nbd_device =
*nbd, struct nbd_cmd *cmd,
 	}
 out:
 	trace_nbd_payload_sent(req, handle);
-	nsock->pending =3D NULL;
-	nsock->sent =3D 0;
 	__set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 	return BLK_STS_OK;
=20
 requeue:
-	/*
-	 * Can't requeue in case we are dealing with partial send
-	 *
-	 * We must run from pending work function.
-	 * */
-	if (test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags))
-		return BLK_STS_OK;
-
 	/* retry on a different socket */
 	dev_err_ratelimited(disk_to_dev(nbd->disk),
 			    "Request send failed, requeueing\n");
@@ -841,44 +721,6 @@ static blk_status_t nbd_send_cmd(struct nbd_device *=
nbd, struct nbd_cmd *cmd,
 	return BLK_STS_OK;
 }
=20
-/* handle partial sending */
-static void nbd_pending_cmd_work(struct work_struct *work)
-{
-	struct nbd_sock *nsock =3D container_of(work, struct nbd_sock, work);
-	struct request *req =3D nsock->pending;
-	struct nbd_cmd *cmd =3D blk_mq_rq_to_pdu(req);
-	struct nbd_device *nbd =3D cmd->nbd;
-	unsigned long deadline =3D READ_ONCE(req->deadline);
-	unsigned int wait_ms =3D 2;
-
-	mutex_lock(&cmd->lock);
-
-	WARN_ON_ONCE(test_bit(NBD_CMD_REQUEUED, &cmd->flags));
-	if (WARN_ON_ONCE(!test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags)))
-		goto out;
-
-	mutex_lock(&nsock->tx_lock);
-	while (true) {
-		nbd_send_cmd(nbd, cmd, cmd->index);
-		if (!nsock->pending)
-			break;
-
-		/* don't bother timeout handler for partial sending */
-		if (READ_ONCE(jiffies) + msecs_to_jiffies(wait_ms) >=3D deadline) {
-			cmd->status =3D BLK_STS_IOERR;
-			blk_mq_complete_request(req);
-			break;
-		}
-		msleep(wait_ms);
-		wait_ms *=3D 2;
-	}
-	mutex_unlock(&nsock->tx_lock);
-	clear_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
-out:
-	mutex_unlock(&cmd->lock);
-	nbd_config_put(nbd);
-}
-
 static int nbd_read_reply(struct nbd_device *nbd, struct socket *sock,
 			  struct nbd_reply *reply)
 {
@@ -1179,19 +1021,8 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd =
*cmd, int index)
 		goto again;
 	}
=20
-	/* Handle the case that we have a pending request that was partially
-	 * transmitted that _has_ to be serviced first.  We need to call requeu=
e
-	 * here so that it gets put _after_ the request that is already on the
-	 * dispatch list.
-	 */
 	blk_mq_start_request(req);
-	if (unlikely(nsock->pending && nsock->pending !=3D req)) {
-		nbd_requeue_cmd(cmd);
-		ret =3D BLK_STS_OK;
-		goto out;
-	}
 	ret =3D nbd_send_cmd(nbd, cmd, index);
-out:
 	mutex_unlock(&nsock->tx_lock);
 	return ret;
 }
@@ -1374,14 +1205,11 @@ static int nbd_add_socket(struct nbd_device *nbd,=
 unsigned long arg,
 	nsock->dead =3D false;
 	mutex_init(&nsock->tx_lock);
 	nsock->sock =3D sock;
-	nsock->pending =3D NULL;
-	nsock->sent =3D 0;
 	nsock->cookie =3D 0;
 	nsock->index =3D config->num_connections;
 	spin_lock_init(&nsock->cmd_lock);
 	INIT_LIST_HEAD(&nsock->cmd_list);
 	INIT_WORK(&nsock->tx_work, nbd_tx_work);
-	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
 	socks[config->num_connections++] =3D nsock;
 	atomic_inc(&config->live_connections);
=20
