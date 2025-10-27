Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9EF239E7E
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545001; cv=none; b=Fek5enpMVNLmg17o5haXjqleLZ//Pv3KYH+yFCtLgGDFSBF6U7sLS4HCQqEMPqKxPYL+bF0kmEZkh+4GDUo0MjAJifT8Kd8N/0D4D14ZYMyk3+XtxMk2CHoFswWZacN9d+4/l+LaDTByqxd1Uyohr6O+UpkCgqT2U3kDCzIZ2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545001; c=relaxed/simple;
	bh=/auc4MZr+OajYd+OaNGYpbLP19jFu2OHIO1Jq/ypq8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=VHfiJuqvt+/tFHaOzZiJelphcTHCzREGqXU1tNJCc+Mrr62aZUISuKp+S0P5/gRKGytHiTe5oKXCpz+zceN4L0l7aWkqA3kKq10BJA0KZ5X/8+D7UnifueLHTuyYgUTijcxvm/6CuQw9c/pH8xSQvrShPJPmJqB/HAIkvSDZky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OgePVYlo; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OgePVYlo"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251027060309epoutp0422ef3350942790598fd6ba50dc478f4d~yQ9XUbJAZ1471314713epoutp04a
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 06:03:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251027060309epoutp0422ef3350942790598fd6ba50dc478f4d~yQ9XUbJAZ1471314713epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761544989;
	bh=vZJD6tbrr7iDfFmW+CWqwnzZbJ2h3gEHO1zpYTWAHuI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OgePVYloTzMwdpjohkzCoRbk4F594k8Tqaycd53CWK/4krMeBYswwPY0NbmBS9PBu
	 wtuTBit1R7Y5ZmbTlhnks9aswEv8cxqajljKWVsieRawVmwlKi8iZaFx6DEc+WMjxL
	 pSM50i2hP1e3Hs47qMMg0/B6/xElN1FimN/KL+dM=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251027060309epcas5p146799ade6f600a50131d97b45f1b58dd~yQ9W4y1Ee2957529575epcas5p1Z;
	Mon, 27 Oct 2025 06:03:09 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cw2x82ngLz2SSKh; Mon, 27 Oct
	2025 06:03:08 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251027060307epcas5p1eb3ad9d4926616811459f164f5b55354~yQ9VfuJ5m2957529575epcas5p1T;
	Mon, 27 Oct 2025 06:03:07 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251027060305epsmtip28f9d9c355023391ee7a7d7094627680f~yQ9TSqnzg2329923299epsmtip2B;
	Mon, 27 Oct 2025 06:03:05 +0000 (GMT)
Message-ID: <03b69a96-161f-4c5c-90f9-9be55d58d8ff@samsung.com>
Date: Mon, 27 Oct 2025 11:33:02 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block: make bio auto-integrity deadlock safe
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
	<akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, David
	Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, linux-block@vger.kernel.org,
	linux-mm@kvack.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20251023080919.9209-4-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251027060307epcas5p1eb3ad9d4926616811459f164f5b55354
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251023081005epcas5p371dc081977202f0e60a47067d8109064
References: <20251023080919.9209-1-hch@lst.de>
	<CGME20251023081005epcas5p371dc081977202f0e60a47067d8109064@epcas5p3.samsung.com>
	<20251023080919.9209-4-hch@lst.de>

On 10/23/2025 1:38 PM, Christoph Hellwig wrote:
> @@ -194,6 +194,17 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
>   					(1U << bi->interval_exp) - 1);
>   	}
>   
> +	/*
> +	 * The block layer automatically adds integrity data for bios that don't
> +	 * already have it.  It allocates a single segment. Limit the I/O size
> +	 * so that a single maximum size metadata segment can cover the
> +	 * integrity data for the entire I/O.
> +	 */
> +	lim->max_sectors = min3(lim->max_sectors,
> +		BLK_INTEGRITY_MAX_SIZE /
> +			bi->pi_tuple_size * lim->logical_block_size,
> +		lim->max_segment_size >> SECTOR_SHIFT);

Two issues:
- When underlying device has pi-type 0, pi_tuple_size will be 0 and this 
will cause divide-by-zero.
- The second value in above min3() is in bytes, and other two in 
sectors. So this clamping may not be happening correctly.



