Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF9388E62
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653779; cv=none; b=uJpQnKsa8LWcqDDMLWWL3VFsbVutDld+Bz520InSm1qYX+7Hg9fhBY7Cxk+4me6Jkr28kMswYsynL+ebzaghebmQr+ugDZbDa6aGilJZZ1DQ7SLS3wHXRjy5gssUDpaWEOWxllTSsw5+7GVs7KPZ+kDGYgTM05mP/AbLbTDHAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653779; c=relaxed/simple;
	bh=lGpgp/pP44twBOfzkFzPhu02G8F+V3SWZd3Z9ULCkdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RL+dnD9szRMau+8yKyD0J1RlSkmtPO1RzHq7i0L4rnXENr6pqjpvEL/vnfbs5bl8Ro2qhJ33BREw/SVtLOLvhyLVNqWLIi9jXLPKiWArqYpoAk0YuHzq4duCWjb4b+p8Uop2GFo6wQ0W6CYd+1Lv0T9naLvoGppcxYZryekz4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1k0ErsbO; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1k0ErsbO"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3Cj6hg1z1XMFwj;
	Wed,  4 Mar 2026 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653767; x=1775245768; bh=kNmGJ
	6Up0rN4oo8KjI8b7+CYlSoKZdI07TEro6snXSA=; b=1k0ErsbOuJcSblOVrTnSW
	Lbx/LN0Fbol6PeoxsyvWmcFFcUMuZpZA+OnMOxdQWzvflA0DBYhH3ru7ieaEVHGL
	3KOXR92KLUqy1dQd9HZbnkhY41s+qp8JJU9Yt3IGOblm9W3eSWC4PgNleDKkELU8
	EcwWSQMdZv3JBsmXwmtYNxv+ubpTILrbOYD/hpymOLPo4mgem3X2sT9EYaPqgMoi
	8KN4CYkYzN02z3FTKkpYn/tc538qSL0SayBpBSMqGOXHTTnp7aW/0p/kj2t7SPN7
	fq1daONUbKXsdOZCGOnuhgQ+pFBLoVUpKHY8y3YQWKXFC7pT6EudrZgypXcXIhY3
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MgFA1pQTDzLC; Wed,  4 Mar 2026 19:49:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3CR1V22z1XM6JV;
	Wed,  4 Mar 2026 19:49:22 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Zheng Qixing <zhengqixing@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 08/14] null_blk: Add more lock context annotations
Date: Wed,  4 Mar 2026 11:48:27 -0800
Message-ID: <20260304194843.760669-9-bvanassche@acm.org>
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
