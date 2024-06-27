Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5918732D
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494063; cv=none; b=EZEP69dGygRxNq7/Sb25s/aSTe3PAQ9iK//JVl6tS0wqehoXMHOjtKVAWHJhTY/65e2tHB8u2IB+QOeY1pqvd5sEnFq48QcaDc7jyd5emuHJsQMDvLZxlLWfCb5xy1i55AlnPjcD9Owj/2py2bGuUCBkqTDsxOp3Lz5Vhd7akMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494063; c=relaxed/simple;
	bh=jNHWVbeYhZDhPFEgKWgFGR78ajz3qSFZP4uZZ8IoHx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=CG17OVNyCOTx+DGTmLfQsvYHMIeMg2RvsSEMmOgX38crG1bj3yVjG3/Mxw4ta6hTeT2crUpiaSN8T+Cp1YNGlrPOWEVLAXefAfiJ99elFr/Xh8U3Axt7zL60LdUBG+O452Ae6+Lxbplw1DKFafM+/DV43VSg8ISjjuv04zCAu0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Q4jfW6Dl; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q4jfW6Dl"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240627131418epoutp01e87636c9c82032a9969d3438049749b7~c3rxz_1ap1975719757epoutp01b
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 13:14:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240627131418epoutp01e87636c9c82032a9969d3438049749b7~c3rxz_1ap1975719757epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719494058;
	bh=h6p0r8QGeMeiENXxuYhDRIQeqijV9Gyk512CJzPV4Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4jfW6Dl+HgdB27ZyZw4fTcEzjXScKmbkCheOcxZHUOSYiqoDiyPQHfu18Z8kwiJB
	 CoxW1eygKeFXh1jJSFq16qY0db6l45Lo8xN9QM1VJMLO0kkTYh1axvKd7VNDzAScTb
	 vZHY4hn9AVHVFYdAg+lpv8HbN3tcnSDqRxArsVpw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240627131418epcas5p3e5ce668a5c2608f08d5a2eef12629fcd~c3rxXJJod0653906539epcas5p3L;
	Thu, 27 Jun 2024 13:14:18 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4W8zYN44Yvz4x9Pw; Thu, 27 Jun
	2024 13:14:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CE.6F.06857.8A56D766; Thu, 27 Jun 2024 22:14:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240627105404epcas5p334c7c5bd3aee98b58e60ac1008c863be~c1xVBDgd82093720937epcas5p3N;
	Thu, 27 Jun 2024 10:54:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240627105404epsmtrp217e34dfa5111e03db9004cc5e0d69924~c1xVAPDND0954409544epsmtrp2R;
	Thu, 27 Jun 2024 10:54:04 +0000 (GMT)
X-AuditID: b6c32a4b-ae9fa70000021ac9-16-667d65a80d89
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	45.1E.19057.BC44D766; Thu, 27 Jun 2024 19:54:03 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240627105402epsmtip18392ee0ffabb9899cc12174cd8c7e685~c1xTPibz43160631606epsmtip1w;
	Thu, 27 Jun 2024 10:54:02 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v6 1/3] block: Added folio-lized version of
 bio_add_hw_page()
Date: Thu, 27 Jun 2024 16:15:50 +0530
Message-Id: <20240627104552.11177-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627104552.11177-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmlu6K1No0g5blUhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+P2qTUsBc/FKq6vmcLewLhWqIuRg0NC
	wERiW4dvFyMXh5DAbkaJJ+fnskM4nxgldrU+ZINwvjFK3Fq9k7GLkROsY1F7NyNEYi+jxPdP
	f6BaPjNKPFvdxwYyl01AV+JHUyhIg4iAu8TUl4/AGpgFzjJKnJj6iAWkRljAX+Lb1AKQGhYB
	VYkbC3azgti8ArYS+1rnQC2Tl5h56Ts7SDmngJ1E16cKiBJBiZMzn7CA2MxAJc1bZzODjJcQ
	mMgh8bDtNVSvi8SbaYuYIGxhiVfHt7BD2FISn9/tZYOwsyUONW6AqimR2HmkAarGXqL1VD8z
	yF5mAU2J9bv0IcKyElNPrWOC2Msn0fv7CVQrr8SOeTC2msScd1NZIGwZiYWXZkDFPSSWt+8E
	iwsJTGSUePFQbgKjwiwk78xC8s4shM0LGJlXMUqmFhTnpqcWmxYY56WWw6M4OT93EyM4yWp5
	72B89OCD3iFGJg7GQ4wSHMxKIryhJVVpQrwpiZVVqUX58UWlOanFhxhNgcE9kVlKNDkfmObz
	SuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgmjDLPTvwfvlvi/Pe
	sbMmL3F6YJ0QavGC50+ocz9j8r31EwsvbVK+MZP51V8f57gHOZH6crqiLYdajy5dU/rbe/2x
	E2uE7l5zkm66effbt3TJaAe/8+cUrgkc2bJs1W/vBc+Kw6KqJlUIWTJHXWa3s13yQeKGeqGW
	S4HuhZIoh2cqE27Zama2LL5/Iu35eqP25VInkmzl5VI53Pca309Kd29/uvrNcvctrE8O/TCd
	1992VIh3Osv8R58Wej90efX7RaoiZ4TfY2GRc+lG0rfk3j6e9+OV2esdUf919opFcNhVW+W1
	FDpL7gq+MJmX12W205dvtk0Zbe78LsfmlkS0/LBPs2hauz6KbcrJOxz6SizFGYmGWsxFxYkA
	MxUBSjsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnO5pl9o0g91zzS2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF7x9z2Bx4
	PDav0PK4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr4/apNSwFz8Uq
	rq+Zwt7AuFaoi5GTQ0LARGJRezdjFyMXh5DAbkaJGf8usUIkZCR2390JZQtLrPz3nB2i6COj
	xIU3+1m6GDk42AR0JX40hYLUiAj4SizY8BxsELPAdUaJG9O3MoMkhIESy3p2gQ1iEVCVuLFg
	N5jNK2Arsa91DiPEAnmJmZe+s4PM5BSwk+j6VAFiCgGVbJyRDVEtKHFy5hMWEJsZqLp562zm
	CYwCs5CkZiFJLWBkWsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERwJWlo7GPes+qB3
	iJGJg/EQowQHs5IIb2hJVZoQb0piZVVqUX58UWlOavEhRmkOFiVx3m+ve1OEBNITS1KzU1ML
	UotgskwcnFINTFPXL13I1v7o2+J31z9Ou5GqZLRi9W+T5f0MZ09n3Fr/zuGf/nOBrztZ/7+8
	8qzp8M2985bvDj/Yph4s2q3lcmvPpXlH157tDP7dtuHOzrw96haZN55VXot6UHzUqDu/7ncQ
	18WUDNM3R/ZKtj1Mc2rs3+vUl5Bguax/OuM+QU3Gp78XFHRUX+BR7Nz1i2Oe6WYl3bNyJlua
	7v06uPRIRGDJxLMLz4gf+7X+StPOP1f257t9+vB4VsaDhpBFKu4RUsfzH25LD+JS//vO6PYG
	D+Ul4SsFPk04VBhuNNnbS1Gg6LiBwJ3nDVc9907/cM5D6btaOmtDTvCzCDv1a19rJ3KEd00O
	FN//tOCqRJ7OpbsSSizFGYmGWsxFxYkABI7Wq/MCAAA=
X-CMS-MailID: 20240627105404epcas5p334c7c5bd3aee98b58e60ac1008c863be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240627105404epcas5p334c7c5bd3aee98b58e60ac1008c863be
References: <20240627104552.11177-1-kundan.kumar@samsung.com>
	<CGME20240627105404epcas5p334c7c5bd3aee98b58e60ac1008c863be@epcas5p3.samsung.com>

Added new bio_add_hw_folio() function. This is a prep patch.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c | 33 ++++++++++++++++++++++++++++-----
 block/blk.h |  4 ++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e9e809a63c59..6c2db8317ae5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -979,6 +979,31 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page)
+{
+	struct folio *folio = page_folio(page);
+	size_t folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
+			       offset;
+
+	return bio_add_hw_folio(q, bio, folio, len, folio_offset, max_sectors,
+				same_page);
+}
+
+/**
+ * bio_add_hw_folio - attempt to add a folio to a bio with hw constraints
+ * @q: the target queue
+ * @bio: destination bio
+ * @folio: folio to add
+ * @len: vec entry length
+ * @offset: vec entry offset in the folio
+ * @max_sectors: maximum number of sectors that can be added
+ * @same_page: return if the segment has been merged inside the same folio
+ *
+ * Add a folio to a bio while respecting the hardware max_sectors, max_segment
+ * and gap limitations.
+ */
+int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
+		struct folio *folio, size_t len, size_t offset,
+		unsigned int max_sectors, bool *same_page)
 {
 	unsigned int max_size = max_sectors << SECTOR_SHIFT;
 
@@ -992,8 +1017,8 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
-		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
-				same_page)) {
+		if (bvec_try_merge_hw_page(q, bv, folio_page(folio, 0), len,
+					   offset, same_page)) {
 			bio->bi_iter.bi_size += len;
 			return len;
 		}
@@ -1010,9 +1035,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 			return 0;
 	}
 
-	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, offset);
-	bio->bi_vcnt++;
-	bio->bi_iter.bi_size += len;
+	bio_add_folio_nofail(bio, folio, len, offset);
 	return len;
 }
 
diff --git a/block/blk.h b/block/blk.h
index d0a986d8ee50..8c27fd7cc6de 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -529,6 +529,10 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
+int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
+		struct folio *folio, size_t len, size_t offset,
+		unsigned int max_sectors, bool *same_page);
+
 /*
  * Clean up a page appropriately, where the page may be pinned, may have a
  * ref taken on it or neither.
-- 
2.25.1

