Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F6226534;
	Fri, 23 May 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998025; cv=none; b=jjulgtbkCT1sXzSOU5BFzlnsK7hly6CpKPsEnDlCqbgeWbfbITesVaDhSKXFY9pfTzuc8ZgZ7Ex8Z2dlPvIBc6WrlIrdKsVqNymleIpezkqZYazuWK3E9ylS79osMi5w3pohE6uZXRMbf6QOrgEr5ZThvU8IuPxWzmrO3Fwc1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998025; c=relaxed/simple;
	bh=BscunE33ExX6dA46gAHgfv7e3/7SvsUi/tjoHTB2Yn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kv20aMec0ePbH9kJZ4qPf82MrBnfi9W7wW/DYBGRZYUF63KO/hZC6Plr4sgo0mDm1k3ccS8ZacdpOtj8awLjx4D7jh8pEoA9z+nYUFDgEwUPnmJSZde7j6JNI+hzX/jvek4M07+CEhiYat5exkvLTZWznA/JUegUPgbDQaizdZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhgLqvLg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhgLqvLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C588C4CEE9;
	Fri, 23 May 2025 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747998025;
	bh=BscunE33ExX6dA46gAHgfv7e3/7SvsUi/tjoHTB2Yn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JhgLqvLgFzqvOowo1HuOvaTYL/daXkq0mX//+HbUr6U7Yega8a89+w5Jn14A4Gdts
	 V0zmwIsn7BCGnCvIAquysIAikPwwkS5fImmhGzq9HsimybZFdSoMj5LaEsHI2Ev0gp
	 bFj//dtLZA7P7VE92GCStbRSr7mMZaao6TrkgNpfiDq1evqhj3yImuxM63zRx6OZCq
	 cvHjtBY2z5F7ioBi0MHKupJ3sFQgycIX93aSzNnBfyCbPS+oiyS0Z1bShAQmtCMdzj
	 FxpErHziztx5N+p9s6YMJJa+berrPecjZScZXM0j0Sccdi8uex++rPY4qiObbMnCNz
	 Tipt1iNxe+6mg==
Message-ID: <c1a56518-76ea-4c83-8a5e-89e636e16a26@kernel.org>
Date: Fri, 23 May 2025 13:00:21 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
References: <20250522171405.3239141-1-bvanassche@acm.org>
 <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
 <3cd139d0-5fe0-4ce1-b7a7-36da4fad6eff@kernel.org>
 <20250523082048.GA15587@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250523082048.GA15587@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 10:20, Christoph Hellwig wrote:
> On Fri, May 23, 2025 at 10:10:30AM +0200, Damien Le Moal wrote:
>>> This is pretty ugly, and I honestly absolutely hate how there's quite a
>>> bit of zoned_whatever sprinkling throughout the core code. What's the
>>> reason for not unplugging here, unaligned writes? Because you should
>>> presumable have the exact same issues on non-zoned devices if they have
>>> IO stuck in a plug (and doesn't get unplugged) while someone is waiting
>>> on a freeze.
>>>
>>> A somewhat similar case was solved for IOPOLL and queue entering. That
>>> would be another thing to look at. Maybe a live enter could work if the
>>> plug itself pins it?
>>
>> What about this patch, completely untested...
> 
> This still looks extremely backwards as it messed up common core
> code for something that it shouldn't.  I'd still love to see an
> actual reproducer ahead of me, but I think the problem is that
> blk_zone_wplug_bio_work calls into the still fairly high-level
> submit_bio_noacct_nocheck for bios that already went through
> the submit_bio machinery.
> 
> Something like this completely untested patch:
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 8f15d1aa6eb8..6841af8a989c 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1306,16 +1306,18 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
>  	spin_unlock_irqrestore(&zwplug->lock, flags);
>  
>  	bdev = bio->bi_bdev;
> -	submit_bio_noacct_nocheck(bio);
> -
>  	/*
>  	 * blk-mq devices will reuse the extra reference on the request queue
>  	 * usage counter we took when the BIO was plugged, but the submission
>  	 * path for BIO-based devices will not do that. So drop this extra
>  	 * reference here.
>  	 */
> -	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO))
> +	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO)) {
> +		bdev->bd_disk->fops->submit_bio(bio);
>  		blk_queue_exit(bdev->bd_disk->queue);
> +	} else {
> +		blk_mq_submit_bio(bio);
> +	}

Indeed, this looks better and simpler. Will give it a spin to check.


-- 
Damien Le Moal
Western Digital Research
