Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E41474B8
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799709; cv=none; b=qODbTUAMD3c4cjvI7lwrSZHVOguJjMxGZYYKbldYCsIFaIj2kYxiJ74kJiCkdCKzZq0haQ7vTgsAccYPmm5D8TtJHOkVIIo7iMJQXkYNBv/MEOBL2t8n2UN04fgL7bsHoNUMDzoY3zJlY5h2Nrh3YRTARKBCJLYGok7pxTYZ8DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799709; c=relaxed/simple;
	bh=h1yAtiIHYUrKfelYwZ/ZDtS0zA/CIW9X1yp5ZJiq8TM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFrivhPARz3JHxCNlVg8JcgTxASBsNM2l5fN/RCxIxf9YTpov8nUylmvKnYiCoQ9ZyZU/zODIJLeIg/JtIv1BFfS8RYZhohjUeoUWQKN6uCJp8RdtlgVGaPwQlkDXZtUlW4aSG4k6GRuUyEz+TAOiwA4KOPD59tHmLd9ymfs75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aygdIhXj; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aygdIhXj"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7R5HU018946
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:35:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uDTpHDyrdZGArIWCxyLrlAqXaszSC3cxOPNvJsnOFUI=; b=aygdIhXjqxJP
	k9gdnMBEVXjgE2D3yDaNxXuaIWzRHihXyxwsM3hRqI6AhDq6tC8kPZnAa4HLi5Xv
	4YlSO9T8VN89lS/ZuLuiefG22VK+zUKQqmHlFTEXJnFCHUP/d/shRy/2rYrZ8lMI
	pdFXWasnjrpKflvC1t/ZERr2S6vQ61o16nMottrIxt97m/C88AEMZ5ksFZjlSTqh
	ZKIeJRhUA0dz+WpCV8LyTbX2Sd68OPne2do77Q8D03emZsiQDCOA+1LRCYKIfuyU
	tjG29loKYPioQjnN4KCyAobaXEgv3xeYNjvs7J2HO9H4DVCkrnXVcVo7foKIf0Hd
	fxp8HnJ7lA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 486swmja4t-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:35:06 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 14:34:57 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 94EFF1CC41FE; Tue, 29 Jul 2025 07:34:45 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/7] blk-mq-dma: provide the bio_vec list being iterated
Date: Tue, 29 Jul 2025 07:34:37 -0700
Message-ID: <20250729143442.2586575-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729143442.2586575-1-kbusch@meta.com>
References: <20250729143442.2586575-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KZHSsRYD c=1 sm=1 tr=0 ts=6888dc1a cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=V_F5WBpg3us9ROv35IkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMiBTYWx0ZWRfX/W3PT2qbq1lC Ixmju9RxZ9mp8L3H7lbydKmJr2+x0aO8scHPJ30F0Wm4FGccM/o4pJAueXIPliEI13ZnsTJP3FE pMWVLGUW37gohb1o/ovcveC3/ugHzwKagAHHMml00FlF6kB8a/X1p+x4/QIpO9FgIxr0VkLlfm5
 hv8TXaMyyKqT07VqtdBDd+fuECMltszHJ1/Ewgd31hePdc/Ho348NGwbTq05SBFZfu/QYP2bQ8D UhAef7zBMoZip61bKbuWTsZ+L7kz6O2jXXwwJRWLg6lWO+alpF8y4RNlvATTrr0E1P9P8+TTh/w NiJTFvcxXrMe+Ab3oRcHeFUmK9pGMFWwlMzQaQ6voBOD4CT8jI/UL5BiJljuqs3K6tfiVoesiGs
 YzmpfmEsUr7kcsBSbMrvuj6adfrrWJd3GdiZSpePujbWAshP0SiLylpPCGwvFWBWGmS2OYeI
X-Proofpoint-ORIG-GUID: OVOyIAiGUNlidK5unvfiyBqEtxlkd0K2
X-Proofpoint-GUID: OVOyIAiGUNlidK5unvfiyBqEtxlkd0K2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This will make it easier to add different sources of the bvec table,
like for upcoming integrity support, rather than assume to use the bio's
bi_io_vec. It also makes iterating "special" payloads more in common
with iterating normal payloads.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c         | 30 ++++++++++++++++--------------
 include/linux/blk-mq-dma.h |  1 +
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 61fbdb715220f..08ce66175a7a3 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -10,23 +10,17 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_map_iter *iter)
 	unsigned int max_size;
 	struct bio_vec bv;
=20
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		if (!iter->bio)
-			return false;
-		iter->paddr =3D bvec_phys(&req->special_vec);
-		iter->len =3D req->special_vec.bv_len;
-		iter->bio =3D NULL;
-		return true;
-	}
-
 	if (!iter->iter.bi_size)
 		return false;
=20
-	bv =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+	bv =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 	iter->paddr =3D bvec_phys(&bv);
 	max_size =3D get_max_segment_size(&req->q->limits, iter->paddr, UINT_MA=
X);
 	bv.bv_len =3D min(bv.bv_len, max_size);
-	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
+	bvec_iter_advance_single(iter->bvec, &iter->iter, bv.bv_len);
+
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+		return true;
=20
 	/*
 	 * If we are entirely done with this bi_io_vec entry, check if the next
@@ -40,15 +34,16 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_map_iter *iter)
 		if (!iter->iter.bi_size) {
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
 	iter->len =3D bv.bv_len;
@@ -151,6 +146,11 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
struct device *dma_dev,
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+		iter->iter.bvec =3D &req->special_vec;
+	else
+		iter->iter.bvec =3D req->bio->bi_io_vec;
+
 	/*
 	 * Grab the first segment ASAP because we'll need it to check for P2P
 	 * transfers.
@@ -244,8 +244,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatt=
erlist *sglist,
 	int nsegs =3D 0;
=20
 	/* the internal flush request may not have bio attached */
-	if (bio)
+	if (bio) {
 		iter.iter =3D bio->bi_iter;
+		iter.bvec =3D bio->bi_io_vec;
+	}
=20
 	while (blk_map_iter_next(rq, &iter)) {
 		*last_sg =3D blk_next_sg(last_sg, sglist);
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 1e5988afdb978..c82f880dee914 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -8,6 +8,7 @@
 struct blk_map_iter {
 	phys_addr_t			paddr;
 	u32				len;
+	struct bio_vec                  *bvec;
 	struct bvec_iter		iter;
 	struct bio			*bio;
 };
--=20
2.47.3

