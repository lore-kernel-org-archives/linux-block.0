Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B322A7E9
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177174; cv=none; b=TAEZK7TLRPB2C9I+f62lJnjuJTkrtu/zG6+bjRWQ0moKOrUCVAKvJhJWKk6w/+K7BR+DBb6ihmtVCnrYGzsifwykQ03zpzrOIdl7Ux3wJ+LZnTkXQ0cBDB2caqtoWm7872ICyLLqesDyzOcB2M9HH7FfpfUtwET2EVV8QNaFdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177174; c=relaxed/simple;
	bh=TWGrCGbWqvePwSSLM4yLYtl3YsAGjrvkfX5qasXciII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RwxFhKGJLo5CtjQfEdG/CMJBZ/Lz1jVFhiCBR/tRsRVVjXi8Diepp4HX2Ic72AGF2ZXvrQonrdv0LHu1zx4uXPV1/g/7a7tQXnN6wDPucu+F8N1IXg77vqHjzTkji6NyRx60aDUGzdlsaKvzoyNHZ4LasrRyD+I8bMFPjsovvIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ADzvNJxw; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ADzvNJxw"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59MLG13j2949383
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 16:52:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=YlV9Kc0ddgt92aqsXD
	KMZtmLa9pTcjKpcUhxywPnYFo=; b=ADzvNJxwsgoVOS2qOFYzCa+ncZBq++YcHZ
	Y4VPwYX9H5oTZmkz+fAaXqNUvV9clqhQ0AWyRzEIry1bqc3Kthj5E1MayIiBwikW
	jcJLgsnPX/j75TOHPehIJPqbE/qbq4kuK5z8XxZeZlYWeQOknLP042yUhJq+HTvk
	htXj4su2r8jWUeYBt+QVORD/QI/KOpc4G8+2Ju3x/tkvWr1qVePYABrNIRfXzxBT
	CzLAgwB+VHG3qEVIWm54apS4YUMB7JwgY9+/MCfz/gwy5cHP1lj/9eTYxgG4CZCy
	COnWFyuuUQRYxmhNrNYUHYQdpDG1B4Ji2cFhvHlvAOMH/qUKI4dQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49y1b1v8dm-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 16:52:51 -0700 (PDT)
Received: from twshared17671.07.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 22 Oct 2025 23:52:44 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 285C52FC1E3B; Wed, 22 Oct 2025 16:52:32 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <martin.petersen@oracle.com>, <linux-block@vger.kernel.org>
CC: <axboe@devbig197.nha3.facebook.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] blk-integrity: support bvec straddling block data
Date: Wed, 22 Oct 2025 16:52:31 -0700
Message-ID: <20251022235231.1334134-1-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE5OSBTYWx0ZWRfX/8HcmTmaL6hP
 axrJwYfd09K7a8vJgzvD4ci5HKZQe/DpUBbHXtyj5hIOj8GzzpBpK4lYYinpuIlNea2jU4FTOKS
 W7ONYogVzi66M1CPh7cVS29GAqyXHFyLKXOHdcjE4nxtwmr/X5KAb/B49maxcMgRq1fkU7ySWcE
 c8vH9GLmmCzJIzounJJR32fosHpMGMzy9cr5W36l8SkjFCjvbn2PV0hhoPR0nQYmpg6H0r2Gj6a
 zt2bWPOGKmfQK/ApxMqoOFvDNumV5wy9cJHxOsj/7rt8H0ED0Ur6RtBOi2GbU1YU1Ea56A57m+o
 /onznuHvIaUF8nBuTljWtz21e0nP2cYXKcla5O3SHBlk/oVmqpn3zEkvvco7Q62EGy6fHeCUdu7
 aBC1CxHb02I/Pe7WoSoSa6bNHf9dUw==
X-Proofpoint-ORIG-GUID: 3E7ToXfhd_9jC9Jz6xVT0tHOp464LYwH
X-Authority-Analysis: v=2.4 cv=Xc2EDY55 c=1 sm=1 tr=0 ts=68f96e53 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=sHoX4Zs7NGcbYNiplGUA:9
X-Proofpoint-GUID: 3E7ToXfhd_9jC9Jz6xVT0tHOp464LYwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

A bio segment might have only partial block data that continues into the
next segment. User the integrity iterator to store the current checksum
state until we've accumulated a full interval worth of data.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/t10-pi.c | 190 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 123 insertions(+), 67 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c4ed97021460..63ac3298df8de 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -17,6 +17,11 @@ struct blk_integrity_iter {
 	void			*data_buf;
 	sector_t		seed;
 	unsigned int		data_size;
+	unsigned int		remaining;
+	union {
+		u64		crc64;
+		__be16		t10pi;
+	};
 	unsigned short		interval;
 	const char		*disk_name;
 };
@@ -38,25 +43,34 @@ static void t10_pi_generate(struct blk_integrity_iter=
 *iter,
 		struct blk_integrity *bi)
 {
 	u8 offset =3D bi->pi_offset;
-	unsigned int i;
+	unsigned int len, i;
=20
-	for (i =3D 0 ; i < iter->data_size ; i +=3D iter->interval) {
+	for (i =3D 0 ; i < iter->data_size ; i +=3D len) {
 		struct t10_pi_tuple *pi =3D iter->prot_buf + offset;
=20
-		pi->guard_tag =3D t10_pi_csum(0, iter->data_buf, iter->interval,
-				bi->csum_type);
+		len =3D min(iter->remaining, iter->data_size - i);
+		iter->t10pi =3D t10_pi_csum(iter->t10pi, iter->data_buf, len,
+					  bi->csum_type);
+		iter->remaining -=3D len;
+		iter->data_buf +=3D len;
+
+		if (iter->remaining)
+			continue;
+
 		if (offset)
-			pi->guard_tag =3D t10_pi_csum(pi->guard_tag,
-					iter->prot_buf, offset, bi->csum_type);
-		pi->app_tag =3D 0;
+			iter->t10pi =3D t10_pi_csum(iter->t10pi, iter->prot_buf,
+						  offset, bi->csum_type);
=20
+		pi->guard_tag =3D iter->t10pi;
+		pi->app_tag =3D 0;
 		if (bi->flags & BLK_INTEGRITY_REF_TAG)
 			pi->ref_tag =3D cpu_to_be32(lower_32_bits(iter->seed));
 		else
 			pi->ref_tag =3D 0;
=20
-		iter->data_buf +=3D iter->interval;
 		iter->prot_buf +=3D bi->metadata_size;
+		iter->remaining =3D iter->interval;
+		iter->t10pi =3D 0;
 		iter->seed++;
 	}
 }
@@ -65,48 +79,61 @@ static blk_status_t t10_pi_verify(struct blk_integrit=
y_iter *iter,
 		struct blk_integrity *bi)
 {
 	u8 offset =3D bi->pi_offset;
-	unsigned int i;
+	unsigned int len, i;
+	bool skip =3D false;
=20
 	for (i =3D 0 ; i < iter->data_size ; i +=3D iter->interval) {
 		struct t10_pi_tuple *pi =3D iter->prot_buf + offset;
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
+
+		if (iter->remaining =3D=3D iter->interval) {
+			if (bi->flags & BLK_INTEGRITY_REF_TAG) {
+				if (pi->app_tag =3D=3D T10_PI_APP_ESCAPE) {
+					skip =3D true;
+				} else if (be32_to_cpu(pi->ref_tag) !=3D
+				    lower_32_bits(iter->seed)) {
+					pr_err("%s: ref tag error at location %llu " \
+					       "(rcvd %u)\n", iter->disk_name,
+					       (unsigned long long)
+					       iter->seed, be32_to_cpu(pi->ref_tag));
+					return BLK_STS_PROTECTION;
+				}
+			} else {
+				if (pi->app_tag =3D=3D T10_PI_APP_ESCAPE &&
+				    pi->ref_tag =3D=3D T10_PI_REF_ESCAPE)
+					skip =3D true;
 			}
-		} else {
-			if (pi->app_tag =3D=3D T10_PI_APP_ESCAPE &&
-			    pi->ref_tag =3D=3D T10_PI_REF_ESCAPE)
-				goto next;
 		}
=20
-		csum =3D t10_pi_csum(0, iter->data_buf, iter->interval,
+		len =3D min(iter->remaining, iter->data_size - i);
+		if (!skip)
+			iter->t10pi =3D t10_pi_csum(iter->t10pi, iter->data_buf, len,
 				bi->csum_type);
+		iter->remaining -=3D len;
+		iter->data_buf +=3D len;
+
+		if (iter->remaining)
+			continue;
+
+		if (skip)
+			goto next;
+
 		if (offset)
-			csum =3D t10_pi_csum(csum, iter->prot_buf, offset,
+			iter->t10pi =3D t10_pi_csum(iter->t10pi, iter->prot_buf, offset,
 					bi->csum_type);
=20
-		if (pi->guard_tag !=3D csum) {
+		if (pi->guard_tag !=3D iter->t10pi) {
 			pr_err("%s: guard tag error at sector %llu " \
 			       "(rcvd %04x, want %04x)\n", iter->disk_name,
 			       (unsigned long long)iter->seed,
-			       be16_to_cpu(pi->guard_tag), be16_to_cpu(csum));
+			       be16_to_cpu(pi->guard_tag), be16_to_cpu(iter->t10pi));
 			return BLK_STS_PROTECTION;
 		}
-
 next:
-		iter->data_buf +=3D iter->interval;
 		iter->prot_buf +=3D bi->metadata_size;
+		iter->remaining =3D iter->interval;
+		iter->t10pi =3D 0;
 		iter->seed++;
+		skip =3D false;
 	}
=20
 	return BLK_STS_OK;
@@ -208,24 +235,33 @@ static void t10_pi_type1_complete(struct request *r=
q, unsigned int nr_bytes)
 	}
 }
=20
-static __be64 ext_pi_crc64(u64 crc, void *data, unsigned int len)
+static u64 ext_pi_crc64(u64 crc, void *data, unsigned int len)
 {
-	return cpu_to_be64(crc64_nvme(crc, data, len));
+	return crc64_nvme(crc, data, len);
 }
=20
 static void ext_pi_crc64_generate(struct blk_integrity_iter *iter,
 		struct blk_integrity *bi)
 {
 	u8 offset =3D bi->pi_offset;
-	unsigned int i;
+	unsigned int len, i;
=20
-	for (i =3D 0 ; i < iter->data_size ; i +=3D iter->interval) {
+	for (i =3D 0 ; i < iter->data_size ; i +=3D len) {
 		struct crc64_pi_tuple *pi =3D iter->prot_buf + offset;
=20
-		pi->guard_tag =3D ext_pi_crc64(0, iter->data_buf, iter->interval);
+		len =3D min(iter->remaining, iter->data_size - i);
+		iter->crc64 =3D ext_pi_crc64(iter->crc64, iter->data_buf, len);
+		iter->remaining -=3D len;
+		iter->data_buf +=3D len;
+
+		if (iter->remaining)
+			continue;
+
 		if (offset)
-			pi->guard_tag =3D ext_pi_crc64(be64_to_cpu(pi->guard_tag),
-					iter->prot_buf, offset);
+			iter->crc64 =3D ext_pi_crc64(iter->crc64, iter->prot_buf,
+						offset);
+
+		pi->guard_tag =3D cpu_to_be64(iter->crc64);
 		pi->app_tag =3D 0;
=20
 		if (bi->flags & BLK_INTEGRITY_REF_TAG)
@@ -233,8 +269,9 @@ static void ext_pi_crc64_generate(struct blk_integrit=
y_iter *iter,
 		else
 			put_unaligned_be48(0ULL, pi->ref_tag);
=20
-		iter->data_buf +=3D iter->interval;
 		iter->prot_buf +=3D bi->metadata_size;
+		iter->remaining =3D iter->interval;
+		iter->crc64 =3D 0;
 		iter->seed++;
 	}
 }
@@ -250,47 +287,64 @@ static blk_status_t ext_pi_crc64_verify(struct blk_=
integrity_iter *iter,
 		struct blk_integrity *bi)
 {
 	u8 offset =3D bi->pi_offset;
-	unsigned int i;
+	unsigned int len, i;
+	bool skip =3D false;
=20
-	for (i =3D 0; i < iter->data_size; i +=3D iter->interval) {
+	for (i =3D 0; i < iter->data_size; i +=3D len) {
 		struct crc64_pi_tuple *pi =3D iter->prot_buf + offset;
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
+
+		if (iter->remaining =3D=3D iter->interval) {
+			if (bi->flags & BLK_INTEGRITY_REF_TAG) {
+				if (pi->app_tag =3D=3D T10_PI_APP_ESCAPE) {
+					skip =3D true;
+				} else {
+					u64 ref, seed;
+
+					ref =3D get_unaligned_be48(pi->ref_tag);
+					seed =3D lower_48_bits(iter->seed);
+					if (ref !=3D seed) {
+						pr_err("%s: ref tag error at location %llu (rcvd %llu)\n",
+							iter->disk_name, seed, ref);
+						return BLK_STS_PROTECTION;
+					}
+				}
+			} else {
+				if (pi->app_tag =3D=3D T10_PI_APP_ESCAPE &&
+				    ext_pi_ref_escape(pi->ref_tag))
+					skip =3D true;
 			}
-		} else {
-			if (pi->app_tag =3D=3D T10_PI_APP_ESCAPE &&
-			    ext_pi_ref_escape(pi->ref_tag))
-				goto next;
 		}
=20
-		csum =3D ext_pi_crc64(0, iter->data_buf, iter->interval);
+		len =3D min(iter->remaining, iter->data_size - i);
+		if (!skip)
+			iter->crc64 =3D ext_pi_crc64(iter->crc64, iter->data_buf, len);
+		iter->remaining -=3D len;
+		iter->data_buf +=3D len;
+
+		if (iter->remaining)
+			continue;
+
+		if (skip)
+			goto next;
+
 		if (offset)
-			csum =3D ext_pi_crc64(be64_to_cpu(csum), iter->prot_buf,
-					    offset);
+			iter->crc64 =3D ext_pi_crc64(iter->crc64, iter->prot_buf,
+						   offset);
=20
-		if (pi->guard_tag !=3D csum) {
+		if (be64_to_cpu(pi->guard_tag) !=3D iter->crc64) {
 			pr_err("%s: guard tag error at sector %llu " \
 			       "(rcvd %016llx, want %016llx)\n",
 				iter->disk_name, (unsigned long long)iter->seed,
-				be64_to_cpu(pi->guard_tag), be64_to_cpu(csum));
+				be64_to_cpu(pi->guard_tag), iter->crc64);
 			return BLK_STS_PROTECTION;
 		}
=20
 next:
-		iter->data_buf +=3D iter->interval;
 		iter->prot_buf +=3D bi->metadata_size;
+		iter->remaining =3D iter->interval;
+		iter->crc64 =3D 0;
 		iter->seed++;
+		skip =3D false;
 	}
=20
 	return BLK_STS_OK;
@@ -381,9 +435,10 @@ void blk_integrity_generate(struct bio *bio)
 	struct bio_vec bv;
=20
 	iter.disk_name =3D bio->bi_bdev->bd_disk->disk_name;
-	iter.interval =3D 1 << bi->interval_exp;
+	iter.remaining =3D iter.interval =3D 1 << bi->interval_exp;
 	iter.seed =3D bio->bi_iter.bi_sector;
 	iter.prot_buf =3D bvec_virt(bip->bip_vec);
+	iter.crc64 =3D 0;
 	bio_for_each_segment(bv, bio, bviter) {
 		void *kaddr =3D bvec_kmap_local(&bv);
=20
@@ -417,9 +472,10 @@ void blk_integrity_verify_iter(struct bio *bio, stru=
ct bvec_iter *saved_iter)
 	 * and completion, so use the copy created during submission here.
 	 */
 	iter.disk_name =3D bio->bi_bdev->bd_disk->disk_name;
-	iter.interval =3D 1 << bi->interval_exp;
+	iter.remaining =3D iter.interval =3D 1 << bi->interval_exp;
 	iter.seed =3D saved_iter->bi_sector;
 	iter.prot_buf =3D bvec_virt(bip->bip_vec);
+	iter.crc64 =3D 0;
 	__bio_for_each_segment(bv, bio, bviter, *saved_iter) {
 		void *kaddr =3D bvec_kmap_local(&bv);
 		blk_status_t ret =3D BLK_STS_OK;
--=20
2.47.3

