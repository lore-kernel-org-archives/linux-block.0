Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB53ED5C7
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691818; cv=none; b=YaVEVLcuzU0ZTO5u1gOeipwC90i9F3z1Vb8FoZ+RLjKpO4SB5Hl/LMpoBW9rpR+xM938Ub31931Xj8ayiiUUXi/ZCTjAgqFF58npQsz1JmiYMUVsRb5fs7dyBh86p81KM82mHRNS2K5b0ClgVpnA5uXwzBohN7/HughY/n5hHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691818; c=relaxed/simple;
	bh=lGpgp/pP44twBOfzkFzPhu02G8F+V3SWZd3Z9ULCkdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NadTbcfW1IFyJFPh32TJZbJW1Q7aXg5JawJuvznO+k3Hv5ibNxK9E8IF5f8RtsojsQIe8y6ZkUI9h+nWlkbBeqLPv8OT+Z9O+e/BUVX7OXXgCXY/AIFofZANnm3Xj9IhS9PbrNB0aXPfZ6pFBIqAphMPsA2oFkOwlXpqQwKw3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Gg/xdwAG; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Gg/xdwAG"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR6103CfzlffvM;
	Mon, 16 Mar 2026 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773691809; x=1776283810; bh=kNmGJ
	6Up0rN4oo8KjI8b7+CYlSoKZdI07TEro6snXSA=; b=Gg/xdwAGFpbKduZEePUFG
	6DRxsBZdQuU6+T4Vlu7DVCwveXh/Pu6LI5lJpV4fbCEebokFMpDj8ijJYLH2Odvn
	Z7BtwkDxQfWCC+dRPyQ408pRg6rEj8Rdv1OKgA3w41HyY48QFvFRK1NR8J1dSMUl
	UpL+RtPpjXfOXSRidD4G6O2gLHs6w4sJvHz9Zw8vxq1Z14cf2IWH677JPTGwQlRx
	tG4OmM2Bc1i0venvJlbkktYhY6BaK17CCQEaDA8Chgo6qvd2G5aT+S2v/Cm4wyj5
	o1I+F2N+f6KmjBBxxFdsxnhVJSpctWlWKWozi2lcPm4ToPU2vi3r83Nmi9iwrh3D
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bvbVrSfDjBUF; Mon, 16 Mar 2026 20:10:09 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR5k4WBLzlgyG9;
	Mon, 16 Mar 2026 20:10:01 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Genjian Zhang <zhanggenjian@kylinos.cn>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2 07/12] null_blk: Add more lock context annotations
Date: Mon, 16 Mar 2026 13:08:44 -0700
Message-ID: <20260316200901.4111651-9-bvanassche@acm.org>
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

Prepare for enabling lock context analysis by adding the lock context
annotations that are required by Clang.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c  | 7 +++++--
 drivers/block/null_blk/zoned.c | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index f8c0fd57e041..677ac829ef80 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1004,8 +1004,7 @@ static struct nullb_page *null_lookup_page(struct n=
ullb *nullb,
=20
 static struct nullb_page *null_insert_page(struct nullb *nullb,
 					   sector_t sector, bool ignore_cache)
-	__releases(&nullb->lock)
-	__acquires(&nullb->lock)
+	__must_hold(&nullb->lock)
 {
 	u64 idx;
 	struct nullb_page *t_page;
@@ -1038,6 +1037,7 @@ static struct nullb_page *null_insert_page(struct n=
ullb *nullb,
 }
=20
 static int null_flush_cache_page(struct nullb *nullb, struct nullb_page =
*c_page)
+	__must_hold(&nullb->lock)
 {
 	int i;
 	unsigned int offset;
@@ -1087,6 +1087,7 @@ static int null_flush_cache_page(struct nullb *null=
b, struct nullb_page *c_page)
 }
=20
 static int null_make_cache_space(struct nullb *nullb, unsigned long n)
+	__must_hold(&nullb->lock)
 {
 	int i, err, nr_pages;
 	struct nullb_page *c_pages[FREE_BATCH];
@@ -1141,6 +1142,7 @@ static int null_make_cache_space(struct nullb *null=
b, unsigned long n)
=20
 static blk_status_t copy_to_nullb(struct nullb *nullb, void *source,
 				  loff_t pos, size_t n, bool is_fua)
+	__must_hold(&nullb->lock)
 {
 	size_t temp, count =3D 0;
 	struct nullb_page *t_page;
@@ -1242,6 +1244,7 @@ static blk_status_t null_handle_flush(struct nullb =
*nullb)
 static blk_status_t null_transfer(struct nullb *nullb, struct page *page=
,
 	unsigned int len, unsigned int off, bool is_write, loff_t pos,
 	bool is_fua)
+	__must_hold(&nullb->lock)
 {
 	struct nullb_device *dev =3D nullb->dev;
 	blk_status_t err =3D BLK_STS_OK;
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zone=
d.c
index 384bdce6a9b7..a7f94e76034f 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -32,6 +32,7 @@ static inline void null_init_zone_lock(struct nullb_dev=
ice *dev,
=20
 static inline void null_lock_zone(struct nullb_device *dev,
 				  struct nullb_zone *zone)
+	__no_context_analysis /* conditional locking */
 {
 	if (!dev->memory_backed)
 		spin_lock_irq(&zone->spinlock);
@@ -41,6 +42,7 @@ static inline void null_lock_zone(struct nullb_device *=
dev,
=20
 static inline void null_unlock_zone(struct nullb_device *dev,
 				    struct nullb_zone *zone)
+	__no_context_analysis /* conditional locking */
 {
 	if (!dev->memory_backed)
 		spin_unlock_irq(&zone->spinlock);
