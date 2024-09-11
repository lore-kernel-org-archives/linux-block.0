Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D814D456
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043894; cv=none; b=oOF5siqU8MgqiMVj3sJ6jCAnjsucu0yLpDg3bWm9nCXAv68f1THdG0FDzKTOtAcJCqcAPSXsWDYI4Z3Qs0NSclAbfsFIrKgPBr7H97YwjvnnRH7vPVGLz1Df7xdGCf8xBPBpyOr2AXWvMQ5ePbqzjjC//jTINAPjWSsXwvrY65s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043894; c=relaxed/simple;
	bh=gphdJCyT8dsY/SC4thVOf8u06Ixv+9Mx+oiojCb0n78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=b39J+UzpC+VbkQXiK8HUQ4wgU89x+aNsv1X+j20MzlBpRer50YXIA57ssjT6W1kxYM/XsxmkUqEuFUhcwphvqS9jZyQFWczhqpq19iTLAxrgN+6j2hSYWDq0bPf8jXwAMpybqUjbbSt7JZlPysxkr4+Hty+w88wuqym7uS+lOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ddYC+B+Y; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ddYC+B+Y"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240911083810epoutp03485ad8715ec41c86d32472dc4c9380aa~0I8Xye7zY2166021660epoutp03K
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 08:38:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240911083810epoutp03485ad8715ec41c86d32472dc4c9380aa~0I8Xye7zY2166021660epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726043890;
	bh=aVurS7KTKWbGqtF8qmomzgJgC4xAT+DW6fn+FxsUYws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddYC+B+YHaLLC7GsZBZjI1NRnNkKWcARjIhQNx3ypDmUJsrtjkyp4kcmH7aniAHwI
	 XW6jpln+YaRFUM7KS/wHl74yUkQfnOqFgYwKVjXEBtYz3YFzjWWbvbyuCfq53WYizA
	 6ej4DD/U27rHE1O+FOv5TYwAYEl9PGuvU1992yaM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240911083809epcas5p445ac95de7d33e55f5649fd7ef28b6d71~0I8XH5hdK1972819728epcas5p4x;
	Wed, 11 Sep 2024 08:38:09 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4X3Yqh3dtJz4x9Q3; Wed, 11 Sep
	2024 08:38:08 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.E4.09642.0F651E66; Wed, 11 Sep 2024 17:38:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240911065717epcas5p2c488df64821b4c40f73460d501d0326d~0HkSfE4ir0582105821epcas5p2w;
	Wed, 11 Sep 2024 06:57:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240911065717epsmtrp15b72d67e4164ce556bb4548f1ae6ae08~0HkSeOjH81549315493epsmtrp1N;
	Wed, 11 Sep 2024 06:57:17 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-a0-66e156f0f043
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.2A.08964.D4F31E66; Wed, 11 Sep 2024 15:57:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911065714epsmtip13d995a4f319f8ebc294985d16f46a1ac~0HkQU8Dxs0524005240epsmtip1j;
	Wed, 11 Sep 2024 06:57:14 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [PATCH v10 2/4] block: introduce folio awareness and add a bigger
 size from folio
Date: Wed, 11 Sep 2024 12:19:33 +0530
Message-Id: <20240911064935.5630-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911064935.5630-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmlu6HsIdpBpuXC1k0TfjLbLH6bj+b
	xfftfSwWNw/sZLJYufook8XR/2/ZLCYdusZosfXLV1aLvbe0LW5MeMpose33fGaL87PmsFv8
	/jGHzYHXY/MKLY/LZ0s9Nq3qZPPYfbOBzaNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPS
	bZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOVFIoS8wpBQoFJBYXK+nb2RTll5ak
	KmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZxx408lS0KdVcfbLMbYGxlmK
	XYycHBICJhLHz29h6mLk4hAS2M0osXb6d3YI5xOjRPukp1DON0aJ3YdfscG0rPqzlQXEFhLY
	yyjxa0M2RNFnRol1j64DJTg42AR0JX40hYLUiAi4S0x9+YgRpIZZ4CmjxJUvP1lBEsICMRLv
	vr5jB7FZBFQlph3cwATSyytgI3F9einELnmJmZe+g5VwCthKHP7xmAnE5hUQlDg58wnYDcxA
	Nc1bZzODzJcQmMsh0bh3PdShLhKX/sxigbCFJV4d38IOYUtJvOxvg7KzJQ41bmCCsEskdh5p
	gIrbS7Se6mcGuYdZQFNi/S59iLCsxNRT65gg9vJJ9P5+AtXKK7FjHoytJjHn3VSotTISCy/N
	gIp7SDRsesQOCbcJjBJrZrpNYFSYheSdWUjemYWweQEj8ypGydSC4tz01GLTAuO81HJ4HCfn
	525iBCdcLe8djI8efNA7xMjEwXiIUYKDWUmEt9/uXpoQb0piZVVqUX58UWlOavEhRlNgcE9k
	lhJNzgem/LySeEMTSwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGpgCV+3a
	zZV7X/6iXtdPyzddYQ/Ct97sEHmyJMl2wfk3AaU170O7LH1k3j7dOvfOwvkT3ZyiLhbPqb1w
	4Z42rwLTncvJPzbz/fkZ8JjJODJZ4pLOaa2Oox8czuc26PjLzNm0PVPhp3NX34ucpzsN/vex
	TDSJm7RXrTR6/WoxzUo13/WuvD9+1c7L9W/3/GFVPvWb7B9HS301VUdpodep4lsa72s/2nB2
	nvK8nw8/vYvvUkisOtj3yPTnTq+diaFc1tJ+DO8bIo7b7iuM9RB++VGyQPXJ3oZ6s8KSshSB
	bTe1ZzuyT8hb0XJvH/N1O8FlTOy8r37y2F1v0o7+cfn+AWlj5+6tkkopyWFrqqdHflJiKc5I
	NNRiLipOBAAsULSsQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnK6v/cM0g5/zuSyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZB950
	shT0aVWc/XKMrYFxlmIXIyeHhICJxKo/W1m6GLk4hAR2M0pcuNbOApGQkdh9dycrhC0ssfLf
	c3aIoo+MEqsPnGTuYuTgYBPQlfjRFApSIyLgK7Fgw3NGEJtZ4D2jxO0l0iC2sECUxJGeHWwg
	NouAqsS0gxuYQFp5BWwkrk8vhRgvLzHz0nd2EJtTwFbi8I/HTCC2EFDJnw2tYCfwCghKnJz5
	hAVivLxE89bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4
	JrQ0dzBuX/VB7xAjEwfjIUYJDmYlEd5+u3tpQrwpiZVVqUX58UWlOanFhxilOViUxHnFX/Sm
	CAmkJ5akZqemFqQWwWSZODilGpjcWC6oL5te/j/C2LtAPs8s7m3RtZSTVl/5D/s75naxF/I+
	Toz12sL0/O60+hUCHQYpz+6yTP1WPnWue8CvJyc/hj9c/vR384eLThxZBTfaY0JrZFX3W8vF
	X9dQqJxhsz3TXV837XP9aeVJfU3/eOwWZj3liluV//eA9ravATfdku+8rZrX98XtsfSmNKGS
	KpPXj394S8Vtun8koNox8sbqha/lNjo01ptkyj1cuOhkeP2sCU9e57E927GV/ZyD0PYbawJv
	Xj50p/mxQc5V7kiW06831npN6DX437D/8yLj/iyTzYs9S1IkrJ889HjkspJ7l8jvGMk/Mgta
	pe7O8/c3tQq6Gc4QFbbrUtet5ColluKMREMt5qLiRADTehNH+AIAAA==
X-CMS-MailID: 20240911065717epcas5p2c488df64821b4c40f73460d501d0326d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240911065717epcas5p2c488df64821b4c40f73460d501d0326d
References: <20240911064935.5630-1-kundan.kumar@samsung.com>
	<CGME20240911065717epcas5p2c488df64821b4c40f73460d501d0326d@epcas5p2.samsung.com>

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
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/bio.c | 79 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 18 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f9d759315f4d..d8b52bc54549 100644
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
+	unsigned int num_pages, i = 0;
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
+		len = min(folio_size(folio) - folio_offset, left);
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

