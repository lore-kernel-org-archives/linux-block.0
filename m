Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4831C6B5;
	Thu, 22 Aug 2024 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318822; cv=none; b=iEtbkIk9yKIrE5xDRltyFioKqLe9fTmMIhvmsBhst0oWg2y1g/XHDVNVFvMUx55eKKWAX3zXb0o/4zMws1/CDRnSgJ2fc0fG9ppFHx/5QCkFSQbj/NWDcrtK4JamDvbxMNaeI+l0nwJqtXxJv9EPuR8fau9wh4PfngdORzcR4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318822; c=relaxed/simple;
	bh=TaiVPQ5rR0ZNBImhsJxgRxIyaRggKmWmQwltsR1CBdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdgiaDs/uwVBMLegnGp/zgj4aC4YyrIOvzAh3Z0wYi0u698O8oLEm/Q4vzBZOXHlRR2nuEiJ+GRIZVTjc0ohpltWp11eM5gMPrgjZwmPlbNHfXO3FMzXO0LBdBuEuZgiH48Ik5iA8QWqF4x0PlvmN0X+WBRTqMIdh1U7lnBKS/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEdBqw5d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEdBqw5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0B0C32782;
	Thu, 22 Aug 2024 09:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724318822;
	bh=TaiVPQ5rR0ZNBImhsJxgRxIyaRggKmWmQwltsR1CBdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MEdBqw5dkKnsocx8AkDPu1PP0tAOCi3zCH+AUcGE13seAk4jJ/NP226G8X/ya/Wih
	 Q2t0RQIJiPgDIsaWxVrAC2jkf0V+/9pFC/oMXnRTLkl+45G0yhbK+29675uvP93gWF
	 1CdQDCm919jHgzsfCbPTyVcB1iPbK85PrLhidLQUNBfplsQkuV/MPQCl7CE+B1y7TG
	 mzzoIJRGQM2XRDcUj2LLfS8JQa5UaLMb3SSM+Vy+rxmiLwy4p2QoNCmDlR19OY31XI
	 fcz9njyFu0yyIct1KUUs1i/mcZ+ZEuS+qu+EbzZXNcGNMw2/TB6ZKVVhA8ienMxwfe
	 ScDDmWaTvH2Zw==
Message-ID: <f3d2c9ca-7b46-4546-af87-9f9127c1e178@kernel.org>
Date: Thu, 22 Aug 2024 18:27:00 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drivers:block:Fix the NULL vs IS_ERR() bug for
 debugfs_create_dir()
To: Yang Ruibin <11162571@vivo.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240821064932.6592-1-11162571@vivo.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240821064932.6592-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/24 15:49, Yang Ruibin wrote:
> The debugfs_create_dir() function returns error pointers.
> It never returns NULL. So use IS_ERR() to check it.

...to check its return value.

And the patch title could be better. May be something like:

pktcdvd: Use IS_ERR() to check debugfs_create_dir() return value

> 
> Signed-off-by: Yang Ruibin <11162571@vivo.com>

This needs a Fixes tag.

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
>  
>  	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,

-- 
Damien Le Moal
Western Digital Research

