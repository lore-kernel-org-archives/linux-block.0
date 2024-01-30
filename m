Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC264364AC
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635175; cv=none; b=Gi7hdUhXEZTkGUtJAB5BvPD2LIfFgt6u3C5nFUd9K1MujS5lNkKTWIPa3AEDSHVk0Xb6u3qYXVxu1tqliH/2zpdxsZAyT6XBNicgIHhFs3PLjVTQbchW29TJydZ4FWqFZt8b3DoftBKRlSyHDZPv95fO+I0KSDgdrQXjTxKi6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635175; c=relaxed/simple;
	bh=YkC204Hu24ySnSlTsJ1JPkFLP762YVmeCDZgwiLmigY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=o4v90d+F4yY6mEwDyjMk7zYRF/GYQRT2hQ4ExRFW3XlEUzXowqHGawlanEuWlp5eQR0R97R1C2LceEZ7orSiQNq4k2FdiwVDM+Z5SghMQpy7Kyk2Mwh/PejlAPbNhIckb7+Go1QFu0eOzLwEbfwcSIfTZOTDWigIihWvIl9j8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FVhgH7gW; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FVhgH7gW"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240130171930epoutp03abbf8ff1837224efea7e11e1e5fff5b2~vL6VTPyZX2939229392epoutp03O
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 17:19:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240130171930epoutp03abbf8ff1837224efea7e11e1e5fff5b2~vL6VTPyZX2939229392epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706635170;
	bh=+ibPEb1+PjwBqvytPRwsK7lhJ44S079tcZ2oSt+6eJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVhgH7gWFXMNIskXH/Je6SMIoet6pzye0hh/pzXsO/ncMXJWbXNq1SSbkSYy44Wx2
	 TMg5SdzYu5ZQQPEhfn9bxPnPpzULOEvLYwy2gjico/dfMEOcLDgCcrqqaegrOTapyp
	 FFU1Ut+CxUCSQWlHr4dm644fiklsXF0v4lef/xoo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240130171929epcas5p285a65e3b12113c2a6e9a94bad0e71d8f~vL6UbBJqN1569115691epcas5p2W;
	Tue, 30 Jan 2024 17:19:29 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TPX343G0Wz4x9Pw; Tue, 30 Jan
	2024 17:19:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.23.09634.0AF29B56; Wed, 31 Jan 2024 02:19:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240130171927epcas5p2814181a20402d08b96393ce4a5e06e03~vL6R1JhXB1569115691epcas5p2R;
	Tue, 30 Jan 2024 17:19:27 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240130171927epsmtrp2f798dc86393c95b3f035d03d77a1f6fb~vL6R0dqgO2665426654epsmtrp2E;
	Tue, 30 Jan 2024 17:19:27 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-09-65b92fa0453c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A3.2D.08817.E9F29B56; Wed, 31 Jan 2024 02:19:26 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240130171925epsmtip271d50a415ad176aff8dd677b8f99f206~vL6QNSfbK1616116161epsmtip21;
	Tue, 30 Jan 2024 17:19:25 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>, Chinmay Gameti
	<c.gameti@samsung.com>
Subject: [PATCH 2/3] block: support PI at non-zero offset within metadata
Date: Tue, 30 Jan 2024 22:42:05 +0530
Message-Id: <20240130171206.4845-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130171206.4845-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmhu4C/Z2pBv93ilisvtvPZvF9ex+L
	xc0DO5ksVq4+ymRx9P9bNotJh64xWuy9pW0xf9lTdovlx/8xWax7/Z7Fgcvj/L2NLB6Xz5Z6
	bFrVyeaxeUm9x+6bDWweH5/eYvHo27KK0ePzJrkAjqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B4
	53hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygC5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUl
	tkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ2RnvWjexF6xxrViw8QNLA+NT8y5GTg4J
	AROJUz332LsYuTiEBHYzSlz7v5EdJCEk8IlR4uoiU4jEN0aJpfffs8N0PF19gQkisZdRomHS
	TUaIjs+MEjNvVHYxcnCwCWhKXJhcChIWEUiS2PbmMxtIPbPAUkaJOZMPgtULC3hKPPp7hwnE
	ZhFQlZj34ieYzStgLrFj2UI2iGXyEjMvfQdbzClgIdG38jEjRI2gxMmZT1hAbGagmuats5lB
	FkgITOSQ+LfgOyvIERICLhL9sw0g5ghLvDq+BeoBKYnP7/ZCzU+WuDTzHBOEXSLxeM9BKNte
	ovVUPzPIGGagX9bv0odYxSfR+/sJE8R0XomONiGIakWJe5OeskLY4hIPZyyBsj0kFs4+yAYJ
	qm5GiTe9bcwTGOVnIflgFpIPZiFsW8DIvIpRMrWgODc9tdi0wDAvtRwercn5uZsYwclUy3MH
	490HH/QOMTJxMB5ilOBgVhLhXSm3M1WINyWxsiq1KD++qDQntfgQoykwiCcyS4km5wPTeV5J
	vKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUyhr+6f3MXO4H/oEc/Z
	nT7X7d74bjihcV5kYlCCPreEs9snmVnVPW7cl7cnVbZN1DU8/sHjiZu1Rod7nmF5S/gi5TSm
	t0eE4h9cSOzuvPzh24dGxhdq5+bL84l9D2/feKW1bLrXPdOmK8VnMvyDEvbr7Ngz81Z2Ou+5
	9deupD1amGt5+fxTEd5vboff35Tt9j85wea/Wb1pKd/ti7+6VRV3XfeWynvIynwl9IyqyC41
	8Uj+4iAnw6ezEiyEZvCcXWDquTCZO6T3nPitrCD9EImeBVlm17m4D99tudAZuL8vbubip8Jv
	cz2YXPI/SR+Ki3rM+bPu3HbLYh2hrWc2m7FfWOoZ+v/KvQnO9y1lzyuxFGckGmoxFxUnAgBP
	60M4LwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvO48/Z2pBj0NNhar7/azWXzf3sdi
	cfPATiaLlauPMlkc/f+WzWLSoWuMFntvaVvMX/aU3WL58X9MFutev2dx4PI4f28ji8fls6Ue
	m1Z1snlsXlLvsftmA5vHx6e3WDz6tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoEr413rJvaCNa4V
	CzZ+YGlgfGrexcjJISFgIvF09QWmLkYuDiGB3YwSb87eYoZIiEs0X/vBDmELS6z89xzMFhL4
	yChx5ZxqFyMHB5uApsSFyaUgYRGBDInZq7+BlTALrGSUaJ5fDmILC3hKPPp7hwnEZhFQlZj3
	4ieYzStgLrFj2UI2iPHyEjMvfQfr5RSwkOhb+ZgRYpW5xNI/Z5kh6gUlTs58wgIxX16ieets
	5gmMArOQpGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcCVpaOxj3rPqg
	d4iRiYPxEKMEB7OSCO9KuZ2pQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5N
	LUgtgskycXBKNTDlXd5hErzTOP5+69ILWVLKCivCD9n9OSS/8LuiZh1/7cLl9vb/Yx58Kfk8
	efNuK5kHNs9n7+X/F8qWXl+x7+PC5o+KRkyRV8TPrZ8uaqC/o0Sn/bvL9SfGM+Y71XpOiOPV
	TlqwcGYiq8BFr9z7LxfVMlorsjNXcGzPZTBi9FXeF/LV9cPnGToMX4sVl4qcXHgya8ZB2TVs
	vCEKWWeq8hb3SnTd5oz6mCfRLRQXpGN8V0b4muKO88v+ej+YEq1d+/qvxcn/wke8y++J9U7K
	O1/S2PZ0UsY9KVY2m7V3NK1/fP92YPp8G+sTi2J4p78p9TD/K+i3YYm6XN+efy8Cy1b2V8cu
	DF+QfNOgK3XNA18lluKMREMt5qLiRADpUm5T8wIAAA==
X-CMS-MailID: 20240130171927epcas5p2814181a20402d08b96393ce4a5e06e03
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240130171927epcas5p2814181a20402d08b96393ce4a5e06e03
References: <20240130171206.4845-1-joshi.k@samsung.com>
	<CGME20240130171927epcas5p2814181a20402d08b96393ce4a5e06e03@epcas5p2.samsung.com>

The block integrity subsystem assumes that PI appears first in the
metadata buffer.
Abolish this assumption by adding the ability to handle PI starting at
a non-zero offset.
Calculation of the guard tag includes the metadata buffer up to this
offset.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Chinmay Gameti <c.gameti@samsung.com>
---
 block/bio-integrity.c         |  1 +
 block/blk-integrity.c         |  1 +
 block/t10-pi.c                | 52 +++++++++++++++++++++++++----------
 include/linux/blk-integrity.h |  1 +
 include/linux/blkdev.h        |  1 +
 5 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index c9a16fba58b9..2e3e8e04961e 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -395,6 +395,7 @@ static blk_status_t bio_integrity_process(struct bio *bio,
 	iter.tuple_size = bi->tuple_size;
 	iter.seed = proc_iter->bi_sector;
 	iter.prot_buf = bvec_virt(bip->bip_vec);
+	iter.pi_offset = bi->pi_offset;
 
 	__bio_for_each_segment(bv, bio, bviter, *proc_iter) {
 		void *kaddr = bvec_kmap_local(&bv);
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index d4e9b4556d14..ccbeb6dfa87a 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -370,6 +370,7 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	bi->profile = template->profile ? template->profile : &nop_profile;
 	bi->tuple_size = template->tuple_size;
 	bi->tag_size = template->tag_size;
+	bi->pi_offset = template->pi_offset;
 
 	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 251a7b188963..80029292ae4c 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -33,11 +33,15 @@ static blk_status_t t10_pi_generate(struct blk_integrity_iter *iter,
 		csum_fn *fn, enum t10_dif_type type)
 {
 	unsigned int i;
+	u8 offset = iter->pi_offset;
 
 	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
-		struct t10_pi_tuple *pi = iter->prot_buf;
+		struct t10_pi_tuple *pi = iter->prot_buf + offset;
 
 		pi->guard_tag = fn(0, iter->data_buf, iter->interval);
+		if (offset)
+			pi->guard_tag = fn(pi->guard_tag, iter->prot_buf,
+					   offset);
 		pi->app_tag = 0;
 
 		if (type == T10_PI_TYPE1_PROTECTION)
@@ -57,11 +61,12 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 		csum_fn *fn, enum t10_dif_type type)
 {
 	unsigned int i;
+	u8 offset = iter->pi_offset;
 
 	BUG_ON(type == T10_PI_TYPE0_PROTECTION);
 
 	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
-		struct t10_pi_tuple *pi = iter->prot_buf;
+		struct t10_pi_tuple *pi = iter->prot_buf + offset;
 		__be16 csum;
 
 		if (type == T10_PI_TYPE1_PROTECTION ||
@@ -84,6 +89,8 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 		}
 
 		csum = fn(0, iter->data_buf, iter->interval);
+		if (offset)
+			csum = fn(csum, iter->prot_buf, offset);
 
 		if (pi->guard_tag != csum) {
 			pr_err("%s: guard tag error at sector %llu " \
@@ -134,9 +141,11 @@ static blk_status_t t10_pi_type1_verify_ip(struct blk_integrity_iter *iter)
  */
 static void t10_pi_type1_prepare(struct request *rq)
 {
-	const int tuple_sz = rq->q->integrity.tuple_size;
+	struct blk_integrity *bi = &rq->q->integrity;
+	const int tuple_sz = bi->tuple_size;
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
+	u8 offset = bi->pi_offset;
 
 	__rq_for_each_bio(bio, rq) {
 		struct bio_integrity_payload *bip = bio_integrity(bio);
@@ -154,7 +163,7 @@ static void t10_pi_type1_prepare(struct request *rq)
 
 			p = bvec_kmap_local(&iv);
 			for (j = 0; j < iv.bv_len; j += tuple_sz) {
-				struct t10_pi_tuple *pi = p;
+				struct t10_pi_tuple *pi = p + offset;
 
 				if (be32_to_cpu(pi->ref_tag) == virt)
 					pi->ref_tag = cpu_to_be32(ref_tag);
@@ -183,10 +192,12 @@ static void t10_pi_type1_prepare(struct request *rq)
  */
 static void t10_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 {
-	unsigned intervals = nr_bytes >> rq->q->integrity.interval_exp;
-	const int tuple_sz = rq->q->integrity.tuple_size;
+	struct blk_integrity *bi = &rq->q->integrity;
+	unsigned intervals = nr_bytes >> bi->interval_exp;
+	const int tuple_sz = bi->tuple_size;
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
+	u8 offset = bi->pi_offset;
 
 	__rq_for_each_bio(bio, rq) {
 		struct bio_integrity_payload *bip = bio_integrity(bio);
@@ -200,7 +211,7 @@ static void t10_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 
 			p = bvec_kmap_local(&iv);
 			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
-				struct t10_pi_tuple *pi = p;
+				struct t10_pi_tuple *pi = p + offset;
 
 				if (be32_to_cpu(pi->ref_tag) == ref_tag)
 					pi->ref_tag = cpu_to_be32(virt);
@@ -289,11 +300,15 @@ static blk_status_t ext_pi_crc64_generate(struct blk_integrity_iter *iter,
 					enum t10_dif_type type)
 {
 	unsigned int i;
+	u8 offset = iter->pi_offset;
 
 	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
-		struct crc64_pi_tuple *pi = iter->prot_buf;
+		struct crc64_pi_tuple *pi = iter->prot_buf + offset;
 
 		pi->guard_tag = ext_pi_crc64(0, iter->data_buf, iter->interval);
+		if (offset)
+			pi->guard_tag = ext_pi_crc64(be64_to_cpu(pi->guard_tag),
+					iter->prot_buf, offset);
 		pi->app_tag = 0;
 
 		if (type == T10_PI_TYPE1_PROTECTION)
@@ -320,9 +335,10 @@ static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
 				      enum t10_dif_type type)
 {
 	unsigned int i;
+	u8 offset = iter->pi_offset;
 
 	for (i = 0; i < iter->data_size; i += iter->interval) {
-		struct crc64_pi_tuple *pi = iter->prot_buf;
+		struct crc64_pi_tuple *pi = iter->prot_buf + offset;
 		u64 ref, seed;
 		__be64 csum;
 
@@ -344,6 +360,10 @@ static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
 		}
 
 		csum = ext_pi_crc64(0, iter->data_buf, iter->interval);
+		if (offset)
+			csum = ext_pi_crc64(be64_to_cpu(csum), iter->prot_buf,
+					    offset);
+
 		if (pi->guard_tag != csum) {
 			pr_err("%s: guard tag error at sector %llu " \
 			       "(rcvd %016llx, want %016llx)\n",
@@ -373,9 +393,11 @@ static blk_status_t ext_pi_type1_generate_crc64(struct blk_integrity_iter *iter)
 
 static void ext_pi_type1_prepare(struct request *rq)
 {
-	const int tuple_sz = rq->q->integrity.tuple_size;
+	struct blk_integrity *bi = &rq->q->integrity;
+	const int tuple_sz = bi->tuple_size;
 	u64 ref_tag = ext_pi_ref_tag(rq);
 	struct bio *bio;
+	u8 offset = bi->pi_offset;
 
 	__rq_for_each_bio(bio, rq) {
 		struct bio_integrity_payload *bip = bio_integrity(bio);
@@ -393,7 +415,7 @@ static void ext_pi_type1_prepare(struct request *rq)
 
 			p = bvec_kmap_local(&iv);
 			for (j = 0; j < iv.bv_len; j += tuple_sz) {
-				struct crc64_pi_tuple *pi = p;
+				struct crc64_pi_tuple *pi = p +  offset;
 				u64 ref = get_unaligned_be48(pi->ref_tag);
 
 				if (ref == virt)
@@ -411,10 +433,12 @@ static void ext_pi_type1_prepare(struct request *rq)
 
 static void ext_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 {
-	unsigned intervals = nr_bytes >> rq->q->integrity.interval_exp;
-	const int tuple_sz = rq->q->integrity.tuple_size;
+	struct blk_integrity *bi = &rq->q->integrity;
+	unsigned intervals = nr_bytes >> bi->interval_exp;
+	const int tuple_sz = bi->tuple_size;
 	u64 ref_tag = ext_pi_ref_tag(rq);
 	struct bio *bio;
+	u8 offset = bi->pi_offset;
 
 	__rq_for_each_bio(bio, rq) {
 		struct bio_integrity_payload *bip = bio_integrity(bio);
@@ -428,7 +452,7 @@ static void ext_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 
 			p = bvec_kmap_local(&iv);
 			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
-				struct crc64_pi_tuple *pi = p;
+				struct crc64_pi_tuple *pi = p + offset;
 				u64 ref = get_unaligned_be48(pi->ref_tag);
 
 				if (ref == ref_tag)
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 378b2459efe2..e253e7bd0d17 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -20,6 +20,7 @@ struct blk_integrity_iter {
 	unsigned int		data_size;
 	unsigned short		interval;
 	unsigned char		tuple_size;
+	unsigned char		pi_offset;
 	const char		*disk_name;
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d7cac3de65b3..bb4d811fee46 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -108,6 +108,7 @@ struct blk_integrity {
 	const struct blk_integrity_profile	*profile;
 	unsigned char				flags;
 	unsigned char				tuple_size;
+	unsigned char				pi_offset;
 	unsigned char				interval_exp;
 	unsigned char				tag_size;
 };
-- 
2.25.1

