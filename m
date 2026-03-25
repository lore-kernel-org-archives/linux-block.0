Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1E2777EA
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475182; cv=none; b=AKszGNjui0cuvxvFk37TVAa0Gkyd0xMce5Q00nRbCVAoX1jnGpBcJkMo1sVZZkG6BTsPicxlMEe4PEApaqA36fEoDWrK7FHDTGjOiI8jrPiMsuOCB69Z+VFKFLe6nlZow6dVZUVGJBCYcyK2RLA14C+sxU1bu/Gb4/Qg5FdGXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475182; c=relaxed/simple;
	bh=5rHYG5jvzGFcfJnC1vLD1PGz05OGKgo44ypYl+LeKos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGNM1cYSQM+Z6EQiKfZ0b+FJBAPVqtbIiKT6pA73GDnSgQmWV4IL5krMuCAP/ayEWY6whs/NXEd3gcDMSTBbSfkjTrIvMNAvaZMrvk+9GP6L41UdlBTKuYyfOWjLssNCGCklWAHnnOGsw3xLfygX3/Fo20A8i3DFCy4O4i7Hsfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=lqaP5lCJ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="lqaP5lCJ"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0ph4nBKzlfdGT;
	Wed, 25 Mar 2026 21:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475176; x=1777067177; bh=13mgj
	2LRfCKmZLhcU/CmQ48h3PvKmjE7xgRDTJT1SKM=; b=lqaP5lCJDAyPmcd3A8MZl
	tfNtTy3bPBiZv1FiNaiBKy/B+KfzXDS11WY68FQB9kbV7ET/ANnhlQzFlRxvduT9
	mE3KaCYRQvZM90wDXjn1GXDOJ0wGP7e9lLKX0AFlevUcoiWTUgSUeJ8zukO2BB7t
	yc1kLgy2wZ58KseRm2RSQjJ5dQoYBSPi3z/7RjLyyzLGQm0Ozq14DhihysLD3H8d
	MuHSa3fCSecpAw0sZd7eny8T0Y3gKGqComdsNDU8xH5As4RVeJJ2aEsa8Sp4eL8F
	sJe22ACfNb89MG1Z442qUfuwfgW89eZ24xNRtfrFuHiyivRZ3TtNUV3jeveo/lYx
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id M1vVd44zTIIs; Wed, 25 Mar 2026 21:46:16 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pb0PSYzlgyGG;
	Wed, 25 Mar 2026 21:46:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 19/26] nbd: Enable lock context analysis
Date: Wed, 25 Mar 2026 14:45:00 -0700
Message-ID: <20260325214518.2854494-20-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the missing __must_hold() annotations. Enable lock context analysis i=
n
the Makefile.

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
