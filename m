Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF368BE7
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040968; cv=none; b=MQQRQnFIJcgeQrROjTRYF1QKy30/Rhv5mw5WjAPyPV1nTBct5SBIzqByByQ7Kwn7QLUkhxubcjpI/KMAh53NU3Al+J3Yxr2ml6xrKU46ECmJn/MH5pE4Mb15vEkA800sw1h+50RDpjtOBl17CRe2CdYIUkYOJlTiGUM4Gtan2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040968; c=relaxed/simple;
	bh=md9ybH5ys3RExgWiyiE9Dp2TT+NQkjbn4RaBPSzujwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sG/P9ooaZwH3KFFOyveDAVEzD6NOPpglNkLyz1D4HloBPK9Sxh9JuQ6wGibNfpw6UXm+U1vChr4U++4+scDWfetbdrpFyBjLWrRHFmjYA+7zr7nRLQeCgs32EL2dlNQ7ZjKR/JsITHU3Gaf9+9eRD95tiFBWaVyPBjpLAHbEOAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Qq1ly2iX; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Qq1ly2iX"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36699ee4007so1242465ab.0
        for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711040966; x=1711645766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTmaYD+N8oG27MmCeLZ2fD5OgdR8oN/GLBC9LDdyTZ8=;
        b=Qq1ly2iXLDRg8xEev9FTbC/XKihGjKuYWBCfOX7XAYWT9pxM2yCwJItL9zfWEitAN7
         Ysr7Su0dfgsXFWWjVM4L2K+e6BJfOY8EPdulREaNShYTDTQZuypM+uaqUHQTAytbq3TZ
         k+rwnxEajjf7No2rF9OeLQuo9dacRVwWlgKSmJK354CkamMBaabEgyYnf/jEu+CtGBgY
         7gw/cEWscp35xqQaSBZLz3AaDoQHHLR0HwAONjK2sg0SfEgCgNXKsnvesKMxwhq8EqCU
         kQcRS9YoIlm6ueCqUgsLoR5YZqWOVbVo7y1jPTv0Q97OF2pGaEENZjeJMObviiG5t284
         je+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711040966; x=1711645766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTmaYD+N8oG27MmCeLZ2fD5OgdR8oN/GLBC9LDdyTZ8=;
        b=f43kJtbmt+ZKfS3N+AWRSrUF4lAvSDDVxXLg0VB8U2ZsQod6MpcdX8YrBZwItFDq3H
         e4XICA0mRLLRgpHGiQ4xhEetqqf7t1kF6DN59mcSMPG1wxrmBfIklOkkMrYAN81BzULK
         7z33K6V/13p7rG7yQDUlRu/ap3pk9eGz8xdrtUC0vdXODFukFAvp4RQAq5eH18Gp3KXt
         uBqo+VngkUKyVqKG5Tidh5sJZxWtyJVZqqKQb8jvVqx2ICLsIOEeRy7Ru5gHk4PCAipL
         ytJccRc7CLdKPwZUYbKedbI9fEnYPd59KbmyHsiT0V+2mEAOqMKm29yqCcaqZpzEDnLU
         2z4A==
X-Forwarded-Encrypted: i=1; AJvYcCUym+sTwEvL9UstEvTdqoGgbs71lyTihqHhCO+gRcKyYKo7fCMzPcJnjGo4XewF4+1xtN4J/MMQE7RTAPc8DpPBLjhmUBEmZWGZedc=
X-Gm-Message-State: AOJu0YzkBcXdRWNEXGBxVx8RZ1UAaWoqWultmlBo2XdPFokEab+0p4wl
	yRKt4P8pSPT3PofI/0aWfiRiFg59+aOfbexRTSfqzUGVo+naSyyFZZoKVL3lw75RGP/RZEqJd4/
	m
X-Google-Smtp-Source: AGHT+IGx0N24mNhlF+eY9GWvenaOQMUViUvkFXW2Uy5KcdeGm5jedAxps8BLrWXjdAyxA0Q6BAtYYw==
X-Received: by 2002:a6b:c848:0:b0:7d0:2b91:45e8 with SMTP id y69-20020a6bc848000000b007d02b9145e8mr40167iof.2.1711040965897;
        Thu, 21 Mar 2024 10:09:25 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p20-20020a056602259400b007cc7c30e70esm41525ioo.46.2024.03.21.10.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:09:25 -0700 (PDT)
Message-ID: <979af2db-7482-4123-8a8b-e0354eb0bd45@kernel.dk>
Date: Thu, 21 Mar 2024 11:09:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fail unaligned bio from submit_bio_noacct()
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
References: <20240321131634.1009972-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240321131634.1009972-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/24 7:16 AM, Ming Lei wrote:
> For any bio with data, its start sector and size have to be aligned with
> the queue's logical block size.
> 
> This rule is obvious, but there is still user which may send unaligned
> bio to block layer, and it is observed that dm-integrity can do that,
> and cause double free of driver's dma meta buffer.
> 
> So failfast unaligned bio from submit_bio_noacct() for avoiding more
> troubles.
> 
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a16b5abdbbf5..b1a10187ef74 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -729,6 +729,20 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>  		__submit_bio_noacct(bio);
>  }
>  
> +static bool bio_check_alignment(struct bio *bio, struct request_queue *q)
> +{
> +	unsigned int bs = q->limits.logical_block_size;
> +	unsigned int size = bio->bi_iter.bi_size;
> +
> +	if (size & (bs - 1))
> +		return false;
> +
> +	if (size && ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1)))
> +		return false;
> +
> +	return true;
> +}
> +
>  /**
>   * submit_bio_noacct - re-submit a bio to the block device layer for I/O
>   * @bio:  The bio describing the location in memory and on the device.
> @@ -780,6 +794,9 @@ void submit_bio_noacct(struct bio *bio)
>  		}
>  	}
>  
> +	if (WARN_ON_ONCE(!bio_check_alignment(bio, q)))
> +		goto end_io;
> +
>  	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
>  		bio_clear_polled(bio);

Where is this IO coming from? The normal block level dio has checks. And
in fact they are expensive... If we add this one, then we should be able
to kill the block/fops.c checks, no?

-- 
Jens Axboe

