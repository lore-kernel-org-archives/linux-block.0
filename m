Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865706;
	b=s7aH+AaNVBXIJ11W1dUiS53M+ASfVq+4zfg4xYg+GN27SMXNfzL1kgVF9lb4uaLdII0t
	 LyBKsu1bBKuo0A4NOjq8GattjWH9xl1GMc/QbbatnfWmOand4aIiNILwTDn0GNTeBFfvD
	 c+xD3NzGa8MKLk3OygXjJczay5xFC+/Agiz3O8VSOGdr7MyE0cLW0Rg8/ETL6Tp/CMreg
	 6f9zM2l9VAlpNRtYMk+bHEi6CmFEiQfg/FXuz5A8uN/nBBj5c8xN2O4H8qMrM0f871IQO
	 MSS+9BEnBJeLg0gSvYlobIltn0Yc4IIbLSUlbJqwTNym/FE8uMXFEYpvyeRDBVZysxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=e68wirDPJdb+Oxq4yvhUCGKEcCxxW6Hfc+V008axvNc=;
	b=eH0JMw6q/KOKnKPoDdg4Kq+5VCvxM6wUx1OXy4IsVeqO4Ca7E1SOn/lGWdZCmhJP758m
	 chMS8KwAN5jZcv53XRcsaMP/kTHJ5bOQ6rYgQxAb1/mJAoj2M3ppgZdsAJuFDmY6Ujeqw
	 tZ/yWC0n0eXBUIOqxN4E0QnhElWxEbGcjcj1RN2lZTqE/qktGlMr0P4gRG+WL8vxODfVi
	 UZpmKwd19F1h5yhIEAgA51eMhu/S+ehuYy+041NBrysfmsuGjn8MJiYsHN9/vhbqF4zcg
	 5HC4ZbUculAyDhBTTBB1ussW0fHoZU5BeHvbogFjyGR/lqkKt3qTYuf+S3sa1FI5GxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=FkVGnYbv;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41BF606A323
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 21:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D41BF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=FkVGnYbv
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jT1h93pvxzlffth;
	Mon, 16 Nov 2026 21:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794865701; x=1797457702; bh=e68wi
	rDPJdb+Oxq4yvhUCGKEcCxxW6Hfc+V008axvNc=; b=FkVGnYbv354OJp30C5rTd
	JFYDye/G/gX9iYVMeK81PVsSC2IjjzonRetqiLY43M4V1k2q5+IDzhBvPs0SCLkW
	qFEi25q179jnx/0DXO0RrC9vkcRZLZyGKm8WgRetOdEXK7gXVWnCyMHDTXx1UE9O
	gZ66vMqwChXNO3/85WJib8CZIKHehei5Bmi/vOVdxvnzUOAFwHgA6YYWDFlsrk/a
	vYKo0952euMKMsEKsFCgPwG/BTsbDe9Q4JpqKUb+YZDZxDnlbuK6iPbdeItFuqCr
	L4RcgqPNcs71XNqyJfh2fupw8zx6HUe84Tr/6stRPeJRLMiqyCkpMeZNL4NSXQy0
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PMRf2i3IEJL1; Mon, 16 Nov 2026 21:48:21 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jT1h23jS4zlpHwv;
	Mon, 16 Nov 2026 21:48:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Aibing Chen <chenaibing@cmss.chinamobile.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 8/8] nbd: Remove the sent argument of sock_xmit()
Date: Mon, 16 Nov 2026 13:48:08 -0800
Message-ID: <e183083ce7e914e2b19bd6d9899e5a0677c6d1b7.1794865298.git.bvanassche@acm.org>
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

Remove the sent argument of sock_xmit() and __sock_xmit(). All callers
pass NULL since the partial-send handling has been removed.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3d834e4e1349..73fc546447a6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -553,7 +553,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(stru=
ct request *req)
 }
=20
 static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int =
send,
-		       struct iov_iter *iter, int msg_flags, int *sent)
+		       struct iov_iter *iter, int msg_flags)
 {
 	int result;
 	struct msghdr msg =3D {} ;
@@ -586,8 +586,6 @@ static int __sock_xmit(struct nbd_device *nbd, struct=
 socket *sock, int send,
 					result =3D -EPIPE; /* short read */
 				break;
 			}
-			if (sent)
-				*sent +=3D result;
 		} while (msg_data_left(&msg));
 	}
=20
@@ -601,12 +599,12 @@ static int __sock_xmit(struct nbd_device *nbd, stru=
ct socket *sock, int send,
  *  negtive value on failure, and never return 0.
  */
 static int sock_xmit(struct nbd_device *nbd, int index, int send,
-		     struct iov_iter *iter, int msg_flags, int *sent)
+		     struct iov_iter *iter, int msg_flags)
 {
 	struct nbd_config *config =3D nbd->config;
 	struct socket *sock =3D config->socks[index]->sock;
=20
-	return __sock_xmit(nbd, sock, send, iter, msg_flags, sent);
+	return __sock_xmit(nbd, sock, send, iter, msg_flags);
 }
=20
 /*
@@ -666,7 +664,7 @@ static blk_status_t nbd_send_cmd(struct nbd_device *n=
bd, struct nbd_cmd *cmd,
 		req, nbdcmd_to_ascii(type),
 		(unsigned long long)blk_rq_pos(req) << 9, blk_rq_bytes(req));
 	result =3D sock_xmit(nbd, index, 1, &from,
-			(type =3D=3D NBD_CMD_WRITE) ? MSG_MORE : 0, NULL);
+			(type =3D=3D NBD_CMD_WRITE) ? MSG_MORE : 0);
 	trace_nbd_header_sent(req, handle);
 	if (result < 0) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
@@ -689,7 +687,7 @@ static blk_status_t nbd_send_cmd(struct nbd_device *n=
bd, struct nbd_cmd *cmd,
 			dev_dbg(nbd_to_dev(nbd), "request %p: sending %d bytes data\n",
 				req, bvec.bv_len);
 			iov_iter_bvec(&from, ITER_SOURCE, &bvec, 1, bvec.bv_len);
-			result =3D sock_xmit(nbd, index, 1, &from, flags, NULL);
+			result =3D sock_xmit(nbd, index, 1, &from, flags);
 			if (result < 0) {
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
@@ -730,7 +728,7 @@ static int nbd_read_reply(struct nbd_device *nbd, str=
uct socket *sock,
=20
 	reply->magic =3D 0;
 	iov_iter_kvec(&to, ITER_DEST, &iov, 1, sizeof(*reply));
-	result =3D __sock_xmit(nbd, sock, 0, &to, MSG_WAITALL, NULL);
+	result =3D __sock_xmit(nbd, sock, 0, &to, MSG_WAITALL);
 	if (result < 0) {
 		if (!nbd_disconnected(nbd->config))
 			dev_err(disk_to_dev(nbd->disk),
@@ -819,7 +817,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_de=
vice *nbd, int index,
=20
 		rq_for_each_segment(bvec, req, iter) {
 			iov_iter_bvec(&to, ITER_DEST, &bvec, 1, bvec.bv_len);
-			result =3D sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
+			result =3D sock_xmit(nbd, index, 0, &to, MSG_WAITALL);
 			if (result < 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
 					result);
@@ -1319,7 +1317,7 @@ static void send_disconnects(struct nbd_device *nbd=
)
=20
 		iov_iter_kvec(&from, ITER_SOURCE, &iov, 1, sizeof(request));
 		mutex_lock(&nsock->tx_lock);
-		ret =3D sock_xmit(nbd, i, 1, &from, 0, NULL);
+		ret =3D sock_xmit(nbd, i, 1, &from, 0);
 		if (ret < 0)
 			dev_err(disk_to_dev(nbd->disk),
 				"Send disconnect failed %d\n", ret);
