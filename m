Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F0445BEC
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372639; cv=none; b=iL37Z03HapKy1tPRoFM2UaOR05ay5zfmsnAa5KYHDDtbssSOqfbfgEaRnmNEqMmMh3CTDwR++DAyAySi0NR23GeLZe7WBUqtlzzDO2+y9mrgInVdZr+ZRNkGiu9JAvJkIh/Ya9aRW1fIyWHXtP7MOWsreurg3PlmEedtR8Xfi+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372639; c=relaxed/simple;
	bh=tMQAzzorkRLy2Oo0O06lHPU7O8QBYrRB210rj5jjXyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffLI5A3g305vi3webKpSs5qKC1yuET64qN2vl1sH2ViSXHKPZ+WtRnjq0B3ZIJTuUQ4/MHjvKZQ20XLy+scUiA2Vfr+q2aspI/NgscpANyr3wg0HIkJ33ueIHCGfpNoVCeSicrVO498kvBKz1dmp6lvcI/dAoLC04yDLLKiuYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0VKORnCw; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0VKORnCw"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VbgLp55Vcz6Cnk8s;
	Fri, 10 May 2024 20:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1715372607; x=1717964608; bh=H2iwq
	Gm2MBWmx2IQ7zvyluZvsqTbVwqEiMhPPsPHgXU=; b=0VKORnCw5vApyIsRSsrhV
	ThILbu0xIaYz6nAkngPWD5hvVoBefggWg8g9M2GUSDXTdhwAxryUR1iNy/BictEg
	rAVoG85Qfa95fNSt80UyMh0pYBIvEddbop4kpG7KmKhtbwN4HYZ7lPjKElORYq6Y
	jWIpZHpD9wXl5QRvRXIhkIrGI8xgBcWiHXeU4GsUU0Kt688BKm17r2WhwSZ9w5+W
	QNUBxo+ZSinflSXvPEuFWlTKZbAUe/vHJbdb4yDZPKTejxjddWQZ5ItR16BCUroO
	oXWqOSkdqb+0hXw7fBtYsvqoSiOeV5iPDWV5oo0rHwYgN1mPoRU754ERVGKL2oWW
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vbVrQSFGnp7S; Fri, 10 May 2024 20:23:27 +0000 (UTC)
Received: from asus.hsd1.ca.comcast.net (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VbgLk1YgWz6Cnk95;
	Fri, 10 May 2024 20:23:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Josef Bacik <jbacik@fb.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 4/5] nbd: Remove a local variable from nbd_send_cmd()
Date: Fri, 10 May 2024 13:23:12 -0700
Message-ID: <20240510202313.25209-5-bvanassche@acm.org>
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

blk_rq_bytes() returns an unsigned int while 'size' has type unsigned lon=
g.
This is confusing. Improve code readability by removing the local variabl=
e
'size'.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 05f69710afe8..29e43ab1650c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -597,7 +597,6 @@ static int nbd_send_cmd(struct nbd_device *nbd, struc=
t nbd_cmd *cmd, int index)
 	struct nbd_request request =3D {.magic =3D htonl(NBD_REQUEST_MAGIC)};
 	struct kvec iov =3D {.iov_base =3D &request, .iov_len =3D sizeof(reques=
t)};
 	struct iov_iter from;
-	unsigned long size =3D blk_rq_bytes(req);
 	struct bio *bio;
 	u64 handle;
 	u32 type;
@@ -646,7 +645,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struc=
t nbd_cmd *cmd, int index)
 	request.type =3D htonl(type | nbd_cmd_flags);
 	if (type !=3D NBD_CMD_FLUSH) {
 		request.from =3D cpu_to_be64((u64)blk_rq_pos(req) << 9);
-		request.len =3D htonl(size);
+		request.len =3D htonl(blk_rq_bytes(req));
 	}
 	handle =3D nbd_cmd_handle(cmd);
 	request.cookie =3D cpu_to_be64(handle);
