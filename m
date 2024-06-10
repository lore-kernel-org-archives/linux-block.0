Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB12FFC01
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018776; cv=none; b=ijRXDOHU2AzuHL9w7zQY43ke0S84baP6ho9BRZJgTUtAroTYSCye8xj5TYFvGqXbiNGjRCtRFEuUz839Oxhu2ehHDCE6RjhLmnsfNsj/HnMk4Mm7xZYLQROC8CxEjglIuwfsxF7uT9xPRx7XBWSHvER6I2dQghcyn5qx1mOndqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018776; c=relaxed/simple;
	bh=dRSCnSi2wW2YkNcg+iNxRDlyrX+MlVwWieDSDoP1Ugk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=YOMZN9h/tn15BsHeknI4WQt2XOJSvVTXDcn5/FyL+J1Ekkt0KwTJsIvF6GzesZPWos8qggpFYdf4/kjPARk74Y1DhejEg5ruoJUlIl0X8bCwx7QSCiVg2zB2V9tMkZww6+uEtumeAy8tpP/oLGFqw7X8ZcluWPZzVxHkJENvxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J2M+PN/U; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J2M+PN/U"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240610112611epoutp03220e6a7aba67e919b61ddcf86d9fae53~XoPhEWAr50651506515epoutp03x
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 11:26:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240610112611epoutp03220e6a7aba67e919b61ddcf86d9fae53~XoPhEWAr50651506515epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718018771;
	bh=H5PrZC3wARxzuDSS35YKymK2QxWjB5gAOd2JPIJ8IIs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=J2M+PN/UfI1vMCQvBL41P85H58TREIGKpQ3OpMHAgS5wby+NrLLDLmQufr798MJa3
	 qw4uKdNFKIq0+Fygr1NMaLGefZq7uEf2JTMOHCtJtizxl4RcMtp+THrudPTNfEDXWA
	 tuO6AUAoBnDvB1z2SgCAhwp5XXfZzR3vwbdTe4iQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240610112610epcas5p28caefce5679b80e6d39304920f68c5b2~XoPggFFwi2826128261epcas5p2H;
	Mon, 10 Jun 2024 11:26:10 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VyTyS5LZNz4x9Q7; Mon, 10 Jun
	2024 11:26:08 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	93.C1.19174.0D2E6666; Mon, 10 Jun 2024 20:26:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7~XoJphKCI72514725147epcas5p1A;
	Mon, 10 Jun 2024 11:19:27 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240610111927epsmtrp103c1ea7595d63bd46982c4db7082296c~XoJpghO3o1035010350epsmtrp1u;
	Mon, 10 Jun 2024 11:19:27 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-e3-6666e2d0d7d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	08.46.18846.F31E6666; Mon, 10 Jun 2024 20:19:27 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240610111926epsmtip28a89bb83cdd1c4828647a6575ce84c2f~XoJoTr_aK0849908499epsmtip2N;
	Mon, 10 Jun 2024 11:19:26 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v3] block: unmap and free user mapped integrity via
 submitter
Date: Mon, 10 Jun 2024 16:41:44 +0530
Message-Id: <20240610111144.14647-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmuu6FR2lpBiuWqVg0TfjLbLH6bj+b
	xcrVR5ksjv5/y2Yx6dA1Rou9t7Qt5i97ym6x/Pg/JgcOj8tnSz02repk89i8pN5j980GNo+P
	T2+xePRtWcXo8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
	qq2Si0+ArltmDtBJSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8
	dL281BIrQwMDI1OgwoTsjCcPTzAV3FKt2PX9JFMD41n5LkZODgkBE4nrPz8zdzFycQgJ7GGU
	+LZwEiuE84lR4uOmaywgVWBO1xltmI6b7fsZIYp2Mkr8Pv6KEaLoM6PE/nW8IDabgLrEkeet
	YHERgQCJWaevgDUwC3QySvzqugeWEBbwl/g87QIziM0ioCrxbv8NVhCbV8BSYvnvCUwQ2+Ql
	Zl76zg4RF5Q4OfMJ2EXMQPHmrbPB7pYQuMUusefDVTaIBheJmddfsEPYwhKvjm+BsqUkXva3
	QdnpEj8uP4VaUCDRfGwfI4RtL9F6qh9oKAfQAk2J9bv0IcKyElNPrWOC2Msn0fv7CVQrr8SO
	eTC2kkT7yjlQtoTE3nMNULaHxIPFp5ggARQr0fH3GtMERvlZSN6ZheSdWQibFzAyr2KUSi0o
	zk1PTTYtMNTNSy2Hx2xyfu4mRnDS1ArYwbh6w1+9Q4xMHIyHGCU4mJVEeIUyktOEeFMSK6tS
	i/Lji0pzUosPMZoCA3kis5Rocj4wbeeVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2a
	WpBaBNPHxMEp1cCU+vtjwYO0k5t/tofHqycq7KksL/6aGtiR7y65iid20fqy32cPK7mwvAhp
	n1zn2Mp/YqrB8Tu3BRcGHAznvd6SHrIi+23jpFDRoJTTOzqUxT9xreZ9cMztbEW0uKDZihzO
	Wrbf91ctj+Z73BXN9eBR/JMrLeEKCtc0048c3LOZUX97/FmZY1pHvsRf3HW8N/VwvB7L/wKf
	TQKSHtm73i9fo+EuKLL/8Rwl5cgtZ1YUHv9ou8DyyOWbj8QjhLsrQ5vE5A8/M/RfoPW8LHjB
	UaNPW29qqT7Iu6+zXfSqw/klJSIKqgtPuknsz/nocINt84z3oovN/1/se3ug4OXKCM0e9jeL
	oh8bLalcffPpizVsSizFGYmGWsxFxYkAScRBaiMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSvK79w7Q0g/NntS2aJvxltlh9t5/N
	YuXqo0wWR/+/ZbOYdOgao8XeW9oW85c9ZbdYfvwfkwOHx+WzpR6bVnWyeWxeUu+x+2YDm8fH
	p7dYPPq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSvjycMTTAW3VCt2fT/J1MB4Vr6LkZNDQsBE
	4mb7fsYuRi4OIYHtjBJ32r+zQyQkJE69XMYIYQtLrPz3nB2i6COjxO4N3WwgCTYBdYkjz1uB
	ijg4RARCJHqOmIDUMAv0MkocebGfBaRGWMBX4tzif2CDWARUJd7tv8EKYvMKWEos/z2BCWKB
	vMTMSxCLeQUEJU7OfALWywwUb946m3kCI98sJKlZSFILGJlWMYqmFhTnpucmFxjqFSfmFpfm
	pesl5+duYgSHrVbQDsZl6//qHWJk4mA8xCjBwawkwiuUkZwmxJuSWFmVWpQfX1Sak1p8iFGa
	g0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwBRknR/UuUXPQPw6txX7s4qcBSsvvfmWoPim
	5BF3c0atqHrPuqsbP1m3nI75UHfiFturpvdTDht9nPZyCvOys5/rpGZ/7eZvEBfxusd88M35
	6oiW+cri3zndOW04bL/rWx8zE3XnPGDeI70mm2tu/axnutcT2rzaj049MvVg+vvfbx+eWmh+
	9WPRzMbjesmn15w3POH1hNXIqNVy8xIrlwq/K8e3L3Z+tsGsd+7zeu0w1rxvvc9TPZwS8xVX
	HgpfonE651l0pPNGRnup79Lr00K3Z8q3vK07/WdjMtdOfqvC0+c31d1itgxrsDzCNCu+ZrPS
	yXpGEWOrkpUbvnwRfeGqxe8mcPyGziqeT9sMUpVYijMSDbWYi4oTAUEb6QTKAgAA
X-CMS-MailID: 20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7
References: <CGME20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7@epcas5p1.samsung.com>

The user mapped intergity is copied back and unpinned by
bio_integrity_free which is a low-level routine. Do it via the submitter
rather than doing it in the low-level block layer code, to split the
submitter side from the consumer side of the bio.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

