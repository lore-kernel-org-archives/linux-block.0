Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F70FBFD
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 05:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716787345; cv=none; b=hTIay39k2gKk98643nObr1fIHL0O21QJi5D7dc0LSBtuchkuHUdQkJ/DKSL/ZIkNNophZqWq+EuOGuXZzi0nBGRtjKXV19KsqJwhN0Jtaj/fVjYRl5tAYoDYQpDKlUg5ikqSrBhdsWmBAk5VSAX3fXNjiV6RPwuUw7YlKGO2oSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716787345; c=relaxed/simple;
	bh=GzrNcN+pMuO3nMQV17c8CbPgA62GGIKJYjsQXEmkLWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ZCyLSHoAjyoSVZYJ75lDH/bXyCYKO6kI/+IkG5AH4SHAwi04Q+kvqJ+jGrYD4eNxH2WiTP5gIu3ia4laUy7yYg2R5HIKWmCFOaWn9xmprDG5LA2uOYdVYupD0lPgYKO4GgU3g6S+3GKPJFogvew0Qnc11Lw9fF+TEOueZeasGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fDpBrjaN; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fDpBrjaN"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240527052219epoutp014c1adb291c06be5e4532fee68484cf84~TQP0-ABXV0230702307epoutp012
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 05:22:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240527052219epoutp014c1adb291c06be5e4532fee68484cf84~TQP0-ABXV0230702307epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716787339;
	bh=awyLAV62P7hclJArbyXEX4hZ9QRa3kG0YZKRWaBh8rM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=fDpBrjaNjg4RKsrS4C0oJtJFyNp/bvCVdxDG5FKvRW/UfSd43KHJEtQhQmpvTQUrg
	 Rw9AEA2M1CT7o12K3lUQYfRVNJ+x3SnGodpziV5t+snfDjo5c6PKiR0msWKi8iocDM
	 kWSingxhDf+qmlb8Rb4Fe3IcuZXBe9CwtF54smgc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240527052219epcas5p38280c9e2b3301ec637ac6245fc76132d~TQP0o7-Yw1654916549epcas5p3_;
	Mon, 27 May 2024 05:22:19 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VnkY518LWz4x9QB; Mon, 27 May
	2024 05:22:17 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	00.3B.10035.78814566; Mon, 27 May 2024 14:22:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240527022944epcas5p16011e653d1f770cd11bc760f39c17ad2~TN5JPSfcD2621326213epcas5p1T;
	Mon, 27 May 2024 02:29:44 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240527022944epsmtrp1dd3ed2e22fd8d71d7c406b471dd523f4~TN5JOc0VH2915229152epsmtrp16;
	Mon, 27 May 2024 02:29:44 +0000 (GMT)
X-AuditID: b6c32a4b-8afff70000002733-02-6654188746a9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	39.BD.07412.810F3566; Mon, 27 May 2024 11:29:44 +0900 (KST)
Received: from testpc11818.samsungds.net (unknown [109.105.118.18]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240527022943epsmtip122daa5729b4c5b2cbf3e1d7f6cc27ffd~TN5IYsvNE2193421934epsmtip1r;
	Mon, 27 May 2024 02:29:43 +0000 (GMT)
From: hexue <xue01.he@samsung.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	peiwei.li@samsung.com, ruyi.zhang@samsung.com, Xue He <xue01.he@samsung.com>
Subject: [PATCH] block: delete redundant function declarations
Date: Mon, 27 May 2024 10:29:26 +0800
Message-Id: <20240527022926.1331950-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmpm67REiawdP5xhar7/azWfzqvsto
	sfeWtsXlXXPYLJ7t5bT4cvg7u8XZCR9YLbounGJz4PC4fLbUo2/LKkaPz5vkApijsm0yUhNT
	UosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgNYrKZQl5pQChQIS
	i4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzVnx4x15w
	hrXi4swrLA2MV1m6GDk5JARMJI5cf83axcjFISSwm1Hi7+5HzCAJIYFPjBI/V8lCJL4xSqzr
	/sgG07H02iOojr2MEq8W9zBBOD8YJX7s72IEqWITUJLYv+UDmC0iICyxv6OVBaSIWaCXUWLj
	tLXsIAlhATuJBRu2gRWxCKhKvH0yFewoXgFriaVT1kKtk5e42bWfGSIuKHFy5hOwGmagePPW
	2cwgQyUEDrFLtDy4DvWRi8T1P3OZIWxhiVfHt7BD2FISL/vboOx8icnf1zNC2DUS6za/g+q1
	lvh3ZQ+QzQG0QFNi/S59iLCsxNRT65gg9vJJ9P5+wgQR55XYMQ/GVpJYcmQF1EgJid8TFrGC
	jJEQ8JD4+s0ZEqSxEtfWP2GfwCg/C8k3s5B8Mwth8QJG5lWMkqkFxbnpqcWmBcZ5qeXwiE3O
	z93ECE6FWt47GB89+KB3iJGJg/EQowQHs5IIr8i8wDQh3pTEyqrUovz4otKc1OJDjKbAIJ7I
	LCWanA9Mxnkl8YYmlgYmZmZmJpbGZoZK4ryvW+emCAmkJ5akZqemFqQWwfQxcXBKNTDZnfqd
	9a716/6Z8Vl1bVe75ufNPPRC2P/eNPcn8aZnY2R2xR1cOC3O+fuzd8e5VPguuN07uivx897S
	ooDEVxcP7DZpMmfn2Nd3LctNsGHPtadr9GSy3V+Vhx25a7jwY2XkJC3h+ZNqNcrC61/e/P1m
	e/akyjKvMykZ4Qksmi0r+RcxnpslvixPftERyQuzejbXNbLZ3L/Fekb9I/shfd09whYdnuY+
	75NvT3mwTtF8ofCPyFqL6qWiOx6t2ibX+biyqDfiUq5bw85KXtst+y4o+x5ssjkZXHHxU8EH
	eWbTdywsnR/esKgsytxw+Ek0v6et1C0lG0Uj5p/5T/9YKOtl/2lQ+3osW69EPZo7K1OJpTgj
	0VCLuag4EQD5B1ZTDgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnK7Eh+A0g5bjEhar7/azWfzqvsto
	sfeWtsXlXXPYLJ7t5bT4cvg7u8XZCR9YLbounGJz4PC4fLbUo2/LKkaPz5vkApijuGxSUnMy
	y1KL9O0SuDJWfHjHXnCGteLizCssDYxXWboYOTkkBEwkll57xNrFyMUhJLCbUWJJx1xGiISE
	xI5Hf1ghbGGJlf+es0MUfWOU2L1lETtIgk1ASWL/lg9gDSJARfs7WllAipgFJjNKnN+4Hywh
	LGAnsWDDNjCbRUBV4u2TqWCreQWsJZZOWcsGsUFe4mbXfmaIuKDEyZlPwGqYgeLNW2czT2Dk
	m4UkNQtJagEj0ypGydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjODA1NLYwXhv/j+9Q4xM
	HIyHGCU4mJVEeEXmBaYJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zWcMTtFSCA9sSQ1OzW1ILUI
	JsvEwSnVwPSYi/fvBhnVL5V7tv69z8VvX7rU+HX70U9ZK7dzvKv72T130pf3PxKly2POXLTN
	Y4/RtbwmO8F+Ubi30tOVxSpX4p+tCCyaYnjT7c7ySbKvK1UWv99uF3YrY2Pc2vbLn3SEu5aa
	WjUb3mBYXKEn8Hqa7hdL6yUb7y87F/7W/QnDoj081R+N/t1cUFKivd9BeZ7PNRUnwTjx8NVO
	1xO1uq24BPQnPl8/b47AnJsnQkqTjqi4O94+xb9qQWyVemPdk3fb5GfP0RdoDFy5J9Tu7c68
	kkPPnUOn79D26t2qmKZ1NM1s+5/Z2dMN2N3/+L37kxL/6uRrdb/P7PfPWLVMXHzleLl6i5Xl
	1PWyi+NiD/kosRRnJBpqMRcVJwIAr3KfubsCAAA=
X-CMS-MailID: 20240527022944epcas5p16011e653d1f770cd11bc760f39c17ad2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240527022944epcas5p16011e653d1f770cd11bc760f39c17ad2
References: <CGME20240527022944epcas5p16011e653d1f770cd11bc760f39c17ad2@epcas5p1.samsung.com>

From: Xue He <xue01.he@samsung.com>

It is used in block hybrid poll, the related function
definitions have been removed, but the function
declaration has not been delelted.

Signed-off-by: Xue He <xue01.he@samsung.com>
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

