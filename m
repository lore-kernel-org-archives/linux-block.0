Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A20169380
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717018645; cv=none; b=dj82NeEk4WCyZOiR/3W0TEHEg5F5pZjV3pWeHU3m3jEePRvcNhjZTi3s0QBGmoXdm4zDCdq8WUe1vZkBHlLMPZ3x+B/Zds4bVaXNMbWMqw1AsqvUYcBFLHm+kGUtSt/9A+EtWqOQ6iWpoMSMe00Bd3Ktrt5W/OcT8s7hMkqy6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717018645; c=relaxed/simple;
	bh=l46xl1LajyI/Us7v2xyUzH/bIZxgQ8coJAO8gtspyZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUEC6UHYwCbd6sUXDZlizJVd3BMEmblPKXhgc19Rtmee6z/TZCGRGeHBrOhdT4CAmbXIs5odcel9i85FMflv17Tgvxqhe5XDllSSJFM8n4MhKu1BeNfxTJ5hBougn2PKo7G+9+i2oK2Mp1ZfBy08GzswgQ6eycgLahE6Y/HqwWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IGkeDWLK; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IGkeDWLK"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VqN292gFwz6Cnk95;
	Wed, 29 May 2024 21:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1717018477; x=1719610478; bh=4bmLrKYutVND0jB9A4lMEaYM85t+c5DlEF5
	iZyHaqgY=; b=IGkeDWLKVhEPw4YjL0fsOVuQ1DDt3gYrAV1AibLqLAUEGYdLPqT
	yREKFiww2YuWJLvVeCYd9R/GSMf2ow8xBk776pi3Am/6FzUjzaWzKp2wTC+pqUtV
	ziSQE3rHiyHPsKgl4FClMDXM9mc9oAdJH1na8GpYecjraDBiNB7fzH3n7TgMczSc
	x5N7sI29JhBHZXKcwIQb4K2DsCjQKlesV+VYjSSKifGHtbyTPF3COS2hOGAJpLIG
	bYwEeZZJIphLrpV+0XQcRfVeSuuGI0OsLUcn8q56PZXZZSOcaL8nfo/TyJykhilf
	j3BoVgnHuBLgim/XTtdSo+f96OxIDuirK8Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 900zJwVsx6AQ; Wed, 29 May 2024 21:34:37 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VqN2456HQz6Cnk94;
	Wed, 29 May 2024 21:34:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] nbd: Remove __force casts
Date: Wed, 29 May 2024 14:34:26 -0700
Message-ID: <20240529213426.3165433-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make it again possible for sparse to verify that blk_status_t and Unix
error codes are used in the proper context by making nbd_send_cmd()
return a struct instead of an integer.

Additionally, move a misplaced comment to where it should occur.

No functionality has been changed.

Cc: Christoph Hellwig <hch@lst.de>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 22a79a62cc4e..4ee76c39e3a5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -588,11 +588,17 @@ static inline int was_interrupted(int result)
 	return result =3D=3D -ERESTARTSYS || result =3D=3D -EINTR;
 }
=20
+struct send_res {
+	int result;
+	blk_status_t status;
+};
+
 /*
  * Returns BLK_STS_RESOURCE if the caller should retry after a delay. Re=
turns
  * -EAGAIN if the caller should requeue @cmd. Returns -EIO if sending fa=
iled.
  */
-static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int=
 index)
+static struct send_res nbd_send_cmd(struct nbd_device *nbd, struct nbd_c=
md *cmd,
+				    int index)
 {
 	struct request *req =3D blk_mq_rq_from_pdu(cmd);
 	struct nbd_config *config =3D nbd->config;
@@ -614,13 +620,13 @@ static int nbd_send_cmd(struct nbd_device *nbd, str=
uct nbd_cmd *cmd, int index)
=20
 	type =3D req_to_nbd_cmd_type(req);
 	if (type =3D=3D U32_MAX)
-		return -EIO;
+		return (struct send_res){ .result =3D -EIO };
=20
 	if (rq_data_dir(req) =3D=3D WRITE &&
 	    (config->flags & NBD_FLAG_READ_ONLY)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Write on read-only\n");
-		return -EIO;
+		return (struct send_res){ .result =3D -EIO };
 	}
=20
 	if (req->cmd_flags & REQ_FUA)
@@ -674,11 +680,11 @@ static int nbd_send_cmd(struct nbd_device *nbd, str=
uct nbd_cmd *cmd, int index)
 				nsock->sent =3D sent;
 			}
 			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-			return (__force int)BLK_STS_RESOURCE;
+			return (struct send_res){ .status =3D BLK_STS_RESOURCE };
 		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
-		return -EAGAIN;
+		return (struct send_res){ .result =3D -EAGAIN };
 	}
 send_pages:
 	if (type !=3D NBD_CMD_WRITE)
@@ -715,12 +721,14 @@ static int nbd_send_cmd(struct nbd_device *nbd, str=
uct nbd_cmd *cmd, int index)
 					nsock->pending =3D req;
 					nsock->sent =3D sent;
 					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-					return (__force int)BLK_STS_RESOURCE;
+					return (struct send_res){
+						.status =3D BLK_STS_RESOURCE
+					};
 				}
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
 					result);
-				return -EAGAIN;
+				return (struct send_res){ .result =3D -EAGAIN };
 			}
 			/*
 			 * The completion might already have come in,
@@ -737,7 +745,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struc=
t nbd_cmd *cmd, int index)
 	trace_nbd_payload_sent(req, handle);
 	nsock->pending =3D NULL;
 	nsock->sent =3D 0;
-	return 0;
+	return (struct send_res){};
 }
=20
 static int nbd_read_reply(struct nbd_device *nbd, struct socket *sock,
@@ -1018,7 +1026,8 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *=
cmd, int index)
 	struct nbd_device *nbd =3D cmd->nbd;
 	struct nbd_config *config;
 	struct nbd_sock *nsock;
-	int ret;
+	struct send_res send_res;
+	blk_status_t ret;
=20
 	lockdep_assert_held(&cmd->lock);
=20
@@ -1076,14 +1085,15 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd=
 *cmd, int index)
 	 * Some failures are related to the link going down, so anything that
 	 * returns EAGAIN can be retried on a different socket.
 	 */
-	ret =3D nbd_send_cmd(nbd, cmd, index);
-	/*
-	 * Access to this flag is protected by cmd->lock, thus it's safe to set
-	 * the flag after nbd_send_cmd() succeed to send request to server.
-	 */
-	if (!ret)
+	send_res =3D nbd_send_cmd(nbd, cmd, index);
+	ret =3D send_res.result < 0 ? BLK_STS_IOERR : send_res.status;
+	if (ret =3D=3D BLK_STS_OK) {
+		/*
+		 * cmd->lock is held. Hence, it's safe to set this flag after
+		 * nbd_send_cmd() succeeded sending the request to the server.
+		 */
 		__set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
-	else if (ret =3D=3D -EAGAIN) {
+	} else if (send_res.result =3D=3D -EAGAIN) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Request send failed, requeueing\n");
 		nbd_mark_nsock_dead(nbd, nsock, 1);
@@ -1093,7 +1103,7 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *=
cmd, int index)
 out:
 	mutex_unlock(&nsock->tx_lock);
 	nbd_config_put(nbd);
-	return ret < 0 ? BLK_STS_IOERR : (__force blk_status_t)ret;
+	return ret;
 }
=20
 static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
