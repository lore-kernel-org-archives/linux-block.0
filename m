Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A81A1474B1
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592736; cv=none; b=lynTjiEpmk9ZmwbnfBKJWZelbF2MOk+l/UYjIz7QuFi8zla2TCOz0j3RN0LO51lDQeBuBLCxbpmr8ZxG0cUkU4WbmYnTZ3aCFjo8GtrT+81Jk6ZZtRewJKNvoaUzCXqoC6PXfigj6qFGLJDgVdjygk7Zbs8Gqh8Rdxei7pWwgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592736; c=relaxed/simple;
	bh=Q3cQFLlFJQJ3q7xAmfD5Nbt3jz+06UgaKT8Gs/twL4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=SZBJPMViz3Be9CA2lAxMDYbZ1zzsRsazf/Xj55Cxlf6bL93Y5xheFgvb8jARPjij9pPlsQ36YC4hUwPuq8lqjcGaaaamrO6t5pd7cWQFaIu2NqoHcpQNoM3jqgUD39DGltO7O6lRRKVByo46521su5LX3fc76KyhoSSv2LsW0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eYWNTMPR; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eYWNTMPR"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240513093210epoutp024cde29dd228272f348fd0803e33452d0~PAn-C4kUp0899108991epoutp02d
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 09:32:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240513093210epoutp024cde29dd228272f348fd0803e33452d0~PAn-C4kUp0899108991epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715592730;
	bh=medcbqT+hzhIxEb9+cGAuNRKUIWaALINKfbnzpxDjK8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=eYWNTMPRgMCYh6gQNSWxDJzKW+rEirm/F3UlJAWFYKJu5EzxFWom00Q4PKadeBVVt
	 q/u0F0BW8Pu2NaZB8LPjcKDKKYGcCRjQZPuxE8dntRYwYNFJEvaHdHRSOwKoTvEel4
	 aPlYCKHATEWP3Q/4TyOz/0lITw80hDwfyhms2wrg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240513093210epcas5p47744252ca84d3f28fbcd33c94312f1f0~PAn_fdLmV0087000870epcas5p4R;
	Mon, 13 May 2024 09:32:10 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VdDlr31yfz4x9Q2; Mon, 13 May
	2024 09:32:08 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.2C.08600.71ED1466; Mon, 13 May 2024 18:32:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240513084939epcas5p4530be8e7fc62b8d4db694d6b5bca3a19~PAC2ldK7h1354513545epcas5p4x;
	Mon, 13 May 2024 08:49:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240513084939epsmtrp2506b8b1119eb210831094d9d8e576497~PAC2kp_2s2957029570epsmtrp2W;
	Mon, 13 May 2024 08:49:39 +0000 (GMT)
X-AuditID: b6c32a44-921fa70000002198-31-6641de17f54e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D7.86.09238.224D1466; Mon, 13 May 2024 17:49:38 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240513084934epsmtip2f6bbb4448dc7bebe6596907b473c2b55~PACyqlI7F2689126891epsmtip2B;
	Mon, 13 May 2024 08:49:34 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH v2] block: unmap and free user mapped integrity via
 submitter
Date: Mon, 13 May 2024 14:12:22 +0530
Message-Id: <20240513084222.8577-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmhq74Pcc0gy2ndC2aJvxltlh9t5/N
	YuXqo0wWR/+/ZbOYdOgao8XeW9oW85c9ZbdYfvwfkwOHx+WzpR6bVnWyeWxeUu+x+2YDm8fH
	p7dYPPq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
	1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWle
	ul5eaomVoYGBkSlQYUJ2RtO3YywFX9UqHv++wdbAeFGhi5GTQ0LARGLHtinMXYxcHEICuxkl
	utfug3I+MUosmP2UHcL5xijR0biFpYuRA6zl3GM+iPheRomevk6ojs+MEtO2z2MEmcsmoC5x
	5HkrmC0iYCSx/9NJVpAiZoHljBKfJx5iBUkIC/hL7F0yH6yIRUBV4uvOP+wgNq+AhcSjp+tZ
	IA6Ul5h56TtUXFDi5MwnYHFmoHjz1tlgmyUEHrFLbHl0hQmiwUXi4I27jBC2sMSr41vYIWwp
	ic/v9rJB2OkSPy4/haovkGg+tg+q3l6i9VQ/M8ibzAKaEut36UOEZSWmnlrHBLGXT6L39xOo
	Vl6JHfNgbCWJ9pVzoGwJib3nGqBsD4mNJ16C/SskECtxde0RxgmM8rOQvDMLyTuzEDYvYGRe
	xSiZWlCcm56abFpgmJdaDo/Z5PzcTYzgpKnlsoPxxvx/eocYmTgYDzFKcDArifA6FNqnCfGm
	JFZWpRblxxeV5qQWH2I0BYbxRGYp0eR8YNrOK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2x
	JDU7NbUgtQimj4mDU6qBaVuzzQX2Xe/iv/3+ImnaZm7z73TxcoYizfpNc9M8H818uCdxfeAR
	J55zX+xLGHlEvUq1T7XceskUsWOzgl9e8PP4/GPrlrN92GdQ4ZMeEiK39J+w2LM7RxMX9xjt
	MtWI3BDQIh4gYDtLbH+RjLvnmkzFltYnSVpPa1n+10yfqRMitOW+5gzHicvudmbtuLri+A6e
	1/b5GTpZ9Zzf/9/OitW0/nil61zPg8U/YuqvxejOmiFzsH3XxdYjLy49XZbudNvOf+2HqSZ9
	y4Ir3t7yqznW3B+7/KyleLwG+7bpjNIV//I5GvuyeWRS93oyfLOTk5UNlvwjlyIrFCblIHs/
	2OyCm+LlKeJLIpxYWs8rsRRnJBpqMRcVJwIAgBVJNCMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSvK7SFcc0g1l/bSyaJvxltlh9t5/N
	YuXqo0wWR/+/ZbOYdOgao8XeW9oW85c9ZbdYfvwfkwOHx+WzpR6bVnWyeWxeUu+x+2YDm8fH
	p7dYPPq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSuj6dsxloKvahWPf99ga2C8qNDFyMEhIWAi
	ce4xXxcjF4eQwG5Gid6Hk1i6GDmB4hISp14uY4SwhSVW/nvODlH0kVHiwaRWJpAEm4C6xJHn
	rWBFIgJmEksPr2EBKWIWWM0ocWLKYjaQDcICvhJfv2qB1LAIqEp83fmHHcTmFbCQePR0PdQy
	eYmZl75DxQUlTs58AhZnBoo3b53NPIGRbxaS1CwkqQWMTKsYJVMLinPTc5MNCwzzUsv1ihNz
	i0vz0vWS83M3MYKDV0tjB+O9+f/0DjEycTAeYpTgYFYS4XUotE8T4k1JrKxKLcqPLyrNSS0+
	xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJg1OqgenesfpDrXVfOvY3y/+y//nX8/Yr9z+R
	NiF3rqydcyXxfd3HxaejHJ+KRp2bWjZVIs58Q/ahysLVypf+6N/9eTXH+/KHtrJFivbVv1lc
	VBa3/BKqtYravdPzev+BlnWu1RplF24tmvbwQdEm93/R8UkRJTXb76R7XX7yRWyu885G1Vat
	W6a7ti18vTPtuEXOJUdfveWuYc7c6UnlB3Mz5/O2zL9kcHWdS+IqjaYb2+pfzz+4b4nO+xfT
	l3K9+Hzm6MzE04tkA/49V9A429WzjWnD7Ri+7+JXYt7Zp8z5eiJFkEdb76sbV0NiThDD8m1X
	fezWChiemf738L8n0++t3jJx/vKDvqyVs49s296ze/YuayWW4oxEQy3mouJEAIxwNZTNAgAA
X-CMS-MailID: 20240513084939epcas5p4530be8e7fc62b8d4db694d6b5bca3a19
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240513084939epcas5p4530be8e7fc62b8d4db694d6b5bca3a19
References: <CGME20240513084939epcas5p4530be8e7fc62b8d4db694d6b5bca3a19@epcas5p4.samsung.com>

The user mapped intergity is copied back and unpinned by
bio_integrity_free which is a low-level routine. Do it via the submitter
rather than doing it in the low-level block layer code, to split the
submitter side from the consumer side of the bio.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
Changes in v2:
- create a helper for unmap logic (Keith)
- return if integrity is not user-mapped (Jens)
- v1: https://lore.kernel.org/linux-block/20240510094429.2489-1-anuj20.g@samsung.com/
---
 block/bio-integrity.c     | 26 ++++++++++++++++++++++++--
 drivers/nvme/host/ioctl.c | 15 +++++++++++----
 include/linux/bio.h       |  4 ++++
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 2e3e8e04961e..8b528e12136f 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -144,16 +144,38 @@ void bio_integrity_free(struct bio *bio)
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct bio_set *bs = bio->bi_pool;
 
+	if (bip->bip_flags & BIP_INTEGRITY_USER)
+		return;
 	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
 		kfree(bvec_virt(bip->bip_vec));
-	else if (bip->bip_flags & BIP_INTEGRITY_USER)
-		bio_integrity_unmap_user(bip);
 
 	__bio_integrity_free(bs, bip);
 	bio->bi_integrity = NULL;
 	bio->bi_opf &= ~REQ_INTEGRITY;
 }
 
+/**
+ * bio_integrity_unmap_free_user - Unmap and free bio user integrity payload
+ * @bio:	bio containing bip to be unmapped and freed
+ *
+ * Description: Used to unmap and free the user mapped integrity portion of a
+ * bio. Submitter attaching the user integrity buffer is responsible for
+ * unmapping and freeing it during completion.
+ */
+void bio_integrity_unmap_free_user(struct bio *bio)
+{
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct bio_set *bs = bio->bi_pool;
+
+	if (WARN_ON_ONCE(!(bip->bip_flags & BIP_INTEGRITY_USER)))
+		return;
+	bio_integrity_unmap_user(bip);
+	__bio_integrity_free(bs, bip);
+	bio->bi_integrity = NULL;
+	bio->bi_opf &= ~REQ_INTEGRITY;
+}
+EXPORT_SYMBOL(bio_integrity_unmap_free_user);
+
 /**
  * bio_integrity_add_page - Attach integrity metadata
  * @bio:	bio to update
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 499a8bb7cac7..2dff5933cae9 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -111,6 +111,13 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	return req;
 }
 
+static void nvme_unmap_bio(struct bio *bio)
+{
+	if (bio_integrity(bio))
+		bio_integrity_unmap_free_user(bio);
+	blk_rq_unmap_user(bio);
+}
+
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, struct io_uring_cmd *ioucmd, unsigned int flags)
@@ -157,7 +164,7 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 
 out_unmap:
 	if (bio)
-		blk_rq_unmap_user(bio);
+		nvme_unmap_bio(bio);
 out:
 	blk_mq_free_request(req);
 	return ret;
@@ -195,7 +202,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
 	if (bio)
-		blk_rq_unmap_user(bio);
+		nvme_unmap_bio(bio);
 	blk_mq_free_request(req);
 
 	if (effects)
@@ -406,7 +413,7 @@ static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd,
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
 	if (pdu->bio)
-		blk_rq_unmap_user(pdu->bio);
+		nvme_unmap_bio(pdu->bio);
 	io_uring_cmd_done(ioucmd, pdu->status, pdu->result, issue_flags);
 }
 
@@ -432,7 +439,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	 */
 	if (blk_rq_is_poll(req)) {
 		if (pdu->bio)
-			blk_rq_unmap_user(pdu->bio);
+			nvme_unmap_bio(pdu->bio);
 		io_uring_cmd_iopoll_done(ioucmd, pdu->result, pdu->status);
 	} else {
 		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d5379548d684..818e93612947 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -731,6 +731,7 @@ static inline bool bioset_initialized(struct bio_set *bs)
 		bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
 
 int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t len, u32 seed);
+void bio_integrity_unmap_free_user(struct bio *bio);
 extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, unsigned int);
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
 extern bool bio_integrity_prep(struct bio *);
@@ -807,6 +808,9 @@ static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
 {
 	return -EINVAL;
 }
+static inline void bio_integrity_unmap_free_user(struct bio *bio)
+{
+}
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
-- 
2.25.1

