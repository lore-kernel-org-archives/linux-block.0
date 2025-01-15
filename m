Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A2F1DD0D4
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981252; cv=none; b=dPiTCxP7x5pdZel0u+xMhB5hv4JWnmMQuiyiWZkShTQGBVZfqZvZOqfSzBvroABC1gnFSXm698jifMuRTgSxf0qpM294iNtZfQjZcqSxMFzMYtQhpiJXD9wU4wAk1Ez0tNibu7Dd8Q1IcccIsRCTq1hljuBWlZCbbrRWzVoCDz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981252; c=relaxed/simple;
	bh=yHLB3KS794JLyokOem9w2y29sfhYl32BIlUOJByo6SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1qwv+RtP9+GYPSvFwfXvoRlrreM90Cbv71hqw/vdNKR5PIg1FdfK6Lqv8/cEkKa+QhznOh5afthvQT+RmVQGLSpr+6eFQBpoDKQX2fjAn8Q+MauoPspwkIXIAat8fsO8kwfcFKkke8J6ZsT390+RmmEpMgQ9zdBC9nzCZTIIAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=eCIDmn8i; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="eCIDmn8i"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYLjY2fffz6CmR5y;
	Wed, 15 Jan 2025 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1736981237; x=1739573238; bh=I7tm7
	aBMqvJ4y5BsfXNcLUhLrB8MeK6wOh6IMODi7hQ=; b=eCIDmn8iBJkcD3AAWBQSH
	wRSo27kiICG+f+LIbZVfZbBGpQA6BNTjMAC8LAZdAgBCKv7b9eQMaQQ9z8mNqOfz
	3oT61kTvjZ1RSV8kAzLUO5DqceZZeNzSCAHuLVEMkpjfDrFtT9FgOcIunLnSIDf7
	By8YLGNvFYJr5e3d+2aC80rMJ+t50FZ0dbMxe6wgrn4iQsTduqwM/cQuMb3/d2SW
	VGH269DWiTiS6bB+cSsPS60DCjkDvaDYbyAkFWP0WTAtrAYPhk/SFN+2av6is4W1
	RJC32DyK3qwA7owPfBcMc8txnPfeQdZMApXN6+D4sSTzixc6mmhsxc1j4/sW4VaN
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ijsXzPVsB0MS; Wed, 15 Jan 2025 22:47:17 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYLjH27G4z6CmQvG;
	Wed, 15 Jan 2025 22:47:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v17 07/14] blk-zoned: Defer error handling
Date: Wed, 15 Jan 2025 14:46:41 -0800
Message-ID: <20250115224649.3973718-8-bvanassche@acm.org>
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

Only handle errors after pending zoned writes have completed or have been
requeued instead of handling write errors immediately. This patch prepare=
s
for implementing write pipelining support. If the e.g. the SCSI error
handler is activated while multiple requests are queued, all requests mus=
t
have completed or failed before any requests are resubmitted.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         |   9 ++
 block/blk-zoned.c      | 279 ++++++++++++++++++++++++++++++++++++++---
 block/blk.h            |  27 ++++
 include/linux/blkdev.h |   4 +-
 4 files changed, 302 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 01478777ae5f..ca34ec34d595 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -799,6 +799,9 @@ void blk_mq_free_request(struct request *rq)
 	rq_qos_done(q, rq);
=20
 	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
+
+	blk_zone_free_request(rq);
+
 	if (req_ref_put_and_test(rq))
 		__blk_mq_free_request(rq);
 }
@@ -1195,6 +1198,9 @@ void blk_mq_end_request_batch(struct io_comp_batch =
*iob)
 			continue;
=20
 		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
+
+		blk_zone_free_request(rq);
+
 		if (!req_ref_put_and_test(rq))
 			continue;
=20
@@ -1513,6 +1519,7 @@ static void __blk_mq_requeue_request(struct request=
 *rq)
 	if (blk_mq_request_started(rq)) {
 		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 		rq->rq_flags &=3D ~RQF_TIMED_OUT;
+		blk_zone_requeue_work(q);
 	}
 }
=20
@@ -1548,6 +1555,8 @@ static void blk_mq_requeue_work(struct work_struct =
*work)
 	list_splice_init(&q->flush_list, &flush_list);
 	spin_unlock_irq(&q->requeue_lock);
=20
+	blk_zone_requeue_work(q);
+
 	while (!list_empty(&rq_list)) {
 		rq =3D list_entry(rq_list.next, struct request, queuelist);
 		list_del_init(&rq->queuelist);
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 089c6740df4a..cc09ae84acc8 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2016, Damien Le Moal
  * Copyright (c) 2016, Western Digital
  * Copyright (c) 2024, Western Digital Corporation or its affiliates.
+ * Copyright 2024 Google LLC
  */
=20
 #include <linux/kernel.h>
@@ -37,6 +38,7 @@ static const char *const zone_cond_name[] =3D {
 /*
  * Per-zone write plug.
  * @node: hlist_node structure for managing the plug using a hash table.
+ * @link: To list the plug in the zone write plug error list of the disk=
.
  * @ref: Zone write plug reference counter. A zone write plug reference =
is
  *       always at least 1 when the plug is hashed in the disk plug hash=
 table.
  *       The reference is incremented whenever a new BIO needing pluggin=
g is
@@ -60,6 +62,7 @@ static const char *const zone_cond_name[] =3D {
  */
 struct blk_zone_wplug {
 	struct hlist_node	node;
+	struct list_head	link;
 	refcount_t		ref;
 	spinlock_t		lock;
 	unsigned int		flags;
@@ -86,10 +89,16 @@ struct blk_zone_wplug {
  *    to prevent new references to the zone write plug to be taken for
  *    newly incoming BIOs. A zone write plug flagged with this flag will=
 be
  *    freed once all remaining references from BIOs or functions are dro=
pped.
+ *  - BLK_ZONE_WPLUG_ERROR: Indicates that a write error happened. Recov=
ery
+ *    from the write error will happen after all pending zoned write req=
uests
+ *    either have been requeued or have been completed.
  */
 #define BLK_ZONE_WPLUG_PLUGGED		(1U << 0)
 #define BLK_ZONE_WPLUG_NEED_WP_UPDATE	(1U << 1)
 #define BLK_ZONE_WPLUG_UNHASHED		(1U << 2)
+#define BLK_ZONE_WPLUG_ERROR		(1U << 3)
+
+#define BLK_ZONE_WPLUG_BUSY	(BLK_ZONE_WPLUG_PLUGGED | BLK_ZONE_WPLUG_ERR=
OR)
=20
 /**
  * blk_zone_cond_str - Return string XXX in BLK_ZONE_COND_XXX.
@@ -468,8 +477,8 @@ static inline bool disk_should_remove_zone_wplug(stru=
ct gendisk *disk,
 	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
 		return false;
=20
-	/* If the zone write plug is still plugged, it cannot be removed. */
-	if (zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)
+	/* If the zone write plug is still busy, it cannot be removed. */
+	if (zwplug->flags & BLK_ZONE_WPLUG_BUSY)
 		return false;
=20
 	/*
@@ -552,6 +561,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_=
wplug(struct gendisk *disk,
 		return NULL;
=20
 	INIT_HLIST_NODE(&zwplug->node);
+	INIT_LIST_HEAD(&zwplug->link);
 	refcount_set(&zwplug->ref, 2);
 	spin_lock_init(&zwplug->lock);
 	zwplug->flags =3D 0;
@@ -601,6 +611,49 @@ static void disk_zone_wplug_abort(struct blk_zone_wp=
lug *zwplug)
 		blk_zone_wplug_bio_io_error(zwplug, bio);
 }
=20
+static void disk_zone_wplug_set_error(struct gendisk *disk,
+				      struct blk_zone_wplug *zwplug)
+{
+	lockdep_assert_held(&zwplug->lock);
+
+	if (zwplug->flags & BLK_ZONE_WPLUG_ERROR)
+		return;
+
+	zwplug->flags |=3D BLK_ZONE_WPLUG_PLUGGED;
+	zwplug->flags |=3D BLK_ZONE_WPLUG_ERROR;
+	/*
+	 * Increase the zwplug reference count because BLK_ZONE_WPLUG_ERROR has
+	 * been set. This reference will be dropped when BLK_ZONE_WPLUG_ERROR i=
s
+	 * cleared.
+	 */
+	refcount_inc(&zwplug->ref);
+
+	scoped_guard(spinlock_irqsave, &disk->zone_wplugs_lock)
+		list_add_tail(&zwplug->link, &disk->zone_wplugs_err_list);
+}
+
+static void disk_zone_wplug_clear_error(struct gendisk *disk,
+					struct blk_zone_wplug *zwplug)
+{
+	if (!(READ_ONCE(zwplug->flags) & BLK_ZONE_WPLUG_ERROR))
+		return;
+
+	/*
+	 * We are racing with the error handling work which drops the reference
+	 * on the zone write plug after handling the error state. So remove the
+	 * plug from the error list and drop its reference count only if the
+	 * error handling has not yet started, that is, if the zone write plug
+	 * is still listed.
+	 */
+	scoped_guard(spinlock_irqsave, &disk->zone_wplugs_lock) {
+		if (list_empty(&zwplug->link))
+			return;
+		list_del_init(&zwplug->link);
+		zwplug->flags &=3D ~BLK_ZONE_WPLUG_ERROR;
+	}
+	disk_put_zone_wplug(zwplug);
+}
+
 /*
  * Set a zone write plug write pointer offset to the specified value.
  * This aborts all plugged BIOs, which is fine as this function is calle=
d for
@@ -619,6 +672,13 @@ static void disk_zone_wplug_set_wp_offset(struct gen=
disk *disk,
 	zwplug->wp_offset_compl =3D zwplug->wp_offset;
 	disk_zone_wplug_abort(zwplug);
=20
+	/*
+	 * Updating the write pointer offset puts back the zone
+	 * in a good state. So clear the error flag and decrement the
+	 * error count if we were in error state.
+	 */
+	disk_zone_wplug_clear_error(disk, zwplug);
+
 	/*
 	 * The zone write plug now has no BIO plugged: remove it from the
 	 * hash table so that it cannot be seen. The plug will be freed
@@ -747,6 +807,70 @@ static bool blk_zone_wplug_handle_reset_all(struct b=
io *bio)
 	return false;
 }
=20
+struct all_zwr_inserted_data {
+	struct blk_zone_wplug *zwplug;
+	bool res;
+};
+
+/*
+ * Changes @data->res to %false if and only if @rq is a zoned write for =
the
+ * given zone and if it is owned by the block driver.
+ *
+ * @rq members may change while this function is in progress. Hence, use
+ * READ_ONCE() to read @rq members.
+ */
+static bool blk_zwr_inserted(struct request *rq, void *data)
+{
+	struct all_zwr_inserted_data *d =3D data;
+	struct blk_zone_wplug *zwplug =3D d->zwplug;
+	struct request_queue *q =3D zwplug->disk->queue;
+	struct bio *bio =3D READ_ONCE(rq->bio);
+
+	if (rq->q =3D=3D q && READ_ONCE(rq->state) !=3D MQ_RQ_IDLE &&
+	    blk_rq_is_seq_zoned_write(rq) && bio &&
+	    bio_zone_no(bio) =3D=3D zwplug->zone_no) {
+		d->res =3D false;
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Report whether or not all zoned writes for a zone have been inserted =
into a
+ * software queue, elevator queue or hardware queue.
+ */
+static bool blk_zone_all_zwr_inserted(struct blk_zone_wplug *zwplug)
+{
+	struct gendisk *disk =3D zwplug->disk;
+	struct request_queue *q =3D disk->queue;
+	struct all_zwr_inserted_data d =3D { .zwplug =3D zwplug, .res =3D true =
};
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+	struct request *rq;
+
+	scoped_guard(spinlock_irqsave, &q->requeue_lock) {
+		list_for_each_entry(rq, &q->requeue_list, queuelist)
+			if (blk_rq_is_seq_zoned_write(rq) &&
+			    bio_zone_no(rq->bio) =3D=3D zwplug->zone_no)
+				return false;
+		list_for_each_entry(rq, &q->flush_list, queuelist)
+			if (blk_rq_is_seq_zoned_write(rq) &&
+			    bio_zone_no(rq->bio) =3D=3D zwplug->zone_no)
+				return false;
+	}
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		struct blk_mq_tags *tags =3D hctx->sched_tags ?: hctx->tags;
+
+		blk_mq_all_tag_iter(tags, blk_zwr_inserted, &d);
+		if (!d.res || blk_mq_is_shared_tags(q->tag_set->flags))
+			break;
+	}
+
+	return d.res;
+}
+
 static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
 					      struct blk_zone_wplug *zwplug)
 {
@@ -953,14 +1077,6 @@ static bool blk_zone_wplug_prepare_bio(struct blk_z=
one_wplug *zwplug,
 		 * so that we can restore its operation code on completion.
 		 */
 		bio_set_flag(bio, BIO_EMULATES_ZONE_APPEND);
-	} else {
-		/*
-		 * Check for non-sequential writes early as we know that BIOs
-		 * with a start sector not unaligned to the zone write pointer
-		 * will fail.
-		 */
-		if (bio_offset_from_zone_start(bio) !=3D zwplug->wp_offset)
-			return false;
 	}
=20
 	/* Advance the zone write pointer offset. */
@@ -1021,7 +1137,7 @@ static bool blk_zone_wplug_handle_write(struct bio =
*bio, unsigned int nr_segs)
 	 * BLK_STS_AGAIN failure if we let the BIO execute.
 	 * Otherwise, plug and let the BIO execute.
 	 */
-	if ((zwplug->flags & BLK_ZONE_WPLUG_PLUGGED) ||
+	if ((zwplug->flags & BLK_ZONE_WPLUG_BUSY) ||
 	    (bio->bi_opf & REQ_NOWAIT))
 		goto plug;
=20
@@ -1122,6 +1238,29 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned i=
nt nr_segs)
 }
 EXPORT_SYMBOL_GPL(blk_zone_plug_bio);
=20
+/*
+ * Change the zone state to "error" if a zoned write request is requeued=
 to
+ * postpone processing of requeued requests until all pending requests h=
ave
+ * either completed or have been requeued.
+ */
+void blk_zone_write_plug_requeue_request(struct request *rq)
+{
+	struct gendisk *disk =3D rq->q->disk;
+	struct blk_zone_wplug *zwplug;
+
+	if (!blk_rq_is_seq_zoned_write(rq))
+		return;
+
+	zwplug =3D disk_get_zone_wplug(disk, blk_rq_pos(rq));
+	if (WARN_ON_ONCE(!zwplug))
+		return;
+
+	scoped_guard(spinlock_irqsave, &zwplug->lock)
+		disk_zone_wplug_set_error(disk, zwplug);
+
+	disk_put_zone_wplug(zwplug);
+}
+
 static void disk_zone_wplug_unplug_bio(struct gendisk *disk,
 				       struct blk_zone_wplug *zwplug)
 {
@@ -1187,11 +1326,14 @@ void blk_zone_write_plug_bio_endio(struct bio *bi=
o)
 	} else {
 		/*
 		 * If the BIO failed, mark the plug as having an error to
-		 * trigger recovery.
+		 * trigger recovery. Since we cannot rely the completion
+		 * information for torn SAS SMR writes, set
+		 * BLK_ZONE_WPLUG_NEED_WP_UPDATE for these devices.
 		 */
 		spin_lock_irqsave(&zwplug->lock, flags);
-		disk_zone_wplug_abort(zwplug);
-		zwplug->flags |=3D BLK_ZONE_WPLUG_NEED_WP_UPDATE;
+		if (!disk->queue->limits.driver_preserves_write_order)
+			zwplug->flags |=3D BLK_ZONE_WPLUG_NEED_WP_UPDATE;
+		zwplug->flags |=3D BLK_ZONE_WPLUG_ERROR;
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 	}
=20
@@ -1233,6 +1375,25 @@ void blk_zone_write_plug_finish_request(struct req=
uest *req)
 	disk_put_zone_wplug(zwplug);
 }
=20
+/*
+ * Schedule zone_plugs_work if a zone is in the error state and if no re=
quests
+ * are in flight. Called from blk_mq_free_request().
+ */
+void blk_zone_write_plug_free_request(struct request *rq)
+{
+	struct gendisk *disk =3D rq->q->disk;
+	struct blk_zone_wplug *zwplug;
+
+	zwplug =3D disk_get_zone_wplug(disk, blk_rq_pos(rq));
+	if (!zwplug)
+		return;
+
+	if (READ_ONCE(zwplug->flags) & BLK_ZONE_WPLUG_ERROR)
+		kblockd_schedule_work(&disk->zone_wplugs_work);
+
+	disk_put_zone_wplug(zwplug);
+}
+
 static void blk_zone_wplug_bio_work(struct work_struct *work)
 {
 	struct blk_zone_wplug *zwplug =3D
@@ -1279,6 +1440,88 @@ static void blk_zone_wplug_bio_work(struct work_st=
ruct *work)
 	disk_put_zone_wplug(zwplug);
 }
=20
+static void disk_zone_wplug_handle_error(struct gendisk *disk,
+					 struct blk_zone_wplug *zwplug)
+{
+	scoped_guard(spinlock_irqsave, &zwplug->lock) {
+		/*
+		 * A zone reset or finish may have cleared the error
+		 * already. In such case, do nothing as the report zones may
+		 * have seen the "old" write pointer value before the
+		 * reset/finish operation completed.
+		 */
+		if (!(zwplug->flags & BLK_ZONE_WPLUG_ERROR))
+			return;
+
+		zwplug->flags &=3D ~BLK_ZONE_WPLUG_ERROR;
+
+		/* Update the zone write pointer offset. */
+		zwplug->wp_offset =3D zwplug->wp_offset_compl;
+
+		/* Restart BIO submission if we still have any BIO left. */
+		if (!bio_list_empty(&zwplug->bio_list)) {
+			disk_zone_wplug_schedule_bio_work(disk, zwplug);
+		} else {
+			zwplug->flags &=3D ~BLK_ZONE_WPLUG_PLUGGED;
+			if (disk_should_remove_zone_wplug(disk, zwplug))
+				disk_remove_zone_wplug(disk, zwplug);
+		}
+	}
+
+	disk_put_zone_wplug(zwplug);
+}
+
+static void disk_zone_process_err_list(struct gendisk *disk)
+{
+	struct blk_zone_wplug *zwplug, *next;
+	unsigned long flags;
+
+	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
+
+	list_for_each_entry_safe(zwplug, next, &disk->zone_wplugs_err_list,
+				 link) {
+		if (!blk_zone_all_zwr_inserted(zwplug))
+			continue;
+		list_del_init(&zwplug->link);
+		spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
+
+		disk_zone_wplug_handle_error(disk, zwplug);
+		disk_put_zone_wplug(zwplug);
+
+		spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
+	}
+
+	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
+
+	/*
+	 * If one or more zones have been skipped, this work will be requeued
+	 * when a request is requeued (blk_zone_requeue_work()) or freed
+	 * (blk_zone_write_plug_free_request()).
+	 */
+}
+
+static void disk_zone_wplugs_work(struct work_struct *work)
+{
+	struct gendisk *disk =3D
+		container_of(work, struct gendisk, zone_wplugs_work);
+
+	disk_zone_process_err_list(disk);
+}
+
+/* May be called from interrupt context. */
+void blk_zone_requeue_work(struct request_queue *q)
+{
+	struct gendisk *disk =3D q->disk;
+
+	if (!disk)
+		return;
+
+	if (in_interrupt())
+		kblockd_schedule_work(&disk->zone_wplugs_work);
+	else
+		disk_zone_process_err_list(disk);
+}
+
 static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *di=
sk)
 {
 	return 1U << disk->zone_wplugs_hash_bits;
@@ -1287,6 +1530,8 @@ static inline unsigned int disk_zone_wplugs_hash_si=
ze(struct gendisk *disk)
 void disk_init_zone_resources(struct gendisk *disk)
 {
 	spin_lock_init(&disk->zone_wplugs_lock);
+	INIT_LIST_HEAD(&disk->zone_wplugs_err_list);
+	INIT_WORK(&disk->zone_wplugs_work, disk_zone_wplugs_work);
 }
=20
 /*
@@ -1805,9 +2050,11 @@ static void queue_zone_wplug_show(struct blk_zone_=
wplug *zwplug,
 	zwp_bio_list_size =3D bio_list_size(&zwplug->bio_list);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
=20
-	seq_printf(m, "zone_no %u flags 0x%x ref %u wp_offset %u wp_offset_comp=
l %u bio_list_size %u\n",
+	bool all_zwr_inserted =3D blk_zone_all_zwr_inserted(zwplug);
+
+	seq_printf(m, "zone_no %u flags 0x%x ref %u wp_offset %u bio_list_size =
%u all_zwr_inserted %d\n",
 		   zwp_zone_no, zwp_flags, zwp_ref, zwp_wp_offset,
-		   zwp_wp_offset_compl, zwp_bio_list_size);
+		   zwp_bio_list_size, all_zwr_inserted);
 }
=20
 int queue_zone_wplugs_show(void *data, struct seq_file *m)
diff --git a/block/blk.h b/block/blk.h
index 2274253cfa58..98954fb0069f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -475,6 +475,16 @@ static inline void blk_zone_update_request_bio(struc=
t request *rq,
 		bio->bi_iter.bi_size =3D rq->__data_len;
 	}
 }
+
+void blk_zone_write_plug_requeue_request(struct request *rq);
+static inline void blk_zone_requeue_request(struct request *rq)
+{
+	if (blk_rq_is_seq_zoned_write(rq))
+		blk_zone_write_plug_requeue_request(rq);
+}
+
+void blk_zone_requeue_work(struct request_queue *q);
+
 void blk_zone_write_plug_bio_endio(struct bio *bio);
 static inline void blk_zone_bio_endio(struct bio *bio)
 {
@@ -492,6 +502,14 @@ static inline void blk_zone_finish_request(struct re=
quest *rq)
 	if (rq->rq_flags & RQF_ZONE_WRITE_PLUGGING)
 		blk_zone_write_plug_finish_request(rq);
 }
+
+void blk_zone_write_plug_free_request(struct request *rq);
+static inline void blk_zone_free_request(struct request *rq)
+{
+	if (blk_rq_is_seq_zoned_write(rq))
+		blk_zone_write_plug_free_request(rq);
+}
+
 int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cm=
d,
 		unsigned long arg);
 int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
@@ -517,12 +535,21 @@ static inline void blk_zone_update_request_bio(stru=
ct request *rq,
 					       struct bio *bio)
 {
 }
+static inline void blk_zone_requeue_request(struct request *rq)
+{
+}
+static inline void blk_zone_requeue_work(struct request_queue *q)
+{
+}
 static inline void blk_zone_bio_endio(struct bio *bio)
 {
 }
 static inline void blk_zone_finish_request(struct request *rq)
 {
 }
+static inline void blk_zone_free_request(struct request *rq)
+{
+}
 static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
 		unsigned int cmd, unsigned long arg)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index df9887412a9e..fcea07b4062e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -199,7 +199,9 @@ struct gendisk {
 	unsigned int            zone_wplugs_hash_bits;
 	spinlock_t              zone_wplugs_lock;
 	struct mempool_s	*zone_wplugs_pool;
-	struct hlist_head       *zone_wplugs_hash;
+	struct hlist_head	*zone_wplugs_hash;
+	struct list_head	zone_wplugs_err_list;
+	struct work_struct	zone_wplugs_work;
 	struct workqueue_struct *zone_wplugs_wq;
 #endif /* CONFIG_BLK_DEV_ZONED */
=20
