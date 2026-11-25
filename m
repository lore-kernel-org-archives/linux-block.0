Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589616;
	b=SZlllH9tDJwTIAjpRAEUtplCoxO8TTTsa8DzDdvBo15lcPjkG3C2Y6gOlClyMEla2o/J
	 u/CJYWrkH8ctSJ7sxYqXoZwgVoH6MTyw8hWAkdxPMTHxsEitNFKEINHsXS6fA6vqAcbCp
	 i71yuhOqNnFwTE+XpmZB9bczbW1NDqyz6/ikii6fBgblnnCPo3L+PkPjVGNFIAe+aY9gZ
	 RbDH4rH1LBvWSRY2WXjuPDnyhhr2DBUDL1+D/zY9dfOvVB9l3yPfJHT7BNKremBCpk3wL
	 +dtKMxQ7tOdn3u8Eo0WgKQ89tcRC40sYzMgRCtC9FJqU8v+IqR5w79yVm2cOAZ3WQ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589616;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Mime-Version:Subject:Reply-To:Sender:From:To:CC:X-Priority:
	 X-Content-Kind-Code:In-Reply-To:X-CPGS-Detection:X-Drm-Type:
	 X-Msg-Generator:X-Msg-Type:X-Reply-Demand:Message-ID:Date:
	 X-CMS-MailID:Content-Transfer-Encoding:Content-Type:X-Sendblock-Type:
	 CMS-TYPE:cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=GvHylzyoegywHLUbpb97lAiOTzRqA3xdB9sXNXo5lVc=;
	b=pjQ0Cdu9iWeLj5ochQrYnaxQpr4bmzhVBRwm7r4CgGMsp++E9FSSRVxrWb2lWotHuE7m
	 ZqOhUPoEi98w8XMGfZORGSbxHS/54Kz7xd194De2RIor01bACXuUexc5mhtT2r00w5u0z
	 JaiEShSDmeHM+A4XMENwmBticAA22H8Bf52xKrvdyKhyGW+/uOBolxoAHJ1SsRSWW820K
	 mp0H4MOaVipQPYe9zFfrVyFLzQh+JqW3VhAG5xNN0i6J71Rx/iJfcc1LycPLTXF7inj6K
	 JzAsJmYuIMeXRmJLi6qNgDIedmo/YbvwdlZXH+RQ1MPWdXYoGo2yNoTLJGjNr7Z5egg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=R492tAS9;
	arc=none smtp.remote-ip=203.254.224.33
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE59606A335
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 06:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DE59606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=R492tAS9
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261125065333epoutp036a35d72334997def1ab58155ea8dcb0d~rNz10CO9v0698806988epoutp03F
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 06:53:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261125065333epoutp036a35d72334997def1ab58155ea8dcb0d~rNz10CO9v0698806988epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795589613;
	bh=GvHylzyoegywHLUbpb97lAiOTzRqA3xdB9sXNXo5lVc=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=R492tAS9yfXXci4C+6kyBivteQf/dj0qehGEKEGrU9ZAcX6HXckPk047sZlotmPDp
	 jx7RxhjmAi9AHytUG8nDAxAmy7jSb0O5ZWmyi33zrI0/57/zW6eXvg6e3ryIS8y+w4
	 1if3ug2YjfxpgO/go9A2SrRdGQzKuj5J6mRnlbsA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20261125065333epcas2p32e62833f901046cffe29825525ac7527~rNz1gQ50P0744907449epcas2p3F;
	Wed, 25 Nov 2026 06:53:33 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.204]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jZ9PS6nFqz6B9m6; Wed, 25 Nov
	2026 06:53:32 +0000 (GMT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Subject: RE(2): [PATCH] blk-mq: scope the no-sleep requirement in
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
In-Reply-To: <awZqQEp3W5Ewp45T@infradead.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261125065332epcms2p4e172702703233beeab6a683dd69676f2@epcms2p4>
Date: Wed, 25 Nov 2026 15:53:32 +0900
X-CMS-MailID: 20261125065332epcms2p4e172702703233beeab6a683dd69676f2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950
References: <awZqQEp3W5Ewp45T@infradead.org>
	<20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950@epcms2p8>
	<CGME20261124002518epcms2p847d3246dc989469f326f7a2b47f2f950@epcms2p4>

On Wed, 25 Nov 2026 at 13:55 +0900, Christoph Hellwig wrote:
> This commit messages reiterates in annoying detail what the change does,
> which is mostly obvious from the code.  It entirely fails to explain
> why you want to make this change.

Fair. The motivation I left out: BLK_MQ_REQ_NOWAIT is mandatory in
blk_mq_alloc_request_hctx() only to keep blk_mq_get_tag() from re-picking
data->hctx after io_schedule(). But the same flags value is passed on to
blk_queue_enter(), so a caller also takes -EAGAIN for a transient freeze
that has no bearing on hctx selection. There is no way to ask for the
hctx guarantee without also opting out of waiting.
