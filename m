Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063D6171AD
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714620604; cv=none; b=OPbvtEJqkBb+cui5nVb6x0aRMNkmiAbB180on6NZglVS4DEZFYiEYefd5X5mvEzh8CUcLevnhtWHJ2KrjOac3Oj6sQ6/invyjB8B9hEfk864FJLDFXjE6unBFKP3LEq4P3epT6oL7iQgEEaZYWF8mdZGj/1q/8pTU9HPXYjT7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714620604; c=relaxed/simple;
	bh=zxBNLjyz7gfXKl3Kp7B99ED8XA12hrCtrA/5QUnm9Dc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=c63XrXV0IGhiaqDIdlkRLdaFmir9aKwc56k62PEfkQqtErTsOXf/pLbZkThrHc51ZP72eOMjBkLMgZ628U9jZccbxdqnF/MF16q+UWCkScbO6BzvrJX5qA3EMjmICYvJdnEg6nVODMODeHQkcgu+wHfvdYL9E1LIGZ+WWWV8Vbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g/jV49Yx; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g/jV49Yx"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240502032952epoutp024878f2b2ff76cf140e28182946c9a393~LjlhJPBx00743207432epoutp02_
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 03:29:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240502032952epoutp024878f2b2ff76cf140e28182946c9a393~LjlhJPBx00743207432epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714620593;
	bh=whbyQdlTWi4wz3OxegbjvCT288lwN8drj7k3oYUdvDM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=g/jV49YxmdlpASsvjkqxcE6PfUDlW9tfF16zSlXw0qBf8SzZEl0CcBIniKM1IF+aZ
	 2KMiB0WJf6Ew+TmxXFS5/sZ1z3IMYppqNAi/t6V9zsKO68EEPtrIB7DNn3rpTXUGaL
	 UcUcLQ8v/uwda5IzkiVK3EQ4czreBBxoun1P06oQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240502032951epcas5p36508ca85288297d09fc9a767d41b17c4~LjlgFbB6I1697816978epcas5p3J;
	Thu,  2 May 2024 03:29:51 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VVKDs6yYdz4x9Pt; Thu,  2 May
	2024 03:29:49 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FC.DF.09665.DA803366; Thu,  2 May 2024 12:29:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff~LIIjfiank1047110471epcas5p1K;
	Tue, 30 Apr 2024 17:57:35 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240430175735epsmtrp2aff0259bd9171ac367ec70a40195c88a~LIIjevQNi3102331023epsmtrp2W;
	Tue, 30 Apr 2024 17:57:35 +0000 (GMT)
X-AuditID: b6c32a4b-5cdff700000025c1-84-663308ad81f6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A8.63.07541.F0131366; Wed,  1 May 2024 02:57:35 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240430175733epsmtip2fe27ee81aef710a5e0213709fc0d86e0~LIIh2-Y6m1918419184epsmtip2i;
	Tue, 30 Apr 2024 17:57:33 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v2] block : add larger order folio size instead of pages
Date: Tue, 30 Apr 2024 23:20:14 +0530
Message-Id: <20240430175014.8276-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmlu5aDuM0g+cTTS2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFlu/fGW12HtL2+LGhKeMFtt+z2e2+P1jDpsDt8fmFVoe
	l8+Wemxa1cnmsftmA5tH35ZVjB6fN8kFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
	6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
	KTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5Y8ucCU8FO3YqeV9dZGhhnqXQxcnJICJhI/Opv
	ZO5i5OIQEtjNKPHn7D1mkISQwCdGiXdrxSES3xgljjVdZYPpuHnnLCtEYi+jRN/bHywQzmdG
	iZW75wM5HBxsAroSP5pCQRpEgBperrzNCFLDLHCWUeLE1EcsIAlhAQ+J551b2UFsFgFViXtT
	3jOC2LwCNhJ3tm5mhdgmLzHz0nd2iLigxMmZT8B6mYHizVtng90tIfCRXWLjnCVQDS4Sd499
	g7KFJV4d38IOYUtJfH63F+qFbIlDjRuYIOwSiZ1HGqBq7CVaT/UzgzzALKApsX6XPkRYVmLq
	qXVMEHv5JHp/P4Fq5ZXYMQ/GVpOY824qC4QtI7Hw0gyouIfElTXXoEEaK/F00lHWCYzys5C8
	MwvJO7MQNi9gZF7FKJlaUJybnlpsWmCcl1oOj9jk/NxNjOA0quW9g/HRgw96hxiZOBgPMUpw
	MCuJ8E5ZqJ8mxJuSWFmVWpQfX1Sak1p8iNEUGMYTmaVEk/OBiTyvJN7QxNLAxMzMzMTS2MxQ
	SZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQamp6v3bZt+ReLOimvf1/SFOtu63nsh0/Zf0s3w
	a8GvLQvFHcM6PB/P879jsHoqb8ABN/b1j2++ZxG8da2aQ5bZbovD9q1/eu5WzX684YVOwuo+
	c37uKrcvKl8iloebmBzs3TD//g5Rjddrtuzs57qfscXBI4cp1MVpobDST+V4y5O7FnaL7vu1
	51JRnOaW4p3BnsvUlLmZiw+aOfNl3p8p8Kh7W+Dmj7MUdnzLdb0SsvaVpUSzRWDjo9rrW43n
	2W1vYc/5p7V8kcv/iewuN/uvq3LGl75JaDP/Wf+qsin6KYu8wrOGGR9uruMN33buJ4O64nI1
	OZPI37mhc4o+m7gytN59eLJfLWD223Nf511hUmIpzkg01GIuKk4EALbSsKQsBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSvC6/oWGaQcsKAYumCX+ZLVbf7Wez
	+L69j8Xi5oGdTBYrVx9lsjj6/y2bxdYvX1kt9t7Strgx4Smjxbbf85ktfv+Yw+bA7bF5hZbH
	5bOlHptWdbJ57L7ZwObRt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGUv+XGAq2Klb0fPqOksD
	4yyVLkZODgkBE4mbd86ydjFycQgJ7GaUmDfnKSNEQkZi992drBC2sMTKf8/ZIYo+Mkp0PX8L
	5HBwsAnoSvxoCgWpERGwkHjevJwJpIZZ4DqjxI3pW5lBEsICHhLPO7eyg9gsAqoS96a8B1vA
	K2AjcWfrZqgF8hIzL31nh4gLSpyc+YQFxGYGijdvnc08gZFvFpLULCSpBYxMqxglUwuKc9Nz
	kw0LDPNSy/WKE3OLS/PS9ZLzczcxgkNaS2MH4735//QOMTJxMB5ilOBgVhLhnbJQP02INyWx
	siq1KD++qDQntfgQozQHi5I4r+GM2SlCAumJJanZqakFqUUwWSYOTqkGJsP8kN/Hgy9wCX0M
	uD/50ztTzevRa5Zu0/i8RkNz2ZPsvTuktmyI+9x/+s+y9y0XVTcvfLz6td4lzbpa22ABk1cB
	dvF/lD/yNy1U5FsipLO0pPnH68ebinyF1+ab/n44pdBPiMV/WqlolcaW5owXO8XTND8XLGyt
	CWo6JipRNrMk8WGSBkfre2/bT/H2f31MBYy7NrkluLJ+a5QO/MAnbudyXv95dI3ww+XeOu2s
	r+Z/WWJ6NqjhXL3Fx2IjsUxnNtlJUl6HjrZdTmqcWPH5GcuqNf137iq9lLUpnxDyzsHtgu/+
	1/fieE/HcEicsJl7W3Zt4toT6Qs5XHmXNX5YPkHqj8xby4dTOw4F9lX7KrEUZyQaajEXFScC
	AL+37aPYAgAA
X-CMS-MailID: 20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff
References: <CGME20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff@epcas5p1.samsung.com>

When mTHP is enabled, IO can contain larger folios instead of pages.
In such cases add a larger size to the bio instead of looping through
pages. This reduces the overhead of iterating through pages for larger
block sizes. perf diff before and after this change:

Perf diff for write I/O with 128K block size:
	1.26%     -1.04%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
	1.74%             [kernel.kallsyms]  [k] bvec_try_merge_page
Perf diff for read I/O with 128K block size:
	4.40%     -3.63%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
	5.60%             [kernel.kallsyms]  [k] bvec_try_merge_page

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
Changes since v1:
https://lore.kernel.org/all/20240419091721.1790-1-kundan.kumar@samsung.com/
- Changed functions bio_iov_add_page() and bio_iov_add_zone_append_page() to
  accept a folio
- Removed branching and now calculate folio_offset and len in same fashion for
  both 0 order and larger folios
- Added change in NVMe driver to use nvme_setup_prp_simple() by ignoring
  multiples of NVME_CTRL_PAGE_SIZE in offset
- Added change to unpin_user_pages which were added as folios. Also stopped
  the unpin of pages one by one from __bio_release_pages()(Suggested by
  Keith)

 block/bio.c             | 48 +++++++++++++++++++++++++----------------
 drivers/nvme/host/pci.c |  3 ++-
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 38baedb39c6f..0ec453ad15b3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1155,7 +1155,6 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 
 	bio_for_each_folio_all(fi, bio) {
 		struct page *page;
-		size_t nr_pages;
 
 		if (mark_dirty) {
 			folio_lock(fi.folio);
@@ -1163,11 +1162,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 			folio_unlock(fi.folio);
 		}
 		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
-		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
-			   fi.offset / PAGE_SIZE + 1;
-		do {
-			bio_release_page(bio, page++);
-		} while (--nr_pages != 0);
+		bio_release_page(bio, page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1192,7 +1187,7 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static int bio_iov_add_page(struct bio *bio, struct page *page,
+static int bio_iov_add_folio(struct bio *bio, struct folio *folio,
 		unsigned int len, unsigned int offset)
 {
 	bool same_page = false;
@@ -1202,27 +1197,26 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 
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
-
-	if (bio_add_hw_page(q, bio, page, len, offset,
+	if (bio_add_hw_page(q, bio, &folio->page, len, offset,
 			queue_max_zone_append_sectors(q), &same_page) != len)
 		return -EINVAL;
 	if (same_page)
-		bio_release_page(bio, page);
+		bio_release_page(bio, &folio->page);
 	return 0;
 }
 
@@ -1247,8 +1241,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct page **pages = (struct page **)bv;
 	ssize_t size, left;
 	unsigned len, i = 0;
-	size_t offset;
+	size_t offset, folio_offset, size_folio;
 	int ret = 0;
+	int num_pages;
+	struct folio *folio;
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
@@ -1289,16 +1285,30 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	for (left = size, i = 0; left > 0; left -= len, i++) {
 		struct page *page = pages[i];
+		folio = page_folio(page);
+
+		/* See the offset in folio and the size */
+		folio_offset = (folio_page_idx(folio, page)
+				<< PAGE_SHIFT) + offset;
+		size_folio = folio_size(folio);
+
+		/* Calculate the length of folio to be added */
+		len = min_t(size_t, (size_folio - folio_offset), left);
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
 
+		/* Skip the pages which got added */
+		if (bio_flagged(bio, BIO_PAGE_PINNED) && num_pages > 1)
+			unpin_user_pages(pages + i, num_pages - 1);
+		i = i + (num_pages - 1);
 		offset = 0;
 	}
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685..7c07b0582cae 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -778,7 +778,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
+			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1))
+				+ bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-- 
2.25.1

