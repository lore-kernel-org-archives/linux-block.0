Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3737886337
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610299; cv=none; b=T5f5gUjlCTThMeIOrc3m0mskwCj0/jDX8dr1ghOOkK67+31rCNXjIwWVaGJpixQ7SOZNlb6VmZk/Ea5c+P1I8DmfVDbIoFIDtfYAOk+OiKYMRdWlsLujOf6T5NRYRtLqxpBEpTeLVgdFSaz9areF06ABIdkeDi8ejA/U0GtyJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610299; c=relaxed/simple;
	bh=RBnuEVK92zREGdEQoEgkStZS7Ho3hp6LaqQC2ZM0UbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISND3Jhy0E+c0vSUbt7rWh46QzElwqmsYwWNMhEMj090za8u6mRSgRrjfIqge2yScvlaPf0Fl6hYMsR0RClatgvTbuQBR8AktUfWguhMRKE+tp137xkSojHZ3tgHzBY6a1nI2qRDOjE/6sCdhvWUdS5zWj+rT/tsM/OyO2Q6d40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ajbh+BNd; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ajbh+BNd"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhVh71pRqzm174N;
	Tue, 15 Jul 2025 20:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752610293; x=1755202294; bh=Oaj8A
	a0JTLV2L10lYfaRrYAcHa4J0ENpmX55dyLhs0E=; b=ajbh+BNdghLDjDpNm2/bv
	GV4xAxkB+U0CO0taeHt2QHt0rulwyIUngAkR4tAB8CfDnIK7z0JnHcgdwRScL7XS
	uH/h5KOMa+CFHCBXo+UkN+wa2odLYj00/0jw0vA06h/nJF4DswkDn8OrCkma3BDP
	giv/9hBmbqbmuswgfPWce0aE9GknQyS7rh3jE8HtLN2tYt55dUAjVHcq61FLsA0r
	ZsJrtA1BSc7QDRqt9JKQw8cLSnlO+/Q2Qoulo9A/uIxOeBgfUcwCCJdodVbOapya
	lkgfmwtRuJ7AqUGHuoeAPbEmxSk22Q2ga/SmJaXF26DNDWp0hwGEzO19RM2Jerg1
	A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yrueYCsOndEz; Tue, 15 Jul 2025 20:11:33 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhVh15x43zm174M;
	Tue, 15 Jul 2025 20:11:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 2/7] block: Split blk_crypto_fallback_split_bio_if_needed()
Date: Tue, 15 Jul 2025 13:10:50 -0700
Message-ID: <20250715201057.1176740-3-bvanassche@acm.org>
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

Prepare for calling blk_crypto_max_io_size() from the bio splitting code.
No functionality has been changed.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-crypto-fallback.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 3c914d2c054f..98bba0cf89cc 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -209,11 +209,15 @@ blk_crypto_fallback_alloc_cipher_req(struct blk_cry=
pto_keyslot *slot,
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
-	unsigned int num_bytes =3D 0, num_sectors;
+	unsigned int num_bytes =3D 0;
 	struct bio_vec bv;
 	struct bvec_iter iter;
=20
@@ -222,7 +226,14 @@ static bool blk_crypto_fallback_split_bio_if_needed(=
struct bio **bio_ptr)
 		if (++i =3D=3D BIO_MAX_VECS)
 			break;
 	}
-	num_sectors =3D num_bytes >> SECTOR_SHIFT;
+	return num_bytes >> SECTOR_SHIFT;
+}
+
+static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr=
)
+{
+	struct bio *bio =3D *bio_ptr;
+	unsigned int num_sectors =3D blk_crypto_max_io_size(bio);
+
 	if (num_sectors < bio_sectors(bio)) {
 		struct bio *split_bio;
=20
