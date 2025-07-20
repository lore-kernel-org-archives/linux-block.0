Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543A217730
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037048; cv=none; b=Bcu6H9gztCZzYHN+8O9tsBuTJLCmZybBfazwdWFyH5EwBvYposDfaupTqY3mzWxARMxsWvEKhmNjJKceuglEU3MIfCHlU8cVbuHKVOvstQvqf7haU860cJOc94RenskQLAOFuhU/63ZblKhqiCSWLAJpFj4+6PtbJ0RMtrVfA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037048; c=relaxed/simple;
	bh=DCOdFoRugpTvhudOpneasFGPSYc/QObE/kRuCcXxcbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esOq/R2GA3Xk+/hAwppONNFbEaykVZ2nHKeYTU0G1Z+OxdwyWqIdn/cb92XSN3lB3eVf9YqSvUY2ZN1pobviXwUYk5v2QWn9UHgvqOktGnaNZ5uEaDUk/Au4u+AwPp7VZ08Qazshe/kagmR+28Llg6A98efkX8HhGzFnE8sLdSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=keZj57qE; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="keZj57qE"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KIDkmi024222
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:44:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Q97T54siiB+AnzZHMhBNhEFizu8K5aTXy2koOH8+ooI=; b=keZj57qEwkoi
	jz+nofxSCueN8nHWWaTO3dPSsF9t2RNM//llPnSwumZE6JTSDLtZvnUlonobSx5C
	+XgCML+uuy2u3ex0VsveLmSN6ihCyz7K3T+I5fOekLQaLmPFCI40fo/2wrS+/sSf
	GJd+D5m0By6QqaGlosRGvmfUTtNYIg3cRDeQMAKzeqZoYHKz3Mnb4rvJ0S5ykJuR
	8eFQcIiwY/13EpDbypvqGTMCHQrUHLwNnyWOFpmWtrvtp090Sbvql6ArqgiDJ0ZR
	SWiU9LPRf0BBzJEw0tnSs+CjuN4NB98Y6goAVnpdamBuGrowfcqAJB7mxZE4Us6K
	p/zzX+tGjQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4815hs02a0-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:44:05 -0700 (PDT)
Received: from twshared78382.04.prn6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:44:03 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 56BF2178C798; Sun, 20 Jul 2025 11:40:50 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 6/7] blk-mq-dma: add support for mapping integrity metadata
Date: Sun, 20 Jul 2025 11:40:39 -0700
Message-ID: <20250720184040.2402790-7-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=N8QpF39B c=1 sm=1 tr=0 ts=687d38f5 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=vMGUKEoAC2i4v1bJTHIA:9
X-Proofpoint-GUID: KC3KT5GPtpRQLizz6xOmb2D6XhmxVSlS
X-Proofpoint-ORIG-GUID: KC3KT5GPtpRQLizz6xOmb2D6XhmxVSlS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfX/zfaXYkk5kTk 3Z3GsMA8nj2BKfZZ6fFzqyDDcimO9hSbSnFQryXsnpeKSibD8yrtqzzHBJmg+OV3OagSvfSHC4h hlK3getv9eEIhDvIRSxt5p52IdYfceZxBUNyZJ+Xlk5aNoDqT2666BdwpRxhRVS21dUX4onhsiZ
 xxUK0Yjw03oYs7shDLlWwJVEigCFadZZxJyne39vZgvJ0wxCOxk8j0OMWz6wGDAHIr+O9kqnMNe 8JnIbaqgjM54hRkW/T8PE03/7D3JNtgIvz0bGZjeILeVsACHJzOpkbIGrH0FAN+7wqVlPS+hRFg rV/JlS+Zx3+M39gpeetEL9U7oBMLxSwq3Y007bkLkgnmMROJa08uahK++Bd1nNRRgzJmasyoTuD
 VgmVriFc4JWbQq1F5V/6midsii5rYIVxAo1Iex8tBNv2v1ShI5D3AVYSQA9mHMSqwHRBpAIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Provide integrity metadata helpers equivalent to the data payload
helpers for iterating a request for dma setup.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c            | 58 ++++++++++++++++++++++++++++++-----
 include/linux/blk-integrity.h | 17 ++++++++++
 include/linux/blk-mq-dma.h    |  1 +
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 1e2e93c1cf5e2..a4ae043e2cd72 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2025 Christoph Hellwig
  */
+#include <linux/blk-integrity.h>
 #include <linux/blk-mq-dma.h>
 #include "blk.h"
=20
@@ -10,6 +11,24 @@ struct phys_vec {
 	u32		len;
 };
=20
+static bool blk_dma_iter_next(struct blk_dma_iter *iter)
+{
+	if (iter->iter.bi_size)
+		return true;
+	if (!iter->bio->bi_next)
+		return false;
+
+	iter->bio =3D iter->bio->bi_next;
+	if (iter->integrity) {
+		iter->iter =3D iter->bio->bi_integrity->bip_iter;
+		iter->bvec =3D iter->bio->bi_integrity->bip_vec;
+	} else {
+		iter->iter =3D iter->bio->bi_iter;
+		iter->bvec =3D iter->bio->bi_io_vec;
+	}
+	return true;
+}
+
 static bool blk_map_iter_next(struct request *req, struct blk_dma_iter *=
iter,
 			      struct phys_vec *vec)
 {
@@ -36,13 +55,8 @@ static bool blk_map_iter_next(struct request *req, str=
uct blk_dma_iter *iter,
 	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
 		struct bio_vec next;
=20
-		if (!iter->iter.bi_size) {
-			if (!iter->bio->bi_next)
-				break;
-			iter->bio =3D iter->bio->bi_next;
-			iter->iter =3D iter->bio->bi_iter;
-			iter->bvec =3D iter->bio->bi_io_vec;
-		}
+		if (!blk_dma_iter_next(iter))
+			break;
=20
 		next =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
@@ -185,6 +199,7 @@ bool blk_rq_dma_map_iter_start(struct request *req, s=
truct device *dma_dev,
 		struct dma_iova_state *state, struct blk_dma_iter *iter)
 {
 	iter->iter =3D req->bio->bi_iter;
+	iter->integrity =3D false;
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
 		iter->bvec =3D &req->special_vec;
 	else
@@ -227,6 +242,35 @@ bool blk_rq_dma_map_iter_next(struct request *req, s=
truct device *dma_dev,
 }
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_next);
=20
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev,  struct dma_iova_state *state,
+		struct blk_dma_iter *iter)
+{
+	unsigned len =3D bio_integrity_bytes(&req->q->limits.integrity,
+					   blk_rq_sectors(req));
+	iter->iter =3D req->bio->bi_integrity->bip_iter;
+	iter->bvec =3D req->bio->bi_integrity->bip_vec;
+	iter->integrity =3D true;
+	return blk_dma_map_iter_start(req, dma_dev, state, iter, len);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_start);
+
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+               struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	struct phys_vec vec;
+
+	if (!blk_map_iter_next(req, iter, &vec))
+		return false;
+
+	if (iter->p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
+		return blk_dma_map_bus(iter, &vec);
+	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_next);
+#endif
+
 static inline struct scatterlist *
 blk_next_sg(struct scatterlist **sg, struct scatterlist *sglist)
 {
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index c7eae0bfb013f..d66ba850bb2a5 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -4,6 +4,7 @@
=20
 #include <linux/blk-mq.h>
 #include <linux/bio-integrity.h>
+#include <linux/blk-mq-dma.h>
=20
 struct request;
=20
@@ -29,6 +30,11 @@ int blk_rq_map_integrity_sg(struct request *, struct s=
catterlist *);
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes);
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev,  struct dma_iova_state *state,
+		struct blk_dma_iter *iter);
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter);
=20
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
@@ -108,6 +114,17 @@ static inline int blk_rq_integrity_map_user(struct r=
equest *rq,
 {
 	return -EINVAL;
 }
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev,  struct dma_iova_state *state,
+		struct blk_dma_iter *iter)
+{
+	return false;
+}
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	return false;
+}
 static inline struct blk_integrity *bdev_get_integrity(struct block_devi=
ce *b)
 {
 	return NULL;
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index cdbaacc3db065..8b06659bf67dd 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -18,6 +18,7 @@ struct blk_dma_iter {
 	struct bvec_iter		iter;
 	struct bio			*bio;
 	struct pci_p2pdma_map_state	p2pdma;
+	bool				integrity;
 };
=20
 bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_d=
ev,
--=20
2.47.1

