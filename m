Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CB53DB33F
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441585; cv=none; b=aOSsh9v1Gflj4AWVw3LAfabYmXw9/x5Kq/z/s0M6duhthHZryuTprVEmXkPojm0la11r+XP+xZ/ugRK30INuv71wV6Bu0lAjol7GlfvPIgORSMOAC07FhPq0OznTPo0ECyj4Lw1E27nEPOndiw4FhOQeNqLLFjNWHhm+NLU5v7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441585; c=relaxed/simple;
	bh=iKdoqdkwjNZ/kmwwlITxqpyvBUiqme4/EgXC5qcNk1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEWBJkrBWTkGAnggVXd2fOeH17RxDdSTV8XNrsKdLBHDSxjSh/oBcXtk7yzBoHy0PaBZtRWl8M6fchi2n8p9gEMvkD/tbrnFR3hFRJtzfwzQpEVlJbd7NgPOC8uslvanoNptNn7D2Zsu+KCn3smvicstgjstWMrdS/FqK1i/TuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CAmzwKkD; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CAmzwKkD"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0Qx5YYbzlfpPB;
	Thu, 30 Jul 2026 19:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1785441561; x=1788033562; bh=CmVcr
	RB0B+zXhoFuZ/gchbSpfiRE+J9z0SdVSoXaM2Y=; b=CAmzwKkDwPi61kwd+3zHs
	YdhqjQCyl4tp7kVePAziojKcglkbnaynlC24+FbSgeY+7n3uCxswIY8wwKnAR+aT
	FE5SRZ51OH8DmTTVAY0TILgIzOB8LaBdllruR3Q+zEAW6GG6w7G0i8ER5TACq7lv
	IQpG17IaUAfIggI0r9aqplZaOGh2Asv6lbb/SrRKZzbjUL3RWaF5iUW5k2XcknNp
	N8lPcsZDTnPjBQVTFGX96VjjOnqqpqK9a+YWR+qZRJpV0TUBcNOB2pOM78Su98Iw
	3lzOnSWog/8WlpBJIFvPT2qywDhxFTZRGfKlF8RRRMFpvt9+oL5f563xRGOqz1yE
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id T0UzQito86dm; Thu, 30 Jul 2026 19:59:21 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0QZ0vyhzlfvps;
	Thu, 30 Jul 2026 19:59:17 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hans Holmberg <hans.holmberg@wdc.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2 06/12] null_blk: Enable lock context analysis
Date: Thu, 30 Jul 2026 12:58:29 -0700
Message-ID: <55886b395224068987cec253192ae6257e61c960.1785440858.git.bvanassche@acm.org>
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

Add __must_hold() annotations where these are missing. Because
null_lock_zone() and null_unlock_zone() use conditional locking, instead
of annotating these functions, introduce guard class null_zone. Replace
null_lock_zone() and null_unlock_zone() calls with scoped_guard(null_zone=
,
...). Enable lock context analysis in the Makefile.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/Makefile |   2 +
 drivers/block/null_blk/main.c   |   4 ++
 drivers/block/null_blk/zoned.c  | 120 ++++++++++++++------------------
 3 files changed, 57 insertions(+), 69 deletions(-)

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
index f8c0fd57e041..baffc6c61178 100644
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
@@ -1141,6 +1143,7 @@ static int null_make_cache_space(struct nullb *null=
b, unsigned long n)
=20
 static blk_status_t copy_to_nullb(struct nullb *nullb, void *source,
 				  loff_t pos, size_t n, bool is_fua)
+	__must_hold(&nullb->lock)
 {
 	size_t temp, count =3D 0;
 	struct nullb_page *t_page;
@@ -1242,6 +1245,7 @@ static blk_status_t null_handle_flush(struct nullb =
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
index 384bdce6a9b7..dbae748c90ba 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -30,23 +30,26 @@ static inline void null_init_zone_lock(struct nullb_d=
evice *dev,
 		mutex_init(&zone->mutex);
 }
=20
-static inline void null_lock_zone(struct nullb_device *dev,
-				  struct nullb_zone *zone)
-{
-	if (!dev->memory_backed)
-		spin_lock_irq(&zone->spinlock);
-	else
-		mutex_lock(&zone->mutex);
-}
-
-static inline void null_unlock_zone(struct nullb_device *dev,
-				    struct nullb_zone *zone)
-{
-	if (!dev->memory_backed)
-		spin_unlock_irq(&zone->spinlock);
-	else
-		mutex_unlock(&zone->mutex);
-}
+struct nullb_dev_and_zone {
+	struct nullb_device *dev;
+	struct nullb_zone *zone;
+};
+
+DEFINE_CLASS(null_zone, struct nullb_dev_and_zone, ({
+		     if (!_T.dev->memory_backed)
+			     spin_unlock_irq(&_T.zone->spinlock);
+		     else
+			     mutex_unlock(&_T.zone->mutex);
+	     }), ({
+		     if (!dev->memory_backed)
+			     spin_lock_irq(&zone->spinlock);
+		     else
+			     mutex_lock(&zone->mutex);
+		     (struct nullb_dev_and_zone){ dev, zone };
+	     }),
+	     struct nullb_device *dev, struct nullb_zone *zone)
+
+DEFINE_CLASS_IS_UNCONDITIONAL(null_zone)
=20
 int null_init_zoned_dev(struct nullb_device *dev,
 			struct queue_limits *lim)
@@ -216,14 +219,14 @@ int null_report_zones(struct gendisk *disk, sector_=
t sector,
 		 * So use a local copy to avoid corruption of the device zone
 		 * array.
 		 */
-		null_lock_zone(dev, zone);
-		blkz.start =3D zone->start;
-		blkz.len =3D zone->len;
-		blkz.wp =3D zone->wp;
-		blkz.type =3D zone->type;
-		blkz.cond =3D zone->cond;
-		blkz.capacity =3D zone->capacity;
-		null_unlock_zone(dev, zone);
+		scoped_guard(null_zone, dev, zone) {
+			blkz.start =3D zone->start;
+			blkz.len =3D zone->len;
+			blkz.wp =3D zone->wp;
+			blkz.type =3D zone->type;
+			blkz.cond =3D zone->cond;
+			blkz.capacity =3D zone->capacity;
+		}
=20
 		error =3D disk_report_zone(disk, &blkz, i, args);
 		if (error)
@@ -364,7 +367,7 @@ static blk_status_t null_zone_write(struct nullb_cmd =
*cmd, sector_t sector,
 		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
 	}
=20
-	null_lock_zone(dev, zone);
+	guard(null_zone)(dev, zone);
=20
 	/*
 	 * Regular writes must be at the write pointer position. Zone append
@@ -376,19 +379,15 @@ static blk_status_t null_zone_write(struct nullb_cm=
d *cmd, sector_t sector,
 	 */
 	if (append) {
 		if (WARN_ON_ONCE(!dev->zone_append_max_sectors) ||
-		    zone->wp =3D=3D NULL_ZONE_INVALID_WP) {
-			ret =3D BLK_STS_IOERR;
-			goto unlock_zone;
-		}
+		    zone->wp =3D=3D NULL_ZONE_INVALID_WP)
+			return BLK_STS_IOERR;
 		sector =3D zone->wp;
 		blk_mq_rq_from_pdu(cmd)->__sector =3D sector;
 	}
=20
 	if (sector !=3D zone->wp ||
-	    zone->wp + nr_sectors > zone->start + zone->capacity) {
-		ret =3D BLK_STS_IOERR;
-		goto unlock_zone;
-	}
+	    zone->wp + nr_sectors > zone->start + zone->capacity)
+		return BLK_STS_IOERR;
=20
 	if (zone->cond =3D=3D BLK_ZONE_COND_CLOSED ||
 	    zone->cond =3D=3D BLK_ZONE_COND_EMPTY) {
@@ -398,7 +397,7 @@ static blk_status_t null_zone_write(struct nullb_cmd =
*cmd, sector_t sector,
 			ret =3D null_check_zone_resources(dev, zone);
 			if (ret !=3D BLK_STS_OK) {
 				spin_unlock(&dev->zone_res_lock);
-				goto unlock_zone;
+				return ret;
 			}
 			if (zone->cond =3D=3D BLK_ZONE_COND_CLOSED) {
 				dev->nr_zones_closed--;
@@ -415,17 +414,15 @@ static blk_status_t null_zone_write(struct nullb_cm=
d *cmd, sector_t sector,
=20
 	if (dev->badblocks.shift !=3D -1) {
 		badblocks_ret =3D null_handle_badblocks(cmd, sector, &nr_sectors);
-		if (badblocks_ret !=3D BLK_STS_OK && !nr_sectors) {
-			ret =3D badblocks_ret;
-			goto unlock_zone;
-		}
+		if (badblocks_ret !=3D BLK_STS_OK && !nr_sectors)
+			return badblocks_ret;
 	}
=20
 	if (dev->memory_backed) {
 		ret =3D null_handle_memory_backed(cmd, REQ_OP_WRITE, sector,
 						nr_sectors);
 		if (ret !=3D BLK_STS_OK)
-			goto unlock_zone;
+			return ret;
 	}
=20
 	zone->wp +=3D nr_sectors;
@@ -441,12 +438,7 @@ static blk_status_t null_zone_write(struct nullb_cmd=
 *cmd, sector_t sector,
 		zone->cond =3D BLK_ZONE_COND_FULL;
 	}
=20
-	ret =3D badblocks_ret;
-
-unlock_zone:
-	null_unlock_zone(dev, zone);
-
-	return ret;
+	return badblocks_ret;
 }
=20
 static blk_status_t null_open_zone(struct nullb_device *dev,
@@ -655,14 +647,14 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd=
 *cmd, enum req_op op,
 	if (op =3D=3D REQ_OP_ZONE_RESET_ALL) {
 		for (i =3D dev->zone_nr_conv; i < dev->nr_zones; i++) {
 			zone =3D &dev->zones[i];
-			null_lock_zone(dev, zone);
-			if (zone->cond !=3D BLK_ZONE_COND_EMPTY &&
-			    zone->cond !=3D BLK_ZONE_COND_READONLY &&
-			    zone->cond !=3D BLK_ZONE_COND_OFFLINE) {
-				null_reset_zone(dev, zone);
-				trace_nullb_zone_op(cmd, i, zone->cond);
+			scoped_guard(null_zone, dev, zone) {
+				if (zone->cond !=3D BLK_ZONE_COND_EMPTY &&
+				    zone->cond !=3D BLK_ZONE_COND_READONLY &&
+				    zone->cond !=3D BLK_ZONE_COND_OFFLINE) {
+					null_reset_zone(dev, zone);
+					trace_nullb_zone_op(cmd, i, zone->cond);
+				}
 			}
-			null_unlock_zone(dev, zone);
 		}
 		return BLK_STS_OK;
 	}
@@ -670,13 +662,11 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd=
 *cmd, enum req_op op,
 	zone_no =3D null_zone_no(dev, sector);
 	zone =3D &dev->zones[zone_no];
=20
-	null_lock_zone(dev, zone);
+	guard(null_zone)(dev, zone);
=20
 	if (zone->cond =3D=3D BLK_ZONE_COND_READONLY ||
-	    zone->cond =3D=3D BLK_ZONE_COND_OFFLINE) {
-		ret =3D BLK_STS_IOERR;
-		goto unlock;
-	}
+	    zone->cond =3D=3D BLK_ZONE_COND_OFFLINE)
+		return BLK_STS_IOERR;
=20
 	switch (op) {
 	case REQ_OP_ZONE_RESET:
@@ -699,9 +689,6 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *=
cmd, enum req_op op,
 	if (ret =3D=3D BLK_STS_OK)
 		trace_nullb_zone_op(cmd, zone_no, zone->cond);
=20
-unlock:
-	null_unlock_zone(dev, zone);
-
 	return ret;
 }
=20
@@ -710,7 +697,6 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd =
*cmd, enum req_op op,
 {
 	struct nullb_device *dev;
 	struct nullb_zone *zone;
-	blk_status_t sts;
=20
 	switch (op) {
 	case REQ_OP_WRITE:
@@ -729,10 +715,8 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd=
 *cmd, enum req_op op,
 		if (zone->cond =3D=3D BLK_ZONE_COND_OFFLINE)
 			return BLK_STS_IOERR;
=20
-		null_lock_zone(dev, zone);
-		sts =3D null_process_cmd(cmd, op, sector, nr_sectors);
-		null_unlock_zone(dev, zone);
-		return sts;
+		scoped_guard(null_zone, dev, zone)
+			return null_process_cmd(cmd, op, sector, nr_sectors);
 	}
 }
=20
@@ -746,7 +730,7 @@ static void null_set_zone_cond(struct nullb_device *d=
ev,
 			 cond !=3D BLK_ZONE_COND_OFFLINE))
 		return;
=20
-	null_lock_zone(dev, zone);
+	guard(null_zone)(dev, zone);
=20
 	/*
 	 * If the read-only condition is requested again to zones already in
@@ -767,8 +751,6 @@ static void null_set_zone_cond(struct nullb_device *d=
ev,
 		zone->cond =3D cond;
 		zone->wp =3D NULL_ZONE_INVALID_WP;
 	}
-
-	null_unlock_zone(dev, zone);
 }
=20
 /*
