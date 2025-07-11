Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF341AF0AF
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254378; cv=none; b=Ww0i389WuswS0Emw81f87yx8FfshMvAwWuvjCgrYeAourrsY9o3p3gbMdvMhKwD4vP6HKuZ4IWqzAvjCkv/v5c/2sHArmv8gUjtycIaMbKqzfXg4HYf8N42I3A83XP1kXMv/yUgYwwjWzpoIwNNJ0WauU8mhwritoMMdyEwdmHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254378; c=relaxed/simple;
	bh=rB/VDn0lZ4O/3Nw1SiUcU1I93txUnpp3bkG5OtAa3pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYWVp9c4srFXoj4HLHqvGBwI8TQHeg8AXmYUiTMcZCIOSUWeGjkiuBci9qnXHFePFKP3k9uJYaB8A78VMqXTq5cv8rXewGOcXlcBH0WR7o25DOHxuLqf08n8Xs1HZXEEEpsfwaj3Jamhmp9ku4/APVrMVL8iBZgTwzbXDfnPVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mDGch8CH; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mDGch8CH"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bdz3V2kShzm174W;
	Fri, 11 Jul 2025 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752254373; x=1754846374; bh=vrpuq
	40jNvXzeakQwJx+3HLc+MtAopyEwE6qIttuxAU=; b=mDGch8CHSg/py8lJslAoE
	pYQLgPKKi3ZYfKTHWexwGajkOX15W3bghlMzLzEuXKkJfyyHe61bjVnucbacsrQe
	P9cTOA3oRQJHoVkGj62hKMg9MUqqCNEkFtz5Fp5N9jQU0jTLFl6znzSvktg+rPm4
	LOA4sJFqwWICYk6FtA2ZT9grC8sSswPW+cp3jr3cfMJVro+IQXK/sWhCFGYfU/th
	+mu4O0b4QTExtNWOZ9PK/w1IFxTe3WvZ1TACUKOgLP9nBgbZG+Q8vhHZamcY74lq
	U9EedzS5c/04nZgliFGHqJW8a17OcaVX5kVz8bRbekcUhxLwqGnGMgGcuregck73
	Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ZCHIHDfC1xWD; Fri, 11 Jul 2025 17:19:33 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bdz3Q1841zm174w;
	Fri, 11 Jul 2025 17:19:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 2/2] block: Rework splitting of encrypted bios
Date: Fri, 11 Jul 2025 10:18:52 -0700
Message-ID: <20250711171853.68596-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250711171853.68596-1-bvanassche@acm.org>
References: <20250711171853.68596-1-bvanassche@acm.org>
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
 block/blk-core.c            |  3 ---
 block/blk-crypto-fallback.c | 38 ++++++++-----------------------------
 block/blk-crypto-internal.h |  7 +++++++
 block/blk-merge.c           | 12 ++++++++++--
 4 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdac48aec5ef..5af5f8c3cd06 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -626,9 +626,6 @@ static void __submit_bio(struct bio *bio)
 	/* If plug is not used, add new plug here to cache nsecs time. */
 	struct blk_plug plug;
=20
-	if (unlikely(!blk_crypto_bio_prep(&bio)))
-		return;
-
 	blk_start_plug(&plug);
=20
 	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 0f127230215b..481123910b5f 100644
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
 	unsigned int num_sectors =3D 0;
@@ -230,29 +230,6 @@ static unsigned int blk_crypto_max_io_size(struct bi=
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
@@ -289,9 +266,12 @@ static bool blk_crypto_fallback_encrypt_bio(struct b=
io **bio_ptr)
 	bool ret =3D false;
 	blk_status_t blk_st;
=20
-	/* Split the bio if it's too big for single page bvec */
-	if (!blk_crypto_fallback_split_bio_if_needed(bio_ptr))
+	/* Verify that bio splitting has occurred. */
+	if (WARN_ON_ONCE(bio_sectors(*bio_ptr) >
+			 blk_crypto_max_io_size(*bio_ptr))) {
+		(*bio_ptr)->bi_status =3D BLK_STS_IOERR;
 		return false;
+	}
=20
 	src_bio =3D *bio_ptr;
 	bc =3D src_bio->bi_crypt_context;
@@ -488,10 +468,8 @@ static void blk_crypto_fallback_decrypt_endio(struct=
 bio *bio)
  *
  * @bio_ptr: pointer to the bio to prepare
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
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be5..a85d1cc95577 100644
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
@@ -124,9 +125,13 @@ static struct bio *bio_submit_split(struct bio *bio,=
 int split_sectors)
 		trace_block_split(split, bio->bi_iter.bi_sector);
 		WARN_ON_ONCE(bio_zone_write_plugging(bio));
 		submit_bio_noacct(bio);
-		return split;
+
+		bio =3D split;
 	}
=20
+	if (unlikely(!blk_crypto_bio_prep(&bio)))
+		return NULL;
+
 	return bio;
 error:
 	bio->bi_status =3D errno_to_blk_status(split_sectors);
@@ -355,9 +360,12 @@ EXPORT_SYMBOL_GPL(bio_split_rw_at);
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
