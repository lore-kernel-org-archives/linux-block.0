Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB11DE8AD
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845635; cv=none; b=BoH5nzXc9h6WRIq+VmNY3Oxmoam/bFmm2fv19n/Q0hlfcgur/IgLEVYEqDeHzOpM5s3CV6zjbGXZibNAVWlMwADYiRf8PUTGptFCTqwmVjsP3ai2ZVVHszwu/m4bfNieoLGVdrU8xD6psYYvrpjX7+c7EqJyyxfNCOZ26YaWTJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845635; c=relaxed/simple;
	bh=GAFDYqhKt8o8remYDBdljK8fPNxWPOFr3HGKM1Wda/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQJAYyQIIBBf9nhoFyQR+8+OJpItXtFfrSCv87nSPsdBkYk1nhHrQWZB8ZS89hC26xQ6pmkkjj9oRgr5FVwFA6dguk2JlIeyBHiCmTexo8daBz/1yvFM7Gb6IIuPmS/fCVXGdYpZEZfYu8DqmzWpXRl4yuiZZpJsUPBgk5rXOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCz+30br; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCz+30br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6A2C4CEF7;
	Tue, 11 Nov 2025 07:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762845634;
	bh=GAFDYqhKt8o8remYDBdljK8fPNxWPOFr3HGKM1Wda/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FCz+30brRXxTy6VzHVuNkANt9VHsOHqs434n6DwIscDHfkBdGh5SWfTCAaHlmiJ6N
	 x2d7G+CKIO80Jp6fKexLy1lGYD92neIKZmRutmY6btxDdBW42X4S0i3S29Tw15ot/P
	 paKe9Ld7WDcycCMS/TVSI936VbGJwzB+YDs0dS/6yyA4K98xjxc9sFCU/8uLL8n5XX
	 usVXdOtHkNkzkV+gB+hm1/1XMkL/aWdnd2XS6xO95czUQdvl5FoKiZhOOIz38+wi3Y
	 AKyu1MKcoFjSx8eHG1QWN0l2ks6y54L0BtKKjGRHlrMouI4Sa3yEmNE4JxsttiNDWo
	 gMM/py0SW+l1g==
Message-ID: <a8890681-45f7-4f18-9d33-1fb681a408d1@kernel.org>
Date: Tue, 11 Nov 2025 16:16:37 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] blk-zoned: Move code from disk_zone_wplug_add_bio()
 into its caller
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20251110223003.2900613-1-bvanassche@acm.org>
 <20251110223003.2900613-5-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251110223003.2900613-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 7:30 AM, Bart Van Assche wrote:
> Move the following code into the only caller of disk_zone_wplug_add_bio():
>  - The code for clearing the REQ_NOWAIT flag.
>  - The code that sets the BLK_ZONE_WPLUG_PLUGGED flag.
>  - The disk_zone_wplug_schedule_bio_work() call.
> 
> This patch moves all code that is related to REQ_NOWAIT or to bio
> scheduling into a single function. No functionality has been changed.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

[...]

> @@ -1464,8 +1448,10 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
>  	 * Add REQ_NOWAIT BIOs to the plug list to ensure that we will not see a
>  	 * BLK_STS_AGAIN failure if we let the BIO execute.
>  	 */
> -	if (bio->bi_opf & REQ_NOWAIT)
> +	if (bio->bi_opf & REQ_NOWAIT) {
> +		bio->bi_opf &= ~REQ_NOWAIT;
>  		goto plug;
> +	}
>  
>  	/* If the zone is already plugged, add the BIO to the BIO plug list. */
>  	if (zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)

The goto in this if should be "goto add_bio;"

> @@ -1485,7 +1471,12 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
>  	return false;
>  
>  plug:
> +	schedule_bio_work = !(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
> +	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
> +

And the label "add_bio" defined here. That would be cleaner I think.

>  	disk_zone_wplug_add_bio(disk, zwplug, bio, nr_segs);
> +	if (schedule_bio_work)
> +		disk_zone_wplug_schedule_bio_work(disk, zwplug);
>  
>  	spin_unlock_irqrestore(&zwplug->lock, flags);
>  


-- 
Damien Le Moal
Western Digital Research
