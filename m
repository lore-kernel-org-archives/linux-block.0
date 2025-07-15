Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAAC19CCF5
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610307; cv=none; b=fvrh23GXXYOCynm+qwRZsLScI8Txb08c5I8iCKeaq3j7KRyiVc2mMow4LZ8FUJETsD/b4X05A+wIYqTqYQ8i+yQ0Bt7oNf4jDpJNa5C8fRUU3DPBCNf/39f4XSBVXl/2EdC0Cjri/zpUqZrbLfDvPHGMIVQVPi9Er6ZkFhNLNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610307; c=relaxed/simple;
	bh=nAonnaq7e+a9MM+bO5nFI8Ho1mykhzMoopyVQq4mpJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3mkeBG9UURcKN8XkPnoN03ChZj2Ly/RfyzxEtBrKg+g+4a9Ur6hex0PiMfw5O2K+YmVRJfhe/NhIlYdXieR2Y7mRtUJVa1/RZVAeEGKBHJfC8mQqBW+dQY4nVOKUtmNu9Z7icyRIS95ZyHJyYfimLofzhdLbB0qrK5RPiOIP3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=lXc0rfch; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="lXc0rfch"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhVhH3Gr7zm0jvy;
	Tue, 15 Jul 2025 20:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752610302; x=1755202303; bh=8yZqX
	rD1bQl/kUzJfVi1dcllFtnhVbfP2ap2CbK1aCk=; b=lXc0rfchMM4/eP5u/rc4g
	QspgTLtZvFvYTAxVgKVX7Cm8bN4kMsOK8hjgFU9S7MF0aiFAnlAIds/LwlBRRdAx
	zv55w+DApUcZ3kWJHA06hlRMDrjRAbB6vbp9U8MWdlryt4HOJ2ISWeU+636j7BLg
	IRaq0fnsttIMKd8flxx4iMGmlQ2KoH32tTU+6vFHs6QcDkQ32xeAcXvYcjPwdUK1
	J1QtFidCkiyHURaZUQjrD1bH70LtFKxx1Ra3UXAAY/CPKD1erw2nBLUs/x+UzHPB
	PuxUPxO/iQ+7dMsSv1PMvKN+AYRAnT9hpL6bOREzBTZu6j89nh9DvW28BhZpIKVV
	w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xgozFnh_GJdA; Tue, 15 Jul 2025 20:11:42 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhVhC13PLzm174R;
	Tue, 15 Jul 2025 20:11:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 4/7] block: Modify the blk_crypto_fallback_bio_prep() calling convention
Date: Tue, 15 Jul 2025 13:10:52 -0700
Message-ID: <20250715201057.1176740-5-bvanassche@acm.org>
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

Return a bio pointer instead of accepting a struct bio ** argument. No
functionality has been changed.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-crypto-fallback.c | 16 ++++++++--------
 block/blk-crypto-internal.h |  8 ++++----
 block/blk-crypto.c          |  6 ++++--
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 98bba0cf89cc..bd668a52817d 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -484,7 +484,7 @@ static void blk_crypto_fallback_decrypt_endio(struct =
bio *bio)
 /**
  * blk_crypto_fallback_bio_prep - Prepare a bio to use fallback en/decry=
ption
  *
- * @bio_ptr: pointer to the bio to prepare
+ * @bio: bio to prepare
  *
  * If bio is doing a WRITE operation, this splits the bio into two parts=
 if it's
  * too big (see blk_crypto_fallback_split_bio_if_needed()). It then allo=
cates a
@@ -499,28 +499,28 @@ static void blk_crypto_fallback_decrypt_endio(struc=
t bio *bio)
  * of the stack except for blk-integrity (blk-integrity and blk-crypto a=
re not
  * currently supported together).
  *
- * Return: true on success. Sets bio->bi_status and returns false on err=
or.
+ * Return: a bio pointer on success; %NULL upon failure. Sets bio->bi_st=
atus on
+ * error.
  */
-bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
+struct bio *blk_crypto_fallback_bio_prep(struct bio *bio)
 {
-	struct bio *bio =3D *bio_ptr;
 	struct bio_crypt_ctx *bc =3D bio->bi_crypt_context;
 	struct bio_fallback_crypt_ctx *f_ctx;
=20
 	if (WARN_ON_ONCE(!tfms_inited[bc->bc_key->crypto_cfg.crypto_mode])) {
 		/* User didn't call blk_crypto_start_using_key() first */
 		bio->bi_status =3D BLK_STS_IOERR;
-		return false;
+		return NULL;
 	}
=20
 	if (!__blk_crypto_cfg_supported(blk_crypto_fallback_profile,
 					&bc->bc_key->crypto_cfg)) {
 		bio->bi_status =3D BLK_STS_NOTSUPP;
-		return false;
+		return NULL;
 	}
=20
 	if (bio_data_dir(bio) =3D=3D WRITE)
-		return blk_crypto_fallback_encrypt_bio(bio_ptr);
+		return blk_crypto_fallback_encrypt_bio(&bio) ? bio : NULL;
=20
 	/*
 	 * bio READ case: Set up a f_ctx in the bio's bi_private and set the
@@ -535,7 +535,7 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_pt=
r)
 	bio->bi_end_io =3D blk_crypto_fallback_decrypt_endio;
 	bio_crypt_free_ctx(bio);
=20
-	return true;
+	return bio;
 }
=20
 int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key)
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index e2fd5a3221d3..212e5bbfc95f 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -219,7 +219,7 @@ static inline int blk_crypto_rq_bio_prep(struct reque=
st *rq, struct bio *bio,
=20
 int blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_n=
um);
=20
-bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr);
+struct bio *blk_crypto_fallback_bio_prep(struct bio *bio);
=20
 int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key);
=20
@@ -232,11 +232,11 @@ blk_crypto_fallback_start_using_mode(enum blk_crypt=
o_mode_num mode_num)
 	return -ENOPKG;
 }
=20
-static inline bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
+static inline struct bio *blk_crypto_fallback_bio_prep(struct bio *bio)
 {
 	pr_warn_once("crypto API fallback disabled; failing request.\n");
-	(*bio_ptr)->bi_status =3D BLK_STS_NOTSUPP;
-	return false;
+	bio->bi_status =3D BLK_STS_NOTSUPP;
+	return NULL;
 }
=20
 static inline int
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 84efb65fc51c..4bf8c212aee8 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -281,6 +281,7 @@ void __blk_crypto_free_request(struct request *rq)
  */
 struct bio *__blk_crypto_bio_prep(struct bio *bio)
 {
+	struct bio *new_bio;
 	const struct blk_crypto_key *bc_key =3D bio->bi_crypt_context->bc_key;
=20
 	/* Error if bio has no data. */
@@ -301,8 +302,9 @@ struct bio *__blk_crypto_bio_prep(struct bio *bio)
 	if (blk_crypto_config_supported_natively(bio->bi_bdev,
 						 &bc_key->crypto_cfg))
 		return bio;
-	if (blk_crypto_fallback_bio_prep(&bio))
-		return bio;
+	new_bio =3D blk_crypto_fallback_bio_prep(bio);
+	if (new_bio)
+		return new_bio;
 fail:
 	bio_endio(bio);
 	return NULL;
