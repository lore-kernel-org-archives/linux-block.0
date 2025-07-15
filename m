Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653086337
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610292; cv=none; b=mW+oYDCc1Q4rIRpP/QoICOL5eq8YjszjN3LAQoUzWyheYrTYqBa1lBbqAP85ITW5eC7y8vWeg2TxP6xxv4eQCgZJ+1RckqxTnETV2rsMWEPySjDu0SyO9yCSyljWkCJzFQxVOZoVXAUJfnFu6dGYYWZ1skvxQ9upU3s75aYR0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610292; c=relaxed/simple;
	bh=KfVPHOT3Fn3eOght75VOh6CV/G0LlksSRQ+0HQ1TDdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRiPZGpIXtJFJxlCU4xeIGuI2X5jkDiMWfXAMEF+JhlgML30CQGulH9zUKKpu96bhbDAJSCtqvhxq4QkU25lWtPn+4wVCtiGNoZzMocsnDJA3jIgCzY69clcI+Zx4xPrs0QuCF91yWgoKFiyLAkMPr2w4IWSDlKXJOjDL1F7Pxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HyhXLTTr; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HyhXLTTr"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhVh223GBzm174N;
	Tue, 15 Jul 2025 20:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1752610288; x=1755202289; bh=IeKfs
	8zKIo/ReUgwPqf1LdskhNNcVJg36BYB+y2qvbI=; b=HyhXLTTrpEeIF9Vxsg4/V
	ThTqZG2BVvLjz7tH/AwGKZLBCJ2uc8drvxr2ezyNLwEwLVxrKWwnXYhY8Ms952rj
	ubJAeIJ9FIVnvY7Ng/bL/IGFUt6ZxN7VbSrnYqX+8yyMRhxLOiAKCq3CkvmJrrbU
	pcKkxEfESkSQFsQEXcqPKFO8pNJg4NvZH9SifwLVdAdozNyH6jiayEnAWo2wSsKO
	5ZB5A+LmvsLBSyzoojJQJHdImXNYhdO/j7tgHx151xQQrVpaW4jJ3+MF8ybyLzDF
	kH1sgbx/gJN/PAc4XlrAEh7Z/e20ex8gy4aadmjlWJM+sYS3mcDPGbX55I0zJ/nn
	A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Qfs-nLxnZWOw; Tue, 15 Jul 2025 20:11:28 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhVgw3hPvzm0ySR;
	Tue, 15 Jul 2025 20:11:23 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH v3 1/7] block: Improve blk_crypto_fallback_split_bio_if_needed()
Date: Tue, 15 Jul 2025 13:10:49 -0700
Message-ID: <20250715201057.1176740-2-bvanassche@acm.org>
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

Remove the assumption that bv_len is a multiple of 512 bytes since this i=
s
not guaranteed by the block layer. This assumption may cause this functio=
n
to return a smaller value than it should. This is harmless from a
correctness point of view but may result in suboptimal performance.

Note: unsigned int is sufficient for num_bytes since bio_for_each_segment=
()
yields at most one page per iteration and since PAGE_SIZE * BIO_MAX_VECS
fits in an unsigned int.

Suggested-by: John Garry <john.g.garry@oracle.com>
Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-crypto-fallback.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 005c9157ffb3..3c914d2c054f 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -213,15 +213,16 @@ static bool blk_crypto_fallback_split_bio_if_needed=
(struct bio **bio_ptr)
 {
 	struct bio *bio =3D *bio_ptr;
 	unsigned int i =3D 0;
-	unsigned int num_sectors =3D 0;
+	unsigned int num_bytes =3D 0, num_sectors;
 	struct bio_vec bv;
 	struct bvec_iter iter;
=20
 	bio_for_each_segment(bv, bio, iter) {
-		num_sectors +=3D bv.bv_len >> SECTOR_SHIFT;
+		num_bytes +=3D bv.bv_len;
 		if (++i =3D=3D BIO_MAX_VECS)
 			break;
 	}
+	num_sectors =3D num_bytes >> SECTOR_SHIFT;
 	if (num_sectors < bio_sectors(bio)) {
 		struct bio *split_bio;
=20
