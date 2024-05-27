Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D81E28684
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799587; cv=none; b=F6gzP6rkonWOeSaH2tB4OFnq9YySswE33hoDes5hTGcOK2DfgaG8KpP7kD+Kp9UVXFKkBguVKoYM3GAqHKvspv9/es2CGo2ggsZ/gpzhkEZQaI6nfD3klR2UouSQSGpzV0Jh8bKkMdh764yXzImnz09IZyXw2laThXJV4vR8r10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799587; c=relaxed/simple;
	bh=1TfGGOPQIJAxfW9bXXbGkAy29+61DNQCFn6EEoU1vc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=fOzXW90zvSfD+XK9qoVI5SYiJSUur6ayiiPy8fTBzJWrsPOZflcBeZQEqzm4uvrdViCYSdIFOA3TujTvToY5CEPNlsXwTlnZJRf0FvCiNMJPC3Fo86Q3ppg6hW7hWne21dz98bPJtLTyVCGIhMakcpFOqYSYbeGGmqdDdOKyZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OYyES5c1; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OYyES5c1"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240527084622epoutp0251664bfe532ff11150fef743402791d4~TTB-DQ5a71219512195epoutp028
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 08:46:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240527084622epoutp0251664bfe532ff11150fef743402791d4~TTB-DQ5a71219512195epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716799582;
	bh=wQVGpATxrdqStkwdOGFt1J4r37xmzkXgq1XbQORwUDo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=OYyES5c1nqkP+dh+Dg2rOA4nl/E0ZbI4UMZ3kXRmPPVTOcPyAtCW17RsFMsCtMJ67
	 77qPh6UUioVD6AucTXe49Y9LnaAexwTGlSZRsiPOG7ThIy9eZbrGcvVKkG9iZ2OAgq
	 ioJy0X2TyRHA0xHTThhjAW35ugiqwszLOrx/0Q+A=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240527084621epcas5p22fb6319772dabebfc723f9409a5bd8fa~TTB_rt7wO0432704327epcas5p22;
	Mon, 27 May 2024 08:46:21 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Vnq4X1Y5dz4x9QB; Mon, 27 May
	2024 08:46:20 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1F.0E.10035.95844566; Mon, 27 May 2024 17:46:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240527084541epcas5p17fa0a6ee3f53148ff0896703c58146b6~TTBZR9KYk2501925019epcas5p12;
	Mon, 27 May 2024 08:45:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240527084541epsmtrp29911fbf77cd490add8293e7885e2fe52~TTBZRJpLW1959819598epsmtrp2b;
	Mon, 27 May 2024 08:45:41 +0000 (GMT)
X-AuditID: b6c32a4b-8afff70000002733-9f-66544859fb86
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	60.D9.08336.53844566; Mon, 27 May 2024 17:45:41 +0900 (KST)
Received: from testpc11818.samsungds.net (unknown [109.105.118.18]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240527084540epsmtip2a05b7057b1a6b4748ceab0bb9460fcc9~TTBYN4CjE1034210342epsmtip2Q;
	Mon, 27 May 2024 08:45:40 +0000 (GMT)
From: hexue <xue01.he@samsung.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hexue
	<xue01.he@samsung.com>
Subject: [PATCH v2] block: delete redundant function declarations
Date: Mon, 27 May 2024 16:45:33 +0800
Message-Id: <20240527084533.1485210-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmum6kR0iawadeDovVd/vZLH5132W0
	2HtL2+LyrjlsFmcnfGC16Lpwis2BzePy2VKPvi2rGD0+b5ILYI7KtslITUxJLVJIzUvOT8nM
	S7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB2qqkUJaYUwoUCkgsLlbSt7Mpyi8t
	SVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM44c3M6c8En1orVt3+xNTD+
	Zuli5OSQEDCRmLvyE5DNxSEksJtR4v6hK6wgCSGBT4wSv2cWQyS+MUrM3b+DGabjyN4DzBCJ
	vYwSS59/Y4JwfjBK7Dw4BWwum4CSxP4tHxhBbBEBYYn9Ha1gcWaBWImjyx6AxYUFHCWud+1n
	A7FZBFQlZrfsBovzClhLrPt3BmqbvMTNrv3MEHFBiZMzn0DNkZdo3job7AoJgU3sEj9mtjFC
	NLhILF62jx3CFpZ4dXwLlC0l8fndXjYIO19i8vf1UPU1Eus2v4MGhrXEvyt7gGwOoAWaEut3
	6UOEZSWmnlrHBLGXT6L39xMmiDivxI55MLaSxJIjK6BGSkj8nrCIFcL2kNjx7AYzJEhjJfb9
	62GfwCg/C8k7s5C8Mwth8wJG5lWMkqkFxbnpqcWmBcZ5qeXwiE3Oz93ECE58Wt47GB89+KB3
	iJGJg/EQowQHs5IIr8i8wDQh3pTEyqrUovz4otKc1OJDjKbAMJ7ILCWanA9MvXkl8YYmlgYm
	ZmZmJpbGZoZK4ryvW+emCAmkJ5akZqemFqQWwfQxcXBKNTA5bHv6jretSXLy388vFt0qPHub
	73OWoOayWIut5xmLDvCuuqt0cdualounZHcK5If8nsYVXKY7eUXd/TRW/9yg3Vr2Ofp3vhQG
	PSnc6du86+zNwERJ1bu90ZoTHiat5Ww3YoyxahXjf+pxv/ZFnNfz+0tSroUE38l3UDye4CEf
	l+DPLsZZFyzSvinqirrBtiMenIlS8fKikj8u77o/S+yLTyPP+7s7eKryTu0r2XWrK3vRmwNh
	k//dSJtVoX9cuLbyRPfjgAsSibvni5wSrjsstHNObWnN3+qjbr6H3S9lepzYL9/gnhoQrRK4
	5kbs+q3HZ0fI9rRnLyiM55t8Say0rzmVy3tv3lrDdmexSUosxRmJhlrMRcWJAA8k0ysFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSvK6pR0iawaH56har7/azWfzqvsto
	sfeWtsXlXXPYLM5O+MBq0XXhFJsDm8fls6UefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlXHm
	5nTmgk+sFatv/2JrYPzN0sXIySEhYCJxZO8B5i5GLg4hgd2MEvfPXGGFSEhI7Hj0B8oWllj5
	7zk7RNE3RomOV4fYQBJsAkoS+7d8YASxRYCK9ne0gk1lFoiXuDT1PDOILSzgKHG9az9YPYuA
	qsTslt1g9bwC1hLr/p1hhlggL3Gzaz8zRFxQ4uTMJ1Bz5CWat85mnsDINwtJahaS1AJGplWM
	kqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFBqKW5g3H7qg96hxiZOBgPMUpwMCuJ8IrM
	C0wT4k1JrKxKLcqPLyrNSS0+xCjNwaIkziv+ojdFSCA9sSQ1OzW1ILUIJsvEwSnVwJT8muHf
	pLyPE3r+sk7pTO1Zppz2OYt38f5km6bnpX4XhaMZZt8XPWXhN+3xG4tzDRdfefGcsHAIuvrN
	2+TBw7bUnHnXHkoHNRQevbbtfwLLKy6f0y8ledZ67ODcq+XLUf8ovm1Oto/sSYMw3qNP7bpm
	Vpct3Vw+MWP18T3pnHdYFqr4nnSK3q5bo9Nxdo7j+ofbxPJyPzvItrkvtDav9ZGM31twq7r8
	772Ft9I3LY8S28kb+HPevP2Oi9uc+q7uSn6fMs/bkPn4447PD/R8tJbybRd9whHQUXBb5Hfc
	v/0nDn3nlrQ7waZy59/aGfF/7dK0uNqNzEy+u+VtruN8+4s3P2P7Ww9PtrpTB2cwOiqxFGck
	GmoxFxUnAgBkR5LSsQIAAA==
X-CMS-MailID: 20240527084541epcas5p17fa0a6ee3f53148ff0896703c58146b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240527084541epcas5p17fa0a6ee3f53148ff0896703c58146b6
References: <CGME20240527084541epcas5p17fa0a6ee3f53148ff0896703c58146b6@epcas5p1.samsung.com>

blk_stats_alloc_enable is used in block hybrid poll, the related function
definitions have been removed by patch:
commit 54bdd67d0f88 ("blk-mq: remove hybrid polling")
but the function declaration was not deleted.

Signed-off-by: hexue <xue01.he@samsung.com>
---
 block/blk-stat.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-stat.h b/block/blk-stat.h
index 17e1eb4ec7e2..5d7f18ba436d 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -64,7 +64,6 @@ struct blk_stat_callback {
 
 struct blk_queue_stats *blk_alloc_queue_stats(void);
 void blk_free_queue_stats(struct blk_queue_stats *);
-bool blk_stats_alloc_enable(struct request_queue *q);
 
 void blk_stat_add(struct request *rq, u64 now);
 
-- 
2.40.1

