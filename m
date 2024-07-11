Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9E381CC
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675205; cv=none; b=TRJPLhanpvBiLmoFh9e9FonE0/3nCRRDqsgXtMwGYkAPGofuezKjKX53MknVKiaJ4v1z4zgA+agPhqjdK82/6dAUs2bWCuUQYbVgAh+OCV5mpAYOCVC0vR414lRy9PWZkL6IDJMdt9kZxNkg6MtybbwEY3CRBtW6yIBg8wmpwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675205; c=relaxed/simple;
	bh=AgPzpnl76A59ZoOKASAH06+ps/h9++7shcfDxB84nBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=buZYcqlnn6Z58e5JdGt1tgAIMZqk1XrNgoX1p6GmwtiQkOGzDGRBPJfjTEQtsSpQYtl+M45AbqvVaddh94qVuzKmFld2JxCG/0Y0el4fyxKstQm5uuE3YKAmUslneGTn1l0Kg02NlfX+BoTBJPq7tHFnR2ud7P0C0vwdttqMNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mxgp6B26; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mxgp6B26"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240711052000epoutp04f5fd5640da3d7422f4c9df9892be271b~hEPqNX_Bj1223812238epoutp04h
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 05:20:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240711052000epoutp04f5fd5640da3d7422f4c9df9892be271b~hEPqNX_Bj1223812238epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720675200;
	bh=6n03T2JEGN3vj8I+QUtWy7BDCiBg5RtsiSgviI1bsHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxgp6B26KAISSUrKblgY/Ergl+QSPJbPqr41rESJZxnOxhrh9hOEVvDZginl9ZddA
	 YOXr2kqDBrsPibSWvGOWJcP16UUp88bu9Dx5HRztEIDifj2V+xxF7Tn1BY3B4X4SgK
	 aogjjL4Yk4gxerEKAALj7o2Hpxq81i4MicJ/p89E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240711052000epcas5p33266c6709c8d694a484b6b0053ccf63b~hEPpuq3-80960609606epcas5p3g;
	Thu, 11 Jul 2024 05:20:00 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WKNMf3N4Yz4x9Q7; Thu, 11 Jul
	2024 05:19:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8D.55.07307.E7B6F866; Thu, 11 Jul 2024 14:19:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240711051529epcas5p1aaf694dfa65859b8a32bdffce5239bf6~hELtPh7NW0839808398epcas5p1C;
	Thu, 11 Jul 2024 05:15:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240711051529epsmtrp13a20764128ec3b4be07b6f3ec87c7aff~hELtOwQ_I1247512475epsmtrp1Y;
	Thu, 11 Jul 2024 05:15:29 +0000 (GMT)
X-AuditID: b6c32a44-3f1fa70000011c8b-00-668f6b7e850d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.9D.19057.17A6F866; Thu, 11 Jul 2024 14:15:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240711051527epsmtip14d158fec9577ac15732908f9335b8582~hELrfBjrN0104201042epsmtip1W;
	Thu, 11 Jul 2024 05:15:27 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v8 1/5] block: Added folio-ized version of
 bvec_try_merge_hw_page()
Date: Thu, 11 Jul 2024 10:37:46 +0530
Message-Id: <20240711050750.17792-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711050750.17792-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmhm5ddn+awaZt4hZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PzmdXsBbckKtZsOsXcwDhbpIuRk0NC
	wETize1Oti5GLg4hgd2MEkduTGCGcD4xShz+uoMJwvnGKHGxqZuli5EDrOXRllCI+F5GictH
	HrFAOJ8ZJdZ+O8MMUsQmoCvxoykUZIWIgLvE1JePGEFqmAXOMkqcmArSwMkhLBAq0bjsOiuI
	zSKgKtHRP5cRpJdXwFbi9EQdiPPkJWZe+s4OYnMK2Els/PMOrJVXQFDi5MwnYDYzUE3z1tlg
	V0sITOSQ2Px0PwtEs4vEnsUPGSFsYYlXx7ewQ9hSEi/726DsbIlDjRuYIOwSiZ1HGqDi9hKt
	p/rBfmEW0JRYv0sfIiwrMfXUOiaIvXwSvb+fQLXySuyYB2OrScx5NxXqBBmJhZdmQMU9JDaf
	WsIKCauJwNA93cs2gVFhFpJ/ZiH5ZxbC6gWMzKsYJVMLinPTU5NNCwzzUsvhkZycn7uJEZxo
	tVx2MN6Y/0/vECMTB+MhRgkOZiUR3vk3utOEeFMSK6tSi/Lji0pzUosPMZoCw3sis5Rocj4w
	1eeVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBaBNPHxMEp1cDkLnWzu0RwrarV
	8vKzS93MvKbemauXd2MFfyhX796Of5XXT+244vzvwPT3yjNZ08STzhdFZ4kr5cfMiQzlPlN+
	rkP/ydNLocuf8XVFGTj93GMoerlj053nHYz5vp3XdrH+V+o6Zn/ogvvTtpm2k76uddk4SfXK
	p42TZm9wmODWGlkYw3aH543NN87oudd4fSdEhPVl6V69/fbQMhO3PfYplVphbc9/JHnlzJ7P
	vW+zQOmKuOh5OeZKQeEx+gcU/1x9/vDZ53r9zzNCn5t3LtdKWtfYLubT6zjv4U7/zR4r6rar
	8mooLBF+wyEdIOIufX3qLEmJf3XOvaL8T3Q1v3wynJWzQq+uq1XtwN5vEpOVWIozEg21mIuK
	EwF6ZnSnPQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnG5hVn+awbGfXBZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CV8fnMavaCWxIV
	azadYm5gnC3SxcjBISFgIvFoS2gXIxeHkMBuRonN65axdTFyAsVlJHbf3ckKYQtLrPz3nB2i
	6COjxJtVr5hBmtkEdCV+NIWC1IgI+Eos2PCcEaSGWeA6o8SN6VvBaoQFgiXa1teB1LAIqEp0
	9M9lBAnzCthKnJ6oAzFeXmLmpe/sIDangJ3Exj/vWEBsIaCS/9uugMV5BQQlTs58AhZnBqpv
	3jqbeQKjwCwkqVlIUgsYmVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHgZbWDsY9
	qz7oHWJk4mA8xCjBwawkwjv/RneaEG9KYmVValF+fFFpTmrxIUZpDhYlcd5vr3tThATSE0tS
	s1NTC1KLYLJMHJxSDUyO/lsZ93BnbN7PkGEVYT0n4VL8HrVi2TzRazMfVL+59Xrblaiu2D1F
	grFGx34Jrv2VHfGkO6/Mp86t86H4igxOFqeFUllyj9dW+YtP2/RRPVcmf2K/7cqrVaf+fGTZ
	plhmFn2jckXqd8X2xTE3lqdubtFJFIi60BZrkzeDMb5gaXdl3pKs/p3cQjvNv1/7K6SoV774
	29pv2b7rLyndtz46S7VL9bRZ4wTtam47WZ6Qp0tLVuokTAwxZm2/4p3YcrorJOjqyanv5x8N
	ux1gzn51grzFypMyApbbpzmvldHyrsvZmZRzPqa53uLKyT+Nd57KFm9bMy1lYvKNhzsetN3+
	32BhdbNe0KAk63pnrBJLcUaioRZzUXEiAMwR7ZbyAgAA
X-CMS-MailID: 20240711051529epcas5p1aaf694dfa65859b8a32bdffce5239bf6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240711051529epcas5p1aaf694dfa65859b8a32bdffce5239bf6
References: <20240711050750.17792-1-kundan.kumar@samsung.com>
	<CGME20240711051529epcas5p1aaf694dfa65859b8a32bdffce5239bf6@epcas5p1.samsung.com>

Added new function bvec_try_merge_hw_folio(). This is a prep patch.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 27 +++++++++++++++++++++++----
 block/blk.h |  4 ++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c4053d49679a..7018eded8d7b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -931,7 +931,9 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
 	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
 		return false;
 
-	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
+	if (off < PAGE_SIZE)
+		*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
+
 	if (!*same_page) {
 		if (IS_ENABLED(CONFIG_KMSAN))
 			return false;
@@ -944,14 +946,15 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
 }
 
 /*
- * Try to merge a page into a segment, while obeying the hardware segment
+ * Try to merge a folio into a segment, while obeying the hardware segment
  * size limit.  This is not for normal read/write bios, but for passthrough
  * or Zone Append operations that we can't split.
  */
-bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
-		struct page *page, unsigned len, unsigned offset,
+bool bvec_try_merge_hw_folio(struct request_queue *q, struct bio_vec *bv,
+		struct folio *folio, size_t len, size_t offset,
 		bool *same_page)
 {
+	struct page *page = folio_page(folio, 0);
 	unsigned long mask = queue_segment_boundary(q);
 	phys_addr_t addr1 = bvec_phys(bv);
 	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
@@ -963,6 +966,22 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 	return bvec_try_merge_page(bv, page, len, offset, same_page);
 }
 
+/*
+ * Try to merge a page into a segment, while obeying the hardware segment
+ * size limit.  This is not for normal read/write bios, but for passthrough
+ * or Zone Append operations that we can't split.
+ */
+bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
+		struct page *page, unsigned int len, unsigned int offset,
+		bool *same_page)
+{
+	struct folio *folio = page_folio(page);
+
+	return bvec_try_merge_hw_folio(q, bv, folio, len,
+			((size_t)folio_page_idx(folio, page) << PAGE_SHIFT) +
+			offset, same_page);
+}
+
 /**
  * bio_add_hw_page - attempt to add a page to a bio with hw constraints
  * @q: the target queue
diff --git a/block/blk.h b/block/blk.h
index e180863f918b..6a566b78a0a8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -91,6 +91,10 @@ struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
 		gfp_t gfp_mask);
 void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned short nr_vecs);
 
+bool bvec_try_merge_hw_folio(struct request_queue *q, struct bio_vec *bv,
+		struct folio *folio, size_t len, size_t offset,
+		bool *same_page);
+
 bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 		struct page *page, unsigned len, unsigned offset,
 		bool *same_page);
-- 
2.25.1

