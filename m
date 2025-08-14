Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FECE318146
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167776; cv=none; b=Az9nxI6HBiCkB5oGpHNXipewHPAPBFu65ne/I3vno5sX/Sl99lsVSXkqoTmQey4aOt2CMqFMgT5C6PQ0ZbVRhuK6+VeXtzhc0+gaD7ov6HRIL/5CYkz/BFAOFgPY2EnzA3sXGQD063e2ots9LGiYJq4mbeRoAd3yBsL8+5/L5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167776; c=relaxed/simple;
	bh=FAsOnHJrXTTmM+67qnX76GBD+5Rmrq11A//vrItApgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=mZ9EKieFrgDFcVSs+byhBLxl/FQzQTMQMVT7QKO7EnzFPoJZwOrYPKCmC5CMsJLoO0iW7lAL/EFrEluyGG0sR90xTdxfK76ObEeCWSbXvNtcRpdZBZXK4BB+9afst0e3fAvboardTEqCb3WeoLaepjo9aPYMVYZsVZ71E+nmkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jFDYWVVU; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jFDYWVVU"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250814103609epoutp030c32ed5a7e9425aa30a82c251e17c39b~bm8l5fSjj1747417474epoutp03Z
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 10:36:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250814103609epoutp030c32ed5a7e9425aa30a82c251e17c39b~bm8l5fSjj1747417474epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755167769;
	bh=vMirkc2jYuhoLkWn6g3tc/zu7BWTS2mjJ3h8QSa13pk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jFDYWVVUjWEPvEWDPVw6Ih9+ucoJFun2CjtSp30PFTtM1yhA8bmH2Zfm7oJV2Q+fi
	 iTCgcl8YjoXuaDJQsypeZ9ebyFBlVXWOjWf5COVYsRiwsYqFngd7Xuz6ZRUHHLYdFE
	 gkeu2+gsGcdaGs1JZ7driwHN22JVf4roXlfSG9Bk=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250814103608epcas5p205526093f113b331cd6c17935fe9859b~bm8lKsWJm0668706687epcas5p2r;
	Thu, 14 Aug 2025 10:36:08 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c2hVH6lJ5z2SSKY; Thu, 14 Aug
	2025 10:36:07 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250814103607epcas5p2b8b562d3df9e005e3ff746d3b3f93978~bm8kJ-Ecr0668706687epcas5p2q;
	Thu, 14 Aug 2025 10:36:07 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250814103606epsmtip1f2a6eb39e6280c9fa84c7a1604d3bc01~bm8jUSAR72509225092epsmtip1f;
	Thu, 14 Aug 2025 10:36:06 +0000 (GMT)
Message-ID: <0cbb90b6-c25d-4700-90b5-5628690834b1@samsung.com>
Date: Thu, 14 Aug 2025 16:06:05 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 6/9] blk-mq-dma: add scatter-less integrity data DMA
 mapping
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250813153153.3260897-7-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814103607epcas5p2b8b562d3df9e005e3ff746d3b3f93978
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813153221epcas5p19194a22c9206de885b1c3f04ad6e0e80
References: <20250813153153.3260897-1-kbusch@meta.com>
	<CGME20250813153221epcas5p19194a22c9206de885b1c3f04ad6e0e80@epcas5p1.samsung.com>
	<20250813153153.3260897-7-kbusch@meta.com>

On 8/13/2025 9:01 PM, Keith Busch wrote:
> + * blk_rq_integrity_dma_map_iter_start - map the next integrity DMA segment for
> + * 					 a request
> + * @req:	request to map
> + * @dma_dev:	device to map to
> + * @state:	DMA IOVA state
> + * @iter:	block layer DMA iterator
> + *
> + * Iterate to the next integrity mapping after a previous call to
> + * blk_rq_integrity_dma_map_iter_start().  See there for a detailed description
> + * of the arguments.
> + *
> + * Returns %false if there is no segment to map, including due to an error, or
> + * %true if it did map a segment.
> + *
> + * If a segment was mapped, the DMA address for it is returned in @iter.addr and
> + * the length in @iter.len.  If no segment was mapped the status code is
> + * returned in @iter.status.
> + */
> +bool blk_rq_integrity_dma_map_iter_next(struct request *req,
> +               struct device *dma_dev, struct blk_dma_iter *iter)
> +{

The function comment should also use the name 
"blk_rq_integrity_dma_map_iter_next".
Otherwise, looks good.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
