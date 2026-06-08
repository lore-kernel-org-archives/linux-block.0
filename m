Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892336680F
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918980; cv=none; b=WhB7WSfuHkQ9q+v8eBQUEPHzzvkaQjsPY4nY/zHkvWBDOvxZwmRIX1H6DU4kJ3JEJD8bK+7jc3NcJ7FpCzx6MVZ3Ps3BF112/IpRbo9fE/QP6qjo+U/61iKUUq3oZS7ap4ETr8uAY0yy2OczH7SNIhisLFAlCDLkUIjHH7ZYYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918980; c=relaxed/simple;
	bh=0ExTSIvgOCvddbqVu3Vq3relaC1BNhY7Z3b7v9+cAao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVYxOfAMA+2IA7Mfs6s2zVA20vWkAnxzzfhGnh5+7JvEk6cAGdMgllLPnMsFGyAxl3esvxjK7MEDt63exEVfH8yDzYrp9FwtnF+z8aVpqvmOY3kZqQ1GAew2nqJ3YTOLEhCeQjUBWTMwn7UeOCTphKI6tIojozT+yOT4rMYKdvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7Bo1ebm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7Bo1ebm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CFC1F00893;
	Mon,  8 Jun 2026 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780918978;
	bh=N+fj1phf5bXza/Z2Qq6aCdEd787CxhYgpMgZvaVm9jk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V7Bo1ebmZNuKiuPHZjPKvygshZqwB0dk4cqoCNqqqjeNND6SDtMSk7/VAeq4IlIhm
	 q9qJbPdq7ud34IVVdzMVAHHZEO/kCylu2/R7QmWgxetgO6pk+Y2gZCiSXo8KyWpo+0
	 QGRGYkuT0KIYlKxQnsXLTUbov6HQwc3tspqu3zZ/hPcycaq8wtL40kMlXMEDK1AIN6
	 ZDAXvB+f1zCjwO2JwOomuWTPkSis/NQ/P+RGdRVrMCb0YFDq7XmMAjGd06WOcGeyei
	 t2yrWsya+mbmU+mZ6qCmwMNmXK+GWh5Vq4Hf5A6kZS1e9ENHcEDA4bnEUwVYwBTgdG
	 xynzv0VgtjXnQ==
Message-ID: <33035623-1f1b-4391-9212-e2af5fd9457f@kernel.org>
Date: Mon, 8 Jun 2026 19:42:54 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: clear zone write plugging flag before failing
 rejected BIOs
To: Jackie Liu <liu.yun@linux.dev>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20260607031814.19188-1-liu.yun@linux.dev>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260607031814.19188-1-liu.yun@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/06/07 11:18, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> Commit fe0418eb9bd6 ("block: Prevent potential deadlocks in zone write plug
> error recovery") changed blk_zone_wplug_handle_write() to fail BIOs
> directly when blk_zone_wplug_prepare_bio() rejects them, for example
> because the write is not aligned to the cached write pointer or the plug
> needs a write pointer update. However, the BIO is already marked with
> BIO_ZONE_WRITE_PLUGGING at that point even though it is not issued.
> 
> Completing such a BIO with bio_io_error() makes bio_endio() call
> blk_zone_write_plug_bio_endio(), which treats the completion as a failed
> device write and may poison the cached zone write pointer state by setting
> BLK_ZONE_WPLUG_NEED_WP_UPDATE.

Yes, true. But you did not explain clearly why that is a problem. After all, if
we hit this case, the user issued an unaligned BIO, and so forcing it to do a
report zones to get everything in sync and the correct write pointer is not a
bad thing.

If fe0418eb9bd6 change is actually causing you problems, please describe that
problem clearly. But ideally, I do not want to special case some error
completions over others and prefer to have a single error path that result in
the same state for the zone write plugs, regardless of a write error root cause.

> 
> Clear BIO_ZONE_WRITE_PLUGGING and drop the zone write plug reference before
> failing the rejected BIO.
> 
> Fixes: fe0418eb9bd6 ("block: Prevent potential deadlocks in zone write plug error recovery")
> Cc: stable@vger.kernel.org # 6.13+
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  block/blk-zoned.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 6a221c180889..855767d8bfc1 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1502,7 +1502,9 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
>  		goto queue_bio;
>  
>  	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
> +		bio_clear_flag(bio, BIO_ZONE_WRITE_PLUGGING);
>  		spin_unlock_irqrestore(&zwplug->lock, flags);
> +		disk_put_zone_wplug(zwplug);
>  		bio_io_error(bio);
>  		return true;
>  	}


-- 
Damien Le Moal
Western Digital Research
