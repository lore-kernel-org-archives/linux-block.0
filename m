Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D9924168D
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403093; cv=none; b=OWdIVF0FfWo4u7ATzp3v4r+oIVh/wsQJwvfnCN3dyIW0LqjwogrkeNUXGXbNqneurivl+CVI+7q1xff4pzG99lhsueH409YfZR/rsm4hRq6TH1HvPraKjMpBJP/+4EYVOq0XjWOSCBWdh2xrHc4IfRzmqmAZ9ZO2dJtSUHBUtNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403093; c=relaxed/simple;
	bh=X4TiQRCAyimCy235Rs2X/10FtaUcKM3owhi+6iQOMAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zuxuu1EYyy+bScneP52nxSvZ4Oj5K6O5h7nirGo+5yC157TeLDE+ruqO9tnEd6f1qHlIRs+43TL+jNNGB5obPb5dlDI+Kt8MltxPat+a0bTeXmwZo6BapctzEkWWgPn4hwYAI/YKLKQFqve7Gx1V0eQsQw/yUEL0c9z26G8sEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hkR2yLPu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hkR2yLPu"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYPkw027939
	for <linux-block@vger.kernel.org>; Tue, 5 Aug 2025 07:11:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=47Zm63PeojXkiJDTke1e+5K+CoKyN+QOtXjqL/eR4fI=; b=hkR2yLPuXL3c
	T4OJWpbtm0y6QaoX8srv/czAM5dXwaTUXGqfSfq7O4ijp3RhwkLuJ1FlAMibpsn1
	9twetMALR3ujiphrmmIkLNJZmGsJqJLzS/dybmEgxfvopSWHoirWgMSZljGBm5Lw
	t/mDsVZvg6XBtS3YWppCeIvrxGeG+rDaLDyxneZ8iok5fhxYu5WmqqA/o3jB7tGs
	DhGAl4kDQRwe+6FDpCFkAR3EBhSwtLijL2DgcfCNAMjUBKawOBdmq2x9xvOu9at4
	pi7NT8w+8pyovgjLlXyjgJ0mkXl2/GvCbl2HxRnQY1SNM2XaV3vMon5dDZ9mUBEB
	JjOFq9T2KA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48b9033jak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 07:11:30 -0700 (PDT)
Received: from twshared42488.16.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 041A14FDD55; Tue,  5 Aug 2025 07:11:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>
Subject: [PATCHv2 6/7] blk-integrity: use simpler alignment check
Date: Tue, 5 Aug 2025 07:11:22 -0700
Message-ID: <20250805141123.332298-7-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250805141123.332298-1-kbusch@meta.com>
References: <20250805141123.332298-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H5Pbw/Yi c=1 sm=1 tr=0 ts=68921112 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yetF5jY7WHH6jeiS1L0A:9
X-Proofpoint-GUID: gOYrL1DWcPmjlxrj3t9hB4m1TLmqSEz4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfX4OKY8WXPCLCt pu9k15pgLln142wmkWSwv9fOrfvApTIZnORP0Z3Dx/X8thL56M2qCHM5UPBiJwK5lH8Sn+wTfUh 3U3sC3CgNdMH9yWw8LI5B2aocwy5XUSKqXlPIpH/twnpsYnveMXQlJ5UfDeLgT/lspZA4Lx/oOO
 SWHNnKVrjjO9R4XLmRwRZYfuE9ykDfm3YaZrP7pz1ra92K4GoMq9qoTPzBhKTa8wr/W+fXtsMoL YHYxIxTI61c/QO9M+Gl5Uejg5BmNByP6MbZLwqUUv2QE3vf13PX24riI0OhEVSxOqYDM++brHvg QI0G2gF4tRWTlLHCkSDyuFykhOHyaAGGeskZ/fCDA+SJNqKlHU+B1VphPuRTosygrABrjNTSZAQ
 i5i0CrEq5QdiDLDCo+78bmWYAQU5HrqJSyaFbaYx+W8IwHEHgtlXuGe85UVhx9vyTxdd8st+
X-Proofpoint-ORIG-GUID: gOYrL1DWcPmjlxrj3t9hB4m1TLmqSEz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We're checking length and addresses against the same alignment value, so
use the more simple iterator check.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/bio-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b077ca937f6b..6d069a49b4aad 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -262,7 +262,6 @@ static unsigned int bvec_from_pages(struct bio_vec *b=
vec, struct page **pages,
 int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 {
 	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
-	unsigned int align =3D blk_lim_dma_alignment_and_pad(&q->limits);
 	struct page *stack_pages[UIO_FASTIOV], **pages =3D stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec =3D stack_vec;
 	size_t offset, bytes =3D iter->count;
@@ -285,7 +284,8 @@ int bio_integrity_map_user(struct bio *bio, struct io=
v_iter *iter)
 		pages =3D NULL;
 	}
=20
-	copy =3D !iov_iter_is_aligned(iter, align, align);
+	copy =3D iov_iter_alignment(iter) &
+			blk_lim_dma_alignment_and_pad(&q->limits);
 	ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs, 0, &offset=
);
 	if (unlikely(ret < 0))
 		goto free_bvec;
--=20
2.47.3

