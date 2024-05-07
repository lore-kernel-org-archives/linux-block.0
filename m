Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8801755A
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715146678; cv=none; b=u5J0hIivznhNO86rK4i2vqiQBBQhOX0uFkxCv+Ok7NVlUxRYjb4LfNy+n8T5DhdWhdkUIuUvKRBhhWNTljeSd2/ca/t1mACklaqd2tE9ZVO2aOOZa0nYq5uh4uSOORl2ju3lQ5w7+9AoyIhoS7XmrLafGP+ffhVlhSMYrdRQdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715146678; c=relaxed/simple;
	bh=cEGNWM79vtwr8ee3ZPhTdancPLn9TjjyE06Lq63u41g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=MNNWo0LlrTAyG7w479FxUCJfn5NwVoFl4crvKwqmMUcXilX5Js56tT4kPwrtD0ptoyfO0wC3+FL6xHSSsAKAR69Vosnb6XdTHt+TYJnZbA/4v3FQqBRqLdNv/kpQ24g7AvBCqx74HFQqiGFmoYElcnJur7ygc+xpbHkgzYSMWyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PN9JpyP3; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PN9JpyP3"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240508053744epoutp04bdafea7153459755b3cf86df05411d03~NbM3nrRD11144411444epoutp04D
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 05:37:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240508053744epoutp04bdafea7153459755b3cf86df05411d03~NbM3nrRD11144411444epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715146664;
	bh=caFPHF3Jzy+JjJ69FjaEX3QBtwejfSBYgbmabI2wjrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PN9JpyP3avFAvMPJDQbQcevG9kp4K9RGUwiVwM8gE2i4syrLEzl4ftYhWSKASasLQ
	 O+esJEmx7KVox1XA/5FRsrzEhAL2QuUGdPZ2c3E6enq7WYpOkBlq4eMsM7LPm1PQhL
	 NoHKohBNSgdHbSIgA1DC167w1InYAhuzeR5Rg6DU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240508053744epcas5p48469025a32f246ed8a20bf6863b3f8aa~NbM3G2ENz0753007530epcas5p4b;
	Wed,  8 May 2024 05:37:44 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VZ3nf2yZJz4x9QK; Wed,  8 May
	2024 05:37:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.69.19431.6AF0B366; Wed,  8 May 2024 14:37:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240507145323epcas5p3834a1c67986bf104dbf25a5bd844a063~NPIuM8JcK3113331133epcas5p3H;
	Tue,  7 May 2024 14:53:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240507145323epsmtrp25935de4da344f0847fb4929568482ad8~NPIuLWmHu0954309543epsmtrp2r;
	Tue,  7 May 2024 14:53:23 +0000 (GMT)
X-AuditID: b6c32a50-ccbff70000004be7-f4-663b0fa6d6b8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.B7.08924.2604A366; Tue,  7 May 2024 23:53:23 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240507145321epsmtip17da84e3df1f72184dd191a304d695004~NPIskl7Ci2861028610epsmtip1-;
	Tue,  7 May 2024 14:53:21 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v3 2/3] block: add folio awareness instead of looping
 through pages
Date: Tue,  7 May 2024 20:15:08 +0530
Message-Id: <20240507144509.37477-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507144509.37477-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmpu4yfus0g/09whZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i61fvrJa7L2lbXFjwlNGi22/5zNb/P4xh82B22PzCi2P
	y2dLPTat6mTz2H2zgc2jb8sqRo/Pm+QC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
	dQ0tLcyVFPISc1NtlVx8AnTdMnOAjlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
	FJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGds/drBWvBJpqL390+mBsYm8S5GTg4JAROJNVPm
	s3UxcnEICexhlJj59DMrhPOJUeLlr48sEM43RolLPVfZYFruTJvBCJHYyyjx7c4uJpCEkMBn
	Rom3Nyq6GDk42AR0JX40hYKERYDqX668DVbPLHCWUeLE1EcsIAlhgVCJSZc2g/WyCKhKLJ4z
	CWwBr4CtxJVVs1gglslLzLz0nR3E5hSwk+hb84ARokZQ4uTMJ2A1zEA1zVtnM4MskBDo5JCY
	PXE9K0Szi0TXz5vMELawxKvjW9ghbCmJz+/2Qn2TLXGocQMThF0isfNIA1SNvUTrqX5mkGeY
	BTQl1u/ShwjLSkw9tY4JYi+fRO/vJ1CtvBI75sHYahJz3k2Ful9GYuGlGVBxD4lVH+6yQwJu
	IqNE1+rHzBMYFWYh+WcWkn9mIaxewMi8ilEqtaA4Nz012bTAUDcvtRwezcn5uZsYwSlWK2AH
	4+oNf/UOMTJxMB5ilOBgVhLhPdpunibEm5JYWZValB9fVJqTWnyI0RQY4hOZpUST84FJPq8k
	3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6pBiaup1JiFqcXuTwIj+Ex
	+jk5pTzo7Ey3Nwvdn/bNznwnwlVzsWrt8kczk/9/ONVyuGf+wrs1Ls9Wrn/ivm569rY318LD
	S5XC+uZPfeor80Yp7EdJn/pns7dvo8Kmb62P5GPa+jiy5tXPRWZXAu6VMwS/mRk573S33YJO
	rikhnHOn3GU6+CxTbvLP8xPYOUz91pmeMHy340DLv5UiXx8KHjKRv3K4/WzZVKm9Fz+oBh84
	7/vfKe1r4MIpxtH/Ag6YJF7YPPVRacb1zv4sxYPH06/915twfE/xth6WuBPVF0oWWN6vlRX7
	p659mEv87rPH19U+PmjVC+GQPd3E9lLmfZ8ac/3Kn7ZePq8n9fXNu8XFrsRSnJFoqMVcVJwI
	AJFOHaU6BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnG6yg1WawfJFzBZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i61fvrJa7L2lbXFjwlNGi22/5zNb/P4xh82B22PzCi2P
	y2dLPTat6mTz2H2zgc2jb8sqRo/Pm+QC2KK4bFJSczLLUov07RK4MrZ+7WAt+CRT0fv7J1MD
	Y5N4FyMnh4SAicSdaTMYuxi5OIQEdjNK3Jn3jA0iISOx++5OVghbWGLlv+fsEEUfGSWuL5/L
	1MXIwcEmoCvxoykUpEZEwELiefNyJpAaZoHrjBI3pm9lBkkICwRL7Dp+hB3EZhFQlVg8ZxLY
	Al4BW4krq2axQCyQl5h56TtYDaeAnUTfmgeMILYQUM3tr2uh6gUlTs58AlbPDFTfvHU28wRG
	gVlIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOAS3NHYzbV33QO8TI
	xMF4iFGCg1lJhPdou3maEG9KYmVValF+fFFpTmrxIUZpDhYlcV7xF70pQgLpiSWp2ampBalF
	MFkmDk6pBqbtyeYeGXmvVRL0O/JvxTJ0W/1RaG1ys1125U6vnJxJ/f0e/V611bPrdBW2zdIK
	NN0kEutS7LBviZpQ0dz2ZyGVnJJdM+4ceNzb1m7v8NAkfubl5cnSCUVuJsskeNeYLXfs1HpU
	5cT8wtVk7tl/bHFHVP2rPhev2L7mvPeaGSsdDkszOlVlKR2Y5vH36QWjF4YlLza7vvkhuLCQ
	3+rY1RAX5avvnFqfHXSIDDVO9vY1TxCfa8GssfbhyfiwSWt6uqesfaa2+8iiYpOTDTPDI46c
	jLHbrpPK5VX7SejMf/YlR+7amX3kKn6dpmArn1PpKTH5/8ddV5Ur1toZHd1dF7LDIEUzUlDq
	hWL5fr9FSizFGYmGWsxFxYkAE5tVFPACAAA=
X-CMS-MailID: 20240507145323epcas5p3834a1c67986bf104dbf25a5bd844a063
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240507145323epcas5p3834a1c67986bf104dbf25a5bd844a063
References: <20240507144509.37477-1-kundan.kumar@samsung.com>
	<CGME20240507145323epcas5p3834a1c67986bf104dbf25a5bd844a063@epcas5p3.samsung.com>

Add a bigger size from folio to bio and skip processing for pages.

Fetch the offset of page within a folio. Depending on the size of folio
and folio_offset, fetch a larger length. This length may consist of
multiple contiguous pages if folio is multiorder.

Using the length calculate number of pages which will be added to bio and
increment the loop counter to skip those pages.

This technique helps to avoid overhead of merging pages which belong to
same large order folio.

Also folio-lize the functions bio_iov_add_page() and
bio_iov_add_zone_append_page()

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 38baedb39c6f..e2c31f1b0aa8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1192,7 +1192,7 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static int bio_iov_add_page(struct bio *bio, struct page *page,
+static int bio_iov_add_folio(struct bio *bio, struct folio *folio,
 		unsigned int len, unsigned int offset)
 {
 	bool same_page = false;
@@ -1202,27 +1202,27 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 
 	if (bio->bi_vcnt > 0 &&
 	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				page, len, offset, &same_page)) {
+				&folio->page, len, offset, &same_page)) {
 		bio->bi_iter.bi_size += len;
 		if (same_page)
-			bio_release_page(bio, page);
+			bio_release_page(bio, &folio->page);
 		return 0;
 	}
-	__bio_add_page(bio, page, len, offset);
+	bio_add_folio_nofail(bio, folio, len, offset);
 	return 0;
 }
 
-static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
+static int bio_iov_add_zone_append_folio(struct bio *bio, struct folio *folio,
 		unsigned int len, unsigned int offset)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	bool same_page = false;
 
-	if (bio_add_hw_page(q, bio, page, len, offset,
+	if (bio_add_hw_page(q, bio, &folio->page, len, offset,
 			queue_max_zone_append_sectors(q), &same_page) != len)
 		return -EINVAL;
 	if (same_page)
-		bio_release_page(bio, page);
+		bio_release_page(bio, &folio->page);
 	return 0;
 }
 
@@ -1247,8 +1247,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct page **pages = (struct page **)bv;
 	ssize_t size, left;
 	unsigned len, i = 0;
-	size_t offset;
-	int ret = 0;
+	size_t offset, folio_offset;
+	int ret = 0, num_pages;
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
@@ -1289,15 +1289,26 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	for (left = size, i = 0; left > 0; left -= len, i++) {
 		struct page *page = pages[i];
+		struct folio *folio = page_folio(page);
+
+		/* Calculate the offset of page in folio */
+		folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
+				offset;
+
+		len = min_t(size_t, (folio_size(folio) - folio_offset), left);
+
+		num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
 
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
+
+		/* Skip the pages which got added */
+		i = i + (num_pages - 1);
 
 		offset = 0;
 	}
-- 
2.25.1

