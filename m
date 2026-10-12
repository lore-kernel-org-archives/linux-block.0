Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60580362156
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811892; cv=none; b=l4zEGoEpo46zkdQ6jcl/837APRgLbKAQK4eUJxljdx+ZNw8Z4EAIIRE7emwKRQYHQIuht5I3JxIkMtr3ols50UCjcA2wjRHUBnauAEM+PX8ODWR4LQslDZhH9/AtHyReRBS7JRvYAHaqD7cr9dbLQIqxDiEqhigBupW1VTev4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811892; c=relaxed/simple;
	bh=e8NoWuZd6g2nPC6LRrkgdR58Uuwe7iKZv0GO2AHRhSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQJX066/gNo42FLaZYCckI7iSUTt1IvrGGSmB/yjfHKhkbeDlHBdHbQ0xrIVhh56Pz/3AAyEnX638PmZjwa3x3KltotNPq4MVQxfBwqOUQ+ACezj7I5uBZ+ExH29aXZIdLKwnI8f87aIur5x9oaw+4upqnEDzFOPPzal5jumBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsByhSuu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsByhSuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E531F0089B;
	Mon, 12 Oct 2026 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791811890;
	bh=U2FjSEAoHuybBsxcJ6vcM0DX+aTerz0clOSDqKghaxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NsByhSuum89fDsyJO5WQu/Z3f0bWB+DIcA3yj7IfYe8IxUjSrc2Pda7h+Fbj9Baek
	 ASQSHgGhnTRzPFAZhcw18KQM+d33j3BZuoBwLaXOUCXrKPIFGxUP1FePS40WUGRHGp
	 P90l9b23qRlQiFfHOZ3PodwIvRIXPeNyJPoiLaL3me/zD17iRQcyDaLempDWT07vRl
	 MVZv4EXJoCRwkneU7oVe64f/ETrNsuUDyT4SUO1H9GiJc5lrthkVKEswCq0CMGwI6/
	 FrjWDU5yMS+FwNQmU6FS7pbWZgnJbANzOF0Qf7Sze8yY6v37pTc6tiKKYBoHe8fhX1
	 uH5X11OLGyo2Q==
Message-ID: <ab8aa336-94ce-4c97-98b6-7d7049621f87@kernel.org>
Date: Mon, 12 Oct 2026 15:31:27 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: explicitly mention full zone when writing to it
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20261012132556.1307034-1-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261012132556.1307034-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/12 15:25, Christoph Hellwig wrote:
> Don't print the impossibly large write pointer, but directly mention
> the full zone when a write to one is received.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/zloop.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 394dc2408ed7..f8988f9b5d04 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -603,8 +603,12 @@ static int zloop_seq_write_prep(struct zloop_cmd *cmd)
>  		}
>  	} else {
>  		if (cmd->sector != zone->wp) {
> -			pr_err("Zone %u: unaligned write: sect %llu, wp %llu\n",
> -			       zone_no, cmd->sector, zone->wp);
> +			if (zone->wp == ULLONG_MAX)

ULLONG_MAX is used also for reporting the write pointer of read-only and offline
zones. So maybe we should mention the condition here using blk_zone_cond_str()
instead of hard coding "full" in the message.

> +				pr_err("Zone %u: write to full zone: sect %llu\n",
> +				       zone_no, cmd->sector);

				pr_err("Zone %u: write to %s zone: sect %llu\n",
				       zone_no, blk_zone_cond_str(zone->cond),
				       cmd->sector);

> +			else
> +				pr_err("Zone %u: unaligned write: sect %llu, wp %llu\n",
> +				       zone_no, cmd->sector, zone->wp);
>  			ret = -EIO;
>  			goto out_unlock;
>  		}


-- 
Damien Le Moal
Western Digital Research
