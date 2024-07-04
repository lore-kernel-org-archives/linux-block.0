Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764EC1A38F9
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080124; cv=none; b=mXxJAX2ke7B6hwQZ7h0bSK8qxSlZI3svEhJviHquInkGaFvFP+Ie05hStBYOBN+FVMh2IKSSWD5SUoTmxSi2Syv1X/nAu4qiqdinz7MVnkDOgyGSITgL0FobKn2mFO9vioULmq9Q/2TGQKv2/LyZxgIoP3ejpinwVmF/HpoVo/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080124; c=relaxed/simple;
	bh=hNUQ67ZVEN3DNgwF+lZ5HRlC7EC3f5effW9v6MlmfhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=odpoaEfK15gXpsIE8J4TyFWtuzMC3dMJKVPFXX4aRELzLpiU+IIzyP3R+SI/qoBLCriXNILVnukAnqRmKO5I+p/nIlhsC3CyBWwNZnkCfN3elh0YlKa8OWioSxzSYoFhZnb3HYUXe4QtCxO0H2c7QUQuI6kc0m5fxYahTObR020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GMhF3a+L; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GMhF3a+L"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240704080200epoutp03cfdcbe9b1882b346a57c61e617ba3c04~e88Gge7yB1806918069epoutp039
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:02:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240704080200epoutp03cfdcbe9b1882b346a57c61e617ba3c04~e88Gge7yB1806918069epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720080120;
	bh=FAgmrDRvLDUpW+VRyqQXXE6A2RXvHS99RuUFNiqOOlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMhF3a+L/jYKr5aJfXkkilcMiZA/9v9T56XnqqlTesBce8JgaMdflq0VsyBG1LJ4c
	 cacIsH0Nfud6b9ghJvR8aTp+pF1DA/31kTW8cBywzTc1Qc04HPwqiw5rIZyLQHP/L/
	 TKby9lIYurgkwYSSGi9Ymj6GHqjOH7MA5ZlZTE5Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240704080200epcas5p2e9b016b7ba18cdd472050711b9f00e32~e88GHmsLw0737207372epcas5p2i;
	Thu,  4 Jul 2024 08:02:00 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WF8Hn73wLz4x9QH; Thu,  4 Jul
	2024 08:01:57 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.A7.09989.4F656866; Thu,  4 Jul 2024 17:01:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240704071122epcas5p12a52967e486a69375ee77db86f2594a0~e8P5GjRP31116911169epcas5p1N;
	Thu,  4 Jul 2024 07:11:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240704071122epsmtrp289bcc797feab911bbb9b88a3e47641df~e8P5Fu_bL0957709577epsmtrp2z;
	Thu,  4 Jul 2024 07:11:22 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-e6-668656f43a92
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	73.28.29940.A1B46866; Thu,  4 Jul 2024 16:11:22 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240704071120epsmtip2451f355e56c8c475c6ff776b5351222f~e8P3O_Dx31296012960epsmtip2J;
	Thu,  4 Jul 2024 07:11:20 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v7 1/4] block: Added folio-lized version of
 bvec_try_merge_hw_page()
Date: Thu,  4 Jul 2024 12:33:54 +0530
Message-Id: <20240704070357.1993-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704070357.1993-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmpu6XsLY0g1MH1SyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzje
	Od7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoQiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJ
	rVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdkbXgX7mggd8FTs+L2JuYJzE08XIySEh
	YCJx9ORyti5GLg4hgd2MEr3t5xkhnE+MEjtvPGQGqRIS+MYoceRnJEzH3N4lrBBFexklXq6Y
	ww5R9JlRYtpH6y5GDg42AV2JH02hIGERAXeJqS8fgQ1lFjjLKHFi6iMWkISwQJjElMm3GUFs
	FgFViSPb9rGB2LwCNhK7N71hgVgmLzHz0new+ZwCthIdv6YxQtQISpyc+QSshhmopnnrbGaQ
	BRICEzkkDrecY4RodpGYf3gxE4QtLPHq+BZ2CFtK4vO7vWwQdrbEocYNUDUlEjuPNEDV2Eu0
	nupnBnmGWUBTYv0ufYiwrMTUU+uYIPbySfT+fgLVyiuxYx6MrSYx591UqPtlJBZemgEV95A4
	NRGkBhRwExglvjUsZp7AqDALyT+zkPwzC2H1AkbmVYySqQXFuempxaYFRnmp5fBITs7P3cQI
	TrRaXjsYHz74oHeIkYmD8RCjBAezkgiv1PvmNCHelMTKqtSi/Pii0pzU4kOMpsAAn8gsJZqc
	D0z1eSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB9DFxcEo1MJlUba4RmbBj
	49y+kHi9QLXzXWtFr2qVLDuZFHVIvPJvAov43sJZhnu78jJM9A6+mbPWsFLw3/Oph7bXdG/k
	eFKg+YdTtzTjWO7J2IsBJwNXlbxJEaot/86w95TFXkYD+zMilQGLxQOUygOlnyh4Bgr//ZPk
	/N4qy0d74ozAtT39M15f/r5Y8Y5rVa+QtRVvMvsVuwl5Tzf7ndrpdkd4f771mdh3T949bpCS
	XH3F8ZFN84ee/XzbfYy2bv4atnrxCZYDZ3YGNKgr9ZeKFfr9rKuMCNr69OmF9zvEnhwJTM/d
	/WuX09KPfKLTXHi9Hz/RLW+96xhwo6LnTZ2Hll3l+gnCO77u2DdXIZOlWWC7jxJLcUaioRZz
	UXEiABDRBzA9BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSvK6Ud1uaQVuXjEXThL/MFqvv9rNZ
	fN/ex2Jx88BOJouVq48yWRz9/5bNYtKha4wWW798ZbXYe0vb4saEp4wW237PZ7b4/WMOmwOP
	x+YVWh6Xz5Z6bFrVyeax+2YDm0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBldB3oZy54wFex
	4/Mi5gbGSTxdjJwcEgImEnN7l7B2MXJxCAnsZpT4fmwnM0RCRmL33Z2sELawxMp/z9khij4y
	Sty+fA6oiIODTUBX4kdTKEiNiICvxIINzxlBapgFrjNK3Ji+FWyQsECIxKnldxlBbBYBVYkj
	2/axgdi8AjYSuze9YYFYIC8x89J3dhCbU8BWouPXNLB6IaCaezfPs0DUC0qcnPkEzGYGqm/e
	Opt5AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeDluYOxu2r
	PugdYmTiYDzEKMHBrCTCK/W+OU2INyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs
	1NSC1CKYLBMHp1QDk0u0CsM81qVtX+/sec/iEXwwNnnH98MGW7dyOm95+Xqjyezldnx75gUZ
	v4zWv9w37+6B65axYkrWfreMNhW4Vt+fpFma6rU7Q9e/rP6ZqzJXIa96zuaeW9M+zVqUMXvV
	muXFanzGU8NiHN5eurucf+kBAWHV/TFf82d9O6BwWo+hLMtHNNF1gZhOz6+zs1+abF2aenme
	wCz+3TOZZMvdU75P1j6/+sob13MWDZ+jC9IDtpTecwu/sErbVzrEinXzzfqvJiq7c1caM5az
	NmgIzr71NiRs3i/dx8EH9s46/09L65DJ+5NsJ4KzWtKL0jmsKz5xh4pI+hy++vviTr0dxdNN
	1qyUfpQksHjHAffVHUosxRmJhlrMRcWJAI6PwrT1AgAA
X-CMS-MailID: 20240704071122epcas5p12a52967e486a69375ee77db86f2594a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240704071122epcas5p12a52967e486a69375ee77db86f2594a0
References: <20240704070357.1993-1-kundan.kumar@samsung.com>
	<CGME20240704071122epcas5p12a52967e486a69375ee77db86f2594a0@epcas5p1.samsung.com>

Added new function bvec_try_merge_hw_folio(). This is a prep patch.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c | 17 +++++++++++++++++
 block/blk.h |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index e9e809a63c59..c10f5fa0ba27 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -952,6 +952,23 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 		struct page *page, unsigned len, unsigned offset,
 		bool *same_page)
 {
+	struct folio *folio = page_folio(page);
+
+	return bvec_try_merge_hw_folio(q, bv, folio, len,
+			((size_t)folio_page_idx(folio, page) << PAGE_SHIFT) +
+			offset, same_page);
+}
+
+/*
+ * Try to merge a folio into a segment, while obeying the hardware segment
+ * size limit.  This is not for normal read/write bios, but for passthrough
+ * or Zone Append operations that we can't split.
+ */
+bool bvec_try_merge_hw_folio(struct request_queue *q, struct bio_vec *bv,
+		struct folio *folio, size_t len, size_t offset,
+		bool *same_page)
+{
+	struct page *page = folio_page(folio, 0);
 	unsigned long mask = queue_segment_boundary(q);
 	phys_addr_t addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
 	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
diff --git a/block/blk.h b/block/blk.h
index 47dadd2439b1..17478657c5ef 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -94,6 +94,10 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 		struct page *page, unsigned len, unsigned offset,
 		bool *same_page);
 
+bool bvec_try_merge_hw_folio(struct request_queue *q, struct bio_vec *bv,
+		struct folio *folio, size_t len, size_t offset,
+		bool *same_page);
+
 static inline bool biovec_phys_mergeable(struct request_queue *q,
 		struct bio_vec *vec1, struct bio_vec *vec2)
 {
-- 
2.25.1

