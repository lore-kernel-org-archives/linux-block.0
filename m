Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592359;
	b=xEv/jebx+XOPJ1h4zY4A6AG6OpsE9z2+xFUa3TjZy71mMwt3tC+12dR6mB5SVUn+lR7Q
	 m60V9jpzms0PEpaz6WyPc34DqBdVkvltpE/gMLFx+GRMej3Ez5JMJg4pf6aeQowrTHquP
	 0ZJMX8V3ItL9Zxr3R5gNOLis96fo4fpt+4mhQyh0LyxwL+YuYJlN+ymbS8EUK2xk+6dJj
	 H2SZq0Jm3PzfoFVwp/XY+7EXit1eb9jhyANUH823nLrPex990jMuulFUf5xAX2XMR/cjS
	 vchZUZs8/+rnJq149eH8R5uCiNrWfyKfAWulLyF6u8wg8H72+lSTRnEPXwp3XpWp/Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592359;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Mime-Version:Subject:Reply-To:Sender:From:To:CC:X-Priority:
	 X-Content-Kind-Code:X-CPGS-Detection:X-Drm-Type:X-Msg-Generator:
	 X-Msg-Type:X-Reply-Demand:Message-ID:Date:X-CMS-MailID:
	 Content-Transfer-Encoding:Content-Type:X-Sendblock-Type:CMS-TYPE:
	 cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=pKwo/utL0RCF0IhzNfFqNEAGFV4dok1n7WdI8rSHcuM=;
	b=01Sdxdm30joQ6uWSBywv7W+HifUcSCTwSxSk1JnxaG8giEsLINQvqp8vXyj/3Mjkqusi
	 RkzgiMjDlOBofAUXH0iYXg9RRG0cw1I7WZTAsx0/6nBcFN0ZNDJtK1U3NuJrgCKJfI43k
	 b5hzhsdLLD6HZtuRc2JFksKyIuAsw6CdaQUEHE4Vy2hA4MjcNZE8tdKsKklEfVK/tYuvU
	 Gon7LK8zcffhPIfraJWkjMLP79PSy0RV+9ksxSMCGlnDqPtlAKHCwI8k7kaVuiwlFVH7e
	 rfNPOTh3Kf2C//UJmgHyGtq82yeLiQHgxPKjb00PEP3B3RDkialNELIJvXzDxTXQQOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=S8j4XLSD;
	arc=none smtp.remote-ip=203.254.224.33
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7B2606A31E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B7B2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=S8j4XLSD
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261125073915epoutp0313ba53fbba4806a9c96d52dbf2a095a3~rObv6-UfR2408924089epoutp03k
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:39:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261125073915epoutp0313ba53fbba4806a9c96d52dbf2a095a3~rObv6-UfR2408924089epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795592356;
	bh=pKwo/utL0RCF0IhzNfFqNEAGFV4dok1n7WdI8rSHcuM=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=S8j4XLSDbNRvCzYKcFACVKRpprFAYBOycjZJawyFmVcH4ay+AKPe++I8QKT/DFwUv
	 xIUEcRpIhuHp+4akM2oV2pgWSDLP83peSW5P+1t8fB9eSf94Fb9k3+KbQF9G1tv/rp
	 xuyVaoz7ITr9BCplihOmtFae0KT4YRuk03yJ88zE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20261125073915epcas2p2c661b361b482a226f58efbe6929ff5e0~rObvjONy_0560105601epcas2p2a;
	Wed, 25 Nov 2026 07:39:15 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.205]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4jZBQC2Vjmz3hhT7; Wed, 25 Nov
	2026 07:39:15 +0000 (GMT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Subject: [PATCH v3] blk-mq: scope the no-sleep requirement in
 blk_mq_alloc_request_hctx()
Reply-To: hmi.jeon@samsung.com
Sender: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
From: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
To: "hch@infradead.org" <hch@infradead.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>,
	=?UTF-8?B?7KCV7J6s7JuF?= <jaew.jung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261125073914epcms2p653a329ef9213d5a9e2f74ec5401a3018@epcms2p6>
Date: Wed, 25 Nov 2026 16:39:14 +0900
X-CMS-MailID: 20261125073914epcms2p653a329ef9213d5a9e2f74ec5401a3018
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261125073914epcms2p653a329ef9213d5a9e2f74ec5401a3018
References: <CGME20261125073914epcms2p653a329ef9213d5a9e2f74ec5401a3018@epcms2p6>

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Changes since v2:
- resend only; the v2 mail had the patch headers pasted into the message
  body. No changes to the code or the commit message.
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

