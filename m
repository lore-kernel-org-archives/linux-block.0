Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190D92C18A
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928005; cv=none; b=niETxxKnensQ2Vw4mIh1hrboLC6yYQJ3XX03bH8Sl7tgwz+uBtic4jrVA1o+Sm+yxHd/nve5QZrJklWKvt47AmIe75OPRGcFutGmwO4pZwQz0jnT/jQUTYzjq15FU2XURQo3W/XqSJ09DkE3UvB/Ke/9X9XD8WllLBgpj/0ze38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928005; c=relaxed/simple;
	bh=tdayG/B8k5J9R8dYYTYLfnyN2SrPKtn9N86kJiEwwfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NY3VJe7Q7LXB/Z+c/BWGq9tRLUw8PIEEXTPmu+PWyCzE7Juj8C4BzS2OJOOUJgj1vNoWOcpYWA0AhdvDgRJ6h7L7rj+6nyoIlkEFORJjk5QW53DVV9FupHEB4PD27UZzU7c8wnbqbyU13YdDuOZ8wZh1Axbua7pGiQAiCgjaoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vidRRFop; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vidRRFop"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 583J8Hf43662150
	for <linux-block@vger.kernel.org>; Wed, 3 Sep 2025 12:33:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=njBTdTt6SW8iTrjyJ8MLhTKwiu/YM2R1oj4pt04xh8Q=; b=vidRRFopEpj9
	jHZnxLjy03ANQlBA5tB6p7r4LPuRKTv9JH/ATXM7xwByepRUH2IiQ7mHka1tzrQo
	FM/ecdfKpIXWr6+xYDlLuQEBiPGWAJnYLSxh2n3IgFuYuQrmWMM42JaSHfkCnXmW
	be+vz8OHgofbG3WzFov2vX7rOsKjxtNLVqiHL6Se6XQhWdFZfpi1cndgK4XTiHzn
	qO+PeTHrWWdb3zFVCcAGYW17slQzmjObkoWREUKyfzPRIjSIsUu9w/x8EYV8OG5m
	fzM+S+vN8BRnrrRxS3LP0BcTWkk6qd0QyR+rLQhXmUNzYXqvXH1ErJ30tV4Lb7Zn
	cTTJXk0KgA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48xqt7jdp6-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 03 Sep 2025 12:33:22 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 3 Sep 2025 19:33:20 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C908114CE622; Wed,  3 Sep 2025 12:33:17 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/2] blk-integrity: enable p2p source and destination
Date: Wed, 3 Sep 2025 12:33:16 -0700
Message-ID: <20250903193317.3185435-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250903193317.3185435-1-kbusch@meta.com>
References: <20250903193317.3185435-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE5NiBTYWx0ZWRfXz0zacbgIywfQ
 Cd7OdrvBZdSTMd5CurwInE+EzkHM1CgH89wK/SYxwf/gIzJVht0ORxhqXvX5hpqsya+3vV1uWEv
 OjLSuIMZJe2RlIK5houkv7tkEmFXmVWxMMbGYoYx95QIxN8RkSMKqPleJVFSyH9HN14DL5irlkV
 ABGOhnBO8Y8JEJNItjq36G0w9A0hufFcDXwvMDOQ2AmEGmQD7jDBRCQtrxvLG/eqimz3bQrB0jU
 eFuMAhukYRolYfYOwVkQCi3HjkVdoHAmGDybs3aWwfVFHK+NKU8sD57HFotoP8qTnUOXBx1ClPT
 4SQ59LItnKa7gva5LPaZf5Z27/7x5TgOkOu+Rlro8hHNaxjIngfk0vGf0COipo=
X-Authority-Analysis: v=2.4 cv=LZ886ifi c=1 sm=1 tr=0 ts=68b89802 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=nFeozVan30irdC35seoA:9
X-Proofpoint-GUID: D3Auq3IBu8cBk0Pwi9Q1BScfVxNdNFaQ
X-Proofpoint-ORIG-GUID: D3Auq3IBu8cBk0Pwi9Q1BScfVxNdNFaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Set the extraction flags to allow p2p pages for the metadata buffer if
the block device allows it. Similar to data payloads, ensure the bio
does not use merging if we see a p2p page.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b077ca937f6b..d3618ed106f4e 100644
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
+		if (is_pci_p2pdma_page(pages[i]))
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

