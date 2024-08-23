Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BFD156C69;
	Fri, 23 Aug 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409997; cv=none; b=aLiFn5tZZmw8Hmbom7B24ZaZjNmASzHc9B6rPKzJlcb5fOUJvjwoUgxCL6LJeapQnLBqbCzMqQqxCGIZrndTuYYlw0r7iGQe/4DFjBwghKT6rpz7xDx/R7LygdpFZkkna+jnsQ7b0loXs9wOfxy/NZKeDmF41k6EiUjb/mcKTSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409997; c=relaxed/simple;
	bh=ODXL1+0ktJnQ96irwigR67GLfIMiIqnFjBqah/vYlYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e04OZs92f2P+vjiPl5BhcAeNgQgV4IPD5V5F6NApaj/t99q+mPxXxmvesf6C4jXi611h4UhnP21LTY9xKYarTyeqcOYXCCj/U1tx6rlO9VpsIJ/Fd94QjTxU4C7XBr2u5hGCPP4618jVWWNadSQ9IgViTex98IV+vcrsaj4DBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J0HMtOer; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J0HMtOer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AA5C32786;
	Fri, 23 Aug 2024 10:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724409997;
	bh=ODXL1+0ktJnQ96irwigR67GLfIMiIqnFjBqah/vYlYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0HMtOer5GAPTA7uUw2MqAvgyKymhif6SLLwdbdu2m/FmDmcrigUqMRbqhd/1GeSL
	 HWh2iKImg6wTC9eec7SClLTE2D8qz7P2Zr2POxbJHU/9D3E3zMewrEeL/b2nULkcNQ
	 3zcKIZRHG89bcnTvxmBKKnDJCFxEgWAR34urGMcQ=
Date: Fri, 23 Aug 2024 18:46:34 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yang Ruibin <11162571@vivo.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v3] drivers:block:Use IS_ERR() to check
 debugfs_create_dir() return value
Message-ID: <2024082331-passcode-widget-a88f@gregkh>
References: <20240823101047.3755190-1-11162571@vivo.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823101047.3755190-1-11162571@vivo.com>

On Fri, Aug 23, 2024 at 06:10:46PM +0800, Yang Ruibin wrote:
> The debugfs_create_dir() function returns error pointers.It
> never returns NULL. So use IS_ERR() to check its return value.

Close, but no.  Please just never check debugfs functions, you shouldn't
need to do that at all.

> 
> Fixes: f40eb99897af ("pktcdvd: remove driver.")
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
> Changes v3:
> - Add corresponding fixes.The revert original fixes information 
> - is used compared to the v2 version
> ---
>  drivers/block/pktcdvd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index 7cece5884b9c..030b7a063a0b 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -498,7 +498,7 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
>  	if (!pkt_debugfs_root)
>  		return;
>  	pd->dfs_d_root = debugfs_create_dir(pd->disk->disk_name, pkt_debugfs_root);
> -	if (!pd->dfs_d_root)
> +	if (IS_ERR(pd->dfs_d_root))
>  		return;

No need to check at all, no logic should care if debugfs works or not.
And any return value from debugfs can be passed into other debugfs
calls, so it's safe to pass in errors that it gives you.

So just remove these 2 lines please.

thanks,

greg k-h
