Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BD1A0AE0
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080135; cv=none; b=OxHKHio8M4LXqige+6+czZEWldZrtf1b41HxL6jKT/NfKlD/md2ncnqPmrzTM8typ7+Am0rUZnKX/kOc/Y9i/mRC5aMnt/EBgc3VQKx+/r8CoSmGrKail/rWuAUI1jNjkM8/wtsw5OJxCKsisWf4QptscYkk41idobxC/+u0g6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080135; c=relaxed/simple;
	bh=eCpbEk1K12ePXWai2MBUhBsul4wZ2/1YtiCE/H0Acsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=jY6mQLuaK/kIHxsXLdbyFIAKZ8Q401aUpVnj+1wIa40uUgTxOvFvLMXuqs00CmeA6Whl+fuTbZhnbbKOvrmoZ2KkoByZpv+4M+4+/d2hbaJ5RN9vZHERdt9Dr9F8V5e17tdhll2Qkepi8iqNVI+bCZnZzPxhdyPrdWcuSA5hb+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O1yXmHGf; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O1yXmHGf"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240704080211epoutp0426c636281e862e449e8a04061e3fa020~e88QmHaPE0205702057epoutp04_
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:02:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240704080211epoutp0426c636281e862e449e8a04061e3fa020~e88QmHaPE0205702057epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720080131;
	bh=yegwE09m26FWH64rUFlry2fVF/9zd8SeheQSpERjDmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1yXmHGfWjb9PExQBDgXyfKxFodmlpZVFXVsiBjjnmZxBBUDNNK6bTFpCZKqTNyhn
	 2VBgmNc0iLcmKuIPB7GGmZ5qaFQOnVol1uinzG9PoT1uchBkYq+l5ghHVo2v85fgkX
	 YWUbqDYv1iCVhvJyj1QFVeLEL0l7IDu9nhyORwpg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240704080211epcas5p4349f73f26f5dbbc0c63deb5332ff9cb1~e88QLHxmg2264922649epcas5p4b;
	Thu,  4 Jul 2024 08:02:11 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WF8J11TChz4x9QR; Thu,  4 Jul
	2024 08:02:09 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B6.F4.11095.EF656866; Thu,  4 Jul 2024 17:02:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240704071130epcas5p131b210c30237386f2c786e81c88355f6~e8QAC33JL0634606346epcas5p1C;
	Thu,  4 Jul 2024 07:11:30 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240704071130epsmtrp1255e05321ba5ebdf900fac29ca016a87~e8QAB-bQz0734707347epsmtrp1B;
	Thu,  4 Jul 2024 07:11:30 +0000 (GMT)
X-AuditID: b6c32a49-423b770000012b57-aa-668656fe9086
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.3B.18846.12B46866; Thu,  4 Jul 2024 16:11:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240704071127epsmtip2ec6fa7aa852b6a246383b85727a04e0a~e8P9i2gjr1296012960epsmtip2L;
	Thu,  4 Jul 2024 07:11:27 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v7 3/4] block: introduce folio awareness and add a bigger
 size from folio
Date: Thu,  4 Jul 2024 12:33:56 +0530
Message-Id: <20240704070357.1993-4-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704070357.1993-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmpu6/sLY0gzN7pC2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzje
	Od7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoQiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJ
	rVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaLHbEFLeoVaxb9Zm1gvCLXxcjJISFg
	IrHg80vmLkYuDiGB3YwSlxY8YIVwPjFK7GrpYoZzzkxcxgbTsm/rbjaIxE5GiT+rFkE5nxkl
	bs87D9TCwcEmoCvxoykUpEFEwF1i6stHjCA1zAJnGSVOTH3EApIQFoiWuH//FTOIzSKgKnFi
	3XImEJtXwEbix68jzBDb5CVmXvrODmJzCthKdPyaxghRIyhxcuYTsDnMQDXNW2eDnSoh0Msh
	8WfZanaIZheJc/e3MUHYwhKvjm+BiktJvOxvg7KzJQ41boCqKZHYeaQBKm4v0XqqH+wZZgFN
	ifW79CHCshJTT61jgtjLJ9H7+wlUK6/EjnkwtprEnHdTWSBsGYmFl2ZAxT0kJp46zgQJrAmM
	El0bl7BMYFSYheSfWUj+mYWwegEj8ypGydSC4tz01GLTAsO81HJ4LCfn525iBKdaLc8djHcf
	fNA7xMjEwXiIUYKDWUmEV+p9c5oQb0piZVVqUX58UWlOavEhRlNggE9klhJNzgcm+7ySeEMT
	SwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGpgS1OKZ7l16bVbrJ3uLMeTZ
	jAu8q4UKX7yyP9VXZH1kStJjUynFLNbF0d4uh593RZ5PbxQs9vGXPLnlT5f3GeaJb0Uk52YW
	HeLnOf874cGfo2czHubV8D3s/6GhZzTPQKbRTo8vd7NV0VIGFal13yJDFF993bvV6pv6nTDG
	k4bX9Vzf9VvcbZju5M9YclZOjrcydofCS6VNB9yer7XRPe/94fXFbfzm+auWHJ39/YjU7dKX
	r+o2lnTJybt88ZaWzJMIVJyw7YtKhta9a63t3xwZa99PexyyK9Rf40ze3fVaEwqLzlnrbs/P
	tm4xzLHnP2pfdPCWbyHPgys/dWbM0mvpu3mAZcI10UvvdJ4lXFdiKc5INNRiLipOBACxvI3e
	PgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvK6id1uawZ0f1hZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CV8WJHbEGLesWa
	Rb9ZGxivyHUxcnJICJhI7Nu6m62LkYtDSGA7o8SquxPYIBIyErvv7mSFsIUlVv57zg5R9JFR
	Ylb7DyCHg4NNQFfiR1MoSI2IgK/Egg3PGUFqmAWuM0rcmL6VGSQhLBApsXpaA5jNIqAqcWLd
	ciYQm1fARuLHryPMEAvkJWZe+s4OYnMK2Ep0/JrGCGILAdXcu3meBaJeUOLkzCdgNjNQffPW
	2cwTGAVmIUnNQpJawMi0ilE0taA4Nz03ucBQrzgxt7g0L10vOT93EyM4BrSCdjAuW/9X7xAj
	EwfjIUYJDmYlEV6p981pQrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KL
	YLJMHJxSDUwyi14ut382p/xme3ik/lTbnQx3F2WFnSgUjr5jMePcWgPBXwUOQtPnLL/47anN
	Zxau84x/FHy013MLlv7vtlh4aWukXMX00rM3L+wrirdZxD85/PeyzSf3NLgytWzV2vrp05dX
	KgIblhqXRXHUV846vuGnZm5r99HOJ9efTDl8lev7bauUNb6FQlu9p2tx28Q53J80s/p088zN
	LrNLltqfqW79Os186+OcFBOOK1HXXMTmPAzOcdINUk8NzbxUZ3T9sYXc0nXCITuWscVGVVd7
	HHhaGzv3kGXMvXcXvx0TZ1Pmca94cSDyieCG6ph1fxaks3n7ST02MrLZeVxtzl1u2/6S+uJN
	nVuCBf6uzbVUYinOSDTUYi4qTgQAxfOMHfACAAA=
X-CMS-MailID: 20240704071130epcas5p131b210c30237386f2c786e81c88355f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240704071130epcas5p131b210c30237386f2c786e81c88355f6
References: <20240704070357.1993-1-kundan.kumar@samsung.com>
	<CGME20240704071130epcas5p131b210c30237386f2c786e81c88355f6@epcas5p1.samsung.com>

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
---
 block/bio.c | 77 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 16 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 05d624f016f0..32c9c6d80384 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1243,8 +1243,8 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static int bio_iov_add_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int offset)
+static int bio_iov_add_folio(struct bio *bio, struct folio *folio, size_t len,
+			     size_t offset)
 {
 	bool same_page = false;
 
@@ -1253,30 +1253,61 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 
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
@@ -1296,9 +1327,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
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
@@ -1340,15 +1371,29 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
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

