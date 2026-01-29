Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72225771
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678586; cv=none; b=nNmpf0Wi/bhoRxO0y1rNdVVae2ZXsV7EQ3E8D9HVdrk3IxYf0y9KbIsdzswI+8u1lCp+0EDHT4r8MfVF6cmmsh3dyUpJGV4n5SVPYDFkg49E+wavB9jn2h0fNfr8pcgkaft/G9PNzAXgEIitAJrp6nIJ2j52nH/ireQpEZrwJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678586; c=relaxed/simple;
	bh=ARs//fIDejJMHXNpru/GOfl78BmMhpV7mS+cI7e3jF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=WhACTtk0xW/hqxcDM3XJJa9WmQa/YiYrfxVbjPN5JOujGAAbiSLKM5tHkXmQlDZDv3HV5UInO4/v+otWscHE3zxnMwMqkCzAPFP9hvo+sp6O1vqVJCKPiMjGOkxFXge+BqjNB60qICcIkE58Lun6Feplu5hOqutg/lAnZd9nfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Q/5PnCZz; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q/5PnCZz"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260129092301epoutp04e5e822c6dc7409c075b4c57102491deb~PKUsUSiaD1559215592epoutp04n
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 09:23:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260129092301epoutp04e5e822c6dc7409c075b4c57102491deb~PKUsUSiaD1559215592epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769678581;
	bh=qUI9j7bLsc/At0wO/OTw5TxXAC8JsaEARV5hmvwnG/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q/5PnCZznOXaUpCI+pYDUOjyQ5VmFOJ+2E7ksYDBXSDYXqi3hB4jt19n6BsMU6WPh
	 yxZnSWfxfZv6MD2RahXQEXr1e80lewONBHuxDY5qi6irntSd1G+fmSiIlcWQn45+5s
	 Dbs5Ck4mzCop2f9R/nBli34f/nfi+vcTuxYHFCQM=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260129092300epcas5p497c738bc1c9130fde8bde6c2ef93629f~PKUr-sXzK2452624526epcas5p4t;
	Thu, 29 Jan 2026 09:23:00 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4f1twM4y0wz3hhTD; Thu, 29 Jan
	2026 09:22:59 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260129092258epcas5p1fb7fd90db827d982829475652b43786a~PKUqbo9f40563405634epcas5p1D;
	Thu, 29 Jan 2026 09:22:58 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260129092258epsmtip27dd77ea529ab52486982c8fef66e4a08~PKUp8Hjuq1221112211epsmtip2D;
	Thu, 29 Jan 2026 09:22:58 +0000 (GMT)
Date: Thu, 29 Jan 2026 14:48:46 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: introduce blk_queue_rot()
Message-ID: <20260129091846.nx3crn6347gf6brv@green245.gost>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260129072715.1107336-3-dlemoal@kernel.org>
X-CMS-MailID: 20260129092258epcas5p1fb7fd90db827d982829475652b43786a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_13656e_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260129092258epcas5p1fb7fd90db827d982829475652b43786a
References: <20260129072715.1107336-1-dlemoal@kernel.org>
	<20260129072715.1107336-3-dlemoal@kernel.org>
	<CGME20260129092258epcas5p1fb7fd90db827d982829475652b43786a@epcas5p1.samsung.com>

------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_13656e_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 29/01/26 04:27PM, Damien Le Moal wrote:
>To check if a request queue is for a rotational device, a double
>negation is needed with the pattern "!blk_queue_nonrot(q)". Simplify
>this with the introduction of the helper blk_queue_rot() which tests
>if a requests queue limit has the BLK_FEAT_ROTATIONAL feature set.
>All call sites of blk_queue_nonrot() are modified to use blk_queue_rot()
>and blk_queue_nonrot() definition removed.
>
>No functional changes.
>
>Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>---
> block/bfq-iosched.c    | 20 ++++++++++----------
> block/blk-iocost.c     |  2 +-
> block/blk-iolatency.c  |  5 +----
> block/blk-wbt.c        |  5 ++---
> include/linux/blkdev.h |  4 ++--
> 5 files changed, 16 insertions(+), 20 deletions(-)
>
>diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>index 6e54b1d3d8bc..3ebdec40e758 100644
>--- a/block/bfq-iosched.c
>+++ b/block/bfq-iosched.c
>@@ -231,7 +231,7 @@ static struct kmem_cache *bfq_pool;
> #define BFQ_RQ_SEEKY(bfqd, last_pos, rq) \
> 	(get_sdist(last_pos, rq) >			\
> 	 BFQQ_SEEK_THR &&				\
>-	 (!blk_queue_nonrot(bfqd->queue) ||		\
>+	 (blk_queue_rot(bfqd->queue) ||			\
> 	  blk_rq_sectors(rq) < BFQQ_SECT_THR_NONROT))
> #define BFQQ_CLOSE_THR		(sector_t)(8 * 1024)
> #define BFQQ_SEEKY(bfqq)	(hweight32(bfqq->seek_history) > 19)
>@@ -4165,7 +4165,7 @@ static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>
> 	/* don't use too short time intervals */
> 	if (delta_usecs < 1000) {
>-		if (blk_queue_nonrot(bfqd->queue))
>+		if (!blk_queue_rot(bfqd->queue))
blk_queue_rot looks fine to me in other places.
Keeping blk_queue_nonrot would avoid the double negation here and few places.
I see you made the changes for bdev_nonrot down, but missed to add here
?

Thanks,
Nitesh

------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_13656e_
Content-Type: text/plain; charset="utf-8"


------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_13656e_--
