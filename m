Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EEE1F1313
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710126; cv=none; b=LI12sHFrydBe6SES/jXtQtWgjle7LkrgM6E2stF83p21ZEDGnmrQDb21c5ioxmHarSWB3ITv/rTQkBWPkWPHwGNxIPGN9EB39F8NqwWN9HLr0rqatndFBYZVBCC7DnTxV7UOAiC+fhOHX4FaxSR0gEWh3ej/SloCrxdtp0htoi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710126; c=relaxed/simple;
	bh=hfwoItPPyVbupaqMFj5idQBuK6Uap58ru5LjCX/HFs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=npb6ZZPPKyEnR8DbK1Gr8Uv5qgUkJCp4nDbFcBXm6fUy7igYDdcd93VvlTC4yHXw1s5GRRIBMygXUHeq7GXTrtLnfNmxDtePq+EEELr11dZ33PbqvbNnTxA9L4tYGNyuzI2rhEcdKRDrx/1fYJb4F8cBqCmhnWlqUsADp7KAVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RJ0Bz0R9; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RJ0Bz0R9"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250612063522epoutp012f18155f5d82fd12ed1a19564d75ca6e~IOBYRI9NP0304103041epoutp01M
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 06:35:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250612063522epoutp012f18155f5d82fd12ed1a19564d75ca6e~IOBYRI9NP0304103041epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749710122;
	bh=SGZHR6E+1XHwEXuH4bI7b8/heNltq39V3eoiOJ96fDU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=RJ0Bz0R9fN7S+zLXxBSR4ct75hfS3IEg0HX20m+zhKlpMVTw3SEi54p92wIJbVVNv
	 Tf4HRJNzNyRDmjKDyvkhlWV0vbFh6x36ZzMRJ5eLfJ/R3T71uTtvwRCjojoTdZAXvK
	 9gLOP73FdI8CfuOr7YFsfRGiWk2sh30TlNzaeT6Y=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250612063522epcas5p47e4907fd238737ef4195fd625fe6b3e8~IOBX3C3pT1936419364epcas5p4z;
	Thu, 12 Jun 2025 06:35:22 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.180]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bHt7X4yVfz2SSKb; Thu, 12 Jun
	2025 06:35:20 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250612063520epcas5p41c169bd6781f2df727dc980cef8ef1f8~IOBWAjQo_1936419364epcas5p4p;
	Thu, 12 Jun 2025 06:35:20 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250612063518epsmtip2cc0af3549ea92ff5de7d6a08bdc4c51f~IOBUt9gf40515505155epsmtip2r;
	Thu, 12 Jun 2025 06:35:18 +0000 (GMT)
Message-ID: <e7e6235b-99c3-478d-887e-4b2c9a1a14f4@samsung.com>
Date: Thu, 12 Jun 2025 12:05:18 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>, Logan Gunthorpe
	<logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250610050713.2046316-3-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250612063520epcas5p41c169bd6781f2df727dc980cef8ef1f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250610050727epcas5p3d2b58ed1a8224a141d819fdc985d1a0c
References: <20250610050713.2046316-1-hch@lst.de>
	<CGME20250610050727epcas5p3d2b58ed1a8224a141d819fdc985d1a0c@epcas5p3.samsung.com>
	<20250610050713.2046316-3-hch@lst.de>

On 6/10/2025 10:36 AM, Christoph Hellwig wrote:
> +static bool blk_dma_map_bus(struct request *req, struct device *dma_dev,

Both are not used in the function body.

> + */
> +bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
> +		struct dma_iova_state *state, struct blk_dma_iter *iter)
> +{
> +	unsigned int total_len = blk_rq_payload_bytes(req);
> +	struct phys_vec vec;
> +
> +	iter->iter.bio = req->bio;
> +	iter->iter.iter = req->bio->bi_iter;
> +	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
Should this (or maybe p2pdma field itself) be compiled out using 
CONFIG_PCI_P2PDMA.
