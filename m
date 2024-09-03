Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453411D5CC0
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390818; cv=none; b=U/gnSinUVj7n4MlwDvvTOVXrvNVfWwiUQVF/XHwVFFlvv4g6a5iFZuq+4VM3zC8p3dl2vtJ8dzc9LektdyMCduka/S9zWUjy8D4PlvazwYh0mDMcjvUqSto99z1zSclraq8RB20RViyOpTagH33IlYEepzbt+4Y4V/mX8M0Jups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390818; c=relaxed/simple;
	bh=feSGCbeCgJksAVn2sT2r7Puy+Y+IKOeukvPFz2Iu6K0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eXPfWp7GewDtOiO5h2SOq1penOcRZW/LF8OvIf5B2M1Pq1w/Lab9uQ7JsYB3A75HpODn27Rk10CD4vZ+auhEgiDZFgZHW6YLTVqcy3vIF/bVnysZYLk2JBIEP9ragI1Wmiof7MK9DM0Wd8w3Oj8Bjei9ySImMEHSS7dlKYyOf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XbKKZejF; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XbKKZejF"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483GP8Oe007850
	for <linux-block@vger.kernel.org>; Tue, 3 Sep 2024 12:13:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=FN4
	nYuhRpzQNHKHCY2wtdQhlqEQk7YCSEAveNVok+1w=; b=XbKKZejF9o4BwKrsLwF
	v5mxz42bVTZv2bopka6sgJK3lGVJODT15ZCzOAJc8Qu4lRor8Jmw5mGFx/YcbUMC
	976bOhZDlqx8dK4MoJUg9SaJ9WvzDK/E+3fa/k0qrTO3bGUZ8xixqXvqYd3jIfn7
	RvtcYgjj23BkHWss89pWp36SkriARY5fRrwm8h8QYqK4EVdzRVT+rdIdS5VLhZrW
	XgP6IR86EbVco2AGE6VserpibhV/o7IFYnim1LCsKf8eFvvPKl3PwPwSK338Ai2i
	hpqpkCFVIrOi3ZKFp2ztAu3xeQKMbEi1VVc8hqw1TgK+jsxoPanbbzbhJ86V5i2P
	N4A==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41e5y5s9qq-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 12:13:36 -0700 (PDT)
Received: from twshared10900.35.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 3 Sep 2024 19:13:33 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A756E12979360; Tue,  3 Sep 2024 12:13:30 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] blk-mq: set the nr_integrity_segments from bio
Date: Tue, 3 Sep 2024 12:13:25 -0700
Message-ID: <20240903191325.3642403-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: d0e8OpHawBtkQQXL2lFyB5lQwgRhl-79
X-Proofpoint-GUID: d0e8OpHawBtkQQXL2lFyB5lQwgRhl-79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_07,2024-09-03_01,2024-09-02_01

From: Keith Busch <kbusch@kernel.org>

This value is used for potential merging later.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

Check the bio actually has integrity before counting the segments. I
previously tested v1 with additional experimental patches atop that
addressed the problem differently and didn't notice the obvious API
requirement.

 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 36abbaefe3874..3ed5181c75610 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2546,6 +2546,10 @@ static void blk_mq_bio_to_request(struct request *=
rq, struct bio *bio,
 	rq->__sector =3D bio->bi_iter.bi_sector;
 	rq->write_hint =3D bio->bi_write_hint;
 	blk_rq_bio_prep(rq, bio, nr_segs);
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	if (bio->bi_opf & REQ_INTEGRITY)
+		rq->nr_integrity_segments =3D blk_rq_count_integrity_sg(rq->q, bio);
+#endif
=20
 	/* This can't fail, since GFP_NOIO includes __GFP_DIRECT_RECLAIM. */
 	err =3D blk_crypto_rq_bio_prep(rq, bio, GFP_NOIO);
--=20
2.43.5

