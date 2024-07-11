Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE65FB9B
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675217; cv=none; b=ExfI0My59rOsF8HPbi7ks5XFnylRnZBQKQXRtC8rOYRDk8F5P3Yg6+pbgDLvm6zSF6y0ZOZLM55DB1msLVlpwxatj7sNFj5CbHTrXoe5mUZfbPYCQI4R06FkEsnPXFLqD5ft3sNxdnamauli5gDaehmhaqjLRhhLUP0bbppcCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675217; c=relaxed/simple;
	bh=uRDISmRMMsPbNCOgomSZwWRkp7ktFqa48Pr3xhL9cds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=hF7KkW8sbrNqI+rugKVCFbJs6Fgotje5A6BB4f1Diyr70qDLyQFU1BdeTS1VkTi6D7mvQY8Ze0AYSyhhlz6fhe0gexAao6mfhzCNKnbuqxIzEbwmu7xRTMCOuM5dMgu4+DQ7Ggj/mqAzLm3LiU7pz8tECWHhScaScqX3zKSTIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gCSG2ePN; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gCSG2ePN"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240711052013epoutp0362aac82f79c9bdc2bc7053bcad79f225~hEP2Xgz6R1551215512epoutp03t
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 05:20:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240711052013epoutp0362aac82f79c9bdc2bc7053bcad79f225~hEP2Xgz6R1551215512epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720675214;
	bh=jUURJxBXiQxlMyE0MeIkequPl8VktsiHIXGRDMikDxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCSG2ePNfFeM2T+z/O6a8q8eW5pdBcuO7dTwaHO/aY1A0TUNL6ttCXbzGQs8oHDt2
	 zMzHIEIlfivGYj0qEMrVCW1Y1JIVBTK1G1jGjU+sorbkBhiTTRV27cW+t0I0pfmIni
	 GF4qXiEsajDoFl93QDhPPM0iUrGACR04YQKFFdgk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240711052013epcas5p4cef469c4aebafa4b624919b1a2b89657~hEP1xd7MY1591415914epcas5p45;
	Thu, 11 Jul 2024 05:20:13 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WKNMv3w02z4x9Q7; Thu, 11 Jul
	2024 05:20:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.F3.19174.B8B6F866; Thu, 11 Jul 2024 14:20:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240711051543epcas5p364f770974e2367d27c685a626cc9dbb5~hEL6NOGoP1516315163epcas5p3R;
	Thu, 11 Jul 2024 05:15:43 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240711051543epsmtrp223e0bd154980a012976ff051adf2f2de~hEL6MYEch1668816688epsmtrp2L;
	Thu, 11 Jul 2024 05:15:43 +0000 (GMT)
X-AuditID: b6c32a50-b33ff70000004ae6-25-668f6b8bb394
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.C5.07412.F7A6F866; Thu, 11 Jul 2024 14:15:43 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240711051541epsmtip1342f7ade2d7406fe3a3402c67c802db7~hEL4apagb0217802178epsmtip1-;
	Thu, 11 Jul 2024 05:15:41 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v8 5/5] block: unpin user pages belonging to a folio at once
Date: Thu, 11 Jul 2024 10:37:50 +0530
Message-Id: <20240711050750.17792-6-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711050750.17792-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmlm53dn+awdO/MhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO6Nj6SPmghs8FTt75zE3MC7i6mLk5JAQ
	MJF4sH4JexcjF4eQwB5Gia+btjNBOJ8YJVZcPgPlfGOU2DbnPztMy6etc8FsIYG9jBLLD8ZD
	FH1mlNh38AhrFyMHB5uArsSPplCQGhEBd4mpLx8xgtQwC5xllDgx9RELSEJYwEfiw+NbYDaL
	gKrEv7V3GUF6eQVsJabdYIbYJS8x89J3sF2cAnYSG/+8AyvnFRCUODnzCZjNDFTTvHU2M8h8
	CYGpHBIH+/8xQTS7SKyc/BXqaGGJV8e3QNlSEp/f7WWDsLMlDjVugKovkdh5pAGqxl6i9VQ/
	M8g9zAKaEut36UOEZSWmnlrHBLGXT6L39xOoVl6JHfNgbDWJOe+mskDYMhILL82AintInDyy
	gQ0SVhOBoXtjH/MERoVZSP6ZheSfWQirFzAyr2KUSi0ozk1PTTYtMNTNSy2Hx3Jyfu4mRnCq
	1QrYwbh6w1+9Q4xMHIyHGCU4mJVEeOff6E4T4k1JrKxKLcqPLyrNSS0+xGgKDPCJzFKiyfnA
	ZJ9XEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZqakFqEUwfEwenVAOTaK9Fu+A9lvK3
	v/leznBKuPhTacL5gAKvS3N0ci/LNt56OGXTQvkn3zI6k8qmTbL46dQ6ce7pO81qPXq3hSRq
	jip+n/P5Ded3PaZlglc3r9lcKhMv6iG+cNttLuk5Di/XfQzdwRBkE5o6y+jTZuU/NctrdISL
	LtbMNlB8WXPZ/s/jWZOOcnnErJj03KjAboKdfg9vP+f1ureXowRuLRJY4nzcO0sta/lOucus
	UW846/dbGpxsna+z8eztShnz/dlFWfoSZ3/0/GmaeOez6YR9a6vm83k2HLb4yb714dr3QVkz
	S7kV9YPta3KMW7JUrc+Jlk6Te3zIU43BQeoPS/W+yamn60+XxS09rbl2+qk1SizFGYmGWsxF
	xYkAg+CuKD4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnG59Vn+awYEWNoumCX+ZLVbf7Wez
	+L69j8Xi5oGdTBYrVx9lsjj6/y2bxaRD1xgttn75ymqx95a2xY0JTxkttv2ez2zx+8ccNgce
	j80rtDwuny312LSqk81j980GNo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DK6Fj6iLngBk/F
	zt55zA2Mi7i6GDk5JARMJD5tncvexcjFISSwm1Hi7KseRoiEjMTuuztZIWxhiZX/nkMVfWSU
	mPGgASjBwcEmoCvxoykUpEZEwFdiwYbnjCA1zALXGSVuTN/KDJIQFvCR+PD4FguIzSKgKvFv
	7V1GkF5eAVuJaTeYIebLS8y89J0dxOYUsJPY+OcdWLkQUMn/bVfA4rwCghInZz4BizMD1Tdv
	nc08gVFgFpLULCSpBYxMqxglUwuKc9Nzkw0LDPNSy/WKE3OLS/PS9ZLzczcxgmNBS2MH4735
	//QOMTJxMB5ilOBgVhLhnX+jO02INyWxsiq1KD++qDQntfgQozQHi5I4r+GM2SlCAumJJanZ
	qakFqUUwWSYOTqkGpm1X+M8+6Jw9qa5mZeFjV+5F5TMWxk1m+irItlqPM19/9/H/Vi1ps+5u
	kr6f8TCkcntcSv2Ub91b7gnc4BbzfeWz/9ulNL/zAYumpp0+ZrctiFNaMk37z2HVpXIPK+Ir
	S/u17Y5/U+5QvsTRvyNJt+Dg/MUTDhz1VlmxT2zB/Nc/Tx5d2jGLQc7b4K+XZ/72ljeX5CdO
	yq4qi33TforTWk767hLviIO81zdFrPr6o76HwbvH5LpT9cXrCw4K+nzsMpn7f/Z805LqeWaM
	G8VYbLfWyNjt7n3/tYFhtfWmiamMhwRvNfAema8/b/Gk2L2Ldn7bXpKk8YxH1rPbd9aWhOcH
	owpD3v1d/u/117YSvnNKLMUZiYZazEXFiQDjegb79AIAAA==
X-CMS-MailID: 20240711051543epcas5p364f770974e2367d27c685a626cc9dbb5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240711051543epcas5p364f770974e2367d27c685a626cc9dbb5
References: <20240711050750.17792-1-kundan.kumar@samsung.com>
	<CGME20240711051543epcas5p364f770974e2367d27c685a626cc9dbb5@epcas5p3.samsung.com>

Add a new wrapper bio_release_folio() and use it to put refs by npages
count.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c | 6 +-----
 block/blk.h | 6 ++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b4df3af3e303..ca249f2c99a7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1207,7 +1207,6 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	struct folio_iter fi;
 
 	bio_for_each_folio_all(fi, bio) {
-		struct page *page;
 		size_t nr_pages;
 
 		if (mark_dirty) {
@@ -1215,12 +1214,9 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
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
index 777e1486f0de..8e266f0ace2b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -558,6 +558,12 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
 		unpin_user_page(page);
 }
 
+static inline void bio_release_folio(struct bio *bio, struct folio *folio,
+				     unsigned long npages)
+{
+	unpin_user_folio(folio, npages);
+}
+
 struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
-- 
2.25.1

