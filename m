Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD171F7580
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895015; cv=none; b=uNN8TyBIA0gmIgiiuGxQLAB6toa1vvGCLbEbYisreJYtdrJ5Os2uuI9HNNT3/lz3ls5CDWi3P3VA46t3VgPVdKw04LH80kREJCnxRyihVrvw3Rzwz5GfMgQfoWxkWBW3GM+DMCKYIBBoJV3Bv0Ck8GN3tAMzULZ/KKyBoVVGRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895015; c=relaxed/simple;
	bh=3KL8ArKlzLgrCQicCEE18KqP4iXzb+9FZJXhVYtMcyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFCmEWtoGhIZ8qI2b25ZxBRblXU0gtKWnbwDfBhAfgJfv5gJGaWTn1I3upnkSAT+gEh7QUcf4Jg0tE2LoxOtPri/+sIcT9+k2+UDIpsE4u7ONojYFR5Qg1AaKlO5ALMc/c6Fqw79xa+g+w1Mpl92zAixro4ogD8MQ6hLkL7KAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zjp+p63g; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zjp+p63g"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bSJKw5FPpzm0pK0;
	Wed, 25 Jun 2025 23:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1750895011; x=1753487012; bh=drmSj
	6xImpcJy1ZxK4mBh0+VR4B3c+wIhbUgrIQkxaU=; b=zjp+p63gdE0IHnC1zv3OV
	f1q6hNjW2DcMDSRv+R6iiA67yDgjaORoOhVcUD7wNgTJVN071wK24vbAMIFkBoIf
	+dv2oFBfz8c9UYLETlJr+mo9QLxijUAwi1fknCI4NIYgV3xp6KQvXdLdyXdR41a5
	zr9HyKR0wwt8R4paCkNCPsCMAi05yId98k6Eyhxz1g5vf+wNQ22bauvqYL8pxAXw
	0dvzChKpBzhCh+amx1dEzhs8Fz0Nl5KwCMLg2pXnJ1KD4HQOheok6trOzxhsTCAc
	JpoJIC9JnSZ/4/EIpNwTuVgEdQiQhpoEGVicNyfW1iaAovBthuXX8HVVDsx6jQHh
	g==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 98lUt9hF7jLL; Wed, 25 Jun 2025 23:43:31 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bSJKp1dxHzm0pKb;
	Wed, 25 Jun 2025 23:43:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Keith Busch <kbusch@kernel.org>,
	Christop Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/3] block: Split blk_crypto_fallback_split_bio_if_needed()
Date: Wed, 25 Jun 2025 16:42:57 -0700
Message-ID: <20250625234259.1985366-2-bvanassche@acm.org>
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

Prepare for calling blk_crypto_max_io_size() from the bio splitting code.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-crypto-fallback.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 005c9157ffb3..323f59b91a8f 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -209,9 +209,12 @@ blk_crypto_fallback_alloc_cipher_req(struct blk_cryp=
to_keyslot *slot,
 	return true;
 }
=20
-static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr=
)
+/*
+ * The encryption fallback code allocates bounce pages individually. Hen=
ce this
+ * function that calculates an upper limit for the bio size.
+ */
+static unsigned int blk_crypto_max_io_size(struct bio *bio)
 {
-	struct bio *bio =3D *bio_ptr;
 	unsigned int i =3D 0;
 	unsigned int num_sectors =3D 0;
 	struct bio_vec bv;
@@ -222,6 +225,16 @@ static bool blk_crypto_fallback_split_bio_if_needed(=
struct bio **bio_ptr)
 		if (++i =3D=3D BIO_MAX_VECS)
 			break;
 	}
+
+	return num_sectors;
+}
+
+static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr=
)
+{
+	struct bio *bio =3D *bio_ptr;
+	unsigned int num_sectors;
+
+	num_sectors =3D blk_crypto_max_io_size(bio);
 	if (num_sectors < bio_sectors(bio)) {
 		struct bio *split_bio;
=20
