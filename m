Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388D420E031
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750884295; cv=none; b=EDSFOArAY+rnniEcaSTqDsvVR21zGp/7cz/kSq8sTQlwiA1DfaFpnYbVqTTx48/9lkU/Hskuiy2yW5Do9wb/KE7MI1DJjg/2C7dPpp/7n6B4IJn0ED7KkskrgJLpwegSsz569eU/a/BSg/tPsVeWlzwCj7rrLNCq2mTI/zN5HVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750884295; c=relaxed/simple;
	bh=XeoWWUKmumZ8ynOtL2//IbtRw6xjLJByq00I40xOzck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G620Y0yvjmd0+ZSiF3J9yOyK3nY2tNOsFtct5m4mfwSJmHAI6mRqKsKrdARGa9GsyZWHaXsE5Q6edTtAUAoJqjyhgIiswih8GWwDc+sh+ucVFcsqnlT9ax39K/vNzR/dR4CbMcEJI+fH0kBdkMHWQFOsflDKIMHXtGkqoPRiSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AMJXwp0d; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AMJXwp0d"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PJMJbH016284
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 13:44:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=L5RtRyeSuYZjNvCCAI
	rZfZ0wTr6RWPvM785jVZwUc2k=; b=AMJXwp0dndU7l0AygcuFkbJbH5C9Ewn/J6
	+qZTWvcAcDdhNmU9WHf7w1g9Cf7GR78eJXnePjq3h+h+HGiLkjWxcTnnAG7jmuar
	hh4TugGLahInCkC7wymL1DII6hIBhPBwKm3xrO1BFWJ9C/re84DiL0Jjot87gR5z
	Vg45+f4niE6Ji9KWX7BULFFeHb5h2zFPYRmhuV0rHx661w2Sv1RuX59ezlVp4Xkt
	KXISUe2Ra+CfJfgiRFQHLJCm66SArjWQjHLueXKppEeeSpZfdCebfY6Tbs/IFfXJ
	aJQob4NOZA7efxN5rL+lRKs2UQH81nkrzj57Ua7reU3Wq+AD50JA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47gevm4es6-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 13:44:52 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 25 Jun 2025 20:44:49 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id C5B538C48C8; Wed, 25 Jun 2025 13:44:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <leon@kernel.org>, <joshi.k@samsung.com>,
        <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] blk-integrity: add scatter-less DMA mapping helpers
Date: Wed, 25 Jun 2025 13:44:44 -0700
Message-ID: <20250625204445.1802483-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE1OSBTYWx0ZWRfX9hNblVeCwFQb hqLmovcNFVAqTuSRj9Wmi3L6kZR6Xx0djMMk5vmRKZm4FywwxBWVF/qUr6lH1LmqkHfTe/2MwLl f+j+Nc37H1x5tyUatlICp6bx6AXcnw4o2ITZKFnpBHh0xrTO3/sXVQlGClZGAg7DLRLXLvhS03y
 9eBbvSGN868oOJ8AuZEXTi377//7Lo+q46re1GR3P8dx/4oSNf10L8XggyMzXBFI0zSCtRr28HB qjWUs2tYDGUP2YQJdSlh/CkOdCKbrAKwA/G1FAgcPXgScTWatxH5iFNXwwdMk/RjZSvNGEI5dB9 4HnRYNiYynYyE8EpKzM3yIJC/kr0MW8vYSL3NRlscj7ZTZvL+EAAe89rXJtqyXxLwgvarejkWsP
 +a4oQNRHKDuHHPkSx0Hj9xIzAWzCqPhiSzt5Yoci3kyE8N+gx07PYAU3mLRm2AfVqQybPqqC
X-Proofpoint-ORIG-GUID: VbPHLTRTTVGkHH3YSNRSGL8AJk1wtVQY
X-Proofpoint-GUID: VbPHLTRTTVGkHH3YSNRSGL8AJk1wtVQY
X-Authority-Analysis: v=2.4 cv=Ud9RSLSN c=1 sm=1 tr=0 ts=685c5fc4 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=YbswHzic5SfKCEL6b6MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_07,2025-06-25_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This is much like the scatter-less DMA helpers for request data, but for
integrity metadata instead. This one only subscribes to the direct
mapping as the virt boundary queue limit used to check for iova
coalescing possibilities doesn't apply to metadata.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c         | 94 +++++++++++++++++++++++++++++++++++
 block/blk-mq-dma.c            |  9 +---
 block/blk.h                   | 10 ++++
 include/linux/blk-integrity.h |  6 +++
 4 files changed, 112 insertions(+), 7 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index e4e2567061f9d..e79df07d1151a 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -112,6 +112,100 @@ int blk_rq_map_integrity_sg(struct request *rq, str=
uct scatterlist *sglist)
 }
 EXPORT_SYMBOL(blk_rq_map_integrity_sg);
=20
+static void bio_integrity_advance_iter_single(struct bio *bio,
+						struct bvec_iter *iter,
+						struct bio_vec *bvec,
+						unsigned int bytes)
+{
+	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
+
+	iter->bi_sector +=3D bytes / bi->tuple_size;
+	bvec_iter_advance(bvec, iter, bytes);
+}
+
+static bool blk_rq_integrity_map_iter_next(struct request *req,
+		struct req_iterator *iter, struct phys_vec *vec)
+{
+	struct bio_integrity_payload *bip =3D bio_integrity(iter->bio);
+	unsigned int max_size;
+	struct bio_vec bv;
+
+	if (!iter->iter.bi_size)
+		return false;
+
+	bv =3D mp_bvec_iter_bvec(bip->bip_vec, iter->iter);
+	vec->paddr =3D bvec_phys(&bv);
+	max_size =3D get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX=
);
+	bv.bv_len =3D min(bv.bv_len, max_size);
+
+	bio_integrity_advance_iter_single(iter->bio, &iter->iter, &bv, bv.bv_le=
n);
+	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
+		struct bio_vec next;
+
+		if (!iter->iter.bi_size) {
+			if (!iter->bio->bi_next)
+				break;
+			iter->bio =3D iter->bio->bi_next;
+			iter->iter =3D iter->bio->bi_iter;
+		}
+
+		next =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+		if (bv.bv_len + next.bv_len > max_size ||
+		    !biovec_phys_mergeable(req->q, &bv, &next))
+			break;
+
+		bv.bv_len +=3D next.bv_len;
+		bio_integrity_advance_iter_single(iter->bio, &iter->iter, &bv,
+							next.bv_len);
+	}
+
+	vec->len =3D bv.bv_len;
+	return true;
+}
+
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	struct bio_integrity_payload *bip =3D bio_integrity(req->bio);
+	struct phys_vec vec;
+
+	iter->iter.bio =3D req->bio;
+	iter->iter.iter =3D bip->bip_iter;
+	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
+	iter->status =3D BLK_STS_OK;
+
+	if (!blk_rq_integrity_map_iter_next(req, &iter->iter, &vec))
+		return false;
+
+	switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
+				phys_to_page(vec.paddr))) {
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		return blk_dma_map_bus(iter, &vec);
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+	case PCI_P2PDMA_MAP_NONE:
+		break;
+	default:
+		iter->status =3D BLK_STS_INVAL;
+		return false;
+	}
+
+	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_map_iter_start);
+
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	struct phys_vec vec;
+
+	if (!blk_rq_integrity_map_iter_next(req, &iter->iter, &vec))
+		return false;
+	if (iter->p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
+		return blk_dma_map_bus(iter, &vec);
+	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_next);
+
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes)
 {
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index ad283017caef2..54c25e5e60d78 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -5,11 +5,6 @@
 #include <linux/blk-mq-dma.h>
 #include "blk.h"
=20
-struct phys_vec {
-	phys_addr_t	paddr;
-	u32		len;
-};
-
 static bool blk_map_iter_next(struct request *req, struct req_iterator *=
iter,
 			      struct phys_vec *vec)
 {
@@ -77,14 +72,14 @@ static inline bool blk_can_dma_map_iova(struct reques=
t *req,
 		dma_get_merge_boundary(dma_dev));
 }
=20
-static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *=
vec)
+bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
 {
 	iter->addr =3D pci_p2pdma_bus_addr_map(&iter->p2pdma, vec->paddr);
 	iter->len =3D vec->len;
 	return true;
 }
=20
-static bool blk_dma_map_direct(struct request *req, struct device *dma_d=
ev,
+bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter, struct phys_vec *vec)
 {
 	iter->addr =3D dma_map_page(dma_dev, phys_to_page(vec->paddr),
diff --git a/block/blk.h b/block/blk.h
index 1141b343d0b5c..755975ddc3046 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
=20
 #include <linux/bio-integrity.h>
 #include <linux/blk-crypto.h>
+#include <linux/blk-mq-dma.h>
 #include <linux/lockdep.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
 #include <linux/sched/sysctl.h>
@@ -727,6 +728,15 @@ int bdev_open(struct block_device *bdev, blk_mode_t =
mode, void *holder,
 	      const struct blk_holder_ops *hops, struct file *bdev_file);
 int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
=20
+struct phys_vec {
+	phys_addr_t	paddr;
+	u32		len;
+};
+
+bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec);
+bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
+		struct blk_dma_iter *iter, struct phys_vec *vec);
+
 void blk_integrity_generate(struct bio *bio);
 void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_=
iter);
 void blk_integrity_prepare(struct request *rq);
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index c7eae0bfb013f..8e2aeb5c13864 100644
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
@@ -30,6 +31,11 @@ int blk_rq_count_integrity_sg(struct request_queue *, =
struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes);
=20
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter);
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter);
+
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
 {
--=20
2.47.1

