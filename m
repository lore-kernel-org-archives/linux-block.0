Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86B1EEE9
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714972685; cv=none; b=d/Ss00i0+GsoGlPQU6tduHuHB9AWPI1K36f1mXy9927MUv108jWQ0B4vSnnZ3HOMVG5ynHlbhufG9lAJZp4NmEEDz+qN53y6G9+9p0I8X0dAineHbOTpG3MRaP6pkwiPNeAYTCbjwT80EXs30u5Rj040LLifB6FTXfnGBnJ/UsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714972685; c=relaxed/simple;
	bh=RgD1EtcFapzbLM+iGG9eEbxtGF01ljb2m+ueR4QwTjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=NUOJPHIOVVq49ojMUlymNFyx084JTZ5imtnZthjdGCkcxj1pgQR+F5eNzhrJ1XCrA6ARQNP814yskSQ94GmwDWRzIuwVaGN8UfyGFAz9hRjO4Pm+TE8YLF6UABuonct8xnj6xxfcTwO/IQ16J3CtHYT4LEi9Dp4yZM/2+s0ZkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qPf/F6Kp; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qPf/F6Kp"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240506051753epoutp045418507bc6ef6b29a5742336568b1f53~Mzo9yPocr2743727437epoutp04f
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 05:17:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240506051753epoutp045418507bc6ef6b29a5742336568b1f53~Mzo9yPocr2743727437epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714972673;
	bh=RWwrLx7piyo9Dr2ocg98shFavX0JhfqvS+jgXlxIrhE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=qPf/F6KpgJXRMR8rxKuRY7ZPAOctFswiTNJ3csZugvE8s7xMQ8+brGy/QVTJGi6t6
	 CBuKdhfYpYXrUidNqlT8mZpaNH2mv69JthNZshETrD1qawaQAXHexbgpo/Bz5CBM1B
	 0uZ6u3OcrJrx4g6w5PHA4xUXoYQOd5XytOnb7S8E=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240506051753epcas5p2cb592d4cb9c9a3cd0d78d9d1377fdb57~Mzo9iM6981041210412epcas5p29;
	Mon,  6 May 2024 05:17:53 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VXqRg61bzz4x9Pw; Mon,  6 May
	2024 05:17:51 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	32.6E.09665.FF768366; Mon,  6 May 2024 14:17:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33~Mzo7q-WAg1352913529epcas5p1D;
	Mon,  6 May 2024 05:17:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240506051751epsmtrp2da5fa983bcafcd7250db2d57f93f1eac~Mzo7qWoKq3110131101epsmtrp2D;
	Mon,  6 May 2024 05:17:51 +0000 (GMT)
X-AuditID: b6c32a4b-5cdff700000025c1-1d-663867ffcb81
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	72.9E.08924.FF768366; Mon,  6 May 2024 14:17:51 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240506051750epsmtip20b62db1ab9e300b9d5b0ca86940eaf07~Mzo6h91270244102441epsmtip20;
	Mon,  6 May 2024 05:17:49 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com,
	anuj20.g@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] block: streamline meta bounce buffer handling
Date: Mon,  6 May 2024 10:40:47 +0530
Message-Id: <20240506051047.4291-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmpu7/dIs0g873OhZNE/4yW6y+289m
	sXL1USaLo//fsllMOnSN0WLvLW2L5cf/MTmwe1w+W+qxaVUnm8fumw1sHh+f3mLx6NuyitHj
	8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wc
	oEuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZG
	pkCFCdkZL7rWsBZcU6g427SHtYFxnVQXIyeHhICJxOEjJ5i7GLk4hAR2M0q8X7OKDcL5xCjx
	9ORPRgjnG6PEhf+H2WBaOldsZYFI7GWUuNp1gh3C+cwo0XllG1AVBwebgKbEhcmlIKaIgJHE
	5wXhIL3MAhUSXx9/BpsjLGAn0XhpAxOIzSKgKtFz+SYjiM0rYC7xf2cXE8QueYmZl76zQ8QF
	JU7OfMICMUdeonnrbLCzJQQusUtc/78B6jgXiTMn7jBD2MISr45vYYewpSQ+v9sLVZMscWnm
	OagFJRKP9xyEsu0lWk/1M4PczAx0/vpd+hC7+CR6fz9hAglLCPBKdLQJQVQrStyb9JQVwhaX
	eDhjCZTtIdH4ZAHYViGBWImLFzewT2CUm4Xkg1lIPpiFsGwBI/MqRsnUguLc9NRi0wLjvNRy
	eFQm5+duYgQnQS3vHYyPHnzQO8TIxMF4iFGCg1lJhPdou3maEG9KYmVValF+fFFpTmrxIUZT
	YLBOZJYSTc4HpuG8knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqY
	jLgDPJWv3M30iflTXNd/8PNm8cJL2j0HK1eu2KxRe/bxxzc7Qv97/Ms9/fLA7mtX+36t8lfc
	sGPy1H6m9+lHtD4se9Jtt3nnjzTvcneNMxOSO+2P/dzIwXM+e3qSJ9csXz27NbvUfVf6ZPL5
	sSuxnljrK3PxRZNbGffSY5Pr9BovuxW97eGJuc5zWT/txXlvox98VW0sge1P7uy79HS94QWn
	Oc0b7s21/mn9UWPhgdIpcvkFC8uPxCtWFz4S4zXcPGVdt/Vp97/ZE+ZyTPwZ4qj6LTAj48GS
	y1OLmoJj+VpjDyyZ8UXal7mXp3b7zIzDb7gVd4Z4PPzzapLmVuOHK5fGp9TnTPrwP0G0Xkdz
	gRJLcUaioRZzUXEiAIMl5p4LBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvO7/dIs0gw0f+CyaJvxltlh9t5/N
	YuXqo0wWR/+/ZbOYdOgao8XeW9oWy4//Y3Jg97h8ttRj06pONo/dNxvYPD4+vcXi0bdlFaPH
	501yAWxRXDYpqTmZZalF+nYJXBkvutawFlxTqDjbtIe1gXGdVBcjJ4eEgIlE54qtLF2MXBxC
	ArsZJT40bGCBSIhLNF/7wQ5hC0us/PecHaLoI6PE5/9PWLsYOTjYBDQlLkwuBakRETCTOP7+
	HSOIzSxQI7Hmz342EFtYwE6i8dIGJhCbRUBVoufyTbAaXgFzif87u5gg5stLzLz0nR0iLihx
	cuYTFog58hLNW2czT2Dkm4UkNQtJagEj0ypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxN
	jOBQ1dLcwbh91Qe9Q4xMHIyHGCU4mJVEeI+2m6cJ8aYkVlalFuXHF5XmpBYfYpTmYFES5xV/
	0ZsiJJCeWJKanZpakFoEk2Xi4JRqYOJoYdj2/s5jyeqbu5N6a6qZKnWCNX4avrsv5nhhdafd
	p7dcpvXhRw6wBt/1nygbv8Mn+O5kzo9h/y7HWWgYHhBeXzrTL8fHu2tXmrR+XuuBULG68Jo3
	6vyrvZ8ffb+95NLHVM2w5f28cVMb7607UW6ZHu9oGeGl89X/vv2njTVey35OM1ki4b8hd4F/
	wBZlp0eOW6+xXLY2u1/Oll7ypayQ/8Ds9Ls38zhCqr11f64Ned3ckPpOwn6Sb/SF+2HOCiV5
	px4aqK9w/F57qf9SVHC1aaJb3a6GhVm8BiocX8yKZiyrfrohJ/osX+WtwGqVue8UQu0dLu45
	vHjLKq0MJfW8k6ki4lzXHojqsE5VYinOSDTUYi4qTgQAiorGtcQCAAA=
X-CMS-MailID: 20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33
References: <CGME20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33@epcas5p1.samsung.com>

Currently bio_integrity_copy_user() uses bip_vec array to store two
different things: (a) kernel allocated bounce buffer (b) bunch of extra
bvecs to pinned user memory.
This leads to unwieldy handling at places.

The patch cleans this up and uses bip_vec for just kernel allocated meta
buffer. The bio_vecs (to pinned user memory) and their count are now
stored seprately into bip. Existing memory (of the field bip_work) is
reused so that bip does not grow unconditionally.

Based on an earlier patch from Keith Busch.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/bio-integrity.c | 28 ++++++++++++++++++----------
 include/linux/bio.h   | 12 +++++++++++-
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 2e3e8e04961e..47634b89d27c 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -105,8 +105,8 @@ static void bio_integrity_unpin_bvec(struct bio_vec *bv, int nr_vecs,
 
 static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 {
-	unsigned short nr_vecs = bip->bip_max_vcnt - 1;
-	struct bio_vec *copy = &bip->bip_vec[1];
+	unsigned short nr_vecs = bip->copy_vcnt;
+	struct bio_vec *copy = bip->copy_vec;
 	size_t bytes = bip->bip_iter.bi_size;
 	struct iov_iter iter;
 	int ret;
@@ -116,6 +116,7 @@ static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 	WARN_ON_ONCE(ret != bytes);
 
 	bio_integrity_unpin_bvec(copy, nr_vecs, true);
+	kfree(copy);
 }
 
 static void bio_integrity_unmap_user(struct bio_integrity_payload *bip)
@@ -208,6 +209,7 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 				   unsigned int direction, u32 seed)
 {
 	bool write = direction == ITER_SOURCE;
+	struct bio_vec *copy_vec = NULL;
 	struct bio_integrity_payload *bip;
 	struct iov_iter iter;
 	void *buf;
@@ -224,7 +226,7 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 			goto free_buf;
 		}
 
-		bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
+		bio_integrity_unpin_bvec(bvec, nr_vecs, false);
 	} else {
 		memset(buf, 0, len);
 
@@ -232,19 +234,21 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 		 * We need to preserve the original bvec and the number of vecs
 		 * in it for completion handling
 		 */
-		bip = bio_integrity_alloc(bio, GFP_KERNEL, nr_vecs + 1);
+		copy_vec = kcalloc(nr_vecs, sizeof(*bvec), GFP_KERNEL);
+		if (!copy_vec) {
+			ret = -ENOMEM;
+			goto free_buf;
+		}
+		memcpy(copy_vec, bvec, nr_vecs * sizeof(*bvec));
+
 	}
 
+	bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
 	if (IS_ERR(bip)) {
 		ret = PTR_ERR(bip);
-		goto free_buf;
+		goto free_copy;
 	}
 
-	if (write)
-		bio_integrity_unpin_bvec(bvec, nr_vecs, false);
-	else
-		memcpy(&bip->bip_vec[1], bvec, nr_vecs * sizeof(*bvec));
-
 	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
 				     offset_in_page(buf));
 	if (ret != len) {
@@ -254,9 +258,13 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 
 	bip->bip_flags |= BIP_INTEGRITY_USER | BIP_COPY_USER;
 	bip->bip_iter.bi_sector = seed;
+	bip->copy_vec = copy_vec;
+	bip->copy_vcnt = nr_vecs;
 	return 0;
 free_bip:
 	bio_integrity_free(bio);
+free_copy:
+	kfree(copy_vec);
 free_buf:
 	kfree(buf);
 	return ret;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9b8a369f44bc..ffbfa43d51af 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -345,7 +345,17 @@ struct bio_integrity_payload {
 
 	struct bvec_iter	bio_iter;	/* for rewinding parent bio */
 
-	struct work_struct	bip_work;	/* I/O completion */
+	union {
+		/*
+		 * bip_work is used only for block-layer sent integrity.
+		 * For user sent integrity, reuse the same memory.
+		 */
+		struct work_struct	bip_work;	/* I/O completion */
+		struct {
+			struct bio_vec	*copy_vec; /* pinned user memory */
+			unsigned short	copy_vcnt; /* # of bio_vecs for above */
+		};
+	};
 
 	struct bio_vec		*bip_vec;
 	struct bio_vec		bip_inline_vecs[];/* embedded bvec array */
-- 
2.25.1

