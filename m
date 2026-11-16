Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865702;
	b=ifOOEiq1mYyPtT2TObhjLMogmspEP2k6H0DMpz+vjjf150TDCwBSUFJ2i/YBRGMnkkO5
	 ZYSSOlD5CIhj4rTWfC+c0ZpubjTfxOMJSI9uvnnO+L4wvaDWT6iWmni4RIPppoe/fa01G
	 v5sPzIj1yxs8z8s3T3m6JsWhhWbXmWqvgOBN1LuDO1qOsUh8wiYabSaOlKef37B4djo9x
	 yeH/48WSniiA6rvetNgLJSPuwmn2ckROX6Or9xp5LLtAgVq5kUpdOwR+SaGEQ/BZkiBsa
	 zissr9dzlKfkt9kbuuh6R1SnFuLx3eoRYp8c1R8M+rV+fw+hA1bJf0riJ4PfZ4EGl4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=aF1D0j2mtu5Yyhyv/KL8sQQtFNOU+dKzV6vQx6Q6ToY=;
	b=yxrNROPlNboeWmvmbaPaLEvmXqxi1y8MfDGyZ/rsc7j7Nq9jAoxR2VQ3quFQsl40ZEd5
	 GTKzVoPk+frT2kNuwD/Q8hCfQTaJsNLmbBV5TZG89+O7H3hhdEorUcjNnwX0Bx0G6pQgu
	 DE6B47sOtsqdffUOzdj/NQObdN5E4MKhDsnNK95KHtRZI14LbLF7KuTjFwUXGD72h8Rgm
	 udTI8oghSiaEvgUsYTh/ZhNOMYnMQVSLYyKcuFva9xSfRQqeWjnDIAb7OAyGYEItlwjCo
	 2jiORD6vwmHLeKEUUvb45y3skXivN2OuIZCPQVoEV381/AANM4C0Kik9Stzzqb4x5ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=x3rmrSsf;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25146606A31C
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 21:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25146606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=x3rmrSsf
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jT1h559GYzlg7MM;
	Mon, 16 Nov 2026 21:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794865698; x=1797457699; bh=aF1D0
	j2mtu5Yyhyv/KL8sQQtFNOU+dKzV6vQx6Q6ToY=; b=x3rmrSsf/8XA2U0fBqzdP
	BTwf1dEAAzpkwrNYL6dFJDa0LwbXuMtYpLYKb9YTntcyW8jQOzKk86ybgABoVRSA
	hUTAxNvDH7JfGnGCRbVlR/eGsT+bKTuOXyaqieS93tgcQzPsRe+5tY0PCEe/KzSB
	AKlJ+cRMvhcPIf8wxa5FsEF/t20QtXgpSqyu8s8p20852o3feZYJ0P+kJBlkHm2w
	f45ldgqECJdpkzC5RMX+pLAQjKphQWv4Re6BAOhGzxYClpaVfBe5MLQ6yFDRBjnS
	/qVTHZ/jxwqVUk7QYsB+0KmNLXIh6Xye8JmTJeDtcVM8Ysoo2zFxum0xWMvGL3DT
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LXAgg4NBZvOb; Mon, 16 Nov 2026 21:48:18 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jT1h02ZqCzlpHxb;
	Mon, 16 Nov 2026 21:48:16 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Aibing Chen <chenaibing@cmss.chinamobile.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/8] nbd: Requeue requests directly in nbd_send_cmd()
Date: Mon, 16 Nov 2026 13:48:02 -0800
Message-ID: <d97789b6d23d4b6b61873c5c1f1dacbbbc9d5812.1794865298.git.bvanassche@acm.org>
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

Call nbd_requeue_cmd(cmd) and return BLK_STS_OK when sock_xmit() is
interrupted before any bytes have been sent in nbd_send_cmd(), instead of
setting NBD_CMD_REQUEUED and returning BLK_STS_RESOURCE.

nbd_handle_cmd() already calls blk_mq_start_request(req) before invoking
nbd_send_cmd(). Calling nbd_requeue_cmd(cmd) transitions the started
request back to MQ_RQ_IDLE via blk_mq_requeue_request() and ensures
nbd_send_cmd() only returns BLK_STS_OK or BLK_STS_IOERR, which simplifies
deferring request transmission to a workqueue.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 864746624ff5..64f2265fb5d9 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -650,8 +650,7 @@ static void nbd_sched_pending_work(struct nbd_device =
*nbd,
 }
=20
 /*
- * Returns BLK_STS_RESOURCE if the caller should retry after a delay.
- * Returns BLK_STS_IOERR if sending failed.
+ * Returns BLK_STS_IOERR if sending failed and cannot be retried.
  */
 static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd =
*cmd,
 				 int index)
@@ -728,7 +727,8 @@ static blk_status_t nbd_send_cmd(struct nbd_device *n=
bd, struct nbd_cmd *cmd,
 	trace_nbd_header_sent(req, handle);
 	if (result < 0) {
 		if (was_interrupted(result)) {
-			/* If we haven't sent anything we can just return BUSY,
+			/*
+			 * If we haven't sent anything we can just requeue,
 			 * however if we have sent something we need to make
 			 * sure we only allow this req to be sent until we are
 			 * completely done.
@@ -737,8 +737,8 @@ static blk_status_t nbd_send_cmd(struct nbd_device *n=
bd, struct nbd_cmd *cmd,
 				nbd_sched_pending_work(nbd, nsock, cmd, sent);
 				return BLK_STS_OK;
 			}
-			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-			return BLK_STS_RESOURCE;
+			nbd_requeue_cmd(cmd);
+			return BLK_STS_OK;
 		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
