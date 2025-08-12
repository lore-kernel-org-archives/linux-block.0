Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC718288524
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006861; cv=none; b=o3UGotKhHeA6H9fofOtNRS1h39SrWgQuGqxvDpL7jGwSprjY2jd4ew8fbi+Sx8dbbdwmgxHymzlEwzBXz+4dLsomlpOagg7To7zk86PXfWhcA0b+bzVx8ntgZ12JpaodgjKIQtvTUgxnrl5q950wxfrr4eAkTh9/nMSPFKYCxlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006861; c=relaxed/simple;
	bh=BaaYqQsFYdpIMQdtBh3FQqw0iRJqFlq/1/ulRHN8m5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9SsuQ0RXcFVfo3entJbR3z7evtx5OPyWXWaYcFFRiZoM4L1uLjYfCnnm5JIAdK/FYyRZZ1RqoyH9NylFZRbk1J1kryZbRUCElDyp5IzbQKtKmLke6G2msXf+957eg42XgKDC5oat7Hyd7mN9bxe02AILHoKED1SR0JYqDeSr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=K1lBYG9S; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="K1lBYG9S"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDno4B028298
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:54:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=tn8Ucr7zEiT68IISk1J04nIX8owtsTK+AIFADmbQl7Y=; b=K1lBYG9SX/hC
	5BIwcmHicKZTn/DgxwqCEYgy3mqeA0Cxpc0Jc2U/ECuEmTDbufYwbZoZmK2IM+RD
	D4uTGUwaTlKuVckPLVQYkqfnVlycqCQG6msktizW/5wX1DEyCl1jfBhvC0opuaFh
	vbGLTbYzsI19zKBj1yRpMeIFLByikuP2LX+Jp1R0haQg5YMG7N1JzNTz8bxycRs+
	74ctHBPyX1lAqj0wYagwoIGD0XUhwQN9kU9zyqBxgdK4PFJiPx3PD9wCbpZKf6WG
	urg6zJDoJKLef1SN3jivJEaOVJRH6xXY7kSry4Su26ivM2C9e/g3QvlaK1CWXp8C
	gJ01UEgHVQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g0jbufud-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:54:18 -0700 (PDT)
Received: from twshared52133.15.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:18 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id D5D728D407F; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 6/8] blk-mq-dma: add support for mapping integrity metadata
Date: Tue, 12 Aug 2025 06:52:08 -0700
Message-ID: <20250812135210.4172178-7-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812135210.4172178-1-kbusch@meta.com>
References: <20250812135210.4172178-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=O+w5vA9W c=1 sm=1 tr=0 ts=689b478a cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=kBB9r6RryUnlB4RlzuIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfX7BlQkV6V2IZH PCR8NATUaVEL8EV0Bpfu5zs91hS3V/yao/WagyIqYeQtvnwN0+CXtrclE0woDhv8S2xEtHG7v7+ 2dZs2rnvO/u7MDM7Jasn/RF17ju9mdzxhtyhroLOF7+4YVXmMT0pHWzTXRlqTWHGofAq8XiW7Pu
 U+LYy/D4rQV9K3V7iqnUZuLyPXq3T7XqFbgDB7HPa251nK6+bALlpagQTmoVqL/CX2YWGkrqckR bKuS1OoUO2CGCmFPQKDvEghCzca57gRL0SLY+3uSAjn0cwmy55are5XvRBa09rwQNoIoZQTT6Kx m7v2HcnG3DA81eaqGjkVHjUZgglf4FW6EcY/2EK1YddfnQXPKMgw2NoB4AlKPdirxcP6SqxeQej
 OcM83TidKiomjshqakmkwS75z1hwnpcPurm7waghsXIxzJi1975d++1ChenC/LLaFTkdOH/V
X-Proofpoint-ORIG-GUID: pwsRqTXS0fAMkJGCujdPe3zEiCn6COcy
X-Proofpoint-GUID: pwsRqTXS0fAMkJGCujdPe3zEiCn6COcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Provide integrity metadata helpers equivalent to the data payload
helpers for iterating a request for dma setup.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c         |  43 +++++-------
 block/blk-mq-dma.c            | 120 +++++++++++++++++++++++++++-------
 block/blk-mq.h                |  26 ++++++++
 include/linux/blk-integrity.h |  17 +++++
 include/linux/blk-mq-dma.h    |   1 +
 5 files changed, 157 insertions(+), 50 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 056b8948369d5..1f4ef02078d5b 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -16,6 +16,7 @@
 #include <linux/t10-pi.h>
=20
 #include "blk.h"
+#include "blk-mq.h"
=20
 /**
  * blk_rq_count_integrity_sg - Count number of integrity scatterlist ele=
ments
@@ -134,37 +135,25 @@ int blk_get_meta_cap(struct block_device *bdev, uns=
igned int cmd,
  */
 int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sgli=
st)
 {
-	struct bio_vec iv, ivprv =3D { NULL };
 	struct request_queue *q =3D rq->q;
 	struct scatterlist *sg =3D NULL;
 	struct bio *bio =3D rq->bio;
 	unsigned int segments =3D 0;
-	struct bvec_iter iter;
-	int prev =3D 0;
-
-	bio_for_each_integrity_vec(iv, bio, iter) {
-		if (prev) {
-			if (!biovec_phys_mergeable(q, &ivprv, &iv))
-				goto new_segment;
-			if (sg->length + iv.bv_len > queue_max_segment_size(q))
-				goto new_segment;
-
-			sg->length +=3D iv.bv_len;
-		} else {
-new_segment:
-			if (!sg)
-				sg =3D sglist;
-			else {
-				sg_unmark_end(sg);
-				sg =3D sg_next(sg);
-			}
-
-			sg_set_page(sg, iv.bv_page, iv.bv_len, iv.bv_offset);
-			segments++;
-		}
-
-		prev =3D 1;
-		ivprv =3D iv;
+	struct blk_map_iter iter;
+	struct phys_vec vec;
+
+	iter =3D (struct blk_map_iter) {
+		.bio =3D bio,
+		.iter =3D bio_integrity(bio)->bip_iter,
+		.bvecs =3D bio_integrity(bio)->bip_vec,
+		.is_integrity =3D true,
+	};
+
+	while (blk_map_iter_next(rq, &iter, &vec)) {
+		sg =3D blk_next_sg(&sg, sglist);
+		sg_set_page(sg, phys_to_page(vec.paddr), vec.len,
+				offset_in_page(vec.paddr));
+		segments++;
 	}
=20
 	if (sg)
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 31dd8f58f0811..c26e797876d56 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -2,16 +2,31 @@
 /*
  * Copyright (C) 2025 Christoph Hellwig
  */
+#include <linux/blk-integrity.h>
 #include <linux/blk-mq-dma.h>
 #include "blk.h"
+#include "blk-mq.h"
=20
-struct phys_vec {
-	phys_addr_t	paddr;
-	u32		len;
-};
+static bool __blk_map_iter_next(struct blk_map_iter *iter)
+{
+	if (iter->iter.bi_size)
+		return true;
+	if (!iter->bio || !iter->bio->bi_next)
+		return false;
+
+	iter->bio =3D iter->bio->bi_next;
+	if (iter->is_integrity) {
+		iter->iter =3D bio_integrity(iter->bio)->bip_iter;
+		iter->bvecs =3D bio_integrity(iter->bio)->bip_vec;
+	} else {
+		iter->iter =3D iter->bio->bi_iter;
+		iter->bvecs =3D iter->bio->bi_io_vec;
+	}
+	return true;
+}
=20
-static bool blk_map_iter_next(struct request *req, struct blk_map_iter *=
iter,
-			      struct phys_vec *vec)
+bool blk_map_iter_next(struct request *req, struct blk_map_iter *iter,
+			struct phys_vec *vec)
 {
 	unsigned int max_size;
 	struct bio_vec bv;
@@ -242,23 +257,6 @@ bool blk_rq_dma_map_iter_next(struct request *req, s=
truct device *dma_dev,
 }
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_next);
=20
-static inline struct scatterlist *
-blk_next_sg(struct scatterlist **sg, struct scatterlist *sglist)
-{
-	if (!*sg)
-		return sglist;
-
-	/*
-	 * If the driver previously mapped a shorter list, we could see a
-	 * termination bit prematurely unless it fully inits the sg table
-	 * on each mapping. We KNOW that there must be more entries here
-	 * or the driver would be buggy, so force clear the termination bit
-	 * to avoid doing a full sg_init_table() in drivers for each command.
-	 */
-	sg_unmark_end(*sg);
-	return sg_next(*sg);
-}
-
 /*
  * Map a request to scatterlist, return number of sg entries setup. Call=
er
  * must make sure sg can hold rq->nr_phys_segments entries.
@@ -290,3 +288,79 @@ int __blk_rq_map_sg(struct request *rq, struct scatt=
erlist *sglist,
 	return nsegs;
 }
 EXPORT_SYMBOL(__blk_rq_map_sg);
+
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+/**
+ * blk_rq_integrity_dma_map_iter_start - map the first integrity DMA seg=
ment
+ * 					 for a request
+ * @req:	request to map
+ * @dma_dev:	device to map to
+ * @state:	DMA IOVA state
+ * @iter:	block layer DMA iterator
+ *
+ * Start DMA mapping @req integrity data to @dma_dev.  @state and @iter =
are
+ * provided by the caller and don't need to be initialized.  @state need=
s to be
+ * stored for use at unmap time, @iter is only needed at map time.
+ *
+ * Returns %false if there is no segment to map, including due to an err=
or, or
+ * %true if it did map a segment.
+ *
+ * If a segment was mapped, the DMA address for it is returned in @iter.=
addr
+ * and the length in @iter.len.  If no segment was mapped the status cod=
e is
+ * returned in @iter.status.
+ *
+ * The caller can call blk_rq_dma_map_coalesce() to check if further seg=
ments
+ * need to be mapped after this, or go straight to blk_rq_dma_map_iter_n=
ext()
+ * to try to map the following segments.
+ */
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
+		.iter =3D bio_integrity(bio)->bip_iter,
+		.bvecs =3D bio_integrity(bio)->bip_vec,
+		.is_integrity =3D true,
+	};
+	return blk_dma_map_iter_start(req, dma_dev, state, iter, len);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_start);
+
+/**
+ * blk_rq_integrity_dma_map_iter_start - map the next integrity DMA segm=
ent for
+ * 					 a request
+ * @req:	request to map
+ * @dma_dev:	device to map to
+ * @state:	DMA IOVA state
+ * @iter:	block layer DMA iterator
+ *
+ * Iterate to the next integrity mapping after a previous call to
+ * blk_rq_integrity_dma_map_iter_start().  See there for a detailed desc=
ription
+ * of the arguments.
+ *
+ * Returns %false if there is no segment to map, including due to an err=
or, or
+ * %true if it did map a segment.
+ *
+ * If a segment was mapped, the DMA address for it is returned in @iter.=
addr and
+ * the length in @iter.len.  If no segment was mapped the status code is
+ * returned in @iter.status.
+ */
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+               struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	struct phys_vec vec;
+
+	if (!blk_map_iter_next(req, &iter->iter, &vec))
+		return false;
+
+	if (iter->p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
+		return blk_dma_map_bus(iter, &vec);
+	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_next);
+#endif
diff --git a/block/blk-mq.h b/block/blk-mq.h
index affb2e14b56e3..ab378518fc0fb 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -449,4 +449,30 @@ static inline bool blk_mq_can_poll(struct request_qu=
eue *q)
 		q->tag_set->map[HCTX_TYPE_POLL].nr_queues;
 }
=20
+struct phys_vec {
+	phys_addr_t	paddr;
+	u32		len;
+};
+
+struct blk_map_iter;
+bool blk_map_iter_next(struct request *req, struct blk_map_iter *iter,
+			struct phys_vec *vec);
+
+static inline struct scatterlist *
+blk_next_sg(struct scatterlist **sg, struct scatterlist *sglist)
+{
+	if (!*sg)
+		return sglist;
+
+	/*
+	 * If the driver previously mapped a shorter list, we could see a
+	 * termination bit prematurely unless it fully inits the sg table
+	 * on each mapping. We KNOW that there must be more entries here
+	 * or the driver would be buggy, so force clear the termination bit
+	 * to avoid doing a full sg_init_table() in drivers for each command.
+	 */
+	sg_unmark_end(*sg);
+	return sg_next(*sg);
+}
+
 #endif
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
index 881880095e0da..0f45ea110ca12 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -9,6 +9,7 @@ struct blk_map_iter {
 	struct bvec_iter		iter;
 	struct bio			*bio;
 	struct bio_vec			*bvecs;
+	bool				is_integrity;
 };
=20
 struct blk_dma_iter {
--=20
2.47.3

