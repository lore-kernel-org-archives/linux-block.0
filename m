Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78E86337
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610314; cv=none; b=afEkfIQpRwbDTlPfxIJPNKNQ7A8A17F+vRCTLyxL+F0kGlySr0bGGGxl5g89PbLuS4f2lfSPQPgshLMQKoOBlZKUvS3z+jr5/0G8IChFq6A4aLCWwLLNMCoH7+e4vMq8pf5+C7W3U/xBs12VjYMpFlKvtkr0jlnjM86fNbf871o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610314; c=relaxed/simple;
	bh=k38Oy2Czo5B/RICr7THO83/FkMk7DtVyRyv5/UUsHOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zvjlqeu4WIK9NDCz4Dh0jjsrEzYrmqajfZsE8dFM9qVS1FdyOHMyCv5M6ekrpul2uXT51ed3Rfjs1P1lsUgXOKmw7rT5bX9t7Ity02zq9Fl5ZQCMuuj2TGmzyDUILqwPL26KIWR7B/2U9MyoFjisFmvt+UxAp4HxE3vyktdHTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HFHCpCAi; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HFHCpCAi"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhVhR35nTzm174M;
	Tue, 15 Jul 2025 20:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752610310; x=1755202311; bh=RCKzw
	aRAoX5CcuhnMCFlqiGwduqSLTiPD8dnqXTrAJU=; b=HFHCpCAidf+faleFp7R/0
	WCnIEZn6vnJN5bCsagsjgqKegkMKYEB5amv/vVg6/ARQOBmjQuOcqd7InRTi/x4F
	TODYpYKSg99xt8rhvEksLrkxH2mXnWjizvZfyFATAUYHuljheHY3qDTnKLyhb7Jv
	yGn2ne/14kvnq7s6rEQXKyr4U0DNO8tmJxtTtqcXjSbsr6DWPtSifXVcKf3oesn2
	sK7x/abaU6bpEbxjlRwBHdZ19SUpZk/VGZ11mOPScvIxY9eVqcax5JeqhXVndgR8
	KdXYv7e2SxMgD1GzH1rCQpJinTerq/HjgshAP+IAWDR/WKqIyqqW4paP8+cI8kdT
	w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ALSdZiNIdjRa; Tue, 15 Jul 2025 20:11:50 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhVhM1BM2zm174N;
	Tue, 15 Jul 2025 20:11:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 6/7] block: Rework splitting of encrypted bios
Date: Tue, 15 Jul 2025 13:10:54 -0700
Message-ID: <20250715201057.1176740-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250715201057.1176740-1-bvanassche@acm.org>
References: <20250715201057.1176740-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Modify splitting of encrypted bios as follows:
- Stop calling blk_crypto_bio_prep() for bio-based block drivers that do =
not
  call bio_split_to_limits().
- For request-based block drivers and for bio-based block drivers that ca=
ll
  bio_split_to_limits(), call blk_crypto_bio_prep() after bio splitting
  happened instead of before bio splitting happened.
- In bio_split_rw(), restrict the bio size to the smaller size of what is
  supported by the block driver and the crypto fallback code.

The advantages of these changes are as follows:
- This patch fixes write errors on zoned storage caused by out-of-order
  submission of bios. This out-of-order submission happens if both the
  crypto fallback code and bio_split_to_limits() split a bio.
- Less code duplication. The crypto fallback code now calls
  bio_split_to_limits() instead of open-coding it.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c            |  4 ----
 block/blk-crypto-fallback.c | 41 +++++++++----------------------------
 block/blk-crypto-internal.h |  7 +++++++
 block/blk-merge.c           |  9 ++++++--
 4 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2c3c8576aa9b..5af5f8c3cd06 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -626,10 +626,6 @@ static void __submit_bio(struct bio *bio)
 	/* If plug is not used, add new plug here to cache nsecs time. */
 	struct blk_plug plug;
=20
-	bio =3D blk_crypto_bio_prep(bio);
-	if (unlikely(!bio))
-		return;
-
 	blk_start_plug(&plug);
=20
 	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index ba5f1c887574..b54ad41e4192 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -214,7 +214,7 @@ blk_crypto_fallback_alloc_cipher_req(struct blk_crypt=
o_keyslot *slot,
  * the bio size supported by the encryption fallback code. This function
  * calculates the upper limit for the bio size.
  */
-static unsigned int blk_crypto_max_io_size(struct bio *bio)
+unsigned int blk_crypto_max_io_size(struct bio *bio)
 {
 	unsigned int i =3D 0;
 	unsigned int num_bytes =3D 0;
@@ -229,28 +229,6 @@ static unsigned int blk_crypto_max_io_size(struct bi=
o *bio)
 	return num_bytes >> SECTOR_SHIFT;
 }
=20
-static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr=
)
-{
-	struct bio *bio =3D *bio_ptr;
-	unsigned int num_sectors =3D blk_crypto_max_io_size(bio);
-
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
@@ -268,8 +246,8 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_CR=
YPTO_DUN_ARRAY_SIZE],
 /*
  * The crypto API fallback's encryption routine.
  * Allocate a bounce bio for encryption, encrypt the input bio using cry=
pto API,
- * and return the bounce bio. May split input bio if it's too large. Ret=
urns the
- * bounce bio on success. Returns %NULL and sets bio->bi_status on error=
.
+ * and return the bounce bio. Returns the bounce bio on success. Returns=
 %NULL
+ * and sets bio->bi_status on error.
  */
 static struct bio *blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
 {
@@ -285,9 +263,12 @@ static struct bio *blk_crypto_fallback_encrypt_bio(s=
truct bio *src_bio)
 	unsigned int i, j;
 	blk_status_t blk_st;
=20
-	/* Split the bio if it's too big for single page bvec */
-	if (!blk_crypto_fallback_split_bio_if_needed(&src_bio))
+	/* Verify that bio splitting has occurred. */
+	if (WARN_ON_ONCE(bio_sectors(src_bio) >
+			 blk_crypto_max_io_size(src_bio))) {
+		src_bio->bi_status =3D BLK_STS_IOERR;
 		return NULL;
+	}
=20
 	bc =3D src_bio->bi_crypt_context;
 	data_unit_size =3D bc->bc_key->crypto_cfg.data_unit_size;
@@ -481,10 +462,8 @@ static void blk_crypto_fallback_decrypt_endio(struct=
 bio *bio)
  *
  * @bio: bio to prepare
  *
- * If bio is doing a WRITE operation, this splits the bio into two parts=
 if it's
- * too big (see blk_crypto_fallback_split_bio_if_needed()). It then allo=
cates a
- * bounce bio for the first part, encrypts it, and updates bio_ptr to po=
int to
- * the bounce bio.
+ * For WRITE operations, a bounce bio is allocated, encrypted, and *bio_=
ptr is
+ * updated to point to the bounce bio.
  *
  * For a READ operation, we mark the bio for decryption by using bi_priv=
ate and
  * bi_end_io.
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 212e5bbfc95f..920cfc14c244 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -223,6 +223,8 @@ struct bio *blk_crypto_fallback_bio_prep(struct bio *=
bio);
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
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be5..f4e210279cd3 100644
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
@@ -124,10 +125,12 @@ static struct bio *bio_submit_split(struct bio *bio=
, int split_sectors)
 		trace_block_split(split, bio->bi_iter.bi_sector);
 		WARN_ON_ONCE(bio_zone_write_plugging(bio));
 		submit_bio_noacct(bio);
-		return split;
+
+		bio =3D split;
 	}
=20
-	return bio;
+	return blk_crypto_bio_prep(bio);
+
 error:
 	bio->bi_status =3D errno_to_blk_status(split_sectors);
 	bio_endio(bio);
@@ -211,6 +214,8 @@ static inline unsigned get_max_io_size(struct bio *bi=
o,
 	else
 		max_sectors =3D lim->max_sectors;
=20
+	max_sectors =3D min(max_sectors, blk_crypto_max_io_size(bio));
+
 	if (boundary_sectors) {
 		max_sectors =3D min(max_sectors,
 			blk_boundary_sectors_left(bio->bi_iter.bi_sector,
