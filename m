Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30539A937
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 00:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720053282; cv=none; b=kiyCKJ047DxOad1vkMOkT67zpl73uBOfHnFiIuMqJtANRGOUpN50W9qw6OW490SJXQuA6bvw5BOoB2cAmYTwOyoJ8RflOaTa9dspZBsUYkVd2Qe3Qa3q9IGdXnJwa2e7tx7ef01pOFAFOhkgb7JWFB/pCVy10j33t6386zPM6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720053282; c=relaxed/simple;
	bh=MTX4HmUcQncEPQajo9Z/lZreymr2fh/UbiIRrmtgG64=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RQisQPbhFMuBIfk9gq9NkJe6O0e0hLQL+gl2vzhRA1oJxSusnBrPdet46AWzQCPeq5a6Hgez2ATTZ5N14+T+nCkvDRBZJdpms/2LU1AXoilHZog8J2q8kDENadxJkHBzn5SqJj4b6WxAUgVCngAQOTKAXN3+7OOzAA3F8M4HM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gvj4PK+L; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gvj4PK+L"
X-Envelope-To: dlemoal@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720053278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWao+DTQ74ElcgKuqbztQLq0RqYnYK5+MlaXZjxpEbk=;
	b=gvj4PK+LvqeiBAlIfEi9oMAt0fVwCGj2UPdnYR/n26F7Pb12gl9qDr/kIUIO8cfBzNDtWo
	eGVWat76E38Cp/UlzFz2bL+MSUAoYaWBw7BWX3a0eS6DpiLU1R4+19SMVHRqYHlzoN2jcC
	roRrXAverjvdItEBUariwB9ibG6Q0tk=
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: linux-block@vger.kernel.org
Message-ID: <8679c3f5-d5fc-4a6c-8534-1880a3647e2b@linux.dev>
Date: Thu, 4 Jul 2024 08:34:30 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] null_blk: Fix description of the fua parameter
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20240702073234.206458-1-dlemoal@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240702073234.206458-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/7/2 15:32, Damien Le Moal 写道:
> The description of the fua module parameter is defined using
> MODULE_PARM_DESC() with the first argument passed being "zoned". That is
> the wrong name, obviously. Fix that by using the correct "fua" parameter
> name so that "modinfo null_blk" displays correct information.
> 
> Fixes: f4f84586c8b9 ("null_blk: Introduce fua attribute")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/block/null_blk/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 83a4ebe4763a..5de9ca4eceb4 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -227,7 +227,7 @@ MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (
>   
>   static bool g_fua = true;
>   module_param_named(fua, g_fua, bool, 0444);
> -MODULE_PARM_DESC(zoned, "Enable/disable FUA support when cache_size is used. Default: true");
> +MODULE_PARM_DESC(fua, "Enable/disable FUA support when cache_size is used. Default: true");

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   
>   static unsigned int g_mbps;
>   module_param_named(mbps, g_mbps, uint, 0444);

