Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791983B813F
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154598; cv=none; b=f3CehIpFTUsE/mUnANR2lEKGZkYDOJcqH/0LdE6Do9pGgMuSEl3i3PwTh02UISXOZ6fnZzh0NB7YtNbdXcjnqH15fdf6ZOdNT8Fuzec21iBKasp/wiWtu7Z8vtQjDm9Dahk6oBsUiIzAc+qDaFkHgsJjDdAN8VYJZmpd5TMaL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154598; c=relaxed/simple;
	bh=/7HxhyxXUtqcMU0kxmrAf8OoClQnOKbPVmJTWmnVYuc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ps88wJRyNokBkhExyhi7feo06H1fptsCYb5PMAe8Hp7h1isZVu0+B6M/qXFRKHTAQYlsatXbygWdBFQ840ShGaVe9T/AiNmwhU7rlEZ5hr/o3XuEcv6OOBfIpicBc+KqQXzVXV8eqCBV2UkAa4C7TrNqmL+etUv7KpCwgjWwn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SndFh+ME; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SndFh+ME"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67JFXEwL1957342
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 08:49:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=AREJhPCUJ
	sQ1ZLXETLlea3AhmmQ6LviLpC1PbUvwqsY=; b=SndFh+MEZ0ogF28+6fUS5o6KR
	wxR7VBxXRRywKttTcRHZyL5/3nUyzC1qancFdLlM1RBrViX5aWuqof8AYEkwysUk
	y6nwN/HOMnVYmJzTb9zjPdDXzosazqWut4Ec2nFp6+DLEVc3UoOaKV4i5qjco0PZ
	pFGRu0vrvzOKVqe05DDW8iPVSDMVNY7iTsrTZu+yCxrRDgDdem/KIPrcyJ+AKRkF
	rVBEoQxT7w51m4olSZTrZqh3KwUhvvOpMB0mj/H+z2C3AkPyQhdib8nIL9YCdUzh
	M1Lq369LOpu8+6pmwHzZEmlBcFOj5fvHIjUoJIs0ah1Zah27nKsIzigigphsA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4g4yfjwq6g-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 08:49:55 -0700 (PDT)
Received: from twshared22248.02.snb1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 19 Aug 2026 15:49:52 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 034DC28892F8D; Wed, 19 Aug 2026 08:49:38 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Eric
 Auger <eauger@redhat.com>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCHv2] block: save page offset gaps in cloned bio
Date: Wed, 19 Aug 2026 08:49:37 -0700
Message-ID: <20260819154937.3903312-1-kbusch@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEyMyBTYWx0ZWRfX4Dzk6b8tu3Wp
 qIyTUtPAyvgepkD2baDoKiBOpWtk1dO2Kpn3jmhbuUQY/zKfVqGtAbqZcH1VE3VvgqJm5Gsi9Yd
 jSy6LlJJ3wCaoD15oaz/j/e2DfvSJe3Hsn1SRsG/q+3oiERVolCph+Se2OgltTvpILkuNipPmp+
 +8gi9LDmZQCXPM5ZGd1IOCrrjIUMl6iwp4TKLyzUtjkhEaXJ51kPm7P4EvWImgenCHnH5RTuh46
 4jMoqUAlxwiEzOsqUMkDozMoBzeVG8ta1ZxYrZah+fpmOncgbG1vaC96Dop4JEselXRi/qUc/Xg
 4coYhg463/iZq8IojWsf9+d7r/pBFjV8rhefGNme6l6Ugczj3ENfpogoTkbHXd/zScMCTFcK+tU
 rBNhmftqGC76h6UAjYfPo6fjSfxM9XXPYlCn7RfoiSqPfWg81Q0SxZHqMTfMb6IrpXGnp0/+z9l
 FbFa/RDG+a1BxqzHjiA==
X-Proofpoint-ORIG-GUID: 48C9I_dDgp5--bFdIPjtIWVFI9JHge7x
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEyMyBTYWx0ZWRfXzwpvmMWV5HIy
 dkXHSPtHy2nP95d+CAVfsJb5w9aH6qeuNAbXEUhcS0HevMiO8y8rnFf/bxmWNz3UEOXgfsVRxsf
 f3suWNvdQHVcarCoWjcwEK7ua2/g3no=
X-Proofpoint-GUID: 48C9I_dDgp5--bFdIPjtIWVFI9JHge7x
X-Authority-Analysis: v=2.4 cv=XZG5Co55 c=1 sm=1 tr=0 ts=6a85d0a3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=xMx9eJq75iw932m43aMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The cloned bio needs to inherit the accumulated gaps between vectors so
that we can know if this bio can subscribe to the iova coalescing
optimization.

When cloning for a split, the gap only applies to the front bio since
that's as far as has been processed. The remaining bio can reset its
gaps to 0 since it advanced past the checked vectors, and will start its
accounting from there on the next split check.

Fixes: 2f6b2565d43c ("block: accumulate memory segment gaps per bio")
Reported-by: Eric Auger <eauger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:
  Added code comment explaining the reinitialization, and a more clear
  change log.

 block/bio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 898b2f5ef8c81..f95b63c0604af 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -859,6 +859,7 @@ static int __bio_clone(struct bio *bio, struct bio *b=
io_src, gfp_t gfp)
 	bio->bi_ioprio =3D bio_src->bi_ioprio;
 	bio->bi_write_hint =3D bio_src->bi_write_hint;
 	bio->bi_write_stream =3D bio_src->bi_write_stream;
+	bio->bi_bvec_gap_bit =3D bio_src->bi_bvec_gap_bit;
 	bio->bi_iter =3D bio_src->bi_iter;
 	bio->bi_io_vec =3D bio_src->bi_io_vec;
=20
@@ -1972,6 +1973,14 @@ struct bio *bio_split(struct bio *bio, int sectors=
,
=20
 	bio_advance(bio, split->bi_iter.bi_size);
=20
+	/*
+	 * The gap bit is set when splitting to limits and only applies to the
+	 * front bio that was split off. The remaining bio will calcualte its
+	 * gap value when it is subsequently split to limits, so it is safe to
+	 * re-initialize the value back to 0.
+	 */
+	bio->bi_bvec_gap_bit =3D 0;
+
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
 		bio_set_flag(split, BIO_TRACE_COMPLETION);
=20
--=20
2.53.0-Meta

