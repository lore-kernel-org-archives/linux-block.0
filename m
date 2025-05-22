Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303F017C21B
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935537; cv=none; b=YocZckP7HWsRz0p7N1q6sRCc6FwLc2jWC7uWFUb2U0AoyCHY87tsYD5dzb13iM5WBdOsq/Q7vHZDom/XkUBTMDZVyXcayZTg2Y0EfDaeMxk1kL/JTVVNZYVjdGj2Q4oXqeb8b+diZWCudYGh1NVt2Hja7J2B445puDlDt9fi5vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935537; c=relaxed/simple;
	bh=mPNvJWQfwSWJIqhLs1HlrDn/WYuYPmB8wfxtTNGfuDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8ng2lCVSiRTy7+n5s5QfilJqSd4cQYOkhJvQaShrb1X/OwfdSsCFchcc/a9a51bCSdEL9rwKKKCUnTCxsMwjgZ7fTB7zCBryOhb5mO9WGcN+3js3ViDbiY47NE7TQC/KbAzYNaf7l274au1pGRMYaep0TpGSgJEgfU6hNd32BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LG1VvoQo; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LG1VvoQo"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85b41281b50so271462539f.3
        for <linux-block@vger.kernel.org>; Thu, 22 May 2025 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747935533; x=1748540333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nM6gVpWW7hwcfcfH51deVSV04V713QkHpPw2pc8ZGq0=;
        b=LG1VvoQoDhqaMS4RWdQx94vF+mu/UYVO0FnOsD3JF0toWz9MjUzjIYKnl7/XHPKErf
         ZdCNevR+O8TMusd0tQPQTjWFhabBk6GckLrwIMRr+5T4S22Xk0tjEpNZsx47DdmZN+aK
         SgmeKJe46M9ssZApIJVJsxf15hAFiP6c79CRqLlP5M9tL+c0o9C15qOe9GuGik7hOuHS
         Kp7fR5rxjE6GkPGchRPJU6OkCEYGl3JzFNFZb/2ydoLHrFONZtAAiBa+Dnn3vMHYywot
         DUjV5fVw3+aTmV9R0viM0RReHocOThudTOlcN5DvBqFCPIeiBV026/vc64T2JeQH0N3U
         gY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747935533; x=1748540333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nM6gVpWW7hwcfcfH51deVSV04V713QkHpPw2pc8ZGq0=;
        b=gMYwHe6Ndj6E/VPNVnrk9204jCRwu48uazWipx8faVOEd3ivR3M7fKsGWN1joOvLjp
         asdy5LElGmzz33VVZiodukVFZOg9aPHdkPu2iCNMVlXvV1wwoTA4RFEbtAoKTN8dSajp
         hLXrz4jP6uDYg8SqGKIStCbbfhGDDf5K73CxcvJPqY687VJpbDLBqa2ppPczNxI7N1ud
         VICVKKcX2K7n6TzYSlPD1N4AbmAdlXDDlD9BdfKg8iLqALVHIi/7QEoRBq6ksdpDD4Nu
         670TQ5q0P1YTCD6pEq/z6SaShbPN6UzP23MktrpvnRX9s6mQ36S/Rc9njcP7BfNypE4J
         RDug==
X-Gm-Message-State: AOJu0YwesRESgAIHLptnVswkl029iQLcfqvjqolg7DHzVREVDurJfQYs
	G/LCuMKGI1wkxgn0P12O1srpctDZaL2JLnjpWqOS1F8hKxvqRpPPDC9IXP3eA0uI63Q=
X-Gm-Gg: ASbGncsmSYIFlA6QnV4ZZ/2MAvCLtE7xo0RqCspzsSOoeI/15srgl5wLrepqY23PIQ8
	0n+5tfvlqjjzRKQEj2R1sdIxb2GhMOG14ZPgFq/31y16jkxO5/lPPRTKpclSkgXb6EFYAUuaH8O
	pwSYMHH0PjNwhHIUvuQIuCtH5IWdYuroBupGAIOZZ482qSDeRBd9C5WrBrTiUID0yrB6X8McDFJ
	NcKHXpu8hQY7I/Savf24w1So74hCy/vLSGZrNEeDQDZte7+kDIogkAhppFW7D2Onh+rmviJX/fJ
	Ij6DpSywnCYwPgsX0B/m7ea1/pMbC/6LfJa+kwSy1jivs7M=
X-Google-Smtp-Source: AGHT+IF6b+fW8vRi48fyuKhfYCPzjJZNoYLDWjSHJ031JPvz5fE62vULtRWlBoHyfcTLf0e9Puh3Xg==
X-Received: by 2002:a05:6602:371b:b0:85b:3f1a:30aa with SMTP id ca18e2360f4ac-86a23229aabmr3343648039f.9.1747935532879;
        Thu, 22 May 2025 10:38:52 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a236e69acsm313856039f.31.2025.05.22.10.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 10:38:52 -0700 (PDT)
Message-ID: <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
Date: Thu, 22 May 2025 11:38:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
References: <20250522171405.3239141-1-bvanassche@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250522171405.3239141-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 11:14 AM, Bart Van Assche wrote:
> blk_mq_freeze_queue() never terminates if one or more bios are on the plug
> list and if the block device driver defines a .submit_bio() method.
> This is the case for device mapper drivers. The deadlock happens because
> blk_mq_freeze_queue() waits for q_usage_counter to drop to zero, because
> a queue reference is held by bios on the plug list and because the
> __bio_queue_enter() call in __submit_bio() waits for the queue to be
> unfrozen.
> 
> This patch fixes the following deadlock:
> 
> Workqueue: dm-51_zwplugs blk_zone_wplug_bio_work
> Call trace:
>  __schedule+0xb08/0x1160
>  schedule+0x48/0xc8
>  __bio_queue_enter+0xcc/0x1d0
>  __submit_bio+0x100/0x1b0
>  submit_bio_noacct_nocheck+0x230/0x49c
>  blk_zone_wplug_bio_work+0x168/0x250
>  process_one_work+0x26c/0x65c
>  worker_thread+0x33c/0x498
>  kthread+0x110/0x134
>  ret_from_fork+0x10/0x20
> 
> Call trace:
>  __switch_to+0x230/0x410
>  __schedule+0xb08/0x1160
>  schedule+0x48/0xc8
>  blk_mq_freeze_queue_wait+0x78/0xb8
>  blk_mq_freeze_queue+0x90/0xa4
>  queue_attr_store+0x7c/0xf0
>  sysfs_kf_write+0x98/0xc8
>  kernfs_fop_write_iter+0x12c/0x1d4
>  vfs_write+0x340/0x3ac
>  ksys_write+0x78/0xe8
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Yu Kuai <yukuai1@huaweicloud.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> 
> Changes compared to v1: fixed a race condition. Call bio_zone_write_plugging()
>   only before submitting the bio and not after it has been submitted.
> 
>  block/blk-core.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b862c66018f2..713fb3865260 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -621,6 +621,13 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  	return BLK_STS_OK;
>  }
>  
> +/*
> + * Do not call bio_queue_enter() if the BIO_ZONE_WRITE_PLUGGING flag has been
> + * set because this causes blk_mq_freeze_queue() to deadlock if
> + * blk_zone_wplug_bio_work() submits a bio. Calling bio_queue_enter() for bios
> + * on the plug list is not necessary since a q_usage_counter reference is held
> + * while a bio is on the plug list.
> + */
>  static void __submit_bio(struct bio *bio)
>  {
>  	/* If plug is not used, add new plug here to cache nsecs time. */
> @@ -633,8 +640,12 @@ static void __submit_bio(struct bio *bio)
>  
>  	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
>  		blk_mq_submit_bio(bio);
> -	} else if (likely(bio_queue_enter(bio) == 0)) {
> +	} else {
>  		struct gendisk *disk = bio->bi_bdev->bd_disk;
> +		bool zwp = bio_zone_write_plugging(bio);
> +
> +		if (unlikely(!zwp && bio_queue_enter(bio) != 0))
> +			goto finish_plug;
>  	
>  		if ((bio->bi_opf & REQ_POLLED) &&
>  		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
> @@ -643,9 +654,12 @@ static void __submit_bio(struct bio *bio)
>  		} else {
>  			disk->fops->submit_bio(bio);
>  		}
> -		blk_queue_exit(disk->queue);
> +
> +		if (!zwp)
> +			blk_queue_exit(disk->queue);
>  	}

This is pretty ugly, and I honestly absolutely hate how there's quite a
bit of zoned_whatever sprinkling throughout the core code. What's the
reason for not unplugging here, unaligned writes? Because you should
presumable have the exact same issues on non-zoned devices if they have
IO stuck in a plug (and doesn't get unplugged) while someone is waiting
on a freeze.

A somewhat similar case was solved for IOPOLL and queue entering. That
would be another thing to look at. Maybe a live enter could work if the
plug itself pins it?

-- 
Jens Axboe
