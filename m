Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7376E2BEC45
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 04:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402462; cv=none; b=eMu+8yl9Um4tKmF4lBAyyVAFODELel6rrEADHjNLxxnp1b+mPl7IdCVqzXtiqCqgWlUntlOObRzVNyM/c4aQITtRCtibwT/9UC2Lay3opyaedQvFy8S2KTxTRz+DTe5O50gG0leUeCpV8zKgHvj4Qh8I+Jz3P7XXpa+eZVkKHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402462; c=relaxed/simple;
	bh=tIfjhpSrmWEiiJgWoQFTFpt/MTenni44zbTIOJXs+64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpJLSxKD1XITdQn+yDxUAXUnNcMeMPkjdZHcAwRdaZ503bCDhelZpRK/kTQ1MIsIq59n+r9e8HuPOPno1EmY+aDlxjfHbdqmbeNl798hHzc2drESBGegQoml8BI5LILCj0D1V2RnX/gQ5Hdbl7NSORRWD0zMvnKXbzzqx2VFvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UreWUrSc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UreWUrSc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E594C4CEFB;
	Thu,  6 Nov 2025 04:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762402462;
	bh=tIfjhpSrmWEiiJgWoQFTFpt/MTenni44zbTIOJXs+64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UreWUrScFdwlEetO9At9CCHYEfzpzu6zFuWzZGLl1pdsJMABmHEx+snGmURm48+yX
	 6Onp5Wedl8CDx9krkNCkPCccqpoCs0nhUnyT767UgUcg2BJjzJ1DE2yxVNZmc3zRPs
	 19o0rEy0QntkuqZNZcnOs62KkCTQAv0c/iC+iXDtVIEFtm2YVQC7ZyKJYm5wPE1MfP
	 /DKDeOch1/JVrtw0b/szCnImMufnUtrDC/7jLcN82K4itGAbD41+/qE9K60yjUKGf1
	 Jj5NlXYNfo6J6EREnT9yJ64814XdqTP4/hGrG/my48WNRFf8mSEYBeLYM0ICqmt/14
	 CjaglqEZhH7Pg==
Message-ID: <ad303562-5b34-4156-94f1-516787e873b1@kernel.org>
Date: Thu, 6 Nov 2025 13:10:28 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: fix cached zone reporting after zone append
 was used
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20251105195225.2733142-1-hch@lst.de>
 <20251105195225.2733142-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251105195225.2733142-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 4:52 AM, Christoph Hellwig wrote:
> No zone plugs are allocated when a zone is opened by calling Zone Append
> on it.  This makes the cached zone reporting report incorrectly empty
> zones if the file system is unmounted and report zones is called after
> that, e.g. by xfstests test cases using the scratch device.
> 
> Fix this by recording if zone append was used on a device, and disable
> cached reporting for the device until a ZONE_RESET_ALL happens that
> guarantees all zones are empty.
> 
> We could probably do even better using a per-zone flag, but the practical
> use cache for zone reporting after the initial mount are rather limited,
> so let's keep things simple for now.
> 
> Fixes: 31f0656a4ab7 ("block: introduce blkdev_report_zones_cached()")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for this ! I did recreate this issue with zloop as well.

One nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> @@ -1474,6 +1487,9 @@ static void blk_zone_wplug_handle_native_zone_append(struct bio *bio)
>  	struct blk_zone_wplug *zwplug;
>  	unsigned long flags;
>  
> +	if (!test_bit(GD_ZONE_APPEND_USED, &disk->state))
> +		set_bit(GD_ZONE_APPEND_USED, &disk->state);

We could remove the test_bit() here and unconditionally call set_bit(): single
atomic op instead of 2.

-- 
Damien Le Moal
Western Digital Research
