Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AA113F442
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539377; cv=none; b=Z0UiFLIeDLXM1ijMhcbfvj/qkqkNNAHU895nRBOAF6JspQY7OA7oqYv4CiddLnxIlluRgWSVa2u7wnMkXiLiK5GION66z897TR6UagmaCHkg9C0hWhLdKoh9S7co3kW6botk6nMCfqJTG1hLHICsKYhp3f0cml7wAKFtJfdm50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539377; c=relaxed/simple;
	bh=JpBONwZ275W6iGtZ7UZNORepX2e+ESLldVu6Er/5X04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HC3ImkF4QiTaDKV7ZeBP7KB1qVqKh1fQpreaeTVIBZ+CLUE23MMPVsI3r3h1y/ncleTxhqDTf55H4iR2eZp4f777se7WKJRu3vgQDVqrf3Vff+1q0K7YnLv3J6AvXek+Id395XN3hozCoT4yUGmaSxETwe2m0ICgfSxDLUU8aVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kgXUb3a7; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kgXUb3a7"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vv4gM2ZrXzlgMVX;
	Tue,  4 Jun 2024 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1717539372; x=1720131373; bh=zeqJNKCfUJCRtBJB5894iwTgYpLtjj64akz
	7i16rY1g=; b=kgXUb3a7qUmqCb3a7msBnrXrzSMlV/qWHAvD2fmKEHSn8c7bT4V
	NwOb4Fp3aGNRHwnc119sA5BzAXOIup+agY6j1RI9hwl1Qif7SuIWmtJ3/+fkJgCu
	8oJ+CGx118BTloy9PN6UjKQADv/n1D6aAWOK9Atu/npie9vogid4Y1fBCydSmN8w
	rzgq55pDbtXxGwAtqve21mbprsgOGzrm20STNHRELdXcjoIVmE7GS5WyqtFkpIzE
	V3CGJfSRyZCq23dTjuBhH41CT2t53vvXj4u/c2wGX6FTgfjxn0QqEj35sJIXNKph
	SbZwbrlBI5Oj8XHGk8HNxCjYeqBGGRHonFQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sj2eadtbtZ0C; Tue,  4 Jun 2024 22:16:12 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vv4gH4BTbzlgMVV;
	Tue,  4 Jun 2024 22:16:11 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3] nbd: Remove __force casts
Date: Tue,  4 Jun 2024 16:15:31 -0600
Message-ID: <20240604221531.327131-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Hellwig <hch@lst.de>

Make it again possible for sparse to verify that blk_status_t and Unix
error codes are used in the proper context by making nbd_send_cmd()
return a blk_status_t instead of an integer.

No functionality has been changed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[ bvanassche: added description and made two small formatting changes ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 51 +++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

Changes compared to v2: fixed return type in the patch description.

Changes compared to v1: instead of making nbd_send_cmd() return a struct,
  change the nbd_send_cmd() return type into blk_status_t and move the co=
de
  for making a socket dead from the nbd_send_cmd() caller into nbd_send_c=
md().

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 22a79a62cc4e..b87aa80a46dd 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -589,10 +589,11 @@ static inline int was_interrupted(int result)
 }
=20
 /*
- * Returns BLK_STS_RESOURCE if the caller should retry after a delay. Re=
turns
- * -EAGAIN if the caller should requeue @cmd. Returns -EIO if sending fa=
iled.
+ * Returns BLK_STS_RESOURCE if the caller should retry after a delay.
+ * Returns BLK_STS_IOERR if sending failed.
  */
-static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int=
 index)
+static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd =
*cmd,
+				 int index)
 {
 	struct request *req =3D blk_mq_rq_from_pdu(cmd);
 	struct nbd_config *config =3D nbd->config;
@@ -614,13 +615,13 @@ static int nbd_send_cmd(struct nbd_device *nbd, str=
uct nbd_cmd *cmd, int index)
=20
 	type =3D req_to_nbd_cmd_type(req);
 	if (type =3D=3D U32_MAX)
-		return -EIO;
+		return BLK_STS_IOERR;
=20
 	if (rq_data_dir(req) =3D=3D WRITE &&
 	    (config->flags & NBD_FLAG_READ_ONLY)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Write on read-only\n");
-		return -EIO;
+		return BLK_STS_IOERR;
 	}
=20
 	if (req->cmd_flags & REQ_FUA)
@@ -674,11 +675,11 @@ static int nbd_send_cmd(struct nbd_device *nbd, str=
uct nbd_cmd *cmd, int index)
 				nsock->sent =3D sent;
 			}
 			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-			return (__force int)BLK_STS_RESOURCE;
+			return BLK_STS_RESOURCE;
 		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
-		return -EAGAIN;
+		goto requeue;
 	}
 send_pages:
 	if (type !=3D NBD_CMD_WRITE)
@@ -715,12 +716,12 @@ static int nbd_send_cmd(struct nbd_device *nbd, str=
uct nbd_cmd *cmd, int index)
 					nsock->pending =3D req;
 					nsock->sent =3D sent;
 					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-					return (__force int)BLK_STS_RESOURCE;
+					return BLK_STS_RESOURCE;
 				}
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
 					result);
-				return -EAGAIN;
+				goto requeue;
 			}
 			/*
 			 * The completion might already have come in,
@@ -737,7 +738,16 @@ static int nbd_send_cmd(struct nbd_device *nbd, stru=
ct nbd_cmd *cmd, int index)
 	trace_nbd_payload_sent(req, handle);
 	nsock->pending =3D NULL;
 	nsock->sent =3D 0;
-	return 0;
+	__set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
+	return BLK_STS_OK;
+
+requeue:
+	/* retry on a different socket */
+	dev_err_ratelimited(disk_to_dev(nbd->disk),
+			    "Request send failed, requeueing\n");
+	nbd_mark_nsock_dead(nbd, nsock, 1);
+	nbd_requeue_cmd(cmd);
+	return BLK_STS_OK;
 }
=20
 static int nbd_read_reply(struct nbd_device *nbd, struct socket *sock,
@@ -1018,7 +1028,7 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *=
cmd, int index)
 	struct nbd_device *nbd =3D cmd->nbd;
 	struct nbd_config *config;
 	struct nbd_sock *nsock;
-	int ret;
+	blk_status_t ret;
=20
 	lockdep_assert_held(&cmd->lock);
=20
@@ -1072,28 +1082,11 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd=
 *cmd, int index)
 		ret =3D BLK_STS_OK;
 		goto out;
 	}
-	/*
-	 * Some failures are related to the link going down, so anything that
-	 * returns EAGAIN can be retried on a different socket.
-	 */
 	ret =3D nbd_send_cmd(nbd, cmd, index);
-	/*
-	 * Access to this flag is protected by cmd->lock, thus it's safe to set
-	 * the flag after nbd_send_cmd() succeed to send request to server.
-	 */
-	if (!ret)
-		__set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
-	else if (ret =3D=3D -EAGAIN) {
-		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Request send failed, requeueing\n");
-		nbd_mark_nsock_dead(nbd, nsock, 1);
-		nbd_requeue_cmd(cmd);
-		ret =3D BLK_STS_OK;
-	}
 out:
 	mutex_unlock(&nsock->tx_lock);
 	nbd_config_put(nbd);
-	return ret < 0 ? BLK_STS_IOERR : (__force blk_status_t)ret;
+	return ret;
 }
=20
 static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
