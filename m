Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8443203AA
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477404; cv=none; b=sf+wftaFjhnFDxNGmMnZnPTsTvF3RhORLC9WOFo5iqWQR+4JNAn9Zr0cg3rXsHlC5yIidKn7lOGOJpVR/9xUtRons7QVrlBXVU/G8cDgcsNPSWOKwdfQ7bmPi8GcTAESqvS6teArg3UBJDrUWfetDaSn1YT5sJg0lI8kCnA0q1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477404; c=relaxed/simple;
	bh=aLC+9l8a3e0TyTKc2dT/x3t1S1CsKShJTvmaZGoZNeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u397XSDm25oUvDsJXaqMlbxeqFlZKPttUH/6Z6eIwMpfT2kD5D8UccWH2/BEpz+3lj9nBJWJEys3W431KmAvSKklyjPvdh4hPblWND9LutQImXujtH65S4kqLB2KVt/rWUJpJllsIvDwpO6h0ICuRSE6Tu9a8fuAMZq9dJZlc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SovaXCaC; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SovaXCaC"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57T7lOG52464331
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 07:23:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KqeGlfnCcP/78XD3MlSdQnU+kfWsJ/iig4l+gmh5668=; b=SovaXCaCWm5j
	5OcIhQh9Z5NuW8/tLdeXubup5NnmJWZCi644GrM6wq5mODsAkYyr6UCKdpgdU4AH
	nfIo0RX3Q7B3RfYpuUpULEQN1dSx9nanOz1I91wpEo8Up6JBhxCRRQGm8vp6/128
	OSyEMSnSqpO5L8xw9ELKaHhksBouqABlz3ml7EAw5SXbPCI7uBQu0+kzaVXgPHOr
	2dsFA+xVzvtZPjDByaJl7ksbwobl0pNcQWPclYbl3a+LE505zh33jU3p1VVgLXTZ
	1gUjnMHbtQLtBFeGqai06kiCTsmB2YmFxbgpTEnGOg0gniHEsTPOHPSBkHbcWtiZ
	wWrKji6FFQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48u8469xu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 07:23:21 -0700 (PDT)
Received: from twshared25333.08.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 29 Aug 2025 14:23:21 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4EA2311FADB6; Fri, 29 Aug 2025 07:23:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] blk-integrity: enable p2p source and destination
Date: Fri, 29 Aug 2025 07:23:06 -0700
Message-ID: <20250829142307.3769873-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829142307.3769873-1-kbusch@meta.com>
References: <20250829142307.3769873-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDEyMSBTYWx0ZWRfX7TidgJYhDk3i
 mseguDYTK+vfbds+hu7m+gh908WsKe3MaZ/bYU9Wb+/ALs8vu5vEsQ1gDo+7xK84SyN0vXejZX1
 8z5cP/3an1RAM68ckjhH8QIOt6txoZ07P5cXWk5LjDcMnUMCEbJy4rYHqfjNuJj/s/6PJmjLwL4
 FdMCZvIIGbA5H3CI1UYwHTqD05I8g0mlI2pwSRNR2oiM+qZ2jqPKvjSOrLpcwhLWiw2+wy2HcF1
 CXpeK/TzKwzDz6aAn0QmIeniS5ubDuYMahTuMLjF/GHE94oBxY1FND41Ug1u0UTLPkvklEuLsRa
 xtPzIulTUY8IOaQqickOMCRzsSy53eH4SlADGThhJa5vrobCSFJ+WD03GUhe2M=
X-Proofpoint-GUID: JJKnCYA34PT9D9yJWITEKhq4YfU8lsA-
X-Proofpoint-ORIG-GUID: JJKnCYA34PT9D9yJWITEKhq4YfU8lsA-
X-Authority-Analysis: v=2.4 cv=TdGWtQQh c=1 sm=1 tr=0 ts=68b1b7d9 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=NyUx0YTEs4DmRO4HD-YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_05,2025-08-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

User provided metadata can come from anywhere, including p2p pages. Set
the extraction flags to allow p2p pages for the metadata buffer if the
block device allows it. Similar to data payloads, ensure the bio
disallows merging if we see a p2p page.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b077ca937f6b..5709ce2bf3464 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -230,7 +230,8 @@ static int bio_integrity_init_user(struct bio *bio, s=
truct bio_vec *bvec,
 }
=20
 static unsigned int bvec_from_pages(struct bio_vec *bvec, struct page **=
pages,
-				    int nr_vecs, ssize_t bytes, ssize_t offset)
+				    int nr_vecs, ssize_t bytes, ssize_t offset,
+				    bool *is_p2p)
 {
 	unsigned int nr_bvecs =3D 0;
 	int i, j;
@@ -251,6 +252,9 @@ static unsigned int bvec_from_pages(struct bio_vec *b=
vec, struct page **pages,
 			bytes -=3D next;
 		}
=20
+		if (is_pci_p2pdma_page(page))
+			*is_p2p =3D true;
+
 		bvec_set_page(&bvec[nr_bvecs], pages[i], size, offset);
 		offset =3D 0;
 		nr_bvecs++;
@@ -265,10 +269,11 @@ int bio_integrity_map_user(struct bio *bio, struct =
iov_iter *iter)
 	unsigned int align =3D blk_lim_dma_alignment_and_pad(&q->limits);
 	struct page *stack_pages[UIO_FASTIOV], **pages =3D stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec =3D stack_vec;
+	iov_iter_extraction_t extraction_flags =3D 0;
 	size_t offset, bytes =3D iter->count;
+	bool copy, is_p2p =3D false;
 	unsigned int nr_bvecs;
 	int ret, nr_vecs;
-	bool copy;
=20
 	if (bio_integrity(bio))
 		return -EINVAL;
@@ -286,15 +291,23 @@ int bio_integrity_map_user(struct bio *bio, struct =
iov_iter *iter)
 	}
=20
 	copy =3D !iov_iter_is_aligned(iter, align, align);
-	ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs, 0, &offset=
);
+
+	if (blk_queue_pci_p2pdma(q))
+		extraction_flags |=3D ITER_ALLOW_P2PDMA;
+
+	ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs,
+					extraction_flags, &offset);
 	if (unlikely(ret < 0))
 		goto free_bvec;
=20
-	nr_bvecs =3D bvec_from_pages(bvec, pages, nr_vecs, bytes, offset);
+	nr_bvecs =3D bvec_from_pages(bvec, pages, nr_vecs, bytes, offset,
+				   &is_p2p);
 	if (pages !=3D stack_pages)
 		kvfree(pages);
 	if (nr_bvecs > queue_max_integrity_segments(q))
 		copy =3D true;
+	if (is_p2p)
+		bio->bi_opf |=3D REQ_NOMERGE;
=20
 	if (copy)
 		ret =3D bio_integrity_copy_user(bio, bvec, nr_bvecs, bytes);
--=20
2.47.3

