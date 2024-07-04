Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298A18637
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080133; cv=none; b=aS+knk05RwwkcHs2Q/AgIf+L5YiGcSBsqqvtg1HyT27CfNQAU5zMqkcKtj9kMNsnJe9TNXrvX1EWwAFU3oroL6y87shLDKQs7aTfEUtHaDe4KrCm8UvmI2XI7nvndPYaLejIuC6oEEFXW6e45aO8+kNi4aFeGrejl8wAsBk+Xis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080133; c=relaxed/simple;
	bh=RUPBTsuCCMz3bH/NxphWPI4KU8Jh6d2AesWl/vnCbno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=pm7RDCosIZYWUW8OnX1YrzUcJ+a87MI4dU8lLpC7bLL5oiu1Ri3UUZYrC5hA/0h3zja1jGYHyucl/xfamZh6nG7rlmKJ+hheg7GwtjYQK+WzTTawnxuUAPWYQgLCUGPOkivvnZ6q3qdloHJA5Yji/RWuLvhx/xk+Wr6M19bym60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=po2CGivw; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="po2CGivw"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240704080208epoutp020dcf16bd25c10b82f2391f9d7cf1ed04~e88N8qpwc2819828198epoutp02N
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:02:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240704080208epoutp020dcf16bd25c10b82f2391f9d7cf1ed04~e88N8qpwc2819828198epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720080128;
	bh=C3COj6yzvcsM80qGx7kwUsuNpzi9iGWUY6hjfKEM+vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=po2CGivwiuxO+64741eB7UY+H9AVDN6vyVFa0vOF+McdL2PbHJ+4mxGXQNq2Awn76
	 GkiLbfh+q+aJwNsapPVvDfddrN5Rf9jcNm86dj2yBj/nQfUSDAGSrvqJLpO8r4f3Oo
	 iQ7mwk0HFFae0nGYORvkjQk4YWRKxhdjU420qfRs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240704080207epcas5p4d3f9da8ae6311826ca69191d24fa2934~e88NMQbEU1450214502epcas5p4h;
	Thu,  4 Jul 2024 08:02:07 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WF8Hx4v5Cz4x9Pt; Thu,  4 Jul
	2024 08:02:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	85.B7.09989.AF656866; Thu,  4 Jul 2024 17:02:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240704071126epcas5p2572342c5d25c3292a9a39cb8c798a42c~e8P8grwLG3204032040epcas5p2q;
	Thu,  4 Jul 2024 07:11:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240704071126epsmtrp1a6fec1ee346bd33da9604e91282ecfc3~e8P8fMD_O0702607026epsmtrp1S;
	Thu,  4 Jul 2024 07:11:26 +0000 (GMT)
X-AuditID: b6c32a4a-e57f970000002705-fe-668656fa7ff6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.C8.19057.E1B46866; Thu,  4 Jul 2024 16:11:26 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240704071123epsmtip2092a1d540d185f03192f077640be5e42~e8P6KfB9a1296012960epsmtip2K;
	Thu,  4 Jul 2024 07:11:23 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH v7 2/4] block: Added folio-lized version of
 bio_add_hw_page()
Date: Thu,  4 Jul 2024 12:33:55 +0530
Message-Id: <20240704070357.1993-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704070357.1993-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmuu6vsLY0g1UdlhZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PgjJ2sBVvEKh5PnsTWwNgh1MXIySEh
	YCLR33SftYuRi0NIYDejxOedf1hBEkICnxgl7m4QgEh8Y5RoavjGDtPx4fRvqKK9jBLrjnJB
	FH1mlJh3YhVQEQcHm4CuxI+mUJAaEQF3iakvHzGC1DALnGWUODH1EQtIQljAX+LvwblsIDaL
	gKrEicV7mUBsXgEbie4tF1gglslLzLz0HWwxp4CtRMevaYwQNYISJ2c+AathBqpp3jqbGWSB
	hMBEDomlGy+zQjS7SMyc2s4GYQtLvDq+BeoDKYmX/W1QdrbEocYNTBB2icTOIw1QcXuJ1lP9
	zCDPMAtoSqzfpQ8RlpWYemodE8RePone30+gWnkldsyDsdUk5rybCnW/jMTCSzOg4h4S1/4+
	YocE1gRGifPN79knMCrMQvLPLCT/zEJYvYCReRWjZGpBcW56arFpgVFeajk8kpPzczcxghOt
	ltcOxocPPugdYmTiYDzEKMHBrCTCK/W+OU2INyWxsiq1KD++qDQntfgQoykwwCcyS4km5wNT
	fV5JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUzr86rvpL+eMOem
	meOU06fXGh9YVP8j/7lzh98dDfeX355WpUSxn64TiJOSdTolaPZo2cZHxjqB/kwBvQeFpQsZ
	RCs+HF+ZLaq2/9un4Jy2CX8PcOa4BWy/FvLdZ4p8yNoFCd36f34smyTT1hXQPs37kcGPHVp1
	M3l7njdp6Gxx255k0MG7R//6Kfln09e+C1yQ4TddusP/qcnUKAG7oxOWn5+d0sp0++J/zmeZ
	y5XYH1aFHHx5UyX9/trOO0/mLC5pKP+qbHU+sJpL9uxRCb7t8U0bzGtcttdy/Da+8DbUa3F8
	wKKI+4vOzq/T5Fl4/Or37zmn5tk67ZDg3Skcfm9j7tPt87QPvVTrtbFvffxViaU4I9FQi7mo
	OBEAxyrnVD0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSvK6cd1uawYoHrBZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i0mHrjFabP3yldVi7y1tixsTnjJabPs9n9ni9485bA48
	HptXaHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVcXDGTtaCLWIV
	jydPYmtg7BDqYuTkkBAwkfhw+jcriC0ksJtRYuanYoi4jMTuuztZIWxhiZX/nrN3MXIB1Xxk
	lDh6aBmQw8HBJqAr8aMpFKRGRMBXYsGG54wgNcwC1xklbkzfygySEAZKLL18gw3EZhFQlTix
	eC8TiM0rYCPRveUCC8QCeYmZl76zg9icArYSHb+mMUIcZCNx7+Z5Foh6QYmTM5+A2cxA9c1b
	ZzNPYBSYhSQ1C0lqASPTKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4FjQ0trBuGfV
	B71DjEwcjIcYJTiYlUR4pd43pwnxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7
	NbUgtQgmy8TBKdXApDtXg83AcOdu10ivPdHnzp0Xvhb2IcWsxmb5U4ef238zMS/wNp7NaPpd
	4OhW9e7yZRPLBOwlrx05dulIXYTglGfJq3LNTN7cXychq71De0/Ayb2S/i6JLZp+CSv/Rzzx
	SS/VTdGX9vy5sFiu0u7vU9aaGf+UNtu/nGe5S/ygweHF0fkvr2yx+/OmhH+v53MHhkVRxiX7
	zrELClvEV4nadJ8wln/rcbLPeM5tg/YDHFwXl7JGJP1PqH31wvqBwKu9N75tKpTZ+GFSbGjN
	1YqFYpYfHqx+tvfNZf9FbRM5NvqWrD1n/eDI15kReoXvzz8y2dbiHpkYM3tqqZ5ZlUGSoJnF
	/Iv7l3ctEenJV+QxVWIpzkg01GIuKk4EANRWPm30AgAA
X-CMS-MailID: 20240704071126epcas5p2572342c5d25c3292a9a39cb8c798a42c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240704071126epcas5p2572342c5d25c3292a9a39cb8c798a42c
References: <20240704070357.1993-1-kundan.kumar@samsung.com>
	<CGME20240704071126epcas5p2572342c5d25c3292a9a39cb8c798a42c@epcas5p2.samsung.com>

Added new bio_add_hw_folio() function. This is a prep patch.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c | 32 +++++++++++++++++++++++++++-----
 block/blk.h |  4 ++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c10f5fa0ba27..05d624f016f0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -996,6 +996,30 @@ bool bvec_try_merge_hw_folio(struct request_queue *q, struct bio_vec *bv,
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page)
+{
+	struct folio *folio = page_folio(page);
+
+	return bio_add_hw_folio(q, bio, folio, len,
+			((size_t)folio_page_idx(folio, page) << PAGE_SHIFT) +
+			offset, max_sectors, same_page);
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
 
@@ -1009,8 +1033,8 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
-		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
-				same_page)) {
+		if (bvec_try_merge_hw_folio(q, bv, folio, len, offset,
+					    same_page)) {
 			bio->bi_iter.bi_size += len;
 			return len;
 		}
@@ -1027,9 +1051,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 			return 0;
 	}
 
-	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, offset);
-	bio->bi_vcnt++;
-	bio->bi_iter.bi_size += len;
+	bio_add_folio_nofail(bio, folio, len, offset);
 	return len;
 }
 
diff --git a/block/blk.h b/block/blk.h
index 17478657c5ef..0c8857fe4079 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -534,6 +534,10 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
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

