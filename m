Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3A5028A;
	Fri, 10 May 2024 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372643; cv=none; b=KMnw1hpj2NDHuXcFmLSh3tVN0NhePqXW6cpwOunqB9Jd26yG3ac8duyunweo6QjbgRKjOSml5DUuOu19wwZKyI22Xiz6xeVCbjGX9dhbi3KOrpBneQ51ZTTiIyquTCjisA7U3VMXG6JEmhDrHUVMfO9eNrDxXW1Za4xjSAf4Bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372643; c=relaxed/simple;
	bh=+lwJebfu+is0C5ZFW/N58T0glXMTb8j4kdQ+8l6sE5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hptN3aC6fUjmYvOJO3XFxIgjmH5R9HZFqtAR+te/I5o0UQFnKL9pPfrlXAsX9UMe8n+eevg8T2/ZqspJ4AQjjAzBysfS7ULVZjO/cWlU9mXqmAS2ZiByEes+IBh1pcHQNK3aWjjam63KyX/ESQ50AX3IB1PfVe6LdJgDekxfWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EdX7PlBx; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EdX7PlBx"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VbgLt6ql4z6Cnk95;
	Fri, 10 May 2024 20:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1715372608; x=1717964609; bh=OdB1l
	/QW8mmPj53pOGxXVfdkmJXzlBmjUEF1G2X1fQQ=; b=EdX7PlBx8/nke0an3J4Gy
	az+/Gc+opZwjZOJI1X9YFceoNSTKIAuAcRZia+xBIWd9uyWZMDdq1XMFs8w8oo0r
	uFJWGmDRwaEryNrx4GJQ+vIXLQyt8TSWFiez/AM1CQpsisG+kL/YiRncIaqnuXhZ
	kRm+qe0XFMOB7eFwxKNd7010wTvctg1ubOahf7RCik1uO4jhGiP+tTUvvOhjADbg
	nSmi2zZgx01BcEei9lHJLU32OdAQgzGi46zUe7ob+W/PNADfNQ+ROk32RcALiwAS
	ilWmJAkxLsYnGvkjxRwfdU2CTDOj0DtIETT5yax9nIA13bF+gqOFmlJMCypFZ3lI
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1fI7r24ppDBx; Fri, 10 May 2024 20:23:28 +0000 (UTC)
Received: from asus.hsd1.ca.comcast.net (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VbgLl1jRsz6Cnk8y;
	Fri, 10 May 2024 20:23:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Josef Bacik <jbacik@fb.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Markus Pargmann <mpa@pengutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 5/5] nbd: Fix signal handling
Date: Fri, 10 May 2024 13:23:13 -0700
Message-ID: <20240510202313.25209-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510202313.25209-1-bvanassche@acm.org>
References: <20240510202313.25209-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Both nbd_send_cmd() and nbd_handle_cmd() return either a negative error
number or a positive blk_status_t value. nbd_queue_rq() converts these
return values into a blk_status_t value. There is a bug in the conversion
code: if nbd_send_cmd() returns BLK_STS_RESOURCE, nbd_queue_rq() should
return BLK_STS_RESOURCE instead of BLK_STS_OK. Fix this, move the
conversion code into nbd_handle_cmd() and fix the remaining sparse warnin=
gs.

This patch fixes the following sparse warnings:

drivers/block/nbd.c:673:32: warning: incorrect type in return expression =
(different base types)
drivers/block/nbd.c:673:32:    expected int
drivers/block/nbd.c:673:32:    got restricted blk_status_t [usertype]
drivers/block/nbd.c:714:48: warning: incorrect type in return expression =
(different base types)
drivers/block/nbd.c:714:48:    expected int
drivers/block/nbd.c:714:48:    got restricted blk_status_t [usertype]
drivers/block/nbd.c:1120:21: warning: incorrect type in assignment (diffe=
rent base types)
drivers/block/nbd.c:1120:21:    expected int [assigned] ret
drivers/block/nbd.c:1120:21:    got restricted blk_status_t [usertype]
drivers/block/nbd.c:1125:16: warning: incorrect type in return expression=
 (different base types)
drivers/block/nbd.c:1125:16:    expected restricted blk_status_t
drivers/block/nbd.c:1125:16:    got int [assigned] ret

Cc: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
Fixes: fc17b6534eb8 ("blk-mq: switch ->queue_rq return value to blk_statu=
s_t")
Cc: stable@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 29e43ab1650c..22a79a62cc4e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -588,6 +588,10 @@ static inline int was_interrupted(int result)
 	return result =3D=3D -ERESTARTSYS || result =3D=3D -EINTR;
 }
=20
+/*
+ * Returns BLK_STS_RESOURCE if the caller should retry after a delay. Re=
turns
+ * -EAGAIN if the caller should requeue @cmd. Returns -EIO if sending fa=
iled.
+ */
 static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int=
 index)
 {
 	struct request *req =3D blk_mq_rq_from_pdu(cmd);
@@ -670,7 +674,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struc=
t nbd_cmd *cmd, int index)
 				nsock->sent =3D sent;
 			}
 			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-			return BLK_STS_RESOURCE;
+			return (__force int)BLK_STS_RESOURCE;
 		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
@@ -711,7 +715,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struc=
t nbd_cmd *cmd, int index)
 					nsock->pending =3D req;
 					nsock->sent =3D sent;
 					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-					return BLK_STS_RESOURCE;
+					return (__force int)BLK_STS_RESOURCE;
 				}
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
@@ -1008,7 +1012,7 @@ static int wait_for_reconnect(struct nbd_device *nb=
d)
 	return !test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags);
 }
=20
-static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
+static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 {
 	struct request *req =3D blk_mq_rq_from_pdu(cmd);
 	struct nbd_device *nbd =3D cmd->nbd;
@@ -1022,14 +1026,14 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, in=
t index)
 	if (!config) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Socks array is empty\n");
-		return -EINVAL;
+		return BLK_STS_IOERR;
 	}
=20
 	if (index >=3D config->num_connections) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
 		nbd_config_put(nbd);
-		return -EINVAL;
+		return BLK_STS_IOERR;
 	}
 	cmd->status =3D BLK_STS_OK;
 again:
@@ -1052,7 +1056,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int =
index)
 			 */
 			sock_shutdown(nbd);
 			nbd_config_put(nbd);
-			return -EIO;
+			return BLK_STS_IOERR;
 		}
 		goto again;
 	}
@@ -1065,7 +1069,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int =
index)
 	blk_mq_start_request(req);
 	if (unlikely(nsock->pending && nsock->pending !=3D req)) {
 		nbd_requeue_cmd(cmd);
-		ret =3D 0;
+		ret =3D BLK_STS_OK;
 		goto out;
 	}
 	/*
@@ -1084,19 +1088,19 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, in=
t index)
 				    "Request send failed, requeueing\n");
 		nbd_mark_nsock_dead(nbd, nsock, 1);
 		nbd_requeue_cmd(cmd);
-		ret =3D 0;
+		ret =3D BLK_STS_OK;
 	}
 out:
 	mutex_unlock(&nsock->tx_lock);
 	nbd_config_put(nbd);
-	return ret;
+	return ret < 0 ? BLK_STS_IOERR : (__force blk_status_t)ret;
 }
=20
 static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 			const struct blk_mq_queue_data *bd)
 {
 	struct nbd_cmd *cmd =3D blk_mq_rq_to_pdu(bd->rq);
-	int ret;
+	blk_status_t ret;
=20
 	/*
 	 * Since we look at the bio's to send the request over the network we
@@ -1116,10 +1120,6 @@ static blk_status_t nbd_queue_rq(struct blk_mq_hw_=
ctx *hctx,
 	 * appropriate.
 	 */
 	ret =3D nbd_handle_cmd(cmd, hctx->queue_num);
-	if (ret < 0)
-		ret =3D BLK_STS_IOERR;
-	else if (!ret)
-		ret =3D BLK_STS_OK;
 	mutex_unlock(&cmd->lock);
=20
 	return ret;
