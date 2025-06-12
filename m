Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33E91F1313
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709481; cv=none; b=WalEmlGayNn53tVxjsU/+yJ9IpZB/axaDPzCkQmsy59DCvfE/ZQVOmPAvFlQ+J4978dz7wTRCeQEjJVcCfUu2a6HG3D0n7vAWnmfTQ02hkQsxLnMfkbVpYCTeJC6VO6iRt6GGfmIGgkRamGgfqtSyB2+MFdFoCTLeuNeBGDTfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709481; c=relaxed/simple;
	bh=/hmPVZcpOW3BoRGbrGLVszEJGz0BVeezTIFatC4dNyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=tBZPb4xPZwbfdDr+aXREKwad2sadlMgAc7iuYrHReWO4T55b41afRXUXaYQWpIpYqoD6IWMH8XMeK30LdS4oylHxarak9INYCyBvkN1pGb6y+6Id6Or/0hdAmkJQS6/o/1aqnvD9PzKzfFZ5uFN4YZ9u8HfjoYS9WzIw++SiFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZjFpl50f; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZjFpl50f"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250612062436epoutp01220eb2e5945ebc7fb38450b52abe044a~IN3_n1K5r2591525915epoutp01L
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 06:24:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250612062436epoutp01220eb2e5945ebc7fb38450b52abe044a~IN3_n1K5r2591525915epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749709476;
	bh=UtPymdd8LPXoV15uEH9uSYo/uGh6AqBmwQzP/RMvyGU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZjFpl50fvd9FHdWLEQl0C99J0G3ebipD+knz4D/naJG1SD3qF+48rISN9o/qClCDt
	 Fh/Wj92/qq4XRVFP7H9oxHvU9ySM4/D/wqInr3yDJY09HsA5aVA/oeK3+iBEta1B68
	 j821rwWpkKc1Uew6P7nc2Jv2bsn5z3qFJC3RP80o=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250612062434epcas5p340bce2c2519adc20e0d234883a45f900~IN388h_cH1502115021epcas5p3a;
	Thu, 12 Jun 2025 06:24:34 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.175]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bHsv44bdlz3hhT9; Thu, 12 Jun
	2025 06:24:32 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250612062431epcas5p1eb2ce99af9b6aa2367d26b3db8804b73~IN36PhV6c3170231702epcas5p10;
	Thu, 12 Jun 2025 06:24:31 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250612062430epsmtip23f092a27f487341f12eb593eb6b30b36~IN349aphG2969629696epsmtip2C;
	Thu, 12 Jun 2025 06:24:30 +0000 (GMT)
Message-ID: <c75ac878-376e-497b-b4fe-ddd54733c090@samsung.com>
Date: Thu, 12 Jun 2025 11:54:21 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>, Logan Gunthorpe
	<logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250610050713.2046316-2-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250612062431epcas5p1eb2ce99af9b6aa2367d26b3db8804b73
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250610050728epcas5p343c293cd81ffb03b6f12dabfcf2fd8d4
References: <20250610050713.2046316-1-hch@lst.de>
	<CGME20250610050728epcas5p343c293cd81ffb03b6f12dabfcf2fd8d4@epcas5p3.samsung.com>
	<20250610050713.2046316-2-hch@lst.de>

On 6/10/2025 10:36 AM, Christoph Hellwig wrote:
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -930,8 +930,6 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
>   		return false;
>   	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
>   		return false;
> -	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
> -		return false;

I did not understand the value of moving this out to its two callers 
(bio_add_page and bio_integrity_add_page).

Since this check existed, I am a bit confused. The thing that patch 
title says - is not a new addition and used to happen earlier too?
Or is this about setting REQ_NOMERGE in bio?

Flagging P2P bio with the new flag REQ_P2PDMA seems preparatory work to 
optimize stuff in subsequent patches.
