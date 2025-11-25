Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFE2D3EDF
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097061; cv=none; b=edYpv3EFnd0BP2NOThg1DybxjJVGvRtgQwLFcSXR1FZ+EzTW+IIDsov4dnqwEXyGQZOcfELqK2UPeGkWW+yq/u/MQvYdcT94Iw0vk+La9UGL/DMGNQoxNK51z3fvheQ4IxRa1lkwEv5BwR1JzqA8vKthS02SnvOLwA6xRLVeHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097061; c=relaxed/simple;
	bh=L+a3ioCgnDJ4aREs/zxjE3ON3M0Xcb3nQS0QtNpIawA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oIemdMRbGyIDncWIAiLE6Y9F3f8InZeWPr6ij37EIHpzHgrXNYuVL3JcoQiRqq20ZPrtcPxsf9V1wY1BIOOaUub9dIKtZ3gcHPycEbXyFJTdmsQmo15J+v1BO7CXCqkUE2GwHDLLrgzfL4kXiKFGIlujwlTXAeL6NE5x6W8o0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=iXmYAx1M; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="iXmYAx1M"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APEhsjC3578381
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 10:57:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=JdxdZNb27z8BsHAxz+
	Sr/3bqC9uP18JO1C5SWLlgSNg=; b=iXmYAx1MZPyCcdzWdR7t1uDqimB8+DvnbM
	9XlIYHXHFpAQDWRqIPoKQzdaCfNyP1RMgc0gFfg9l4+wewThx39wkomcxXSdsBSS
	4rBS6xtNmn8KJl9T7iuBOeHQ/BBuF4+uIkMy98YEr7IPl/+RdfyVbDdPP1nyaVs2
	aQTq0deVqY4ngw0OpAGMHLmgI+pKtMO1x4U+S4IGmGrNHcqgvfOMtMLBdQh5cKpL
	zf1f+6/Jxpozzp14rz32lXTLu4A4p0vx8O/S/M4RK/QqlnyNUuM1JhR9f3ok389X
	zW2tzhuWNghdGIQqLvg8K2oCAAH/Lrv6rtUSww98VgFVXLFSyy7A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4anbw3bf2a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 10:57:37 -0800 (PST)
Received: from twshared13623.02.snb2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 25 Nov 2025 18:57:36 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id B44234273817; Tue, 25 Nov 2025 10:57:25 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
        "Martin K.
 Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv7] blk-integrity: support arbitrary buffer alignment
Date: Tue, 25 Nov 2025 10:57:18 -0800
Message-ID: <20251125185718.2190305-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ye_rMR6xf_fzWUzK7ln7eHVhzHpU9MpF
X-Proofpoint-GUID: ye_rMR6xf_fzWUzK7ln7eHVhzHpU9MpF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE1NyBTYWx0ZWRfX9oww2JzDvvr0
 8bq1Bg6UEpqYbm8z74wj5sg5iqOCs1mqohimQ5P46wqsYz0eskOD4Qez10hS+WjPYMTftiTJ7tH
 8JU9i2/vHnD24mToJL6r9A+rCnyhoCrMTlmh17ssExltqfg1Q9tVxGz0W9YyPAVaL+9peB3dzfS
 S/0JfhLyG8ut5vHob5KRM9R6JBWLeDAJPJfb3ymBlglTkEHCbo7DkBmUdWNDPHcYqlToAvak8lM
 Zng6Db+1LRE3y4LgAZWQzfzBa8A8fZQDY4K41u01aVKBjdjfpLtQ0sPwTEriq9NPq1zG02qy03d
 JizQVF7WgWMlXVNqvvvOY9rzAFkjahq5kYRkbMuGzahredPFEtH909/hZNEgOt2XYNnxhoNbmcE
 smAbMqZrynykj6hDdR/wLMmxNdtGew==
X-Authority-Analysis: v=2.4 cv=Aa283nXG c=1 sm=1 tr=0 ts=6925fc21 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=xHMqUeLr-KbIvyXNY5YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A bio segment may have partial interval block data with the rest
continuing into the next segments because direct-io data payloads only
need to align in memory to the device's DMA limits.

At the same time, the protection information may also be split in
multiple segments. The most likely way that may happen is if two
requests merge, or if we're directly using the io_uring user metadata.
The generate/verify, however, only ever accessed the first bip_vec.

Further, it may be possible to unalign the protection fields from the
user space buffer, or if there are odd additional opaque bytes in front
or in back of the protection information metadata region.

Change up the iteration to allow spanning multiple segments. This patch
is mostly a re-write of the protection information handling to allow any
arbitrary alignments, so it's probably easier to review the end result
rather than the diff.

Martin reports many SCSI controllers are not able to handle interval
data composed of multiple segments when PI is used, so this patch
introduces a new integrity limit that a low level driver can set to
notify that it is capable of handling that, default to false. The nvme
driver is the first one to enable it in this patch. Everyone else will
force DMA alignment to the logical block size to ensure interval data is
always aligned within a single segment.

Reviewed-by: "Martin K. Petersen" <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v6->v7:

Incorporated review comments from Caleb:

  * Replaced mp_bvec_iter_bvec with bvec_iter_bvec for all places that
    kmap it

  * Moved a declaration to the scope that uses it

Since it was just the one iter change, I've retained the previous
reviews.

 block/blk-settings.c          |  12 +-
 block/t10-pi.c                | 819 +++++++++++++++++++---------------
 drivers/nvme/host/core.c      |   1 +
 include/linux/blk-integrity.h |   1 +
 4 files changed, 466 insertions(+), 367 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 51401f08ce05b..86e04ea895ea0 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -198,11 +198,11 @@ static int blk_validate_integrity_limits(struct que=
ue_limits *lim)
 		bi->interval_exp =3D ilog2(lim->logical_block_size);
=20
 	/*
-	 * The PI generation / validation helpers do not expect intervals to
-	 * straddle multiple bio_vecs.  Enforce alignment so that those are
+	 * Some IO controllers can not handle data intervals straddling
+	 * multiple bio_vecs.  For those, enforce alignment so that those are
 	 * never generated, and that each buffer is aligned as expected.
 	 */
-	if (bi->csum_type) {
+	if (!(bi->flags & BLK_SPLIT_INTERVAL_CAPABLE) && bi->csum_type) {
 		lim->dma_alignment =3D max(lim->dma_alignment,
 					(1U << bi->interval_exp) - 1);
 	}
@@ -1001,10 +1001,14 @@ bool queue_limits_stack_integrity(struct queue_li=
mits *t,
 		if ((ti->flags & BLK_INTEGRITY_REF_TAG) !=3D
 		    (bi->flags & BLK_INTEGRITY_REF_TAG))
 			goto incompatible;
+		if ((ti->flags & BLK_SPLIT_INTERVAL_CAPABLE) &&
+		    !(bi->flags & BLK_SPLIT_INTERVAL_CAPABLE))
+			ti->flags &=3D ~BLK_SPLIT_INTERVAL_CAPABLE;
 	} else {
 		ti->flags =3D BLK_INTEGRITY_STACKED;
 		ti->flags |=3D (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE) |
-			     (bi->flags & BLK_INTEGRITY_REF_TAG);
+			     (bi->flags & BLK_INTEGRITY_REF_TAG) |
+			     (bi->flags & BLK_SPLIT_INTERVAL_CAPABLE);
 		ti->csum_type =3D bi->csum_type;
 		ti->pi_tuple_size =3D bi->pi_tuple_size;
 		ti->metadata_size =3D bi->metadata_size;
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c4ed97021460..3a564c0e2fe80 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -12,462 +12,555 @@
 #include <linux/unaligned.h>
 #include "blk.h"
=20
+#define APP_TAG_ESCAPE 0xffff
+#define REF_TAG_ESCAPE 0xffffffff
+
+/*
+ * This union is used for onstack allocations when the pi field is split=
 across
+ * segments. blk_validate_integrity_limits() guarantees pi_tuple_size ma=
tches
+ * the sizeof one of these two types.
+ */
+union pi_tuple {
+	struct crc64_pi_tuple	crc64_pi;
+	struct t10_pi_tuple	t10_pi;
+};
+
 struct blk_integrity_iter {
-	void			*prot_buf;
-	void			*data_buf;
-	sector_t		seed;
-	unsigned int		data_size;
-	unsigned short		interval;
-	const char		*disk_name;
+	struct bio			*bio;
+	struct bio_integrity_payload	*bip;
+	struct blk_integrity		*bi;
+	struct bvec_iter		data_iter;
+	struct bvec_iter		prot_iter;
+	unsigned int			interval_remaining;
+	u64				seed;
+	u64				csum;
 };
=20
-static __be16 t10_pi_csum(__be16 csum, void *data, unsigned int len,
-		unsigned char csum_type)
+static void blk_calculate_guard(struct blk_integrity_iter *iter, void *d=
ata,
+				unsigned int len)
 {
-	if (csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
-		return (__force __be16)ip_compute_csum(data, len);
-	return cpu_to_be16(crc_t10dif_update(be16_to_cpu(csum), data, len));
+	switch (iter->bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		iter->csum =3D crc64_nvme(iter->csum, data, len);
+		break;
+	case BLK_INTEGRITY_CSUM_CRC:
+		iter->csum =3D crc_t10dif_update(iter->csum, data, len);
+		break;
+	case BLK_INTEGRITY_CSUM_IP:
+		iter->csum =3D (__force u32)csum_partial(data, len,
+						(__force __wsum)iter->csum);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		iter->csum =3D U64_MAX;
+		break;
+	}
+}
+
+static void blk_integrity_csum_finish(struct blk_integrity_iter *iter)
+{
+	switch (iter->bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_IP:
+		iter->csum =3D (__force u16)csum_fold((__force __wsum)iter->csum);
+		break;
+	default:
+		break;
+	}
 }
=20
 /*
- * Type 1 and Type 2 protection use the same format: 16 bit guard tag,
- * 16 bit app tag, 32 bit reference tag. Type 3 does not define the ref
- * tag.
+ * Update the csum for formats that have metadata padding in front of th=
e data
+ * integrity field
  */
-static void t10_pi_generate(struct blk_integrity_iter *iter,
-		struct blk_integrity *bi)
+static void blk_integrity_csum_offset(struct blk_integrity_iter *iter)
 {
-	u8 offset =3D bi->pi_offset;
-	unsigned int i;
+	unsigned int offset =3D iter->bi->pi_offset;
+	struct bio_vec *bvec =3D iter->bip->bip_vec;
+
+	while (offset > 0) {
+		struct bio_vec pbv =3D bvec_iter_bvec(bvec, iter->prot_iter);
+		unsigned int len =3D min(pbv.bv_len, offset);
+		void *prot_buf =3D bvec_kmap_local(&pbv);
+
+		blk_calculate_guard(iter, prot_buf, len);
+		kunmap_local(prot_buf);
+		offset -=3D len;
+		bvec_iter_advance_single(bvec, &iter->prot_iter, len);
+	}
+	blk_integrity_csum_finish(iter);
+}
=20
-	for (i =3D 0 ; i < iter->data_size ; i +=3D iter->interval) {
-		struct t10_pi_tuple *pi =3D iter->prot_buf + offset;
+static void blk_integrity_copy_from_tuple(struct bio_integrity_payload *=
bip,
+					  struct bvec_iter *iter, void *tuple,
+					  unsigned int tuple_size)
+{
+	while (tuple_size) {
+		struct bio_vec pbv =3D bvec_iter_bvec(bip->bip_vec, *iter);
+		unsigned int len =3D min(tuple_size, pbv.bv_len);
+		void *prot_buf =3D bvec_kmap_local(&pbv);
+
+		memcpy(prot_buf, tuple, len);
+		kunmap_local(prot_buf);
+		bvec_iter_advance_single(bip->bip_vec, iter, len);
+		tuple_size -=3D len;
+		tuple +=3D len;
+	}
+}
=20
-		pi->guard_tag =3D t10_pi_csum(0, iter->data_buf, iter->interval,
-				bi->csum_type);
-		if (offset)
-			pi->guard_tag =3D t10_pi_csum(pi->guard_tag,
-					iter->prot_buf, offset, bi->csum_type);
-		pi->app_tag =3D 0;
+static void blk_integrity_copy_to_tuple(struct bio_integrity_payload *bi=
p,
+					struct bvec_iter *iter, void *tuple,
+					unsigned int tuple_size)
+{
+	while (tuple_size) {
+		struct bio_vec pbv =3D bvec_iter_bvec(bip->bip_vec, *iter);
+		unsigned int len =3D min(tuple_size, pbv.bv_len);
+		void *prot_buf =3D bvec_kmap_local(&pbv);
+
+		memcpy(tuple, prot_buf, len);
+		kunmap_local(prot_buf);
+		bvec_iter_advance_single(bip->bip_vec, iter, len);
+		tuple_size -=3D len;
+		tuple +=3D len;
+	}
+}
=20
-		if (bi->flags & BLK_INTEGRITY_REF_TAG)
-			pi->ref_tag =3D cpu_to_be32(lower_32_bits(iter->seed));
-		else
-			pi->ref_tag =3D 0;
+static bool ext_pi_ref_escape(const u8 ref_tag[6])
+{
+	static const u8 ref_escape[6] =3D { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff =
};
=20
-		iter->data_buf +=3D iter->interval;
-		iter->prot_buf +=3D bi->metadata_size;
-		iter->seed++;
-	}
+	return memcmp(ref_tag, ref_escape, sizeof(ref_escape)) =3D=3D 0;
 }
=20
-static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
-		struct blk_integrity *bi)
-{
-	u8 offset =3D bi->pi_offset;
-	unsigned int i;
-
-	for (i =3D 0 ; i < iter->data_size ; i +=3D iter->interval) {
-		struct t10_pi_tuple *pi =3D iter->prot_buf + offset;
-		__be16 csum;
-
-		if (bi->flags & BLK_INTEGRITY_REF_TAG) {
-			if (pi->app_tag =3D=3D T10_PI_APP_ESCAPE)
-				goto next;
-
-			if (be32_to_cpu(pi->ref_tag) !=3D
-			    lower_32_bits(iter->seed)) {
-				pr_err("%s: ref tag error at location %llu " \
-				       "(rcvd %u)\n", iter->disk_name,
-				       (unsigned long long)
-				       iter->seed, be32_to_cpu(pi->ref_tag));
-				return BLK_STS_PROTECTION;
-			}
-		} else {
-			if (pi->app_tag =3D=3D T10_PI_APP_ESCAPE &&
-			    pi->ref_tag =3D=3D T10_PI_REF_ESCAPE)
-				goto next;
+static blk_status_t blk_verify_ext_pi(struct blk_integrity_iter *iter,
+				      struct crc64_pi_tuple *pi)
+{
+	u64 seed =3D lower_48_bits(iter->seed);
+	u64 guard =3D get_unaligned_be64(&pi->guard_tag);
+	u64 ref =3D get_unaligned_be48(pi->ref_tag);
+	u16 app =3D get_unaligned_be16(&pi->app_tag);
+
+	if (iter->bi->flags & BLK_INTEGRITY_REF_TAG) {
+		if (app =3D=3D APP_TAG_ESCAPE)
+			return BLK_STS_OK;
+		if (ref !=3D seed) {
+			pr_err("%s: ref tag error at location %llu (rcvd %llu)\n",
+				iter->bio->bi_bdev->bd_disk->disk_name, seed,
+				ref);
+			return BLK_STS_PROTECTION;
 		}
+	} else if (app =3D=3D APP_TAG_ESCAPE && ext_pi_ref_escape(pi->ref_tag))=
 {
+		return BLK_STS_OK;
+	}
+
+	if (guard !=3D iter->csum) {
+		pr_err("%s: guard tag error at sector %llu (rcvd %016llx, want %016llx=
)\n",
+			iter->bio->bi_bdev->bd_disk->disk_name, iter->seed,
+			guard, iter->csum);
+		return BLK_STS_PROTECTION;
+	}
+
+	return BLK_STS_OK;
+}
=20
-		csum =3D t10_pi_csum(0, iter->data_buf, iter->interval,
-				bi->csum_type);
-		if (offset)
-			csum =3D t10_pi_csum(csum, iter->prot_buf, offset,
-					bi->csum_type);
-
-		if (pi->guard_tag !=3D csum) {
-			pr_err("%s: guard tag error at sector %llu " \
-			       "(rcvd %04x, want %04x)\n", iter->disk_name,
-			       (unsigned long long)iter->seed,
-			       be16_to_cpu(pi->guard_tag), be16_to_cpu(csum));
+static blk_status_t blk_verify_pi(struct blk_integrity_iter *iter,
+				      struct t10_pi_tuple *pi, u16 guard)
+{
+	u32 seed =3D lower_32_bits(iter->seed);
+	u32 ref =3D get_unaligned_be32(&pi->ref_tag);
+	u16 app =3D get_unaligned_be16(&pi->app_tag);
+
+	if (iter->bi->flags & BLK_INTEGRITY_REF_TAG) {
+		if (app =3D=3D APP_TAG_ESCAPE)
+			return BLK_STS_OK;
+		if (ref !=3D seed) {
+			pr_err("%s: ref tag error at location %u (rcvd %u)\n",
+				iter->bio->bi_bdev->bd_disk->disk_name, seed,
+				ref);
 			return BLK_STS_PROTECTION;
 		}
+	} else if (app =3D=3D APP_TAG_ESCAPE && ref =3D=3D REF_TAG_ESCAPE) {
+		return BLK_STS_OK;
+	}
=20
-next:
-		iter->data_buf +=3D iter->interval;
-		iter->prot_buf +=3D bi->metadata_size;
-		iter->seed++;
+	if (guard !=3D (u16)iter->csum) {
+		pr_err("%s: guard tag error at sector %llu (rcvd %04x, want %04x)\n",
+			iter->bio->bi_bdev->bd_disk->disk_name, iter->seed,
+			guard, (u16)iter->csum);
+		return BLK_STS_PROTECTION;
 	}
=20
 	return BLK_STS_OK;
 }
=20
-/**
- * t10_pi_type1_prepare - prepare PI prior submitting request to device
- * @rq:              request with PI that should be prepared
- *
- * For Type 1/Type 2, the virtual start sector is the one that was
- * originally submitted by the block layer for the ref_tag usage. Due to
- * partitioning, MD/DM cloning, etc. the actual physical start sector is
- * likely to be different. Remap protection information to match the
- * physical LBA.
- */
-static void t10_pi_type1_prepare(struct request *rq)
+static blk_status_t blk_verify_t10_pi(struct blk_integrity_iter *iter,
+				      struct t10_pi_tuple *pi)
 {
-	struct blk_integrity *bi =3D &rq->q->limits.integrity;
-	const int tuple_sz =3D bi->metadata_size;
-	u32 ref_tag =3D t10_pi_ref_tag(rq);
-	u8 offset =3D bi->pi_offset;
-	struct bio *bio;
+	u16 guard =3D get_unaligned_be16(&pi->guard_tag);
=20
-	__rq_for_each_bio(bio, rq) {
-		struct bio_integrity_payload *bip =3D bio_integrity(bio);
-		u32 virt =3D bip_get_seed(bip) & 0xffffffff;
-		struct bio_vec iv;
-		struct bvec_iter iter;
+	return blk_verify_pi(iter, pi, guard);
+}
=20
-		/* Already remapped? */
-		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
-			break;
+static blk_status_t blk_verify_ip_pi(struct blk_integrity_iter *iter,
+				     struct t10_pi_tuple *pi)
+{
+	u16 guard =3D get_unaligned((u16 *)&pi->guard_tag);
=20
-		bip_for_each_vec(iv, bip, iter) {
-			unsigned int j;
-			void *p;
-
-			p =3D bvec_kmap_local(&iv);
-			for (j =3D 0; j < iv.bv_len; j +=3D tuple_sz) {
-				struct t10_pi_tuple *pi =3D p + offset;
-
-				if (be32_to_cpu(pi->ref_tag) =3D=3D virt)
-					pi->ref_tag =3D cpu_to_be32(ref_tag);
-				virt++;
-				ref_tag++;
-				p +=3D tuple_sz;
-			}
-			kunmap_local(p);
-		}
+	return blk_verify_pi(iter, pi, guard);
+}
=20
-		bip->bip_flags |=3D BIP_MAPPED_INTEGRITY;
+static blk_status_t blk_integrity_verify(struct blk_integrity_iter *iter=
,
+					 union pi_tuple *tuple)
+{
+	switch (iter->bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		return blk_verify_ext_pi(iter, &tuple->crc64_pi);
+	case BLK_INTEGRITY_CSUM_CRC:
+		return blk_verify_t10_pi(iter, &tuple->t10_pi);
+	case BLK_INTEGRITY_CSUM_IP:
+		return blk_verify_ip_pi(iter, &tuple->t10_pi);
+	default:
+		return BLK_STS_OK;
 	}
 }
=20
-/**
- * t10_pi_type1_complete - prepare PI prior returning request to the blk=
 layer
- * @rq:              request with PI that should be prepared
- * @nr_bytes:        total bytes to prepare
- *
- * For Type 1/Type 2, the virtual start sector is the one that was
- * originally submitted by the block layer for the ref_tag usage. Due to
- * partitioning, MD/DM cloning, etc. the actual physical start sector is
- * likely to be different. Since the physical start sector was submitted
- * to the device, we should remap it back to virtual values expected by =
the
- * block layer.
- */
-static void t10_pi_type1_complete(struct request *rq, unsigned int nr_by=
tes)
+static void blk_set_ext_pi(struct blk_integrity_iter *iter,
+			   struct crc64_pi_tuple *pi)
 {
-	struct blk_integrity *bi =3D &rq->q->limits.integrity;
-	unsigned intervals =3D nr_bytes >> bi->interval_exp;
-	const int tuple_sz =3D bi->metadata_size;
-	u32 ref_tag =3D t10_pi_ref_tag(rq);
-	u8 offset =3D bi->pi_offset;
-	struct bio *bio;
+	put_unaligned_be64(iter->csum, &pi->guard_tag);
+	put_unaligned_be16(0, &pi->app_tag);
+	put_unaligned_be48(iter->seed, &pi->ref_tag);
+}
=20
-	__rq_for_each_bio(bio, rq) {
-		struct bio_integrity_payload *bip =3D bio_integrity(bio);
-		u32 virt =3D bip_get_seed(bip) & 0xffffffff;
-		struct bio_vec iv;
-		struct bvec_iter iter;
-
-		bip_for_each_vec(iv, bip, iter) {
-			unsigned int j;
-			void *p;
-
-			p =3D bvec_kmap_local(&iv);
-			for (j =3D 0; j < iv.bv_len && intervals; j +=3D tuple_sz) {
-				struct t10_pi_tuple *pi =3D p + offset;
-
-				if (be32_to_cpu(pi->ref_tag) =3D=3D ref_tag)
-					pi->ref_tag =3D cpu_to_be32(virt);
-				virt++;
-				ref_tag++;
-				intervals--;
-				p +=3D tuple_sz;
-			}
-			kunmap_local(p);
-		}
+static void blk_set_pi(struct blk_integrity_iter *iter,
+		       struct t10_pi_tuple *pi, __be16 csum)
+{
+	put_unaligned(csum, &pi->guard_tag);
+	put_unaligned_be16(0, &pi->app_tag);
+	put_unaligned_be32(iter->seed, &pi->ref_tag);
+}
+
+static void blk_set_t10_pi(struct blk_integrity_iter *iter,
+			   struct t10_pi_tuple *pi)
+{
+	blk_set_pi(iter, pi, cpu_to_be16((u16)iter->csum));
+}
+
+static void blk_set_ip_pi(struct blk_integrity_iter *iter,
+			  struct t10_pi_tuple *pi)
+{
+	blk_set_pi(iter, pi, (__force __be16)(u16)iter->csum);
+}
+
+static void blk_integrity_set(struct blk_integrity_iter *iter,
+			      union pi_tuple *tuple)
+{
+	switch (iter->bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		return blk_set_ext_pi(iter, &tuple->crc64_pi);
+	case BLK_INTEGRITY_CSUM_CRC:
+		return blk_set_t10_pi(iter, &tuple->t10_pi);
+	case BLK_INTEGRITY_CSUM_IP:
+		return blk_set_ip_pi(iter, &tuple->t10_pi);
+	default:
+		WARN_ON_ONCE(1);
+		return;
 	}
 }
=20
-static __be64 ext_pi_crc64(u64 crc, void *data, unsigned int len)
+static blk_status_t blk_integrity_interval(struct blk_integrity_iter *it=
er,
+					   bool verify)
 {
-	return cpu_to_be64(crc64_nvme(crc, data, len));
+	blk_status_t ret =3D BLK_STS_OK;
+	union pi_tuple tuple;
+	void *ptuple =3D &tuple;
+	struct bio_vec pbv;
+
+	blk_integrity_csum_offset(iter);
+	pbv =3D bvec_iter_bvec(iter->bip->bip_vec, iter->prot_iter);
+	if (pbv.bv_len >=3D iter->bi->pi_tuple_size) {
+		ptuple =3D bvec_kmap_local(&pbv);
+		bvec_iter_advance_single(iter->bip->bip_vec, &iter->prot_iter,
+				iter->bi->metadata_size - iter->bi->pi_offset);
+	} else if (verify) {
+		blk_integrity_copy_to_tuple(iter->bip, &iter->prot_iter,
+				ptuple, iter->bi->pi_tuple_size);
+	}
+
+	if (verify)
+		ret =3D blk_integrity_verify(iter, ptuple);
+	else
+		blk_integrity_set(iter, ptuple);
+
+	if (likely(ptuple !=3D &tuple)) {
+		kunmap_local(ptuple);
+	} else if (!verify) {
+		blk_integrity_copy_from_tuple(iter->bip, &iter->prot_iter,
+				ptuple, iter->bi->pi_tuple_size);
+	}
+
+	iter->interval_remaining =3D 1 << iter->bi->interval_exp;
+	iter->csum =3D 0;
+	iter->seed++;
+	return ret;
 }
=20
-static void ext_pi_crc64_generate(struct blk_integrity_iter *iter,
-		struct blk_integrity *bi)
+static void blk_integrity_iterate(struct bio *bio, struct bvec_iter *dat=
a_iter,
+				  bool verify)
 {
-	u8 offset =3D bi->pi_offset;
-	unsigned int i;
+	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
+	struct bio_integrity_payload *bip =3D bio_integrity(bio);
+	struct blk_integrity_iter iter =3D {
+		.bio =3D bio,
+		.bip =3D bip,
+		.bi =3D bi,
+		.data_iter =3D *data_iter,
+		.prot_iter =3D bip->bip_iter,
+		.interval_remaining =3D 1 << bi->interval_exp,
+		.seed =3D data_iter->bi_sector,
+		.csum =3D 0,
+	};
+	blk_status_t ret =3D BLK_STS_OK;
+
+	while (iter.data_iter.bi_size && ret =3D=3D BLK_STS_OK) {
+		struct bio_vec bv =3D bvec_iter_bvec(iter.bio->bi_io_vec,
+						   iter.data_iter);
+		void *kaddr =3D bvec_kmap_local(&bv);
+		void *data =3D kaddr;
+		unsigned int len;
+
+		bvec_iter_advance_single(iter.bio->bi_io_vec, &iter.data_iter,
+					 bv.bv_len);
+		while (bv.bv_len && ret =3D=3D BLK_STS_OK) {
+			len =3D min(iter.interval_remaining, bv.bv_len);
+			blk_calculate_guard(&iter, data, len);
+			bv.bv_len -=3D len;
+			data +=3D len;
+			iter.interval_remaining -=3D len;
+			if (!iter.interval_remaining)
+				ret =3D blk_integrity_interval(&iter, verify);
+		}
+		kunmap_local(kaddr);
+	}
=20
-	for (i =3D 0 ; i < iter->data_size ; i +=3D iter->interval) {
-		struct crc64_pi_tuple *pi =3D iter->prot_buf + offset;
+	if (ret)
+		bio->bi_status =3D ret;
+}
=20
-		pi->guard_tag =3D ext_pi_crc64(0, iter->data_buf, iter->interval);
-		if (offset)
-			pi->guard_tag =3D ext_pi_crc64(be64_to_cpu(pi->guard_tag),
-					iter->prot_buf, offset);
-		pi->app_tag =3D 0;
+void blk_integrity_generate(struct bio *bio)
+{
+	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
=20
-		if (bi->flags & BLK_INTEGRITY_REF_TAG)
-			put_unaligned_be48(iter->seed, pi->ref_tag);
-		else
-			put_unaligned_be48(0ULL, pi->ref_tag);
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		blk_integrity_iterate(bio, &bio->bi_iter, false);
+		break;
+	default:
+		break;
+	}
+}
=20
-		iter->data_buf +=3D iter->interval;
-		iter->prot_buf +=3D bi->metadata_size;
-		iter->seed++;
+void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_=
iter)
+{
+	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
+
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		blk_integrity_iterate(bio, saved_iter, true);
+		break;
+	default:
+		break;
 	}
 }
=20
-static bool ext_pi_ref_escape(const u8 ref_tag[6])
+/*
+ * Advance @iter past the protection offset for protection formats that
+ * contain front padding on the metadata region.
+ */
+static void blk_pi_advance_offset(struct blk_integrity *bi,
+				  struct bio_integrity_payload *bip,
+				  struct bvec_iter *iter)
 {
-	static const u8 ref_escape[6] =3D { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff =
};
+	unsigned int offset =3D bi->pi_offset;
=20
-	return memcmp(ref_tag, ref_escape, sizeof(ref_escape)) =3D=3D 0;
+	while (offset > 0) {
+		struct bio_vec bv =3D mp_bvec_iter_bvec(bip->bip_vec, *iter);
+		unsigned int len =3D min(bv.bv_len, offset);
+
+		bvec_iter_advance_single(bip->bip_vec, iter, len);
+		offset -=3D len;
+	}
 }
=20
-static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
-		struct blk_integrity *bi)
-{
-	u8 offset =3D bi->pi_offset;
-	unsigned int i;
-
-	for (i =3D 0; i < iter->data_size; i +=3D iter->interval) {
-		struct crc64_pi_tuple *pi =3D iter->prot_buf + offset;
-		u64 ref, seed;
-		__be64 csum;
-
-		if (bi->flags & BLK_INTEGRITY_REF_TAG) {
-			if (pi->app_tag =3D=3D T10_PI_APP_ESCAPE)
-				goto next;
-
-			ref =3D get_unaligned_be48(pi->ref_tag);
-			seed =3D lower_48_bits(iter->seed);
-			if (ref !=3D seed) {
-				pr_err("%s: ref tag error at location %llu (rcvd %llu)\n",
-					iter->disk_name, seed, ref);
-				return BLK_STS_PROTECTION;
-			}
-		} else {
-			if (pi->app_tag =3D=3D T10_PI_APP_ESCAPE &&
-			    ext_pi_ref_escape(pi->ref_tag))
-				goto next;
-		}
+static void *blk_tuple_remap_begin(union pi_tuple *tuple,
+				   struct blk_integrity *bi,
+				   struct bio_integrity_payload *bip,
+				   struct bvec_iter *iter)
+{
+	struct bvec_iter titer;
+	struct bio_vec pbv;
=20
-		csum =3D ext_pi_crc64(0, iter->data_buf, iter->interval);
-		if (offset)
-			csum =3D ext_pi_crc64(be64_to_cpu(csum), iter->prot_buf,
-					    offset);
+	blk_pi_advance_offset(bi, bip, iter);
+	pbv =3D bvec_iter_bvec(bip->bip_vec, *iter);
+	if (likely(pbv.bv_len >=3D bi->pi_tuple_size))
+		return bvec_kmap_local(&pbv);
=20
-		if (pi->guard_tag !=3D csum) {
-			pr_err("%s: guard tag error at sector %llu " \
-			       "(rcvd %016llx, want %016llx)\n",
-				iter->disk_name, (unsigned long long)iter->seed,
-				be64_to_cpu(pi->guard_tag), be64_to_cpu(csum));
-			return BLK_STS_PROTECTION;
-		}
+	/*
+	 * We need to preserve the state of the original iter for the
+	 * copy_from_tuple at the end, so make a temp iter for here.
+	 */
+	titer =3D *iter;
+	blk_integrity_copy_to_tuple(bip, &titer, tuple, bi->pi_tuple_size);
+	return tuple;
+}
=20
-next:
-		iter->data_buf +=3D iter->interval;
-		iter->prot_buf +=3D bi->metadata_size;
-		iter->seed++;
+static void blk_tuple_remap_end(union pi_tuple *tuple, void *ptuple,
+				struct blk_integrity *bi,
+				struct bio_integrity_payload *bip,
+				struct bvec_iter *iter)
+{
+	unsigned int len =3D bi->metadata_size - bi->pi_offset;
+
+	if (likely(ptuple !=3D tuple)) {
+		kunmap_local(ptuple);
+	} else {
+		blk_integrity_copy_from_tuple(bip, iter, ptuple,
+				bi->pi_tuple_size);
+		len -=3D bi->pi_tuple_size;
 	}
=20
-	return BLK_STS_OK;
+	bvec_iter_advance(bip->bip_vec, iter, len);
 }
=20
-static void ext_pi_type1_prepare(struct request *rq)
+static void blk_set_ext_unmap_ref(struct crc64_pi_tuple *pi, u64 virt,
+				  u64 ref_tag)
 {
-	struct blk_integrity *bi =3D &rq->q->limits.integrity;
-	const int tuple_sz =3D bi->metadata_size;
-	u64 ref_tag =3D ext_pi_ref_tag(rq);
-	u8 offset =3D bi->pi_offset;
-	struct bio *bio;
+	u64 ref =3D get_unaligned_be48(&pi->ref_tag);
=20
-	__rq_for_each_bio(bio, rq) {
-		struct bio_integrity_payload *bip =3D bio_integrity(bio);
-		u64 virt =3D lower_48_bits(bip_get_seed(bip));
-		struct bio_vec iv;
-		struct bvec_iter iter;
+	if (ref =3D=3D lower_48_bits(ref_tag) && ref !=3D lower_48_bits(virt))
+		put_unaligned_be48(virt, pi->ref_tag);
+}
=20
-		/* Already remapped? */
-		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
-			break;
+static void blk_set_t10_unmap_ref(struct t10_pi_tuple *pi, u32 virt,
+				  u32 ref_tag)
+{
+	u32 ref =3D get_unaligned_be32(&pi->ref_tag);
=20
-		bip_for_each_vec(iv, bip, iter) {
-			unsigned int j;
-			void *p;
-
-			p =3D bvec_kmap_local(&iv);
-			for (j =3D 0; j < iv.bv_len; j +=3D tuple_sz) {
-				struct crc64_pi_tuple *pi =3D p +  offset;
-				u64 ref =3D get_unaligned_be48(pi->ref_tag);
-
-				if (ref =3D=3D virt)
-					put_unaligned_be48(ref_tag, pi->ref_tag);
-				virt++;
-				ref_tag++;
-				p +=3D tuple_sz;
-			}
-			kunmap_local(p);
-		}
+	if (ref =3D=3D ref_tag && ref !=3D virt)
+		put_unaligned_be32(virt, &pi->ref_tag);
+}
=20
-		bip->bip_flags |=3D BIP_MAPPED_INTEGRITY;
+static void blk_reftag_remap_complete(struct blk_integrity *bi,
+				      union pi_tuple *tuple, u64 virt, u64 ref)
+{
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		blk_set_ext_unmap_ref(&tuple->crc64_pi, virt, ref);
+		break;
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		blk_set_t10_unmap_ref(&tuple->t10_pi, virt, ref);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
 	}
 }
=20
-static void ext_pi_type1_complete(struct request *rq, unsigned int nr_by=
tes)
+static void blk_set_ext_map_ref(struct crc64_pi_tuple *pi, u64 virt,
+				u64 ref_tag)
 {
-	struct blk_integrity *bi =3D &rq->q->limits.integrity;
-	unsigned intervals =3D nr_bytes >> bi->interval_exp;
-	const int tuple_sz =3D bi->metadata_size;
-	u64 ref_tag =3D ext_pi_ref_tag(rq);
-	u8 offset =3D bi->pi_offset;
-	struct bio *bio;
+	u64 ref =3D get_unaligned_be48(&pi->ref_tag);
=20
-	__rq_for_each_bio(bio, rq) {
-		struct bio_integrity_payload *bip =3D bio_integrity(bio);
-		u64 virt =3D lower_48_bits(bip_get_seed(bip));
-		struct bio_vec iv;
-		struct bvec_iter iter;
-
-		bip_for_each_vec(iv, bip, iter) {
-			unsigned int j;
-			void *p;
-
-			p =3D bvec_kmap_local(&iv);
-			for (j =3D 0; j < iv.bv_len && intervals; j +=3D tuple_sz) {
-				struct crc64_pi_tuple *pi =3D p + offset;
-				u64 ref =3D get_unaligned_be48(pi->ref_tag);
-
-				if (ref =3D=3D ref_tag)
-					put_unaligned_be48(virt, pi->ref_tag);
-				virt++;
-				ref_tag++;
-				intervals--;
-				p +=3D tuple_sz;
-			}
-			kunmap_local(p);
-		}
-	}
+	if (ref =3D=3D lower_48_bits(virt) && ref !=3D ref_tag)
+		put_unaligned_be48(ref_tag, pi->ref_tag);
 }
=20
-void blk_integrity_generate(struct bio *bio)
+static void blk_set_t10_map_ref(struct t10_pi_tuple *pi, u32 virt, u32 r=
ef_tag)
 {
-	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
-	struct bio_integrity_payload *bip =3D bio_integrity(bio);
-	struct blk_integrity_iter iter;
-	struct bvec_iter bviter;
-	struct bio_vec bv;
-
-	iter.disk_name =3D bio->bi_bdev->bd_disk->disk_name;
-	iter.interval =3D 1 << bi->interval_exp;
-	iter.seed =3D bio->bi_iter.bi_sector;
-	iter.prot_buf =3D bvec_virt(bip->bip_vec);
-	bio_for_each_segment(bv, bio, bviter) {
-		void *kaddr =3D bvec_kmap_local(&bv);
+	u32 ref =3D get_unaligned_be32(&pi->ref_tag);
=20
-		iter.data_buf =3D kaddr;
-		iter.data_size =3D bv.bv_len;
-		switch (bi->csum_type) {
-		case BLK_INTEGRITY_CSUM_CRC64:
-			ext_pi_crc64_generate(&iter, bi);
-			break;
-		case BLK_INTEGRITY_CSUM_CRC:
-		case BLK_INTEGRITY_CSUM_IP:
-			t10_pi_generate(&iter, bi);
-			break;
-		default:
-			break;
-		}
-		kunmap_local(kaddr);
+	if (ref =3D=3D virt && ref !=3D ref_tag)
+		put_unaligned_be32(ref_tag, &pi->ref_tag);
+}
+
+static void blk_reftag_remap_prepare(struct blk_integrity *bi,
+				     union pi_tuple *tuple,
+				     u64 virt, u64 ref)
+{
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		blk_set_ext_map_ref(&tuple->crc64_pi, virt, ref);
+		break;
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		blk_set_t10_map_ref(&tuple->t10_pi, virt, ref);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
 	}
 }
=20
-void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_=
iter)
+static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi=
,
+			       unsigned *intervals, u64 *ref, bool prep)
 {
-	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip =3D bio_integrity(bio);
-	struct blk_integrity_iter iter;
-	struct bvec_iter bviter;
-	struct bio_vec bv;
+	struct bvec_iter iter =3D bip->bip_iter;
+	u64 virt =3D bip_get_seed(bip);
+	union pi_tuple *ptuple;
+	union pi_tuple tuple;
=20
-	/*
-	 * At the moment verify is called bi_iter has been advanced during spli=
t
-	 * and completion, so use the copy created during submission here.
-	 */
-	iter.disk_name =3D bio->bi_bdev->bd_disk->disk_name;
-	iter.interval =3D 1 << bi->interval_exp;
-	iter.seed =3D saved_iter->bi_sector;
-	iter.prot_buf =3D bvec_virt(bip->bip_vec);
-	__bio_for_each_segment(bv, bio, bviter, *saved_iter) {
-		void *kaddr =3D bvec_kmap_local(&bv);
-		blk_status_t ret =3D BLK_STS_OK;
+	if (prep && bip->bip_flags & BIP_MAPPED_INTEGRITY) {
+		*ref +=3D bio->bi_iter.bi_size >> bi->interval_exp;
+		return;
+	}
=20
-		iter.data_buf =3D kaddr;
-		iter.data_size =3D bv.bv_len;
-		switch (bi->csum_type) {
-		case BLK_INTEGRITY_CSUM_CRC64:
-			ret =3D ext_pi_crc64_verify(&iter, bi);
-			break;
-		case BLK_INTEGRITY_CSUM_CRC:
-		case BLK_INTEGRITY_CSUM_IP:
-			ret =3D t10_pi_verify(&iter, bi);
-			break;
-		default:
-			break;
-		}
-		kunmap_local(kaddr);
+	while (iter.bi_size && *intervals) {
+		ptuple =3D blk_tuple_remap_begin(&tuple, bi, bip, &iter);
=20
-		if (ret) {
-			bio->bi_status =3D ret;
-			return;
-		}
+		if (prep)
+			blk_reftag_remap_prepare(bi, ptuple, virt, *ref);
+		else
+			blk_reftag_remap_complete(bi, ptuple, virt, *ref);
+
+		blk_tuple_remap_end(&tuple, ptuple, bi, bip, &iter);
+		(*intervals)--;
+		(*ref)++;
+		virt++;
 	}
+
+	if (prep)
+		bip->bip_flags |=3D BIP_MAPPED_INTEGRITY;
 }
=20
-void blk_integrity_prepare(struct request *rq)
+static void blk_integrity_remap(struct request *rq, unsigned int nr_byte=
s,
+				bool prep)
 {
 	struct blk_integrity *bi =3D &rq->q->limits.integrity;
+	u64 ref =3D blk_rq_pos(rq) >> (bi->interval_exp - SECTOR_SHIFT);
+	unsigned intervals =3D nr_bytes >> bi->interval_exp;
+	struct bio *bio;
=20
 	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
 		return;
=20
-	if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_CRC64)
-		ext_pi_type1_prepare(rq);
-	else
-		t10_pi_type1_prepare(rq);
+	__rq_for_each_bio(bio, rq) {
+		__blk_reftag_remap(bio, bi, &intervals, &ref, prep);
+		if (!intervals)
+			break;
+	}
 }
=20
-void blk_integrity_complete(struct request *rq, unsigned int nr_bytes)
+void blk_integrity_prepare(struct request *rq)
 {
-	struct blk_integrity *bi =3D &rq->q->limits.integrity;
-
-	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
-		return;
+	blk_integrity_remap(rq, blk_rq_bytes(rq), true);
+}
=20
-	if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_CRC64)
-		ext_pi_type1_complete(rq, nr_bytes);
-	else
-		t10_pi_type1_complete(rq, nr_bytes);
+void blk_integrity_complete(struct request *rq, unsigned int nr_bytes)
+{
+	blk_integrity_remap(rq, nr_bytes, false);
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001f..fa534f1d6b27a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1874,6 +1874,7 @@ static bool nvme_init_integrity(struct nvme_ns_head=
 *head,
 		break;
 	}
=20
+	bi->flags |=3D BLK_SPLIT_INTERVAL_CAPABLE;
 	bi->metadata_size =3D head->ms;
 	if (bi->csum_type) {
 		bi->pi_tuple_size =3D head->pi_size;
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index a6b84206eb94c..1f937373e56b6 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -19,6 +19,7 @@ enum blk_integrity_flags {
 	BLK_INTEGRITY_DEVICE_CAPABLE	=3D 1 << 2,
 	BLK_INTEGRITY_REF_TAG		=3D 1 << 3,
 	BLK_INTEGRITY_STACKED		=3D 1 << 4,
+	BLK_SPLIT_INTERVAL_CAPABLE	=3D 1 << 5,
 };
=20
 const char *blk_integrity_profile_name(struct blk_integrity *bi);
--=20
2.47.3

