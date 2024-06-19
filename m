Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F412A8D3
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769634; cv=none; b=XJJHdCvf99y/PjLNc2+iTvRGODb4qFMDd06vLJczi+V64+PQSbf91F7XCIfx1OX0JZy/UfEn7G3D9ACQuB3noXouY0dz7If4xLI7Fkx42HbbbU4i7rHiHB1m3ZPhaBAERm7ixQymHDH1O1zi2qVzbc5e8Ctxw9zthvVeUwyVtUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769634; c=relaxed/simple;
	bh=YTlkJRIOJIbkKTZubAroWx4vpbjYjDL/ePvjM+YhBNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=EzUswQsP8zMAkfXiBonCn59Nza7YVv/3zD6InznfXLq0IxnPAjUFBpWkwDAG2wTlxh2i/NyVHwLb79yCXezWv4Hyx4bfeXfGKAHu7voDelDiy+jJIZRbgvYSDJjwXxem79XUGqoKuEb3dRmVbQREOY2rCrXAYdLru4rebJ70le8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gWZ6DUKz; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gWZ6DUKz"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240619040030epoutp01d574a714544cbfe6ef43d73d7da549b3~aS99PzkSV1170711707epoutp01o
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 04:00:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240619040030epoutp01d574a714544cbfe6ef43d73d7da549b3~aS99PzkSV1170711707epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718769630;
	bh=BTtyefl8JwRad/XXg1ppvQ7OTg1YYjTD32mp9iAFC4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWZ6DUKz2+RoPQiZl3hRRH3Sg23etWQJtnfpi1pIXtt4TiY4xxW6wQBAWIoE8AUCC
	 QoDroRWPMpVFTOq6kyS5Csxfq5ssVfT+9pSSksdrfnxHEl7arGhfduei6atBiBPSwt
	 6ngf7F1QFA6kOHAJ1N24JnpRJzFfCQNIbKgb2cN0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240619040029epcas5p1231097f6f8b00838594a6aeaed8fc8e8~aS980RkgX0336603366epcas5p1G;
	Wed, 19 Jun 2024 04:00:29 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4W3qf36tmLz4x9Pv; Wed, 19 Jun
	2024 04:00:27 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6B.01.06857.AD752766; Wed, 19 Jun 2024 13:00:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240619024146epcas5p15357534fb7410c212743162b351e27e8~aR5NzhP1n2032620326epcas5p1g;
	Wed, 19 Jun 2024 02:41:46 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240619024146epsmtrp2be20ae7dcc31a15fc2fda6829f297bc9~aR5NyjRF20348503485epsmtrp2s;
	Wed, 19 Jun 2024 02:41:46 +0000 (GMT)
X-AuditID: b6c32a4b-88bff70000021ac9-15-667257dad335
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.84.07412.A6542766; Wed, 19 Jun 2024 11:41:46 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240619024144epsmtip23ddc67300aa9f9026fcae26bab63d4db~aR5MDAe4D0512005120epsmtip2W;
	Wed, 19 Jun 2024 02:41:44 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v5 1/3] block: Added folio-lized version of
 bio_add_hw_page()
Date: Wed, 19 Jun 2024 08:04:18 +0530
Message-Id: <20240619023420.34527-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240619023420.34527-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmlu6t8KI0g+unOCyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzje
	Od7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoQiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJ
	rVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsb3PYtYC57JVbybPYWxgXGRWBcjJ4eE
	gInEy7m/mbsYuTiEBHYzSnS9us8E4XxilHjw6DI7hPONUWL5xbvMMC0N9+9DJfYySux9eJwF
	wvnMKNEx5x1bFyMHB5uArsSPplCQBhEBd4mpLx8xgtQwC5xllDgx9RELSEJYwF9iY8NGNhCb
	RUBV4t7jzYwgNq+ArcT9Bf2MENvkJWZe+s4OMpNTwE7i5xVriBJBiZMzn4CNYQYqad46G+wH
	CYGJHBIHd8xmAqmXEHCRWLzGD2KMsMSr41vYIWwpic/v9rJB2NkShxo3MEHYJRI7jzRA1dhL
	tJ7qZwYZwyygKbF+lz5EWFZi6ql1TBBr+SR6fz+BauWV2DEPxlaTmPNuKguELSOx8NIMqLiH
	ROvSH2yQoJrIKLFjxWfWCYwKs5C8MwvJO7MQVi9gZF7FKJlaUJybnlpsWmCcl1oOj+Tk/NxN
	jOBEq+W9g/HRgw96hxiZOBgPMUpwMCuJ8DpNy0sT4k1JrKxKLcqPLyrNSS0+xGgKDO6JzFKi
	yfnAVJ9XEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZqakFqEUwfEwenVAPTsaYtyr5y
	bhXfFnlw2zRf2DTrldDOR87RzPVzlMVu/tNiryqxPr182uNVR3n51yUyzxBtr3CZVH7dzrdJ
	gXuX0/V52amTlEQN1fOk27YcvFLS7b/3950NV7Y4/T4VqrIo+vZN8+vVRUc+Ld+z9VNPjMz2
	zkOvc9/OT5ectGuNR0ZcnsKaO7FznDQi5h7I1Hhh8Xx5g4j6Nv0b6xL5riRPzTo+585v1dYW
	VoZTLuH563ZP+3PzeALj+uS5E8s/MRgcuM/zQLMmUf/c06W7PqhH5dQcS9Fb0vXtOr/DZOVf
	4myGG24fmNL2+fT1uyUTT7DtvbT0ppCDV4XEoqt+82pXNYuKzZhWVrP9+vM1+xh1HJVYijMS
	DbWYi4oTAZpPW389BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSvG6Wa1GaQed/XoumCX+ZLVbf7Wez
	+L69j8Xi5oGdTBYrVx9lsjj6/y2bxaRD1xgttn75ymqx95a2xY0JTxkttv2ez2zx+8ccNgce
	j80rtDwuny312LSqk81j980GNo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DK+L5nEWvBM7mK
	d7OnMDYwLhLrYuTkkBAwkWi4f5+9i5GLQ0hgN6PEnZV/2CASMhK77+5khbCFJVb+ew5V9JFR
	Ys7cmUAOBwebgK7Ej6ZQkBoRAV+JBRueM4LUMAtcZ5S4MX0rM0hCGCjx+sFFdhCbRUBV4t7j
	zYwgNq+ArcT9Bf2MEAvkJWZe+g42k1PATuLnFWuQsBBQSd+KDywQ5YISJ2c+AbOZgcqbt85m
	nsAoMAtJahaS1AJGplWMkqkFxbnpucmGBYZ5qeV6xYm5xaV56XrJ+bmbGMGxoKWxg/He/H96
	hxiZOBgPMUpwMCuJ8DpNy0sT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6Yklqdmpq
	QWoRTJaJg1OqgSlK5aNhzfe1S0qdDffEPS0L/cJ7TGvSvCm7/j9ZEVCls5HDaXdbo5rY9Uy5
	lY1TxbTU9/zr5Ji87eaxtCvzo78ZhqRc+3poVehsrnCvf6ICL7/ObWdiO3L937GkZ8Ydc2pv
	S7loqC50XnzVM0n2H8+zd6dXnH4yX0rfvOPOpTkyq5NPL31502+SwOwbq/xeTpmT2NU+7/9M
	NlUHhtVB3tf47XZvfL6Kba2K+B2WQ3rhVr8MW29Gqrp+zAk602h6+oQJg6KWyFfzI35frCvn
	T/+VkJGgG84T9WBPcQP/3ad8MyRk/7Jz7L/HofP03SF7s7Kpni+6Fu3VkDB7tujQUsuI/hmb
	3Kst5+XuSy5LqZ+qxFKckWioxVxUnAgAWiZgn/QCAAA=
X-CMS-MailID: 20240619024146epcas5p15357534fb7410c212743162b351e27e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240619024146epcas5p15357534fb7410c212743162b351e27e8
References: <20240619023420.34527-1-kundan.kumar@samsung.com>
	<CGME20240619024146epcas5p15357534fb7410c212743162b351e27e8@epcas5p1.samsung.com>

Added new bio_add_hw_folio() function. This is a prep patch.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c | 38 +++++++++++++++++++++++++++++---------
 block/blk.h |  4 ++++
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e9e809a63c59..c8914febb16e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -964,7 +964,7 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 }

 /**
- * bio_add_hw_page - attempt to add a page to a bio with hw constraints
+ * bio_add_hw_page - a wrapper around function bio_add_hw_folio
  * @q: the target queue
  * @bio: destination bio
  * @page: page to add
@@ -972,13 +972,35 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
  * @offset: vec entry offset
  * @max_sectors: maximum number of sectors that can be added
  * @same_page: return if the segment has been merged inside the same page
- *
- * Add a page to a bio while respecting the hardware max_sectors, max_segment
- * and gap limitations.
  */
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
                struct page *page, unsigned int len, unsigned int offset,
                unsigned int max_sectors, bool *same_page)
+{
+       struct folio *folio = page_folio(page);
+       size_t folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
+                              offset;
+
+       return bio_add_hw_folio(q, bio, folio, len, folio_offset, max_sectors,
+                               same_page);
+}
+
+/**
+ * bio_add_hw_folio - attempt to add a folio to a bio with hw constraints
+ * @q: the target queue
+ * @bio: destination bio
+ * @folio: folio to add
+ * @len: vec entry length
+ * @offset: vec entry offset in the folio
+ * @max_sectors: maximum number of sectors that can be added
+ * @same_page: return if the segment has been merged inside the same page
+ *
+ * Add a folio to a bio while respecting the hardware max_sectors, max_segment
+ * and gap limitations.
+ */
+int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
+               struct folio *folio, unsigned int len, unsigned int offset,
+               unsigned int max_sectors, bool *same_page)
 {
        unsigned int max_size = max_sectors << SECTOR_SHIFT;

@@ -992,8 +1014,8 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
        if (bio->bi_vcnt > 0) {
                struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];

-               if (bvec_try_merge_hw_page(q, bv, page, len, offset,
-                               same_page)) {
+               if (bvec_try_merge_hw_page(q, bv, folio_page(folio, 0), len,
+                                          offset, same_page)) {
                        bio->bi_iter.bi_size += len;
                        return len;
                }
@@ -1010,9 +1032,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
                        return 0;
        }

-       bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, offset);
-       bio->bi_vcnt++;
-       bio->bi_iter.bi_size += len;
+       bio_add_folio_nofail(bio, folio, len, offset);
        return len;
 }

diff --git a/block/blk.h b/block/blk.h
index 79e8d5d4fe0c..d0bec44a2ffb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -524,6 +524,10 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
                struct page *page, unsigned int len, unsigned int offset,
                unsigned int max_sectors, bool *same_page);

+int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
+               struct folio *folio, unsigned int len, unsigned int offset,
+               unsigned int max_sectors, bool *same_page);
+
 /*
  * Clean up a page appropriately, where the page may be pinned, may have a
  * ref taken on it or neither.
--
2.25.1

