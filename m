Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16293E7150;
	Fri,  5 Jun 2026 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685091; cv=none; b=sxCYO2ZQiaHqGC5KRvsFfJyfmAsgAD2ZWIddHBfPVNm140Nf2kNhYTBPxACoI4va7nv8ZWQxJ7oKt6kMqYEhyjPEi+/7nha396yXnwQjmkkE5zVi1N1l5FjXhVTF2OnGbqSL2mo3S3APxSBtB9GKlzVo/nqzEuT4AWLc7wjphqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685091; c=relaxed/simple;
	bh=xOVJrcQJu9wV6njEHpBuISU+KK7OwEhlPBGv4BISme8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpzc4ltdfLisMsQBMA5zaU0DTIWQChv7X+0045YURUcrZVqZZtl4Yk7jb5eEzm5uIaHdrf7GflTF8HHQxQ7zBy6l4ZckTbl9kDVxVbq83suQpCbu6V6W0fj7ymIDa8dqTRgX25VhUqrdlhzGcyN4vrI7RVc3E1QrF9VXAgCYw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ifVnqSb/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifVnqSb/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RQAuudq1KexEjUEwn/6TA+RKjAxrN4T/KI/AypDFr0A=; b=ifVnqSb/pJXQ39+jOpBBifH+Xs
	BMy+34+jUdwoV0CD7adb2IvC59fNFu60+6/RFMrW83WfeBW8RVbo+wuKSetmKLsi/bz5u8lcQUtHC
	pERDmA55A1GIqqFE6Jy1wSp9q2i+SYWgPo+kB1U+drc2oVsgFtey0v5Mi769iCE0YdzObgqHogew9
	h8zD9K7bBkJRolfPqNQpC/GauzGHktNIvO096zdJiNtRdAqUAgvcEAYujzgYE8ePgkGUAnxhqE0yF
	ZTN3Q+6uGIRinpvDhaSF6LAZDhMYRZcgQHEtK765Gy728WAj29mbW3sjI6ZSrSRe0ErJD+zqFT0TP
	RCHGoqDA==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZXE-000000014P5-31SX;
	Fri, 05 Jun 2026 18:44:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/4] block: add a macro to initialize the status table
Date: Fri,  5 Jun 2026 20:44:27 +0200
Message-ID: <20260605184441.590927-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605184441.590927-1-hch@lst.de>
References: <20260605184441.590927-1-hch@lst.de>
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-core.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b0f0a304ea0b..1614323282f1 100644
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

