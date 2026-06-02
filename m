Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFCC3C5DBE
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440190; cv=none; b=n+J57sxYFKvT4+SGUkg0UJG0f5AgIstuwemCyjwKY0e3ruiBf6g/CxbaPwWhjtq+e+w+aa3uG08NWFyaVC2Zw5sNtCeNw5wAkorqmyaKHjWF9wpJONrxk/M7MrpamYAQDmI2qv9GbOJGqqLNLX4adtqP6kmzmc0tZh4Mvuk/taE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440190; c=relaxed/simple;
	bh=4PKJSoTsZm3jSxa98aPahcVrcp4r5ulkwgZKz08OWvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoKb++HwevkG3WPNrWafigFtvIw4JY0NFq13N+GA6+5IggL/N99xbis4Av/ELLmMqouDzBl8kKebEu05mEHF5VklYW5ePTBzOXUpvTDdgvnBwgt5V9br003TbM/M3NvoPu2aOC8XA/P1KjonLseTR3hJJqWLN9PnAfJzBWfAu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fwV842XO; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fwV842XO"
Date: Wed, 3 Jun 2026 00:42:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780440185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZrbifNlPB/yayEapv3XsRF4Y7LSXjoFhBHa0c2MBAk=;
	b=fwV842XOeCKjJhFVppFMcNkrqkBUV9wV6qx7zEqbbLnvUI6eQMjNUe4evVGwrpMzT0HNrK
	xjKw4C6gsPNemzhaVsenMPrhUYeUsVPZX5tUU8bBTorYxaExofNGv6UTlzgiSB98+DvNz4
	edfooxierGu/dihcSnjHvYKEWWuIoOo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] n64cart: use strscpy in n64cart_probe
Message-ID: <ah9ccwtc10j1v-dO@linux.dev>
References: <20260517172617.3954-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517172617.3954-2-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

Gentle ping?

On Sun, May 17, 2026 at 07:26:17PM +0200, Thorsten Blum wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. While the
> current code works correctly, replace strcpy() with the safer strscpy()
> to follow secure coding best practices.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/block/n64cart.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
> index b9fdeff31caf..328da73b6f2c 100644
> --- a/drivers/block/n64cart.c
> +++ b/drivers/block/n64cart.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/string.h>
>  
>  enum {
>  	PI_DRAM_REG = 0,
> @@ -145,7 +146,7 @@ static int __init n64cart_probe(struct platform_device *pdev)
>  	disk->flags = GENHD_FL_NO_PART;
>  	disk->fops = &n64cart_fops;
>  	disk->private_data = &pdev->dev;
> -	strcpy(disk->disk_name, "n64cart");
> +	strscpy(disk->disk_name, "n64cart");
>  
>  	set_capacity(disk, size >> SECTOR_SHIFT);
>  	set_disk_ro(disk, 1);
