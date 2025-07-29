Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DE1474B8
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799705; cv=none; b=Dgm50UgM8vBshFasBFE+725Rpku4uwyCtF+JiqAQ18l+VvsjWo4fPRLpcNJGMOuyV+Hv05ky13LSpOJOQzL2Qrr/LFFwcKfBZlDogBw+vR+aeROk/4VPz7VDVN4uiU0LlTJ8+ejwkergkoDKShDR3wQZdQtWh8+ocH2I5vhmGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799705; c=relaxed/simple;
	bh=LO/Qih6NTK/sIRxryMEcovRm+RP5xOlOOjjiJIeFVJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6B3oe5S2Ij53Fd5e+h/svuFMatlmR1uzjhxpv+2nMthclPigtayMKTzYU6Z5F8Rum4a5CfwYFudIo/6Eh0w6JYnNdeByrnzBtMjbOCljCiBgrGLJcOy8ufdj+dNfsAqthHzxaCzaWl6y4XzwOjXC/8ZEAwglsqNpsivHyjs600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Qy6DsuJx; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Qy6DsuJx"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56T7QjNc020371
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:35:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=D7T1MRjrWaBnmmS+NioKcUuOcWxLurcFJkmlOf3tSpU=; b=Qy6DsuJxmeud
	tOES9mClzWBFDj1aO/Hi+KTWx112KxvxD63H/kD50bUjMP5pgU2DqCCEmfZ4yTfn
	sW9cZzExKMMVM/FxfdYzl8v+tgLGOrql1e/ksZjypgPIPZI1XPWVVq9L2XqjYo/e
	x8auSoBPCIPUL0CKDAcboTJhlcHYiVxXtRololZO0jOUkPFd25iyqYyIixFrBPh7
	3hgXrxpFg6wT0ZLL7bMgejpNLyVImqriK8BkpsfSMaPOcEppb+rTstMkNOshgl0b
	5rSBG6V+LDKx/tvm5zZKCsTlGRvLpPgrLH1HVPAG4HFO733qI0IyAgdJq8ZQQTbD
	pcMvQg/m9g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 486sw62a11-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:35:00 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 14:34:56 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 8CC961CC420C; Tue, 29 Jul 2025 07:34:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 6/7] blk-mq-dma: add support for mapping integrity metadata
Date: Tue, 29 Jul 2025 07:34:41 -0700
Message-ID: <20250729143442.2586575-7-kbusch@meta.com>
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
X-Proofpoint-GUID: 0nvv0D-iiFcqucJIQ7oBl7-OQLNDFY7f
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=6888dc14 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Hk6iwB6CFOrwtQdECcAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMiBTYWx0ZWRfX5aZUXnqJ4Ucw 6xRRnYOkc54H9DyFTyyw2HUlKoP4T1N+i1TTrRd8hsnnzFDITvcwPLWxgWQLru2eWU0L+p43dzE ai+0p62goNeuxlZ7kK/tigeTj4GSAvvUOJFTAfyPennPorg0vnnXM4m1kTSSa6PVfKtGu/W7wmx
 g5+msrF/yTVq82fn1jh8vm6Gl+/ffRw6dNyGnCbunkxmY7wbFvtnQYjkx7XJJgRsGoKiq92wP/M WIaOLNjjYv32yNAQ3Vd3waxBRzFiI2zJdSSve1XzLZqAOLf1ORDYKNvMxJnUdgSWV4uP+VJvKh+ MAvJDtCQO8bxwvcPCy1fqBMeh3N6mmqbXFw/6lpK9szxx1uQehDec4BwjURh1shc0xVEBq27+r+
 dtmC2oqtq72w83FOY8shshNRM28NpyeeQFatLSPKYZgN1KI+SnwdzfIHy0NHBwojhHq9rRrb
X-Proofpoint-ORIG-GUID: 0nvv0D-iiFcqucJIQ7oBl7-OQLNDFY7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Provide integrity metadata helpers equivalent to the data payload
helpers for iterating a request for dma setup.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c            | 54 +++++++++++++++++++++++++++++++----
 include/linux/blk-integrity.h | 17 +++++++++++
 include/linux/blk-mq-dma.h    |  1 +
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 646caa00a0485..708fb6f51efc7 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -2,9 +2,28 @@
 /*
  * Copyright (C) 2025 Christoph Hellwig
  */
+#include <linux/blk-integrity.h>
 #include <linux/blk-mq-dma.h>
 #include "blk.h"
=20
+static bool __blk_map_iter_next(struct blk_map_iter *iter)
+{
+	if (iter->iter.bi_size)
+		return true;
+	if (!iter->bio->bi_next)
+		return false;
+
+	iter->bio =3D iter->bio->bi_next;
+	if (iter->is_integrity) {
+		iter->iter =3D iter->bio->bi_integrity->bip_iter;
+		iter->bvec =3D iter->bio->bi_integrity->bip_vec;
+	} else {
+		iter->iter =3D iter->bio->bi_iter;
+		iter->bvec =3D iter->bio->bi_io_vec;
+	}
+	return true;
+}
+
 static bool blk_map_iter_next(struct request *req, struct blk_map_iter *=
iter)
 {
 	unsigned int max_size;
@@ -31,11 +50,8 @@ static bool blk_map_iter_next(struct request *req, str=
uct blk_map_iter *iter)
 	       (!iter->iter.bi_bvec_done && iter->bio->bi_next)) {
 		struct bio_vec next;
=20
-		if (!iter->iter.bi_size) {
-			iter->bio =3D iter->bio->bi_next;
-			iter->iter =3D iter->bio->bi_iter;
-			iter->bvec =3D iter->bio->bi_io_vec;
-		}
+		if (!__blk_map_iter_next(iter))
+			break;
=20
 		next =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
@@ -178,6 +194,7 @@ bool blk_rq_dma_map_iter_start(struct request *req, s=
truct device *dma_dev,
 		struct dma_iova_state *state, struct blk_dma_iter *iter)
 {
 	iter->iter.iter =3D req->bio->bi_iter;
+	iter->iter.is_integrity =3D false;
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
 		iter->iter.bvec =3D &req->special_vec;
 	else
@@ -218,6 +235,33 @@ bool blk_rq_dma_map_iter_next(struct request *req, s=
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
+	iter->iter.iter =3D req->bio->bi_integrity->bip_iter;
+	iter->iter.bvec =3D req->bio->bi_integrity->bip_vec;
+	iter->iter.is_integrity =3D true;
+	return blk_dma_map_iter_start(req, dma_dev, state, iter, len);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_start);
+
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+               struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	if (!blk_map_iter_next(req, &iter->iter))
+		return false;
+
+	if (iter->p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
+		return blk_dma_map_bus(iter);
+	return blk_dma_map_direct(req, dma_dev, iter);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_next);
+#endif
+
 static inline struct scatterlist *
 blk_next_sg(struct scatterlist **sg, struct scatterlist *sglist)
 {
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index c7eae0bfb013f..1ef0c373297b3 100644
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
+static inline bool blk_rq_integrity_dma_map_iter_start(struct request *r=
eq,
+		struct device *dma_dev,  struct dma_iova_state *state,
+		struct blk_dma_iter *iter)
+{
+	return false;
+}
+static inline bool blk_rq_integrity_dma_map_iter_next(struct request *re=
q,
+		struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	return false;
+}
 static inline struct blk_integrity *bdev_get_integrity(struct block_devi=
ce *b)
 {
 	return NULL;
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index aef8d784952ff..4b7b85f9e23e6 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -11,6 +11,7 @@ struct blk_map_iter {
 	struct bio_vec                  *bvec;
 	struct bvec_iter		iter;
 	struct bio			*bio;
+	bool				is_integrity;
 };
=20
 struct blk_dma_iter {
--=20
2.47.3

