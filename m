Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C81DD877
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981243; cv=none; b=Iu0v8+UQWFIcl8+mx+/fxK9Do4yJWGr0U7RnVpW2eun5sLUOFVQo4BoGnMR0hLyrcvcvOWn6oFh3VBQ9xJfVC7srONni3H9OqJGuEm+9UAivjOatA69VHfMPXYu8BlKmoEIkrmP3mwly/WKLuYNOGqULl3TyiHB4B/8xOzbiUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981243; c=relaxed/simple;
	bh=dY+plBFSBACAfUO2Nso0B7I5fr4OO1/B48+2jZyJHjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUZm9NzKoqXc1jzn3Li6QzWLdniVjpbNbOGBqwdVY3i8XCTabjZLPrEPR4rXAhbt0+dnCdm5oA1vPcZaqXgeD/T7Md5BW6XicZft6SZADh0UdeGIa3Paaf4r/adn1pcN7bImb9flJRXupcrADnNhpwgJuPHiekvWOXGufzyxfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mU0teB0o; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mU0teB0o"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYLjN2xdHz6CmM6M;
	Wed, 15 Jan 2025 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1736981234; x=1739573235; bh=krRN/
	Q54JB7gsBwcJitQM3QAdibDLvVQac+ARKsxcuw=; b=mU0teB0oz4x3NonzMtZ7I
	8C3L65BDSZw7W6bdhFVxsQIdTMhtKs9jmmfiF+Lw7mi42TjS+KFcO9zrWo3mYXOn
	VjkB3lYCzKDknBYJpOCWi9bDJuzduUwkDyuWWlPuFUGSxLSqIR4vSkbdgAXi0G21
	gDeheuKOggP3N+Y49jJ4Lvvwj1jjNOB888BA0HNXoTY6L/+3c5um6ku5EKLpvj5f
	frwpy8GW5Z/qQGPowDW/qMVIJY5lYqRlwYq4zlADH3w4nfsKDJCgVRxV7dApfVsk
	eK5lt0PiAPRbIzMmZOynanKSxbl+Z+dhbycEjp2m2lV209cZDJLxMqhtd2xy4iN9
	A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GPiaIbyDG42m; Wed, 15 Jan 2025 22:47:14 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYLjD706cz6CmR5y;
	Wed, 15 Jan 2025 22:47:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v17 06/14] blk-zoned: Track the write pointer per zone
Date: Wed, 15 Jan 2025 14:46:40 -0800
Message-ID: <20250115224649.3973718-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
In-Reply-To: <20250115224649.3973718-1-bvanassche@acm.org>
References: <20250115224649.3973718-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Derive the write pointer from successfully completed zoned writes. This
patch prepares for restoring the write pointer after a write has failed
either by the device (e.g. a unit attention or an unaligned write) or by
the driver (e.g.  BLK_STS_RESOURCE).

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 37 +++++++++++++++++++++++++++++--------
 block/blk.h       |  4 +++-
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9d08a54c201e..089c6740df4a 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -51,6 +51,8 @@ static const char *const zone_cond_name[] =3D {
  * @zone_no: The number of the zone the plug is managing.
  * @wp_offset: The zone write pointer location relative to the start of =
the zone
  *             as a number of 512B sectors.
+ * @wp_offset_compl: End offset for completed zoned writes as a number o=
f 512
+ *		     byte sectors.
  * @bio_list: The list of BIOs that are currently plugged.
  * @bio_work: Work struct to handle issuing of plugged BIOs
  * @rcu_head: RCU head to free zone write plugs with an RCU grace period=
.
@@ -63,6 +65,7 @@ struct blk_zone_wplug {
 	unsigned int		flags;
 	unsigned int		zone_no;
 	unsigned int		wp_offset;
+	unsigned int		wp_offset_compl;
 	struct bio_list		bio_list;
 	struct work_struct	bio_work;
 	struct rcu_head		rcu_head;
@@ -554,6 +557,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_=
wplug(struct gendisk *disk,
 	zwplug->flags =3D 0;
 	zwplug->zone_no =3D zno;
 	zwplug->wp_offset =3D bdev_offset_from_zone_start(disk->part0, sector);
+	zwplug->wp_offset_compl =3D zwplug->wp_offset;
 	bio_list_init(&zwplug->bio_list);
 	INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
 	zwplug->disk =3D disk;
@@ -612,6 +616,7 @@ static void disk_zone_wplug_set_wp_offset(struct gend=
isk *disk,
 	/* Update the zone write pointer and abort all plugged BIOs. */
 	zwplug->flags &=3D ~BLK_ZONE_WPLUG_NEED_WP_UPDATE;
 	zwplug->wp_offset =3D wp_offset;
+	zwplug->wp_offset_compl =3D zwplug->wp_offset;
 	disk_zone_wplug_abort(zwplug);
=20
 	/*
@@ -1148,6 +1153,7 @@ void blk_zone_write_plug_bio_endio(struct bio *bio)
 	struct gendisk *disk =3D bio->bi_bdev->bd_disk;
 	struct blk_zone_wplug *zwplug =3D
 		disk_get_zone_wplug(disk, bio->bi_iter.bi_sector);
+	unsigned int end_sector;
 	unsigned long flags;
=20
 	if (WARN_ON_ONCE(!zwplug))
@@ -1165,11 +1171,24 @@ void blk_zone_write_plug_bio_endio(struct bio *bi=
o)
 		bio->bi_opf |=3D REQ_OP_ZONE_APPEND;
 	}
=20
-	/*
-	 * If the BIO failed, abort all plugged BIOs and mark the plug as
-	 * needing a write pointer update.
-	 */
-	if (bio->bi_status !=3D BLK_STS_OK) {
+	if (bio->bi_status =3D=3D BLK_STS_OK) {
+		switch (bio_op(bio)) {
+		case REQ_OP_WRITE:
+		case REQ_OP_ZONE_APPEND:
+		case REQ_OP_WRITE_ZEROES:
+			end_sector =3D bdev_offset_from_zone_start(disk->part0,
+				     bio->bi_iter.bi_sector + bio_sectors(bio));
+			if (end_sector > zwplug->wp_offset_compl)
+				zwplug->wp_offset_compl =3D end_sector;
+			break;
+		default:
+			break;
+		}
+	} else {
+		/*
+		 * If the BIO failed, mark the plug as having an error to
+		 * trigger recovery.
+		 */
 		spin_lock_irqsave(&zwplug->lock, flags);
 		disk_zone_wplug_abort(zwplug);
 		zwplug->flags |=3D BLK_ZONE_WPLUG_NEED_WP_UPDATE;
@@ -1772,7 +1791,7 @@ EXPORT_SYMBOL_GPL(blk_zone_issue_zeroout);
 static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
 				  struct seq_file *m)
 {
-	unsigned int zwp_wp_offset, zwp_flags;
+	unsigned int zwp_wp_offset, zwp_wp_offset_compl, zwp_flags;
 	unsigned int zwp_zone_no, zwp_ref;
 	unsigned int zwp_bio_list_size;
 	unsigned long flags;
@@ -1782,11 +1801,13 @@ static void queue_zone_wplug_show(struct blk_zone=
_wplug *zwplug,
 	zwp_flags =3D zwplug->flags;
 	zwp_ref =3D refcount_read(&zwplug->ref);
 	zwp_wp_offset =3D zwplug->wp_offset;
+	zwp_wp_offset_compl =3D zwplug->wp_offset_compl;
 	zwp_bio_list_size =3D bio_list_size(&zwplug->bio_list);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
=20
-	seq_printf(m, "%u 0x%x %u %u %u\n", zwp_zone_no, zwp_flags, zwp_ref,
-		   zwp_wp_offset, zwp_bio_list_size);
+	seq_printf(m, "zone_no %u flags 0x%x ref %u wp_offset %u wp_offset_comp=
l %u bio_list_size %u\n",
+		   zwp_zone_no, zwp_flags, zwp_ref, zwp_wp_offset,
+		   zwp_wp_offset_compl, zwp_bio_list_size);
 }
=20
 int queue_zone_wplugs_show(void *data, struct seq_file *m)
diff --git a/block/blk.h b/block/blk.h
index 4904b86d5fec..2274253cfa58 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -470,8 +470,10 @@ static inline void blk_zone_update_request_bio(struc=
t request *rq,
 	 * the original BIO sector so that blk_zone_write_plug_bio_endio() can
 	 * lookup the zone write plug.
 	 */
-	if (req_op(rq) =3D=3D REQ_OP_ZONE_APPEND || bio_zone_write_plugging(bio=
))
+	if (req_op(rq) =3D=3D REQ_OP_ZONE_APPEND || bio_zone_write_plugging(bio=
)) {
 		bio->bi_iter.bi_sector =3D rq->__sector;
+		bio->bi_iter.bi_size =3D rq->__data_len;
+	}
 }
 void blk_zone_write_plug_bio_endio(struct bio *bio);
 static inline void blk_zone_bio_endio(struct bio *bio)
