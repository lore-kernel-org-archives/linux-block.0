Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410C1662EF
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007169; cv=none; b=sEtYJf9XuMqfVsM8VNhhr6br9IvLsqEPtyjjvVMBOj1dWyQEnrAH5dvf9jXqnKv/G2k9jxsHqLz6hFTBCFE2zzIvi+UUNJ3idfHn5QxUEpTWms4luU6GJlD/u4F00jI67jCYy1ofrv6Bi6E/V5PYDvRMKg9D6V0LtaPYiGJpCOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007169; c=relaxed/simple;
	bh=IaKXwVGJRjEnRA6slngATyDpmxhDCZeE9AcAifOLCuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=fIBn1KFKq6GYIw1wifPAaoghRlVlrB/diWRx2JJZN4yuBm2RNyeZxSbC2F4GNKhjN5LfOjW57gkwn/EO6zT/PRA9JtBdk7CEFkPIO+K7QargD5zEL0nKO43r5657XDOIk6thf9TDNi05qmVs/8Hu7lHc9MjgKI/031mT2g2SqzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=K1KL6fzS; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K1KL6fzS"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240830083919epoutp0196a66204313978b7056396a3c04e7983~wdN8jj8IJ3142131421epoutp01D
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 08:39:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240830083919epoutp0196a66204313978b7056396a3c04e7983~wdN8jj8IJ3142131421epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725007159;
	bh=s3pkBUV7KVMdvBn9edCjXcLRnM+hwZCrBgmJhdACGOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1KL6fzSvhNo4vr5Xpt6P+xI59pA/NmyESLjHrmVQHHCJu1j7sxCX39ovWFBMmAQS
	 HoNWFc/w8eWaqfjjd1739TB3sOh1jzaf6FK/F/eDJZ3lGWLuRV7U9KKiLuVj9DcxDw
	 U2a3ElQ9laIbDPAPjFzgfHxVfIE4fEyoI1OyHbwg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240830083917epcas5p32c06a3b1b137b8fc920a5b01082b055b~wdN7iZ08A2112921129epcas5p3B;
	Fri, 30 Aug 2024 08:39:17 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WwBQX15Wyz4x9Pw; Fri, 30 Aug
	2024 08:39:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F1.56.09642.33581D66; Fri, 30 Aug 2024 17:39:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240830080052epcas5p459f462c6a2cd2b68c1c28dcfe1ec3ac2~wcsYGx7hL0243902439epcas5p4s;
	Fri, 30 Aug 2024 08:00:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240830080052epsmtrp18b984c566973940a163a80be233f5201~wcsYF9Cyw1314913149epsmtrp1b;
	Fri, 30 Aug 2024 08:00:52 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-de-66d185331093
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.43.08964.43C71D66; Fri, 30 Aug 2024 17:00:52 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240830080049epsmtip2e39e7e4357d8f6e2e40225de7668e849~wcsVm5vI-2259122591epsmtip2L;
	Fri, 30 Aug 2024 08:00:49 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [PATCH v9 2/4] block: introduce folio awareness and add a bigger
 size from folio
Date: Fri, 30 Aug 2024 13:22:55 +0530
Message-Id: <20240830075257.186834-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830075257.186834-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmlq5x68U0g2qLpgl/mS1W3+1ns/i+
	vY/F4uaBnUwWK1cfZbI4+v8tm8WkQ9cYLbZ++cpqsfeWtsWNCU8ZLbb9ns9scX7WHHaL3z/m
	sDnwemxeoeVx+Wypx6ZVnWweu282sHn0bVnF6PF5k1wAW1S2TUZqYkpqkUJqXnJ+SmZeuq2S
	d3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QkUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM
	/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IyuzTuYCu5pVpzqaGRsYHyv0MXI
	ySEhYCLxfusydhBbSGA3o8ScrSldjFxA9idGiSWfp7NBON8YJR78O8sO03HzXRszRMdeRolP
	a+Igij4zSkw4e5+xi5GDg01AV+JHUyhIjYiAu8TUl48YQWqYBZ4ySlz58pMVJCEsEC1xetYl
	JhCbRUBV4vC0d4wgNq+AncSLly3MEMvkJWZe+g62mFPAXmLL/B5WiBpBiZMzn7CA2MxANc1b
	ZzODLJAQmMkhsfjVLjaIZheJKx/OsEDYwhKvjm+B+kBK4mV/G5SdLXGocQMThF0isfNIA1Tc
	XqL1VD8zyDPMApoS63fpQ4RlJaaeWscEsZdPovf3E6hWXokd82BsNYk576ZCrZWRWHhpBhPI
	GAkBD4nLD9khYTWJUaJ/9QKWCYwKs5C8MwvJO7MQNi9gZF7FKJlaUJybnlpsWmCcl1oOj+Pk
	/NxNjOBkq+W9g/HRgw96hxiZOBgPMUpwMCuJ8J44fjZNiDclsbIqtSg/vqg0J7X4EKMpMLwn
	MkuJJucD031eSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1MW299
	S9Y2zn+eYzRlLpPXYZ1ilS+Krl7zyjtV3Y2Y6hOuR3TnPehiXGmYrbzWxd/o0a9n89Yybwnb
	ePK6VPDpg+Xv/gfNdJ48O4jz5fQ195o+/H3C5rLU8Oa/7BLOT34tV7+XdPAIRcXFxp7P49G8
	JTJV2sWH+XB10AZp97/6Ev8uv/1mc7z9/zXOhyerufZJ/2vT6+Kq7dW/5KI+beJUZkGN/E97
	KvnLf0cu7vfvzm95e8Ppn309t96BiRYRKudimGq2NJQ0pjBbGX10ENiZ8e8Zw6cFedZiwVr/
	Ds+dHa6lef/W4nvFG36sDBA9NL+c8b/UBNt3X5Y+KwuYsWoai2vIpF3FExOCTNiYjlQosRRn
	JBpqMRcVJwIAeyYV8z8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvK5JzcU0g4PbmC2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZXZt3
	MBXc06w41dHI2MD4XqGLkZNDQsBE4ua7NuYuRi4OIYHdjBJ/3k1lgkjISOy+u5MVwhaWWPnv
	OTtE0UdGiVMzfrJ0MXJwsAnoSvxoCgWpERHwlViw4TkjiM0s8J5R4vYSaRBbWCBS4t6tXcwg
	NouAqsThae/AangF7CRevGxhhpgvLzHz0nd2EJtTwF5iy/wesL1CQDUtVxcxQdQLSpyc+YQF
	Yr68RPPW2cwTGAVmIUnNQpJawMi0ilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOCq0
	NHcwbl/1Qe8QIxMH4yFGCQ5mJRHeE8fPpgnxpiRWVqUW5ccXleakFh9ilOZgURLnFX/RmyIk
	kJ5YkpqdmlqQWgSTZeLglGpgWvLgkeaOo7e1DE0ibn+We7ZIkMWDY3M4O+Ma72jjmJTwg/dC
	+vddsFE7YCBltHVtt16ei4bpOg2tv306V0rE4p7NqbRilTbe+mKqWICyQI21n1VyoklikHY5
	61XtjWf0t91IejNlndpZVVZj9fhXZzqUPYTc2mKVNq53Xb5YrN7uM7/6v6VPc/a/P3/4f1ci
	85GMWxvefZgnZNTEt7ytuuadJo/xrA/Pn6l8MZ7Sop62ff6xb+4xb05YypZx97Fc+dE7tfiE
	zZI7N5rtC79er5yr8uRTaWjWhHr/nPzOOGPGhlM75l/9Y9a8w/TwvohKP7fNf81uJhbN191h
	WPH8ae9p3qO9O3aeyW3KuXVfiaU4I9FQi7moOBEA2OeX/PkCAAA=
X-CMS-MailID: 20240830080052epcas5p459f462c6a2cd2b68c1c28dcfe1ec3ac2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240830080052epcas5p459f462c6a2cd2b68c1c28dcfe1ec3ac2
References: <20240830075257.186834-1-kundan.kumar@samsung.com>
	<CGME20240830080052epcas5p459f462c6a2cd2b68c1c28dcfe1ec3ac2@epcas5p4.samsung.com>

Add a bigger size from folio to bio and skip merge processing for pages.

Fetch the offset of page within a folio. Depending on the size of folio
and folio_offset, fetch a larger length. This length may consist of
multiple contiguous pages if folio is multiorder.

Using the length calculate number of pages which will be added to bio and
increment the loop counter to skip those pages.

This technique helps to avoid overhead of merging pages which belong to
same large order folio.

Also folio-ize the functions bio_iov_add_page() and
bio_iov_add_zone_append_page()

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Tested-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 79 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 18 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f9d759315f4d..c8fc97b42410 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -931,7 +931,8 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
 	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
 		return false;
 
-	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
+	*same_page = ((vec_end_addr & PAGE_MASK) == ((page_addr + off) &
+		     PAGE_MASK));
 	if (!*same_page) {
 		if (IS_ENABLED(CONFIG_KMSAN))
 			return false;
@@ -1227,8 +1228,8 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static int bio_iov_add_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int offset)
+static int bio_iov_add_folio(struct bio *bio, struct folio *folio, size_t len,
+			     size_t offset)
 {
 	bool same_page = false;
 
@@ -1237,30 +1238,61 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 
 	if (bio->bi_vcnt > 0 &&
 	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				page, len, offset, &same_page)) {
+				folio_page(folio, 0), len, offset,
+				&same_page)) {
 		bio->bi_iter.bi_size += len;
 		if (same_page)
-			bio_release_page(bio, page);
+			bio_release_page(bio, folio_page(folio, 0));
 		return 0;
 	}
-	__bio_add_page(bio, page, len, offset);
+	bio_add_folio_nofail(bio, folio, len, offset);
 	return 0;
 }
 
-static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int offset)
+static int bio_iov_add_zone_append_folio(struct bio *bio, struct folio *folio,
+					 size_t len, size_t offset)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	bool same_page = false;
 
-	if (bio_add_hw_page(q, bio, page, len, offset,
+	if (bio_add_hw_folio(q, bio, folio, len, offset,
 			queue_max_zone_append_sectors(q), &same_page) != len)
 		return -EINVAL;
 	if (same_page)
-		bio_release_page(bio, page);
+		bio_release_page(bio, folio_page(folio, 0));
 	return 0;
 }
 
+static unsigned int get_contig_folio_len(unsigned int *num_pages,
+					 struct page **pages, unsigned int i,
+					 struct folio *folio, size_t left,
+					 size_t offset)
+{
+	size_t bytes = left;
+	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, bytes);
+	unsigned int j;
+
+	/*
+	 * We might COW a single page in the middle of
+	 * a large folio, so we have to check that all
+	 * pages belong to the same folio.
+	 */
+	bytes -= contig_sz;
+	for (j = i + 1; j < i + *num_pages; j++) {
+		size_t next = min_t(size_t, PAGE_SIZE, bytes);
+
+		if (page_folio(pages[j]) != folio ||
+		    pages[j] != pages[j - 1] + 1) {
+			break;
+		}
+		contig_sz += next;
+		bytes -= next;
+	}
+	*num_pages = j - i;
+
+	return contig_sz;
+}
+
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
 
 /**
@@ -1280,9 +1312,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
-	ssize_t size, left;
-	unsigned len, i = 0;
-	size_t offset;
+	ssize_t size;
+	unsigned int i = 0, num_pages;
+	size_t offset, folio_offset, left, len;
 	int ret = 0;
 
 	/*
@@ -1322,17 +1354,28 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		goto out;
 	}
 
-	for (left = size, i = 0; left > 0; left -= len, i++) {
+	for (left = size, i = 0; left > 0; left -= len, i += num_pages) {
 		struct page *page = pages[i];
+		struct folio *folio = page_folio(page);
+
+		folio_offset = ((size_t)folio_page_idx(folio, page) <<
+			       PAGE_SHIFT) + offset;
+
+		len = min_t(size_t, (folio_size(folio) - folio_offset), left);
+
+		num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
+
+		if (num_pages > 1)
+			len = get_contig_folio_len(&num_pages, pages, i,
+						   folio, left, offset);
 
-		len = min_t(size_t, PAGE_SIZE - offset, left);
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			ret = bio_iov_add_zone_append_page(bio, page, len,
-					offset);
+			ret = bio_iov_add_zone_append_folio(bio, folio, len,
+					folio_offset);
 			if (ret)
 				break;
 		} else
-			bio_iov_add_page(bio, page, len, offset);
+			bio_iov_add_folio(bio, folio, len, folio_offset);
 
 		offset = 0;
 	}
-- 
2.25.1

