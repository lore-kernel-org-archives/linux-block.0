Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gVn7C5Ji"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA96DD44
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 18:11:20 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231124021115epoutp04523c8ea0298c054369a568fb8b676c03~abTMhGgQt1436314363epoutp04J
	for <linux-block@vger.kernel.org>; Fri, 24 Nov 2023 02:11:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231124021115epoutp04523c8ea0298c054369a568fb8b676c03~abTMhGgQt1436314363epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1700791875;
	bh=4DjYsPte187bqwAmYLu9/v8MpLPCIn5GOjbrKYJu9sk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=gVn7C5JiE1lDegWoyXFO1cdahEG76hJONSWzFasMvtKF2mUCQJR/CyYLCnniSAN4k
	 1g0QwwNim6F9Q9qvwriavPLf5aC76PIJLIi2mQRqLAIForYixIIjC5Q0jdNVY6BvKj
	 j/kVZir5dNCsJvX+8zHJaTRou+l2rCZhzoKZ2Nug=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231124021115epcas5p246ebc8efb083363745a3cdd9791376ff~abTL9GSOS2038920389epcas5p2F;
	Fri, 24 Nov 2023 02:11:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Sbz4112gPz4x9QC; Fri, 24 Nov
	2023 02:11:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	37.79.10009.04600656; Fri, 24 Nov 2023 11:11:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231123191010epcas5p2b775f5b179ac02c3930d2274e3225d76~aVjibOMKS2756027560epcas5p2O;
	Thu, 23 Nov 2023 19:10:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231123191010epsmtrp1061579d3f59d2e33f4020ab1ff01e966~aVjiamG4u2233922339epsmtrp1S;
	Thu, 23 Nov 2023 19:10:10 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-40-65600640a0c7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	42.73.08755.293AF556; Fri, 24 Nov 2023 04:10:10 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231123191009epsmtip114a242d8b50dc81eb728309e42065775~aVjhaL7kq0831008310epsmtip1b;
	Thu, 23 Nov 2023 19:10:09 +0000 (GMT)
From: "kundan.kumar" <kundan.kumar@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, Kundan Kumar <kundan.kumar@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2] block: skip QUEUE_FLAG_STATS and rq-qos for passthrough
 io
Date: Fri, 24 Nov 2023 00:33:31 +0530
Message-Id: <20231123190331.7934-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmlq4jW0KqQfMaRovVd/vZLFauPspk
	cfT/WzaLSYeuMVps/fKV1WLvLW0HNo/LZ0s9Nq3qZPPYfbOBzaNvyypGj8+b5AJYo7JtMlIT
	U1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4D2KymUJeaUAoUC
	EouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM9b8aWQp
	aOKpuDd9DVMDYzNXFyMnh4SAicSOB0tZuxi5OIQEdjNKfHnznQXC+cQo0Xx/AjOE841R4sS5
	T4xdjBxgLc9XGUDE9zJKPJ3/GKr9M6PEhovzmUGK2AT0JfrXFIKsEBEwktj59zUbiM0skC/x
	6Ol0NpASYYEAiek3ZUHCLAKqEvvf3AMr4RWwkZjSspId4jp5iZmXvrNDxAUlTs58wgIxRl6i
	eetssNskBI6xS/xpvcAE0eAiMf/vPihbWOLV8S1Qg6QkXva3QdnZEocaN0DVlEjsPNIAFbeX
	aD3VD3Y+s4CmxPpd+hBhWYmpp9YxQezlk+j9/QSqlVdixzwYW01izrupLBC2jMTCSzOg4h4S
	Rw8sBRsvJBArcfHtH7YJjPKzkLwzC8k7sxA2L2BkXsUomVpQnJueWmxaYJSXWg6P1uT83E2M
	4ESo5bWD8eGDD3qHGJk4GA8xSnAwK4nw5v6JTxXiTUmsrEotyo8vKs1JLT7EaAoM44nMUqLJ
	+cBUnFcSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8TB6dUAxNjt8Or/Dhd
	hzjD7bP2r37v5xpyooZfKXF9rulz19D/W57t/3Gea//6B9u4alN63+hJfvllGlFSk9j2SODo
	Q8u5seEmJilWU/Y3xuxe+ymj6cvECd7eL7dmrfLdHXSA+9XBf6GrPbeeYuj49CtNprND28Gk
	zqN8VtGJMmHGayKaFk6hyktXKRu3dZbHbMlz4DzNV8p55Z3k3LvnJiSI3EqdIR4gznQglKdw
	weqKhTe6jP9/3sDP/eL9rv/bApJ9Fr/iVN1zosxdzUHwb1FiS+8PgcufRH4tZZT+fVhmZi5/
	/gfXGkufZbl/PDWEXNrLZ/XyeFTbJbstdDHSfyLKdU/yU8wt4WPt8UdcxJd/VmIpzkg01GIu
	Kk4EABIfjYINBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSnO6kxfGpBhM3iVisvtvPZrFy9VEm
	i6P/37JZTDp0jdFi65evrBZ7b2k7sHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAGsVlk5Ka
	k1mWWqRvl8CVseZPI0tBE0/FvelrmBoYm7m6GDk4JARMJJ6vMuhi5OIQEtjNKLGi7x5zFyMn
	UFxGYvfdnawQtrDEyn/P2UFsIYGPjBIP72eA9LIJ6Ev0rykECYsImEnsP7eRGSTMLFAo8WeT
	KIgpLOAn8XiJBEgFi4CqxP4399hAbF4BG4kpLSvZIYbLS8y89J0dIi4ocXLmExYQmxko3rx1
	NvMERr5ZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDkctzR2M21d9
	0DvEyMTBeIhRgoNZSYR3C3tMqhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe8Re9KUIC6Yklqdmp
	qQWpRTBZJg5OqQamjLya7f15rL6vj/Et5FXT+t2Sd3lTDUNdbGxP8eTvM5Zu2PWdfX/yaf/X
	LUIe64LPbMvV/7Bae0nane6f1rxPHlpdPl91i/uV5eaYw25S26Y23f5pETqvd/69tUox35gU
	Fv4PZV/9abK9ML+qdKnQzKaYgnOPAtO0LQ+tSNJsZWW48un4mQfuqsp/dvk431y/sSBHyfWN
	4MTa+EkT5n594dVVt6zm9hOZlLNvDCLWNyTY1v5a3KxTkn3ZXc+B80+PiMkLkwrxN/NPpm9y
	/8dwjX/3Vu7a1fzsbrx31A6quWzMmVCxYXW1T3hnVEjO/MpbXoHLPz502BXhfyup+7xTGdO9
	uZ+Mb22+GxyibPlRiaU4I9FQi7moOBEA2DMCHbYCAAA=
X-CMS-MailID: 20231123191010epcas5p2b775f5b179ac02c3930d2274e3225d76
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231123191010epcas5p2b775f5b179ac02c3930d2274e3225d76
References: <CGME20231123191010epcas5p2b775f5b179ac02c3930d2274e3225d76@epcas5p2.samsung.com>

From: Kundan Kumar <kundan.kumar@samsung.com>

Write-back throttling (WBT) enables QUEUE_FLAG_STATS on the request
queue. But WBT does not make sense for passthrough io, so skip
QUEUE_FLAG_STATS processing.

Also skip rq_qos_issue/done for passthrough io.

Overall, the change gives ~11% hike in peak performance.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
Changes since v1:
- Fix coding style

 block/blk-mq.c     | 3 ++-
 block/blk-rq-qos.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 900c1be1fee1..fb29ff5cc281 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1248,7 +1248,8 @@ void blk_mq_start_request(struct request *rq)
 
 	trace_block_rq_issue(rq);
 
-	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
+	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags) &&
+	    !blk_rq_is_passthrough(rq)) {
 		rq->io_start_time_ns = ktime_get_ns();
 		rq->stats_sectors = blk_rq_sectors(rq);
 		rq->rq_flags |= RQF_STATS;
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index f48ee150d667..37245c97ee61 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -118,7 +118,7 @@ static inline void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
 
 static inline void rq_qos_done(struct request_queue *q, struct request *rq)
 {
-	if (q->rq_qos)
+	if (q->rq_qos && !blk_rq_is_passthrough(rq))
 		__rq_qos_done(q->rq_qos, rq);
 }
 
-- 
2.25.1

