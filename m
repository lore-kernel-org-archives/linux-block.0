Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C41D1300
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725044046; cv=none; b=H8uvs7efXyMpdfrMbJDnhVUs0dBWM0QeJSuKsgrWLptPbWLghHskghL3c3b6H6SKy9Cg7oL/uo7diHtVzHC6rXH+V6lLoVY6wMeKfkJI1Oy1so6bxDwuZa9YxYAkQhyxnyKCHhpbgysvYP6Kft75iV9uHgUuAMwLJsMWaKY/tOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725044046; c=relaxed/simple;
	bh=JeNjB6hgA9IABOt/+dyLmtxEn5pWDtZrr3fos8J5MOY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YzuS0D/eEuFN6DhUnn/OUCH4uG4nAtEzw8/RnY0UdZtAfQE/s704enIUdWEeYpJ3bnz2Z4PGRhVv5X5SRZP+ZGtq9VdAbJCru24DPQrsIQsKcAqUdSRQ1FzYmbAtbgmJuEuZrpoJ2xnrmeQMmUyPYrfp1bEtXd3fwcL0n4V9i/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Ykwmx0cY; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Ykwmx0cY"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 47UIDWNu013620
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 11:54:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=TJl
	o4sCFS+VvSF6qVOtc0ykonsjafWuShGtVy2abv6U=; b=Ykwmx0cYOTSmnLBr92m
	nLqBqCtKYaedeNn3tJD8/tFR7RysoOf5KKhU904C7n1+O9L0QO3gdiqxXY428P6n
	UgWUPyr/i+SSNfp7wY8HFpN5/tvLR0cthxGlShYKCQxLBgD1s/QJSzhBHnQpLAAi
	yDsyqK35mRg8AT8h3dNsAp9BQTMpj3HvbJ8kofVaTqf6EVTFwegQBet9qTgO3Q+c
	8jS6oO3tCvbiSuJULBAeoAZnpRcur5x7aO7pycyae14EQmJujVKUtD1gPkzFOjgg
	c5vXQp2HZgl2kA1xj5L1KIxSRweNi+lNd3rbAv0E/MhYTHaTqS2RT5s947lpTNIU
	wrg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41b1vydyrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 11:54:03 -0700 (PDT)
Received: from twshared19529.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 30 Aug 2024 18:54:01 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id E797A126F3B75; Fri, 30 Aug 2024 11:53:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] blk-mq: set the nr_integrity_segments from bio
Date: Fri, 30 Aug 2024 11:53:45 -0700
Message-ID: <20240830185345.3696027-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FOccY93Np3oMrDw5ZZcznx8cL6OjFvD0
X-Proofpoint-GUID: FOccY93Np3oMrDw5ZZcznx8cL6OjFvD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

This value is used for potential merging later.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 36abbaefe3874..56bcb599d8660 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2546,6 +2546,9 @@ static void blk_mq_bio_to_request(struct request *r=
q, struct bio *bio,
 	rq->__sector =3D bio->bi_iter.bi_sector;
 	rq->write_hint =3D bio->bi_write_hint;
 	blk_rq_bio_prep(rq, bio, nr_segs);
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	rq->nr_integrity_segments =3D blk_rq_count_integrity_sg(rq->q, bio);
+#endif
=20
 	/* This can't fail, since GFP_NOIO includes __GFP_DIRECT_RECLAIM. */
 	err =3D blk_crypto_rq_bio_prep(rq, bio, GFP_NOIO);
--=20
2.43.5

