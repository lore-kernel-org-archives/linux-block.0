Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14649286422
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668723; cv=none; b=B9ANrfhdh4pJ7S60O6SrR9gs4b+xD6I9cmodPzQXvvswwsoMxrWpvQ46qjI4l1xIIOgq37/mVdh7VIWwR2DZYKK4MYP1Fdlt6wMMBXAkPZw75Taj4vIW2fPa1s5OjWcxZJA7jsrL/zVLk/CSeWLy2bMJFgKt+NqzgWkI/NfrqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668723; c=relaxed/simple;
	bh=kvQVNgZPvAlIndShaEcrsn44a7OwoGQ2hOCfCYQxlME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEaiPIQYq01WnjPfdHuxz1fLQs5bz33UIVat9rBfqPjKL1814mSBsjOSprbD5Rx80DOBItogAWDTOVu6XmhJrF8b43WPXCjqDbcIsBlTjn7kIT9YRCPsue7DWZBICKsMZGsxek8lh0+FOOQa8u+O2LdMJp2nY6NHKruIbSlxPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QntH5Mlc; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QntH5Mlc"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FKBbH021638
	for <linux-block@vger.kernel.org>; Fri, 8 Aug 2025 08:58:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=nPmofxVJJVT8vmj3OGd3x5XdpGfNjZeeRGgSS/58hLA=; b=QntH5Mlc/TiY
	EhXFMUBdJgCN3S79D2W4lx2riTaAu+3dq0HQ+VPT03DkwRY5s+xdtCNGeDiO6BqQ
	kAeDpIaFvVO3jAqntgYvbokOhjwG5ybyd15x3DzlDXIOrGSSYa2JMlyAxrjqPXTG
	nOimime0zgAr07tpYlKoGcbVwGOUvFS+d9EiJW174TuW8EgGQtth+hfaD3B+oa8X
	3NB4M/XnHYvPrP7g9Rhd5WEp5Uj4WiDuM2PyYxI5xoLL/H4fsZm8kJxgUC3FExA/
	1Mjld7uHCN6pP9sXqbEomovBe8bn6uPZ+k/V1dN3voc2TIfqx34uNzvagl/znS0v
	dLY7O8OXNQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48dbwck3f3-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 08 Aug 2025 08:58:40 -0700 (PDT)
Received: from twshared52133.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:33 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 413BA6C76CB; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 6/8] blk-mq-dma: add support for mapping integrity metadata
Date: Fri, 8 Aug 2025 08:58:24 -0700
Message-ID: <20250808155826.1864803-7-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250808155826.1864803-1-kbusch@meta.com>
References: <20250808155826.1864803-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfX2Zx3VHO81kZH FxSS3rNvIvmxXgW/4mNXDIWwH9YQ/qTJGkzzMCG20f+lXgXN/qRdFs02YStoNTGLxbskpeLWpk7 m9qFK+Rv/oKvK0jKUptX9A53G8TlKAW4sKB7VRYYu+MLSFrNcDk0wRfNS+JYKLu8W1XZFC5ri0M
 1zEw/uHa6qIZeUEG89E/hfxmF+nslLNmuCOULrmf6OoI00N2RojSk25gIYb4IxmP2NZR0IJE4/x lCzOebfqVb5GdE3qlrnT6/B+c+XA1Lvj9P8KpIIEnqSVmQFlfzAJ9x9jOxlEGkdObXePiJ8YlRF 6eIshPbPYp2odA3HzU4pM8jnNnra0HqFzn+EPXX9cVlGhwijMSJbqBGxiNsfkY9RnyHJLThG3by
 6s5em9jozPKMZADjlUTtOGd7JegTPFAjDDBKt0ijLGSOVbmOX+fLYezB1b1vOSf4M9lBdMUN
X-Proofpoint-GUID: gz3MIjO_ypkzKAd7ORUM4oremB2bTbTI
X-Authority-Analysis: v=2.4 cv=DthW+H/+ c=1 sm=1 tr=0 ts=68961eb0 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=DHwdFhbtcl8zAAEAvK0A:9
X-Proofpoint-ORIG-GUID: gz3MIjO_ypkzKAd7ORUM4oremB2bTbTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Provide integrity metadata helpers equivalent to the data payload
helpers for iterating a request for dma setup.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c            | 62 +++++++++++++++++++++++++++++++----
 include/linux/blk-integrity.h | 17 ++++++++++
 include/linux/blk-mq-dma.h    |  3 ++
 3 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index bc694fecb39dc..6acf46679c96a 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -2,9 +2,30 @@
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
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	if (iter->is_integrity) {
+		iter->iter =3D iter->bio->bi_integrity->bip_iter;
+		iter->bvec =3D iter->bio->bi_integrity->bip_vec;
+		return true;
+	}
+#endif
+	iter->iter =3D iter->bio->bi_iter;
+	iter->bvec =3D iter->bio->bi_io_vec;
+	return true;
+}
+
 static bool blk_map_iter_next(struct request *req, struct blk_map_iter *=
iter)
 {
 	unsigned int max_size;
@@ -27,13 +48,8 @@ static bool blk_map_iter_next(struct request *req, str=
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
@@ -232,6 +248,38 @@ bool blk_rq_dma_map_iter_next(struct request *req, s=
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
index aef8d784952ff..5ff7f3ce9059a 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -11,6 +11,9 @@ struct blk_map_iter {
 	struct bio_vec                  *bvec;
 	struct bvec_iter		iter;
 	struct bio			*bio;
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	bool				is_integrity;
+#endif
 };
=20
 struct blk_dma_iter {
--=20
2.47.3

