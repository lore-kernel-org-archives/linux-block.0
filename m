Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27BB55769;
	Mon, 26 Aug 2024 04:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724647459; cv=none; b=LxZL3qzgHWFBGRWV/XmBcEyrGrbZOTdAvOwQrsXTJcbjFUvB+w6t1469ZBjpWHT928lBk+Obc+VLRxfjlokHK+s/a7+/cLa/6fAKaZntjCoyfD7gc6r0aA4Pxt4elUQKjS8qaFT6V+1CTtIW3+ncgAq9vrZ9tBeCiU7ZYYPSqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724647459; c=relaxed/simple;
	bh=MLNvDdlhcJKQk/CpdBe2CUbMYx6o9U4aStTOQHpuQeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHzdijgOytA0zSHqaRc+CI3jEV7+Fardc/o/mgDtSAavVae8TYLdc2I+T3FFcdu5GqfkpldxzGEXUuAXjTGmHJ6L+qT5UHQZeoOIErySUt5vQtLLd8dhRaHuaaqDz3MRqPPslZ1rlnpEuboJYyDZ8mU5GX3Wk17IDWMEM87pDSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEgnjOOr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEgnjOOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7241C4AF0F;
	Mon, 26 Aug 2024 04:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724647458;
	bh=MLNvDdlhcJKQk/CpdBe2CUbMYx6o9U4aStTOQHpuQeI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AEgnjOOrHkqu/WXLDOV+ChMQkbjWHEujBpVWs60jOK2kzVxC1RY+pGVgbYbpOveMN
	 NbBCz2u+xzDPJjFLOl7kL2aDuAhcM7dvZP5sVKXB4xuoFT+Z4zs/LEbUk36l88EHHS
	 HmZ9C2DIrUIFGJuLYK/O0tb3S0UiQWMGamRAFF4xV1MJ5jHklpgjuZ9al9X+AzKY/d
	 KNYKEi7g1hPB925G0elcdW/zLcGtEb1yUbHlCAoe5RuH2xwohS/iCExt1/285ZSmqH
	 8uG8iK9wdb2r3zZziLqlW0yeB26w7El7mX2mWN7x/VIAH7gfJPiFyIof/mPFSurPJd
	 sIQJPZtWDS6Tg==
Message-ID: <0df17bc3-5411-47de-abc1-479be5d9f822@kernel.org>
Date: Mon, 26 Aug 2024 13:44:16 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] pktcdvd:Remove unnecessary debugfs_create_dir() error
 check in pkt_debugfs_dev_new()
To: Yang Ruibin <11162571@vivo.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240826042835.1911916-1-11162571@vivo.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240826042835.1911916-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/24 1:28 PM, Yang Ruibin wrote:
> This patch removes the debugfs_create_dir() error checking in
> pkt_debugfs_dev_new(). Because the debugfs_create_dir() is developed
> in a way that the caller can safely handle the errors that
> occur during the creation of DebugFS nodes.

Missing sapce after the prefix in the patch title: "pktcdvd: Remove..."

And the commit message explanation makes no sense. You likely wanted to say
that *debugfs_create_file()* accepts a parent dentry that is an error pointer
and returns an error in such case, right ?

Also, there is no need for phrasing like "This patch removes...". We know it is
a patch, we are looking at it :) So simply be assertive: "Remove ..."

> 
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
> Changes v5:
> -Changed the subject line
> -Fixes information has been deleted
> ---
>  drivers/block/pktcdvd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index 7cece5884b9c..3edb37a41312 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -498,8 +498,6 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
>  	if (!pkt_debugfs_root)
>  		return;
>  	pd->dfs_d_root = debugfs_create_dir(pd->disk->disk_name, pkt_debugfs_root);
> -	if (!pd->dfs_d_root)
> -		return;
>  
>  	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,
>  					     pd, &pkt_seq_fops);

-- 
Damien Le Moal
Western Digital Research

