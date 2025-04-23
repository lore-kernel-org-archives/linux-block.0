Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616B270569
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403110; cv=none; b=JfuSsEUQIzZVaa4WM61VyG5JJSUVZ6H23mWDg+Gm8mBq9f3vjUYJeZqDCtjS+uMNeU97L46mCCbWnHTSdHqHhhddLHtbZqYGLSjmQr1NwmknTc69H/oQgU1FwxcpPJBWT1Z7YyIx9RyoJv2kpXZmJiF5HCDbJYut5RpQlmcxVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403110; c=relaxed/simple;
	bh=0rzldctYCd5gvWIfDIgHHJXEgT7zpTZ6vRCeMpSt1E0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HYu7wcsXOnTd30s5glATmbG/3vYKuZ0MiSubJRVp/MOIEcaUSzV77SporgSuJe8MxHG3OHFnLEi4+lhGV+zIJW1QbkSzzTg+s4gvcQyzdgSAuJ99LKjwa1p2gRsjwTzrruYJrsqz+rLUQL/PX9t5yCvvkbXtJiTVqiaqvmYN0OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id 9ACDA108B;
	Wed, 23 Apr 2025 12:11:42 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 3CA50600BE060;
	Wed, 23 Apr 2025 12:11:42 +0200 (CEST)
Subject: Re: Block device's sysfs setting getting lost after suspend-resume
 cycle
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block <linux-block@vger.kernel.org>
References: <32c5ca62-eeef-5fb5-51f5-80dac4effc98@applied-asynchrony.com>
 <aAiKM0-1JJulHLW7@infradead.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <cceea022-a5e3-97b3-62ed-7ead174565a3@applied-asynchrony.com>
Date: Wed, 23 Apr 2025 12:11:42 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aAiKM0-1JJulHLW7@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2025-04-23 08:35, Christoph Hellwig wrote:
> Hi Holger,
> 
> can you try the patch below?  It fixes losing the read-ahead value in
> my little test.
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 6b2dbe645d23..4817e7ca03f8 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -61,8 +61,14 @@ void blk_apply_bdi_limits(struct backing_dev_info *bdi,
>   	/*
>   	 * For read-ahead of large files to be effective, we need to read ahead
>   	 * at least twice the optimal I/O size.
> +	 *
> +	 * There is no hardware limitation for the read-ahead size and the user
> +	 * might have increased the read-ahead size through sysfs, so don't ever
> +	 * decrease it.
>   	 */
> -	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
> +	bdi->ra_pages = max3(bdi->ra_pages,
> +				lim->io_opt * 2 / PAGE_SIZE,
> +				VM_READAHEAD_PAGES);
>   	bdi->io_pages = lim->max_sectors >> PAGE_SECTORS_SHIFT;
>   }
>   
> 

Tried several different readahead values across multiple
suspend/resume cycles and it retained them properly again.

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

Thank you!

cheers
Holger
