Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B1A1A0AE0
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080138; cv=none; b=Wm7j2ans68iTxW+W1TsNyUdkKNLlv30E8IU57keQ4Q2n1Ypbh16KHlB3RwCtEePplnBxCoLSSQYMglAo36fwdUZyRHOAXLIFhGmaxk44LPUxxs0plUyMhpug8xcUJSsfM39bkuWtjSEhPohoUYz4P7bx0tW1E0beorH+7t3IJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080138; c=relaxed/simple;
	bh=BaXjJSTCGyNPM4Udc8hEgVtLoly6k43XUS4eKNnx7JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ZL3wBOwos/AknhzP5dSOSiQo8DIS7ClGEotnFuPyCfGEcApPMiX/Upb9UcIaiEdxcus4n6bz9KhExj+aRDBWdJ9hDdV1NhTpFGlfGAYOUAz6rSUBHGec3W2XMIUXC2tyBmCWsgMxRSMXP7/0lJatvXTvVrBsZnPwl+PsydO6Dzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZiFW2QVV; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZiFW2QVV"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240704080215epoutp016e2e1ea51b8fedf9b8b9cd8fe62da3f8~e88T4sYTH3040630406epoutp01N
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:02:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240704080215epoutp016e2e1ea51b8fedf9b8b9cd8fe62da3f8~e88T4sYTH3040630406epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720080135;
	bh=mmXLAMm20kZ9sA7M0jMUFOOHuzSAh1ATl08lEFOf+3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiFW2QVV9aScEl96vGYuliuZghh79RTjXr7T8BTyIUYb1+Kvfj4o5HnDQONAVvdL+
	 ekqaYo40uT2gEe0alZLGydgdiatbjyj4B0c9Me1hKBYpTthJMHRIl5X7rtRmnDv7FZ
	 B0dLk/lVLsmrZY1CfEF7YjRpl7OeZKHD53eD+kt8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240704080214epcas5p19419fe1e86d7caba1b5c9cd8e0973939~e88TVBasJ1028410284epcas5p1l;
	Thu,  4 Jul 2024 08:02:14 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WF8J41pV9z4x9QP; Thu,  4 Jul
	2024 08:02:12 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.F4.11095.20756866; Thu,  4 Jul 2024 17:02:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240704071134epcas5p2ec6160369e9092de98a051e05750bd4f~e8QEQ0qX10606106061epcas5p29;
	Thu,  4 Jul 2024 07:11:34 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240704071134epsmtrp12b48dbf6ec9fef05883975c33dab9a6a~e8QEP-zFQ0702607026epsmtrp1c;
	Thu,  4 Jul 2024 07:11:34 +0000 (GMT)
X-AuditID: b6c32a49-423b770000012b57-b6-668657028597
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.41.07412.62B46866; Thu,  4 Jul 2024 16:11:34 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240704071131epsmtip2e63a283d3e3e3c25173c1ba6606c39e9~e8QBQOscN1296012960epsmtip2N;
	Thu,  4 Jul 2024 07:11:31 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v7 4/4] block: unpin user pages belonging to a folio at once
Date: Thu,  4 Jul 2024 12:33:57 +0530
Message-Id: <20240704070357.1993-5-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704070357.1993-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmhi5TeFuawZJz/BZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2PGfYeCfeIVnR++szcwNgl3MXJwSAiY
	SLR2VnYxcnEICexmlDj4dxcbhPOJUeLSqS2sEM43oMyeg0xdjJxgHfub2qASexklftx8xwLh
	fGaUuLj2MiPIXDYBXYkfTaEgDSIC7hJTXz5iBKlhFjjLKHFi6iMWkBphAR+JR2/BalgEVCXa
	vnxkAbF5BWwkXqw4ygyxTF5i5qXv7CA2p4CtRMevaYwQNYISJ2c+AatnBqpp3jobqr6XQ+LM
	u0iI11wk7r+ogggLS7w6voUdwpaSeNnfBmVnSxxq3AD1V4nEziMNUHF7idZT/cwgY5gFNCXW
	79KHCMtKTD21jgliK59E7+8nUK28EjvmwdhqEnPeTWWBsGUkFl6aARX3kOi9e4cVxBYSmMAo
	0XMuawKjwiwkz8xC8swshM0LGJlXMUqmFhTnpqcWmxYY5qWWwyM4OT93EyM4wWp57mC8++CD
	3iFGJg7GQ4wSHMxKIrxS75vThHhTEiurUovy44tKc1KLDzGaAkN7IrOUaHI+MMXnlcQbmlga
	mJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTTx8TBKdXAlOPsbcl/i5dFrSejXrzgk2+3
	8v2K1WUPn6558ap/PXOEQ2qervQv8U9ds8Jl9MoyGL0Uey4tm6DeFVv5r+bJzbdBmSx1kWmX
	wtgvdP06vnDJRf6KQuaJ/bVlv3e/KONZcuLmJZYN67vWC9ypcQmoXXZ8t+a8Krn5Hw0NImdN
	17ra5vjyNVNS/ieRd//2MC+RWK5dEFXz5Z7ep1MZM8oOzd7+7gbT+/kT/e0WbqnwVb5VvWGV
	Nlflqq1h/Z9Li1VE0qUuNJxRLBL7c/JIYRnXlKAzT+5xSkVkPsncpZPGsOucyw4+94T3ZaUL
	H+5aNPvLypur3pVuTub2ClM4/fOeQbfs55enMh/fNFWev/LdPyWW4oxEQy3mouJEAGFK7ZQ5
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvK6ad1uawec3khZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVMeO+Q8E+8YrO
	D9/ZGxibhLsYOTkkBEwk9je1sXYxcnEICexmlHgyoYUFIiEjsfvuTlYIW1hi5b/n7BBFHxkl
	NnYuYu5i5OBgE9CV+NEUClIjIuArsWDDc0aQGmaB64wSN6ZvBasRFvCRePQWrIZFQFWi7ctH
	sPm8AjYSL1YcZYaYLy8x89J3dhCbU8BWouPXNEYQWwio5t7N81D1ghInZz4Bs5mB6pu3zmae
	wCgwC0lqFpLUAkamVYySqQXFuem5yYYFhnmp5XrFibnFpXnpesn5uZsYwZGgpbGD8d78f3qH
	GJk4GA8xSnAwK4nwSr1vThPiTUmsrEotyo8vKs1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampB
	ahFMlomDU6qBSTekJzP020T9tO5QqZgEDrYmQf2ZlRcOKrobC9adCmH6fldXv9X/dHHq5FU/
	N/yKrzz5faa6Ts3e9S6vH3mVmW86wP5PxsPea9sUwQCWiATT4F/+SUYLnHZ7LttTMWnnnAeN
	K3h3iTgsPlnts+2oMVOc8gPlG4v0G/9ksP3d+m33jf1KU6r/PVJ7l3jrbK7z2npXyVsic69t
	WJZ5XI1ty+0J9XxB6Xyr/Lkrfsqsf3/thLihYZJBIb/j/oTbF5tFOKYkq6vFBRccPCvC3Kd9
	8817rrgDFov2z13tKvdtxv62VC6+t8uWZO9xe7BD4s/xZxaPhYPXPbi6J++yyfS6S/dLJkiF
	5LTsmRvyi22zuBJLcUaioRZzUXEiAOcqTIvzAgAA
X-CMS-MailID: 20240704071134epcas5p2ec6160369e9092de98a051e05750bd4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240704071134epcas5p2ec6160369e9092de98a051e05750bd4f
References: <20240704070357.1993-1-kundan.kumar@samsung.com>
	<CGME20240704071134epcas5p2ec6160369e9092de98a051e05750bd4f@epcas5p2.samsung.com>

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
index 32c9c6d80384..0d923140006e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1205,20 +1205,15 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
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
index 0c8857fe4079..18520b05c6ce 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -548,6 +548,13 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
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

