Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E33E51FF
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985987; cv=none; b=RDU+/ZydTEqyF4l89Spc79qo9o/M1TOXSM6M9CcsDUmduAH5HmQm49arZH6CLi+4dSbvL2vYaGc5/G/vYqzaJoO65/4CYcAOv8qsqSZXkYdHIqqznILYNzDtvZbBoie+Q1wnU1qRUOv4uL5vqSV3KqDzzWPwU/Nvi+jyj/iv5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985987; c=relaxed/simple;
	bh=Y2iOkaRQioXqhvGIy7EFyWfyHJsE/2Xaf5p1inKEI0c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gaioqPNtsXMJckiZO4hP3F1yr5/NZ8hQ1hFTAjzuNZcmb4HBy+ALXFUhNvLS7H4A8Ck3rwVKHZc0kJq6UlTJV+waTOKDmxayu6aPRTUCmAVOjJvPm7AuXp4rosf01dQqBsgnego8COoJ1ffZ8yE/3zWwQ6XCpeHTj+dPSFwaVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ixy9BEQ/; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ixy9BEQ/"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYXOk766322
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 09:59:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=KfQY57N+Z
	Vdh3GTjbxmJXbcCmrPHyOP6L1IM9BN2GjU=; b=ixy9BEQ/mIMLfRIiaGOglOqN9
	qz/p6pTSL87yVFYFORqgXEmn5u6clAXemai1w9lOPeY1qTtvwT7es+ccsUg6k3Xu
	a6u/p3gfhhSFeFBwPAL1+RdR9J1lM6a9Sk+63hy5gKDnfRj6Bx0Jv+wTi+fNFB7s
	/PUvLfc3OvGR+F2K4HVbMQAJYcUEc0zD/U94fzUqNfRpdQ7XHxHdTGLKhx3CJRS2
	s2N8dfo00VfEgjgLlVDGs2Sps58GmSZofGrxR4IHeAPlPfK+vtlFNK41qFPBp1tC
	jo0aHaNVsftYIdxnXRDTLfBuZm/F6l/HKDJLMAmYQz9UDxdeiNW94hEUNOlwA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g39v5y4qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 09:59:38 -0700 (PDT)
Received: from twshared0879.02.snb2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 17 Aug 2026 16:59:37 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id AF57128540D7B; Mon, 17 Aug 2026 09:59:18 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Eric
 Auger <eauger@redhat.com>
Subject: [PATCH] block: save page offset gaps in cloned bio
Date: Mon, 17 Aug 2026 09:59:08 -0700
Message-ID: <20260817165908.137682-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a833dfa cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=38ogEbHKRlf1QJnteokA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEzMCBTYWx0ZWRfX7EVqiKZGJSMv
 V9pNwRwoPbSuoEeUYLx5KDydO3JA5RTACQNmdHqwSZAzXdsTPB+PTwRWNYlvILbNJd+y6kUWKo1
 c6NbiMCqNt63MWFhCk/okuXgXK2jFAQ=
X-Proofpoint-GUID: VxrIFf0Q4xl838DK0joHVcJRKTbKP2Xi
X-Proofpoint-ORIG-GUID: VxrIFf0Q4xl838DK0joHVcJRKTbKP2Xi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEzMCBTYWx0ZWRfX6LfTTfv/vl32
 32oVs6AG290lvsKHm0pkyYjun9+hjR6oD8njf3OVsErg2BUDKIp8tWMcw2o3naKqdMIEazp6fVW
 LBVK/R5TKJG8gySDfDQoKYh8mNrw0XGx9SEWEbHRp27l0HKgeNEAHa7UJnNdcpX8VPCwkMPtXuO
 MuFU5DikM0vWbPXgZeSoMf9YVF+UTZ/FUfwfIqFMeLaq6CvqHCISPMXjW5e2+oALVmdPoUTek0W
 DE4fPAHTkShlqUTwHsF6GMjtqalobiXRi6bagZO3xjsB3e2TKqq34l6oFy4uACwESo2aAikjG3H
 0ClE+CIXiyiqMFXpLjeUVaw48ghQ6cuqlHVGnMBKlg8HM3zWFLn8Dj/WDi1NxbswsuNspSI+eUl
 2C7pfcQcGseFQTcUuj+mKc47d8z4m6jnwXaHSea1iQSdVgb8Aprd9GMuDhTYQjd6WLbIQ8DWIKD
 IHSO4Fs8yQxk4kwvcrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The cloned bio needs to inherit the accumulated gaps between vectors so
that we can know if this bio can subscribe to the iova coalescing
optimization. The split remainder meanwhile can reset its gaps to 0
since it advanced beyond it and will start accounting from there.

Fixes: 2f6b2565d43c ("block: accumulate memory segment gaps per bio")
Reported-by: Eric Auger <eauger@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 898b2f5ef8c81..33aa439c1bae2 100644
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
@@ -1971,6 +1972,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 		bio_integrity_trim(split);
=20
 	bio_advance(bio, split->bi_iter.bi_size);
+	bio->bi_bvec_gap_bit =3D 0;
=20
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
 		bio_set_flag(split, BIO_TRACE_COMPLETION);
--=20
2.53.0-Meta

