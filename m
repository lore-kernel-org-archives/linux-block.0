Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591505;
	b=FibMDuxJL+FSds3ZmRkQd2NZ0vuZvDnnxWgj146bT2xLZ1Jb6ptvKZxHVVfCJdse4Ph8
	 b5xkjENe4ILKRP6jB5fSyzrYPtE1HWj/fUEBya/z0tt39Tq8ZzW+kieOsbN4enZp/TFcd
	 kcSBkeymv/on4ZJMqv9U/iCOndQ6Ecb0uHBs5FRkKaWweYcJi3mQ6CXCQaG8SQHZ/YFFQ
	 lKCAOClLXpYYHdr0tXOxrqLzxHBsya0FHX9ZIor/XHY4NCRrdYJQ/oDuWsA2EkhpWdWOu
	 kygZgE7gWZSm4Htz5pKaVH2ucthQ9GiE02tLu+wmNPx/aF8Lm126ksSw3ZPmjzS1zJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591505;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Mime-Version:Subject:Reply-To:Sender:From:To:CC:X-Priority:
	 X-Content-Kind-Code:X-CPGS-Detection:X-Drm-Type:X-Msg-Generator:
	 X-Msg-Type:X-Reply-Demand:Message-ID:Date:X-CMS-MailID:
	 Content-Transfer-Encoding:Content-Type:X-Sendblock-Type:CMS-TYPE:
	 cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=PqkxENb18SY992tKq/Ln+jvqfZGUzO8cOnUTxUEDRSQ=;
	b=oJGHotziRVMevOz+BsW7FZwOylQiGm9QDxYmpQ8ogFQuY1MWiWDNd5VLf/u6tzer2ORl
	 kzhyGx4gt33MuETmG4FtM/ZpJp0DxH49RbxBU/RwJdSDKsxNUV12WbSpCNamnVGB3K7Zb
	 1RUdXlaS3n8h+GofIqrEpC5vdrlFqslcRXyD0mKZcnhcwSc5v7YIblGwljlETPX/XMb3E
	 1bndGkqPtEsYnMMCm0ZjzLqcmBcFUMsCh+2QRS7Cz12d2rwEeSDN9YaU3YCsWHDxj/cb8
	 wubWQVAzJxhtW+/MIZ4m9dHtuZmh37KuIB8s1hrMUN0gESIpz9iPs1C9FybPafwiQ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="E/7KGb4J";
	arc=none smtp.remote-ip=203.254.224.33
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B45606A329
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54B45606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=E/7KGb4J
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261125072501epoutp0371b981851c75868f2e1de4705e996698~rOPURyd880794607946epoutp03V
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:25:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261125072501epoutp0371b981851c75868f2e1de4705e996698~rOPURyd880794607946epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795591501;
	bh=PqkxENb18SY992tKq/Ln+jvqfZGUzO8cOnUTxUEDRSQ=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=E/7KGb4Jmi0r2R4z4BR3MiEY2vdpYAWbHmRz5znxgc8Gz3aUuBQqgwx+Zc22OCST1
	 SmcWDUzOUO7Ip9/F+VhgBjANw8IEsaNWoXtIAnfxBDXZhWKVd8xBM+K6KlRxEH8t/J
	 cXekeErVniaYTRAzj6Vm6MpQ4airtaMxiKH1RbQY=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20261125072501epcas2p23aeba091baaf459fbd6da20b6c872f8b~rOPT0ldD90197301973epcas2p21;
	Wed, 25 Nov 2026 07:25:01 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.200]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4jZB5m6k3Dz3hhTL; Wed, 25 Nov
	2026 07:25:00 +0000 (GMT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Subject: [PATCH v2] blk-mq: scope the no-sleep requirement in
 blk_mq_alloc_request_hctx()
Reply-To: hmi.jeon@samsung.com
Sender: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
From: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
To: "hch@infradead.org" <hch@infradead.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	=?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261125072500epcms2p4dbf32261de0ff182820c3a5ae8daec38@epcms2p4>
Date: Wed, 25 Nov 2026 16:25:00 +0900
X-CMS-MailID: 20261125072500epcms2p4dbf32261de0ff182820c3a5ae8daec38
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261125072500epcms2p4dbf32261de0ff182820c3a5ae8daec38
References: <CGME20261125072500epcms2p4dbf32261de0ff182820c3a5ae8daec38@epcms2p4>

From 6693953129c96668a266d9c55476eaf75eb3bb7b Mon Sep 17 00:00:00 2001
From: Minsik Jeon <hmi.jeon@samsung.com>
Date: Mon, 23 Nov 2026 16:24:17 +0900
Subject: [PATCH v2] blk-mq: scope the no-sleep requirement in
 blk_mq_alloc_request_hctx()

BLK_MQ_REQ_NOWAIT is mandatory in blk_mq_alloc_request_hctx() only to
keep blk_mq_get_tag() from re-picking data->hctx after io_schedule().
But the same flags value is passed on to blk_queue_enter(), so a caller
also takes -EAGAIN for a transient freeze that has no bearing on hctx
selection. There is no way to ask for the hctx guarantee without also
opting out of waiting.

Force BLK_MQ_REQ_NOWAIT on the tag allocation alone, right before
blk_mq_get_tag(), and let blk_queue_enter() honour the caller's flags.
nr_hw_queues/queue_hw_ctx and alloc_time_ns move after blk_queue_enter()
now that it can sleep through such an update.

Co-authored-by: Jaewoong Jung <jaew.jung@samsung.com>
Signed-off-by: Minsik Jeon <hmi.jeon@samsung.com>
---
Changes since v1:
- rewrite the commit message to explain the motivation instead of
  restating the diff
- say in the code comment why the no-sleep rule is forced at the tag
  allocation rather than required from callers
 block/blk-mq.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 54ccfc43c27c..cf5d98bd13e3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -737,26 +737,27 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
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
+	/* alloc_time includes depth and tag waits, but not the unfreeze wait */
 	if (blk_queue_rq_alloc_time(q))
 		alloc_time_ns = blk_time_get_ns();
 
 	/*
-	 * If the tag allocator sleeps we could get an allocation for a
-	 * different hardware context.  No need to complicate the low level
-	 * allocator for this for the rare use case of a command tied to
-	 * a specific queue.
+	 * nr_hw_queues and queue_hw_ctx only change with the queue frozen, and
+	 * the reference just acquired prevents that freeze from completing.
+	 * Callers need not pass BLK_MQ_REQ_NOWAIT, so blk_queue_enter() may
+	 * have slept through such a change - read both only now that the
+	 * reference guarantees they are stable.
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
@@ -779,6 +780,17 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (flags & BLK_MQ_REQ_RESERVED)
 		data.rq_flags |= RQF_RESV;
 
+	/*
+	 * The tag allocation is the only part that must not sleep:
+	 * blk_mq_get_tag() re-picks data.hctx after io_schedule(), so a
+	 * sleeping allocation could hand back a request on a hardware context
+	 * other than the one asked for.  Force it here rather than require
+	 * BLK_MQ_REQ_NOWAIT from every caller, which would also make
+	 * blk_queue_enter() above fail with -EAGAIN for a freeze that has no
+	 * bearing on which hctx the request lands on.
+	 */
+	data.flags |= BLK_MQ_REQ_NOWAIT;
+
 	ret = -EWOULDBLOCK;
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
-- 
2.52.0

