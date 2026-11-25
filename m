Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795590842;
	b=2iq0yhbibhOdT+uVDhMCknwlrgfBqn6XPvxW03aFsw86aGCfB5m06FxSfS4wDQ1ESfM1
	 7/P5moKaKbumDJOgseHdHqK/3/Pe+LowRqq1FCE6E+Fa3ucHE9y+eDVq/C6kbDSYD4frH
	 2ih1vN20ctEMlnRsyaYlIIia6NX9p2ykFmdJkv0YXMDVzRAgNKB1/2hKsstyeKgBESHcm
	 8CSASLiEqGSIkj2j6GAN25Czbr9Rf1syl9r+JtlgP2U7UvkLc04zQCyEaHli/lwYIFcFA
	 nVgOOFNk3kvj+QJEq5J+PQbHsfkEYcGn0RoQepU9VcMbEKdbxl/fq4dTQyJSOAoSjzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795590842;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Mime-Version:Subject:Reply-To:Sender:From:To:CC:X-Priority:
	 X-Content-Kind-Code:In-Reply-To:X-CPGS-Detection:X-Drm-Type:
	 X-Msg-Generator:X-Msg-Type:X-Reply-Demand:Message-ID:Date:
	 X-CMS-MailID:Content-Transfer-Encoding:Content-Type:X-Sendblock-Type:
	 CMS-TYPE:cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=FThLptRPFN7wHNltfNaJgXqpZjoPtgZZqTXNmisOG+E=;
	b=gcSc7HZG+YgQeJAeVAlCxh0QQrjfcOE2g3v0OATNh+VAJxueRCy6cvYp0F7+UQJiUpsO
	 6sjOV+VPM6xoGpZ2UQ+FZO53C5IXnKZt+1eoREJbKrFQRWXlZY90KOsIQn2wKIx+UQjrT
	 pVZZwqHMgs+Y9zB/jhQvdPRf2JtGewDOyqBe2RfqrPEy8YPhqsds1bohglNWt4GDczW7j
	 VrhCd9Z8h9nQUrsD4wkiqOStDM6Umog1JCcyaNRfUmi1Fz0flwVZn9NWxje0Q5Vf41hbM
	 yu6x3nSURaYGBF/wqRJpCNFPd/uJICCUITgnFAw+ULGiCIN3iBSr0jIrapE2J+dxfmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=gjhCoz7r;
	arc=none smtp.remote-ip=203.254.224.24
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB66606A680
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CB66606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=gjhCoz7r
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261125071357epoutp01ec087aabefe098309dce66f169254124~rOFplU0P_0282302823epoutp01-
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:13:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261125071357epoutp01ec087aabefe098309dce66f169254124~rOFplU0P_0282302823epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795590837;
	bh=FThLptRPFN7wHNltfNaJgXqpZjoPtgZZqTXNmisOG+E=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=gjhCoz7rFyT2mzrPsAfYif1HI0ojF7aP+his4ir7r1MOfHpkSZy5yhOQWpVlh07Gv
	 sMq77zvC60/AvG4wc/skwv8gf7Fl+JInT0nUnCNGZSGt8MUMHUzF+1r1OY9qnMUfrn
	 5kv8pnhNtPS3lEaPJ2tso1fuzPPsQ9GlYj8rH5sE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20261125071357epcas2p2bf774d5131a2b62a901fc8cfcdc21030~rOFpZ4feR1726917269epcas2p2W;
	Wed, 25 Nov 2026 07:13:57 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.204]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4jZ9s06NDlz2SSKn; Wed, 25 Nov
	2026 07:13:56 +0000 (GMT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Subject: RE: Re: RE(2): [PATCH] blk-mq: scope the no-sleep requirement in
 blk_mq_alloc_request_hctx()
Reply-To: hmi.jeon@samsung.com
Sender: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
From: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, =?UTF-8?B?7KCE66+87Iud?=
	<hmi.jeon@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <awaHMx0k45JIgWDp@infradead.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261125071356epcms2p7a4b5ef063efb756caa62986ed1362620@epcms2p7>
Date: Wed, 25 Nov 2026 16:13:56 +0900
X-CMS-MailID: 20261125071356epcms2p7a4b5ef063efb756caa62986ed1362620
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950
References: <awaHMx0k45JIgWDp@infradead.org>
	<awZqQEp3W5Ewp45T@infradead.org>
	<20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950@epcms2p8>
	<20261125065332epcms2p4e172702703233beeab6a683dd69676f2@epcms2p4>
	<CGME20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950@epcms2p7>

On Wed, Nov 25, 2026 at 03:59:00PM +0900, Christoph Hellwig wrote:
> Please put this into the commit log, and given that it is not obvious
> maybe also into a code comment.  Please also describe if this improves
> a workload you care about or if you just found it by code inspection.

Will do - v2 follows with both.

A workload, not inspection. I work on NVMe test tooling, and the driver
under test uses blk_mq_alloc_request_hctx() to send commands to a
specific submission queue; those were failing with -EAGAIN when they
raced a concurrent nr_hw_queues update. What I want is the hctx
guarantee without also giving up the ability to wait.

Thanks for the review.
