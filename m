Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eI9tDwF2"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCD4D53
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 03:54:00 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231123115356epoutp022d5ccc40f5adab8415b88e1ff3958377~aPmqQorPz0563605636epoutp02P
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 11:53:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231123115356epoutp022d5ccc40f5adab8415b88e1ff3958377~aPmqQorPz0563605636epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1700740436;
	bh=16P/YVEtPaR5kTXsVGT+FoFHMuw63eXy9vxLtuymCL8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=eI9tDwF2C7xHPUTgqMs7TDZPLywfLVQnl9Coe901ha07fYeLyj2PvtM0LCNAAp/Ur
	 RcEa6RV/iFNo3hxfQAV9YjeK5lSY3cY8y+hlbGxUTTn8SzCt2MofmaO4e7VxIQVKOQ
	 6hRqCccMxTB7k0YOoHBRmbFjZJ7jcbIazX6fOpJI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231123115356epcas5p12dc88c3ff782cd896ab9659ecdff8bfb~aPmp1gZvQ2493024930epcas5p1n;
	Thu, 23 Nov 2023 11:53:56 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Sbc2p4pmxz4x9Pv; Thu, 23 Nov
	2023 11:53:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	35.2A.10009.25D3F556; Thu, 23 Nov 2023 20:53:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21~aOeR3plNz0825008250epcas5p20;
	Thu, 23 Nov 2023 10:31:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231123103102epsmtrp23203d5186bdf5e059d565e758fd57749~aOeR3DCTi0840608406epsmtrp2i;
	Thu, 23 Nov 2023 10:31:02 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-25-655f3d52b090
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4C.79.08755.6E92F556; Thu, 23 Nov 2023 19:31:02 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231123103058epsmtip194e3accb2b52f1ca5ba460969b9ea741~aOeOZCbRj2077720777epsmtip1Z;
	Thu, 23 Nov 2023 10:30:58 +0000 (GMT)
From: "kundan.kumar" <kundan.kumar@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, Kundan Kumar <kundan.kumar@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] block: skip QUEUE_FLAG_STATS and rq-qos for passthrough io
Date: Thu, 23 Nov 2023 15:54:31 +0530
Message-Id: <20231123102431.6804-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmhm6QbXyqwa8Nahar7/azWaxcfZTJ
	4uj/t2wWkw5dY7TY+uUrq8XeW9oObB6Xz5Z6bFrVyeax+2YDm0ffllWMHp83yQWwRmXbZKQm
	pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDtV1IoS8wpBQoF
	JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ3y7dYWl
	4Dp3xav7D9kaGJ9ydjFyckgImEjc7L3B2sXIxSEksJtRYtH+R8wQzidGiRmHn7KAVAkJfGOU
	2HVZoYuRA6xjb48URM1eRokXszexQDifGSWerH3BDlLEJqAv0b+mEKRXRMBIYuff12wgNrNA
	vsSjp9PBbGEBb4mFP+6yg9gsAqoSP96eBYvzCthITFhzmxniOnmJmZe+s0PEBSVOznzCAjFH
	XqJ562yommPsEvcnZ0HYLhLP1jSyQNjCEq+Ob2GHsKUkPr/bywZhZ0scatzABGGXSOw80gBV
	Yy/ReqqfGeR8ZgFNifW79CHCshJTT61jgljLJ9H7+wlUK6/EjnkwtprEnHdTodbKSCy8NAMq
	7iGxZvcyRpCRQgKxEmevyk1glJ+F5JlZSJ6ZhbB4ASPzKkbJ1ILi3PTUYtMCo7zUcnikJufn
	bmIEJ0Etrx2MDx980DvEyMTBeIhRgoNZSYR3C3tMqhBvSmJlVWpRfnxRaU5q8SFGU2AIT2SW
	Ek3OB6bhvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamPwKZvF5
	W+kKbM3yXe5WO3NHZfij7H21rYvfhz0VPtt/4EL/yWmP5G8ZRTKZq/In+bSwCJYuvSHFISjD
	7vjn4fa/DM9/6U0JNag6daqSWXlZZZfR4v8bHnR+/LKZ0cyh4pzroZmXPT7q/F187MqP4M+z
	/12ZNI1LefP629Uv9pu98Nt1Tb5WzOmUzMZzxz93P7SqbrLYnMl0qFz4d+PrR8vC1f/wFWak
	bP+Wd2LSFtOnqcqTJjj3dIhfjt1zucom+PWCOeKdH1ZtE7nl0xgtYTJFd4ri0QV5l7Mr8zZw
	Boqt+mr2+pyhSH2Mmk7hUm5LoUlCcbtj7h1ZU7bt4PUmZYcHP2a5Lv0X4CgT1zrF+r0SS3FG
	oqEWc1FxIgCZZ91mCwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSnO4zzfhUg0dbVS1W3+1ns1i5+iiT
	xdH/b9ksJh26xmix9ctXVou9t7Qd2Dwuny312LSqk81j980GNo++LasYPT5vkgtgjeKySUnN
	ySxLLdK3S+DK+HbrCkvBde6KV/cfsjUwPuXsYuTgkBAwkdjbI9XFyMUhJLCbUaLh7xamLkZO
	oLiMxO67O1khbGGJlf+es0MUfWSUWDZ/IyNIM5uAvkT/mkKQGhEBM4n95zYyg4SZBQol/mwS
	BQkLC3hLLPxxlx3EZhFQlfjx9iwbiM0rYCMxYc1tZojx8hIzL31nh4gLSpyc+YQFxGYGijdv
	nc08gZFvFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgkNSS3MH4/ZV
	H/QOMTJxMB5ilOBgVhLh3cIekyrEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2
	ampBahFMlomDU6qBSdXS65aHp0yBkt7sUtFfbIfrw2sf6y2aGSeWZJhlY7G5Re3599W14SW9
	KudVvrBwBm359yGBbetvn+A15d5XWSftvLh+k45PhIPnpFtijkxFp6ylnTtWTS3zM5524Mw9
	sSsZk7TfZfEnmjMxnd3//ZOMRuqOoj/9p3YFz+2qrnkhvHFxS/6VSoPfze8PHv7vEiQw04N3
	n5Lm4rvqt4q3Jsaw/7lx2/C2oYnlB255o93cq09t2lJXJV2sevh5a+PlKKWZbY+8P0mV7ar6
	p7ZZgSdh4lHv2btdbtyNZJw+676HUq1W16HPqgqvcvssdx6f/e+i3dOuNQXLFr/6ry0wodx3
	s3nWu+U8q9qerTXtVGIpzkg01GIuKk4EAKROcjK4AgAA
X-CMS-MailID: 20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21
References: <CGME20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21@epcas5p2.samsung.com>

From: Kundan Kumar <kundan.kumar@samsung.com>

Write-back throttling (WBT) enables QUEUE_FLAG_STATS on the request
queue. But WBT does not make sense for passthrough io, so skip
QUEUE_FLAG_STATS processing.

Also skip rq_qos_issue/done for passthrough io.

Overall, the change gives ~11% hike in peak performance.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/blk-mq.c     | 3 ++-
 block/blk-rq-qos.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 900c1be1fee1..2de9c14dd43f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1248,7 +1248,8 @@ void blk_mq_start_request(struct request *rq)
 
 	trace_block_rq_issue(rq);
 
-	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
+	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)
+			&& !blk_rq_is_passthrough(rq)) {
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

