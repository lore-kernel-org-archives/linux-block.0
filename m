Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997FA1E878
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 04:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769641; cv=none; b=E2/gHQnQ5nDkGRSdTG8E1G0IqO775SqDlpZgV43qsPFuFmJ7RLk2rxxtpgBbzwdpbTNL5O+BIHZjXKuEBHqxb/zW629hAUdotVwRZhe0hcq6aB6VTM9cVpSrnwjZUbfKVSInuhjH44rAmnUZhuObLXzEfulLvo4QadNF4k/jeEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769641; c=relaxed/simple;
	bh=cuqpbnNui64IOq3qaArA7pS/2/L4OZYRqBJLrwJKpnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=t1AhYrtq4R/qcsAMp1P7EZ4n6HroJ+rCR9ojdRHQiw2++G3NfSuUWU7ZoxpApjErE/WBVGHU746+H8JlveE+0cG1k9ufFnBYq9ljscma/e1xcxvY45yZQ525fpq5tnouhShNVOUOe1Wd23SEHvbw1AkyHcWnJG+WB1SzmGXkoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W5dtMHdL; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W5dtMHdL"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240619040036epoutp031e41be9713a5a9dd267baa5958732cd0~aS_DSzkwe3132731327epoutp03Z
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 04:00:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240619040036epoutp031e41be9713a5a9dd267baa5958732cd0~aS_DSzkwe3132731327epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718769636;
	bh=bSc1O9CNMJ738L48usJhBMa72iwE2Sgm1XUeD+T+QPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5dtMHdLq8wIzOF+JGfXYU0+TGMY7yh+l3Lsx4w8EgnDjAsIQqCRZlstTeao4NeY+
	 5sVS1zTufx/GiGnG/oFxPgyqBL2LiMhZLHgbCECdlqamOC0AlCIAqCbBqYqRn5GjlB
	 y7lQai10gudBNFZrVxOWLQ/r316qsxsOeSIszK3s=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240619040034epcas5p20e2a8daae4959a1f2b9899ae7fe43e92~aS_A0n1e_3041630416epcas5p2E;
	Wed, 19 Jun 2024 04:00:34 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4W3qf73h8Xz4x9Q7; Wed, 19 Jun
	2024 04:00:31 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	82.B0.08853.FD752766; Wed, 19 Jun 2024 13:00:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240619024153epcas5p4fda751acf693081824c7f1f279988f65~aR5UVaIJr0311303113epcas5p4T;
	Wed, 19 Jun 2024 02:41:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240619024153epsmtrp1dad79b3c9f58027e345ad55c0ff56ab7~aR5UUbgVf0144301443epsmtrp1K;
	Wed, 19 Jun 2024 02:41:53 +0000 (GMT)
X-AuditID: b6c32a44-fc3fa70000002295-4e-667257df3de1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.2C.19057.17542766; Wed, 19 Jun 2024 11:41:53 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240619024151epsmtip24593a978d8352718cf8530901fa4ff66~aR5SopwZM0387003870epsmtip2v;
	Wed, 19 Jun 2024 02:41:51 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v5 3/3] block: unpin user pages belonging to a folio
Date: Wed, 19 Jun 2024 08:04:20 +0530
Message-Id: <20240619023420.34527-4-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240619023420.34527-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmlu798KI0g7YVEhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO6Px9ASWgoNyFd1PfzM2MHaJdTFyckgI
	mEjcurWKtYuRi0NIYDejRMuCbjYI5xOjxPRNM6Ay3xglTt96wQLT8mfdLKiqvYwSF25OhnI+
	M0qsWTsHqIqDg01AV+JHUyhIg4iAu8TUl48YQWqYBc4ySpyY+ghskrCAi8SRfb+YQGwWAVWJ
	r/8fMYPYvAK2Eo/WzmKE2CYvMfPSd3aQmZwCdhI/r1hDlAhKnJz5BGwMM1BJ89bZzCDzJQSm
	ckg82DaXFaLXReJRXwM7hC0s8er4FihbSuJlfxuUnS1xqHEDE4RdIrHzCEy9vUTrqX5mkL3M
	ApoS63fpQ4RlJaaeWscEsZdPovf3E6hWXokd82BsNYk576ZCA0tGYuGlGVBxD4lv55dBQ3Qi
	o8SSxatYJzAqzELyzywk/8xCWL2AkXkVo2RqQXFuemqyaYFhXmo5PJaT83M3MYJTrZbLDsYb
	8//pHWJk4mA8xCjBwawkwus0LS9NiDclsbIqtSg/vqg0J7X4EKMpMLwnMkuJJucDk31eSbyh
	iaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1M21nUvoZ+nfz0buy0zhkv
	dzrfrHl9fmatX29vR2md6PIfE9fN73BacaA3L/5TUOXnX0pCPYGOwp0Hlt76U7vCWiFp/cUZ
	zta1vyuTbSVeX3zAePb747tPnvzQdGOsO5z5XtgwWY51eoSdYuzvbelpSXeVq75pf3VdOWHL
	7/VnewPPlkimza6bKCOiEJ1u+OeJVOfGAyXyndMe7X78+ua+U0anpW6zuBVfmzJBPs45x+bw
	9BsFpa58Sy6fbMz55ZVuLdkV2/9Vaf4vxb8hxfKbkjZf2xhk8ulCNHtr+DemDsftkrula3Y9
	UmLae4ZbLIbdgk/75YdtH29ckfrnw60qsewX281r8uZak6Zt7FAMUmIpzkg01GIuKk4EADVc
	pVg+BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSvG6ha1GawcPpohZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CV0Xh6AkvBQbmK
	7qe/GRsYu8S6GDk5JARMJP6sm8XWxcjFISSwm1Gip/UxO0RCRmL33Z2sELawxMp/z9khij4y
	Spy9187SxcjBwSagK/GjKRSkRkTAV2LBhueMIDXMAtcZJW5M38oMkhAWcJE4su8XE4jNIqAq
	8fX/I7A4r4CtxKO1sxghFshLzLz0nR1kJqeAncTPK9YgYSGgkr4VH1ggygUlTs58AmYzA5U3
	b53NPIFRYBaS1CwkqQWMTKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJjQUtrB+Oe
	VR/0DjEycTAeYpTgYFYS4XWalpcmxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb694UIYH0xJLU
	7NTUgtQimCwTB6dUA5P/8pRAuyc13EWx/6YEv5qkn7E7XbtE/8V2DpEDMvrn53/xWZG55M3B
	2iKnP1dtzq91/Tbnx37GyxoOIutshbet3iV4Zv43E8Hjv0yCrmftyss2yFK7+qXn1Bsv+2ev
	+tpmi1yaMlO+7/STy6xu4tUS14//Xf5qz8eSqcn3WX82u+WrvpzvoSjnV3piwpyr5meXz5Q4
	aPUjYfW+i3/bEtZE8779W/Bztr5YYfx2/3W3n2wx72j2E3MIXFSZyn5RdtlMrfNf0tUM10kW
	XlM87qB7fu+WinaL1LNMf3prfvfIu146xLrXeWePsqqr9KZkfql9RZfXtbXciVzy1dJd+8uq
	pNBdf5IK1546/36ebeRFJZbijERDLeai4kQATWwmBPQCAAA=
X-CMS-MailID: 20240619024153epcas5p4fda751acf693081824c7f1f279988f65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240619024153epcas5p4fda751acf693081824c7f1f279988f65
References: <20240619023420.34527-1-kundan.kumar@samsung.com>
	<CGME20240619024153epcas5p4fda751acf693081824c7f1f279988f65@epcas5p4.samsung.com>

Unpin pages which belong to same folio. This enables us to release folios
on I/O completion rather than looping through pages.

Introduce a function bio_release_folio() helps put refs by npages count.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c        | 13 ++++---------
 block/blk.h        |  7 +++++++
 include/linux/mm.h |  1 +
 mm/gup.c           | 13 +++++++++++++
 4 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3e75b5b0eb6e..68f6de0b0a08 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1186,20 +1186,12 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
        struct folio_iter fi;

        bio_for_each_folio_all(fi, bio) {
-               struct page *page;
-               size_t nr_pages;
-
                if (mark_dirty) {
                        folio_lock(fi.folio);
                        folio_mark_dirty(fi.folio);
                        folio_unlock(fi.folio);
                }
-               page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
-               nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
-                          fi.offset / PAGE_SIZE + 1;
-               do {
-                       bio_release_page(bio, page++);
-               } while (--nr_pages != 0);
+               bio_release_folio(bio, fi.folio, 1);
        }
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1372,6 +1364,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
                } else
                        bio_iov_add_folio(bio, folio, len, folio_offset);

+               if (num_pages > 1)
+                       bio_release_folio(bio, folio, num_pages - 1);
+
                /* Skip the pages which got added */
                i = i + (num_pages - 1);

diff --git a/block/blk.h b/block/blk.h
index d0bec44a2ffb..a657282c0e4a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -538,6 +538,13 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
                unpin_user_page(page);
 }

+static inline void bio_release_folio(struct bio *bio, struct folio *folio,
+                                    unsigned long npages)
+{
+       if (bio_flagged(bio, BIO_PAGE_PINNED))
+               unpin_user_folio(folio, npages);
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
+       gup_put_folio(folio, npages, FOLL_PIN);
+}
+EXPORT_SYMBOL(unpin_user_folio);
+
 /*
  * Set the MMF_HAS_PINNED if not set yet; after set it'll be there for the mm's
  * lifecycle.  Avoid setting the bit unless necessary, or it might cause write
--
2.25.1

