Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BBAEACE
	for <linux-block@vger.kernel.org>; Tue,  1 Apr 2025 04:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743483430; cv=none; b=pBjD4TjKnNvggRpYyhOssvsdb/kFrpT0qz/HWK1EnJrPIRR2H/ZNXBYNKgONYpVsb8whWuXB4bn6uFbATyy2kbJksfavFqYsImJPm5yPfWUMw05BNH1wJMPpXy49uAiFRJZZSY4U7xZi0O+ceGRkwcy6FOP8FHGrY2RX+OR/Ws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743483430; c=relaxed/simple;
	bh=qnYgWrD2Wju8aW8wo2RjMKGRXIT97J+roFA8SXksdAk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=BvDcb294C5nvremW4jN7rYhABtMR3XKmroy73GDVcCy9m7lhIjEUrmhKIaWlbDL1JlFse+IsJAJ3WfWGCvSRTIeQ4yngTn4a7rvGW3pV++QXtX3d2mOuOE/GUNJjrfY9CXAdakpvfES8AkfKujy+QdwUpXs6ONR2auH9GuQY3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TFPsURDg; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TFPsURDg"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250401045658epoutp021f65243fe25d9b8987aba612310bbe75~yGO6HFge83008530085epoutp02T
	for <linux-block@vger.kernel.org>; Tue,  1 Apr 2025 04:56:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250401045658epoutp021f65243fe25d9b8987aba612310bbe75~yGO6HFge83008530085epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1743483418;
	bh=5+9ZbOoug1XdAoMWkPai1W3CpmGY96zj5C7fW1Y95lw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=TFPsURDgbRUESlllUcs05onJG/AHELSUmiY1Lum8BFhBo25Z1x8I95qj1sTmMEDv+
	 h0urWEKnklokdEBnQFwu0H2aFS+Lg38LoSqDiKoOjhSpfsrqkC5DWpAnDqEnmXk5IW
	 jyblXohExRlFXqFP2JxAhH8dtS+wTtYbLj1NKsaA=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250401045657epcas5p412ae99a12d33b31423753a026716fb2d~yGO5mTYfM1515815158epcas5p4y;
	Tue,  1 Apr 2025 04:56:57 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4ZRbMD2KyPz3hhT7; Tue,  1 Apr
	2025 04:56:56 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AC.5A.09853.4127BE76; Tue,  1 Apr 2025 13:56:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250401045256epcas5p47d761c5029394f165bf39e84e1cbbbc9~yGLYqyRkG1618916189epcas5p49;
	Tue,  1 Apr 2025 04:52:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250401045256epsmtrp12a041dcf829e27fadd7ee6e51700ec0c~yGLYqM2f82635926359epsmtrp1D;
	Tue,  1 Apr 2025 04:52:56 +0000 (GMT)
X-AuditID: b6c32a4a-048e07000000267d-53-67eb72144261
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E6.C3.08766.8217BE76; Tue,  1 Apr 2025 13:52:56 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250401045255epsmtip1d9a91cd9b670faae1e94088714d7d5ae~yGLXs3te30552105521epsmtip1e;
	Tue,  1 Apr 2025 04:52:55 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: gost.dev@samsung.com, nitheshshetty@gmail.com, Nitesh Shetty
	<nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: remove unused nseg parameter
Date: Tue,  1 Apr 2025 10:13:47 +0530
Message-Id: <20250401044348.15588-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7bCmhq5I0et0g9ezlS1W3+1ns7h5YCeT
	xd5b2haXd81hs9jxpJHRYtvv+cwObB47Z91l97h8ttSjb8sqRo/Pm+QCWKKybTJSE1NSixRS
	85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAVisplCXmlAKFAhKLi5X0
	7WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjO+rtjDVLCGo+LF
	w63sDYwH2LoYOTkkBEwklve+Zuli5OIQEtjNKPHnxzdWCOcTo8Sul8vYIJxvjBIzH1xhhml5
	cnIbVNVeRonJe79DOa1MEheevwKq4uBgE9CWOP2fA6RBREBBouf3SrBJzALTGSU+LvoOtlwY
	aNKRqRPAbBYBVYnJX1tZQGxeASuJLX/WskJsk5dYveEAM0izhMA8doknn+ezQyRcJKZ+WAhV
	JCzx6vgWqLiUxMv+Nii7XGLllBVQn5ZIPP/TC2XbS7Se6gc7lFlAU2L9Ln2IsKzE1FPrmEBs
	ZgE+id7fT5gg4rwSO+bB2MoSa9YvgBojKXHteyOU7SGx4X4v2FohgViJ4w8bWCcwys5C2LCA
	kXEVo2RqQXFuemqxaYFRXmo5PKaS83M3MYKTlJbXDsaHDz7oHWJk4mA8xCjBwawkwhvx9WW6
	EG9KYmVValF+fFFpTmrxIUZTYJhNZJYSTc4Hpsm8knhDE0sDEzMzMxNLYzNDJXHe5p0t6UIC
	6YklqdmpqQWpRTB9TBycUg1M5vuZnjNlHo35X+B0Tr/7+Z66F5LPn+7dk5vUcu3EedYNFx9z
	99iXO/MkL9swNVaV4+LMQzE6pg/LgyZfnnY3vNHyQ9pGK6EF/JPXLVszVy0h6NWfg6FcfBYi
	+/cd+nlh3aaqjDj7HYJHZ28QydE/lW/XOeVK45G9C25/e53K9DGrRXN/s62C3od7D9dfzFc9
	f8qy7+jjr1yPZOaZNc34Y9Sau2tOpBLH5sXO23xzu/VP5PEsm/3telxT9OXuuOkrgwQLmGz3
	nz/6T8lb9qa+0zGLLl+F6ZIeX9UOF6+ayPqbkyUkoq9+0d+JsvdnGxbkycy67yPT7bZDZt2e
	P7+03evW/kls6rjgNzvwneWGBiWW4oxEQy3mouJEAHrT4MLbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJMWRmVeSWpSXmKPExsWy7bCSnK5G4et0g6UbRCxW3+1ns7h5YCeT
	xd5b2haXd81hs9jxpJHRYtvv+cwObB47Z91l97h8ttSjb8sqRo/Pm+QCWKK4bFJSczLLUov0
	7RK4Mr6u2MNUsIaj4sXDrewNjAfYuhg5OSQETCSenNzG2sXIxSEksJtR4vP7dYwQCUmJZX+P
	MEPYwhIr/z1nhyhqZpI43XoFqIiDg01AW+L0fw6QGhEBBYme3yvZQGqYBWYzSkzb1QXWLAy0
	4cjUCWDbWARUJSZ/bWUBsXkFrCS2/FnLCrFAXmL1hgPMExh5FjAyrGKUTC0ozk3PLTYsMMxL
	LdcrTswtLs1L10vOz93ECA4XLc0djNtXfdA7xMjEwXiIUYKDWUmEN+Lry3Qh3pTEyqrUovz4
	otKc1OJDjNIcLErivOIvelOEBNITS1KzU1MLUotgskwcnFINTNXL1c7OCq8I+Vi6QfS5uGng
	rKlLDNwNnT8wcGTUhhZOe9D8/tSicsEfIlLcr9ze7Gp7uKfqSFLrq1vfZf4X2EY5+k1ZeY9r
	3mm2Wds76+ZHh9/ZOG3LnImt3kw72c/4e9w5wb7+asPz1rN5Sg/sXPyrjp2vjEn30/D8XXnU
	iHO6UGTt8nuCjnL/Yx6uT/HWrCixNKt1MT4vUTSpNvKOXiuX2bxkrVPH8y/q2nBY71m9P+zZ
	v2jvEP1v1stbBEQmTcp6MSP+/Np76mcPJ31T3Gb8WJqHaYFJ9wFurcbuzefPtZzbNL3EdOoF
	Cw/O9cu/Ce8O2qew94yez8orNmfFqgvZ+OVuqbvF/vyhOmHvSSWW4oxEQy3mouJEADx2b5OG
	AgAA
X-CMS-MailID: 20250401045256epcas5p47d761c5029394f165bf39e84e1cbbbc9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250401045256epcas5p47d761c5029394f165bf39e84e1cbbbc9
References: <CGME20250401045256epcas5p47d761c5029394f165bf39e84e1cbbbc9@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

We are no longer using nr_segs, after blk_mq_attempt_bio_merge was moved
out of blk_mq_get_new_request.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-mq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae8494d88897..0cfd1a149f64 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2965,8 +2965,7 @@ static bool blk_mq_attempt_bio_merge(struct request_queue *q,
 
 static struct request *blk_mq_get_new_requests(struct request_queue *q,
 					       struct blk_plug *plug,
-					       struct bio *bio,
-					       unsigned int nsegs)
+					       struct bio *bio)
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
@@ -3125,7 +3124,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (rq) {
 		blk_mq_use_cached_rq(rq, plug, bio);
 	} else {
-		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
+		rq = blk_mq_get_new_requests(q, plug, bio);
 		if (unlikely(!rq)) {
 			if (bio->bi_opf & REQ_NOWAIT)
 				bio_wouldblock_error(bio);
-- 
2.43.0

