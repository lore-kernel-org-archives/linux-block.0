Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC429B796
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610301; cv=none; b=LFC0dB0zVbcZ2YH2R9IeQEPThrzd4WHc4vN3RNJPqUTfyFRQ15GUL0OjdD3Y9f97LjsALgiUiOzalXQTAi+z4nbjFUzvtxmnvSpptwU1j1vb5PlD7/3eyfJ42zS+mmW51HRhoRVAOF+ZX2dxqnY9a5ioPQTJUempzlCdnMdlguU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610301; c=relaxed/simple;
	bh=0GydKDzmufQHDfZ4cWAlXDSVSzIVfb8F1rEi+BRq758=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbNeAa+/6LhZUrN6QcarEWZ4jUCqYnM0k5Cg1wPDBYBap8XXmi2nycMk0ieLc63kwOwPe5opAnBKIZrYo3BtQIwx3lNJkIa+uUhDsmsplvH8l4feqA0a5lKPozl8cUSOHwlzZ0BH9GJxB6JF4UHYleZgbCTTPpDZxA8PZ0tiIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AXnXHGTL; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AXnXHGTL"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhVhC29ryzm0jvK;
	Tue, 15 Jul 2025 20:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752610298; x=1755202299; bh=AR7R0
	/WaGOM3GcKmmxqObWJoLsH7B9TQBYF5G58d3Tw=; b=AXnXHGTLATFEuU+mOaZxE
	4b3Xxf3Lz7Apu4OYTFDFD1dR4Cz8eL8oVr4Dh3z0HQNDfI52Jo3BJfOkib6pODh1
	YZyZXFaLNmsso1PsAso6ge1itsau7/v+yvl6sIhF7pngcSwrypmk2GhsDXmj16Cz
	lpj2Pmj6A0PywHIj+sm7LrlgO71ItO+WPYZHzVS2SoSzrs0XHzEROECcO3mILZ/r
	FKLkCd+lOQB0kphKk6mW+LsKQBTJeohT3qcTnMtfWl48+47+/2eYn5zbjlBcrjXn
	xfQSqhR/rvs/dt4FKiY3ldux7oOl8cFAQScXJ/psE0iQRveAfFFzCITvW8KpmV0Z
	A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id r_mpiUVacjEe; Tue, 15 Jul 2025 20:11:38 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhVh70vsHzm0yR0;
	Tue, 15 Jul 2025 20:11:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 3/7] block: Modify the blk_crypto_bio_prep() calling convention
Date: Tue, 15 Jul 2025 13:10:51 -0700
Message-ID: <20250715201057.1176740-4-bvanassche@acm.org>
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

Return a bio pointer instead of accepting a struct bio ** argument.
No functionality has been changed.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c            |  3 ++-
 block/blk-crypto-internal.h | 10 +++++-----
 block/blk-crypto.c          | 24 +++++++++++-------------
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdac48aec5ef..2c3c8576aa9b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -626,7 +626,8 @@ static void __submit_bio(struct bio *bio)
 	/* If plug is not used, add new plug here to cache nsecs time. */
 	struct blk_plug plug;
=20
-	if (unlikely(!blk_crypto_bio_prep(&bio)))
+	bio =3D blk_crypto_bio_prep(bio);
+	if (unlikely(!bio))
 		return;
=20
 	blk_start_plug(&plug);
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index ccf6dff6ff6b..e2fd5a3221d3 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -165,12 +165,12 @@ static inline void bio_crypt_do_front_merge(struct =
request *rq,
 #endif
 }
=20
-bool __blk_crypto_bio_prep(struct bio **bio_ptr);
-static inline bool blk_crypto_bio_prep(struct bio **bio_ptr)
+struct bio *__blk_crypto_bio_prep(struct bio *bio);
+static inline struct bio *blk_crypto_bio_prep(struct bio *bio)
 {
-	if (bio_has_crypt_ctx(*bio_ptr))
-		return __blk_crypto_bio_prep(bio_ptr);
-	return true;
+	if (bio_has_crypt_ctx(bio))
+		return __blk_crypto_bio_prep(bio);
+	return bio;
 }
=20
 blk_status_t __blk_crypto_rq_get_keyslot(struct request *rq);
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 4b1ad84d1b5a..84efb65fc51c 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -261,7 +261,7 @@ void __blk_crypto_free_request(struct request *rq)
 /**
  * __blk_crypto_bio_prep - Prepare bio for inline encryption
  *
- * @bio_ptr: pointer to original bio pointer
+ * @bio: bio to be encrypted
  *
  * If the bio crypt context provided for the bio is supported by the und=
erlying
  * device's inline encryption hardware, do nothing.
@@ -271,18 +271,16 @@ void __blk_crypto_free_request(struct request *rq)
  * blk-crypto may choose to split the bio into 2 - the first one that wi=
ll
  * continue to be processed and the second one that will be resubmitted =
via
  * submit_bio_noacct. A bounce bio will be allocated to encrypt the cont=
ents
- * of the aforementioned "first one", and *bio_ptr will be updated to th=
is
- * bounce bio.
+ * of the aforementioned "first one". The pointer to this bio will be re=
turned.
  *
  * Caller must ensure bio has bio_crypt_ctx.
  *
- * Return: true on success; false on error (and bio->bi_status will be s=
et
- *	   appropriately, and bio_endio() will have been called so bio
- *	   submission should abort).
+ * Return: encrypted bio on success or %NULL on error. Additionally, if =
an error
+ *	   occurred, bio->bi_status will be set and bio_endio() will have bee=
n
+ *	   called.
  */
-bool __blk_crypto_bio_prep(struct bio **bio_ptr)
+struct bio *__blk_crypto_bio_prep(struct bio *bio)
 {
-	struct bio *bio =3D *bio_ptr;
 	const struct blk_crypto_key *bc_key =3D bio->bi_crypt_context->bc_key;
=20
 	/* Error if bio has no data. */
@@ -302,12 +300,12 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 	 */
 	if (blk_crypto_config_supported_natively(bio->bi_bdev,
 						 &bc_key->crypto_cfg))
-		return true;
-	if (blk_crypto_fallback_bio_prep(bio_ptr))
-		return true;
+		return bio;
+	if (blk_crypto_fallback_bio_prep(&bio))
+		return bio;
 fail:
-	bio_endio(*bio_ptr);
-	return false;
+	bio_endio(bio);
+	return NULL;
 }
=20
 int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
