Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304115FA73
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335211; cv=none; b=rlRaIpsOMttqQJzfAIx/9lkmcogSB3LNgENxysb8PUwHFJnT7OQapJjlWs1o4XuyEq3R7LGZC9iXP4JEFadbxpUwlT2JYzlqLClW5I06Zhfai0N2g2pTZYyVloAJoo+GmwFhXn540pL1ifV9LCMh/Qpnrnm3mDf3GNv1d79YWok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335211; c=relaxed/simple;
	bh=iHfdrI4o8NtJNmmXTYihmx93hwbFFf8eX5MNuewjIJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=RHG852mB0CbXFfnZ3sfAyoJR00dNo9N34B8yUE5avCbJEqZU85VRagZnOZv6fj6ohhpx5UsPu2zDvKH3BNW3MKL+Tz1s03AFHkqlgmsdX5x4Rk2M1CLwcPxk+Zlo7grEvJXEnTkbTbMWMee842wYX/fxhRTelcNAH45jZMvcoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XCuAGUUN; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XCuAGUUN"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240510095959epoutp02b83fdc8f9247c55fe363020d86c5ee4f~OGEaYBhid2391223912epoutp02E
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 09:59:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240510095959epoutp02b83fdc8f9247c55fe363020d86c5ee4f~OGEaYBhid2391223912epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715335199;
	bh=93G5ah7DVtX5uw3KznclAfpkwuJaV8fyC+VLi849VZI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=XCuAGUUNgfS0d7+JI5qknFvOAoOYLHeCeXrBBU7V535LysBSzh9xY0cw5VkSJ66y7
	 cVr+lyKH0Nz3l5oBvVP5v7irXHg43Y32lBTtQwGZvGpSWzS1qZ+7t3DG9bzGTdWo/R
	 5nBJYOXcWCNgNPs2dXXbWW3LBmZ+CjZJ38oc9U7o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240510095958epcas5p3d67565582f5fe71788d9e61318782ac9~OGEZzE8Op2425024250epcas5p3Q;
	Fri, 10 May 2024 09:59:58 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VbPWH4TB8z4x9Pr; Fri, 10 May
	2024 09:59:55 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.6F.09665.510FD366; Fri, 10 May 2024 18:59:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240510095142epcas5p4fde65328020139931417f83ccedbce90~OF9LPsI8i1295512955epcas5p4W;
	Fri, 10 May 2024 09:51:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240510095142epsmtrp24aae989e5140b367b19f769ef023460e~OF9LO5ji72564125641epsmtrp2X;
	Fri, 10 May 2024 09:51:42 +0000 (GMT)
X-AuditID: b6c32a4b-5cdff700000025c1-4d-663df015b18f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.9F.08924.E2EED366; Fri, 10 May 2024 18:51:42 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240510095140epsmtip1ea6525f2e48cd4f67e7a1d212092e993~OF9J6A6Ii1972319723epsmtip1N;
	Fri, 10 May 2024 09:51:40 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH] block: unmap and free user mapped integrity via submitter
Date: Fri, 10 May 2024 15:14:29 +0530
Message-Id: <20240510094429.2489-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmhq7oB9s0gxPz+SyaJvxltlh9t5/N
	YuXqo0wWR/+/ZbOYdOgao8XeW9oW85c9ZbdYfvwfkwOHx+WzpR6bVnWyeWxeUu+x+2YDm8fH
	p7dYPPq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
	1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWle
	ul5eaomVoYGBkSlQYUJ2xoxJ69gKTqhUvNh7m7GBcY9cFyMnh4SAicTfFT+Zuxi5OIQEdjNK
	nLk8iR3C+cQoMfXjbzYI5xujRMO0lWwwLWffLGUFsYUE9jJKbFzmAFH0mVHi3fnVYAk2AXWJ
	I89bGUFsEQEjif2fTrKCFDELLGeU+DzxEFiRsICXxLN518BsFgFViVM/94LZvAIWEnv+TGSC
	2CYvMfPSd3aIuKDEyZlPWEBsZqB489bZYIdLCDxil9h2+ApUg4vEneVvWCFsYYlXx7ewQ9hS
	Ep/f7YV6IV3ix+WnUPUFEs3H9jFC2PYSraf6gYZyAC3QlFi/Sx8iLCsx9dQ6Joi9fBK9v59A
	tfJK7JgHYytJtK+cA2VLSOw91wBle0j8en2ZERJasRJLVy9gn8AoPwvJO7OQvDMLYfMCRuZV
	jJKpBcW56anFpgXGeanl8JhNzs/dxAhOmlreOxgfPfigd4iRiYPxEKMEB7OSCG9VjXWaEG9K
	YmVValF+fFFpTmrxIUZTYBhPZJYSTc4Hpu28knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNL
	UrNTUwtSi2D6mDg4pRqY9PdPrluzUqHg1txDR6Zk/W99dt9gixtz2Gud/O5vG1+fvcvkdJHh
	cK6u455V27a81OO2TwlbfLvzzEqjZc67ZQ/Pv3dxh7fuTl2pH3t3Hjor/otdzvX83D8ffCtN
	7Cc9OFXg4CC/57tBo+LyCR+Xmxq+Fw48/O76gtmzS0q0150TzrhxqCD8XNfFladbPrKbBkra
	HHvwM/FHsNzcxzy6/xedjZY73njpotv0iH2nDjNKR77jOZJzhHtRovYSGd3IKUc1Fuww/ZW7
	0Vhdvkxvqd6+xnjmLRzeu50WVka6VD8X3fc5xM6/zHa3t6z3rrIXs2IWChwMvRBVq/o6c0/i
	m2Wcb92OXGqYpeS1LVDwm4cSS3FGoqEWc1FxIgCuxv2FIwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnK7eO9s0g6u72CyaJvxltlh9t5/N
	YuXqo0wWR/+/ZbOYdOgao8XeW9oW85c9ZbdYfvwfkwOHx+WzpR6bVnWyeWxeUu+x+2YDm8fH
	p7dYPPq2rGL0+LxJLoA9issmJTUnsyy1SN8ugStjxqR1bAUnVCpe7L3N2MC4R66LkZNDQsBE
	4uybpaxdjFwcQgK7GSWWzbvEDJGQkDj1chkjhC0ssfLfc3aIoo+MEq+PTGUDSbAJqEsced4K
	ViQiYCax9PAaFpAiZoHVjBInpiwGKxIW8JJ4Nu8aK4jNIqAqcernXjCbV8BCYs+fiUwQG+Ql
	Zl76zg4RF5Q4OfMJC4jNDBRv3jqbeQIj3ywkqVlIUgsYmVYxSqYWFOem5xYbFhjmpZbrFSfm
	Fpfmpesl5+duYgQHsJbmDsbtqz7oHWJk4mA8xCjBwawkwltVY50mxJuSWFmVWpQfX1Sak1p8
	iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqgUlA8sl66QtyjGGfZqUF//xwtDz4udSD
	6zdnnd+/KXVNo1jxgoQPjXGT1my2+5Nc+O5NVPTGMkFRD9mjpb5TFD7yHVl+fdNEZsbHPruT
	X+0rjerXfaw19RbbtkWfA5iXF1/76cawbcf/KanGmqsf7diTzeIXt17wqvby2XcXHc9/tfhO
	tbS7y+8/xYk6phUtKjY2e37N/dJ0cVnNJtmCZ+pnZp+PLjJfcfuyg8DcmfW6d7tPXSkOzCjm
	fRA+he/WZ7FCt+WZ0/9nihrdsO1+eerzrXjJrFXrEz9Py5+4fc9rG0mDfVUfS438ZqvomYfN
	vPzsYGKx1rH0pg8PNzW+Wb3xkY3Aew7Zs+vZ16kL2Rx5psRSnJFoqMVcVJwIAPHsIZTPAgAA
X-CMS-MailID: 20240510095142epcas5p4fde65328020139931417f83ccedbce90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240510095142epcas5p4fde65328020139931417f83ccedbce90
References: <CGME20240510095142epcas5p4fde65328020139931417f83ccedbce90@epcas5p4.samsung.com>

The user mapped intergity is copied back and unpinned by
bio_integrity_free which is a low-level routine. Do it via the submitter
rather than doing it in the low-level block layer code, to split the
submitter side from the consumer side of the bio.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/bio-integrity.c     | 25 +++++++++++++++++++++++--
 drivers/nvme/host/ioctl.c | 20 ++++++++++++++++----
 include/linux/bio.h       |  4 ++++
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 2e3e8e04961e..82a0fa91bb8f 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -144,16 +144,37 @@ void bio_integrity_free(struct bio *bio)
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
+	WARN_ON(!(bip->bip_flags & BIP_INTEGRITY_USER));
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
index 499a8bb7cac7..8016dcf23ad1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -156,8 +156,11 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	return ret;
 
 out_unmap:
-	if (bio)
+	if (bio) {
+		if (bio_integrity(bio))
+			bio_integrity_unmap_free_user(bio);
 		blk_rq_unmap_user(bio);
+	}
 out:
 	blk_mq_free_request(req);
 	return ret;
@@ -194,8 +197,11 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	ret = nvme_execute_rq(req, false);
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
-	if (bio)
+	if (bio) {
+		if (bio_integrity(bio))
+			bio_integrity_unmap_free_user(bio);
 		blk_rq_unmap_user(bio);
+	}
 	blk_mq_free_request(req);
 
 	if (effects)
@@ -405,8 +411,11 @@ static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd,
 {
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
-	if (pdu->bio)
+	if (pdu->bio) {
+		if (bio_integrity(pdu->bio))
+			bio_integrity_unmap_free_user(pdu->bio);
 		blk_rq_unmap_user(pdu->bio);
+	}
 	io_uring_cmd_done(ioucmd, pdu->status, pdu->result, issue_flags);
 }
 
@@ -431,8 +440,11 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	 * Otherwise, move the completion to task work.
 	 */
 	if (blk_rq_is_poll(req)) {
-		if (pdu->bio)
+		if (pdu->bio) {
+			if (bio_integrity(pdu->bio))
+				bio_integrity_unmap_free_user(pdu->bio);
 			blk_rq_unmap_user(pdu->bio);
+		}
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

