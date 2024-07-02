Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA450200A9
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920299; cv=none; b=eUZPmpx3YiG+WfBJT3RT9Al+yRs8FvWGYbohPKP16hGqASKNFyrytbkf1GykSP3ANrHoQxxRijM9VMHN9zJ5c5RKexqfDsCKHq7ZYKEW+g9GDbQ5AUWfATy23AZn9ZwUL68atW53rN03Voxjk4rg9eihKkeG70OT5iRHZEb7DWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920299; c=relaxed/simple;
	bh=1uDkxv9daYSuVmkrYhsthvmuV6Aki8PHutQ1jOwgfDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=t+4M+EzPPk7GB5zjbU/wcqwz4NxdpRcQSwvnJYz/Hwy+icB+hD+9gd5g2Lv/Dp5W6ea82tzNv0jmBjbP4zOFHK90tXdaUwZe8Ra81a7XIPA0MTJG4MX/LMz6YdZpg/SK6ISMVVQOM/Za240fUUSYrCUL0TywnrQksKrtzL2XcVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WcjM5ZyV; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WcjM5ZyV"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240702113809epoutp02dee63f5c90da68c41a261e0bdb6292c1~eYmPsAew82770427704epoutp02F
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 11:38:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240702113809epoutp02dee63f5c90da68c41a261e0bdb6292c1~eYmPsAew82770427704epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719920289;
	bh=iQzYuDQ4SIKZGQgqCoimg/bdqvm2vf5CbeMF5l77MPw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=WcjM5ZyVMIqDYcIIeCq1JkkuDnyyD3lkZ6h49WzMPJKJ9m2d2v9xZ3kNxhFBZUX0F
	 tp7ZVI49N0H+YAIljEG8LUva3fmpnmy1g88rCiOP++PqaWJsstUfItKN2OLT2oCWub
	 oy/SGQeBb95AxI34kM9UWibUnsDcZMm62YPAkfpA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240702113808epcas5p437f5930aab5e182b5bf58b88c768efa7~eYmPap0It0054000540epcas5p40;
	Tue,  2 Jul 2024 11:38:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WD1B706fvz4x9Pt; Tue,  2 Jul
	2024 11:38:07 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	43.19.11095.E96E3866; Tue,  2 Jul 2024 20:38:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240702101517epcas5p3f651d9307bab6ece4d3e450ed61deb82~eXd5v_smP1123511235epcas5p3K;
	Tue,  2 Jul 2024 10:15:17 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240702101517epsmtrp2963b6a79d7928d4fa307f4edf9b251eb~eXd5vWoJR1129911299epsmtrp2-;
	Tue,  2 Jul 2024 10:15:17 +0000 (GMT)
X-AuditID: b6c32a49-423b770000012b57-14-6683e69e25ea
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	8F.63.18846.533D3866; Tue,  2 Jul 2024 19:15:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240702101516epsmtip26a9712122d80529936a15fc36a9bc1be~eXd40UL_22519925199epsmtip2I;
	Tue,  2 Jul 2024 10:15:16 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	joshi.k@samsung.com
Cc: linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH] block: reuse original bio_vec array for integrity during
 clone
Date: Tue,  2 Jul 2024 15:37:53 +0530
Message-Id: <20240702100753.2168-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmlu68Z81pBu3dphZNE/4yW6y+289m
	sXL1USaLo//fslnsvaVtsfz4PyYHNo/LZ0s9dt9sYPP4+PQWi0ffllWMHp83yQWwRmXbZKQm
	pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDtV1IoS8wpBQoF
	JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ8z7c42l
	YBFXxfnjW5kaGLdzdDFyckgImEjcWrSLvYuRi0NIYDejxNvlu5ghnE+MEh2z37PBOb9fz2KD
	aZnZc4YJIrGTUWLXpgtQVZ8ZJY6dnsAOUsUmoC5x5HkrYxcjB4eIQJBE8x4PkDCzgJPElJMN
	zCC2sECgxMVbp5lASlgEVCX6f9iAhHkFLCRObT/CCrFLXmLmpe/sEHFBiZMzn7BAjJGXaN46
	G+xSCYFd7BIP37xih2hwkTiwvZsRwhaWeHV8C1RcSuLzu71QD6RL/Lj8lAnCLpBoPrYPqt5e
	ovVUPzPIPcwCmhLrd+lDhGUlpp5axwSxl0+i9/cTqFZeiR3zYGwlifaVc6BsCYm95xqgbA+J
	K6eOga0VEoiV+DFzF9sERvlZSN6ZheSdWQibFzAyr2KUTC0ozk1PLTYtMMxLLYfHa3J+7iZG
	cCrU8tzBePfBB71DjEwcjIcYJTiYlUR4A3/VpwnxpiRWVqUW5ccXleakFh9iNAUG8URmKdHk
	fGAyziuJNzSxNDAxMzMzsTQ2M1QS533dOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgWnbTXm+svKD
	t1qZrbTWHq/3+nv1hfS1wOVHe47dCAja+u3y9oiOmaeffUu4tHDRXYUp3Mk/tm/ybzZp/rXm
	pv4EBq8vveo7nW4cqLh2r0Rt+s8mtu/OrNv7mPvkaqdOaV2w/dvXhIVRDdNnt33RtA1b8l5t
	w7ZNru//9H8VcLH+XL44iDf6U8cRg3Nn9M6+uhJ3YfZm5wknm7s8c6t/rw9MvBJw3+ZT1mE9
	4+NKU3hC77Gu99ptnPmKc4WT+bK7jipa7/cz9Ymtt7mRd8M6fkfqzGdHZpS5p3Hc4pALizny
	fA3/7a8ZcyYrCd4uqYvbu+rxxDV3jXaltzu+Oflt2g+PLc5Wom3V/JxP+OMnXA55rsRSnJFo
	qMVcVJwIAPU0J4MOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSvK7p5eY0g74PyhZNE/4yW6y+289m
	sXL1USaLo//fslnsvaVtsfz4PyYHNo/LZ0s9dt9sYPP4+PQWi0ffllWMHp83yQWwRnHZpKTm
	ZJalFunbJXBlzPtzjaVgEVfF+eNbmRoYt3N0MXJySAiYSMzsOcMEYgsJbGeUmPKKGyIuIXHq
	5TJGCFtYYuW/5+wQNR8ZJW63WIHYbALqEkeet4LViAiESfz/ORushlnAReL+2k6wuLCAv8Sb
	nzNZuhg5OFgEVCX6f9iAhHkFLCRObT/CCjFeXmLmpe/sEHFBiZMzn7BAjJGXaN46m3kCI98s
	JKlZSFILGJlWMYqmFhTnpucmFxjqFSfmFpfmpesl5+duYgSHolbQDsZl6//qHWJk4mA8xCjB
	wawkwhv4qz5NiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1Oq
	gamyPjdjyXJdaWHZ/zd0F/aXpGzRjn58eMu7412NGYzvJAwTty/ddnDx3spn232nuCxKcl3o
	9VsxQD5potAPD0MVE73l0TPPPVyT3H/u1O/w2qrJ67ZE2pXsz4+pm1Yd2+PAyMbSG/n/rHb8
	q3wO+1erHylbCzzN6VzNWXNa5MkmTRO7YwtPTrT0vh4cwH7WRcVFYXX6lulVXC+P/JN8cr66
	uOWzfOVeNa15AY1lLXkPt8vumMy3d/Lvp8dmMTjW2e1/FftatKzx1MZdUjNXZz+cb6AfUj5h
	eX7W8zP260Ln8/yXjdZcEFL6XPVQtWE968ICE0+mv0pLvgvcrphjb9Jj+Up+DqPpp7dz+8rL
	TyqxFGckGmoxFxUnAgD1Jd8VtAIAAA==
X-CMS-MailID: 20240702101517epcas5p3f651d9307bab6ece4d3e450ed61deb82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702101517epcas5p3f651d9307bab6ece4d3e450ed61deb82
References: <CGME20240702101517epcas5p3f651d9307bab6ece4d3e450ed61deb82@epcas5p3.samsung.com>

Modify bio_integrity_clone to reuse the original bvec array instead of
allocating and copying it, similar to how bio data path is cloned.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio-integrity.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index c4aed1dfa497..b78c145eb026 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -76,7 +76,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 					  &bip->bip_max_vcnt, gfp_mask);
 		if (!bip->bip_vec)
 			goto err;
-	} else {
+	} else if (nr_vecs) {
 		bip->bip_vec = bip->bip_inline_vecs;
 	}
 
@@ -584,14 +584,11 @@ int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 
 	BUG_ON(bip_src == NULL);
 
-	bip = bio_integrity_alloc(bio, gfp_mask, bip_src->bip_vcnt);
+	bip = bio_integrity_alloc(bio, gfp_mask, 0);
 	if (IS_ERR(bip))
 		return PTR_ERR(bip);
 
-	memcpy(bip->bip_vec, bip_src->bip_vec,
-	       bip_src->bip_vcnt * sizeof(struct bio_vec));
-
-	bip->bip_vcnt = bip_src->bip_vcnt;
+	bip->bip_vec = bip_src->bip_vec;
 	bip->bip_iter = bip_src->bip_iter;
 	bip->bip_flags = bip_src->bip_flags & ~BIP_BLOCK_INTEGRITY;
 
-- 
2.25.1

