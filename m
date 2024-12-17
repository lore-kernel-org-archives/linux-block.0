Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A066EEB2
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734475119; cv=none; b=R+lSM42EPW4nDsXyBEgJkX0dz7z0yXA0HfvzsN/PTCMWw8qMcAvTzLPn3vx7wjCLQ52xNegO2Q9KdYRiH/vHSDSKLSKfIHy0RPYFEQv3Rc8SYl/xg5yiPeX53Eo4Uj3c2MZ9hGz8jeBcMsYzLtqDI8Fp0DNNEX7ji1gu+VNZvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734475119; c=relaxed/simple;
	bh=wxmHeIZ0lwMQSO27Ndq0U3Wr1DsdgneNbGlkCtlWkL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv+qIf3IIO5gbOcSIw1PT95MKVv0vbdKZ3pVFD+wckCxhvrFKHmtmR3aiMZN03dQF0nrcg+7i/4N3IiENsfgNbhTl3Mp8TDkrdNW99WmPsG0lFTKLtsYn8wStH6MUNH0tq9ASOqgHXrmx9CEA0pV5R9bfED07+cgRMuhsZitRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=x71e9wxm; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="x71e9wxm"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCWtj4RstzlfflB;
	Tue, 17 Dec 2024 22:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734475112; x=1737067113; bh=rHQDf
	zQUeU7XswfoG6RJd+cDOB7knIiXQZQzmovDXG4=; b=x71e9wxmyH6ZdcLIzI6n7
	5+QQ0UwRrs9djSgil70sqlv6RbrCpEjfv6MwJFxknuUex3kJiC3TRlSCv7qZz/Tk
	aUun5tufPns9DEuxHFxXccNvWUaIiElO3yFLDX1MjPm8QJOsgvceKfDBp090fG0q
	6zU9hCqTUPkh7EgojmTmVVgQSZxau/ZkYgBKjZVlXubKQ76hGgGXUGin/+cVcgPn
	9Ux4+c+HYJpffG06nyKAc7+uCInJbDSvVhlAGfei/N4L8qrHPfefvykW/7zNMq1s
	5xFYo6+ZIE5iZYif6T35Ii78G+RXaJvAvxRlpYH1F4qOuuEozlz99s49bpKLvSkR
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uOvD0J1pb9ca; Tue, 17 Dec 2024 22:38:32 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCWtb1d9nzlff02;
	Tue, 17 Dec 2024 22:38:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 3/3] blk-zoned: Move more error handling into blk_mq_submit_bio()
Date: Tue, 17 Dec 2024 14:38:09 -0800
Message-ID: <20241217223809.683035-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241217223809.683035-1-bvanassche@acm.org>
References: <20241217223809.683035-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The error handling code in blk_zone_plug_bio() and in the functions
called by blk_zone_plug_bio() cannot be understood without knowing
that these functions are only called by blk_mq_submit_bio(). Move
the error handling code in blk_mq_submit_bio() such that all error
handling code for blk_mq_submit_bio() occurs inside blk_mq_submit_bio()
itself.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         | 16 ++++++++--
 block/blk-zoned.c      | 67 +++++++++++++++++++-----------------------
 include/linux/blkdev.h | 13 ++++++--
 3 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f4300e608ed8..2449f412dd00 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3095,8 +3095,20 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
 		goto queue_exit;
=20
-	if (blk_queue_is_zoned(q) && blk_zone_plug_bio(bio, nr_segs))
-		goto queue_exit;
+	if (blk_queue_is_zoned(q)) {
+		switch (blk_zone_plug_bio(bio, nr_segs)) {
+		case bzp_not_plugged:
+			break;
+		case bzp_plugged:
+			goto queue_exit;
+		case bzp_wouldblock:
+			bio_wouldblock_error(bio);
+			goto queue_exit;
+		case bzp_failed:
+			bio_io_error(bio);
+			goto queue_exit;
+		}
+	}
=20
 new_request:
 	if (rq) {
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 4b0be40a8ea7..cb2c05d8b1eb 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -675,8 +675,8 @@ static int disk_zone_sync_wp_offset(struct gendisk *d=
isk, sector_t sector)
 					disk_report_zones_cb, &args);
 }
=20
-static bool blk_zone_wplug_handle_reset_or_finish(struct bio *bio,
-						  unsigned int wp_offset)
+static enum blk_zone_plug_status
+blk_zone_wplug_handle_reset_or_finish(struct bio *bio, unsigned int wp_o=
ffset)
 {
 	struct gendisk *disk =3D bio->bi_bdev->bd_disk;
 	sector_t sector =3D bio->bi_iter.bi_sector;
@@ -684,10 +684,8 @@ static bool blk_zone_wplug_handle_reset_or_finish(st=
ruct bio *bio,
 	unsigned long flags;
=20
 	/* Conventional zones cannot be reset nor finished. */
-	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
-		bio_io_error(bio);
-		return true;
-	}
+	if (!bdev_zone_is_seq(bio->bi_bdev, sector))
+		return bzp_failed;
=20
 	/*
 	 * No-wait reset or finish BIOs do not make much sense as the callers
@@ -713,10 +711,11 @@ static bool blk_zone_wplug_handle_reset_or_finish(s=
truct bio *bio,
 		disk_put_zone_wplug(zwplug);
 	}
=20
-	return false;
+	return bzp_not_plugged;
 }
=20
-static bool blk_zone_wplug_handle_reset_all(struct bio *bio)
+static enum blk_zone_plug_status
+blk_zone_wplug_handle_reset_all(struct bio *bio)
 {
 	struct gendisk *disk =3D bio->bi_bdev->bd_disk;
 	struct blk_zone_wplug *zwplug;
@@ -739,7 +738,7 @@ static bool blk_zone_wplug_handle_reset_all(struct bi=
o *bio)
 		}
 	}
=20
-	return false;
+	return bzp_not_plugged;
 }
=20
 static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
@@ -964,7 +963,8 @@ static bool blk_zone_wplug_prepare_bio(struct blk_zon=
e_wplug *zwplug,
 	return true;
 }
=20
-static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr=
_segs)
+static enum blk_zone_plug_status
+blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 {
 	struct gendisk *disk =3D bio->bi_bdev->bd_disk;
 	sector_t sector =3D bio->bi_iter.bi_sector;
@@ -980,19 +980,15 @@ static bool blk_zone_wplug_handle_write(struct bio =
*bio, unsigned int nr_segs)
 	 * BIO-based devices, it is the responsibility of the driver to split
 	 * the bio before submitting it.
 	 */
-	if (WARN_ON_ONCE(bio_straddles_zones(bio))) {
-		bio_io_error(bio);
-		return true;
-	}
+	if (WARN_ON_ONCE(bio_straddles_zones(bio)))
+		return bzp_failed;
=20
 	/* Conventional zones do not need write plugging. */
 	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
 		/* Zone append to conventional zones is not allowed. */
-		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
-			bio_io_error(bio);
-			return true;
-		}
-		return false;
+		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)
+			return bzp_failed;
+		return bzp_not_plugged;
 	}
=20
 	if (bio->bi_opf & REQ_NOWAIT)
@@ -1001,10 +997,9 @@ static bool blk_zone_wplug_handle_write(struct bio =
*bio, unsigned int nr_segs)
 	zwplug =3D disk_get_and_lock_zone_wplug(disk, sector, gfp_mask, &flags)=
;
 	if (!zwplug) {
 		if (bio->bi_opf & REQ_NOWAIT)
-			bio_wouldblock_error(bio);
+			return bzp_wouldblock;
 		else
-			bio_io_error(bio);
-		return true;
+			return bzp_failed;
 	}
=20
 	/* Indicate that this BIO is being handled using zone write plugging. *=
/
@@ -1022,22 +1017,21 @@ static bool blk_zone_wplug_handle_write(struct bi=
o *bio, unsigned int nr_segs)
=20
 	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
 		spin_unlock_irqrestore(&zwplug->lock, flags);
-		bio_io_error(bio);
-		return true;
+		return bzp_failed;
 	}
=20
 	zwplug->flags |=3D BLK_ZONE_WPLUG_PLUGGED;
=20
 	spin_unlock_irqrestore(&zwplug->lock, flags);
=20
-	return false;
+	return bzp_not_plugged;
=20
 plug:
 	disk_zone_wplug_add_bio(disk, zwplug, bio, nr_segs);
=20
 	spin_unlock_irqrestore(&zwplug->lock, flags);
=20
-	return true;
+	return bzp_plugged;
 }
=20
 /**
@@ -1048,16 +1042,17 @@ static bool blk_zone_wplug_handle_write(struct bi=
o *bio, unsigned int nr_segs)
  * Handle write, write zeroes and zone append operations requiring emula=
tion
  * using zone write plugging.
  *
- * Return true whenever @bio execution needs to be delayed through the z=
one
- * write plug. Otherwise, return false to let the submission path proces=
s
- * @bio normally.
+ * Return %bzp_plugged if the @bio has been scheduled for delayed execut=
ion by
+ * adding it to zwplug->bio_list; %bzp_failed if the caller should fail =
@bio or
+ * %bzp_not_plugged to let the submission path process @bio normally.
  */
-bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
+enum blk_zone_plug_status blk_zone_plug_bio(struct bio *bio,
+					    unsigned int nr_segs)
 {
 	struct block_device *bdev =3D bio->bi_bdev;
=20
 	if (!bdev->bd_disk->zone_wplugs_hash)
-		return false;
+		return bzp_not_plugged;
=20
 	/*
 	 * If the BIO already has the plugging flag set, then it was already
@@ -1065,7 +1060,7 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned in=
t nr_segs)
 	 * plug bio submit work.
 	 */
 	if (bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING))
-		return false;
+		return bzp_not_plugged;
=20
 	/*
 	 * We do not need to do anything special for empty flush BIOs, e.g
@@ -1075,7 +1070,7 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned in=
t nr_segs)
 	 * the written data.
 	 */
 	if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
-		return false;
+		return bzp_not_plugged;
=20
 	/*
 	 * Regular writes and write zeroes need to be handled through the targe=
t
@@ -1097,7 +1092,7 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned in=
t nr_segs)
 	switch (bio_op(bio)) {
 	case REQ_OP_ZONE_APPEND:
 		if (!bdev_emulates_zone_append(bdev))
-			return false;
+			return bzp_not_plugged;
 		fallthrough;
 	case REQ_OP_WRITE:
 	case REQ_OP_WRITE_ZEROES:
@@ -1110,10 +1105,10 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned =
int nr_segs)
 	case REQ_OP_ZONE_RESET_ALL:
 		return blk_zone_wplug_handle_reset_all(bio);
 	default:
-		return false;
+		return bzp_not_plugged;
 	}
=20
-	return false;
+	return bzp_not_plugged;
 }
 EXPORT_SYMBOL_GPL(blk_zone_plug_bio);
=20
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 39e5ffbf6d31..22f3ca58522d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -690,18 +690,27 @@ static inline bool blk_queue_is_zoned(struct reques=
t_queue *q)
 		(q->limits.features & BLK_FEAT_ZONED);
 }
=20
+enum blk_zone_plug_status {
+	bzp_not_plugged,
+	bzp_plugged,
+	bzp_wouldblock,
+	bzp_failed,
+};
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
 	return disk->nr_zones;
 }
-bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
+enum blk_zone_plug_status blk_zone_plug_bio(struct bio *bio,
+					    unsigned int nr_segs);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
 	return 0;
 }
-static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_se=
gs)
+static inline enum blk_zone_plug_status blk_zone_plug_bio(struct bio *bi=
o,
+							  unsigned int nr_segs)
 {
 	return false;
 }
