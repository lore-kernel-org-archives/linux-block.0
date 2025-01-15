Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6451DBB19
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981245; cv=none; b=qzVyTW0hkQMgMcXgVbmcMNCHmgpVm6luZdzihW2AeGay9szApcIVNaaG9i1ghDwrwxF1dte7MfjLqZXtWXtkqVLFS6xRucXoFGADziyhpnQI4Joautjz5wqh0rDqNT+wL9gZVcCtCfFhaLqsM6h6ZDa5cGx3Zb46jUYDyJcF1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981245; c=relaxed/simple;
	bh=RggSVnHIh7yp3OjIe5TAtJDqRBdlfYhjfFvYrhtbXHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEH3+PSVOpg/58RAoisUY2ryh8Nm1pqGQcdKWpitEqCBq8oLUpZADwnDaM6mpSgyAYLSdwAI1co+n3URpsf9HjI8v+AWOqS7l5Y8oco9wUQRnEGDXzoZPBXFvVe//l0p/6w9TLmXaR0DsiC5Z1+SPClYwHMrC8t4bOYa/4TORxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=G7HD26a8; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="G7HD26a8"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYLjR1mdjz6CmM6Q;
	Wed, 15 Jan 2025 22:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1736981239; x=1739573240; bh=4sl61
	HsrwV+FSPuE2ckZJGaDsWAFUjIzGU073sRJ32M=; b=G7HD26a85DPgQmDn7YNNy
	CCydymH4erGTafeFQ+2Umzyox/Rk27XYXCVNCyyaRnnMN4isXjSFXGUWuxyk5dYR
	kXUKzl6ZY3UvZNodI9eokVKK9OWW61EPkraNGrtPFlTbDARjAEmREtf00AbyEP+R
	kPKclwsUwb5A8vfNFAcWobhHh+T4eOuIDwhUq4s4p9nkKB6qLR8T5LLy5Hmt0OWh
	xdbkiwPIQkuky+IPa/YF4+gvAtbN5DV321HW/sGHhaJWBJTfnrfYxTxY5EfXnu7P
	2i5purzhtCibWSGg3m2BJzc9I1mhnk2z00tUWHjhrtHI6urCaT6o3LjBnU3mNpAt
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WfZDMUtyxcjJ; Wed, 15 Jan 2025 22:47:19 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYLjK4qd9z6CmM6X;
	Wed, 15 Jan 2025 22:47:17 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v17 08/14] blk-zoned: Add an argument to blk_zone_plug_bio()
Date: Wed, 15 Jan 2025 14:46:42 -0800
Message-ID: <20250115224649.3973718-9-bvanassche@acm.org>
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

Prepare for preserving the order of pipelined zoned writes per zone.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         | 2 +-
 block/blk-zoned.c      | 3 ++-
 drivers/md/dm.c        | 2 +-
 include/linux/blkdev.h | 5 +++--
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ca34ec34d595..01cfcc6f7b02 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3142,7 +3142,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
 		goto queue_exit;
=20
-	if (blk_queue_is_zoned(q) && blk_zone_plug_bio(bio, nr_segs))
+	if (blk_queue_is_zoned(q) && blk_zone_plug_bio(bio, nr_segs, &swq_cpu))
 		goto queue_exit;
=20
 new_request:
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index cc09ae84acc8..e2929d00dafd 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1165,6 +1165,7 @@ static bool blk_zone_wplug_handle_write(struct bio =
*bio, unsigned int nr_segs)
  * blk_zone_plug_bio - Handle a zone write BIO with zone write plugging
  * @bio: The BIO being submitted
  * @nr_segs: The number of physical segments of @bio
+ * @swq_cpu: [out] CPU of the software queue to which the bio should be =
queued
  *
  * Handle write, write zeroes and zone append operations requiring emula=
tion
  * using zone write plugging.
@@ -1173,7 +1174,7 @@ static bool blk_zone_wplug_handle_write(struct bio =
*bio, unsigned int nr_segs)
  * write plug. Otherwise, return false to let the submission path proces=
s
  * @bio normally.
  */
-bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
+bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs, int *swq_c=
pu)
 {
 	struct block_device *bdev =3D bio->bi_bdev;
=20
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 12ecf07a3841..c3f851fe26f6 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1796,7 +1796,7 @@ static inline bool dm_zone_bio_needs_split(struct m=
apped_device *md,
 }
 static inline bool dm_zone_plug_bio(struct mapped_device *md, struct bio=
 *bio)
 {
-	return dm_emulate_zone_append(md) && blk_zone_plug_bio(bio, 0);
+	return dm_emulate_zone_append(md) && blk_zone_plug_bio(bio, 0, NULL);
 }
=20
 static blk_status_t __send_zone_reset_all_emulated(struct clone_info *ci=
,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fcea07b4062e..0ae106944ab3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -704,13 +704,14 @@ static inline unsigned int disk_nr_zones(struct gen=
disk *disk)
 {
 	return disk->nr_zones;
 }
-bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
+bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs, int *swq_c=
pu);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
 	return 0;
 }
-static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_se=
gs)
+static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_se=
gs,
+				     int *swq_cpu)
 {
 	return false;
 }
