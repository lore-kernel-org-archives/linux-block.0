Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9A0288514
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653767; cv=none; b=FbWPSK6ZSPY8vtQ6mjNdNulDjdb6ZiGAx0ELtNDtbza5lDlPq7gEbybVM6pY8+cVZa0UADD3K9ohZQ4+krutg1o4JccV2dqIG8d0s7BFCaBKgBXUCYsS3z59pkZuFC3HZxo/tR2tc8Y/9ri7Li6BBkpfKxZ3DKBFVXLoOhXJdpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653767; c=relaxed/simple;
	bh=n1HoTtshdcxdl63UZqYb9oyvpofv6dZudcJhcfOMR14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrjvu0znWzc/XDQZ/7psrvHGahHuiHVNeij5KvLSzCLS7dVFg424AHh/lbQuFqycl++0gVt29JZwoTOamnxCEw/y6WhK8jpF1EXRqKF6B5ab7vj/+qIG3XKAu2ErEETHY3lVVy4fN4F4DVP2TKaJHv9SQTGvRcZoyxLep2uSfTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SI4Cg5hO; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SI4Cg5hO"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3CT60tMz1XM6Ht;
	Wed,  4 Mar 2026 19:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653761; x=1775245762; bh=z1lI+
	ITS8LiaD+ZKCmdKdrirSoknPNt97L12BMcmyhw=; b=SI4Cg5hO/IKlktbgGByP/
	Ay8jwgONtAoh1YTndNBqCfSAxEI/YAxDHcq9v6D+NlHL5kDqogLcguav1S+JVgnf
	q8bGqpPOeHn3S0scQ1QBN3poGueXy5s6Fk8OgLkUk0A4GIm14IqG/Cd6QGihpRD+
	73/bFGEXoHIfRmArIxzGWH5dAMFL61Po3wxChLSfKOb7LD1oTrHD9TKF/wbkONwi
	L8l5gfTFNINBoNrKJBclKupeioYahOfYZFijuRjEL7tSAKdA2rloKB2ZkXgWqZvU
	/aatyn0HxHNDZktQM9mNT1BvMxV0bVLlzpUhmp811/2InDUjwjqU6/riz4CksSB6
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IKNeAd6UWcNW; Wed,  4 Mar 2026 19:49:21 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3CL34lJz1XM0pg;
	Wed,  4 Mar 2026 19:49:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 07/14] nbd: Add lock context annotations
Date: Wed,  4 Mar 2026 11:48:26 -0800
Message-ID: <20260304194843.760669-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260304194843.760669-1-bvanassche@acm.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
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
