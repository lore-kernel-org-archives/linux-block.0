Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A4C3EDAB5
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691804; cv=none; b=YeWzwMCGYXWRB0hSwF3ybCDg9fOvbmBXDL1giI1AMLSHmbZ3GQHcb2s/Zkq778XsBfButiL7llA/gRiEstoCAaZvMycOfiQqJmhbQMt4pT+DAH3hPFyyxqfY1rEZ4L/YONDuNIvDucA7W2bg+yLxrAbi+BnmaoUiZT5pCiH82j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691804; c=relaxed/simple;
	bh=n1HoTtshdcxdl63UZqYb9oyvpofv6dZudcJhcfOMR14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPiMl/MFolnIgmg93tzMnFEKPzIrayJHobkMnCmweoGKWHwXKXqK8rS77+Bjp/SXvpvkD+hDn1k2RGFQ7Za5u83DPCVL1EUoNtx90DmanIhwStWr+DZVx3mX35Z/kU2s53zphU9bbRDJCfbYnE3BSz/+cOfMQnHmSQisvV4sTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ubGokxtO; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ubGokxtO"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR5k3yyszlgyGM;
	Mon, 16 Mar 2026 20:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773691799; x=1776283800; bh=z1lI+
	ITS8LiaD+ZKCmdKdrirSoknPNt97L12BMcmyhw=; b=ubGokxtO9ZXIQzvVbNK03
	nWqbvbykr6wPDit99hg52Zx1KwqPLw6c2hgehHp97dhG4J7tnuax22da9Wmx9cij
	z+j3rUmPC5CV8rk4XjiwJlYfDEEK7rqpKTZe5kutOlmc3VFGaW3EPeKhRt2neqxJ
	yCqnQldsoTjlH5UGihDnNn43PqnflNke7KU0jcAF5VUrw4NjPqlToh3ohvSTsoXp
	5wiXVTJlR1bXv3jVNXBpTTHQscX/lZaFbD/HK+XXPsSrFMSJ7bsYFiD9afOzN4Na
	YjRFj8t1cuxibcht/2DRrQSuz/x7oCIit0sWDmHrae0SLWfcja0iXEtPcq3Kq9sb
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Hv54AuvDdxOM; Mon, 16 Mar 2026 20:09:59 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR5Z6SYCzlgyG9;
	Mon, 16 Mar 2026 20:09:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 06/12] nbd: Add lock context annotations
Date: Mon, 16 Mar 2026 13:08:43 -0700
Message-ID: <20260316200901.4111651-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260316200901.4111651-1-bvanassche@acm.org>
References: <20260316200901.4111651-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for enabling lock context analysis by adding those lock context
annotations that are required by Clang.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fe63f3c55d0d..28bb89bc7de3 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1469,6 +1469,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 }
=20
 static int nbd_start_device(struct nbd_device *nbd)
+	__must_hold(&nbd->config_lock)
 {
 	struct nbd_config *config =3D nbd->config;
 	int num_connections =3D config->num_connections;
@@ -1541,6 +1542,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 }
=20
 static int nbd_start_device_ioctl(struct nbd_device *nbd)
+	__must_hold(nbd->config_lock)
 {
 	struct nbd_config *config =3D nbd->config;
 	int ret;
@@ -1592,6 +1594,7 @@ static void nbd_set_cmd_timeout(struct nbd_device *=
nbd, u64 timeout)
 /* Must be called with config_lock held */
 static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd=
,
 		       unsigned int cmd, unsigned long arg)
+	__must_hold(nbd->config_lock)
 {
 	struct nbd_config *config =3D nbd->config;
 	loff_t bytesize;
