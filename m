Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A61C3D
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675215; cv=none; b=F1MCbmA/HQb8LWYGQMRAGoVoR5StWWZKdWQBI1sELtcWRc6lY6TwT/R83/lcDvtk8TEorV3x9hfNbVfGIwn3zKqvm55oXMYfnAFpYjziNdJ2/ZNucg8+0XNZwwGr3+UvJMlLutmNrr+TNcFSQJgr664ZFp4Pd1M8VZ2qwWAPZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675215; c=relaxed/simple;
	bh=sljjdn0XYpgAEo5+oljdSRtflgnvsKmYeG/iraAYyJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YO1s9MUWuqy41xKRWKQzWLa9qVHo82b3tvhAZ0aDz7dONZeLKha+tl1jxGPc3Qn0D/U5hDzBINv9AU10nAElhI2eUTDM5xbu8Xl/mYmqKm122webKNZMX3ffMHSTvSWgFHvEHpLuD8tt4C7oyUpDVcEkCsAgdWJA/jmpaPj7zDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GGMItoK7; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GGMItoK7"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240711052011epoutp03d51be55a444826823dadb4f4de1625b3~hEPzy4Llj1589315893epoutp03s
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 05:20:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240711052011epoutp03d51be55a444826823dadb4f4de1625b3~hEPzy4Llj1589315893epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720675211;
	bh=+Yo/gGquQ+4cJGGCI1Dv5+q2paTXnhvf0gqLMlGXuLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGMItoK7syHSZbn9Ge1tpfn3PbAL/vYa+TZKD3sJt1160ctP/ry3nMowSyatkPHPN
	 Kpgr35ZTodGLKfwAPRUC7gpMJUVFxthE4WDY8SNYMHhhi/9f03v3BEdGjtNxW6XxX8
	 DifD1NmvkO/R+sMmu6pTn5sEtHXE2xvtyJBoy460=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240711052007epcas5p46a9aaceb7aae44e8f72b9c3077d0d391~hEPwOko7O1595615956epcas5p4n;
	Thu, 11 Jul 2024 05:20:07 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WKNMn3tDRz4x9QF; Thu, 11 Jul
	2024 05:20:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8D.1E.06857.58B6F866; Thu, 11 Jul 2024 14:20:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240711051536epcas5p369e005a83fb16d9f6d9636585cc66e3b~hELz-LIeK2616926169epcas5p3J;
	Thu, 11 Jul 2024 05:15:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240711051536epsmtrp10d5afb758cf916af158a2c625218b40f~hELz_WaUE1252312523epsmtrp1E;
	Thu, 11 Jul 2024 05:15:36 +0000 (GMT)
X-AuditID: b6c32a4b-88bff70000021ac9-4b-668f6b85dd50
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.0E.29940.87A6F866; Thu, 11 Jul 2024 14:15:36 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240711051534epsmtip1233eab6fd33b934e3846fefe72c89ed6~hELyLrkyg0104201042epsmtip1Z;
	Thu, 11 Jul 2024 05:15:34 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v8 3/5] block: introduce folio awareness and add a bigger
 size from folio
Date: Thu, 11 Jul 2024 10:37:48 +0530
Message-Id: <20240711050750.17792-4-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711050750.17792-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmhm5rdn+awamHkhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2Pq8x1MBRvVK2Yce8rewPhHrouRk0NC
	wETi+YQG1i5GLg4hgd2MEn+m/oByPjFKrF43gRHC+cYo0d33lL2LkQOs5dkDFZBuIYG9jBLP
	H2ZB1HxmlJh+ewkzSA2bgK7Ej6ZQkBoRAXeJqS8fgc1hFjjLKHFi6iMWkISwQLTEv89TGUFs
	FgFViWMHl7GB9PIK2Eoc3VwNcZ28xMxL39lBbE4BO4mNf96BtfIKCEqcnPkEzGYGqmneOpsZ
	ZL6EwFQOiSlv3zNCNLtI9M6eBGULS7w6voUdwpaSeNnfBmVnSxxq3MAEYZdI7DzSABW3l2g9
	1Q/2C7OApsT6XfoQYVmJqafWMUHs5ZPo/f0EqpVXYsc8GFtNYs67qSwQtozEwkszoOIeEo+/
	TGKHhNVERolnz68zTWBUmIXkn1lI/pmFsHoBI/MqRsnUguLc9NRi0wLjvNRyeBwn5+duYgSn
	WS3vHYyPHnzQO8TIxMF4iFGCg1lJhHf+je40Id6UxMqq1KL8+KLSnNTiQ4ymwPCeyCwlmpwP
	TPR5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwORr1R6kl7Znf
	EnElfXbeom0c4pf9/xX6Tl4W2XJb93YqZ+WrkCmJ/EzFDffWR/KlSwUdaO46u/Qhh8nmLfqh
	VVXrfhdGVr9/vvBBg7D/hVUBBzxTeg8/3SJ9xYmj5yu/o9jRLN+505ebZKVYNs2SfOW1MyrX
	KCBy33QXxazkNz2TX/GuzJKpXXJsI5tJNk/7tMxNm+Ljfp5/sNxxxgMV07P5Hw5GbVh9etm6
	soCr1mrc/UwzVzo2KGa9zBd8P9FQ5NrFnIP714oulypdJNa31drx8rvTnzf+ODu51IPzMUcV
	G+d3x+dfNm3cd3FZx/LwYJWKklkXP61yjvfu2qt4o7JbIlniGMf7p9uPK2z/oMRSnJFoqMVc
	VJwIANQbu0A8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnG5FVn+awZonEhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVMfX5DqaCjeoV
	M449ZW9g/CPXxcjBISFgIvHsgUoXIxeHkMBuRoklbVeYuxg5geIyErvv7mSFsIUlVv57zg5R
	9JFRYt+uh8wgzWwCuhI/mkJBakQEfCUWbHjOCFLDLHCdUeLG9K1gg4QFIiVap7WDDWIRUJU4
	dnAZG0gvr4CtxNHN1RDz5SVmXvrODmJzCthJbPzzjgXEFgIq+b/tClicV0BQ4uTMJ2BxZqD6
	5q2zmScwCsxCkpqFJLWAkWkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwJGhp7mDc
	vuqD3iFGJg7GQ4wSHMxKIrzzb3SnCfGmJFZWpRblxxeV5qQWH2KU5mBREucVf9GbIiSQnliS
	mp2aWpBaBJNl4uCUamCaXrJWVFGaryFkcSVH7LPTnre2Kv/sz3z4ZeI+7faZQmY8dzYtVvpn
	OyWd8fSZDc5mM30SH356PNX+lavd37JDdyaqrruqJ54wfdf5F3OTF/E9iDGYZ7ri6cSjB5uS
	WdcWJH6LK8+q52tiWZWg0uApqru2L25P3mXB56qPl3zbuoD9mPt/3fXHeat+h5k+uvX207JJ
	V5anzVWPP3zm+pPt/1hPNBxq92g5UZbw01gvT3F7Z+DOHiOdNL7GvvXrYtacCu6/vedPZsze
	B2XJV6t7tiZJ51ROVth+SZRFTD/GpE7pr6nqN8M0dwU9Za9p83ZrL7jW+nr3uX9WelsW+wqc
	Onni6LobR89b38xP4uU6rMRSnJFoqMVcVJwIAKUe7bXzAgAA
X-CMS-MailID: 20240711051536epcas5p369e005a83fb16d9f6d9636585cc66e3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240711051536epcas5p369e005a83fb16d9f6d9636585cc66e3b
References: <20240711050750.17792-1-kundan.kumar@samsung.com>
	<CGME20240711051536epcas5p369e005a83fb16d9f6d9636585cc66e3b@epcas5p3.samsung.com>

Add a bigger size from folio to bio and skip merge processing for pages.

Fetch the offset of page within a folio. Depending on the size of folio
and folio_offset, fetch a larger length. This length may consist of
multiple contiguous pages if folio is multiorder.

Using the length calculate number of pages which will be added to bio and
increment the loop counter to skip those pages.

Using a helper function check if pages are contiguous and belong to same
folio, this is done as a COW may happen and change contiguous mapping of
pages of folio.

This technique helps to avoid overhead of merging pages which belong to
same large order folio.

Also folio-lize the functions bio_iov_add_page() and
bio_iov_add_zone_append_page()

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 77 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 16 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a7442f4bbfc6..b4df3af3e303 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1245,8 +1245,8 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static int bio_iov_add_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int offset)
+static int bio_iov_add_folio(struct bio *bio, struct folio *folio, size_t len,
+			     size_t offset)
 {
 	bool same_page = false;
 
@@ -1255,30 +1255,61 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 
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
@@ -1298,9 +1329,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
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
@@ -1342,15 +1373,29 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	for (left = size, i = 0; left > 0; left -= len, i++) {
 		struct page *page = pages[i];
+		struct folio *folio = page_folio(page);
+
+		folio_offset = ((size_t)folio_page_idx(folio, page) <<
+				PAGE_SHIFT) + offset;
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
+
+		/* Skip the pages which got added */
+		i = i + (num_pages - 1);
 
 		offset = 0;
 	}
-- 
2.25.1

