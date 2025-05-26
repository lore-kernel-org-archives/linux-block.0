Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A431A725A;
	Mon, 26 May 2025 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748245276; cv=none; b=a+bW1M123lzJ3AqzVHyMKIPA0JKn5+C+75feHjNqXQxQXzMHISOt1P9tXsDYX6Q20N3lk1D0Xc0ZMMvddsNR1A4R9iRXrSrKvnzHSyVMQu4JXcXhXZCEkWIsWJoys/xoKMe1QWGxI9A3b9JzNUZ0/JclBw3QBJ2B0/fIh9nURKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748245276; c=relaxed/simple;
	bh=yg0mxjoN/y9t7wdGun5ZZlQtrUMUvfn1oIMmqQsKpTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MY3LILP1eYIq53R5QUpkDIuDE8c7tERUahlz44sLP+D+6U5M3AA8q5iqsxREetM5vyAnP2uzxwcR1zvMrqvJ7emSu3rSPqsB7TNttUipreCjwwXXoyWCO6MLb4rHUN2s9z1ikICprRBBx70qmWHr0sbT9p4qpB3skj7q8qs1Y90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpejsJ37; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpejsJ37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD95AC4CEEE;
	Mon, 26 May 2025 07:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748245275;
	bh=yg0mxjoN/y9t7wdGun5ZZlQtrUMUvfn1oIMmqQsKpTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TpejsJ37lMSvDsvEfiyqyeQgdVagEFUb/EBYToJCsQINUx+Gc4tKcMuwm2aA8iNxr
	 TfBzv1OXOh4jVkaPhTpFZYOxlKMwJVZhiLHEyMS2troTCvj7paCh7kQofBhYbCfhRg
	 mow3NIBHcRohcALdkt9vACCliVjwqOIlEHk6nhHtoTu3DQcvbdYlx085CYrU1hUEKC
	 mCB0qksh4RqcVPMMY8lCQkisE8xm0tDoE9xDTlH1sErSJftGRhoZiCHujtw/EsP3N5
	 naMrjQajW6USmeUzHyBVTi6APsKWGExBRS92o5PpRJckRrUmAoK5WP987aw3NrTD47
	 mxGGU726/ZyRg==
Message-ID: <f6b29462-5bd0-4175-a8f8-edd36cd78a2c@kernel.org>
Date: Mon, 26 May 2025 09:41:11 +0200
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
>  
>  put_zwplug:
>  	/* Drop the reference we took in disk_zone_wplug_schedule_bio_work(). */

I ran xfs on an SMR drive with this and I had no issues. Will do more test with
a device mapper added.

-- 
Damien Le Moal
Western Digital Research
