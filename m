Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0018024
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090627; cv=none; b=Yru6GcCMr//hkQh/12X131tS1V2oLJlvlnTBAkOsMC9hyCO4sDeirvZi/RC6ih3Us1jZoa1OaITmgYt60ndCmxsIe2AhoUWtbnLjI8JaIjjW5O8tn/bLb3WuBYZUUZ5WgcFarqBy/EONbjPO9SBPDHrBiwkdIvlbd/MGkgwFOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090627; c=relaxed/simple;
	bh=+alqnPC3oM3iyAALfFpbzsrHifdwuLhT3x6RnKSB8cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tz+vgomuDupBtbt36fmrPc4mfJzL834LmQYP5arBnZUDkyxzWYAVnXtk3/2JVekuA7KixFK5ucs5VAFid5rQy3pbwqmQZcLLvfzBp/+7I1KCqkawj5wPuxz9n1uQVcEDHGTbg2ZwtHdOL6M8ayBFDE8N4ul+LDrNjz8ZnuwG6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0sFC8FTo; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0sFC8FTo"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4ZxFNb67B8zm0ysq;
	Mon, 12 May 2025 22:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1747090622; x=1749682623; bh=xpbq17nV7SDQSQpvI6imFhfT1OiOxdW6mj/
	BgMdT1rk=; b=0sFC8FToXyxkOAbexbVhrpmnq36/mBu/gdNWUoDqZUAvKfDckfA
	cqszbfBE7Pqrajd6vg88beTi0JtTyALlJggGaWdXTauf2fSeth6ka7bYuX+eILqH
	2aMpj1zi5vSOMhhdeom4yxkIPLFgfzvXxnF/IjZpV8TOHcZjxj4gAkXkskUsH3uC
	JM1h5eiVNXtE32Z+4hSwhROn2MnR42ceTzN/vP1uPRUa8ZdLimFaI6T38DY06xy1
	LRvWlTtduALiKLpht7EFAQykv1ijRqfREax6cIBfHuQx6jN+hQNdmNii9+X2j1B/
	2tP29R83YJR3+6eiRcdTVKXhXX8WUFcdt8Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id u4n_4d_qMxQG; Mon, 12 May 2025 22:57:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4ZxFNV3vHzzm0yTN;
	Mon, 12 May 2025 22:56:57 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: Split bios in LBA order
Date: Mon, 12 May 2025 15:56:23 -0700
Message-ID: <20250512225623.243507-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The block layer submits bio fragments in opposite LBA order. Fix this as
follows:
- Introduce a new function bio_split_to_limits_and_submit() that has the
  same behavior as the existing bio_split_to_limits() function. This
  involves splitting a bio and submitting the fragment with the highest
  LBA by calling submit_bio_noacct().
- Use the new function bio_split_to_limits_and_submit() in all drivers
  that are fine with submitting split bios in opposite LBA order.
- Modify bio_split_to_limits() such that it returns two bio pointers
  instead of submitting one of the two bio fragments in case a bio has
  been split.
- Modify blk_mq_submit_bio() and dm_split_and_process_bio() such that
  bio fragments are submitted in LBA order.

This patch fixes unaligned write errors that I encountered with F2FS
submitting zoned writes to a dm driver stacked on top of a zoned UFS
device.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c             | 81 +++++++++++++++++++++++++----------
 block/blk-mq.c                | 27 ++++++++----
 block/blk.h                   | 26 ++++++-----
 drivers/block/drbd/drbd_req.c |  2 +-
 drivers/block/pktcdvd.c       |  2 +-
 drivers/md/dm.c               | 14 ++++--
 drivers/md/md.c               |  2 +-
 drivers/nvme/host/multipath.c |  2 +-
 include/linux/blkdev.h        |  3 +-
 9 files changed, 108 insertions(+), 51 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 782308b73b53..1076e5e1fa9c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -105,8 +105,15 @@ static unsigned int bio_allowed_max_sectors(const st=
ruct queue_limits *lim)
 	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
 }
=20
-static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
+/*
+ * Split a bio and prepare the bio that has been split off for submissio=
n.
+ * Returns %NULL upon error or the prefix bio upon success and stores a =
pointer
+ * to the suffix in *@bio_ptr.
+ */
+static struct bio *bio_submit_split(struct bio **bio_ptr, int split_sect=
ors)
 {
+	struct bio *bio =3D *bio_ptr;
+
 	if (unlikely(split_sectors < 0))
 		goto error;
=20
@@ -124,8 +131,9 @@ static struct bio *bio_submit_split(struct bio *bio, =
int split_sectors)
 		bio_chain(split, bio);
 		trace_block_split(split, bio->bi_iter.bi_sector);
 		WARN_ON_ONCE(bio_zone_write_plugging(bio));
-		submit_bio_noacct(bio);
 		return split;
+	} else {
+		*bio_ptr =3D NULL;
 	}
=20
 	return bio;
@@ -135,7 +143,7 @@ static struct bio *bio_submit_split(struct bio *bio, =
int split_sectors)
 	return NULL;
 }
=20
-struct bio *bio_split_discard(struct bio *bio, const struct queue_limits=
 *lim,
+struct bio *bio_split_discard(struct bio **bio, const struct queue_limit=
s *lim,
 		unsigned *nsegs)
 {
 	unsigned int max_discard_sectors, granularity;
@@ -149,11 +157,13 @@ struct bio *bio_split_discard(struct bio *bio, cons=
t struct queue_limits *lim,
 	max_discard_sectors =3D
 		min(lim->max_discard_sectors, bio_allowed_max_sectors(lim));
 	max_discard_sectors -=3D max_discard_sectors % granularity;
-	if (unlikely(!max_discard_sectors))
-		return bio;
+	if (unlikely(!max_discard_sectors) ||
+	    bio_sectors(*bio) <=3D max_discard_sectors) {
+		struct bio *orig_bio =3D *bio;
=20
-	if (bio_sectors(bio) <=3D max_discard_sectors)
-		return bio;
+		*bio =3D NULL;
+		return orig_bio;
+	}
=20
 	split_sectors =3D max_discard_sectors;
=20
@@ -161,7 +171,7 @@ struct bio *bio_split_discard(struct bio *bio, const =
struct queue_limits *lim,
 	 * If the next starting sector would be misaligned, stop the discard at
 	 * the previous aligned sector.
 	 */
-	tmp =3D bio->bi_iter.bi_sector + split_sectors -
+	tmp =3D (*bio)->bi_iter.bi_sector + split_sectors -
 		((lim->discard_alignment >> 9) % granularity);
 	tmp =3D sector_div(tmp, granularity);
=20
@@ -374,12 +384,12 @@ int bio_split_rw_at(struct bio *bio, const struct q=
ueue_limits *lim,
 }
 EXPORT_SYMBOL_GPL(bio_split_rw_at);
=20
-struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim=
,
+struct bio *bio_split_rw(struct bio **bio, const struct queue_limits *li=
m,
 		unsigned *nr_segs)
 {
 	return bio_submit_split(bio,
-		bio_split_rw_at(bio, lim, nr_segs,
-			get_max_io_size(bio, lim) << SECTOR_SHIFT));
+		bio_split_rw_at(*bio, lim, nr_segs,
+			get_max_io_size(*bio, lim) << SECTOR_SHIFT));
 }
=20
 /*
@@ -389,22 +399,22 @@ struct bio *bio_split_rw(struct bio *bio, const str=
uct queue_limits *lim,
  * a good sanity check that the submitter built the bio correctly is nic=
e to
  * have as well.
  */
-struct bio *bio_split_zone_append(struct bio *bio,
+struct bio *bio_split_zone_append(struct bio **bio,
 		const struct queue_limits *lim, unsigned *nr_segs)
 {
 	int split_sectors;
=20
-	split_sectors =3D bio_split_rw_at(bio, lim, nr_segs,
+	split_sectors =3D bio_split_rw_at(*bio, lim, nr_segs,
 			lim->max_zone_append_sectors << SECTOR_SHIFT);
 	if (WARN_ON_ONCE(split_sectors > 0))
 		split_sectors =3D -EINVAL;
 	return bio_submit_split(bio, split_sectors);
 }
=20
-struct bio *bio_split_write_zeroes(struct bio *bio,
+struct bio *bio_split_write_zeroes(struct bio **bio,
 		const struct queue_limits *lim, unsigned *nsegs)
 {
-	unsigned int max_sectors =3D get_max_io_size(bio, lim);
+	unsigned int max_sectors =3D get_max_io_size(*bio, lim);
=20
 	*nsegs =3D 0;
=20
@@ -414,15 +424,38 @@ struct bio *bio_split_write_zeroes(struct bio *bio,
 	 * I/O completion handler, and we can race and see this.  Splitting to =
a
 	 * zero limit obviously doesn't make sense, so band-aid it here.
 	 */
-	if (!max_sectors)
-		return bio;
-	if (bio_sectors(bio) <=3D max_sectors)
-		return bio;
+	if (!max_sectors || bio_sectors(*bio) <=3D max_sectors) {
+		struct bio *orig_bio =3D *bio;
+
+		*bio =3D NULL;
+		return orig_bio;
+	}
 	return bio_submit_split(bio, max_sectors);
 }
=20
 /**
  * bio_split_to_limits - split a bio to fit the queue limits
+ * @bio:     pointer to the bio to be split
+ *
+ * Check if *@bio needs splitting based on the queue limits of (*@bio)->=
bi_bdev,
+ * and if so split off a bio fitting the limits from the beginning of *@=
bio and
+ * return it.  *@bio is shortened to the remainder if the bio has been s=
plit.
+ * *@bio is cleared if splitting is not required.
+ *
+ * The split bio is allocated from @q->bio_split, which is provided by t=
he
+ * block layer.
+ */
+struct bio *bio_split_to_limits(struct bio **bio)
+{
+	unsigned int nr_segs;
+
+	return __bio_split_to_limits(bio, bdev_limits((*bio)->bi_bdev),
+				     &nr_segs);
+}
+EXPORT_SYMBOL(bio_split_to_limits);
+
+/**
+ * bio_split_to_limits_and_submit - split a bio to fit the queue limits
  * @bio:     bio to be split
  *
  * Check if @bio needs splitting based on the queue limits of @bio->bi_b=
dev, and
@@ -432,13 +465,15 @@ struct bio *bio_split_write_zeroes(struct bio *bio,
  * The split bio is allocated from @q->bio_split, which is provided by t=
he
  * block layer.
  */
-struct bio *bio_split_to_limits(struct bio *bio)
+struct bio *bio_split_to_limits_and_submit(struct bio *bio)
 {
-	unsigned int nr_segs;
+	struct bio *split =3D bio_split_to_limits(&bio);
=20
-	return __bio_split_to_limits(bio, bdev_limits(bio->bi_bdev), &nr_segs);
+	if (split && bio)
+		submit_bio_noacct(bio);
+	return split;
 }
-EXPORT_SYMBOL(bio_split_to_limits);
+EXPORT_SYMBOL(bio_split_to_limits_and_submit);
=20
 unsigned int blk_recalc_rq_segments(struct request *rq)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cbc9a9f97a31..d9a84d0282ae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3122,6 +3122,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct blk_plug *plug =3D current->plug;
 	const int is_sync =3D op_is_sync(bio->bi_opf);
 	struct blk_mq_hw_ctx *hctx;
+	struct bio *remainder =3D NULL;
 	unsigned int nr_segs;
 	struct request *rq;
 	blk_status_t ret;
@@ -3169,18 +3170,19 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
 	}
=20
-	bio =3D __bio_split_to_limits(bio, &q->limits, &nr_segs);
+	remainder =3D bio;
+	bio =3D __bio_split_to_limits(&remainder, &q->limits, &nr_segs);
 	if (!bio)
 		goto queue_exit;
=20
 	if (!bio_integrity_prep(bio))
-		goto queue_exit;
+		goto submit_remainder_and_exit;
=20
 	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
-		goto queue_exit;
+		goto submit_remainder_and_exit;
=20
 	if (blk_queue_is_zoned(q) && blk_zone_plug_bio(bio, nr_segs))
-		goto queue_exit;
+		goto submit_remainder_and_exit;
=20
 new_request:
 	if (rq) {
@@ -3190,7 +3192,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		if (unlikely(!rq)) {
 			if (bio->bi_opf & REQ_NOWAIT)
 				bio_wouldblock_error(bio);
-			goto queue_exit;
+			goto submit_remainder_and_exit;
 		}
 	}
=20
@@ -3205,18 +3207,18 @@ void blk_mq_submit_bio(struct bio *bio)
 		bio->bi_status =3D ret;
 		bio_endio(bio);
 		blk_mq_free_request(rq);
-		return;
+		goto submit_remainder;
 	}
=20
 	if (bio_zone_write_plugging(bio))
 		blk_zone_write_plug_init_request(rq);
=20
 	if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
-		return;
+		goto submit_remainder;
=20
 	if (plug) {
 		blk_add_rq_to_plug(plug, rq);
-		return;
+		goto submit_remainder;
 	}
=20
 	hctx =3D rq->mq_hctx;
@@ -3227,8 +3229,17 @@ void blk_mq_submit_bio(struct bio *bio)
 	} else {
 		blk_mq_run_dispatch_ops(q, blk_mq_try_issue_directly(hctx, rq));
 	}
+
+submit_remainder:
+	if (remainder)
+		submit_bio_noacct(remainder);
+
 	return;
=20
+submit_remainder_and_exit:
+	if (remainder)
+		submit_bio_noacct(remainder);
+
 queue_exit:
 	/*
 	 * Don't drop the queue reference if we were trying to use a cached
diff --git a/block/blk.h b/block/blk.h
index 665b3d1fb504..31fd9a2208a0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -340,13 +340,13 @@ ssize_t part_timeout_show(struct device *, struct d=
evice_attribute *, char *);
 ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
=20
-struct bio *bio_split_discard(struct bio *bio, const struct queue_limits=
 *lim,
+struct bio *bio_split_discard(struct bio **bio, const struct queue_limit=
s *lim,
 		unsigned *nsegs);
-struct bio *bio_split_write_zeroes(struct bio *bio,
+struct bio *bio_split_write_zeroes(struct bio **bio,
 		const struct queue_limits *lim, unsigned *nsegs);
-struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim=
,
+struct bio *bio_split_rw(struct bio **bio, const struct queue_limits *li=
m,
 		unsigned *nr_segs);
-struct bio *bio_split_zone_append(struct bio *bio,
+struct bio *bio_split_zone_append(struct bio **bio,
 		const struct queue_limits *lim, unsigned *nr_segs);
=20
 /*
@@ -370,27 +370,30 @@ static inline bool bio_may_need_split(struct bio *b=
io,
=20
 /**
  * __bio_split_to_limits - split a bio to fit the queue limits
- * @bio:     bio to be split
+ * @bio:     pointer to the bio to be split
  * @lim:     queue limits to split based on
  * @nr_segs: returns the number of segments in the returned bio
  *
  * Check if @bio needs splitting based on the queue limits, and if so sp=
lit off
  * a bio fitting the limits from the beginning of @bio and return it.  @=
bio is
- * shortened to the remainder and re-submitted.
+ * shortened to the remainder and stored in *@bio.
  *
  * The split bio is allocated from @q->bio_split, which is provided by t=
he
  * block layer.
  */
-static inline struct bio *__bio_split_to_limits(struct bio *bio,
+static inline struct bio *__bio_split_to_limits(struct bio **bio,
 		const struct queue_limits *lim, unsigned int *nr_segs)
 {
-	switch (bio_op(bio)) {
+	struct bio *orig_bio =3D *bio;
+
+	switch (bio_op(*bio)) {
 	case REQ_OP_READ:
 	case REQ_OP_WRITE:
-		if (bio_may_need_split(bio, lim))
+		if (bio_may_need_split(*bio, lim))
 			return bio_split_rw(bio, lim, nr_segs);
 		*nr_segs =3D 1;
-		return bio;
+		*bio =3D NULL;
+		return orig_bio;
 	case REQ_OP_ZONE_APPEND:
 		return bio_split_zone_append(bio, lim, nr_segs);
 	case REQ_OP_DISCARD:
@@ -401,7 +404,8 @@ static inline struct bio *__bio_split_to_limits(struc=
t bio *bio,
 	default:
 		/* other operations can't be split */
 		*nr_segs =3D 0;
-		return bio;
+		*bio =3D NULL;
+		return orig_bio;
 	}
 }
=20
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.=
c
index 380e6584a4ee..1076fa616a25 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1612,7 +1612,7 @@ void drbd_submit_bio(struct bio *bio)
 {
 	struct drbd_device *device =3D bio->bi_bdev->bd_disk->private_data;
=20
-	bio =3D bio_split_to_limits(bio);
+	bio =3D bio_split_to_limits_and_submit(bio);
 	if (!bio)
 		return;
=20
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index d5cc7bd2875c..e165ce11dce2 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2431,7 +2431,7 @@ static void pkt_submit_bio(struct bio *bio)
 	struct device *ddev =3D disk_to_dev(pd->disk);
 	struct bio *split;
=20
-	bio =3D bio_split_to_limits(bio);
+	bio =3D bio_split_to_limits_and_submit(bio);
 	if (!bio)
 		return;
=20
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5ab7574c0c76..2974e95f671a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1939,6 +1939,7 @@ static blk_status_t __send_zone_reset_all(struct cl=
one_info *ci)
 static void dm_split_and_process_bio(struct mapped_device *md,
 				     struct dm_table *map, struct bio *bio)
 {
+	struct bio *remainder =3D NULL;
 	struct clone_info ci;
 	struct dm_io *io;
 	blk_status_t error =3D BLK_STS_OK;
@@ -1961,7 +1962,8 @@ static void dm_split_and_process_bio(struct mapped_=
device *md,
 		 * emulation to ensure that the BIO does not cross zone
 		 * boundaries.
 		 */
-		bio =3D bio_split_to_limits(bio);
+		remainder =3D bio;
+		bio =3D bio_split_to_limits(&remainder);
 		if (!bio)
 			return;
 	}
@@ -1971,7 +1973,7 @@ static void dm_split_and_process_bio(struct mapped_=
device *md,
 	 * need zone append emulation (e.g. dm-crypt).
 	 */
 	if (static_branch_unlikely(&zoned_enabled) && dm_zone_plug_bio(md, bio)=
)
-		return;
+		goto submit_remainder;
=20
 	/* Only support nowait for normal IO */
 	if (unlikely(bio->bi_opf & REQ_NOWAIT) && !is_abnormal) {
@@ -1982,13 +1984,13 @@ static void dm_split_and_process_bio(struct mappe=
d_device *md,
 		 */
 		if (bio->bi_opf & REQ_PREFLUSH) {
 			bio_wouldblock_error(bio);
-			return;
+			goto submit_remainder;
 		}
 		io =3D alloc_io(md, bio, GFP_NOWAIT);
 		if (unlikely(!io)) {
 			/* Unable to do anything without dm_io. */
 			bio_wouldblock_error(bio);
-			return;
+			goto submit_remainder;
 		}
 	} else {
 		io =3D alloc_io(md, bio, GFP_NOIO);
@@ -2036,6 +2038,10 @@ static void dm_split_and_process_bio(struct mapped=
_device *md,
 		dm_io_dec_pending(io, error);
 	} else
 		dm_queue_poll_io(bio, io);
+
+submit_remainder:
+	if (remainder)
+		submit_bio_noacct(remainder);
 }
=20
 static void dm_submit_bio(struct bio *bio)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9daa78c5fe33..40c20398a9cc 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -418,7 +418,7 @@ static void md_submit_bio(struct bio *bio)
 		return;
 	}
=20
-	bio =3D bio_split_to_limits(bio);
+	bio =3D bio_split_to_limits_and_submit(bio);
 	if (!bio)
 		return;
=20
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 250f3da67cc9..d84cf3e3f979 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -457,7 +457,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 	 * different queue via blk_steal_bios(), so we need to use the bio_spli=
t
 	 * pool from the original queue to allocate the bvecs from.
 	 */
-	bio =3D bio_split_to_limits(bio);
+	bio =3D bio_split_to_limits_and_submit(bio);
 	if (!bio)
 		return;
=20
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6ebd8e7f3ac9..1d8267f389bb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -934,7 +934,8 @@ void blk_request_module(dev_t devt);
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 void submit_bio_noacct(struct bio *bio);
-struct bio *bio_split_to_limits(struct bio *bio);
+struct bio *bio_split_to_limits(struct bio **bio);
+struct bio *bio_split_to_limits_and_submit(struct bio *bio);
=20
 extern int blk_lld_busy(struct request_queue *q);
 extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t f=
lags);
