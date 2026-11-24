Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479922;
	b=uhNcJmFU0yAMTulILsDY+ySR5HZEYhi0AE+JXECKH+7RtvltupxZfN+xvWS4VjmWU49B
	 /gAYAjlJiD7Nt5dbM38aIaDxfptkV2ahP3j4PgfDFlwRXklI6AWJUiVon+GFwhr1/6bA6
	 xsu0Nb5huugmXEzkah0ODlc7KsdgY9/CJYEL6wuu4GxykQE0TbJhfc2zDphIO9hMxgDWH
	 jmH5yXLZd64BnNCDJZFe5rlh2+DElL9l7Id15z7umCxzbth4a9IJFotckiR+QipXLvbYV
	 hv3WnrzLhZscpE6UdoMRl51OIc/tBTh5DM4Maesn6o1kTi4YJxij6T5jZR27okhgdiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479922;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Mime-Version:Subject:Reply-To:Sender:From:To:CC:X-Priority:
	 X-Content-Kind-Code:X-CPGS-Detection:X-Drm-Type:X-Msg-Generator:
	 X-Msg-Type:X-Reply-Demand:Message-ID:Date:X-CMS-MailID:
	 Content-Transfer-Encoding:Content-Type:X-Sendblock-Type:CMS-TYPE:
	 cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=TijDS4iJhF8Q/BBU6u7k4K+yZkYGqLLKmnnFBlweIcg=;
	b=lShRWaWnzm4RmuzaFWqe3pkD9QzGJI4qdkd9vq34YHHr2CjTyZXLhl8k1Bnvs6wxZ32w
	 DV5fOrHBbxN9K1PdTwTrExiuta6QF+kiarLkFLBTDATdW82cN8kUGb4Vv0Af1kNtrr9NG
	 8BoeeM8HzTc0jPjNCx2jooNgHh76CFg9UOMV8g4WmiZOdDi20QBpb7ihoPaZMjnvFLV1K
	 KnI+TD2d8FGU7T1SC5xiXgKEggbOVP+v+PN0IPOdGljT17wQ3haOv07EF+LKDP+2PzOx+
	 PMQm04MGL8JIVPnwKnu/2JFE2bgZCo+MAGx/TXVmZuAny1uvpHwFvwFmL9yu+eC1V0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=QKPcDugn;
	arc=none smtp.remote-ip=203.254.224.25
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D6606A327
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 00:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C38D6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=QKPcDugn
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261124002519epoutp02ea8786ddbcd04d5470bb47e5b335decb~q03k5IsWW0778207782epoutp02x
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 00:25:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261124002519epoutp02ea8786ddbcd04d5470bb47e5b335decb~q03k5IsWW0778207782epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795479919;
	bh=TijDS4iJhF8Q/BBU6u7k4K+yZkYGqLLKmnnFBlweIcg=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=QKPcDugn/AWkI9sQN2tvLEc2sL5B616rOdMS6VyDCTrQoqA8rYa6N/10J9zyV0Zcr
	 AHxNNmblzn38WakBJIfLdRJdtLP7F/KOqHU2CHKEYBb43Kz5ZMhmWRNPaq4EK9CbaU
	 cOGYP4Ub6X4UtmjBSf/+Evlu3AONvrKLVsfuloyc=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20261124002518epcas2p27dcd8179831296c47e13018840470a70~q03kqOVqu3180931809epcas2p2K;
	Tue, 24 Nov 2026 00:25:18 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.200]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4jYNqy47pbz2SSKk; Tue, 24 Nov
	2026 00:25:18 +0000 (GMT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Subject: [PATCH] blk-mq: scope the no-sleep requirement in
 blk_mq_alloc_request_hctx()
Reply-To: hmi.jeon@samsung.com
Sender: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
From: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	=?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950@epcms2p8>
Date: Tue, 24 Nov 2026 09:25:18 +0900
X-CMS-MailID: 20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950
References: <CGME20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950@epcms2p8>

From 3f2a79888ada5c811151bc5c59a1c7f59c8f7b3b Mon Sep 17 00:00:00 2001
From: Minsik Jeon <hmi.jeon@samsung.com>
Date: Mon, 23 Nov 2026 16:24:17 +0900
Subject: [PATCH] blk-mq: scope the no-sleep requirement in
 blk_mq_alloc_request_hctx()

blk_mq_alloc_request_hctx() rejects any caller that does not pass
BLK_MQ_REQ_NOWAIT, with a comment explaining that a sleeping tag
allocation could hand back a request on a different hardware context:
blk_mq_get_tag() re-picks data->hctx after io_schedule(). That
reasoning only applies to the tag allocator. The same flags value is
also handed to blk_queue_enter(), where waiting for the queue to
unfreeze has no bearing on hctx selection at all, so the requirement
as written is broader than the invariant it protects.

Guarantee the invariant where it actually matters instead of asking
every caller for it: force BLK_MQ_REQ_NOWAIT on the tag allocation
itself, right before blk_mq_get_tag(), and drop the corresponding
WARN_ON_ONCE(). blk_queue_enter() keeps using the caller's flags
as-is, so entering a frozen queue may now block if the caller did not
ask for BLK_MQ_REQ_NOWAIT.

Because blk_queue_enter() can now sleep, two things that implicitly
depended on it never blocking need to move:

 - nr_hw_queues and queue_hw_ctx are only changed with the queue
   frozen (__blk_mq_update_nr_hw_queues()), and the usage counter
   reference taken by blk_queue_enter() is what keeps that freeze
   from completing. Read hctx_idx against nr_hw_queues only after
   that reference is held, otherwise a caller that slept through an
   update could index a stale queue_hw_ctx.

 - alloc_time_ns is meant to measure this request's own depth and tag
   wait, not time spent waiting for the queue to unfreeze. Measure it
   after blk_queue_enter() instead of before.

No functional change: the only caller, nvme's
__nvme_submit_sync_cmd(), still passes BLK_MQ_REQ_NOWAIT for every
qid-targeted command (fabrics connect, in-band auth).

Co-authored-by: Jaewoong Jung <jaew.jung@samsung.com>
Signed-off-by: Minsik Jeon <hmi.jeon@samsung.com>
---
 block/blk-mq.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 54ccfc43c27c..2f7298580e35 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -737,26 +737,31 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	unsigned int tag;
 	int ret;
 
-	/* alloc_time includes depth and tag waits */
+	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_RESERVED)))
+		return ERR_PTR(-EINVAL);
+
+	ret = blk_queue_enter(q, flags);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/*
+	 * alloc_time includes depth and tag waits, but not any time spent
+	 * waiting for the queue to unfreeze above: that wait does not belong
+	 * to this request's allocation latency.
+	 */
 	if (blk_queue_rq_alloc_time(q))
 		alloc_time_ns = blk_time_get_ns();
 
 	/*
-	 * If the tag allocator sleeps we could get an allocation for a
-	 * different hardware context.  No need to complicate the low level
-	 * allocator for this for the rare use case of a command tied to
-	 * a specific queue.
+	 * nr_hw_queues and queue_hw_ctx only change with the queue frozen, and
+	 * the reference just acquired prevents that freeze from completing.
+	 * Callers are no longer required to pass BLK_MQ_REQ_NOWAIT, so
+	 * blk_queue_enter() may have slept through such a change - read both
+	 * only now that the reference guarantees they are stable.
 	 */
-	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT)) ||
-	    WARN_ON_ONCE(!(flags & BLK_MQ_REQ_RESERVED)))
-		return ERR_PTR(-EINVAL);
-
+	ret = -EIO;
 	if (hctx_idx >= q->nr_hw_queues)
-		return ERR_PTR(-EIO);
-
-	ret = blk_queue_enter(q, flags);
-	if (ret)
-		return ERR_PTR(ret);
+		goto out_queue_exit;
 
 	/*
 	 * Check if the hardware context is actually mapped to anything.
@@ -779,6 +784,17 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (flags & BLK_MQ_REQ_RESERVED)
 		data.rq_flags |= RQF_RESV;
 
+	/*
+	 * The tag allocation is the only part that must not sleep:
+	 * blk_mq_get_tag() re-picks data.hctx after io_schedule(), so a
+	 * sleeping allocation could hand back a request on a hardware context
+	 * other than the one asked for.  Guarantee that here instead of
+	 * requiring it of every caller.  Entering the queue above is a
+	 * separate matter - waiting for an unfreeze does not influence hctx
+	 * selection - and is left to the caller's flags.
+	 */
+	data.flags |= BLK_MQ_REQ_NOWAIT;
+
 	ret = -EWOULDBLOCK;
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
-- 
2.52.0

