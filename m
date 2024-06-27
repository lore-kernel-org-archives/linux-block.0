Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462313F00A
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494082; cv=none; b=U3dKUseA4gL4sj9NRJQSt1pWR+wLj+dsnrthboBKtkJEqibnuwe1AKqap/IOlIMvPSZCET0E8jZOK388K9NJ/fWicE6L0YCtC8w2O3TFce3Xpdq1t+vQpe5RITA5Uhjc75yaM72JIk9SHFFJRlMeN7BlVl925hM+gGgUnxXkFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494082; c=relaxed/simple;
	bh=HDPHiwHv6cgL2Z9u/eNpYhdoxEW6H8O/UwkdK+XEt4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=QOYYC7gMm4m3JTTnQEG5hsfTxddyQpH++tFEueKh1wZFgEM1pU9ZqVNqlyqcQH2RbwO44T1r5zyansjDgcePY0t0wJBmThUJkgHGRz0A4HPuctgJSQTbpNmgLxCLkaViJ8NpvGLZ/NlUkQbErNEt2kIaG5TN3ZEBG5DYFgYeT+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=orbmRHVN; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="orbmRHVN"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240627131432epoutp0374705de52cfbca3d637ba4441a798456~c3r_x3esT1178111781epoutp036
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 13:14:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240627131432epoutp0374705de52cfbca3d637ba4441a798456~c3r_x3esT1178111781epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719494072;
	bh=yx1lS/I183VitV+qxQrDGQglsXzYSCNs/H0Gu2n36x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orbmRHVNJiPsEG2EQqt3Dr4MIoFylyQqwhNXEycJIKcSCggoxXw6GeZqUNuOtScVZ
	 bQUEDEDAOSjx3qe5zxnYBXV1o6gIgxpgrT5xT8llTDs+3OpI4cHqrqae7/9YKRKRX1
	 WEalRAJD2czby0NtQK4CFq012MhZ+y6Mvfi7rvZA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240627131432epcas5p360fb1f917e13a71b63a78af2743ad3c8~c3r_N1e5F2191421914epcas5p3x;
	Thu, 27 Jun 2024 13:14:32 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4W8zYf2PNZz4x9Pt; Thu, 27 Jun
	2024 13:14:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.3A.09989.6B56D766; Thu, 27 Jun 2024 22:14:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240627105410epcas5p175463086ef530a5a7f9ed555b02ed20b~c1xa0yIR12803028030epcas5p1S;
	Thu, 27 Jun 2024 10:54:10 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240627105410epsmtrp1e82942007c5f510636b59e2952b28876~c1xay-r840778707787epsmtrp1g;
	Thu, 27 Jun 2024 10:54:10 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-d9-667d65b65eaa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	12.EF.18846.2D44D766; Thu, 27 Jun 2024 19:54:10 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240627105408epsmtip140ac7dea76f5f67cc573796e930c5e98~c1xY_B7sr0102701027epsmtip12;
	Thu, 27 Jun 2024 10:54:08 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v6 2/3] block: introduce folio awareness and add a bigger
 size from folio
Date: Thu, 27 Jun 2024 16:15:51 +0530
Message-Id: <20240627104552.11177-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627104552.11177-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmpu621No0g+Ut/BZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2PplFPMBY/VKm6t/8bUwLhbrouRk0NC
	wETi8KatjF2MXBxCArsZJf4svsIM4XxilNizbR4jnDPn71wWmJZzh/qgEjsZJQ5MuMgC4Xxm
	lDj2ewZrFyMHB5uArsSPplCQBhEBd4mpLx+BNTALnGWUODH1EdgkYYFoie/n97GB1LMIqEo8
	O2EJEuYVsJV409/ODrFMXmLmpe/sICWcAnYSXZ8qIEoEJU7OfAI2hRmopHnrbLCrJQQ6OSR+
	PdzABtHrIjH55yaoo4UlXh3fAjVTSuJlfxuUnS1xqHEDE4RdIrHzSANU3F6i9VQ/M8heZgFN
	ifW79CHCshJTT61jgtjLJ9H7+wlUK6/EjnkwtprEnHdTodbKSCy8NAMq7iGxZmUzGySoJjJK
	NKz4yTiBUWEWkn9mIflnFsLqBYzMqxglUwuKc9NTi00LjPJSy+GRnJyfu4kRnGi1vHYwPnzw
	Qe8QIxMH4yFGCQ5mJRHe0JKqNCHelMTKqtSi/Pii0pzU4kOMpsDgnsgsJZqcD0z1eSXxhiaW
	BiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB9DFxcEo1ME3br3v4zvUX35ovOvZHHcnK
	/btmlhPX/xTL+rNdgkWrpYVjP9812rDb3l7q+8ljZx6IhuxmXPFruXM0N3ves2knKqITVSq+
	nVBZ99UjLG7x+jc1eu6bzYTtWnwdnqsl7vg03Xajn1NxlbrcZP9P9+d/OMe/v2gr/3o+jeeH
	fxlvm/pW/WC6f1rTTVa2vzenHmRrSrk7OeN3tZz3J4cLlT+fei/bvsRE9ytPfmEO58/qfSGa
	82a8PyMZ+upYMOfdu0JZz7UObnrPd891kWAgt2uCI4eKVl++dMKxjS7l/RUyGTUyNtHCxR9S
	v82fZ7Rwdqzav/es/v9tpzd9yM+bwepWr7LOzJrj9T+eoBl/XyuxFGckGmoxFxUnAgBYtMC0
	PQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnO4ll9o0g9P9bBZNE/4yW6y+C2R9
	397HYnHzwE4mi5WrjzJZHP3/ls1i0qFrjBZbv3xltdh7S9vixoSnjBbbfs9ntvj9Yw6bA4/H
	5hVaHpfPlnpsWtXJ5rH7ZgObR9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGUsnXKKueCxWsWt
	9d+YGhh3y3UxcnJICJhInDvUx9jFyMUhJLCdUaLvx3ZGiISMxO67O1khbGGJlf+es0MUfWSU
	aNp5hamLkYODTUBX4kdTKEiNiICvxIINz8EGMQtcZ5S4MX0rM0hCWCBS4tm2u2D1LAKqEs9O
	WIKEeQVsJd70t7NDzJeXmHnpOztICaeAnUTXpwoQUwioZOOMbIhqQYmTM5+wgNjMQNXNW2cz
	T2AUmIUkNQtJagEj0ypG0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4PDXCtrBuGz9X71DjEwc
	jIcYJTiYlUR4Q0uq0oR4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFk
	mTg4pRqYOhezH9LL/hl+WPTnxqLP3Zb/NySerbf5nazbqh/6XzbvX1tWwPcCj2Ob3+UurXi6
	U7i1d64kw/knVY/XOzJOjVwYd0wIGHzekZH1a6+cTVXLv3rvq+Ls82+t5PtMl2nuOVg8NbL6
	aNDVkh/5GQ+U+aT5X07WXyL09cYWYy1bO2HnJYZ8pdlTizf97BJ6k1TAz7zrQMWUnTrTzwUZ
	bbCt3zVZnzXSsjo17q9Fr+rMzhStPx9X+R3ydNwStdgoltHg4idWoZ1sz28sUL83m/VWD4Pj
	y+A/0ZfiOno47bOc74t+E7zn9jC25oaBhNveHdLPDs6dctXJtS91V7c+V63Ld7F7+wxzZsqt
	8ttdm6TEUpyRaKjFXFScCABU5Jo47gIAAA==
X-CMS-MailID: 20240627105410epcas5p175463086ef530a5a7f9ed555b02ed20b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240627105410epcas5p175463086ef530a5a7f9ed555b02ed20b
References: <20240627104552.11177-1-kundan.kumar@samsung.com>
	<CGME20240627105410epcas5p175463086ef530a5a7f9ed555b02ed20b@epcas5p1.samsung.com>

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
 block/bio.c | 76 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 16 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 6c2db8317ae5..28281135a3f5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1227,8 +1227,8 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static int bio_iov_add_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int offset)
+static int bio_iov_add_folio(struct bio *bio, struct folio *folio, size_t len,
+			     size_t offset)
 {
 	bool same_page = false;
 
@@ -1237,30 +1237,60 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 
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
 
+static unsigned int get_contig_folio_len(int *num_pages, struct page **pages,
+					 int i, struct folio *folio,
+					 size_t left, size_t offset)
+{
+	size_t bytes = left;
+	size_t contig_sz = min_t(size_t,  PAGE_SIZE - offset, bytes);
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
@@ -1280,9 +1310,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
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
@@ -1324,15 +1354,29 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	for (left = size, i = 0; left > 0; left -= len, i++) {
 		struct page *page = pages[i];
+		struct folio *folio = page_folio(page);
+
+		folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
+				offset;
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

