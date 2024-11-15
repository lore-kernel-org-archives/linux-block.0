Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1654769;
	Fri, 15 Nov 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686839; cv=none; b=nyvHiF6R6ZYp/bzLdWGsuUjuCMUUCHhwqmUYF1G9WkTsLyWhibI8Y9hThnhjoAEZ2M5v2/yODJOJlzUvtSXVab7Le7KRYOOkwYlz3Ol6E7QI4U9KaYA3reooqV8tCilohnuGHYxOhn4ZSKvrVEn/hCEMqeApKpNC/bW2qetQSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686839; c=relaxed/simple;
	bh=QidJsVEDsV7iTfjHWunC7E7BKbrRE5HrjsN3+lOKs+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4ey9LZR/o4Dv5/+3xte9wuy4Kpm4SzOshfddMaI0nHnUUdsK3cyBfimiq2jvvYbDjYgt3TxeRh2/O4syFQLtxekFb2RDUkinhrlRHNH52Vj13gFiJ0cHS7OyU7Ae2dpmOcoCmIzLtsHb03bdirmwpAvkxHddnr7LwgZQuXeexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+u4lta3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+u4lta3"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f8c7ca7f3cso471008a12.2;
        Fri, 15 Nov 2024 08:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731686836; x=1732291636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20D1PWGk03rV5COuXCsG0W7radE26VyHx9rRuiqEHTc=;
        b=S+u4lta3arbU+rou+BSHS88lZ4muhvENDb3HdmMWLZKfeaUXVw/AL5hQm3HJKiGhJu
         OniPLDNarp/mQM3quBaJy8r8CWbQyMv/iFTRIlUQa4/YQtVFrTYgF8RuWf8qHrzMWZj1
         iAHheCUb69BAX5hLHPEOvrLRgSrB2P+XQ745fTno8iUVJujuRSJXK7nWHPluxgUsQjL2
         /29440ezIAgM9UsYFUf4V1Pl82GKfxuDsPle1GAgn5Zu4IB61Z3x7XS/O2REIXSPOzm7
         ycXggExds79Y5EjYM+gOzkGQJHiaRmk8AI6j9J9T4DkkmOsTgoQKNuyWpYztkXQNA+aW
         Ow0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686836; x=1732291636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20D1PWGk03rV5COuXCsG0W7radE26VyHx9rRuiqEHTc=;
        b=n41PLS+MjQrslAtzUAZI7c0xIBMdBxslAq9ShLza1/opEMlwcHZQ5Jaiz6L9dmxEil
         7n9aYyO2BAluQdKJGg/DtA0lmcGd+AQqbJad6i1LkeWDB0QViEfg5poSR+8KMU+gUGst
         2piE4usKs1lS/SBvAGLrrS4i30VNHzVmw4u4SoboobS3S8sGNUF+ffNXzsIn4wVumopM
         cCoMu+E2Or9j+1ugSN6ArkM8yoqZ/7hy1cPyeJNn4Ac515bBhL2FQLGlbGSGJ36WXcQj
         2D9N8DEMc7lOYASGa+yPlT5dQRWsHXxx/Ud28Kz3ZXYSEEZURCfM0h9/fx50bFrqv/XD
         IHWA==
X-Forwarded-Encrypted: i=1; AJvYcCW3hD4kDsVql5qQKMMINe74EJeri0xqz931bPKZ9njYppS4YSXSABmn0PhL7WHH0qX5Mner1RdjLLlyyzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3op3y+iasuFx+waY3wqNRFcTiWrizHopZtujnTVddSaEUwS2
	rZO9i7xisCTywCV4C0UMFiCH7eF0JjJnDA1KoIZzJVH9etHl5iYHjrl+J0LVclc=
X-Google-Smtp-Source: AGHT+IGTxCjRkoF28Yc9OCPVjH319LHep5KM45/j/IMvA7HJmJ4iBQZTz59clttfjpoYmxMXuRTc6g==
X-Received: by 2002:a05:6a20:158e:b0:1db:e481:3274 with SMTP id adf61e73a8af0-1dc90bc8e52mr4682121637.31.1731686836177;
        Fri, 15 Nov 2024 08:07:16 -0800 (PST)
Received: from [192.168.0.198] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770ee95csm1560062b3a.27.2024.11.15.08.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 08:07:15 -0800 (PST)
Message-ID: <70996029-be8a-4f97-88fc-a27cff4f5df4@gmail.com>
Date: Fri, 15 Nov 2024 21:37:10 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 hch@infradead.org
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241008175215.23975-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <20241008175215.23975-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/10/24 23:22, SurajSonawane2415 wrote:
> Fix the uninitialized symbol 'bio' in the function blk_rq_prep_clone
> to resolve the following error:
> block/blk-mq.c:3199 blk_rq_prep_clone() error: uninitialized symbol 'bio'.
> 
> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
> ---
> V1 - Initialize 'bio' to NULL.
> V2 - Move bio_put(bio) into the bio_ctr error handling block,
> ensuring memory cleanup occurs only when the bio_ctr fail.
> V3 - Moved the bio declaration into the loop scope, eliminating
> the need to set it to NULL at the end of the loop.
> V4 - Adjusted position of arguments of bio_alloc_clone.
> 
>   block/blk-mq.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4b2c8e940..89c9a6c4d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3156,19 +3156,21 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>   		      int (*bio_ctr)(struct bio *, struct bio *, void *),
>   		      void *data)
>   {
> -	struct bio *bio, *bio_src;
> +	struct bio *bio_src;
>   
>   	if (!bs)
>   		bs = &fs_bio_set;
>   
>   	__rq_for_each_bio(bio_src, rq_src) {
> -		bio = bio_alloc_clone(rq->q->disk->part0, bio_src, gfp_mask,
> -				      bs);
> +		struct bio *bio = bio_alloc_clone(rq->q->disk->part0, bio_src,
> +					gfp_mask, bs);
>   		if (!bio)
>   			goto free_and_out;
>   
> -		if (bio_ctr && bio_ctr(bio, bio_src, data))
> +		if (bio_ctr && bio_ctr(bio, bio_src, data)) {
> +			bio_put(bio);
>   			goto free_and_out;
> +		}
>   
>   		if (rq->bio) {
>   			rq->biotail->bi_next = bio;
> @@ -3176,7 +3178,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>   		} else {
>   			rq->bio = rq->biotail = bio;
>   		}
> -		bio = NULL;
>   	}
>   
>   	/* Copy attributes of the original request to the clone request. */
> @@ -3196,8 +3197,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>   	return 0;
>   
>   free_and_out:
> -	if (bio)
> -		bio_put(bio);
>   	blk_rq_unprep_clone(rq);
>   
>   	return -ENOMEM;

Hello Jens!

I wanted to follow up on this patch I submitted. I have done all the 
suggested changes till v4. I was wondering if you had a chance to review 
it and if there are any comments or feedback.

Thank you for your time and consideration. I look forward to your response.

Best regards,
Suraj Sonawane
