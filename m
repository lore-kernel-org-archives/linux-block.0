Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874205027B
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372635; cv=none; b=rE/tsYGFzCzDcJl00H0GQjUM/H9CG1qgC1w31UcjZiMOcXjOPP3ZF01/uv95Abg6cvom8Ip8jHtDTvHiOGheVn0ao83IiZNfCsqClOd9KI4MXXBWiLS0TDpEMf4jl8qP3RAmeItM0mb7KQ5S2+tqdH8buodSTmL85+h7fUNZBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372635; c=relaxed/simple;
	bh=eqeh6JylJkKjgBXxnvqmNvWKa9WriJ/6Tut3n+L8cGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Htapa6I9HunCfWTT9LF4ytqIMnwRM3fdgsYJ+5cfSCSWAFb4XIP2uPdCRrnukGOx2jjYne89RvIGv4Y5prRy98oA1OKDsWpfk5GkRkGDtlbzIAsvx7hodZdCrivEhePgJY/OW2zEEI5Onjz0rWdAvkWfKosQLk1oBoiOUKLQN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ABhxr71z; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ABhxr71z"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VbgLn24rTz6Cnk90;
	Fri, 10 May 2024 20:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1715372606; x=1717964607; bh=ZJUhX
	WOuyzwWrWPwZjQW4ihwlG1UQ5bqT512VQlm9Y8=; b=ABhxr71z4lDpVIVJ/uyRN
	1Awal/jGUExyWSiQZP0ADzrahgJpeR6SdRlKFfGC9ISh7Mn/ItwkcyMoW9nem3En
	hOQQfKzTJNPO0k6ti90wlxd7lsMGE3P6iO6X8wTVZhlcOVclRuY6XLeTCIE0RD9Q
	XN6mZKMGQqPfWIT1i7bAfLW/T806J6wtZ5JVBaRBivTnSTaOHwSN0sNhXGSscDRK
	ILuPnjgV8rfmDtX2D5UOJILkZUrd7qUOzxFVilFlK7GLm42zxZ63m9HKyN/2nOVG
	jqijLskYjo9ZCVVcQD6zTw4dePDy3VQGZ618hJJ8xLY79+XfsQV5Qtk2cD+EQ3Kl
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yCJYxpLGo6yk; Fri, 10 May 2024 20:23:26 +0000 (UTC)
Received: from asus.hsd1.ca.comcast.net (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VbgLj1Nklz6Cnk8s;
	Fri, 10 May 2024 20:23:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Josef Bacik <jbacik@fb.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 3/5] nbd: Improve the documentation of the locking assumptions
Date: Fri, 10 May 2024 13:23:11 -0700
Message-ID: <20240510202313.25209-4-bvanassche@acm.org>
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

Document locking assumptions with lockdep_assert_held() instead of source
code comments. The advantage of lockdep_assert_held() is that it is
verified at runtime if lockdep is enabled in the kernel config.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 90760f27824d..05f69710afe8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -588,7 +588,6 @@ static inline int was_interrupted(int result)
 	return result =3D=3D -ERESTARTSYS || result =3D=3D -EINTR;
 }
=20
-/* always call with the tx_lock held */
 static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int=
 index)
 {
 	struct request *req =3D blk_mq_rq_from_pdu(cmd);
@@ -605,6 +604,9 @@ static int nbd_send_cmd(struct nbd_device *nbd, struc=
t nbd_cmd *cmd, int index)
 	u32 nbd_cmd_flags =3D 0;
 	int sent =3D nsock->sent, skip =3D 0;
=20
+	lockdep_assert_held(&cmd->lock);
+	lockdep_assert_held(&nsock->tx_lock);
+
 	iov_iter_kvec(&from, ITER_SOURCE, &iov, 1, sizeof(request));
=20
 	type =3D req_to_nbd_cmd_type(req);
@@ -1015,6 +1017,8 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int =
index)
 	struct nbd_sock *nsock;
 	int ret;
=20
+	lockdep_assert_held(&cmd->lock);
+
 	config =3D nbd_get_config_unlocked(nbd);
 	if (!config) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
