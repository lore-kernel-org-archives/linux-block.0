Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D20343D85;
	Wed, 10 Jun 2026 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068226; cv=none; b=MK5IB7uk1n6Aw8O446FPTvKap8aFx6SW2Rqp+Qb8dETYRy4X/dxw9uxd/9+KwowaMWoxGGYniMvjDiWcVFrQDLoYIs5lUFgrBCqa4cOO6jBMXDwDHU1ec/5LXZ36l+czSGAPfLhxtoGLtgHIZFNxV77+6j4OpNGr7cN8kGXMJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068226; c=relaxed/simple;
	bh=gr1BlwKyaA6Wk6/SuwU53UTp845bVytDgN3yX3SPDvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4+9dHKRG0QY/mmApDartJ5Zep6bleAwhGc5gTx1nrOfseQrqbb2pXsfx2f38DgM0CuRrjgUT9ENR2B+qD6uGWW/Wx5O3TyYCNWJKeFM5D9WrvWLl3JzdGMIATRItk33UaJsta1Q+s2jEPFFFsmfWNU/ntoMd3U84l8BeNOHGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fO5nFAVM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fO5nFAVM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jZGPDaWDFPN+CVZ5uxpGVsNyw4lL+9is75/Aa2KUoao=; b=fO5nFAVMJzWGaaMo5zPwdRRsUN
	EldES8RPl1dGabUveQ7Uxyn2E6s7OvMdgQPzJP2r4SJLEtEwErpAnjzfjEiOuyy/bEGBbxl0WVZQl
	yZIpb2UY6Jq9rXBCA9qz8pUNtUEgjplUgDr6gjNi+Auo1sJ/cd+ep7zEsXBefN4VzDkwt0JJBYlv1
	IMFoxuLRivWF1KgNpQmzKZ+BLOvlEiCQHfJYbApwYSE0PSJ/y1+HfOG+GMM3NN/QH/HCPH1WQ64bQ
	juHsGx7La8mc71XM1o14yu71U74/5wZOALJbzIPgLR8zGFbVlVmjIubhtG+mfKqXI5TiN10TPt8qP
	cBEIH/7g==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBCp-00000006oHu-3rBN;
	Wed, 10 Jun 2026 05:10:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/4] block: add a macro to initialize the status table
Date: Wed, 10 Jun 2026 07:08:02 +0200
Message-ID: <20260610051015.1906799-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610051015.1906799-1-hch@lst.de>
References: <20260610051015.1906799-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Prepare for adding a new value to the error table by adding a macro
to fill it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 block/blk-core.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1c637db79e59..43121a9f99f0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -132,39 +132,44 @@ inline const char *blk_op_str(enum req_op op)
 }
 EXPORT_SYMBOL_GPL(blk_op_str);
 
+#define ENT(_tag, _errno, _desc)	\
+[BLK_STS_##_tag] = {				\
+	.errno		= _errno,		\
+	.name		= _desc,		\
+}
 static const struct {
 	int		errno;
 	const char	*name;
 } blk_errors[] = {
-	[BLK_STS_OK]		= { 0,		"" },
-	[BLK_STS_NOTSUPP]	= { -EOPNOTSUPP, "operation not supported" },
-	[BLK_STS_TIMEOUT]	= { -ETIMEDOUT,	"timeout" },
-	[BLK_STS_NOSPC]		= { -ENOSPC,	"critical space allocation" },
-	[BLK_STS_TRANSPORT]	= { -ENOLINK,	"recoverable transport" },
-	[BLK_STS_TARGET]	= { -EREMOTEIO,	"critical target" },
-	[BLK_STS_RESV_CONFLICT]	= { -EBADE,	"reservation conflict" },
-	[BLK_STS_MEDIUM]	= { -ENODATA,	"critical medium" },
-	[BLK_STS_PROTECTION]	= { -EILSEQ,	"protection" },
-	[BLK_STS_RESOURCE]	= { -ENOMEM,	"kernel resource" },
-	[BLK_STS_DEV_RESOURCE]	= { -EBUSY,	"device resource" },
-	[BLK_STS_AGAIN]		= { -EAGAIN,	"nonblocking retry" },
-	[BLK_STS_OFFLINE]	= { -ENODEV,	"device offline" },
+	ENT(OK,			0,		""),
+	ENT(NOTSUPP,		-EOPNOTSUPP,	"operation not supported"),
+	ENT(TIMEOUT,		-ETIMEDOUT,	"timeout"),
+	ENT(NOSPC,		-ENOSPC,	"critical space allocation"),
+	ENT(TRANSPORT,		-ENOLINK,	"recoverable transport"),
+	ENT(TARGET,		-EREMOTEIO,	"critical target"),
+	ENT(RESV_CONFLICT,	-EBADE,		"reservation conflict"),
+	ENT(MEDIUM,		-ENODATA,	"critical medium"),
+	ENT(PROTECTION,		-EILSEQ,	"protection"),
+	ENT(RESOURCE,		-ENOMEM,	"kernel resource"),
+	ENT(DEV_RESOURCE,	-EBUSY,		"device resource"),
+	ENT(AGAIN,		-EAGAIN,	"nonblocking retry"),
+	ENT(OFFLINE,		-ENODEV,	"device offline"),
 
 	/* device mapper special case, should not leak out: */
-	[BLK_STS_DM_REQUEUE]	= { -EREMCHG, "dm internal retry" },
+	ENT(DM_REQUEUE,		-EREMCHG,	"dm internal retry"),
 
 	/* zone device specific errors */
-	[BLK_STS_ZONE_OPEN_RESOURCE]	= { -ETOOMANYREFS, "open zones exceeded" },
-	[BLK_STS_ZONE_ACTIVE_RESOURCE]	= { -EOVERFLOW, "active zones exceeded" },
+	ENT(ZONE_OPEN_RESOURCE, -ETOOMANYREFS,	"open zones exceeded"),
+	ENT(ZONE_ACTIVE_RESOURCE, -EOVERFLOW,	"active zones exceeded"),
 
 	/* Command duration limit device-side timeout */
-	[BLK_STS_DURATION_LIMIT]	= { -ETIME, "duration limit exceeded" },
-
-	[BLK_STS_INVAL]		= { -EINVAL,	"invalid" },
+	ENT(DURATION_LIMIT,	-ETIME,		"duration limit exceeded"),
+	ENT(INVAL,		-EINVAL,	"invalid"),
 
 	/* everything else not covered above: */
-	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
+	ENT(IOERR,		-EIO,		"I/O"),
 };
+#undef ENT
 
 blk_status_t errno_to_blk_status(int errno)
 {
-- 
2.53.0

