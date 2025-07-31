Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D6EAC6
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974327; cv=none; b=Km4Bvrdqfjr6AlHDj/J3apcGKcZ4+snqu9BlsUNUkc732mft1x+95MvR6gExNwpCnXfDRZQb9TkJDG1zdIwbfBbsednF+gP4pwJtLF6GprGusI7U5Mywb+9OGOo00xUEuB4yU9zNBGa64bC39qH8u+FeSrr222B9Au2Xm12qrZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974327; c=relaxed/simple;
	bh=C/8ooFv7LigDgfrkCvNR5mfU1I95wfpwfH4u1p/12dI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTheVwkkCuUKrG+jPuW1vJZy0gdolm60qqRwfIoQ/8zz1Qvfsoom0blBxDFTWCpEPsOTk+TUHv0FWXOTmVruPyslVtpfsGajdOLl5Ky5R60VQfeaRF/V4cx9A8eZFv32emTZ7bqPakYNzNHESy/19f+X4MZ06eocHEaTAwSQDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=r4LI9BkP; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="r4LI9BkP"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56VE76gi018443
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=3lXUThCK9TruXupsMznihYaGe0l1jI570tUcjQ/bbi0=; b=r4LI9BkPS/p8
	8sNp7lhTADCIIjrJ2prFRLXcpTLglKVmKZI/UcdXUxPj8S84vM+o+EgBpeqcv0TW
	fhe0wFfoRJ3xwUDK72xed7szfjq/8rb++Ya7XwTaqgL1J13PvYFcl6Wz8eOBj/07
	jmebP7EQLO7cv4MYGFAsl4emCsYUPo86PvPNEqQV0KVpmEDrPxbbRAh+UyFK811q
	9+NW6rBApuWXDsGkAQzhuo61ZAUwRMJC0HOPfrBHuad0cPiu1hRGIO6I4eDPLuJI
	ePYas1P+R97VnyAX6AD7cAOzENBN1yR11MTpBtUo0oa9b/OoUIL41ZA25I2kAAXU
	R/ONWzGUFQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4883m32my9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:24 -0700 (PDT)
Received: from twshared52133.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:22 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 25A1E231DB2; Thu, 31 Jul 2025 08:05:14 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 6/8] blk-mq-dma: add support for mapping integrity metadata
Date: Thu, 31 Jul 2025 08:05:11 -0700
Message-ID: <20250731150513.220395-7-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731150513.220395-1-kbusch@meta.com>
References: <20250731150513.220395-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dgSzNFi5vTA8GJkJxBN1F2dXTFnKKI_t
X-Authority-Analysis: v=2.4 cv=WqwrMcfv c=1 sm=1 tr=0 ts=688b8635 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=i2dgJ8ZlISNNJfdBrEcA:9
X-Proofpoint-GUID: dgSzNFi5vTA8GJkJxBN1F2dXTFnKKI_t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX4C+jQr8yX5Pj stkOsde3w5jw8vgaeta2+PxCE0waNhhAr4diATbJUUcmlxo/+AS2nEwUZZF18XeWjAQ4AT0hfid onONvcMzwoQYCXyrFPYOkr9MrVzC10cHqzblKZew8qQZas+A1sN02/hxqUC8lA3JZSHehOJl11h
 L7dljdeaQoqAFNf0bXrXD7nkGC6SV6YBteJm4f7GoosoZPNkcz9LNQPzBEYv7Ag3TrzI4URdvWm TQYQDCykaeoHSoxY39eqpSxwvMNGNzW/lTA/uEZfkpD6t6qw0O50qVxu/8KPQCWNzD2/HMoqaUF G1fx4rygLcJDO1LxDKSsdIecFoHhbZtDFHE4eu+fhl8ipALd263h0ZPH5tNwChqxaJzVu6HmwoD
 VjyevWI+5QOloT0Tus6QuKC7feBXcL5RUErhz2pEwwg9+LX8ck0tws8F2mSfq8n8f8hThg6G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Provide integrity metadata helpers equivalent to the data payload
helpers for iterating a request for dma setup.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c            | 60 +++++++++++++++++++++++++++++++----
 include/linux/blk-integrity.h | 17 ++++++++++
 include/linux/blk-mq-dma.h    |  1 +
 3 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index bc694fecb39dc..faa36ff6465ee 100644
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
+	if (!iter->bio || !iter->bio->bi_next)
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
@@ -27,13 +46,8 @@ static bool blk_map_iter_next(struct request *req, str=
uct blk_map_iter *iter)
 	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
 		struct bio_vec next;
=20
-		if (!iter->iter.bi_size) {
-			if (!iter->bio || !iter->bio->bi_next)
-				break;
-			iter->bio =3D iter->bio->bi_next;
-			iter->iter =3D iter->bio->bi_iter;
-			iter->bvec =3D iter->bio->bi_io_vec;
-		}
+		if (!__blk_map_iter_next(iter))
+			break;
=20
 		next =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
@@ -232,6 +246,38 @@ bool blk_rq_dma_map_iter_next(struct request *req, s=
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
+	struct bio *bio =3D req->bio;
+
+	iter->iter =3D (struct blk_map_iter) {
+		.bio =3D bio,
+		.iter =3D bio->bi_integrity->bip_iter,
+		.bvec =3D bio->bi_integrity->bip_vec,
+		.is_integrity =3D true,
+	};
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
index e67a2b6e8f111..78fe2459e6612 100644
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
@@ -31,6 +32,11 @@ int blk_rq_integrity_map_user(struct request *rq, void=
 __user *ubuf,
 			      ssize_t bytes);
 int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
 		     struct logical_block_metadata_cap __user *argp);
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev,  struct dma_iova_state *state,
+		struct blk_dma_iter *iter);
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter);
=20
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
@@ -115,6 +121,17 @@ static inline int blk_rq_integrity_map_user(struct r=
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

