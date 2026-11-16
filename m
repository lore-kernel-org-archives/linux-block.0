Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865710;
	b=OCNsu2Vn7HuqtLP1h7x5hr+JC8ZF5+vaGsKJ5oGcZ46nd8DI0kpvxISd8tQzKgXzs+Xa
	 5nOFyvOSL5oSJrFu7NAv2ZlLnPfqlCLiYwFVPImPQtutfM7QlQxSDUmrcSmX5gCyZHuTz
	 Ju86mrf0eldEt1+DJrOg7UJ7fD62arl6r4sF1+uBe2TZ4WwhRGKEhGRIGUZ6qRQMLZBnA
	 hbmi1c1NffI/azRRx9KAmmo78DI8UjBLWRXmB4ZkQhYz5K/NUT58rPFnzE/Ke24FNm4tc
	 TFNZSKOKD7bnxyGXJEUjuqxEE4rPkSZNr4bI8UFV6bi0ylUxs8XJAOH73sya0IwJzAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=QhmfvHWDQOgNx3cI+gJFcFvX8YeaeMzEeD2gdw1+oAY=;
	b=FKX9W2xgoltdSY3Dpjm1rNhz29wVHUe9feWRD5zVy2Sh3UcGMwhjyN2VDHUsqc1Fnrc2
	 U5RRDUdJaHwKgYSDyEb/6rhx/sDMeMTNbR+M1ls2W6T49eT4cobDvaBivXemS5LOx8Jj/
	 u0gePFx0+0UQaE5FK0lIGeGdwHzixbteR6Y2Po9ghlJs661me9KEL2KQHY7wb83Qb1qTz
	 obBn0AxhDhftBJPGgvfaaYBshnUSthpUCEVpVwThW/YcpHqI80Bn5i0bn1WiqD7phougC
	 FMEXC8roQBxSu1cgUni7SEXTvs1jSEuh+l+gCMlEPIBEXtxHGT8Q1Tg5M/dOdIBAH0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=ZWz91koJ;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA95606A31C
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 21:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBA95606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=ZWz91koJ
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jT1hF36PWzlpHws;
	Mon, 16 Nov 2026 21:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794865699; x=1797457700; bh=Qhmfv
	HWDQOgNx3cI+gJFcFvX8YeaeMzEeD2gdw1+oAY=; b=ZWz91koJ5X+wdZKq6rDFG
	JgzWsM08wzjJnil5y738jx6+XHqAJLm/Ieu7vHATVeZ2XHAiueIuulQI8aojGYCI
	5DMIBjJvaOrbfs6s2Zvwl6+oVYq1/5QCYGEIRtlLlTD3c52Wu+opTNxU2PiFhytK
	9IUjoZoaIk5LH8gnCG3iBwE6ddTTe+B9vS8Y8U5L9aqfyvhQ3mivAx+GtvUhxpsO
	lESWr5kWyBENBCprG4JeLgg21I6EG4S+xfLrxXpsGcjGUC8mSLvozz9hKxLlMxv7
	HfLoJ9TZnL56VyHEeb8b2BD/N8F1hbDTbezKUpQSTl7cYKjGx9y7lNn2Qv5cb527
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Gi4JUBe0XLoi; Mon, 16 Nov 2026 21:48:19 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jT1h1086tzlpHxY;
	Mon, 16 Nov 2026 21:48:16 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Aibing Chen <chenaibing@cmss.chinamobile.com>,
	Bart Van Assche <bvanassche@acm.org>,
	syzbot+a761911cb2560f3ca2f7@syzkaller.appspotmail.com,
	syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com,
	syzbot+e0faf21748da6475085c@syzkaller.appspotmail.com
Subject: [PATCH 4/8] nbd: Defer request transmission to a workqueue
Date: Mon, 16 Nov 2026 13:48:04 -0800
Message-ID: <a06a0e569bc1612d1808c82ea8271555fd1e5b1f.1794865298.git.bvanassche@acm.org>
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

Transmit requests from a per-device unbound workqueue using a per-socket
command list and work item instead of transmitting directly from
nbd_queue_rq(), similar to the loop driver.

Transmitting over a socket directly from nbd_queue_rq() acquires
cmd->lock, nsock->tx_lock, and sk_lock while blk-mq holds
q->q_usage_counter, q->elevator_lock, and set->srcu. Because NBD sockets
are created and owned by user space, other operations on those sockets
or sockets sharing the same lockdep class acquire sk_lock before memory
reclaim (fs_reclaim), mm->mmap_lock, or other subsystem locks, causing
circular lockdep dependency reports.

Break this dependency chain by queueing commands onto a per-socket
cmd_list protected by a spinlock in nbd_queue_rq() and performing socket
transmission from a workqueue under memalloc_noio_save().

Keep BLK_MQ_F_BLOCKING although nbd_queue_rq() no longer sleeps. With
that flag, blk_mq_quiesce_queue() waits for an SRCU grace period of the
tag set instead of a system-wide RCU grace period. nbd_clear_que() is
called for every NBD_CLEAR_SOCK ioctl and every configuration teardown,
and dropping the flag makes blktests nbd/003 about 20 times slower. Since
nbd_queue_rq() only acquires the nsock->cmd_lock spinlock while holding
set->srcu, keeping the flag does not reintroduce the lockdep dependency
chains described above.

Allocate the send workqueue with the same flags as the receive
workqueue. WQ_MEM_RECLAIM is required because the send workqueue is in
the writeback path, e.g. for swap over NBD, and because nbd_clear_que()
flushes it from recv_work() and from the block layer timeout handler,
both of which may run on WQ_MEM_RECLAIM workqueues. Do not use
WQ_FREEZABLE since request transmission was not frozen during system
suspend before this change.

Since request transmission now happens from a kernel worker thread, no
signal can be pending while sending and the partial-send handling in
nbd_send_cmd() is only kept for robustness. Destroy the send workqueue
before freeing the tag set in nbd_dev_remove().

Fixes: ffa1e7ada456 ("block: Make request_queue lockdep splats show up ea=
rlier")
Reported-by: syzbot+a761911cb2560f3ca2f7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6aec646f.aca85a03.3b899.0000.GAE@goo=
gle.com/
Reported-by: syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6aec66fc.059f5055.2712e4.0001.GAE@go=
ogle.com/
Reported-by: syzbot+e0faf21748da6475085c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6aec699e.73adde43.12e2c1.0001.GAE@go=
ogle.com/
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 158 +++++++++++++++++++++++++++++++-------------
 1 file changed, 112 insertions(+), 46 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6373363cc4c4..4d362e3cc395 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -63,6 +63,10 @@ struct nbd_sock {
 	int fallback_index;
 	int cookie;
 	struct work_struct work;
+	spinlock_t cmd_lock;
+	struct list_head cmd_list;
+	struct work_struct tx_work;
+	int index;
 };
=20
 struct recv_thread_args {
@@ -123,6 +127,7 @@ struct nbd_device {
 	struct mutex config_lock;
 	struct gendisk *disk;
 	struct workqueue_struct *recv_workq;
+	struct workqueue_struct *send_workq;
 	struct work_struct remove_work;
=20
 	struct list_head list;
@@ -136,7 +141,7 @@ struct nbd_device {
=20
 #define NBD_CMD_REQUEUED	1
 /*
- * This flag will be set if nbd_queue_rq() succeed, and will be checked =
and
+ * This flag will be set if nbd_send_cmd() succeeded, and will be checke=
d and
  * cleared in completion. Both setting and clearing of the flag are prot=
ected
  * by cmd->lock.
  */
@@ -148,6 +153,7 @@ struct nbd_device {
 struct nbd_cmd {
 	struct nbd_device *nbd;
 	struct mutex lock;
+	struct list_head list_entry;
 	int index;
 	int cookie;
 	int retries;
@@ -267,6 +273,7 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 	struct gendisk *disk =3D nbd->disk;
=20
 	del_gendisk(disk);
+	destroy_workqueue(nbd->send_workq);
 	blk_mq_free_tag_set(&nbd->tag_set);
=20
 	/*
@@ -1080,6 +1087,7 @@ static bool nbd_clear_req(struct request *req, void=
 *data)
 static void nbd_clear_que(struct nbd_device *nbd)
 {
 	blk_mq_quiesce_queue(nbd->disk->queue);
+	flush_workqueue(nbd->send_workq);
 	blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_clear_req, NULL);
 	blk_mq_unquiesce_queue(nbd->disk->queue);
 	dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
@@ -1139,36 +1147,12 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd=
 *cmd, int index)
 {
 	struct request *req =3D blk_mq_rq_from_pdu(cmd);
 	struct nbd_device *nbd =3D cmd->nbd;
-	struct nbd_config *config;
+	struct nbd_config *config =3D nbd->config;
 	struct nbd_sock *nsock;
 	blk_status_t ret;
=20
 	lockdep_assert_held(&cmd->lock);
=20
-	/*
-	 * No config_refs reference is held here. nbd->config and
-	 * config->socks remain valid because nbd_config_put() calls
-	 * nbd_clear_que(), which quiesces the request queue, before freeing
-	 * them. The only other place that modifies config->socks is
-	 * nbd_add_socket(). It only runs before nbd_start_device(), while the
-	 * capacity is zero and the write cache is disabled, so no request
-	 * reaches this driver concurrently (see also commit 285908f554fe
-	 * ("nbd: remove queue freeze in nbd_add_socket")).
-	 */
-	if (!refcount_read(&nbd->config_refs)) {
-		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Socks array is empty\n");
-		return BLK_STS_IOERR;
-	}
-	/* Pairs with smp_wmb() in nbd_alloc_and_init_config(). */
-	smp_rmb();
-	config =3D READ_ONCE(nbd->config);
-
-	if (index >=3D config->num_connections) {
-		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Attempted send on invalid socket\n");
-		return BLK_STS_IOERR;
-	}
 	cmd->status =3D BLK_STS_OK;
 again:
 	nsock =3D config->socks[index];
@@ -1189,6 +1173,7 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *=
cmd, int index)
 			 * and instead just error out.
 			 */
 			sock_shutdown(nbd);
+			blk_mq_start_request(req);
 			return BLK_STS_IOERR;
 		}
 		goto again;
@@ -1211,33 +1196,98 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd=
 *cmd, int index)
 	return ret;
 }
=20
+static void nbd_tx_work(struct work_struct *work)
+{
+	struct nbd_sock *nsock =3D container_of(work, struct nbd_sock, tx_work)=
;
+	struct nbd_cmd *cmd;
+	unsigned int memflags;
+
+	/* See nbd_queue_rq() for why nsock and nbd->config remain valid. */
+	memflags =3D memalloc_noio_save();
+
+	spin_lock(&nsock->cmd_lock);
+	while (!list_empty(&nsock->cmd_list)) {
+		struct request *req;
+		blk_status_t ret;
+
+		cmd =3D list_first_entry(&nsock->cmd_list, struct nbd_cmd,
+				       list_entry);
+		list_del_init(&cmd->list_entry);
+		spin_unlock(&nsock->cmd_lock);
+
+		req =3D blk_mq_rq_from_pdu(cmd);
+		/*
+		 * Since we look at the bio's to send the request over the
+		 * network we need to make sure the completion work doesn't
+		 * mark this request done before we are done doing our send.
+		 * This keeps us from dereferencing freed data if we have
+		 * particularly fast completions (ie we get the completion
+		 * before we exit sock_xmit on the last bvec) or in the case
+		 * that the server is misbehaving (or there was an error)
+		 * before we're done sending everything over the wire.
+		 */
+		mutex_lock(&cmd->lock);
+		clear_bit(NBD_CMD_REQUEUED, &cmd->flags);
+		ret =3D nbd_handle_cmd(cmd, nsock->index);
+		if (ret !=3D BLK_STS_OK)
+			cmd->status =3D ret;
+		mutex_unlock(&cmd->lock);
+
+		if (ret !=3D BLK_STS_OK)
+			blk_mq_complete_request(req);
+
+		cond_resched();
+
+		spin_lock(&nsock->cmd_lock);
+	}
+	spin_unlock(&nsock->cmd_lock);
+
+	memalloc_noio_restore(memflags);
+}
+
 static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 			const struct blk_mq_queue_data *bd)
 {
-	struct nbd_cmd *cmd =3D blk_mq_rq_to_pdu(bd->rq);
-	blk_status_t ret;
+	struct request *req =3D bd->rq;
+	struct nbd_cmd *cmd =3D blk_mq_rq_to_pdu(req);
+	struct nbd_device *nbd =3D cmd->nbd;
+	struct nbd_config *config;
+	struct nbd_sock *nsock;
+	unsigned int index =3D hctx->queue_num;
=20
 	/*
-	 * Since we look at the bio's to send the request over the network we
-	 * need to make sure the completion work doesn't mark this request done
-	 * before we are done doing our send.  This keeps us from dereferencing
-	 * freed data if we have particularly fast completions (ie we get the
-	 * completion before we exit sock_xmit on the last bvec) or in the case
-	 * that the server is misbehaving (or there was an error) before we're
-	 * done sending everything over the wire.
+	 * No config_refs reference is held here or in nbd_tx_work().
+	 * nbd->config and config->socks remain valid because
+	 * nbd_config_put() calls nbd_clear_que(), which quiesces the request
+	 * queue and flushes nbd->send_workq, before freeing them. The only
+	 * other place that modifies config->socks is nbd_add_socket(). It only
+	 * runs before nbd_start_device(), while the capacity is zero and the
+	 * write cache is disabled, so no request reaches this driver
+	 * concurrently (see also commit 285908f554fe ("nbd: remove queue freez=
e
+	 * in nbd_add_socket")).
 	 */
-	mutex_lock(&cmd->lock);
-	clear_bit(NBD_CMD_REQUEUED, &cmd->flags);
+	if (!refcount_read(&nbd->config_refs)) {
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Socks array is empty\n");
+		return BLK_STS_IOERR;
+	}
+	/* Pairs with smp_wmb() in nbd_alloc_and_init_config(). */
+	smp_rmb();
+	config =3D READ_ONCE(nbd->config);
=20
-	/* We can be called directly from the user space process, which means w=
e
-	 * could possibly have signals pending so our sendmsg will fail.  In
-	 * this case we need to return that we are busy, otherwise error out as
-	 * appropriate.
-	 */
-	ret =3D nbd_handle_cmd(cmd, hctx->queue_num);
-	mutex_unlock(&cmd->lock);
+	if (index >=3D config->num_connections) {
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Attempted send on invalid socket\n");
+		return BLK_STS_IOERR;
+	}
=20
-	return ret;
+	nsock =3D config->socks[index];
+	spin_lock(&nsock->cmd_lock);
+	list_add_tail(&cmd->list_entry, &nsock->cmd_list);
+	queue_work(nbd->send_workq, &nsock->tx_work);
+	spin_unlock(&nsock->cmd_lock);
+
+	return BLK_STS_OK;
 }
=20
 static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned lo=
ng fd,
@@ -1364,6 +1414,10 @@ static int nbd_add_socket(struct nbd_device *nbd, =
unsigned long arg,
 	nsock->pending =3D NULL;
 	nsock->sent =3D 0;
 	nsock->cookie =3D 0;
+	nsock->index =3D config->num_connections;
+	spin_lock_init(&nsock->cmd_lock);
+	INIT_LIST_HEAD(&nsock->cmd_list);
+	INIT_WORK(&nsock->tx_work, nbd_tx_work);
 	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
 	socks[config->num_connections++] =3D nsock;
 	atomic_inc(&config->live_connections);
@@ -1766,7 +1820,7 @@ static int nbd_alloc_and_init_config(struct nbd_dev=
ice *nbd)
 	 * readers that observe a non-zero config_refs also observe the new
 	 * nbd->config value. Pairs with the barrier after
 	 * refcount_inc_not_zero() in nbd_get_config_unlocked() and with the
-	 * smp_rmb() in nbd_handle_cmd().
+	 * smp_rmb() in nbd_queue_rq().
 	 */
 	smp_wmb(); /* Pairs with smp_rmb() and smp_mb__after_atomic(). */
 	refcount_set(&nbd->config_refs, 1);
@@ -1965,6 +2019,7 @@ static int nbd_init_request(struct blk_mq_tag_set *=
set, struct request *rq,
 	struct nbd_cmd *cmd =3D blk_mq_rq_to_pdu(rq);
 	cmd->nbd =3D set->driver_data;
 	cmd->flags =3D 0;
+	INIT_LIST_HEAD(&cmd->list_entry);
 	mutex_init(&cmd->lock);
 	return 0;
 }
@@ -2040,6 +2095,15 @@ static struct nbd_device *nbd_dev_add(int index, u=
nsigned int refs,
 		goto out_err_disk;
 	}
=20
+	nbd->send_workq =3D alloc_workqueue("nbd%d-send",
+					  WQ_MEM_RECLAIM | WQ_HIGHPRI |
+					  WQ_UNBOUND, 0, nbd->index);
+	if (!nbd->send_workq) {
+		dev_err(disk_to_dev(nbd->disk), "Could not allocate knbd send work que=
ue.\n");
+		err =3D -ENOMEM;
+		goto out_free_recv_work;
+	}
+
 	mutex_init(&nbd->config_lock);
 	refcount_set(&nbd->config_refs, 0);
 	/*
@@ -2066,6 +2130,8 @@ static struct nbd_device *nbd_dev_add(int index, un=
signed int refs,
 	return nbd;
=20
 out_free_work:
+	destroy_workqueue(nbd->send_workq);
+out_free_recv_work:
 	destroy_workqueue(nbd->recv_workq);
 out_err_disk:
 	put_disk(disk);
