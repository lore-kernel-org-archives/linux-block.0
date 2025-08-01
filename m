Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490F28FFCB
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092081; cv=none; b=g0BwdJP3oLumeWLIPQyOlBD0rv4fMAQY74XLWdYyw+O4byiYR0C6oz3KkPAOH6W5AVy0R35Hksq/RXWnCTOoH1V0oYS1luQx9UG1HIJog5hf60n23LRvsJK0duDbMVIYjaGkHi2bzFvQYpBkeJbEX+YbRnLcJnuzOLPMhF7LOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092081; c=relaxed/simple;
	bh=OMeezIS6H4pb0DAO1sPwLmLYxQE9W3UpuZAe54uaBm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WI3Jv92KSlQhUi4/lam8HcaLzkWJ2WbCgF2d7JlaO2GULOG49woD618iPHXI17f8T0pdNiCzZs78W0ikpoGFPe4qTjkL3p5e+NDFXoCH0jUuQh3BIa9CUUGaErCb9P3Dkof8qZ8FCg2/4MWRSrnqNe+hb7ZBHetAItOrk9Mnp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Zxl0xZSa; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Zxl0xZSa"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571MqFEP027978
	for <linux-block@vger.kernel.org>; Fri, 1 Aug 2025 16:47:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=pnnkPBGQ0gRBLybx/TION3BTRcap0tbm0RMeiLyF+rc=; b=Zxl0xZSaUwtj
	aBOHhx32Oa8mYi4FkV+U3tNqJj36xQOgeLkrCxjO1iZY3cl+cFiwC8ShlJ0gE3H5
	yj9G5yp3uVPHxvOSTLtrUIga7E1JljZJOwAUHfSfKpqYQNMPImidO3lartdHxaKv
	i1kWYO1PGA3tvkVPPvzPZNaFvBIQvYSSiaGtYdmF6Fari8NvVkdwXqTIISeWlOkT
	F3/ckY4e8N2Z4r24yLl6qzWNqaaSywTY6q0k+zerMLgP4kJbvqbYnlSZNemnEjJC
	BOZBgaAaDmqafvDyLKrlbBHdO41WHbU8yRKWkqZBbAz/zYrA/dMsEgcPLZDxnnkJ
	v+GwUkIbVA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 489286t1ts-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 01 Aug 2025 16:47:58 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C96753105F6; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6/7] blk-integrity: use simpler alignment check
Date: Fri, 1 Aug 2025 16:47:35 -0700
Message-ID: <20250801234736.1913170-7-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801234736.1913170-1-kbusch@meta.com>
References: <20250801234736.1913170-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfXwPTzE4cTRZHL q6xhLmNrtBMRh4Vq38ZOJ+G/bJk9NdyabLlBxnDMmGXeSQT59mW6jVThHpi+ejZRKWCZsQT5zsx psw2gaXyuRMxc9OOvfRYoZ4YJt/v6jf4XkdUz0+a799MpmnKyjteFcSeSHuDOrivyY2I5Y4ReOW
 Xhkororh1IQVYwOcgIwj1JeCIsuyWG6Gi7pF4RNk0xSkassTm5x7o0/4Mk0QVpEt4nW7XEdD/aW 09a3D7WFZpQtCtV7NVR/24b7YaoykgYYHMWo4jwX+x0TJgnZL7o44iKZcQ2OwzrsltaJ6e13lAX fAKNwbJrcB6MpfMPpp5wVuGOZE+5xTHehJJZulfbeJiASrlgcgglGLiN8QVvOZ4ZmO/ZHkQJz24
 mJFXH6/8PBr7cI4EXRdAJSFRW66PxcBd9tZsbqzfG1fFqtnQZv97AibZJn5Y0ZRpB1yGqjQv
X-Authority-Analysis: v=2.4 cv=ANL1oDcN c=1 sm=1 tr=0 ts=688d522e cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yetF5jY7WHH6jeiS1L0A:9
X-Proofpoint-GUID: iD5WAbeTPWYDdEU4tiSPVP6nWX_aXotj
X-Proofpoint-ORIG-GUID: iD5WAbeTPWYDdEU4tiSPVP6nWX_aXotj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We're checking length and addresses against the same alignment value, so
use the more simple iterator check.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b077ca937f6b..6d069a49b4aad 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -262,7 +262,6 @@ static unsigned int bvec_from_pages(struct bio_vec *b=
vec, struct page **pages,
 int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 {
 	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
-	unsigned int align =3D blk_lim_dma_alignment_and_pad(&q->limits);
 	struct page *stack_pages[UIO_FASTIOV], **pages =3D stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec =3D stack_vec;
 	size_t offset, bytes =3D iter->count;
@@ -285,7 +284,8 @@ int bio_integrity_map_user(struct bio *bio, struct io=
v_iter *iter)
 		pages =3D NULL;
 	}
=20
-	copy =3D !iov_iter_is_aligned(iter, align, align);
+	copy =3D iov_iter_alignment(iter) &
+			blk_lim_dma_alignment_and_pad(&q->limits);
 	ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs, 0, &offset=
);
 	if (unlikely(ret < 0))
 		goto free_bvec;
--=20
2.47.3

