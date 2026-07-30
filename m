Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F55830F94D
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441562; cv=none; b=Ai8vxkb+AxQ1hhOPCX0LVSf0hbi/S3fgo+2GSphcC8gTywnJEvARUzTDFbWXBMBNv48wDXr+xTT8gkb1eOIfVl1SzML4J5Mp/Df+ul090L5/XYH4iJ2r06woAI9ttjBu5nHjPGNZHiE9AUqncPyLOGGEZExIquyuzpRLVJtVrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441562; c=relaxed/simple;
	bh=luHbYI1FHH++EB4glu8aI71saKb294sd0+ouacO2G/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h44AyE+joAg6heIAGK34Zz6tvn+ns9uvzWFoPM4TdczFBdGQgQKm3eHOZO4wEdOGlwWb5d/0YfKEC0IJBy4NW7YRGpCoWJFKKHJCwf90xoo9CZ6rnK+71jyYp8p6vhW9y3245Bh7/mr28sJnHuztVzjZ3hLaz2Tz7wnYeIVOafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RrC8H9Jj; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RrC8H9Jj"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0QY3BsTzlfpLr;
	Thu, 30 Jul 2026 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1785441553; x=1788033554; bh=eBsYK
	cFn+9ThmmhEEgBLogTS3+Pb1r79V5kCrcC3Mr4=; b=RrC8H9Jj5t3GX1JKiw2Iq
	PaggYlFDX4eMW9JFrD6rjaGV1ZpMrc1p1P7+DyYlzokUYsvnSkr957NXJ4vgxWID
	rS1wiJDQPUnTQcGx2XYZz8qQIro6IRRMCSeJLL4iXzdjVeVvwY7gJbsE4BTu4LiH
	DQpIduoG3e+1R1JUW5wtBtUL69GFi6HJWfhiBP2slpoPqmdp0cenhrFzCjMk7/Qm
	ihBD4IsfiAt+L/P0Rg0bbb9eX9u66MGdDAD2GhK6+NH0xiE+vhz667CemtkhxtoM
	RzMQq5HZhNLRP/nZTfPen9Y/y6ZQqjITNsRsU0lzmALK/y5dODWQS0nript8x0br
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TNTmCQljdJxa; Thu, 30 Jul 2026 19:59:13 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0QQ4Rdmzlfvps;
	Thu, 30 Jul 2026 19:59:10 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 05/12] nbd: Enable lock context analysis
Date: Thu, 30 Jul 2026 12:58:28 -0700
Message-ID: <5e1f54d3826b0d479242a9886ca2c7b6eb8cedaf.1785440858.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <cover.1785440858.git.bvanassche@acm.org>
References: <cover.1785440858.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add __must_hold() annotations where these are missing. Document which mut=
ex
protects nbd_index_idr.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/nbd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8f10762e90ef..751449d362b0 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -49,8 +49,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/nbd.h>
=20
-static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
+static __guarded_by(&nbd_index_mutex) DEFINE_IDR(nbd_index_idr);
 static struct workqueue_struct *nbd_del_wq;
 static int nbd_total_devices =3D 0;
=20
@@ -1506,6 +1506,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 }
=20
 static int nbd_start_device(struct nbd_device *nbd)
+	__must_hold(&nbd->config_lock)
 {
 	struct nbd_config *config =3D nbd->config;
 	int num_connections =3D config->num_connections;
@@ -1578,6 +1579,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 }
=20
 static int nbd_start_device_ioctl(struct nbd_device *nbd)
+	__must_hold(&nbd->config_lock)
 {
 	struct nbd_config *config =3D nbd->config;
 	int ret;
@@ -1629,6 +1631,7 @@ static void nbd_set_cmd_timeout(struct nbd_device *=
nbd, u64 timeout)
 /* Must be called with config_lock held */
 static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd=
,
 		       unsigned int cmd, unsigned long arg)
+	__must_hold(&nbd->config_lock)
 {
 	struct nbd_config *config =3D nbd->config;
 	loff_t bytesize;
@@ -2773,7 +2776,11 @@ static void __exit nbd_cleanup(void)
 	/* Also wait for nbd_dev_remove_work() completes */
 	destroy_workqueue(nbd_del_wq);
=20
-	idr_destroy(&nbd_index_idr);
+	{
+		__assume_ctx_lock(&nbd_index_mutex);
+		idr_destroy(&nbd_index_idr);
+	}
+
 	unregister_blkdev(NBD_MAJOR, "nbd");
 }
=20
