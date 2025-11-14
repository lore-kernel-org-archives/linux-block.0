Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471827E066
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145119; cv=none; b=SuY6ZinluSOBhxqicUuA0NYThPbuWzcX0OHOoSIXXB9EVgrwBvHKFZG6v5U6ukkW7HfhhKchjM4yOYqVf+b3MKw/ZRzez6i8IaOypp9qj2snQTx77aQJvt4psHEC5IAV9HoPvrUOX3+ZOGr1TCXTRJj4h22ZP73gSm1rgfpeBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145119; c=relaxed/simple;
	bh=aMCkvHP40uRZdkExq4Q/mdmYLEC/bxodpGVHy5KMAvc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AJiNCNE6xNFd/en+20DIhgE9OvlSWdFpjH3G4U3iIPH7fPDsqsZAHFwPeiVJEha+hhtkRwsJVD8zBdysH4o5YCVJ7VUFWUMhk4SQTzOzEEOUap5pY9o/wKdHU2wjSeh4+ktBtHs51Q6ESOXUIw6OAJSZ2lCp6CPoLhct7jcWFnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DPDm2vek; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DPDm2vek"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5AECBBpS3794482
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 10:31:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=+i65Bybqh3tzhztRSy
	3LoecpOu42G+2xuZaorHy+OGA=; b=DPDm2vekqcmxb3JKTTQWqHgyWGTEGQtwwF
	0RKXoLQiTM/JajetZPhCDnjuJzpzb0EuSItJ2298dY46nbaPRu79yXoAAcn7VRZm
	4V0KKYcbS6nFLYJRQOSIHpaT2bX1WyWzHdT+SnaqDPnECHpxY6OnVjqmbDXZDhUV
	dvhGhJ0RSiP4739EMXAOq8cpfA/QArsPm9Nx0NtuSquZv0XkrpJvRJQZ8xSTyA2U
	ns6DNjfqPSRgdW+UPopP7eNrDgq6JRWS5xaVG0fh2y9L1dfQFHAXPD2VbX6tI627
	6Of0W1atG/96uluPrVSQXOEZ0ElePPCs4pN2opjEYh3nqSM8kIbA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4ae476asur-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 10:31:56 -0800 (PST)
Received: from twshared31947.34.frc3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Fri, 14 Nov 2025 18:31:51 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 49AE63C6D85B; Fri, 14 Nov 2025 10:31:46 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: consider discard merge last
Date: Fri, 14 Nov 2025 10:31:45 -0800
Message-ID: <20251114183145.519913-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hnFaED6_4r_Nx1csOg_fQksEYNKCybY3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDE0OSBTYWx0ZWRfX48X4BzJzeFR9
 VUpQUeYTYGUY8oxxKaRYaggSl+xosMlKtvgIvmTm8Fmj1rWCM+LzCCnp8bCRIW3cnaTl5APvtnF
 8B3z3kx2JCW2NtGPgdTmi0+NBIJjC/GUztuW1lADg8Dd+V1GWNIzwS2vNUzRrgAWvERSGko7jiW
 LpwNp2JUQ/eQniz7QZev6w6sFz0yi328g8vencPc6F1nStDEbOXXJ5SuQLsdHPVGcFSshoN4bwi
 GKCECBpEwql7E4M4b+8Dmv44Xez9mZubiy0PfZjdItk5xnOAH1TphEHze97xZxnVm8GlW8oJJ2/
 f1guvc/1UZq+F4D8dMoFkeGeNCkVsJM9HPPdNPd9FL24YjTp+9dSxX23SXFYSzrj4EXMsUpvUJ1
 rmxbnc1Fb3Uo8p70hkbEFdq23fcO5A==
X-Authority-Analysis: v=2.4 cv=JbSxbEKV c=1 sm=1 tr=0 ts=6917759c cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=TxlfCqywItWwZHMmrIkA:9
X-Proofpoint-GUID: hnFaED6_4r_Nx1csOg_fQksEYNKCybY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

If the next discard range is contiguous with the current range being
considered, it's cheaper to expand the current range than to append an
additional bio.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-merge.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index d3115d7469df0..db08bc9060916 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -712,10 +712,10 @@ static void blk_account_io_merge_request(struct req=
uest *req)
 static enum elv_merge blk_try_req_merge(struct request *req,
 					struct request *next)
 {
-	if (blk_discard_mergable(req))
-		return ELEVATOR_DISCARD_MERGE;
-	else if (blk_rq_pos(req) + blk_rq_sectors(req) =3D=3D blk_rq_pos(next))
+	if (blk_rq_pos(req) + blk_rq_sectors(req) =3D=3D blk_rq_pos(next))
 		return ELEVATOR_BACK_MERGE;
+	else if (blk_discard_mergable(req))
+		return ELEVATOR_DISCARD_MERGE;
=20
 	return ELEVATOR_NO_MERGE;
 }
@@ -903,12 +903,12 @@ bool blk_rq_merge_ok(struct request *rq, struct bio=
 *bio)
=20
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
-	if (blk_discard_mergable(rq))
-		return ELEVATOR_DISCARD_MERGE;
-	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D bio->bi_iter.bi_sec=
tor)
+	if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
 	else if (blk_rq_pos(rq) - bio_sectors(bio) =3D=3D bio->bi_iter.bi_secto=
r)
 		return ELEVATOR_FRONT_MERGE;
+	else if (blk_discard_mergable(rq))
+		return ELEVATOR_DISCARD_MERGE;
 	return ELEVATOR_NO_MERGE;
 }
=20
--=20
2.47.3

