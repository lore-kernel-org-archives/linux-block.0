Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60482F3C2C
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903774; cv=none; b=lT0wVr1LBnVwNbPlb1aEDD//sMIC7gKxtB4EkxTKKDDXwNcgOPfndqvkZnk46Ma7zF/LH3QfP6e+nJ9X9u6S7T0ufFIeQeA6xfkQN125FC+vrFE2aE0bCuHG40jiF+67yGr9T4ckS8mMVuRzZvyrvBxlB67LrywLqGFB/KBoIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903774; c=relaxed/simple;
	bh=3V4dudQg0ploo6v3pt91Z3bNgpsClfZ60CLE6JQECxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okK2GiTGQNn5T0yTXVqo87K8m3Lo3Pc0KO2/SESU+XjaoSCz+cu4S8XW8muL6nLNChL5oq5mFhVo7Ip36yfLK6cY1XPB+n74x51qiGJ48dqlxhdN7cG9kSYQasfeNSds+y1TN9fDyxUOqBYaeEc9Rg+rp5wb5TOXpGnz6rymHuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=PFa/A6gI; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="PFa/A6gI"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d5jRc01MJzlgqyc;
	Tue, 11 Nov 2025 23:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1762903770; x=1765495771; bh=VLVRj
	xTJ6hHhsmjX6CUh4tFg4sLVR/rvz5tvBbbTNYk=; b=PFa/A6gIi4KTKj7MEYtsz
	giXJKyCdiYtcjJqV+mh7fNHzFGPptTJpP+Ww/OVHQ5/mH7ndt7LkIHbFVxPYaKkT
	sp7AYBTeR7ocSnQG4x0DomvctB6Gp+Ux6QS6qMyfiSqeS2DIcDy5PB/Z239+X3j9
	C3A6peIDXp1GWVYqeZgymvxAx/d6iXtoP57NZkZoBhkD5IrGzqjAYomNqWRpgHwJ
	jDuixrwVN5oT1OyI+FcC9XdkJwgDFMHDfJ9sp7Js24LQJJDHf1duBc+98LZU3Zi2
	Tm7ESf2RxOuRiZLhtaZmWFntTQGvl13R7rrbaKAkTrYERIozIpTM5sFw2y5Vheh1
	A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id h-Z8ifPfA6fY; Tue, 11 Nov 2025 23:29:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d5jRW6LYPzltJQJ;
	Tue, 11 Nov 2025 23:29:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v2 3/3] blk-zoned: Move code from disk_zone_wplug_add_bio() into its caller
Date: Tue, 11 Nov 2025 15:29:02 -0800
Message-ID: <20251111232903.953630-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251111232903.953630-1-bvanassche@acm.org>
References: <20251111232903.953630-1-bvanassche@acm.org>
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
scheduling into a single function. Additionally, the 'schedule_bio_work'
variable is removed. No functionality has been changed.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 5487d5eb2650..85de45c3f6be 100644
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
@@ -1461,14 +1444,17 @@ static bool blk_zone_wplug_handle_write(struct bi=
o *bio, unsigned int nr_segs)
 	bio_set_flag(bio, BIO_ZONE_WRITE_PLUGGING);
=20
 	/*
-	 * If the zone is already plugged, add the BIO to the plug BIO list.
-	 * Do the same for REQ_NOWAIT BIOs to ensure that we will not see a
-	 * BLK_STS_AGAIN failure if we let the BIO execute.
-	 * Otherwise, plug and let the BIO execute.
+	 * Add REQ_NOWAIT BIOs to the plug list to ensure that we will not see =
a
+	 * BLK_STS_AGAIN failure if we let the caller submit the BIO.
 	 */
-	if ((zwplug->flags & BLK_ZONE_WPLUG_PLUGGED) ||
-	    (bio->bi_opf & REQ_NOWAIT))
-		goto plug;
+	if (bio->bi_opf & REQ_NOWAIT) {
+		bio->bi_opf &=3D ~REQ_NOWAIT;
+		goto queue_bio;
+	}
+
+	/* If the zone is already plugged, add the BIO to the BIO plug list. */
+	if (zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)
+		goto queue_bio;
=20
 	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
 		spin_unlock_irqrestore(&zwplug->lock, flags);
@@ -1476,15 +1462,21 @@ static bool blk_zone_wplug_handle_write(struct bi=
o *bio, unsigned int nr_segs)
 		return true;
 	}
=20
+	/* Otherwise, plug and let the caller submit the BIO. */
 	zwplug->flags |=3D BLK_ZONE_WPLUG_PLUGGED;
=20
 	spin_unlock_irqrestore(&zwplug->lock, flags);
=20
 	return false;
=20
-plug:
+queue_bio:
 	disk_zone_wplug_add_bio(disk, zwplug, bio, nr_segs);
=20
+	if (!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)) {
+		zwplug->flags |=3D BLK_ZONE_WPLUG_PLUGGED;
+		disk_zone_wplug_schedule_bio_work(disk, zwplug);
+	}
+
 	spin_unlock_irqrestore(&zwplug->lock, flags);
=20
 	return true;
