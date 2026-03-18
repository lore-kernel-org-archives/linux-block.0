Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051C0213E89
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773817787; cv=none; b=dGMUTXHN5yXSeOxUF+nFyO9edXDr2B/qdkd7t3IpZYaY/sI4hY4d2YrTJqywY1pcB43HWVd4zT0TSS9N2qP1cMJBaf2p/18bwwZWybKmNakqU2gmuswmitn3DNLCCVn3qGJ3r4AYvXY/9c4Q8ZCt9jEPY/Qmjxq08OPuEvRKgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773817787; c=relaxed/simple;
	bh=0D4gnMsabiJ034u12SyMviVywYttxi8gJ1h+l0Hl4iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBgbLE3Ilpm0Bchh3XpvhTXgx1/Wn5DmDbDp6+BXn+Z96XFs9Z+sbehct+tHuN0O+Ohl9CA8vM4U2T7RKpLIVMFePL3gN3g+s0KIAG61fL0C+mEuX8W72JFytBcQwBifmWywtbAmkTBBsJF0EXVSs8gUV6WCw/lW/u1AT1fdUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p50CzfS9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p50CzfS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D52C19421;
	Wed, 18 Mar 2026 07:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773817786;
	bh=0D4gnMsabiJ034u12SyMviVywYttxi8gJ1h+l0Hl4iE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p50CzfS9ln0cGtF8gPw56c087zTOW2TSV2IG3Ikd8VRGGzGeetG7gALLQfrm+VUq3
	 4E8IleAw7vnMT1kTsFl32q4o3nenq/1sY5qcgOnIpvusJ15Ytv+bysQjSngiOoJZix
	 FxyKJ1re9TjeuBuaxBj+MUPL7nmigLmy2UTDffw/5bg9hq72ZsBP74gp21c6t3pEPV
	 2cldg7CYyGUUUBwFsrXgvn8Go/1FMIVw/NSW1+jAz9eIJbMDiCs24zfOAAvYZ2/QM1
	 MwIsrxN8nMuSJdKdGC6vSEYlCp3wOHrw+MwHcwIFt2lCUSbBmF2Hp2QUEQc9WJX41l
	 SVJu8oTmflhSQ==
Message-ID: <832989a6-f964-4632-a07a-0314f2483b0c@kernel.org>
Date: Wed, 18 Mar 2026 16:03:58 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] zloop: forget write cache on force removal
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260318055331.1824108-1-hch@lst.de>
 <20260318055331.1824108-3-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260318055331.1824108-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 2:53 PM, Christoph Hellwig wrote:
> Add a new options that causes zloop to truncate the zone files to the
> write pointer value recorded at the last cache flush to simulate
> unclean shutdowns.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me. One nit below.
With that corrected:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  .../admin-guide/blockdev/zoned_loop.rst       |  5 +
>  drivers/block/zloop.c                         | 97 +++++++++++++++++++
>  2 files changed, 102 insertions(+)
> 
> diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
> index 6aa865424ac3..237ee2fccb82 100644
> --- a/Documentation/admin-guide/blockdev/zoned_loop.rst
> +++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
> @@ -104,6 +104,11 @@ ordered_zone_append   Enable zloop mitigation of zone append reordering.
>                        (extents), as when enabled, this can significantly reduce
>                        the number of data extents needed to for a file data
>                        mapping.
> +discard_write_cache   Discard all data that was not explicitly persisted using a
> +                      flush operation when removed by truncating each zone file

			 flush operation when the device is removed by
		         truncating each zone file...

> +                      to the size recorded during the last flush operation.
> +                      This simulates power fail events where uncommitted data is
> +                      lost.
>  ===================   =========================================================


-- 
Damien Le Moal
Western Digital Research
