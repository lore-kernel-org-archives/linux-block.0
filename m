Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37FC2F1FC1
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895028; cv=none; b=Pp6jZfOU+sVFqp6kVpLP7RNPH7VDrkRpKkND0yR7UmF729Io3NW8d0B7NWOH3SAWSk0wSrjJJ4bwrboEb5QpSWQwZw3nLQyH8xqizjdeA/mRrpqvWZnYRAjOm9Szpr45WBFZLy7Ax6Ttd/79HuwTK4e47GI5auYGS2KEBAdB7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895028; c=relaxed/simple;
	bh=4bCBVQMCB62cdHvbfi0xF+b6Wh7r+DaI18m8FGKPiCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTDF7jNmMY/rWOAWJm30Rh2tIZo4wp+jVtjp4pzJTv3mwSpidK55OXoZoFJsZzIFS0NfTsenBQhwGRzWoxUsnOK8G4zVQhoX6d4OknQWAEwMzoapXMVhDTmVFSTbzPp/RxIq8AEulBOcjNuHQb0UGe5lyw0sQ+Hj+I7H/pr7tAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mqAyeaXW; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mqAyeaXW"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bSJL873BKzm0jwG;
	Wed, 25 Jun 2025 23:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1750895023; x=1753487024; bh=wm3LV
	yUWWP2NiSgRl/pfKu5bPvyKhocECBcwcyvRW4A=; b=mqAyeaXW2FIA7bzKUjdhq
	TlhY9aQlZno3wd4IRAvHMqY/nPXHC4nJWYuQQBHziy/k8DcyFt9l0UqZoclUlBla
	OQVyuqVRAtHOaZFf5zPTFHCDQh4qBetx6EKbIKOnZa3Ezhsk0hKkGFZgMssb+lDM
	mEOkCL9fPFWMWynQV8JvXi+ZEKU3G9N5Sq3nrv3DJJsNVrpGKdtCjdOlpUH+Gi5J
	he9JDP0ncm8IiGEDqcGIeWkTRiChXyV9rzWzmj9C98b7wa7Fg7C0L25Un6Bf98mW
	TP5NE9YYDUM3wq4kNnGqWcXcqV6g861TKBL6QL9dNR0HLn+l73pOZVgA4lzsLdYC
	Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rNMGDcbeH6Qx; Wed, 25 Jun 2025 23:43:43 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bSJL22vRHzm0pKG;
	Wed, 25 Jun 2025 23:43:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Keith Busch <kbusch@kernel.org>,
	Christop Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 3/3] block: Rework splitting of encrypted bios
Date: Wed, 25 Jun 2025 16:42:59 -0700
Message-ID: <20250625234259.1985366-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625234259.1985366-1-bvanassche@acm.org>
References: <20250625234259.1985366-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Modify splitting of encrypted bios as follows:
- Introduce a new block device flag BD_SPLITS_BIO_TO_LIMITS that allows
  bio-based drivers to report that they call bio_split_to_limits() for
  every bio.
- For request-based block drivers and for bio-based block drivers that ca=
ll
  bio_split_to_limits(), call blk_crypto_bio_prep() after bio splitting
  happened instead of before bio splitting happened.
- For bio-based block drivers of which it is not known whether they call
  bio_split_to_limits(), call blk_crypto_bio_prep() before .submit_bio() =
is
  called.
- In blk_crypto_fallback_encrypt_bio(), prevent infinite recursion by onl=
y
  trying to split a bio if this function is not called from inside
  bio_split_to_limits().
- Since blk_crypto_fallback_encrypt_bio() may clear *bio_ptr, in its call=
er
  (__blk_crypto_bio_prep()), check whether or not this pointer is NULL.
- In bio_split_rw(), restrict the bio size to the smaller size of what is
  supported to the block driver and the crypto fallback code.

The advantages of these changes are as follows:
- This patch fixes write errors on zoned storage caused by out-of-order
  submission of bios. This out-of-order submission happens if both the
  crypto fallback code and bio_split_to_limits() split a bio.
- Less code duplication. The crypto fallback code now calls
  bio_split_to_limits() instead of open-coding it.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bio.c                 |  3 ++
 block/blk-core.c            | 19 +++++++++----
 block/blk-crypto-fallback.c | 56 +++++++++++++++----------------------
 block/blk-crypto-internal.h |  7 +++++
 block/blk-crypto.c          |  3 +-
 block/blk-merge.c           | 13 +++++++--
 block/blk.h                 |  9 ++++++
 include/linux/blk_types.h   |  1 +
 8 files changed, 69 insertions(+), 42 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 92c512e876c8..2103612171c0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1688,6 +1688,9 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	if (!split)
 		return ERR_PTR(-ENOMEM);
=20
+	/* Prevent that bio_split_to_limits() calls itself recursively. */
+	bio_set_flag(split, BIO_HAS_BEEN_SPLIT);
+
 	split->bi_iter.bi_size =3D sectors << 9;
=20
 	if (bio_integrity(split))
diff --git a/block/blk-core.c b/block/blk-core.c
index fdac48aec5ef..3a720ec8e6cc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -626,23 +626,30 @@ static void __submit_bio(struct bio *bio)
 	/* If plug is not used, add new plug here to cache nsecs time. */
 	struct blk_plug plug;
=20
-	if (unlikely(!blk_crypto_bio_prep(&bio)))
-		return;
-
 	blk_start_plug(&plug);
=20
 	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) =3D=3D 0)) {
 		struct gendisk *disk =3D bio->bi_bdev->bd_disk;
-=09
-		if ((bio->bi_opf & REQ_POLLED) &&
-		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
+		const blk_features_t features =3D disk->queue->limits.features;
+
+		/*
+		 * Only call blk_crypto_bio_prep() before .submit_bio() if
+		 * the block driver won't call bio_split_to_limits().
+		 */
+		if (unlikely(!(features & BLK_FEAT_CALLS_BIO_SPLIT_TO_LIMITS) &&
+			     !blk_crypto_bio_prep(&bio)))
+			goto exit_queue;
+
+		if ((bio->bi_opf & REQ_POLLED) && !(features & BLK_FEAT_POLL)) {
 			bio->bi_status =3D BLK_STS_NOTSUPP;
 			bio_endio(bio);
 		} else {
 			disk->fops->submit_bio(bio);
 		}
+
+exit_queue:
 		blk_queue_exit(disk->queue);
 	}
=20
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 323f59b91a8f..8f9aee6a837a 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -213,7 +213,7 @@ blk_crypto_fallback_alloc_cipher_req(struct blk_crypt=
o_keyslot *slot,
  * The encryption fallback code allocates bounce pages individually. Hen=
ce this
  * function that calculates an upper limit for the bio size.
  */
-static unsigned int blk_crypto_max_io_size(struct bio *bio)
+unsigned int blk_crypto_max_io_size(struct bio *bio)
 {
 	unsigned int i =3D 0;
 	unsigned int num_sectors =3D 0;
@@ -229,29 +229,6 @@ static unsigned int blk_crypto_max_io_size(struct bi=
o *bio)
 	return num_sectors;
 }
=20
-static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr=
)
-{
-	struct bio *bio =3D *bio_ptr;
-	unsigned int num_sectors;
-
-	num_sectors =3D blk_crypto_max_io_size(bio);
-	if (num_sectors < bio_sectors(bio)) {
-		struct bio *split_bio;
-
-		split_bio =3D bio_split(bio, num_sectors, GFP_NOIO,
-				      &crypto_bio_split);
-		if (IS_ERR(split_bio)) {
-			bio->bi_status =3D BLK_STS_RESOURCE;
-			return false;
-		}
-		bio_chain(split_bio, bio);
-		submit_bio_noacct(bio);
-		*bio_ptr =3D split_bio;
-	}
-
-	return true;
-}
-
 union blk_crypto_iv {
 	__le64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 	u8 bytes[BLK_CRYPTO_MAX_IV_SIZE];
@@ -270,8 +247,10 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_C=
RYPTO_DUN_ARRAY_SIZE],
  * The crypto API fallback's encryption routine.
  * Allocate a bounce bio for encryption, encrypt the input bio using cry=
pto API,
  * and replace *bio_ptr with the bounce bio. May split input bio if it's=
 too
- * large. Returns true on success. Returns false and sets bio->bi_status=
 on
- * error.
+ * large. Returns %true on success. On error, %false is returned and one=
 of
+ * these two actions is taken:
+ * - Either @bio_ptr->bi_status is set and *@bio_ptr is not modified.
+ * - Or bio_endio() is called and *@bio_ptr is changed into %NULL.
  */
 static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 {
@@ -288,11 +267,17 @@ static bool blk_crypto_fallback_encrypt_bio(struct =
bio **bio_ptr)
 	bool ret =3D false;
 	blk_status_t blk_st;
=20
-	/* Split the bio if it's too big for single page bvec */
-	if (!blk_crypto_fallback_split_bio_if_needed(bio_ptr))
-		return false;
+	if (!bio_flagged(*bio_ptr, BIO_HAS_BEEN_SPLIT)) {
+		/* Split the bio if it's too big for single page bvec */
+		src_bio =3D bio_split_to_limits(*bio_ptr);
+		if (!src_bio) {
+			*bio_ptr =3D NULL;
+			return false;
+		}
+	} else {
+		src_bio =3D *bio_ptr;
+	}
=20
-	src_bio =3D *bio_ptr;
 	bc =3D src_bio->bi_crypt_context;
 	data_unit_size =3D bc->bc_key->crypto_cfg.data_unit_size;
=20
@@ -488,9 +473,8 @@ static void blk_crypto_fallback_decrypt_endio(struct =
bio *bio)
  * @bio_ptr: pointer to the bio to prepare
  *
  * If bio is doing a WRITE operation, this splits the bio into two parts=
 if it's
- * too big (see blk_crypto_fallback_split_bio_if_needed()). It then allo=
cates a
- * bounce bio for the first part, encrypts it, and updates bio_ptr to po=
int to
- * the bounce bio.
+ * too big. It then allocates a bounce bio for the first part, encrypts =
it, and
+ * updates bio_ptr to point to the bounce bio.
  *
  * For a READ operation, we mark the bio for decryption by using bi_priv=
ate and
  * bi_end_io.
@@ -508,6 +492,12 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_p=
tr)
 	struct bio_crypt_ctx *bc =3D bio->bi_crypt_context;
 	struct bio_fallback_crypt_ctx *f_ctx;
=20
+	/*
+	 * Check whether blk_crypto_fallback_bio_prep() has already been called=
.
+	 */
+	if (bio->bi_end_io =3D=3D blk_crypto_fallback_encrypt_endio)
+		return true;
+
 	if (WARN_ON_ONCE(!tfms_inited[bc->bc_key->crypto_cfg.crypto_mode])) {
 		/* User didn't call blk_crypto_start_using_key() first */
 		bio->bi_status =3D BLK_STS_IOERR;
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index ccf6dff6ff6b..443ba1fd82e6 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -223,6 +223,8 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_pt=
r);
=20
 int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key);
=20
+unsigned int blk_crypto_max_io_size(struct bio *bio);
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
=20
 static inline int
@@ -245,6 +247,11 @@ blk_crypto_fallback_evict_key(const struct blk_crypt=
o_key *key)
 	return 0;
 }
=20
+static inline unsigned int blk_crypto_max_io_size(struct bio *bio)
+{
+	return UINT_MAX;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
=20
 #endif /* __LINUX_BLK_CRYPTO_INTERNAL_H */
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 4b1ad84d1b5a..76278e23193d 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -306,7 +306,8 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 	if (blk_crypto_fallback_bio_prep(bio_ptr))
 		return true;
 fail:
-	bio_endio(*bio_ptr);
+	if (*bio_ptr)
+		bio_endio(*bio_ptr);
 	return false;
 }
=20
diff --git a/block/blk-merge.c b/block/blk-merge.c
index e55a8ec219c9..df65231be543 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -9,6 +9,7 @@
 #include <linux/blk-integrity.h>
 #include <linux/part_stat.h>
 #include <linux/blk-cgroup.h>
+#include <linux/blk-crypto.h>
=20
 #include <trace/events/block.h>
=20
@@ -125,9 +126,14 @@ static struct bio *bio_submit_split(struct bio *bio,=
 int split_sectors)
 				  bio->bi_iter.bi_sector);
 		WARN_ON_ONCE(bio_zone_write_plugging(bio));
 		submit_bio_noacct(bio);
-		return split;
+
+		bio =3D split;
 	}
=20
+	WARN_ON_ONCE(!bio);
+	if (unlikely(!blk_crypto_bio_prep(&bio)))
+		return NULL;
+
 	return bio;
 error:
 	bio->bi_status =3D errno_to_blk_status(split_sectors);
@@ -356,9 +362,12 @@ EXPORT_SYMBOL_GPL(bio_split_rw_at);
 struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim=
,
 		unsigned *nr_segs)
 {
+	u32 max_sectors =3D
+		min(get_max_io_size(bio, lim), blk_crypto_max_io_size(bio));
+
 	return bio_submit_split(bio,
 		bio_split_rw_at(bio, lim, nr_segs,
-			get_max_io_size(bio, lim) << SECTOR_SHIFT));
+				(u64)max_sectors << SECTOR_SHIFT));
 }
=20
 /*
diff --git a/block/blk.h b/block/blk.h
index 1141b343d0b5..5f2b43b250df 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -376,6 +376,11 @@ static inline bool bio_may_need_split(struct bio *bi=
o,
 		lim->min_segment_size;
 }
=20
+static void bio_clear_split_flag(struct bio **bio)
+{
+	bio_clear_flag(*bio, BIO_HAS_BEEN_SPLIT);
+}
+
 /**
  * __bio_split_to_limits - split a bio to fit the queue limits
  * @bio:     bio to be split
@@ -392,6 +397,10 @@ static inline bool bio_may_need_split(struct bio *bi=
o,
 static inline struct bio *__bio_split_to_limits(struct bio *bio,
 		const struct queue_limits *lim, unsigned int *nr_segs)
 {
+	struct bio *clear_split_flag __cleanup(bio_clear_split_flag) =3D bio;
+
+	bio_set_flag(bio, BIO_HAS_BEEN_SPLIT);
+
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 	case REQ_OP_WRITE:
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 09b99d52fd36..d235e894347a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -308,6 +308,7 @@ enum {
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
 	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
+	BIO_HAS_BEEN_SPLIT,
 	BIO_FLAG_LAST
 };
=20
