Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A8D1DD0F8
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981250; cv=none; b=CR+AG/XkzKXAWpEjAOxIU9r8TET7gKjfJxLte5sq8PudLveBw1anTM2ZtDY3y7gaJo7AVL0P96eaAAJVINXGm3Ikap5VyOydfbWp2NyaUhuQfyfyTNXkaAyfC688xBcRfW9QTurc5K9Zds6WEXMhzyZ7ooNkZJ4m5Mp4kw5kqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981250; c=relaxed/simple;
	bh=Y3sA9anukKPVn9fAcJQFNJ5W5bJcLwTQJ8Nxv2IROpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chPYQ4LimSrnEySiVdAoYdZMSq+qbxPG74+QRv2Ywbte8ZOuZ7/qagKZ5b7lLsLjFg4kbnV55IGbZSQC655sjy6xinsft8dBplDj0/8RyXja0vueFFXTOC+cVeo+jcofKCuG3zh2obXp7ASAhphdFv18y93URf3tdoJ3bPkr8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OklR/lef; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OklR/lef"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYLjW54BQz6CmM6f;
	Wed, 15 Jan 2025 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1736981241; x=1739573242; bh=K5KXa
	uSteIJJuQf0l8TmDlKKt/2zlxs+y1SoTKJ/GXo=; b=OklR/lefDV9iWICDPy7KE
	hGJUuvy2AJgN5nz+RzqK7e0n5ccFdyk+d3+EmxRCVVQHI0oQvUfOzDT+ldi9BxWU
	r+A49Ba3JaTvllbCcpy2I2NgRuYkLwS7DqcxGysDTBZBKy3OqrP2klztPvKqRuzr
	VuMkV2m4muInXBXjOkpvIpdJEgVo6/qnOq1bwrzbS7PShkWkq7+BIJ31PgVqaGK5
	ol/XTcKmVToHq6FVDAq6jXbqMHBIUcAlAPLb2ol6PhoprL1+FkaQNvRb3B+SQi51
	2rT1stemiLUAEoWd2O231Iqt6UDmvSbgawQqyGSGvkzSPHDLVwJ4J5Ct3us3oM/A
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id B3qqkWu3n_xu; Wed, 15 Jan 2025 22:47:21 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYLjM72f8z6CmQyl;
	Wed, 15 Jan 2025 22:47:19 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v17 09/14] blk-zoned: Support pipelining of zoned writes
Date: Wed, 15 Jan 2025 14:46:43 -0800
Message-ID: <20250115224649.3973718-10-bvanassche@acm.org>
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

Support pipelining of zoned writes if the block driver preserves the writ=
e
order per hardware queue. Track per zone to which software queue writes
have been queued. If zoned writes are pipelined, submit new writes to the
same software queue as the writes that are already in progress. This
prevents reordering by submitting requests for the same zone to different
software or hardware queues.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c    |  4 ++--
 block/blk-zoned.c | 33 ++++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 01cfcc6f7b02..5ac9ff1ab380 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3103,8 +3103,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	/*
 	 * A BIO that was released from a zone write plug has already been
 	 * through the preparation in this function, already holds a reference
-	 * on the queue usage counter, and is the only write BIO in-flight for
-	 * the target zone. Go straight to preparing a request for it.
+	 * on the queue usage counter. Go straight to preparing a request for
+	 * it.
 	 */
 	if (bio_zone_write_plugging(bio)) {
 		nr_segs =3D bio->__bi_nr_segments;
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e2929d00dafd..6eec11b04501 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -55,6 +55,8 @@ static const char *const zone_cond_name[] =3D {
  *             as a number of 512B sectors.
  * @wp_offset_compl: End offset for completed zoned writes as a number o=
f 512
  *		     byte sectors.
+ * @swq_cpu: Software queue to submit writes to for drivers that preserv=
e the
+ *	write order.
  * @bio_list: The list of BIOs that are currently plugged.
  * @bio_work: Work struct to handle issuing of plugged BIOs
  * @rcu_head: RCU head to free zone write plugs with an RCU grace period=
.
@@ -69,6 +71,7 @@ struct blk_zone_wplug {
 	unsigned int		zone_no;
 	unsigned int		wp_offset;
 	unsigned int		wp_offset_compl;
+	int			swq_cpu;
 	struct bio_list		bio_list;
 	struct work_struct	bio_work;
 	struct rcu_head		rcu_head;
@@ -78,8 +81,7 @@ struct blk_zone_wplug {
 /*
  * Zone write plug flags bits:
  *  - BLK_ZONE_WPLUG_PLUGGED: Indicates that the zone write plug is plug=
ged,
- *    that is, that write BIOs are being throttled due to a write BIO al=
ready
- *    being executed or the zone write plug bio list is not empty.
+ *    that is, that write BIOs are being throttled.
  *  - BLK_ZONE_WPLUG_NEED_WP_UPDATE: Indicates that we lost track of a z=
one
  *    write pointer offset and need to update it.
  *  - BLK_ZONE_WPLUG_UNHASHED: Indicates that the zone write plug was re=
moved
@@ -568,6 +570,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_=
wplug(struct gendisk *disk,
 	zwplug->zone_no =3D zno;
 	zwplug->wp_offset =3D bdev_offset_from_zone_start(disk->part0, sector);
 	zwplug->wp_offset_compl =3D zwplug->wp_offset;
+	zwplug->swq_cpu =3D -1;
 	bio_list_init(&zwplug->bio_list);
 	INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
 	zwplug->disk =3D disk;
@@ -1085,7 +1088,8 @@ static bool blk_zone_wplug_prepare_bio(struct blk_z=
one_wplug *zwplug,
 	return true;
 }
=20
-static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr=
_segs)
+static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr=
_segs,
+					int *swq_cpu)
 {
 	struct gendisk *disk =3D bio->bi_bdev->bd_disk;
 	sector_t sector =3D bio->bi_iter.bi_sector;
@@ -1138,8 +1142,15 @@ static bool blk_zone_wplug_handle_write(struct bio=
 *bio, unsigned int nr_segs)
 	 * Otherwise, plug and let the BIO execute.
 	 */
 	if ((zwplug->flags & BLK_ZONE_WPLUG_BUSY) ||
-	    (bio->bi_opf & REQ_NOWAIT))
+	    (bio->bi_opf & REQ_NOWAIT)) {
 		goto plug;
+	} else if (disk->queue->limits.driver_preserves_write_order) {
+		if (zwplug->swq_cpu < 0)
+			zwplug->swq_cpu =3D raw_smp_processor_id();
+		*swq_cpu =3D zwplug->swq_cpu;
+	} else {
+		zwplug->flags |=3D BLK_ZONE_WPLUG_PLUGGED;
+	}
=20
 	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
 		spin_unlock_irqrestore(&zwplug->lock, flags);
@@ -1147,8 +1158,6 @@ static bool blk_zone_wplug_handle_write(struct bio =
*bio, unsigned int nr_segs)
 		return true;
 	}
=20
-	zwplug->flags |=3D BLK_ZONE_WPLUG_PLUGGED;
-
 	spin_unlock_irqrestore(&zwplug->lock, flags);
=20
 	return false;
@@ -1223,7 +1232,7 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned in=
t nr_segs, int *swq_cpu)
 		fallthrough;
 	case REQ_OP_WRITE:
 	case REQ_OP_WRITE_ZEROES:
-		return blk_zone_wplug_handle_write(bio, nr_segs);
+		return blk_zone_wplug_handle_write(bio, nr_segs, swq_cpu);
 	case REQ_OP_ZONE_RESET:
 		return blk_zone_wplug_handle_reset_or_finish(bio, 0);
 	case REQ_OP_ZONE_FINISH:
@@ -1278,6 +1287,9 @@ static void disk_zone_wplug_unplug_bio(struct gendi=
sk *disk,
=20
 	zwplug->flags &=3D ~BLK_ZONE_WPLUG_PLUGGED;
=20
+	if (refcount_read(&zwplug->ref) =3D=3D 2)
+		zwplug->swq_cpu =3D -1;
+
 	/*
 	 * If the zone is full (it was fully written or finished, or empty
 	 * (it was reset), remove its zone write plug from the hash table.
@@ -2041,6 +2053,7 @@ static void queue_zone_wplug_show(struct blk_zone_w=
plug *zwplug,
 	unsigned int zwp_zone_no, zwp_ref;
 	unsigned int zwp_bio_list_size;
 	unsigned long flags;
+	int swq_cpu;
=20
 	spin_lock_irqsave(&zwplug->lock, flags);
 	zwp_zone_no =3D zwplug->zone_no;
@@ -2049,13 +2062,15 @@ static void queue_zone_wplug_show(struct blk_zone=
_wplug *zwplug,
 	zwp_wp_offset =3D zwplug->wp_offset;
 	zwp_wp_offset_compl =3D zwplug->wp_offset_compl;
 	zwp_bio_list_size =3D bio_list_size(&zwplug->bio_list);
+	swq_cpu =3D zwplug->swq_cpu;
 	spin_unlock_irqrestore(&zwplug->lock, flags);
=20
 	bool all_zwr_inserted =3D blk_zone_all_zwr_inserted(zwplug);
=20
-	seq_printf(m, "zone_no %u flags 0x%x ref %u wp_offset %u bio_list_size =
%u all_zwr_inserted %d\n",
+	seq_printf(m, "zone_no %u flags 0x%x ref %u wp_offset %u wp_offset_comp=
l %u bio_list_size %u all_zwr_inserted %d swq_cpu %d\n",
 		   zwp_zone_no, zwp_flags, zwp_ref, zwp_wp_offset,
-		   zwp_bio_list_size, all_zwr_inserted);
+		   zwp_wp_offset_compl, zwp_bio_list_size, all_zwr_inserted,
+		   swq_cpu);
 }
=20
 int queue_zone_wplugs_show(void *data, struct seq_file *m)
