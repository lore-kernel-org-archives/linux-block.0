Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30778374A0F
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042802; cv=none; b=WIXRf4H8m6W538vmNoqe84ECIm65OTFKZogKe9DQj6zhK72PyyIrrOTDhKCETLc4xRbxYg1KvqI/I7ELo+xo+RySdhEnC6ZYMPYx4HCxt57+LCG9fIJLQNAWNopRTi6JV6uAryaivHrYmTFMuVFWZ4mVd9A9fh6xdUiZIRo2wvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042802; c=relaxed/simple;
	bh=b1L+4excz72zKLeDofCFCNxMnjtCF1ElFfNmmY6HuXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZLtljbqD3FZXPxXGGyh6tuZxp6xKrgaPY6smRTPgGzzXGkZDzWu06qvYAgWLIxNMHRPo7XbdQLos4niYVhxonB5keJliaquhKTLF5qGv/+eToKMaMd14p+Agr+iUszGHUuwmf0hp62WpKqIoTxUtHVWkaySREXZ5fuEy/FCQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=i2fVHQ0Y; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="i2fVHQ0Y"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjg45bdpzlgtd1;
	Tue,  9 Jun 2026 22:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042797; x=1783634798; bh=ZJjth
	kDXIIoiM6nD5/weRqWHhsVS7lgQFAbE+/YKZec=; b=i2fVHQ0YS3m17UWnnQMMN
	cVBQ5O4wkIqzThK3dw2tDGwr6FeyOSeLVG4180wnLi/fr8sxkkzLgv++4tkX32tx
	CwNHBJ6eNwptIdkJtIx2p7P7EGnb8IH2iv/Ag37ai9Q9NRYOqX0VsdDyQtI6jb60
	pI56BNfMoZ5k39HNc8Iqwwm0XB42KcyCq0XEyxerVzIaYQRE6zmdPUiBVIFB0LMj
	Epfe0VDBXAp/Psps7VJ9447JLtUx1Tk3HRCvTRBr9mFxvTu15jDzXjNQs+Udw556
	1sWD8HylBfOCo/bsL5wYNkq0a9fnpKyhzJ6Ao+teux+H93VhcBrYufLJddKDm5hs
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JY-85bAE1l3G; Tue,  9 Jun 2026 22:06:37 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfz0mdpzlffvQ;
	Tue,  9 Jun 2026 22:06:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 20/27] nbd: Enable lock context analysis
Date: Tue,  9 Jun 2026 15:05:07 -0700
Message-ID: <5361809d027e772503ca3cc458aaebdf06792e3b.1781042470.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <cover.1781042470.git.bvanassche@acm.org>
References: <cover.1781042470.git.bvanassche@acm.org>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e2fe9e3308fc..345e4b73009d 100644
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
