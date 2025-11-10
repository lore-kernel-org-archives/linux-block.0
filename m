Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F33D303A1A
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813839; cv=none; b=t0vvIIRAvV9iWTpAAV2fBUBQfYesvXcgd8X9V6CVMl+tADz+nlg25TP0mza5lA0xMmgBmB13P0GH6f6236o1nJI4ncTMpweMDYqSR6Pp+A8jS3cuB5JE7Tr5dsVJtxjEp29b1hjgRVZ5WyjCmNSF7HXXV40BAK4Gcsy001qN2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813839; c=relaxed/simple;
	bh=dBSv/jcxqrVTYY2z7oZ3IW1vuQfuEwzWNI1PGG+MFPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxRQgRZLWDyCRcReYGV4zbMt/0R9MqTJO9x/Wb9iKDXUCelMXCH2KsF1UM4VvzPK4k5jQakEgUcCfojrWzdEn2Uii6eqHgiXdemo/ouq1auY1HRMGFk7O9jYVOjehoBHZm0YIIHfbejLQx6wS5wBQQA6ouIUNx8gCvQfb3ZLDps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0jch2/Gw; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0jch2/Gw"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d54B44vvBzltH96;
	Mon, 10 Nov 2025 22:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1762813835; x=1765405836; bh=YelaY
	WhHzmj60CWF76SzrXTts47H5yIgwLWy4CiaxtY=; b=0jch2/Gw4pfn8pb8AI3/L
	Gtk+PyOradXe0e+ygtLq8GCBqwR/3sVlHShf5knlvnCNgGW1oPy+sbYxcVRZuh0w
	pPkPREfGiqDas0HbSPnR4AghPz1Y2yl9iP6npUFmx88nithg5oDqAafpYaFgAnCg
	PNgD720SJbXle3gz3BGSBt5NSzh9yBcPRJsoEwIO/Istmx8CWyGpiptzFyBQrnoo
	HUe3pQpCLzr0kKAEQF3T4Z71yUeXUpx1N8pOUWa70q8nErQ/cUGHOJkOzBbV2M/T
	hU5FEHA6iTuCexUrgg8EETEur+kHNagA8B3lk9OERohs1JEzdqEuN7tO33ar3P3E
	g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mASlklWxs-lI; Mon, 10 Nov 2025 22:30:35 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d54B03pX6zlv4DL;
	Mon, 10 Nov 2025 22:30:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 4/4] blk-zoned: Move code from disk_zone_wplug_add_bio() into its caller
Date: Mon, 10 Nov 2025 14:30:02 -0800
Message-ID: <20251110223003.2900613-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251110223003.2900613-1-bvanassche@acm.org>
References: <20251110223003.2900613-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move the following code into the only caller of disk_zone_wplug_add_bio()=
:
 - The code for clearing the REQ_NOWAIT flag.
 - The code that sets the BLK_ZONE_WPLUG_PLUGGED flag.
 - The disk_zone_wplug_schedule_bio_work() call.

This patch moves all code that is related to REQ_NOWAIT or to bio
scheduling into a single function. No functionality has been changed.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 73c7358ec184..bff953416ffc 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1204,8 +1204,6 @@ static inline void disk_zone_wplug_add_bio(struct g=
endisk *disk,
 				struct blk_zone_wplug *zwplug,
 				struct bio *bio, unsigned int nr_segs)
 {
-	bool schedule_bio_work =3D false;
-
 	/*
 	 * Grab an extra reference on the BIO request queue usage counter.
 	 * This reference will be reused to submit a request for the BIO for
@@ -1221,16 +1219,6 @@ static inline void disk_zone_wplug_add_bio(struct =
gendisk *disk,
 	 */
 	bio_clear_polled(bio);
=20
-	/*
-	 * REQ_NOWAIT BIOs are always handled using the zone write plug BIO
-	 * work, which can block. So clear the REQ_NOWAIT flag and schedule the
-	 * work if this is the first BIO we are plugging.
-	 */
-	if (bio->bi_opf & REQ_NOWAIT) {
-		schedule_bio_work =3D !(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
-		bio->bi_opf &=3D ~REQ_NOWAIT;
-	}
-
 	/*
 	 * Reuse the poll cookie field to store the number of segments when
 	 * split to the hardware limits.
@@ -1246,11 +1234,6 @@ static inline void disk_zone_wplug_add_bio(struct =
gendisk *disk,
 	bio_list_add(&zwplug->bio_list, bio);
 	trace_disk_zone_wplug_add_bio(zwplug->disk->queue, zwplug->zone_no,
 				      bio->bi_iter.bi_sector, bio_sectors(bio));
-
-	zwplug->flags |=3D BLK_ZONE_WPLUG_PLUGGED;
-
-	if (schedule_bio_work)
-		disk_zone_wplug_schedule_bio_work(disk, zwplug);
 }
=20
 /*
@@ -1418,6 +1401,7 @@ static bool blk_zone_wplug_handle_write(struct bio =
*bio, unsigned int nr_segs)
 {
 	struct gendisk *disk =3D bio->bi_bdev->bd_disk;
 	sector_t sector =3D bio->bi_iter.bi_sector;
+	bool schedule_bio_work =3D false;
 	struct blk_zone_wplug *zwplug;
 	gfp_t gfp_mask =3D GFP_NOIO;
 	unsigned long flags;
@@ -1464,8 +1448,10 @@ static bool blk_zone_wplug_handle_write(struct bio=
 *bio, unsigned int nr_segs)
 	 * Add REQ_NOWAIT BIOs to the plug list to ensure that we will not see =
a
 	 * BLK_STS_AGAIN failure if we let the BIO execute.
 	 */
-	if (bio->bi_opf & REQ_NOWAIT)
+	if (bio->bi_opf & REQ_NOWAIT) {
+		bio->bi_opf &=3D ~REQ_NOWAIT;
 		goto plug;
+	}
=20
 	/* If the zone is already plugged, add the BIO to the BIO plug list. */
 	if (zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)
@@ -1485,7 +1471,12 @@ static bool blk_zone_wplug_handle_write(struct bio=
 *bio, unsigned int nr_segs)
 	return false;
=20
 plug:
+	schedule_bio_work =3D !(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
+	zwplug->flags |=3D BLK_ZONE_WPLUG_PLUGGED;
+
 	disk_zone_wplug_add_bio(disk, zwplug, bio, nr_segs);
+	if (schedule_bio_work)
+		disk_zone_wplug_schedule_bio_work(disk, zwplug);
=20
 	spin_unlock_irqrestore(&zwplug->lock, flags);
=20
