Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFA22EF2A2
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254378; cv=none; b=SaXMtYzWJuFzjsN3KQznlfkup2Yn/l3p6w6OlisPNHQd/GujCqVrgah6DocZNdRvwJSlT4Lm+jJwv2EtXKszmPHq+KUfglWkRLZ8M/Zqg1c4sn0ijEOO7UL2IcqybO4YhFf0kTrkDOdUo3q2ysFfJoc1MpAJfJon9AboCBm9TFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254378; c=relaxed/simple;
	bh=pFo08NITXg3KWexlJnJLBXHaPYWDJlI2vsGxUEXNS3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiHEYcxIYrnC+VvG7si4UqBfsRMaKQV7FEgk6okOx2FDgxUqzBaZl8nyx1T9ZFqgohrD5ckf1CvInIp3zbb3izSW6A0UE5Fj0vOiXKdsjZ/j98h6ZxvMUyePNZI6Vw8nf71ApwgV8lMF+wngmT9qbHQUffiQQC+l8cbG5zoYhqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=BsVJxNmx; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="BsVJxNmx"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bdz3Q3qMgzm174x;
	Fri, 11 Jul 2025 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752254369; x=1754846370; bh=i6CKQ
	+tNXU9lCRb3pbxbW2GwJA2JGlY4oVgKDq4FOvI=; b=BsVJxNmxaKYx8LoSoeHcc
	U+pxNIlbhE3qzDi4YNRac+QWd+S3ebsN4P/Wr2Ylh8OSMeT90wud8VV93RFujEkC
	B8G2sV4AwwNCgpByPjLyF5CWyxgUL/hM950WE4pgUfv8MWx+UuFNbJOGNLWjhrSX
	oi8z1QVt3XdSftw1CY/D5N9s1cJw8JBW4Zr9dRzxWTORuFHC/ldSzzJ+lecnJ7uS
	GklWjN0eyIx8+2XL8/DfBy7ndj3fRy3CxE6rnj9vwJqZ2Fb+NwTMdka3qzb0VLnC
	jGB3k42C4i63CogTAiicEjyEY4gcQn9MFZqCwfkL9OPLoxPMiImQ4MXumzbPoSqB
	A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id g0VgbvhS63tF; Fri, 11 Jul 2025 17:19:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bdz3L30KVzm174W;
	Fri, 11 Jul 2025 17:19:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 1/2] block: Split blk_crypto_fallback_split_bio_if_needed()
Date: Fri, 11 Jul 2025 10:18:51 -0700
Message-ID: <20250711171853.68596-2-bvanassche@acm.org>
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

Prepare for calling blk_crypto_max_io_size() from the bio splitting code.
No functionality has been changed.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-crypto-fallback.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 005c9157ffb3..0f127230215b 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -209,9 +209,13 @@ blk_crypto_fallback_alloc_cipher_req(struct blk_cryp=
to_keyslot *slot,
 	return true;
 }
=20
-static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr=
)
+/*
+ * The encryption fallback code allocates bounce pages individually. Thi=
s limits
+ * the bio size supported by the encryption fallback code. This function
+ * calculates the upper limit for the bio size.
+ */
+static unsigned int blk_crypto_max_io_size(struct bio *bio)
 {
-	struct bio *bio =3D *bio_ptr;
 	unsigned int i =3D 0;
 	unsigned int num_sectors =3D 0;
 	struct bio_vec bv;
@@ -222,6 +226,16 @@ static bool blk_crypto_fallback_split_bio_if_needed(=
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
