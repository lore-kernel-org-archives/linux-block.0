Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51A697A5
	for <linux-block@vger.kernel.org>; Thu, 21 Dec 2023 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RknqFI9n"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231221130139epoutp03d821cc9ae8176de3a65ab2710c5bc369~i2lxwOA6p1365513655epoutp03D
	for <linux-block@vger.kernel.org>; Thu, 21 Dec 2023 13:01:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231221130139epoutp03d821cc9ae8176de3a65ab2710c5bc369~i2lxwOA6p1365513655epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703163699;
	bh=PpnlORNR0D4uCtNQd1bbOOWyPJnGQzA/ditmPACE5wE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=RknqFI9nLJtGJYI/LAIF4eChc3UaM5gUtooyXspWdZEhurw17T7m0lSrb5wjmVDlQ
	 mA/1kmtYxGJICkQjW9j+BXx6tmeAj7P06jwzCIpS6SjxtEQ0DfDHpRU27UpVKVCFlV
	 CuXBxILm408KeyvImUYBHVMW4ePWHQZwCqMJTCEg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231221130139epcas5p2aa94ddd4d53646cb0efabbe23508ba3b~i2lxavJqs0750607506epcas5p2R;
	Thu, 21 Dec 2023 13:01:39 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SwrD12q8Xz4x9Pt; Thu, 21 Dec
	2023 13:01:37 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.66.09634.03734856; Thu, 21 Dec 2023 22:01:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231221111858epcas5p46c3bf66f33df8652d2da966b3ecbfa60~i1MHWoPL60261302613epcas5p4O;
	Thu, 21 Dec 2023 11:18:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231221111858epsmtrp1a518a6716d63997965b748925070783a~i1MHWC9sq1883118831epsmtrp1b;
	Thu, 21 Dec 2023 11:18:58 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-b6-65843730eaf6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	51.2C.08755.12F14856; Thu, 21 Dec 2023 20:18:57 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231221111857epsmtip18f664a9fc348222ede1be4a3af7576a9~i1MGW1xzm3105531055epsmtip1_;
	Thu, 21 Dec 2023 11:18:56 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, Kundan Kumar <kundan.kumar@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] block: skip start/end time stamping for passthrough IO
Date: Thu, 21 Dec 2023 16:42:21 +0530
Message-Id: <20231221111221.4237-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmlq6BeUuqwb1Tehar7/azWaxcfZTJ
	4uj/t2wWkw5dY7TY+uUrq8XeW9oObB6Xz5Z6bFrVyeax+2YDm0ffllWMHp83yQWwRmXbZKQm
	pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDtV1IoS8wpBQoF
	JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ6xf8Z+p
	4CtbxYm5X9kbGN+ydjFyckgImEgsmfSdHcQWEtjNKHF8Yn4XIxeQ/YlR4uvSH8wQzjdGiTe/
	VrPBdKxu62CCSOxllOh+8h2q6jOjxMQjb4EyHBxsAroSP5pCQRpEBIwkdv59DdbMLJAv8ejp
	dDBbWMBd4vHdJWCrWQRUJTY/3MsIYvMK2Eh8WfcM6jx5iZmXIM7jFRCUODnzCQvEHHmJ5q2z
	wfZKCBxil9i8cDUzRIOLxKpd16FsYYlXx7ewQ9hSEi/726DsbIlDjRuYIOwSiZ1HGqDi9hKt
	p/qZQe5nFtCUWL9LHyIsKzH11DomiL18Er2/n0C18krsmAdjq0nMeTeVBcKWkVh4aQZU3ENi
	999lLJDgjZW42/KeZQKj/Cwk78xC8s4shM0LGJlXMUqmFhTnpqcWmxYY5qWWw+M1OT93EyM4
	FWp57mC8++CD3iFGJg7GQ4wSHMxKIrz5Oi2pQrwpiZVVqUX58UWlOanFhxhNgWE8kVlKNDkf
	mIzzSuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgYnmfK30qyMzQ
	1uhv/wtLy4c6JfdeT550LV+s+dFx5VXGn075zey1iDtp7hQw97b/MZOf6TfefJwhJRDDY77/
	2Ep12/WZt/Lsb+sEVM1K/PAuy1FM47BhmkXgxd0X2CQ+WSSwtUe2yNV1n2OaOTMqk+PfJ74r
	DLEyM2/2zLPTZzh4YvZXtZo5N2vlYnr1+B9c+MpyeWGbz1lu/2Pywc/f7j/IdGUyu+3vh1OS
	BfTXV3uyNB7dz7Qj86OIluWsp9fuK9rOZ7ifXvdkXl/9feU4C6Xm+wuOKQpM3HXtdGjOyicr
	zjy8Vh3w+KXFaos/tmIar157Se4Q/dMs/f279ETZuGlrGZ67beE/zftVt7skSomlOCPRUIu5
	qDgRAG8iwg0OBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnK6ifEuqwdetNhar7/azWaxcfZTJ
	4uj/t2wWkw5dY7TY+uUrq8XeW9oObB6Xz5Z6bFrVyeax+2YDm0ffllWMHp83yQWwRnHZpKTm
	ZJalFunbJXBlrF/xn6ngK1vFiblf2RsY37J2MXJySAiYSKxu62DqYuTiEBLYzSjx7NQpRoiE
	jMTuuzuhioQlVv57zg5R9JFR4u/5GUBFHBxsAroSP5pCQWpEBMwk9p/byAwSZhYolPizSRQk
	LCzgLvH47hJ2EJtFQFVi88O9YON5BWwkvqx7BjVeXmLmpe/sEHFBiZMzn7CA2MxA8eats5kn
	MPLNQpKahSS1gJFpFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcFBqae5g3L7qg94h
	RiYOxkOMEhzMSiK8ezubUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1I
	LYLJMnFwSjUwbZ43f9l1Rx7e3UY7RA6r5v92ZNA7WW7TmtCr92vWZb02pQcv+BbFz365b3bu
	unndvMeeK8svuTyRq+vGnVsLvQ6a9Gzuni9fMuFR8Cnp+5I/l64K5PsWPKdGuEFSQzWtQtmf
	LbL4d268zbRZFy5z7+1Jb/V99WXeFMnybPdHn7LLb6xue2wyOeP22+VH7t85/PaByMrmwO+/
	PC0j1AIifnlNPFWn6pzj++XF67nennM1Y1Zcv9LO4LkgVm1NxJ4O7lM6883l1qQzWCwqkKpl
	LXoumLrs+/FPrlu8Uxd8aO+ZF65a98jo26TSCs16u8nWVaK3nVJf5gq9uxKUt8qZ31f7jd42
	yQC7sLyfTGxOSizFGYmGWsxFxYkAJC87c7kCAAA=
X-CMS-MailID: 20231221111858epcas5p46c3bf66f33df8652d2da966b3ecbfa60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231221111858epcas5p46c3bf66f33df8652d2da966b3ecbfa60
References: <CGME20231221111858epcas5p46c3bf66f33df8652d2da966b3ecbfa60@epcas5p4.samsung.com>

This patch will avoid start/end time stamping for passthrough IO.
This helps to improve IO performance by ~7%

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/blk-mq.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1ab3081c82ed..04617494db7e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -830,7 +830,8 @@ void blk_mq_end_request_batch(struct io_comp_batch *ib);
  */
 static inline bool blk_mq_need_time_stamp(struct request *rq)
 {
-	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_USE_SCHED));
+	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_USE_SCHED) &&
+		!blk_rq_is_passthrough(rq));
 }
 
 static inline bool blk_mq_is_reserved_rq(struct request *rq)
-- 
2.25.1

