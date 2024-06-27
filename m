Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48F13F00A
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494086; cv=none; b=ZKzUU9yPQXPR4PFG2sIdVHPtB0XuR+aqujKKCsr/V7iub+SF9U+XviyfogALti9DqHWU8ZKUVWdBL9kzGVQ4SvxfEyiJXBnmm0Ksr7aC4CDlnz4k79OEK7iXETlpY9XcXaSPEYv8btpe4sGISGnIqVKnF53fiIjWf84twlSFjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494086; c=relaxed/simple;
	bh=MPgRvf4KkLoxeFxAmS+6WEZ61YbSxUQ/6Lg2fsS4SxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bYVzr2qhRwTFSk83DnMfEzIvLuc4tcEzgiJJ5BeJqXa1ybVcLZst94vwqybKey7ZTCxGPukZmBYfXuZJq/kxkTQlimYWswVTxUMxvdZzfxnuiDOnjVWoXql18GH3QaHF7kPptZ8gkg4hgBHij3fmPsGwga5S7550zyQTw1oznvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Zh7ChcZn; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zh7ChcZn"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240627131437epoutp04657a21fd588ec97cd7db19ae1f06a97b~c3sDEwI473138831388epoutp04j
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 13:14:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240627131437epoutp04657a21fd588ec97cd7db19ae1f06a97b~c3sDEwI473138831388epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719494077;
	bh=SayiFRvfmct27qAqrsmRa8SVNq5pD1UBTXXsqIKLCcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zh7ChcZnPmAZdnbmRBWVMFn+0d1LCnazYifhH8lGS+I7XftEmFPtjUIsJX2splnFz
	 gmvX+jxvp1mk+nCr+lygMAiDpGYUc06qigxMleDUG0mWf7KHq/d/2XUsJbw40ajQzv
	 tVpG5LLZG9XO0JBTFFqtiLs+D6MB/6PbzCnDBzTc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240627131436epcas5p34d7333276b2d80098dcd605b65ca2e7e~c3sCjVj8t2191421914epcas5p3A;
	Thu, 27 Jun 2024 13:14:36 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4W8zYl0B0Xz4x9Pv; Thu, 27 Jun
	2024 13:14:35 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	81.A8.11095.AB56D766; Thu, 27 Jun 2024 22:14:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240627105413epcas5p3384fbacd155f252a861e22cd11ee3b31~c1xdmwCE52093720937epcas5p3q;
	Thu, 27 Jun 2024 10:54:13 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240627105413epsmtrp178983fe8ee56d82b3dda03132fe76e60~c1xdmAtc40778707787epsmtrp1j;
	Thu, 27 Jun 2024 10:54:13 +0000 (GMT)
X-AuditID: b6c32a49-3c3ff70000012b57-31-667d65babf9a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.EF.18846.5D44D766; Thu, 27 Jun 2024 19:54:13 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240627105411epsmtip19e651837572b234d583fc6babee31d1c~c1xbvAqua0228702287epsmtip1p;
	Thu, 27 Jun 2024 10:54:11 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v6 3/3] block: unpin user pages belonging to a folio at once
Date: Thu, 27 Jun 2024 16:15:52 +0530
Message-Id: <20240627104552.11177-4-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627104552.11177-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmhu6u1No0g7OfrSyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzje
	Od7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoQiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJ
	rVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaxi7PZCvaJV9xadIa5gbFJuIuRk0NC
	wERi15pprF2MXBxCArsZJWb07meHcD4xSrydf5gVznm3ai+QwwHW0vbKDqRbSGAno8Sqb7EQ
	NZ8ZJVr3PmcEqWET0JX40RQKUiMi4C4x9eUjRpAaZoGzjBInpj5iAUkIC/hIPNxyHsxmEVCV
	mLy2lR2kl1fAVuLe4hCI6+QlZl76DhbmFLCT6PpUARLmFRCUODnzCVgnM1BJ89bZzBDlvRwS
	c7YnQNguEo+3fmSCsIUlXh3fwg5hS0m87G+DsrMlDjVugKopkdh5pAEqbi/ReqqfGWQts4Cm
	xPpd+hBhWYmpp9YxQazlk+j9/QSqlVdixzwYW01izrupLBC2jMTCSzOg4h4Sh5oXsUBCaiKj
	xMJFd5knMCrMQvLOLCTvzEJYvYCReRWjZGpBcW56arFpgWFeajk8hpPzczcxglOslucOxrsP
	PugdYmTiYDzEKMHBrCTCG1pSlSbEm5JYWZValB9fVJqTWnyI0RQY2hOZpUST84FJPq8k3tDE
	0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6pBiZL+d8bz4soPvMtCdjO5HMt
	j/e0yC0jv2P/Ndg+pzBx3LPLLvu12vOAjVDtn/IrPeELkgxnJ7qvPthZJLGC9fEjyyf186/K
	FgaETa+Jms44Sfah8vRXguUtU3X2O53mf8wTm9m8tG2K/dE5xhN3bA1VSd6qo9f69Bpr6ofw
	QzvPJWt/XLnkWq//8qfGr5QZqpOlOtomef2r3f3AUXFX2F1fXs9tz8P0q48niIZtZT6YrLyq
	0/WMF/fGRcHLV3+p/b5d2eH050C3hesqHvbHR5jN9mndzdlWVtgmsLdT/cynCee6pt828U9V
	ypw6o/XVnORr/s9K3xludPeOa6vS2X5knQSnq2Xx/bAjv5kSVZVYijMSDbWYi4oTAYC02t46
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSnO5Vl9o0g4172C2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr49jF2WwF+8Qr
	bi06w9zA2CTcxcjBISFgItH2yq6LkYtDSGA7o8T1K7fZuhg5geIyErvv7mSFsIUlVv57zg5R
	9JFR4ta/66wgzWwCuhI/mkJBakQEfCUWbHjOCFLDLHCdUeLG9K3MIAlhAR+Jh1vOs4DYLAKq
	EpPXtrKD9PIK2ErcWxwCMV9eYual72BhTgE7ia5PFSCmEFDFxhnZIBW8AoISJ2c+ARvCDFTd
	vHU28wRGgVlIUrOQpBYwMq1iFE0tKM5Nz00uMNQrTswtLs1L10vOz93ECA5+raAdjMvW/9U7
	xMjEwXiIUYKDWUmEN7SkKk2INyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQQHpiSWp2ampB
	ahFMlomDU6qBKZLPOOUrq0joO+td2gJhs4p7orOcouq/2GtYyHb6ypuctfz0wWPazQbzmQYX
	90odKJvLVneJ7bZW/zff6BmFU6eyn5Q+sNGm66NxabVJ151myUurhSb4HL7ocPixElPLtpCQ
	7n+NXbcYjiUUMz9KuzBLy++wzdxjGs9MOxgeXl88T+5Q/9UHzOudX+jKuQj+fBm5eV/GwibJ
	1twbv09f/Mbf0r9vg2x1XuX8n40WOo2z/ldttH7n8+9gf12KOVNZds43T4XLzoviPLU5o6x8
	7q8T8tz9Lrkz+fT8M4Izm+o/h0t8+O64ZWfzORf9dWafmbT0Bfj9QgIZl95Ov/Uogi+iUszi
	+ZfgnrlbtG4psRRnJBpqMRcVJwIAw8b35e0CAAA=
X-CMS-MailID: 20240627105413epcas5p3384fbacd155f252a861e22cd11ee3b31
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240627105413epcas5p3384fbacd155f252a861e22cd11ee3b31
References: <20240627104552.11177-1-kundan.kumar@samsung.com>
	<CGME20240627105413epcas5p3384fbacd155f252a861e22cd11ee3b31@epcas5p3.samsung.com>

Add a new function bio_release_folio() and use it to put refs by npages
count.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c        |  7 +------
 block/blk.h        |  7 +++++++
 include/linux/mm.h |  1 +
 mm/gup.c           | 13 +++++++++++++
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 28281135a3f5..c367378de5c2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1189,20 +1189,15 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	struct folio_iter fi;
 
 	bio_for_each_folio_all(fi, bio) {
-		struct page *page;
 		size_t nr_pages;
-
 		if (mark_dirty) {
 			folio_lock(fi.folio);
 			folio_mark_dirty(fi.folio);
 			folio_unlock(fi.folio);
 		}
-		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
 		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
 			   fi.offset / PAGE_SIZE + 1;
-		do {
-			bio_release_page(bio, page++);
-		} while (--nr_pages != 0);
+		bio_release_folio(bio, fi.folio, nr_pages);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
diff --git a/block/blk.h b/block/blk.h
index 8c27fd7cc6de..e5de16d26a0e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -543,6 +543,13 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
 		unpin_user_page(page);
 }
 
+static inline void bio_release_folio(struct bio *bio, struct folio *folio,
+				     unsigned long npages)
+{
+	if (bio_flagged(bio, BIO_PAGE_PINNED))
+		unpin_user_folio(folio, npages);
+}
+
 struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..b902c6c39e2b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1618,6 +1618,7 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 				      bool make_dirty);
 void unpin_user_pages(struct page **pages, unsigned long npages);
+void unpin_user_folio(struct folio *folio, unsigned long npages);
 
 static inline bool is_cow_mapping(vm_flags_t flags)
 {
diff --git a/mm/gup.c b/mm/gup.c
index ca0f5cedce9b..bc96efa43d1b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -488,6 +488,19 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 }
 EXPORT_SYMBOL(unpin_user_pages);
 
+/**
+ * unpin_user_folio() - release pages of a folio
+ * @folio:  pointer to folio to be released
+ * @npages: number of pages of same folio
+ *
+ * Release npages of the folio
+ */
+void unpin_user_folio(struct folio *folio, unsigned long npages)
+{
+	gup_put_folio(folio, npages, FOLL_PIN);
+}
+EXPORT_SYMBOL(unpin_user_folio);
+
 /*
  * Set the MMF_HAS_PINNED if not set yet; after set it'll be there for the mm's
  * lifecycle.  Avoid setting the bit unless necessary, or it might cause write
-- 
2.25.1

