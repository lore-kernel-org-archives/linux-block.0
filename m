Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955733123D
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303554; cv=none; b=DSsS1rfEvh9J6s9z/Fkml4Axl1O20H9Lop+ldwcM1cCO0EEXSBrCIXwWUqiId9mG5Uh6A1GRE0EZLFJBQfDlkLrlFvRfFqp5B1dOip/lEXwwFWGWu290yszNgHPee3vZGMbXjdwbzWrhuGs7ojtML+8Gw1m0h8+9uhgjJiPtxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303554; c=relaxed/simple;
	bh=bzbbCgHkNEcseBDUWGHIHQKhW2uEnvW+s4w8mQgh5Pg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ag9eyTvyIG2pF0kVUcVivg7gTRNPR0lKqXFgpEBYmRd1U7bTDxxzugeYJVZ7VUf6AZckRsFA8hqUrJkZJ9TMJO7UITnu5FRpkjtf9oRxKpFJcspiH9GyZy+35BCx8Tdc+nUbqnASAlsKYxUlIirCYx54/183MB+4Etv1DRqprHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=n2Rmy187; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="n2Rmy187"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CLecGh2381163
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 15:32:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=euhFA5V8dxNsiTCGW/
	4Wb2ZOVCrP5g+1huE0YqjBXJI=; b=n2Rmy187HDX8f/QnOxkoV2l18/55N+Try1
	SwYuA1lnTStVt6jahFwSQmzmwiMiX2SI3x76OqKtGPE1MZseENzJ5HVBaOgeMv/T
	47i0CcIQ76Ds+X0u5CKYjJs+5n7dZ7LerwVdx3jgX3Nd3HU8wW49wk3sM1S3aHZa
	0+I0ctBky/tLa0xZAGY69ti+58L9a44sfdYlDYCbTqfZLrJK2hbUwrlcq10iiYDn
	QRC832b5+7uvOkpmmfGflgmd2zcfyOy00V2HQzRAGMtmo+SXjxHiiXFZAJ6wnTyO
	htlXRBfq3qBOK8iYL1OIwM+vkuV76sX1V1egmMcaXtZnyE5M71LA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ermg1jtfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 15:32:32 -0700 (PDT)
Received: from twshared21870.02.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 12 Jun 2026 22:32:19 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 07E0B227FA6A3; Fri, 12 Jun 2026 15:32:14 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Carlos Maiolino
	<cem@kernel.org>
Subject: [PATCH] block: check bio split for unaligned bvec
Date: Fri, 12 Jun 2026 15:32:04 -0700
Message-ID: <20260612223205.465913-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fzg73cR60QpvdhFIj9TYRwtacVMSrXGI
X-Proofpoint-ORIG-GUID: fzg73cR60QpvdhFIj9TYRwtacVMSrXGI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDIxNCBTYWx0ZWRfX44r+qD/2J8n5
 ntPdhL97LEvo9CILo/b2k4cZ/yzdBAhm69YPWThNcHQ6pk6ky8Oagw0+c1RcMIPOabCgLrQqtxM
 xnzy3juK8YvLsBDJ2gHHkjj1bvSJhzY=
X-Authority-Analysis: v=2.4 cv=U/Oiy+ru c=1 sm=1 tr=0 ts=6a2c8900 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=KC3CPbxw_Nr-F8MmkwIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDIxNCBTYWx0ZWRfX29Dix+gMPKCb
 z0m6vtxeffY4ZpkcLyb/Jt2JGFFYzmsR780zYMNPfuofs6oVpRVR9mEoo8b1HCVE3vkDHKV/bqJ
 jiRLfYwqbPMST5Q8KUuujcKE+iWMjIdNeDFWG9DVlpMO06iHvbeujOCZ98FQiEOvjuqqUlUNLTd
 4yPzs+7VBbRqxdmHmHT/IkX/UIMfsFAIsBj1SM7Gm/xaP6SnqW1aJIRDx64dMuwyn57Q4J5tx5Z
 J5E3weYrpC23pU38niPENOVEpyiWpNmE3laACkIIaVVQR9eE35QU1POVo74XUUXBgWYJ2SdXwzD
 /294IVZduiBNV5xO6Dk4SgpCMHt7p+MLnI0o9UHjOtTFpf1IoJQkLsH89/Ei04uwuwgW3OlNFXg
 H4/M7G/wRxQjycZtiGe5iZIhQpWAv/mkHQUsWaqXErz/Q4u1NdK1355QMlDR2VFxf/8cGODXaRD
 0IxKySFRU6SOO5EG3fA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_03,2026-06-12_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Offsets and lengths need to be validated against the dma alignment. This
check was skipped for sufficiently a small bio with a single bvec, which
may allow an invalid request dispatched to the driver. Force the
validation for an unaligned bvec by forcing the bio split path that
handles this condition.

Fixes: 7eac33186957 ("iomap: simplify direct io validity check")
Fixes: 5ff3f74e145a ("block: simplify direct io validity check")
Reported-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 1a2d9101bba04..004048fa0c5a8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -404,6 +404,8 @@ static inline bool bio_may_need_split(struct bio *bio=
,
 	bv =3D __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
 	if (bio->bi_iter.bi_size > bv->bv_len - bio->bi_iter.bi_bvec_done)
 		return true;
+	if ((bv->bv_offset | bv->bv_len) & lim->dma_alignment)
+		return true;
 	return bv->bv_len + bv->bv_offset > lim->max_fast_segment_size;
 }
=20
--=20
2.52.0

