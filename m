Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEF263C8C;
	Wed, 23 Apr 2025 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376615; cv=none; b=aVyrE4qZg300lGIfHlO9Y1bhUdW1QnokDj+gcpMHvVrUN0oZfj92rArTZKK15vAFIAuSydAPPPMu1CTxiBCNv8sapF1rvLeiXaoPKxCSK6y9bZ/khOMvhJmtl4pRCsb5hGdbQucuPJj5Osj4PjJ06aOO5FJSl7zsJuf/NjDvidQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376615; c=relaxed/simple;
	bh=O4yPbNBaYFoNwQKOXxtrIJpWTe+WoiDQpV/8tZmutZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WAHRaFXMOFzj2mXyKuH0ROe4Q20inSudxhiX2u8i0F3JzEGJ6dnHgXvhoWGdJGe5LT4je1w0vWNb+JyJqD+c1A/y0NiLQdVlayf8yuDfmDcJKsp9vU+L/htNZVmNUYClaIxH7N/dEAUJI2/uKsrIov8kuajXZPlq9XFcqjZx5cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a8055cf61fed11f0a216b1d71e6e1362-20250423
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:11a8d7b1-49d3-47a3-be11-ac6ee2574613,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:6eeaac85ebf38b026436a2303d6455f7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a8055cf61fed11f0a216b1d71e6e1362-20250423
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1467068272; Wed, 23 Apr 2025 10:50:03 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 4564516003841;
	Wed, 23 Apr 2025 10:50:03 +0800 (CST)
X-ns-mid: postfix-6808555B-151785318
Received: from localhost.localdomain (unknown [10.42.20.206])
	by node4.com.cn (NSMail) with ESMTPA id D8C1A16003840;
	Wed, 23 Apr 2025 02:50:02 +0000 (UTC)
From: tanzheng <tanzheng@kylinos.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tanzheng <tanzheng@kylinos.cn>
Subject: [PATCH v1] block: Fix bio complete cannot be traced
Date: Wed, 23 Apr 2025 10:49:59 +0800
Message-Id: <20250423024959.2051923-1-tanzheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now all bio that enters bio_endio through blk_update_request
and blk_mq_end_request_batch will not be traced because the
BIO_TRACE_COMPLETION flag has been cleared before entering
bio_endio.

To fix it, BIO_TRACE_COMPLETION needs to be cleared after bio_endio.

Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
---
 block/blk-mq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae8494d88897..17c19eaf8f1e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -876,13 +876,14 @@ static void blk_complete_request(struct request *re=
q)
 	do {
 		struct bio *next =3D bio->bi_next;
=20
-		/* Completion has already been traced */
-		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
-
 		blk_zone_update_request_bio(req, bio);
=20
 		if (!is_flush)
 			bio_endio(bio);
+
+		/* Completion has already been traced */
+		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
+
 		bio =3D next;
 	} while (bio);
=20
@@ -969,8 +970,6 @@ bool blk_update_request(struct request *req, blk_stat=
us_t error,
 			bio->bi_status =3D BLK_STS_IOERR;
 		}
=20
-		/* Completion has already been traced */
-		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
 		if (unlikely(quiet))
 			bio_set_flag(bio, BIO_QUIET);
=20
@@ -983,6 +982,9 @@ bool blk_update_request(struct request *req, blk_stat=
us_t error,
 				bio_endio(bio);
 		}
=20
+		/* Completion has already been traced */
+		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
+
 		total_bytes +=3D bio_bytes;
 		nr_bytes -=3D bio_bytes;
=20
--=20
2.25.1

