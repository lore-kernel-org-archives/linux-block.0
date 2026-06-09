Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403ED24BD03
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042814; cv=none; b=CDBXC3fUihGANsq75YmQQieX7cOIKdBKlwklrO1c2wYiv5MX0Yz9wcZqMH4vPOP5qgOdWYHawb7YdNmzBk6272+4LkTEJNOpafsVQeY420Fvi5ZUYNgyS9uff8jK2ge7w/Yx1Bmmyho7d0i22dq6sUwuUmYT4irJTgRjFReq+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042814; c=relaxed/simple;
	bh=EsCnyMCXLB9bPfJwqkeOTci2nC5y5ry/jNPxT3GLOAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtcfs5W0tbkLmFiAr+PgP1pFwimqD8B678G0tuhYvT1elcgsH9B5O4Q8l8MkF5DS8pakESBsvGzbd7WgM2xEpJ+O+IkvdpcXTuYtMlFRPUrv/YxP1ieTybxP+Rp9sESbHkSwNdSvVRkQuzwhGxJLD7ELiXQwWYLIdv4cm/dImnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AgJUQjxR; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AgJUQjxR"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjgK0Bg2zlfddr;
	Tue,  9 Jun 2026 22:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042804; x=1783634805; bh=zpcLQ
	vjDzRGcYVfC/Imdad+ULbNep2JC096alxWyoPc=; b=AgJUQjxReD2WY40iVLJq9
	y4lyPxe7MdGGpZIGUA2A1G7CPAhuLBo6Mut7j0gtaTR5SqkcLe3L9C1wqBYyXPIm
	Az2OVYsZNtTGxxK7lrjguWkpGKEf9wKIpiC47OIpvF36UhiNXrB4KcUdWSOXLgxV
	XaeO5z12fr0ncJmktDgv1XsjE2djeI2swWzRrVEKSVjV9lfCyiLafUllVaI/4v1F
	zp/2XLdGs6ZEXmKTQp8MQZmoe0A/oAoa2o8FAbc6WImwkX53BvOpJ8Ovx7CbRUpM
	3t2sHMKUxreb5OkfCF8GXWkeGjknVdhQFlFMXkQMltSwCAVpRsSjYIi9wHcG/PFw
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 42SQ0xgtKTOs; Tue,  9 Jun 2026 22:06:44 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjg53f9Qzlh2rF;
	Tue,  9 Jun 2026 22:06:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Genjian Zhang <zhanggenjian@kylinos.cn>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 21/27] null_blk: Enable lock context analysis
Date: Tue,  9 Jun 2026 15:05:08 -0700
Message-ID: <b70422c6f243b9275e336430071b52eb92dd40c4.1781042470.git.bvanassche@acm.org>
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

Add __must_hold() annotations where these are missing. Annotate two
functions that use conditional locking with __context_unsafe(). Enable lo=
ck
context analysis in the Makefile.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/Makefile |  2 ++
 drivers/block/null_blk/main.c   | 12 ++++++++----
 drivers/block/null_blk/zoned.c  |  2 ++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/Makefile b/drivers/block/null_blk/Mak=
efile
index 84c36e512ab8..282b0d51a477 100644
--- a/drivers/block/null_blk/Makefile
+++ b/drivers/block/null_blk/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
=20
+CONTEXT_ANALYSIS :=3D y
+
 # needed for trace events
 ccflags-y			+=3D -I$(src)
=20
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index f8c0fd57e041..bba13b102828 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1038,6 +1038,7 @@ static struct nullb_page *null_insert_page(struct n=
ullb *nullb,
 }
=20
 static int null_flush_cache_page(struct nullb *nullb, struct nullb_page =
*c_page)
+	__must_hold(&nullb->lock)
 {
 	int i;
 	unsigned int offset;
@@ -1087,6 +1088,7 @@ static int null_flush_cache_page(struct nullb *null=
b, struct nullb_page *c_page)
 }
=20
 static int null_make_cache_space(struct nullb *nullb, unsigned long n)
+	__must_hold(&nullb->lock)
 {
 	int i, err, nr_pages;
 	struct nullb_page *c_pages[FREE_BATCH];
@@ -1139,8 +1141,9 @@ static int null_make_cache_space(struct nullb *null=
b, unsigned long n)
 	return 0;
 }
=20
-static blk_status_t copy_to_nullb(struct nullb *nullb, void *source,
-				  loff_t pos, size_t n, bool is_fua)
+static blk_status_t copy_to_nullb(struct nullb *nullb, void *source, lof=
f_t pos,
+				  size_t n, bool is_fua)
+	__must_hold(&nullb->lock)
 {
 	size_t temp, count =3D 0;
 	struct nullb_page *t_page;
@@ -1240,8 +1243,9 @@ static blk_status_t null_handle_flush(struct nullb =
*nullb)
 }
=20
 static blk_status_t null_transfer(struct nullb *nullb, struct page *page=
,
-	unsigned int len, unsigned int off, bool is_write, loff_t pos,
-	bool is_fua)
+				  unsigned int len, unsigned int off,
+				  bool is_write, loff_t pos, bool is_fua)
+	__must_hold(&nullb->lock)
 {
 	struct nullb_device *dev =3D nullb->dev;
 	blk_status_t err =3D BLK_STS_OK;
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zone=
d.c
index 384bdce6a9b7..12a3534ecb85 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -32,6 +32,7 @@ static inline void null_init_zone_lock(struct nullb_dev=
ice *dev,
=20
 static inline void null_lock_zone(struct nullb_device *dev,
 				  struct nullb_zone *zone)
+	__context_unsafe(conditional locking)
 {
 	if (!dev->memory_backed)
 		spin_lock_irq(&zone->spinlock);
@@ -41,6 +42,7 @@ static inline void null_lock_zone(struct nullb_device *=
dev,
=20
 static inline void null_unlock_zone(struct nullb_device *dev,
 				    struct nullb_zone *zone)
+	__context_unsafe(conditional locking)
 {
 	if (!dev->memory_backed)
 		spin_unlock_irq(&zone->spinlock);
