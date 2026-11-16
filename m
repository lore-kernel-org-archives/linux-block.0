Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865705;
	b=x5c4ueyMhNdH6MFn0ccstuOO59VARoU9yntmVA2JFqmxofLemyE/xBVCegUNXqWUvOmM
	 Nq78gDPiQWC5ssRWHFLumXwDwCzdq2pmSgakEiT/XO1w1xR10hyKb/3xDfgU6j+ZRUOgm
	 8YfwWGunye7TFQxl/VgwVajk92nKBGCA1rLAQ5drcd5pv8+aySJkeqe4kknbMJTiYzcOn
	 7uLMpvCEVTmkPxQXMyaHmGVSZ9MUsmh1qSZn6vA2CPZkFWyumxNb/HWxxbrsvf8ephw9Y
	 rBg+MIDbv5xKAJQ28fHpfk1fr2lTiBA9Jo3+B7bXbgfwKkbCUYAj/EbxLTO1ZQeKmqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Dz8CbyIcyRsbPdtBGhM1jybkO5ORrgBtDiK5T4j0DPw=;
	b=ODXkGduJYeUmy8+vIrh1QO/kWBVPhhFsqeIF34T2v0aSK31ZEFrEkuC3Jni6wJY1BVQH
	 4IQ7hQiE0IHnOWbIRAJ7P5l3TCSsu+9LLP4Tm/HT94gVPiWRHXlsbpEKyj1tfWV5eql/A
	 ay8JLfIoOftPsPe6JW8Z42uzO+6mVOZjyqleYptjhNGv2FBLx3Pfq1F7z34jwYdrIgW80
	 nrGu7IHWRGd+0ndoLHjh2uNmTbP75+A++37bQUzyJkqp4FQynERpPDl8qbVV4zgpi63GQ
	 4Y802asxvUB7zfuCEn35Habj8T+H2sM7fvuTkle+Qag6oGdyCszfVgKhXHpmDRPZfYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=SR+sF+mr;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FA3606A32C
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 21:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4FA3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=SR+sF+mr
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jT1h83pHLzlpJ46;
	Mon, 16 Nov 2026 21:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794865698; x=1797457699; bh=Dz8Cb
	yIcyRsbPdtBGhM1jybkO5ORrgBtDiK5T4j0DPw=; b=SR+sF+mrzULTD5puC9SCF
	RAlqHH8cHdhhkgxrFJEIG/Vxuo8T7/6FgwzpIhXDKOWV9Huv00HLhUnQ9h/nrwgi
	1J8vX5NxFT6hGMJzAktIEw/clSwnZNriqQ/yU/GeXRqpr31H1aLXBJcoNYjIuSMY
	34XYkfohBc3rpJSEVkE5juHv5TY1z7sV2vdU6PNth5iKP6nR9W66ArPQCMV2MQt+
	4UQYR417JWKmxdU+bS7I3dvLtzZ2hYNY4ZUPjmzL9SIk5Dt8EJuFvrThbjShuUXF
	bBwwnhave9V44cCViyM5raBXcVuVJs9MAVYUjAc9ZZAeUMXfafeHXRHtqEqUGSkB
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1D2dlVNE6wup; Mon, 16 Nov 2026 21:48:18 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jT1h04vjGzlpHwn;
	Mon, 16 Nov 2026 21:48:16 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Aibing Chen <chenaibing@cmss.chinamobile.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 3/8] nbd: Stop taking a config_refs reference per request
Date: Mon, 16 Nov 2026 13:48:03 -0800
Message-ID: <bb40820497231f3ced93f6996ccce150975fae74.1794865298.git.bvanassche@acm.org>
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

Check refcount_read(&nbd->config_refs) instead of calling
nbd_get_config_unlocked() and nbd_config_put() for every request in
nbd_handle_cmd(), and use refcount_inc_not_zero() in
nbd_sched_pending_work().

nbd_config_put() calls nbd_clear_sock() -> nbd_clear_que(), which
quiesces the request queue before freeing config->socks and nbd->config.
Any nbd_queue_rq() call that observes config_refs > 0 completes before
blk_mq_quiesce_queue() returns, and any nbd_queue_rq() call after
blk_mq_unquiesce_queue() observes either config_refs =3D=3D 0 or a newly
allocated configuration. The only other function that modifies
config->socks is nbd_add_socket(). It only runs before
nbd_start_device(), while the capacity is zero and the write cache is
disabled, so no request reaches the driver concurrently. Avoiding
nbd_config_put() in the request submission path also avoids acquiring
nbd->config_lock from the send workqueue when request transmission is
deferred to a workqueue.

If nbd_sched_pending_work() fails because config_refs dropped to zero
after part of a request has been sent, mark the socket dead so that no
other request is sent after the truncated request.

Use smp_wmb() instead of smp_mb__before_atomic() in
nbd_alloc_and_init_config() because refcount_set() is not a
read-modify-write operation, and document both readers that pair with
this barrier.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 67 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 64f2265fb5d9..6373363cc4c4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -629,11 +629,16 @@ static inline int was_interrupted(int result)
  * We've already sent header or part of data payload, have no choice but
  * to set pending and schedule it in work.
  *
- * And we have to return BLK_STS_OK to block core, otherwise this same
- * request may be re-dispatched with different tag, but our header has
- * been sent out with old tag, and this way does confuse reply handling.
+ * The request must not be requeued, otherwise this same request may be
+ * re-dispatched with different tag, but our header has been sent out wi=
th
+ * old tag, and this way does confuse reply handling.
+ *
+ * Returns true if nsock->work has been scheduled. Returns false if no
+ * config_refs reference could be obtained because the device is being t=
orn
+ * down. In that case the caller must mark @nsock dead, since a truncate=
d
+ * request has been sent, and fail the request.
  */
-static void nbd_sched_pending_work(struct nbd_device *nbd,
+static bool nbd_sched_pending_work(struct nbd_device *nbd,
 				   struct nbd_sock *nsock,
 				   struct nbd_cmd *cmd, int sent)
 {
@@ -642,11 +647,14 @@ static void nbd_sched_pending_work(struct nbd_devic=
e *nbd,
 	/* pending work should be scheduled only once */
 	WARN_ON_ONCE(test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags));
=20
+	if (!refcount_inc_not_zero(&nbd->config_refs))
+		return false;
+
 	nsock->pending =3D req;
 	nsock->sent =3D sent;
 	set_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
-	refcount_inc(&nbd->config_refs);
 	schedule_work(&nsock->work);
+	return true;
 }
=20
 /*
@@ -734,8 +742,16 @@ static blk_status_t nbd_send_cmd(struct nbd_device *=
nbd, struct nbd_cmd *cmd,
 			 * completely done.
 			 */
 			if (sent) {
-				nbd_sched_pending_work(nbd, nsock, cmd, sent);
-				return BLK_STS_OK;
+				if (nbd_sched_pending_work(nbd, nsock, cmd,
+							   sent))
+					return BLK_STS_OK;
+				/*
+				 * Don't send anything after a truncated request.
+				 * The device is being torn down, so don't notify
+				 * user space that the link is dead.
+				 */
+				nbd_mark_nsock_dead(nbd, nsock, 0);
+				return BLK_STS_IOERR;
 			}
 			nbd_requeue_cmd(cmd);
 			return BLK_STS_OK;
@@ -772,8 +788,11 @@ static blk_status_t nbd_send_cmd(struct nbd_device *=
nbd, struct nbd_cmd *cmd,
 			result =3D sock_xmit(nbd, index, 1, &from, flags, &sent);
 			if (result < 0) {
 				if (was_interrupted(result)) {
-					nbd_sched_pending_work(nbd, nsock, cmd, sent);
-					return BLK_STS_OK;
+					if (nbd_sched_pending_work(nbd, nsock,
+								   cmd, sent))
+						return BLK_STS_OK;
+					nbd_mark_nsock_dead(nbd, nsock, 0);
+					return BLK_STS_IOERR;
 				}
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
@@ -1126,17 +1145,28 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd=
 *cmd, int index)
=20
 	lockdep_assert_held(&cmd->lock);
=20
-	config =3D nbd_get_config_unlocked(nbd);
-	if (!config) {
+	/*
+	 * No config_refs reference is held here. nbd->config and
+	 * config->socks remain valid because nbd_config_put() calls
+	 * nbd_clear_que(), which quiesces the request queue, before freeing
+	 * them. The only other place that modifies config->socks is
+	 * nbd_add_socket(). It only runs before nbd_start_device(), while the
+	 * capacity is zero and the write cache is disabled, so no request
+	 * reaches this driver concurrently (see also commit 285908f554fe
+	 * ("nbd: remove queue freeze in nbd_add_socket")).
+	 */
+	if (!refcount_read(&nbd->config_refs)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Socks array is empty\n");
 		return BLK_STS_IOERR;
 	}
+	/* Pairs with smp_wmb() in nbd_alloc_and_init_config(). */
+	smp_rmb();
+	config =3D READ_ONCE(nbd->config);
=20
 	if (index >=3D config->num_connections) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
-		nbd_config_put(nbd);
 		return BLK_STS_IOERR;
 	}
 	cmd->status =3D BLK_STS_OK;
@@ -1159,7 +1189,6 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *=
cmd, int index)
 			 * and instead just error out.
 			 */
 			sock_shutdown(nbd);
-			nbd_config_put(nbd);
 			return BLK_STS_IOERR;
 		}
 		goto again;
@@ -1179,7 +1208,6 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *=
cmd, int index)
 	ret =3D nbd_send_cmd(nbd, cmd, index);
 out:
 	mutex_unlock(&nsock->tx_lock);
-	nbd_config_put(nbd);
 	return ret;
 }
=20
@@ -1734,12 +1762,13 @@ static int nbd_alloc_and_init_config(struct nbd_d=
evice *nbd)
=20
 	nbd->config =3D config;
 	/*
-	 * Order refcount_set(&nbd->config_refs, 1) and nbd->config assignment,
-	 * its pair is the barrier in nbd_get_config_unlocked().
-	 * So nbd_get_config_unlocked() won't see nbd->config as null after
-	 * refcount_inc_not_zero() succeed.
+	 * Order the nbd->config assignment before refcount_set(), such that
+	 * readers that observe a non-zero config_refs also observe the new
+	 * nbd->config value. Pairs with the barrier after
+	 * refcount_inc_not_zero() in nbd_get_config_unlocked() and with the
+	 * smp_rmb() in nbd_handle_cmd().
 	 */
-	smp_mb__before_atomic();
+	smp_wmb(); /* Pairs with smp_rmb() and smp_mb__after_atomic(). */
 	refcount_set(&nbd->config_refs, 1);
=20
 	return 0;
