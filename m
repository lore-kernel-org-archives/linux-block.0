Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0619CCF5
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610309; cv=none; b=IscTnfOcQFW+cy0xsteiA3SBvrEP0J9ahXS5LHN2NosMizXO75uUsNRoz7COmGDtv7lXJQB1OZgPHqW+2Xq4SuUYrkwltddCGSRzx50THjI1xRbrZUfIDRsAbWLOyyxF0vu7a99qt5trMS0MZKjvid5h4ZHcrKgOGHBkpRrS3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610309; c=relaxed/simple;
	bh=kjvuGj2vZhjXsYphcYK027DOFdp+g5Kl614yolV5zm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYaUYgYSEdAnb5PxYy+w5Ek+m92yrk3laCC6XiVJlJZdzXzXVBHGLJrYCqkKgAaDVKOxQaislr4pKY30Rg/E1zT/EgbJYuasHHRwfdU8ophPwbqysClJoCrCnIyVlxjZ9rOJJryyReOYw9gci5XhBW1hNODY8CO4G+NJGuUD5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=PGjGnMUi; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="PGjGnMUi"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhVhM1Rh9zm174g;
	Tue, 15 Jul 2025 20:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752610305; x=1755202306; bh=WBsTI
	owGvpWxfXFh6lq+kddnCHDJ1CXqBWDLEJ8otbA=; b=PGjGnMUi+4YfPa+X43wyS
	02sRyoObDYM0BWCFftsmeVfUyWz3mLtkXTKL+tMv/1/B2ws0Tqf5IPQLj3f35uH5
	SVJhvhQhDVoVRg0mGW3QgWpfyKAJV1VTGNBH6NRoE+6bXnCQgLHA0VHtBPPDSgLY
	BPtSlAG+qq7/oAvK4I98JoVmpcMH3xVbe1RxdtmPYh2IZUUMvVxmgKyByNaUeP4K
	jzSvbbp0CQ+cInfDezvlFdU9f9Tegrbu+red+YuISksn5UX+oHc1yy0EH0BWNyIv
	LB8sG6aHIeWKDgqHrk2yK5El5sdhqiwwuIpSTOBC0PmVZbHQ7wGsMneiSJwAyxWy
	A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Y1C70hJE1uNp; Tue, 15 Jul 2025 20:11:45 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhVhH0JJlzm174M;
	Tue, 15 Jul 2025 20:11:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 5/7] block: Change the blk_crypto_fallback_encrypt_bio() calling convention
Date: Tue, 15 Jul 2025 13:10:53 -0700
Message-ID: <20250715201057.1176740-6-bvanassche@acm.org>
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

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-crypto-fallback.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index bd668a52817d..ba5f1c887574 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -268,13 +268,12 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_=
CRYPTO_DUN_ARRAY_SIZE],
 /*
  * The crypto API fallback's encryption routine.
  * Allocate a bounce bio for encryption, encrypt the input bio using cry=
pto API,
- * and replace *bio_ptr with the bounce bio. May split input bio if it's=
 too
- * large. Returns true on success. Returns false and sets bio->bi_status=
 on
- * error.
+ * and return the bounce bio. May split input bio if it's too large. Ret=
urns the
+ * bounce bio on success. Returns %NULL and sets bio->bi_status on error=
.
  */
-static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
+static struct bio *blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
 {
-	struct bio *src_bio, *enc_bio;
+	struct bio *enc_bio, *ret =3D NULL;
 	struct bio_crypt_ctx *bc;
 	struct blk_crypto_keyslot *slot;
 	int data_unit_size;
@@ -284,14 +283,12 @@ static bool blk_crypto_fallback_encrypt_bio(struct =
bio **bio_ptr)
 	struct scatterlist src, dst;
 	union blk_crypto_iv iv;
 	unsigned int i, j;
-	bool ret =3D false;
 	blk_status_t blk_st;
=20
 	/* Split the bio if it's too big for single page bvec */
-	if (!blk_crypto_fallback_split_bio_if_needed(bio_ptr))
-		return false;
+	if (!blk_crypto_fallback_split_bio_if_needed(&src_bio))
+		return NULL;
=20
-	src_bio =3D *bio_ptr;
 	bc =3D src_bio->bi_crypt_context;
 	data_unit_size =3D bc->bc_key->crypto_cfg.data_unit_size;
=20
@@ -299,7 +296,7 @@ static bool blk_crypto_fallback_encrypt_bio(struct bi=
o **bio_ptr)
 	enc_bio =3D blk_crypto_fallback_clone_bio(src_bio);
 	if (!enc_bio) {
 		src_bio->bi_status =3D BLK_STS_RESOURCE;
-		return false;
+		return NULL;
 	}
=20
 	/*
@@ -362,9 +359,7 @@ static bool blk_crypto_fallback_encrypt_bio(struct bi=
o **bio_ptr)
=20
 	enc_bio->bi_private =3D src_bio;
 	enc_bio->bi_end_io =3D blk_crypto_fallback_encrypt_endio;
-	*bio_ptr =3D enc_bio;
-	ret =3D true;
-
+	ret =3D enc_bio;
 	enc_bio =3D NULL;
 	goto out_free_ciph_req;
=20
@@ -520,7 +515,7 @@ struct bio *blk_crypto_fallback_bio_prep(struct bio *=
bio)
 	}
=20
 	if (bio_data_dir(bio) =3D=3D WRITE)
-		return blk_crypto_fallback_encrypt_bio(&bio) ? bio : NULL;
+		return blk_crypto_fallback_encrypt_bio(bio);
=20
 	/*
 	 * bio READ case: Set up a f_ctx in the bio's bi_private and set the
