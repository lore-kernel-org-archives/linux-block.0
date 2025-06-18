Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D202556E
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750240036; cv=none; b=m/0959wVia5sspInw0F0Z5RbYmBMEtE9BiO0lx7+IteKF2dlfjM8ndx2eenN3+6G3DRUjMSdX/JI1x4wpMJJzKILp8GoY3/sbBmCUzvD+bINmuPCKY2yRgMWaOfIIaB1E+na4bFElZ3QJd8MnzGnuI2ZCIVfLqgRCTxfk2m7DgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750240036; c=relaxed/simple;
	bh=vUmX690y/2Y6i7LK8fdnv5dekJtZXoCKros3W8lb+nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlHWtRFjsnhAC+QUoXcp9EGdvD47uxI0TURXP/tJWHcXHoI6gRBor5Rin380aI1pko3URDnbpSXFaCwY3C0UysSg7i/llOkpPTMz7uo0InjvpNWz+6PsH7dw8w4T1sfnQ5ipNL2m0qmFlsyj4h09QQHOVwSXpRGJ3wsxUUyPSMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g92+UwHx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g92+UwHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B537C4CEE7;
	Wed, 18 Jun 2025 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750240035;
	bh=vUmX690y/2Y6i7LK8fdnv5dekJtZXoCKros3W8lb+nw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g92+UwHxuCWLh7WXbTKcB3uzvuYm6b30+zRsqB+dSjbYplnwbFiH3XYLpcCcW7Acf
	 3nst0cisQgw3vPdnrZ/axWaeY6+fKz/kDyBmVk3GplYbY5KV+XRYssmutZoAnx0H3l
	 /fc6S+RTE1eH0r89+VaGILHG/CTyFwtOEO1Vq5/MkpGnEwSAD+e5AdVp6SdO4Cwv+B
	 n3ai/4hsg5B/0pBqp+Yv/ys3/glyOG625Vv/xVIAUlJcWJN3pfK4CDEZk0RQddhxXo
	 7mZAoFBAblhMEJcW2RyYF65S5NGLxCHKIMtwDasUPN+Q1JFyJUtZ1g48BlTr0tZ/co
	 2AapLxszdPshA==
Message-ID: <99834ce9-a581-4998-bd23-d66d20f990fa@kernel.org>
Date: Wed, 18 Jun 2025 18:47:13 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: John Garry <john.g.garry@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <acc347c6-5b75-40e0-b9c0-ba70819bdcd9@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <acc347c6-5b75-40e0-b9c0-ba70819bdcd9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/25 18:06, John Garry wrote:
> On 18/06/2025 07:00, Damien Le Moal wrote:
>> Back in 2015, commit d2be537c3ba3 ("block: bump BLK_DEF_MAX_SECTORS to
>> 2560") increased the default maximum size of a block device I/O to 2560
>> sectors (1280 KiB) to "accommodate a 10-data-disk stripe write with
>> chunk size 128k". This choice is rather arbitrary and since then,
>> improvements to the block layer have software RAID drivers correctly
>> advertize their stripe width through chunk_sectors and abuses of
>> BLK_DEF_MAX_SECTORS_CAP by drivers (to set the HW limit rather than the
>> default user controlled maximum I/O size) have been fixed.
>>
>> Since many block devices can benefit from a larger value of
>> BLK_DEF_MAX_SECTORS_CAP, and in particular HDDs, increase this value to
>> be 4MiB, or 8192 sectors.
>>
>> And given that BLK_DEF_MAX_SECTORS_CAP is only used in the block layer
>> and should not be used by drivers directly, move this macro definition
>> to the block layer internal header file block/blk.h.
>>
>> Suggested-by: Martin K . Petersen <martin.petersen@oracle.com>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> Regardless of comment below:
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
>> ---
>> Changes from v1:
>>   - Move BLK_DEF_MAX_SECTORS_CAP definition to block/blk.h
> 
> it's only referenced in blk-settings.c, so I don't know why it doesn't 
> live there.
> 
> However it is co-located with enum blk_default_limits and the same 
> comment goes for members of enum blk_default_limits. I think all those 
> in enum blk_default_limits could potentially be moved to blk-settings.c 
> after Christoph's work for atomic queue limit updates.

I actually checked that and a few drivers are still using 2 of the 4 enum defaults.

Jens,

DO you prefer we move BLK_DEF_MAX_SECTORS_CAP to blk-settings.c ? blk.h has a
couple of settings macro at the top, it is together with that for now.


-- 
Damien Le Moal
Western Digital Research
