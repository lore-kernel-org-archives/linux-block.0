Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67044314A65
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296141; cv=none; b=oMs+eKjkN8RWTmhRVSpA51MA9vptOFS1WqAFxbTc8RD8TgE6tO460TOGSQnIB/pjOr7gmmbLYOqS8XShL4jtMrTGfAOlNU4RRvGLLmX492agt0ZJTDoagQkMCjM1jgj7gT8lTDmo7nLspzhAeUsqD8k6aBb/raQVGPmpFoizSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296141; c=relaxed/simple;
	bh=QNgZ66A7ScPN/XsKdrarKjNMzRCQKq30YYjFAsnIy68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cFioLs5TTZHSA8fhUHaYtHIDpkWgJ36wJfajt78Vnnl9ijGfBV1K+uy52U9OrGPwOQVaMSfsc6Nf3J8Ei1aOQ/DBcz1oBoybAdVQt5bE1fh+vkkTEwT4QQS9vWdH+i2F01eoI2qfNFL86aHYK8bPGyaKyofuH6Lp6bBbaE+twIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vGL59jhb; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vGL59jhb"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4HUCdr2048430
	for <linux-block@vger.kernel.org>; Tue, 4 Nov 2025 14:42:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=WPYj8IKL08VaLPjF++
	OW/xDVOuOVmofnOlQ0MUXt9gw=; b=vGL59jhbGh1QUUmlvMyww1jxfXl3X2DfJw
	Ve10N6Ihok8hiwMzhGYsPWLUJm/QfbMRfJJ304HYrfoLQ2ZRMfPbS75lWQhMd+Vi
	69JGldSWzSSs1pAmu5knDrkXZhEPVuOcAKXP6NDE+WZud+OZPypEOgsx75b77G2d
	ryir5vHoEtu/RQaFdrfc790leQ4lX4H/UG8g6v0cLp/6UCHl5ZagSnoODyz8PX97
	Gkh065nxO4GLtU9XSvXCg4hoaizAZpfbFwPwGDX+hP/6l/XdMwf9y55SFx9yE48n
	zO1plV4WSfqxdyH9KNFgXAC9fBxUlLDLZ0TdTym+fwmPk2m9GWGQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a7nxramxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 14:42:16 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 4 Nov 2025 22:42:15 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 3452436EB435; Tue,  4 Nov 2025 14:42:05 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <hch@lst.de>, <martin.petersen@oracle.com>
CC: <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [RFC PATCH] blk-integrity: support arbitrary buffer alignment
Date: Tue, 4 Nov 2025 14:40:45 -0800
Message-ID: <20251104224045.3396384-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=S43UAYsP c=1 sm=1 tr=0 ts=690a8149 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=DiMilDjMHV9Hk4Sv8ggA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE5MSBTYWx0ZWRfX2917gTtNafdK
 4eDGVLPdp3eJ4UtQwnHeB4uOH5vw5PjfGv3p9/RXHGbNDprz2T50g8dS82B53sKoXCfL6XkaHm7
 SLzqsUlwnJTMppng417r4zA+9NhGBnVNjBDyhQFLVTvV7mUpOh2lKwGlOMUA9H52zipG+EVv9QA
 nLr4J7pRBwmvp4gJCjAeRCDHlj+E3Yg/X+0j6CVEQLVbAVnbIqOloarNA0OzxZAEKLP6lcmDGwa
 2nIBTQOTDU+1Ol9p5UvuIy1QT6f0qgWjB7YLqkHi2AjscknF04nDQCYd7/c4vbTSLhjWRvuvcy7
 l2dRLis+SgQL2fTEIw8GO9FPQpXjHWZDDbZPtiDS07NQAFk6+2z9D7zRE6alUSt5DNSMr7LS53C
 TzklsMTDD6VbK3zfbmx1EFDAgkyEyw==
X-Proofpoint-GUID: QTRDH6YdhOYvFinSTwLgY-3SX6SUaYnT
X-Proofpoint-ORIG-GUID: QTRDH6YdhOYvFinSTwLgY-3SX6SUaYnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_04,2025-11-03_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A bio segment might have partial block data with the rest continuing
into the next segments.

At the same time, the protection information may also be split in
multiple segments. The most likely way that may happen is if two
requests merge, or if we're directly using the io_uring user metadata.
Further, it may be possible to have unalign the protection fields from
the user space buffer, or if there are odd additional opaque bytes in
front or in back of the protection information metadata region.

Change up the iteration to allow spanning multiple segments. This patch
is mostly a re-write of the protection information handling to allow any
arbitrary alignments, so it's probably easier to review the end result
rather than the diff.

Note, this strives to be a very general solution that should work in
scenarios that I think unlikely to ever encounter in real life. The
original goal was to simply remove the 'lim->dma_alignment' that
protection information was imposing, and it wasn't too much further to
support even arbitrary integrity buffers either.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-settings.c   |  10 -
 block/t10-pi.c         | 858 ++++++++++++++++++++++++-----------------
 include/linux/t10-pi.h |   4 +-
 3 files changed, 505 insertions(+), 367 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index ccffa3ca85c36..345b6a271cc35 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -184,16 +184,6 @@ static int blk_validate_integrity_limits(struct queu=
e_limits *lim)
 	if (!bi->interval_exp)
 		bi->interval_exp =3D ilog2(lim->logical_block_size);
=20
-	/*
-	 * The PI generation / validation helpers do not expect intervals to
-	 * straddle multiple bio_vecs.  Enforce alignment so that those are
-	 * never generated, and that each buffer is aligned as expected.
-	 */
-	if (bi->csum_type) {
-		lim->dma_alignment =3D max(lim->dma_alignment,
-					(1U << bi->interval_exp) - 1);
-	}
-
 	return 0;
 }
=20
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c4ed97021460..1ead263de206b 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -12,230 +12,157 @@
 #include <linux/unaligned.h>
 #include "blk.h"
=20
+union pi_tuple {
+	struct crc64_pi_tuple *crc64_pi;
+	struct t10_pi_tuple *t10_pi;
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
+
+	struct bvec_iter		data_iter;
+	struct bvec_iter		prot_iter;
+	unsigned int			interval_remaining;
+	u64				seed;
+	u64				crc;
 };
=20
-static __be16 t10_pi_csum(__be16 csum, void *data, unsigned int len,
-		unsigned char csum_type)
+static void blk_crc(struct blk_integrity_iter *iter, void *data, unsigne=
d int len)
 {
-	if (csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
-		return (__force __be16)ip_compute_csum(data, len);
-	return cpu_to_be16(crc_t10dif_update(be16_to_cpu(csum), data, len));
+	switch (iter->bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		iter->crc =3D crc64_nvme(iter->crc, data, len);
+		break;
+	case BLK_INTEGRITY_CSUM_CRC:
+		iter->crc =3D crc_t10dif_update(iter->crc, data, len);
+		break;
+	case BLK_INTEGRITY_CSUM_IP:
+		iter->crc =3D csum_partial(data, len, iter->crc);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		iter->crc =3D U64_MAX;
+		break;
+	}
 }
=20
-/*
- * Type 1 and Type 2 protection use the same format: 16 bit guard tag,
- * 16 bit app tag, 32 bit reference tag. Type 3 does not define the ref
- * tag.
+/**
+ * blk_integrity_crc_offset - update the crc for formats that have metad=
ata
+ * 			      padding in front of the protection information
+ * 			      field.
  */
-static void t10_pi_generate(struct blk_integrity_iter *iter,
-		struct blk_integrity *bi)
+static void blk_integrity_crc_offset(struct blk_integrity_iter *iter)
 {
-	u8 offset =3D bi->pi_offset;
-	unsigned int i;
-
-	for (i =3D 0 ; i < iter->data_size ; i +=3D iter->interval) {
-		struct t10_pi_tuple *pi =3D iter->prot_buf + offset;
-
-		pi->guard_tag =3D t10_pi_csum(0, iter->data_buf, iter->interval,
-				bi->csum_type);
-		if (offset)
-			pi->guard_tag =3D t10_pi_csum(pi->guard_tag,
-					iter->prot_buf, offset, bi->csum_type);
-		pi->app_tag =3D 0;
-
-		if (bi->flags & BLK_INTEGRITY_REF_TAG)
-			pi->ref_tag =3D cpu_to_be32(lower_32_bits(iter->seed));
-		else
-			pi->ref_tag =3D 0;
-
-		iter->data_buf +=3D iter->interval;
-		iter->prot_buf +=3D bi->metadata_size;
-		iter->seed++;
+	unsigned int offset =3D iter->bi->pi_offset;
+
+	while (offset > 0) {
+		struct bio_vec pbv =3D mp_bvec_iter_bvec(iter->bip->bip_vec,
+						       iter->prot_iter);
+		unsigned int len =3D min(pbv.bv_len, offset);
+		void *prot_buf =3D bvec_kmap_local(&pbv);
+
+		bvec_iter_advance_single(iter->bip->bip_vec, &iter->prot_iter, len);
+		blk_crc(iter, prot_buf, len);
+		kunmap_local(prot_buf);
+		offset -=3D len;
 	}
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
-		}
-
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
-			return BLK_STS_PROTECTION;
-		}
-
-next:
-		iter->data_buf +=3D iter->interval;
-		iter->prot_buf +=3D bi->metadata_size;
-		iter->seed++;
+static void __blk_integrity_copy_from_tuple(struct bio_integrity_payload=
 *bip,
+		struct bvec_iter *iter, void *tuple, unsigned int tuple_size)
+{
+	while (tuple_size) {
+		struct bio_vec pbv =3D mp_bvec_iter_bvec(bip->bip_vec, *iter);
+		unsigned int len =3D min(tuple_size, pbv.bv_len);
+		void *prot_buf =3D bvec_kmap_local(&pbv);
+
+		bvec_iter_advance_single(bip->bip_vec, iter, len);
+		memcpy(prot_buf, tuple, len);
+		tuple +=3D len;
+		tuple_size -=3D len;
+		kunmap_local(prot_buf);
 	}
-
-	return BLK_STS_OK;
 }
=20
 /**
- * t10_pi_type1_prepare - prepare PI prior submitting request to device
- * @rq:              request with PI that should be prepared
- *
- * For Type 1/Type 2, the virtual start sector is the one that was
- * originally submitted by the block layer for the ref_tag usage. Due to
- * partitioning, MD/DM cloning, etc. the actual physical start sector is
- * likely to be different. Remap protection information to match the
- * physical LBA.
+ * blk_integrity_copy_from_tuple- copy from @tuple to the @iter
  */
-static void t10_pi_type1_prepare(struct request *rq)
+static void blk_integrity_copy_from_tuple(struct blk_integrity_iter *ite=
r,
+					  void *tuple)
 {
-	struct blk_integrity *bi =3D &rq->q->limits.integrity;
-	const int tuple_sz =3D bi->metadata_size;
-	u32 ref_tag =3D t10_pi_ref_tag(rq);
-	u8 offset =3D bi->pi_offset;
-	struct bio *bio;
-
-	__rq_for_each_bio(bio, rq) {
-		struct bio_integrity_payload *bip =3D bio_integrity(bio);
-		u32 virt =3D bip_get_seed(bip) & 0xffffffff;
-		struct bio_vec iv;
-		struct bvec_iter iter;
-
-		/* Already remapped? */
-		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
-			break;
-
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
+	__blk_integrity_copy_from_tuple(iter->bip, &iter->prot_iter,
+					tuple, iter->bi->pi_tuple_size);
+}
=20
-		bip->bip_flags |=3D BIP_MAPPED_INTEGRITY;
+static void __blk_integrity_copy_to_tuple(struct bio_integrity_payload *=
bip,
+		struct bvec_iter *iter, void *tuple, unsigned int tuple_size)
+{
+	while (tuple_size) {
+		struct bio_vec pbv =3D mp_bvec_iter_bvec(bip->bip_vec, *iter);
+		unsigned int len =3D min(tuple_size, pbv.bv_len);
+		void *prot_buf =3D bvec_kmap_local(&pbv);
+
+		bvec_iter_advance_single(bip->bip_vec, iter, len);
+		memcpy(tuple, prot_buf, len);
+		tuple +=3D len;
+		tuple_size -=3D len;
+		kunmap_local(prot_buf);
 	}
 }
=20
 /**
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
+ * blk_integrity_copy_to_tuple - copy to &tuple from  @iter
  */
-static void t10_pi_type1_complete(struct request *rq, unsigned int nr_by=
tes)
+static void blk_integrity_copy_to_tuple(struct blk_integrity_iter *iter,=
 void *tuple)
 {
-	struct blk_integrity *bi =3D &rq->q->limits.integrity;
-	unsigned intervals =3D nr_bytes >> bi->interval_exp;
-	const int tuple_sz =3D bi->metadata_size;
-	u32 ref_tag =3D t10_pi_ref_tag(rq);
-	u8 offset =3D bi->pi_offset;
-	struct bio *bio;
-
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
-	}
+	__blk_integrity_copy_to_tuple(iter->bip, &iter->prot_iter,
+					tuple, iter->bi->pi_tuple_size);
 }
=20
-static __be64 ext_pi_crc64(u64 crc, void *data, unsigned int len)
+static void blk_set_ext_pi(void *prot_buf, struct blk_integrity_iter *it=
er)
 {
-	return cpu_to_be64(crc64_nvme(crc, data, len));
+	struct crc64_pi_tuple *pi =3D prot_buf;
+
+	if (unlikely((unsigned long)prot_buf & (sizeof(*pi) - 1))) {
+		put_unaligned_be16(0, &pi->app_tag);
+		put_unaligned_be64(iter->crc, &pi->guard_tag);
+		put_unaligned_be48(iter->seed, &pi->ref_tag);
+	} else {
+		pi->app_tag =3D 0;
+		pi->guard_tag =3D cpu_to_be64(iter->crc);
+		put_unaligned_be48(iter->seed, &pi->ref_tag);
+	}
 }
=20
-static void ext_pi_crc64_generate(struct blk_integrity_iter *iter,
-		struct blk_integrity *bi)
+static void blk_set_t10_pi(void *prot_buf, struct blk_integrity_iter *it=
er)
 {
-	u8 offset =3D bi->pi_offset;
-	unsigned int i;
-
-	for (i =3D 0 ; i < iter->data_size ; i +=3D iter->interval) {
-		struct crc64_pi_tuple *pi =3D iter->prot_buf + offset;
+	struct t10_pi_tuple *pi =3D prot_buf;
=20
-		pi->guard_tag =3D ext_pi_crc64(0, iter->data_buf, iter->interval);
-		if (offset)
-			pi->guard_tag =3D ext_pi_crc64(be64_to_cpu(pi->guard_tag),
-					iter->prot_buf, offset);
+	if (unlikely((unsigned long)prot_buf & (sizeof(*pi) - 1))) {
+		put_unaligned_be16(0, &pi->app_tag);
+		put_unaligned_be16((u16)iter->crc, &pi->guard_tag);
+		put_unaligned_be32((u32)iter->seed, &pi->ref_tag);
+	} else {
 		pi->app_tag =3D 0;
+		pi->guard_tag =3D cpu_to_be16((u16)iter->crc);
+		pi->ref_tag =3D cpu_to_be32((u32)iter->seed);
+	}
+}
=20
-		if (bi->flags & BLK_INTEGRITY_REF_TAG)
-			put_unaligned_be48(iter->seed, pi->ref_tag);
-		else
-			put_unaligned_be48(0ULL, pi->ref_tag);
+static void blk_set_ip_pi(void *prot_buf, struct blk_integrity_iter *ite=
r)
+{
+	struct t10_pi_tuple *pi =3D prot_buf;
=20
-		iter->data_buf +=3D iter->interval;
-		iter->prot_buf +=3D bi->metadata_size;
-		iter->seed++;
+	if (unlikely((unsigned long)prot_buf & (sizeof(*pi) - 1))) {
+		put_unaligned_be16(0, &pi->app_tag);
+		__put_unaligned_t(__be16, (__force __be16)(iter->crc), &pi->guard_tag)=
;
+		put_unaligned_be32(iter->seed, &pi->ref_tag);
+	} else {
+		pi->app_tag =3D 0;
+		pi->guard_tag =3D (__force __be16)iter->crc;
+		pi->ref_tag =3D cpu_to_be32(iter->seed);
 	}
 }
=20
@@ -247,227 +174,448 @@ static bool ext_pi_ref_escape(const u8 ref_tag[6]=
)
 }
=20
 static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
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
+					struct crc64_pi_tuple *pi)
+{
+	u64 guard;
+	u64 ref;
+	u16 app;
+
+	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1))) {
+		app =3D get_unaligned_be16(&pi->app_tag);
+		guard =3D get_unaligned_be64(&pi->guard_tag);
+		ref =3D get_unaligned_be48(pi->ref_tag);
+	} else {
+		app =3D be16_to_cpu(pi->app_tag);
+		guard =3D be64_to_cpu(pi->guard_tag);
+		ref =3D get_unaligned_be48(pi->ref_tag);
+	}
=20
-		csum =3D ext_pi_crc64(0, iter->data_buf, iter->interval);
-		if (offset)
-			csum =3D ext_pi_crc64(be64_to_cpu(csum), iter->prot_buf,
-					    offset);
+	if (iter->bi->flags & BLK_INTEGRITY_REF_TAG) {
+		u64 seed =3D lower_48_bits(iter->seed);
=20
-		if (pi->guard_tag !=3D csum) {
-			pr_err("%s: guard tag error at sector %llu " \
-			       "(rcvd %016llx, want %016llx)\n",
-				iter->disk_name, (unsigned long long)iter->seed,
-				be64_to_cpu(pi->guard_tag), be64_to_cpu(csum));
+		if (app =3D=3D T10_PI_APP_ESCAPE)
+			return BLK_STS_OK;
+		if (ref !=3D seed) {
+			pr_err("%s: ref tag error at location %llu (rcvd %llu)\n",
+				iter->bio->bi_bdev->bd_disk->disk_name, seed,
+				ref);
 			return BLK_STS_PROTECTION;
 		}
+	} else if (app =3D=3D T10_PI_APP_ESCAPE &&
+		   ext_pi_ref_escape(pi->ref_tag)) {
+		return BLK_STS_OK;
+	}
=20
-next:
-		iter->data_buf +=3D iter->interval;
-		iter->prot_buf +=3D bi->metadata_size;
-		iter->seed++;
+	if (guard !=3D iter->crc) {
+		pr_err("%s: guard tag error at sector %llu (rcvd %016llx, want %016llx=
)\n",
+			iter->bio->bi_bdev->bd_disk->disk_name, iter->seed,
+			guard, iter->crc);
+		return BLK_STS_PROTECTION;
 	}
=20
 	return BLK_STS_OK;
 }
=20
-static void ext_pi_type1_prepare(struct request *rq)
+static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
+				  struct t10_pi_tuple *pi)
 {
-	struct blk_integrity *bi =3D &rq->q->limits.integrity;
-	const int tuple_sz =3D bi->metadata_size;
-	u64 ref_tag =3D ext_pi_ref_tag(rq);
-	u8 offset =3D bi->pi_offset;
-	struct bio *bio;
+	u16 guard;
+	u32 ref;
+	u16 app;
+
+	if (unlikely((unsigned long)pi  & (sizeof(*pi) - 1))) {
+		guard =3D get_unaligned_be16(&pi->guard_tag);
+		ref =3D get_unaligned_be32(&pi->ref_tag);
+		app =3D get_unaligned_be16(&pi->app_tag);
+	} else {
+		guard =3D be16_to_cpu(pi->guard_tag);
+		ref =3D be32_to_cpu(pi->ref_tag);
+		app =3D be16_to_cpu(pi->app_tag);
+	}
=20
-	__rq_for_each_bio(bio, rq) {
-		struct bio_integrity_payload *bip =3D bio_integrity(bio);
-		u64 virt =3D lower_48_bits(bip_get_seed(bip));
-		struct bio_vec iv;
-		struct bvec_iter iter;
-
-		/* Already remapped? */
-		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
-			break;
-
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
+	if (iter->bi->flags & BLK_INTEGRITY_REF_TAG) {
+		u32 seed =3D lower_32_bits(iter->seed);
+
+		if (app =3D=3D T10_PI_APP_ESCAPE)
+			return BLK_STS_OK;
+		if (ref !=3D seed) {
+			pr_err("%s: ref tag error at location %u (rcvd %u)\n",
+				iter->bio->bi_bdev->bd_disk->disk_name, seed,
+				ref);
+			return BLK_STS_PROTECTION;
 		}
+	} else if (app =3D=3D T10_PI_APP_ESCAPE &&
+		   ref =3D=3D T10_PI_REF_ESCAPE) {
+		return BLK_STS_OK;
+	}
=20
-		bip->bip_flags |=3D BIP_MAPPED_INTEGRITY;
+	if (guard !=3D (u16)iter->crc) {
+		pr_err("%s: guard tag error at sector %llu (rcvd %04x, want %04x)\n",
+			iter->bio->bi_bdev->bd_disk->disk_name, iter->seed,
+			guard, (u16)iter->crc);
+		return BLK_STS_PROTECTION;
 	}
+
+	return BLK_STS_OK;
 }
=20
-static void ext_pi_type1_complete(struct request *rq, unsigned int nr_by=
tes)
+static blk_status_t blk_integrity_verify(struct blk_integrity_iter *iter=
,
+				      void *tuple)
 {
-	struct blk_integrity *bi =3D &rq->q->limits.integrity;
-	unsigned intervals =3D nr_bytes >> bi->interval_exp;
-	const int tuple_sz =3D bi->metadata_size;
-	u64 ref_tag =3D ext_pi_ref_tag(rq);
-	u8 offset =3D bi->pi_offset;
-	struct bio *bio;
+	switch (iter->bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		return ext_pi_crc64_verify(iter, tuple);
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		return t10_pi_verify(iter, tuple);
+	default:
+		return BLK_STS_OK;
+	}
+}
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
+static void blk_integrity_set(struct blk_integrity_iter *iter,
+				 void *tuple)
+{
+	switch (iter->bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		return blk_set_ext_pi(tuple, iter);
+	case BLK_INTEGRITY_CSUM_CRC:
+		return blk_set_t10_pi(tuple, iter);
+	case BLK_INTEGRITY_CSUM_IP:
+		return blk_set_ip_pi(tuple, iter);
+	default:
+		WARN_ON_ONCE(1);
+		return;
 	}
 }
=20
-void blk_integrity_generate(struct bio *bio)
+static blk_status_t blk_integrity_interval(struct blk_integrity_iter *it=
er, bool verify)
+{
+	blk_status_t ret =3D BLK_STS_OK;
+	union pi_tuple tuple;
+	void *ptuple =3D &tuple;
+	struct bio_vec pbv;
+
+	blk_integrity_crc_offset(iter);
+	pbv =3D mp_bvec_iter_bvec(iter->bip->bip_vec, iter->prot_iter);
+	if (pbv.bv_len >=3D iter->bi->pi_tuple_size) {
+		ptuple =3D bvec_kmap_local(&pbv);
+		bvec_iter_advance_single(iter->bip->bip_vec, &iter->prot_iter,
+				iter->bi->metadata_size - iter->bi->pi_offset);
+	} else if (verify) {
+		blk_integrity_copy_to_tuple(iter, ptuple);
+	}
+
+	if (verify)
+		ret =3D blk_integrity_verify(iter, ptuple);
+	else
+		blk_integrity_set(iter, ptuple);
+
+	if (ptuple !=3D &tuple)
+		kunmap_local(ptuple);
+	else if (!verify)
+		blk_integrity_copy_from_tuple(iter, ptuple);
+
+	iter->interval_remaining =3D 1 << iter->bi->interval_exp;
+	iter->crc =3D 0;
+	iter->seed++;
+
+	return ret;
+}
+
+static void blk_integrity_iterate(struct bio *bio, struct bvec_iter *dat=
a_iter,
+				  bool verify)
 {
 	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip =3D bio_integrity(bio);
-	struct blk_integrity_iter iter;
-	struct bvec_iter bviter;
-	struct bio_vec bv;
-
-	iter.disk_name =3D bio->bi_bdev->bd_disk->disk_name;
-	iter.interval =3D 1 << bi->interval_exp;
-	iter.seed =3D bio->bi_iter.bi_sector;
-	iter.prot_buf =3D bvec_virt(bip->bip_vec);
-	bio_for_each_segment(bv, bio, bviter) {
+	struct blk_integrity_iter iter =3D {
+		.bio =3D bio,
+		.bip =3D bip,
+		.bi =3D bi,
+		.data_iter =3D *data_iter,
+		.prot_iter =3D bip->bip_iter,
+		.interval_remaining =3D 1 << bi->interval_exp,
+		.seed =3D data_iter->bi_sector,
+		.crc =3D 0,
+	};
+	blk_status_t ret =3D BLK_STS_OK;
+
+	while (iter.data_iter.bi_size && ret =3D=3D BLK_STS_OK) {
+		struct bio_vec bv =3D mp_bvec_iter_bvec(iter.bio->bi_io_vec,
+						      iter.data_iter);
 		void *kaddr =3D bvec_kmap_local(&bv);
+		void *data =3D kaddr;
+
+		bvec_iter_advance_single(iter.bio->bi_io_vec, &iter.data_iter,
+					 bv.bv_len);
+		while (bv.bv_len) {
+			unsigned int len =3D min(iter.interval_remaining, bv.bv_len);
+
+			blk_crc(&iter, data, len);
+			bv.bv_len -=3D len;
+			data +=3D len;
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
+			iter.interval_remaining -=3D len;
+			if (!iter.interval_remaining)
+				ret =3D blk_integrity_interval(&iter, verify);
 		}
 		kunmap_local(kaddr);
 	}
+
+	if (ret)
+		bio->bi_status =3D ret;
+}
+
+void blk_integrity_generate(struct bio *bio)
+{
+	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
+
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		blk_integrity_iterate(bio, &bio->bi_iter, false);
+		break;
+	default:
+		break;
+	}
 }
=20
 void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_=
iter)
 {
 	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
-	struct bio_integrity_payload *bip =3D bio_integrity(bio);
-	struct blk_integrity_iter iter;
-	struct bvec_iter bviter;
-	struct bio_vec bv;
+
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		blk_integrity_iterate(bio, saved_iter, true);
+		break;
+	default:
+		break;
+	}
+}
+
+/**
+ * blk_pi_advance_offset - advance @iter past the protection offset
+ *
+ * For protection formats that contain front padding on the metadata reg=
ion.
+ */
+static void blk_pi_advance_offset(struct blk_integrity *bi,
+				  struct bio_integrity_payload *bip,
+				  struct bvec_iter *iter)
+{
+	unsigned int offset =3D bi->pi_offset;
+
+	while (offset > 0) {
+		struct bio_vec bv =3D mp_bvec_iter_bvec(bip->bip_vec, *iter);
+		unsigned int len =3D min(bv.bv_len, offset);
+
+		bvec_iter_advance_single(bip->bip_vec, iter, len);
+		offset -=3D len;
+	}
+}
+
+static void *blk_tuple_remap_start(union pi_tuple *tuple, struct blk_int=
egrity *bi,
+				   struct bio_integrity_payload *bip,
+				   struct bvec_iter *iter)
+{
+	struct bvec_iter titer;
+	struct bio_vec pbv;
+
+	blk_pi_advance_offset(bi, bip, iter);
+	pbv =3D mp_bvec_iter_bvec(bip->bip_vec, *iter);
+	if (likely(pbv.bv_len >=3D bi->pi_tuple_size))
+		return bvec_kmap_local(&pbv);
=20
 	/*
-	 * At the moment verify is called bi_iter has been advanced during spli=
t
-	 * and completion, so use the copy created during submission here.
+	 * We need to preserve the state of the original iter for the
+	 * copy_from_tuple at the end, so make a temp iter for here.
 	 */
-	iter.disk_name =3D bio->bi_bdev->bd_disk->disk_name;
-	iter.interval =3D 1 << bi->interval_exp;
-	iter.seed =3D saved_iter->bi_sector;
-	iter.prot_buf =3D bvec_virt(bip->bip_vec);
-	__bio_for_each_segment(bv, bio, bviter, *saved_iter) {
-		void *kaddr =3D bvec_kmap_local(&bv);
-		blk_status_t ret =3D BLK_STS_OK;
-
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
+	titer =3D *iter;
+	__blk_integrity_copy_to_tuple(bip, &titer, tuple, bi->pi_tuple_size);
+	return tuple;
+}
=20
-		if (ret) {
-			bio->bi_status =3D ret;
-			return;
-		}
+static void *blk_tuple_remap_end(union pi_tuple *tuple, void *ptuple,
+				 struct blk_integrity *bi,
+				 struct bio_integrity_payload *bip,
+				 struct bvec_iter *iter)
+{
+	unsigned int len =3D bi->metadata_size - bi->pi_offset;
+
+	if (likely(ptuple !=3D tuple)) {
+		kunmap_local(ptuple);
+	} else {
+		__blk_integrity_copy_from_tuple(bip, iter, ptuple,
+						bi->pi_tuple_size);
+		len -=3D bi->pi_tuple_size;
+	}
+
+	bvec_iter_advance(bip->bip_vec, iter, len);
+	return tuple;
+}
+
+static void blk_set_ext_unmap_ref(void *prot_buf, u64 virt, u64 ref_tag)
+{
+	struct crc64_pi_tuple *pi =3D prot_buf;
+
+	if (get_unaligned_be48(&pi->ref_tag) =3D=3D lower_48_bits(ref_tag))
+		put_unaligned_be48(virt, pi->ref_tag);
+}
+
+static void blk_set_t10_unmap_ref(void *prot_buf, u32 virt, u32 ref_tag)
+{
+	struct t10_pi_tuple *pi =3D prot_buf;
+	u32 ref;
+
+	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1)))
+		ref =3D get_unaligned_be32(&pi->ref_tag);
+	else
+		ref =3D be32_to_cpu(pi->ref_tag);
+
+	if (ref !=3D ref_tag)
+		return;
+
+	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1)))
+		put_unaligned_be32(virt, &pi->ref_tag);
+	else
+		pi->ref_tag =3D cpu_to_be32(virt);
+}
+
+static void blk_reftag_remap_complete(struct blk_integrity *bi, void *tu=
ple, u64 virt,
+			       u64 ref)
+{
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		blk_set_ext_unmap_ref(tuple, virt, ref);
+		break;
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		blk_set_t10_unmap_ref(tuple, virt, ref);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
 	}
 }
=20
+static void blk_set_ext_map_ref(void *prot_buf, u64 virt, u64 ref_tag)
+{
+	struct crc64_pi_tuple *pi =3D prot_buf;
+
+	if (get_unaligned_be48(&pi->ref_tag) =3D=3D lower_48_bits(virt))
+		put_unaligned_be48(ref_tag, pi->ref_tag);
+}
+
+static void blk_set_t10_map_ref(void *prot_buf, u32 virt, u32 ref_tag)
+{
+	struct t10_pi_tuple *pi =3D prot_buf;
+	u32 ref;
+
+	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1)))
+		ref =3D get_unaligned_be32(&pi->ref_tag);
+	else
+		ref =3D be32_to_cpu(pi->ref_tag);
+
+	if (ref !=3D virt)
+		return;
+
+	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1)))
+		put_unaligned_be32(ref_tag, &pi->ref_tag);
+	else
+		pi->ref_tag =3D cpu_to_be32(ref_tag);
+}
+
+static void blk_reftag_remap_prepare(struct blk_integrity *bi, void *tup=
le, u64 virt,
+			       u64 ref)
+{
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		blk_set_ext_map_ref(tuple, virt, ref);
+		break;
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		blk_set_t10_map_ref(tuple, virt, ref);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
+
+static void blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
+			     u64 *ref, bool prep)
+{
+	struct bio_integrity_payload *bip =3D bio_integrity(bio);
+	struct bvec_iter iter =3D bip->bip_iter;
+	u64 virt =3D bip_get_seed(bip);
+	union pi_tuple tuple;
+	void *ptuple;
+
+	while (iter.bi_size) {
+		ptuple =3D blk_tuple_remap_start(&tuple, bi, bip, &iter);
+
+		if (prep)
+			blk_reftag_remap_prepare(bi, ptuple, virt, *ref);
+		else
+			blk_reftag_remap_complete(bi, ptuple, virt, *ref);
+
+		blk_tuple_remap_end(&tuple, ptuple, bi, bip, &iter);
+		(*ref)++;
+		virt++;
+	}
+}
+
+static inline unsigned int pi_shift(struct request_queue *q)
+{
+	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
+	    q->limits.integrity.interval_exp)
+		return q->limits.integrity.interval_exp;
+	else
+		return ilog2(queue_logical_block_size(q));
+}
+
+static inline u64 pi_ref_tag(struct request *rq)
+{
+	return blk_rq_pos(rq) >> (pi_shift(rq->q) - SECTOR_SHIFT);
+}
+
 void blk_integrity_prepare(struct request *rq)
 {
 	struct blk_integrity *bi =3D &rq->q->limits.integrity;
+	unsigned int shift =3D pi_shift(rq->q);
+	u64 ref =3D pi_ref_tag(rq);
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
+		struct bio_integrity_payload *bip =3D bio_integrity(bio);
+
+		if (bip->bip_flags & BIP_MAPPED_INTEGRITY) {
+			ref +=3D bio->bi_iter.bi_size >> shift;
+			continue;
+		}
+
+		blk_reftag_remap(bio, bi, &ref, true);
+		bip->bip_flags |=3D BIP_MAPPED_INTEGRITY;
+	}
 }
=20
+/*
+ * This MUST be called before any bio_advance occurs on the request.
+ */
 void blk_integrity_complete(struct request *rq, unsigned int nr_bytes)
 {
 	struct blk_integrity *bi =3D &rq->q->limits.integrity;
+	u64 ref =3D pi_ref_tag(rq);
+	struct bio *bio;
=20
 	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
 		return;
=20
-	if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_CRC64)
-		ext_pi_type1_complete(rq, nr_bytes);
-	else
-		t10_pi_type1_complete(rq, nr_bytes);
+	__rq_for_each_bio(bio, rq)
+		blk_reftag_remap(bio, bi, &ref, false);
 }
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index 2c59fe3efcd42..7003ea2c78d18 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -34,8 +34,8 @@ struct t10_pi_tuple {
 	__be32 ref_tag;		/* Target LBA or indirect LBA */
 };
=20
-#define T10_PI_APP_ESCAPE cpu_to_be16(0xffff)
-#define T10_PI_REF_ESCAPE cpu_to_be32(0xffffffff)
+#define T10_PI_APP_ESCAPE 0xffff
+#define T10_PI_REF_ESCAPE 0xffffffff
=20
 static inline u32 t10_pi_ref_tag(struct request *rq)
 {
--=20
2.47.3

