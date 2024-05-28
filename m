Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B11BDD3
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879274; cv=none; b=m7a+zxGG0n+pCtWhWiWpVUlcv/P+zC7C68puw27pfntyTbTAFEhAcz8aEH9rSubQs0dhUB189jqLwvTLXdMoiB2T92r4pr+5VfOEfCQ1BGPboX8iXUc2wyholL7F6OtJngS8/uu1a/6TFilKNtYOIps/2rNr4CQPloUx0vZTQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879274; c=relaxed/simple;
	bh=IAT310JYIhY32GUIAdO3AMu9VqkSHcRgInvBb7SRk4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYCjmiWEFlZy6ifrMZvxz+1KEf4Ec2C9oW81vFYeV248gIvNbg/IctD/et06zb7cBiYhKPsMBnYFJ5gtR6u+/8o97+JmXDad9qkfqR9IUzG/nlLSLB6S8c4L9EnuF4EvHvicGdlPaTs9qWf2BQ4uaQYwls3xefx/UwEz6romkuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwRPUqdK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwRPUqdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ED4C3277B;
	Tue, 28 May 2024 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716879273;
	bh=IAT310JYIhY32GUIAdO3AMu9VqkSHcRgInvBb7SRk4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PwRPUqdKr4zFo2SQQPZrGH5t7a6QujBbdzYglLkw5b7qbiHsB9Y9VZ/d0rf2rGN3F
	 555Ps9qKXwKxywnjSOrDJKTMCG8bFdxanU3QZ6rkDVLoMuD+8q01rT14sG3HRIbIUh
	 Cr23VTrk6gGkOX1SvlAPZutTrM2KCnFJbehWPdeA9T6OAbCOFj/HoGIjjHcfTxDrQD
	 UvHKyKa8gTdXpusXq9UKDfdKz2KuSW9NUbkhs0j8Kszyqo/QoG67DKWguDWRyk/U0b
	 HDJ0KC0XVqlT9Worp3FMS4m9DNVVcgjVCfEiPsygxuLB9lMddkwOA33A4O//5J5QeD
	 3CfvvfUyfdVGg==
Date: Tue, 28 May 2024 08:54:30 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] null_blk: Print correct max open zones limit in
 null_init_zoned_dev()
Message-ID: <ZlV_ppTeuvoIrxGt@ryzen.lan>
References: <20240528062852.437599-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528062852.437599-1-dlemoal@kernel.org>

On Tue, May 28, 2024 at 03:28:52PM +0900, Damien Le Moal wrote:
> When changing the maximum number of open zones, print that number
> instead of the total number of zones.
> 
> Fixes: dc4d137ee3b7 ("null_blk: add support for max open/active zone limit for zoned devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/block/null_blk/zoned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 5b5a63adacc1..79c8e5e99f7f 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -108,7 +108,7 @@ int null_init_zoned_dev(struct nullb_device *dev,
>  	if (dev->zone_max_active && dev->zone_max_open > dev->zone_max_active) {
>  		dev->zone_max_open = dev->zone_max_active;
>  		pr_info("changed the maximum number of open zones to %u\n",
> -			dev->nr_zones);
> +			dev->zone_max_open);
>  	} else if (dev->zone_max_open >= dev->nr_zones - dev->zone_nr_conv) {
>  		dev->zone_max_open = 0;
>  		pr_info("zone_max_open limit disabled, limit >= zone count\n");
> -- 
> 2.45.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
