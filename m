Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93A26E70F
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610317; cv=none; b=s91AH4mnUyBX0N70mKmb0YUFOUKmnSBcZf6IZDdX1rKb477+79dxlnQtizUMw4vpBoekX6gWqI/Bb/byifEM7n9nZly00TI55zWup90SIdl7H1w8c4dMs+2CypQtWpj3Pd6BSNrsm1+i+9dfJVfJDb7owI51N2ZR7GVZxG51+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610317; c=relaxed/simple;
	bh=fA1nFPAY2S3AwZ5uw1RK/3eZGGOL63ZpKMZ1oL3CP5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxfXmOkycWQBxz7Hkw+hal7Hk7bDxCt7lWACgXuIp2ehQVXJK2XS17mi8T2Kgnx8yJBXlB4Qe2psNpNCb7Srjnx1sVi3MCuXVYlXSH+zbeOcVEfuiMKMTMNXCDZsXBPFpNXENZDuejOwaMkWTNbwM3rbNAD5PQPIwCgFiJjhW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CWf8oS2n; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CWf8oS2n"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhVhW1w29zm0yMF;
	Tue, 15 Jul 2025 20:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752610314; x=1755202315; bh=Cz9ZQ
	jVbtBQGFsgwyZWsFVpvbDCCERKLmHwEafIVU7c=; b=CWf8oS2nuZMjsJHuMnee4
	bjlYyAiPq2dshCnMpBX5XQvT9b+ltih9Jwo8rDk6NMjCHEdOX2/zLPF8r+g+lXyy
	z3Lbcsp2zwWLZ1FHbhHybXH53TVoCu6TQVjiwr30Vo8ZlD6OF7KeU94m8Q8226kQ
	qeaUp7pKBNj2gKXSP1xVXS+yDPYiYNHLMENai5wlxDNBEmWKhGlUMF/y+n3lQsSP
	Db+4Wen3+oJ1OngU57BHoYgMfJRhafNWAPke+0GhDPINe6G8kZTxGHV5/MQUBYQI
	ue5IidgQKi8vRaAdkadOGU/d6InVX/0m2jrPx9V3JtSwBNl+2mjw3nXhvFnfJM00
	A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DJt6Y3BkN-dd; Tue, 15 Jul 2025 20:11:54 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhVhR0s24zm0jw7;
	Tue, 15 Jul 2025 20:11:50 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 7/7] block, crypto: Remove crypto_bio_split
Date: Tue, 15 Jul 2025 13:10:55 -0700
Message-ID: <20250715201057.1176740-8-bvanassche@acm.org>
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

crypto_bio_split is no longer used since the bio splitting code has been
removed from the crypto fallback code. Hence, also remove crypto_bio_spli=
t.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-crypto-fallback.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index b54ad41e4192..b08e4d89d9a6 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -81,7 +81,6 @@ static struct blk_crypto_fallback_keyslot {
 static struct blk_crypto_profile *blk_crypto_fallback_profile;
 static struct workqueue_struct *blk_crypto_wq;
 static mempool_t *blk_crypto_bounce_page_pool;
-static struct bio_set crypto_bio_split;
=20
 /*
  * This is the key we set when evicting a keyslot. This *should* be the =
all 0's
@@ -528,16 +527,12 @@ static int blk_crypto_fallback_init(void)
=20
 	get_random_bytes(blank_key, sizeof(blank_key));
=20
-	err =3D bioset_init(&crypto_bio_split, 64, 0, 0);
-	if (err)
-		goto out;
-
 	/* Dynamic allocation is needed because of lockdep_register_key(). */
 	blk_crypto_fallback_profile =3D
 		kzalloc(sizeof(*blk_crypto_fallback_profile), GFP_KERNEL);
 	if (!blk_crypto_fallback_profile) {
 		err =3D -ENOMEM;
-		goto fail_free_bioset;
+		goto out;
 	}
=20
 	err =3D blk_crypto_profile_init(blk_crypto_fallback_profile,
@@ -597,8 +592,6 @@ static int blk_crypto_fallback_init(void)
 	blk_crypto_profile_destroy(blk_crypto_fallback_profile);
 fail_free_profile:
 	kfree(blk_crypto_fallback_profile);
-fail_free_bioset:
-	bioset_exit(&crypto_bio_split);
 out:
 	return err;
 }
