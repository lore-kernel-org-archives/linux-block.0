Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E0224B00
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037045; cv=none; b=tNzHspw/W+3bZq2bUlQs/+7/ORQy0BFfQNxYYtVEFyCVdtbLe9vAP7pDPoyM6LL2JGY25g9nbabSJy4Ow9RmdySkyl63EaPvSsjoOxLwgxp9GrNzh7tRCLb7RuFz8ivNmtM7QLrO5+7++D+sF4Li2DKFQOurSbywjvLKTqHNxeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037045; c=relaxed/simple;
	bh=1abtvD5FbKakktSL+WPnGdTLxidYGCjBUSNps1Z11Og=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVy1mCBZtspY45x8dazPCA1gsJ3WrSuqi8RaALzwDtUSpsorMcxuWvxEFNEVGT7in+ZLTEwSBTJoit9nQHxexe19o7ES0FN2zDboKTo8i7W7W2vPRolAFGNj3QtUxABBzsgx3QiFDkS+fk5vqo5ejInrxnOlIUf/V4gUhQv/DqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BHeboMS/; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BHeboMS/"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KIDkmd024222
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:44:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=jeyMdkxr71mHi8iQN2D6FmqIkrzOMSAyTu2jwc1kH6M=; b=BHeboMS/iGej
	biwoCs068ioe0H4ATqU6HRM9Bf8PkDTWD78hOgaKUfXIyEhzw7318AgRlT5iSXpd
	qQoqxHtqvI9YkHlEw6tqQPeHp8sB5aAKo3VnJcKTFlR3okGXjIN3qgFnjfM4YRfV
	tnThVNChgrGQ8oso+zkCmpw0cVs9HxHlCz5Q4AJZw5m8DOgg1yofpFMRc6p3lL5M
	Vnje4WTzpIt3OpVO/kNcJ+5tZNoFoQFt1I8YC96Svpx8jWfj3/lnfLH9pT9fDZdh
	WA0ErbC0UTXKO62R+LgtHUmjMcoiu40jHc9w+wGYNb9GcgjWdRPVimKq5zJOegxW
	h1k2w0DX8A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4815hs02a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:44:02 -0700 (PDT)
Received: from twshared28243.32.prn2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:44:01 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id A1F08178C78E; Sun, 20 Jul 2025 11:40:49 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/7] blk-mq-dma: set the bvec being iterated
Date: Sun, 20 Jul 2025 11:40:35 -0700
Message-ID: <20250720184040.2402790-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250720184040.2402790-1-kbusch@meta.com>
References: <20250720184040.2402790-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=N8QpF39B c=1 sm=1 tr=0 ts=687d38f2 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Ra2a7VNcXYI1eJqiBM4A:9
X-Proofpoint-GUID: iYd8jrX30ZtL0rxBSWDRVEU7CErgP-gH
X-Proofpoint-ORIG-GUID: iYd8jrX30ZtL0rxBSWDRVEU7CErgP-gH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfX4SGY5o0XObPs RH5htKnAhqFmdkKtLW9kSJeVG0dJi6x1EhidvIbyDWbw1cNTFetIO2r6hLLMzzirQOusq3d4Lnm uoohIO1yeVvj7y5hH6UnsFtWfUtzuZvOqOJQADVP++Rfko19yDO0VyV4rS+9WdkuMqxDXgFVkex
 P9V4wgzwL8Yq1/Euer8tcVJ7JOG67uS3S4iA7w1fBQTwzeytGbG2OZzc13GAoR4J/lFNUqttE3H rYBZzQVCfruKwv8Y6QjBNmz7cEgOy/7lclHon0vhI2Uim3i+7EDMNcsGwagBvlJr0yNVjVzf93k gSyc4dqs1W01PzJoOpVIL5IYJ+D8KT8ixm25d+dsr9LPKRt3HCT7D306i+djiWC9f1AdCmNQvm7
 mqw06xIZwjbRbVeeus1atdzI9Cy4bOEHg5WrEeyif2Nbln+TtJHm6tSFUywVbiBiuD0C/TFE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This will make it easier to add different bvec sources, like for
upcoming integrity support. It also makes iterating "special" payloads
more common with iterating normal data bi_io_vecs.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c         | 30 ++++++++++++++++--------------
 include/linux/blk-mq-dma.h |  1 +
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 21da3d8941b23..7f3ad162b8ff2 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -16,23 +16,17 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_dma_iter *iter,
 	unsigned int max_size;
 	struct bio_vec bv;
=20
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		if (!iter->bio)
-			return false;
-		vec->paddr =3D bvec_phys(&req->special_vec);
-		vec->len =3D req->special_vec.bv_len;
-		iter->bio =3D NULL;
-		return true;
-	}
-
 	if (!iter->iter.bi_size)
 		return false;
=20
-	bv =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+	bv =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 	vec->paddr =3D bvec_phys(&bv);
 	max_size =3D get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX=
);
 	bv.bv_len =3D min(bv.bv_len, max_size);
-	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
+	bvec_iter_advance_single(iter->bvec, &iter->iter, bv.bv_len);
+
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+		return true;
=20
 	/*
 	 * If we are entirely done with this bi_io_vec entry, check if the next
@@ -47,15 +41,16 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_dma_iter *iter,
 				break;
 			iter->bio =3D iter->bio->bi_next;
 			iter->iter =3D iter->bio->bi_iter;
+			iter->bvec =3D iter->bio->bi_io_vec;
 		}
=20
-		next =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+		next =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
 		    !biovec_phys_mergeable(req->q, &bv, &next))
 			break;
=20
 		bv.bv_len +=3D next.bv_len;
-		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
+		bvec_iter_advance_single(iter->bvec, &iter->iter, next.bv_len);
 	}
=20
 	vec->len =3D bv.bv_len;
@@ -158,6 +153,11 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
struct device *dma_dev,
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+		iter->bvec =3D &req->special_vec;
+	else
+		iter->bvec =3D req->bio->bi_io_vec;
+
 	/*
 	 * Grab the first segment ASAP because we'll need it to check for P2P
 	 * transfers.
@@ -253,8 +253,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatt=
erlist *sglist,
 	int nsegs =3D 0;
=20
 	/* the internal flush request may not have bio attached */
-	if (iter.bio)
+	if (iter.bio) {
 		iter.iter =3D iter.bio->bi_iter;
+		iter.bvec =3D iter.bio->bi_io_vec;
+	}
=20
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		*last_sg =3D blk_next_sg(last_sg, sglist);
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index e1c01ba1e2e58..c2cf74be6a3d6 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -14,6 +14,7 @@ struct blk_dma_iter {
 	blk_status_t			status;
=20
 	/* Internal to blk_rq_dma_map_iter_* */
+	struct bio_vec			*bvec;
 	struct bvec_iter		iter;
 	struct bio			*bio;
 	struct pci_p2pdma_map_state	p2pdma;
--=20
2.47.1

