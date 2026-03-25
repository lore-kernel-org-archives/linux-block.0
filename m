Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96AD2773DE
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475200; cv=none; b=lI32edoVgfp0+8icLZUbSsJMKWkMeHzbk9Ixi2GpHLSbDL5NjCUHHHt+Br1nkuS8MLrVWhdO5BqgJsob1saEusZhnEKxjXbYj4tjjTFSkEDS6f6shqW1A/+TgzAiWM9VEofFROMafq0NFDTjlLM5djv3claaGyFsICgDVQgXRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475200; c=relaxed/simple;
	bh=nm8JA2kyBIENOx7ohAAYagVWpNBayDQCkpOAuW4mje8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X35qtOgJxdM4bh2d7vLxSbbGctaCi2kWAMucYEtEPhyqUe+NlkRVPk54tqDOEOXR6hAUm4AMB2GZtTbs6XKyxq3rOArqI07eEOpLPBAl5ZqgmqwiRChMgjpZw41Aj/blDRf5QukCiMMNue/NSOmURJkjlzGQVZRPY5p02BV+qVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=k902F8eg; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="k902F8eg"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0q24YXBzlgyG8;
	Wed, 25 Mar 2026 21:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475183; x=1777067184; bh=0gTB2
	UEjOM9d0OIGuw1gK+AYxBXLR0sNcFciNkHEsR4=; b=k902F8egLiN12bw9ZMOWq
	jsjPjy1xEi6G6ChbcbpTnSiC4w7jeUs7KdDhYu9SJJ5/D8Y/RVDzEoMaH7159foh
	4PzB5OkQNRGurgmz7QMR029ZTT18tTGg2dNMztV01viyjH13ywzo2U+rHH64YVNt
	rnbJSe7jHkU53873+W17gYc1vaEfvZFJIkAkuavG31ibLpg0uGpqseYmJVZ3vbX3
	CthzI8Zd7o1zBuv7dmpjOQJpaeb2x4KrsTA3M2Fz0pWZQedhHann8W2jXPl72Qoa
	ECcwO/Y3jJurkcP9CsrGt82FyToEpcbcAlMdK4SQqurHxAwZ6z8HD14s2HnF+fYl
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id f5Y6GUggswk9; Wed, 25 Mar 2026 21:46:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0ph5XpDzlfvpM;
	Wed, 25 Mar 2026 21:46:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Kees Cook <kees@kernel.org>,
	Genjian Zhang <zhanggenjian@kylinos.cn>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 20/26] null_blk: Enable lock context analysis
Date: Wed, 25 Mar 2026 14:45:01 -0700
Message-ID: <20260325214518.2854494-21-bvanassche@acm.org>
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

Convert __releases() __acquires() into __must_hold(). Add __must_hold()
annotations where these are missing. Annotate two functions that use
conditional locking with __no_context_analysis. Enable lock context
analysis in the Makefile.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/Makefile | 2 ++
 drivers/block/null_blk/main.c   | 7 +++++--
 drivers/block/null_blk/zoned.c  | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

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
