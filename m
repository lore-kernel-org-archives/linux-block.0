Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C21FB3;
	Tue, 27 May 2025 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382567; cv=none; b=GzZ5nSMgrTsHfeKUR2Fnve/xBEY0agsqBnW8yJ7GsXYHMB4AGD/Xbv1mB7f77p+H81PRU/BmAaX/TuXZpsoF/ihqJyW2A22TkmbPEPyp/gtVL8kf/DYqCgc/wCU7xPCBUnNIe2MvsQv8SIVEa7W1kw/oAyRIoVg/P6DF7leYDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382567; c=relaxed/simple;
	bh=EwxLqY0fmQF8S71l6h2LmkmacJKXMfgvRPHVrm43FNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBRaXKHidlMzq9YO3eLNj9qzZIuUusTVGhkSIGM1FDkvC0TqaIOKSDlH8dkB3mNldYpNitbpS9BCMSi8EhXrNSrIX2pZAH4rB+NguBu+lY2v8bv4GCdZFy89cKvzwXKsEQAl/OTX64m+EI8EbXCZ97d48rgcUp+Zgl2bifH7MYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1+mSH25C; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1+mSH25C"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b6R9W3Pf1zltP0Y;
	Tue, 27 May 2025 21:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748382557; x=1750974558; bh=UpKlm3hQbRz5j81cotOA5nkr
	nv7yQdeoB3GE/vZ8Ly0=; b=1+mSH25Cb2DETpV9eBhkvrxfW79KY5bQQPJ0gGwO
	dnEh3etPYHBu/ZoBJQEI/YTYpBpgMIlHsDKficD6C8FLxYRu4HnD0AxDmKofd7nV
	aLCnQN4NVhEkg32GojsFxbjuT2UPgp9Zrzrh6AZ8mm6mSIy23xPtfw0EK+pg3uH2
	mzOwXcpur0rIcFAefy5+bEieZSrxNHod0GpM7BifUjVmFV+AUCmIqCPWErD2a+yz
	l406BY3xk7AKbt6LVh5P83PWV1r0Tck8WnXffEMRPq8C+f0QGEcQvKHi9CJ1AO82
	pffryKcFjEK62xxvGffS70KQVuSCXQJVIbFfTZuuGqY9hw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PsAgq2f88O37; Tue, 27 May 2025 21:49:17 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b6R9P42k2zlvBYd;
	Tue, 27 May 2025 21:49:12 +0000 (UTC)
Message-ID: <df240ef1-d794-45af-a3cf-cdec06731103@acm.org>
Date: Tue, 27 May 2025 14:49:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 stable@vger.kernel.org
References: <20250522171405.3239141-1-bvanassche@acm.org>
 <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
 <3cd139d0-5fe0-4ce1-b7a7-36da4fad6eff@kernel.org>
 <20250523082048.GA15587@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250523082048.GA15587@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/25 1:20 AM, Christoph Hellwig wrote:
> Something like this completely untested patch:
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 8f15d1aa6eb8..6841af8a989c 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1306,16 +1306,18 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
>   	spin_unlock_irqrestore(&zwplug->lock, flags);
>   
>   	bdev = bio->bi_bdev;
> -	submit_bio_noacct_nocheck(bio);
> -
>   	/*
>   	 * blk-mq devices will reuse the extra reference on the request queue
>   	 * usage counter we took when the BIO was plugged, but the submission
>   	 * path for BIO-based devices will not do that. So drop this extra
>   	 * reference here.
>   	 */
> -	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO))
> +	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO)) {
> +		bdev->bd_disk->fops->submit_bio(bio);
>   		blk_queue_exit(bdev->bd_disk->queue);
> +	} else {
> +		blk_mq_submit_bio(bio);
> +	}
>   
>   put_zwplug:
>   	/* Drop the reference we took in disk_zone_wplug_schedule_bio_work(). */

This patch works fine on my test setup.

Thanks,

Bart.
