Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A275839EB
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529055; cv=none; b=IYhfiqTSfuFtg8Sbe6W5vJN+lm8WvFP7OdLjgjMV2Ar6ajWuWpahJufsBu4iEOifL+Kv4F6OH7830ASCkN5LgvDRdtoxgomGF4VhVljaHKZrbD31aCH7q5queW23VsVjWmFE+96D+5gYjilHZlemay+3xCIr0vkw7mtNLxrOO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529055; c=relaxed/simple;
	bh=0HvIKaty/N2RAkLi49zYG/BrRTxs0mBwMCqYmKhKkfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=fSaZ3Nq4WaXbMLHwrmqSV+ZGen1rNvA+a9NUbDb7+CiIamV4yWPH3ly71Xi9M+3i9rq8dU+UiiAKnH9lTzr+wS4XumN4ib/2UX1JvWrW21tUp5cHr9IvrKvqKe71WaO1+UGIhO+sY0S454lriew4ef7IHHDewxrc7RVr2HN83Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=igcMBRbm; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="igcMBRbm"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240419121723epoutp020d986a4f8b079b1899bb6d9b4669e819~HrZYblN6Y3188331883epoutp02w
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 12:17:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240419121723epoutp020d986a4f8b079b1899bb6d9b4669e819~HrZYblN6Y3188331883epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713529043;
	bh=RzkN3WpZpiwXjv0tSzixEdQRi6amTB0xy726cMEDjC0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=igcMBRbmhF6vOm7HbxU2nTcRPoQZJHIyOypFIhTDZ23El4zMN9jAV3PgzkDtPUtze
	 lG6OkUljc9qNwjB+oiKr4Yr84Z1HNbsyfZ1t6/v1KZVh8Xh8bo1cu3yfXwCeDOfsqD
	 /ZRsBIrnA9dQIjIII4ldFuF55d1lbYrvUgm7D4oM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240419121723epcas5p28fb77ebcccd5af441931d6ae32ff3395~HrZYDD07o1214112141epcas5p2h;
	Fri, 19 Apr 2024 12:17:23 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VLYYY2VKJz4x9Pp; Fri, 19 Apr
	2024 12:17:21 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.A5.09666.1D062266; Fri, 19 Apr 2024 21:17:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0~HpCaQiZY73135931359epcas5p4u;
	Fri, 19 Apr 2024 09:24:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240419092428epsmtrp2d3d2882f0c95c82883d0e00b5232d8cc~HpCaPzIgV1454814548epsmtrp2g;
	Fri, 19 Apr 2024 09:24:28 +0000 (GMT)
X-AuditID: b6c32a49-f53fa700000025c2-21-662260d156de
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.4E.08924.C4832266; Fri, 19 Apr 2024 18:24:28 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240419092426epsmtip27de0c71b9150eceaa55b44e77f4cea41~HpCYf1w6Y1602816028epsmtip2o;
	Fri, 19 Apr 2024 09:24:26 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH] block : add larger order folio size instead of pages
Date: Fri, 19 Apr 2024 14:47:21 +0530
Message-Id: <20240419091721.1790-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmhu7FBKU0g81veSyaJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFlu/fGW12HtL2+LGhKeMFtt+z2e2+P1jDpsDt8fmFVoe
	l8+Wemxa1cnmsftmA5tH35ZVjB6fN8kFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
	6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
	KTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7YsOkGY8Fb4YrFm84zNjBu4+9i5OSQEDCRmPlk
	EhuILSSwm1Fiw1P/LkYuIPsTo8TUM8eZIJxvjBJbjt9ih+nYfPErK0THXkaJewtiIYo+M0qs
	nrWepYuRg4NNQFfiR1MoSI0IUP3LlbcZQWqYBc4ySpyY+ogFJCEs4CoxYdZHMJtFQFXi4rY9
	YGfwCthI/Pi7DWqZvMTMS9/ZIeKCEidnPgGrZwaKN2+dzQwyVELgK7vEh00/2EAWSwi4SJzu
	4YHoFZZ4dXwL1Bwpic/v9rJB2NkShxo3MEHYJRI7jzRA1dhLtJ7qZwYZwyygKbF+lz5EWFZi
	6ql1TBBr+SR6fz+BauWV2DEPxlaTmPNuKguELSOx8NIMqLiHRNPnbSyQsIqV+N3+l3ECo/ws
	JN/MQvLNLITNCxiZVzFKphYU56anFpsWGOallsOjNTk/dxMjOIVqee5gvPvgg94hRiYOxkOM
	EhzMSiK8ZhyKaUK8KYmVValF+fFFpTmpxYcYTYFBPJFZSjQ5H5jE80riDU0sDUzMzMxMLI3N
	DJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYJKcqjO1RHSvdSSz+3SXuTsfzn3Y23aQdaq9
	36oLn13s//monme6wWiyjGP7tVyJhZwsbYnLl8866XT2gKQA41+TQ9P3epzpsp43XdZ4IweX
	9JppYVuCGZzYn7Xefl46R7Rz4XVp7lPVwXmy60xVrqhYvzy1coOumOGSffJZ/1bUaXZPe9Ob
	+V8x7VfMk2mTGB4zH/rMd5ojeJqlZym3gueCqLvfEw5JevD13bHRtmT4fqaYaUqItWH7wvTr
	/AlXlTLWVx34rz2pJPlv7q/zNhJfEt5zVFjdkF1QfGGC5b3Nmq8vN5nqL32w8MOeCSfls5VU
	807Y9ArKPWBaY6+jEp4SpHk8RO/2HvfJC9ZVNSixFGckGmoxFxUnAgDiIf51KgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSvK6PhVKawY+NahZNE/4yW6y+289m
	8X17H4vFzQM7mSxWrj7KZHH0/1s2i61fvrJa7L2lbXFjwlNGi22/5zNb/P4xh82B22PzCi2P
	y2dLPTat6mTz2H2zgc2jb8sqRo/Pm+QC2KK4bFJSczLLUov07RK4MjZsusFY8Fa4YvGm84wN
	jNv4uxg5OSQETCQ2X/zK2sXIxSEksJtRoqe9nxUiISOx++5OKFtYYuW/5+wQRR8ZJRa+O8bY
	xcjBwSagK/GjKRSkRkTAQuJ583ImkBpmgeuMEjemb2UGSQgLuEpMmPWRBcRmEVCVuLhtDxuI
	zStgI/Hj7zZ2iAXyEjMvfWeHiAtKnJz5BKyeGSjevHU28wRGvllIUrOQpBYwMq1ilEwtKM5N
	zy02LDDMSy3XK07MLS7NS9dLzs/dxAgOaS3NHYzbV33QO8TIxMF4iFGCg1lJhNeMQzFNiDcl
	sbIqtSg/vqg0J7X4EKM0B4uSOK/4i94UIYH0xJLU7NTUgtQimCwTB6dUA9MM7e/ngoNrWWL0
	LHcmv2e/x7frzKOOhmVLLjwrfB6gwJofcf6J+p19E/ed21NXXf9wvcW6z9f5jp8xLTOc9LPo
	D7vGZbWlBayrN77z1lzItem7M79riEuwQ9nTa/pXok9JPl2bsXxR5aw9dxOk36h97Eo011iX
	V3jm2WTFKVyXDuetuGHmH/fluWp/3LHatI3b9mV7rDY33mTkOfk/7878HJnJ9SKv9as3p0Wl
	yvcl7CwtTNFclD5FWv9N85SLJ23z8uQSeu3X1ItMd2bTsnrnyVM8q+vsKvbpH+aliD9qXHQz
	QsRi2poZL6O8vVbuEzzybGqCBS/3wTORp32+zZaMqJoyO22z1/n18rstHA8psRRnJBpqMRcV
	JwIAYR72cNgCAAA=
X-CMS-MailID: 20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0
References: <CGME20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0@epcas5p4.samsung.com>

When mTHP is enabled, IO can contain larger folios instead of pages.
In such cases add a larger size to the bio instead of looping through
pages. This reduces the overhead of iterating through pages for larger
block sizes. perf diff before and after this change:

Perf diff for write I/O with 128K block size:
	1.22%     -0.97%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
Perf diff for read I/O with 128K block size:
	4.13%     -3.26%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 block/bio.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 38baedb39c6f..c507e47e3c46 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1247,8 +1247,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct page **pages = (struct page **)bv;
 	ssize_t size, left;
 	unsigned len, i = 0;
-	size_t offset;
+	size_t offset, folio_offset, size_folio;
 	int ret = 0;
+	unsigned short num_pages;
+	struct folio *folio;
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
@@ -1289,16 +1291,33 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	for (left = size, i = 0; left > 0; left -= len, i++) {
 		struct page *page = pages[i];
+		folio = page_folio(page);
+
+		if (!folio_test_large(folio) ||
+		   (bio_op(bio) == REQ_OP_ZONE_APPEND)) {
+			len = min_t(size_t, PAGE_SIZE - offset, left);
+			if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+				ret = bio_iov_add_zone_append_page(bio, page,
+						len, offset);
+				if (ret)
+					break;
+			} else
+				bio_iov_add_page(bio, page, len, offset);
+		} else {
+			/* See the offset of folio and the size */
+			folio_offset = (folio_page_idx(folio, page)
+					<< PAGE_SHIFT) + offset;
+			size_folio = folio_size(folio);
 
-		len = min_t(size_t, PAGE_SIZE - offset, left);
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			ret = bio_iov_add_zone_append_page(bio, page, len,
-					offset);
-			if (ret)
-				break;
-		} else
-			bio_iov_add_page(bio, page, len, offset);
+			/* Calculate the length of folio to be added */
+			len = min_t(size_t, (size_folio - folio_offset), left);
+
+			num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
 
+			bio_iov_add_page(bio, page, len, offset);
+			/* Skip the pages which got added */
+			i = i + (num_pages - 1);
+		}
 		offset = 0;
 	}
 
-- 
2.25.1

