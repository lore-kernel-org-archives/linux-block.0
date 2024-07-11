Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5A5821A
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 05:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675214; cv=none; b=qSv05ClNR7efeX2RQ2nFnIHr2NzwL0Wj7HfOrKAtZLe/u8Dvz9mmKen1HVgdf5j0Xanc2PK7pyH/tDFtN8cdTfgTRyfylxbC9gaYaJt/zdxiBdbmZJcKxGTi04s3tJ4KdVXuk5MCsbj0XWo1BHDb6Qukfi2OzYNBZOH75V0walo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675214; c=relaxed/simple;
	bh=MOErW+3cwzKhNWrsaEfV0Kp3dW8ivvUuZbDORFwshfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=rR8ZIDZGbOQifr7Uo2eqGh2heBliRTJA1/BDEt1bPudR1M87YCIkUr2EMAsHS1KXtcPvdY7KIpAXcqcddkFHaj9IZzDW2T0WGXf6TD18O/tqvMInuIyPrt94DR66URldisTBiptmfj/vtjRp/YVaFsZB7kffVp1XAldkDbWKdE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YsjIgvRw; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YsjIgvRw"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240711052011epoutp01fe225f4da2b16e9a20a31f1fbcca443a~hEPzmqdGi0543005430epoutp01F
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 05:20:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240711052011epoutp01fe225f4da2b16e9a20a31f1fbcca443a~hEPzmqdGi0543005430epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720675211;
	bh=T3jsnH2IlRJgZk3DwZtmFeE4PLHu5FwsealKd2ct36c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsjIgvRw3N0XgG1YW41K1JjyN4EFro722wIdEn/zv6VbriWRSgpFnnffcvAgkWXzh
	 0po8uXq+Ppe3u73Lwk5/AyjlW3ffmrqUN4ytR4LpN/Y8tlmxJ+wH97xZn5Ou3A5CCD
	 DYFFwgNXyWKH6MzsLMBoTi3CaoBD+TXGgQLXdziM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240711052004epcas5p3de0715fb91cde06c96ec910d86819021~hEPtZcOKE1244412444epcas5p3k;
	Thu, 11 Jul 2024 05:20:04 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WKNMk1pHnz4x9Ps; Thu, 11 Jul
	2024 05:20:02 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.1E.06857.28B6F866; Thu, 11 Jul 2024 14:20:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240711051532epcas5p360e92f46b86eca56e73643a71950783a~hELwI-Xpy1631916319epcas5p3t;
	Thu, 11 Jul 2024 05:15:32 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240711051532epsmtrp2f677df2bb7a211f899db7036185bbe30~hELwINXGD1668816688epsmtrp2_;
	Thu, 11 Jul 2024 05:15:32 +0000 (GMT)
X-AuditID: b6c32a4b-88bff70000021ac9-3b-668f6b82e2b5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E6.9E.18846.47A6F866; Thu, 11 Jul 2024 14:15:32 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240711051530epsmtip1cf5c979561437fa2f30ee651be594211~hELubciw-0258502585epsmtip1x;
	Thu, 11 Jul 2024 05:15:30 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v8 2/5] block: Added folio-ized version of bio_add_hw_page()
Date: Thu, 11 Jul 2024 10:37:47 +0530
Message-Id: <20240711050750.17792-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711050750.17792-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmum5Tdn+aQddUdoumCX+ZLVbf7Wez
	+L69j8Xi5oGdTBYrVx9lsjj6/y2bxaRD1xgttn75ymqx95a2xY0JTxkttv2ez2zx+8ccNgce
	j80rtDwuny312LSqk81j980GNo++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53
	jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6UEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xi
	q5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnbH64yP2gh75iv2tE9gaGNsluxg5OSQE
	TCSOfp/P3MXIxSEksJtR4uWTJewQzidGiZ/7V7LBORc+LGCHadm7dwUrRGIno8Sn98tYIJzP
	jBJzvjwCquLgYBPQlfjRFArSICLgLjH15SNGkBpmgbOMEiemPmIBSQgL+EisvL6BCcRmEVCV
	aJu+iBHE5hWwlfjVdpkZYpu8xMxL38E2cwrYSWz8844FokZQ4uTMJ2A2M1BN89bZYE9ICEzk
	kDh48SkjRLOLxJZ5D6DOFpZ4dXwLlC0l8fndXjYIO1viUCPEERICJRI7jzRA1dhLtJ7qZwZ5
	hllAU2L9Ln2IsKzE1FPrmCD28kn0/n4C1corsWMejK0mMefdVBYIW0Zi4aUZTCBjJAQ8JBr/
	JEHCaiKjxOl3jSwTGBVmIXlnFpJ3ZiFsXsDIvIpRMrWgODc9tdi0wDgvtRwey8n5uZsYwalW
	y3sH46MHH/QOMTJxMB5ilOBgVhLhnX+jO02INyWxsiq1KD++qDQntfgQoykwvCcyS4km5wOT
	fV5JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUx1dklnw9aIvjef
	Hu+u1qn1aVF4lcTHySqOX+aGv45cONPsxbw3bxWWfDPbvFaK+1zV31Kz051XzKJ+OvG9kOIO
	X36iuGWxyZ3oZlbR+z1xtw2aMwSWHoqdedvfw8658ldeag3v5aUic7jjJYX3eTxlO2KzXiTj
	WWvd45YdjIfm2VbdeSDye8ta/tKY2wsSHZd/6+COYHzxcsXLyR1BPhO+nkmb2JG6dUn4BHN/
	xQO671pE+4vl/UQ2ZjY6N8crX+h9vVFTLHuSlWc/257wTIeNp3ZPm3C9UMe2ea1R+G8WlrkH
	QqOkDU3OiTTfP1/lfHDSOcOFKQ0yb//u5LhSy1F0xkKVL1255fyfVS83H1NiKc5INNRiLipO
	BABIqvq5PgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnG5JVn+awa0twhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVsfrjI/aCHvmK
	/a0T2BoY2yW7GDk5JARMJPbuXcHaxcjFISSwnVHiyJyzzBAJGYndd3eyQtjCEiv/PWcHsYUE
	PjJK3L0IVMPBwSagK/GjKRQkLCLgK7Fgw3NGkDnMAtcZJW5M3wo2R1jAR2Ll9Q1MIDaLgKpE
	2/RFjCA2r4CtxK+2y1C75CVmXvoONp9TwE5i4593LBC7bCX+b7vCDlEvKHFy5hOwODNQffPW
	2cwTGAVmIUnNQpJawMi0ilE0taA4Nz03ucBQrzgxt7g0L10vOT93EyM4BrSCdjAuW/9X7xAj
	EwfjIUYJDmYlEd75N7rThHhTEiurUovy44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQW
	wWSZODilGphU9cvuqxUW7Zx3eNLJfw2/jsiciTix8Lm/n9q0CRP2vp7J8O+mxFk/vkYm3UwD
	4cs9WyMvfn5/egJzQEnHmr81k5co94Xse3xH4/05sy0tUUam1xZw6h913fum9O6i/Q5XYoId
	HBemdZoL+tTsnCE8MSfq8XntQnZB30/+brGlqgo7TO7PX1qxb07M/9MuV/sczt9uKdLeEuD0
	a7XTk5Az71Vjzr0v5LWeMzXTfPmSfzwPzl2ceHOGWI/0lAVbpu76dkBUP2qmwJ0Nf7sNW6Oq
	LphOWvG9rs5R9BRrd1N5164J6d/EXs+P+Dkn9vCLozPeLzbvKy7+vn/LHa0zRYL94m4fP5T+
	0Li38cmqwpm7PiixFGckGmoxFxUnAgDUOXVe8AIAAA==
X-CMS-MailID: 20240711051532epcas5p360e92f46b86eca56e73643a71950783a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240711051532epcas5p360e92f46b86eca56e73643a71950783a
References: <20240711050750.17792-1-kundan.kumar@samsung.com>
	<CGME20240711051532epcas5p360e92f46b86eca56e73643a71950783a@epcas5p3.samsung.com>

Added new bio_add_hw_folio() function. This is a prep patch.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 46 ++++++++++++++++++++++++++++++++++------------
 block/blk.h |  4 ++++
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 7018eded8d7b..a7442f4bbfc6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -983,20 +983,20 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 }
 
 /**
- * bio_add_hw_page - attempt to add a page to a bio with hw constraints
+ * bio_add_hw_folio - attempt to add a folio to a bio with hw constraints
  * @q: the target queue
  * @bio: destination bio
- * @page: page to add
+ * @folio: folio to add
  * @len: vec entry length
- * @offset: vec entry offset
+ * @offset: vec entry offset in the folio
  * @max_sectors: maximum number of sectors that can be added
- * @same_page: return if the segment has been merged inside the same page
+ * @same_page: return if the segment has been merged inside the same folio
  *
- * Add a page to a bio while respecting the hardware max_sectors, max_segment
+ * Add a folio to a bio while respecting the hardware max_sectors, max_segment
  * and gap limitations.
  */
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
+int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
+		struct folio *folio, size_t len, size_t offset,
 		unsigned int max_sectors, bool *same_page)
 {
 	unsigned int max_size = max_sectors << SECTOR_SHIFT;
@@ -1011,8 +1011,8 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
-		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
-				same_page)) {
+		if (bvec_try_merge_hw_folio(q, bv, folio, len, offset,
+					    same_page)) {
 			bio->bi_iter.bi_size += len;
 			return len;
 		}
@@ -1029,12 +1029,34 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 			return 0;
 	}
 
-	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, offset);
-	bio->bi_vcnt++;
-	bio->bi_iter.bi_size += len;
+	bio_add_folio_nofail(bio, folio, len, offset);
 	return len;
 }
 
+/**
+ * bio_add_hw_page - attempt to add a page to a bio with hw constraints
+ * @q: the target queue
+ * @bio: destination bio
+ * @page: page to add
+ * @len: vec entry length
+ * @offset: vec entry offset
+ * @max_sectors: maximum number of sectors that can be added
+ * @same_page: return if the segment has been merged inside the same page
+ *
+ * Add a page to a bio while respecting the hardware max_sectors, max_segment
+ * and gap limitations.
+ */
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned int len, unsigned int offset,
+		unsigned int max_sectors, bool *same_page)
+{
+	struct folio *folio = page_folio(page);
+
+	return bio_add_hw_folio(q, bio, folio, len,
+			((size_t)folio_page_idx(folio, page) << PAGE_SHIFT) +
+			offset, max_sectors, same_page);
+}
+
 /**
  * bio_add_pc_page	- attempt to add page to passthrough bio
  * @q: the target queue
diff --git a/block/blk.h b/block/blk.h
index 6a566b78a0a8..777e1486f0de 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -540,6 +540,10 @@ void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
 struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 		struct lock_class_key *lkclass);
 
+int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
+		struct folio *folio, size_t len, size_t offset,
+		unsigned int max_sectors, bool *same_page);
+
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
-- 
2.25.1

