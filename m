Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59965239E70
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869994; cv=none; b=Bsm9n6TIMBAEZuNC1h0FbqD4c513oOhHZMzCKIlFzGNqKrPkJ6iZ6VeMFPkEEP5q4ANobEWSAfaEFBLsxkK19jndjs+w9RLTimHEuBzi91za2qz4oEPLFKuJN4m6ui1C4yYzZZHjYmUelUvpo+NBl5+oI1y3NcGU9dxVPaYmASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869994; c=relaxed/simple;
	bh=+si8862ou1F9T1BAmoGHFYD+SieE5gMBf5QWZrz2WnQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jg1AtgA+gSacD/rlx5KzxPSr/I9Iw7ZuXYH4ICcgmT+M50FG6qFUb1J1JESDjf8KrUo27Ozq0j9PMYQVTbrOnVKzkWuY7WfSK4HsLLp0Ayn2GUPgUuBZmw5KfMIMPGLCq3N4wjv7AUSDRUANgO9WL52D0396ASj0c3P8pC9viH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Fw+S+wUL; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Fw+S+wUL"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB7STj41282287
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 06:06:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=7/isxsudFFhOWwsRwQ
	3DNbcI6iye8MVCV01lphqHFHg=; b=Fw+S+wULWjEyDVoJD6IqGlwAl23NbcbEif
	okPewDDaYvmzKVmCber5xEIcp8dr2iBa6y9R0Hzp/RUUu7EiqT37C01WO2YGe/Uj
	kWSJzrPow+hZeYg/tm2G1LoKk/Ij2ZvfNGK5Vd61PCbm+UgSziDfaXTn+HZ5965v
	Lhm6i9u4XaVqkpoKWYeU5X8vAVFw+6kIInrLTciKWEUiSjsUwonjPenPl8uCkwcN
	z8ycumceRlReyTun5IyuoAqQWrfdtV0SLhaYZ4kFKgEknkymOs3E8MEADGVArL6O
	LWCbWUijulcpsUENgCQAAFUAZmmDreuMsnTfINRs17YWTrN+wsow==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac0sha2su-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 06:06:32 -0800 (PST)
Received: from twshared22445.03.snb1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 14:06:31 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 15F0E3A7E68B; Tue, 11 Nov 2025 06:06:22 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yukuai@fnnas.com>, Keith Busch <kbusch@kernel.org>,
        Matthew Wilcox
	<willy@infradead.org>
Subject: [PATCH] block: fix merging data-less bios
Date: Tue, 11 Nov 2025 06:06:20 -0800
Message-ID: <20251111140620.2606536-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=Pf/yRyhd c=1 sm=1 tr=0 ts=691342e8 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=upPtVoU741YgZzhtDMoA:9 a=zZCYzV9kfG8A:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: LcpbBNm1L6EOTvjrALBWqiZz4cCQShHc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExMyBTYWx0ZWRfX8G8oeXXKiGaG
 lDuj0qnuLFenltcSDTuhIi2/A+sxscBcKZva+kDirGl71+MGO/wf3r9HzyPKc/d6GrNx6Maxb0b
 Q+sPBFxZG7pXtIduPlO9IBfDxHDxbZFk/nXfUjMgW+FsNG/yLwgqno7HHk/3WhAGR/DHhTp0+94
 MuS0I2AKSAEZLW5OgYIitSmlbsruceQH16T8SuA8HoANEVWopnJ23BiVKRMse9vO6yy9F5dArne
 qrAiJhnqMnmLddZ1ylZcFxG3toBz7FbJGedA2Z/uJouFmbtVcrRQtUl9nygsOLz0hN+ji8DvLKJ
 WSZIH/zgeL5qhdt2CcIb8iM0wpyhS8pE8D+/9BgK9ATENMvkE6Er5r+eBIFnf74VH6/8tnNOnJt
 Yp/ZhiJV8B+P4ymVczvrDrk4Yzq6YQ==
X-Proofpoint-ORIG-GUID: LcpbBNm1L6EOTvjrALBWqiZz4cCQShHc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The data segment gaps the block layer tracks doesn't apply to bio's that
don't have data. Skip calculating this to fix a NULL pointer access.

Fixes: 2f6b2565d43cdb5 ("block: accumulate memory segment gaps per bio")
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-merge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3ca6fbf8b7870..d3115d7469df0 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -737,6 +737,9 @@ u8 bio_seg_gap(struct request_queue *q, struct bio *p=
rev, struct bio *next,
 {
 	struct bio_vec pb, nb;
=20
+	if (!bio_has_data(prev))
+		return 0;
+
 	gaps_bit =3D min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
 	gaps_bit =3D min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
=20
--=20
2.47.3

