Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C3218859E
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378577; cv=none; b=ely5v+nTJm7bpF8kWlEobTpIYYbLV3N7HT39p8FkXzHjPeB4Kt7NBPChOIJRMTcWGGRxMfsODuSijgNxqoWhuIiPd5sOhM7cTqD6gtMMjeCGFhvqhi1V9vctr1U22xRA2LZh23d0fyjlYvMPQNje4R44Hr6obbVf1GJ950i3qiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378577; c=relaxed/simple;
	bh=Jd2JhMcuMQ/0eSKaGneZKDZ/qwF+c9sowUz9gZ1xKAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTd8S8tC96O9bXVj/kt2OztAGkwrEwa3hKLgEJy8areKqmgjF+x47GPEj66TVkFSeXI2LbFFY7kM7rVW6fF8THLyajYXTpUFph4zfNOOk2pyENZXeb05FgTKkufSkL8uADZucTaLat0X0DUEDrKDh/2jz5x48ojzQ22+XGi+O2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gWw/Jakg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gWw/Jakg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-715abede256so4135950b3a.3
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725378573; x=1725983373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGTHrUOt7SQ0jUkPpme5j8MLZrljWKp5K0DSOh1vRA0=;
        b=gWw/JakgZRVCqHOAsizDjdhrcr6vDUW4VHYLiSBHMwgmtRtl9hBdCurBJTRZQ/EEDS
         Zfd8b0LnaMzk8X1LpjHqUth+6l2onQao4oi6PYuaYgktZXb8wg3CP80CXW6gwr6NUUWI
         lf4TJF9LyVKZXe7vGthnrz008klb5jsP1ys+/jPxnrs3oEadCrfN3krQMwK07U8ClA3S
         Vs15p5FBPrN/6HeOMsnGy69iBEd8VQMWoTdoLUgixwYr5P1BL/ie/8yjbNRJuGsAuzLI
         7ICurdbiQ/L1hV679o072VXAHHMjc39v2hna0tw9vDOqMKB3sNoN2cO09SyRpCzacMyZ
         AouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378573; x=1725983373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGTHrUOt7SQ0jUkPpme5j8MLZrljWKp5K0DSOh1vRA0=;
        b=pcuLulUme+D8oCan4hfNcjBAi1oYbpYtdd9a9AZsCReuRASp8XBBEo8xPqJKVub90C
         scswVCzqhyK3VCroMlazjoSNRfgQzB94qwYfsBuMC3f5r4uFrZZX+m6KfBHA5qADRUb3
         pw1DqHwrTwFZ2QlGYzC70R/IvuWYvsjOdSMeqvKiLUBv2LUOOSPYB8WlT7gS9t6TdkGf
         wdxke4ok7rQ5Vbi+tdKfIgh6ELZRkt2zsTCJKjtHqY7ILwGZMbwht1ZIqPNCVfkk8Pdu
         eDIU3HXqQ8yAehxyJnTry9u7aZnTsx/2OjOGzPR6FfCY04kN6Bj/0KbYsMNDTd6uqEcF
         bnZw==
X-Gm-Message-State: AOJu0YzRUszi+YtHEjHv10BnaBeMk6ItKcTNG6euGwC7XW5AcSzc6PDs
	t0hjlpxOnPAaL9hZxndQxc9VTZepdqMIyLIVa8dQm3sngxgwf7kbiRI5YD194a6Tf/rmWcBXfIG
	i
X-Google-Smtp-Source: AGHT+IHKzr00BabRSRyjL/g4MNOGJGWk91MfIdPTb7Aw2nSWqByd2sErxatf2CAhseYhHMIiLJEmtA==
X-Received: by 2002:a05:6a00:1a8a:b0:714:2069:d917 with SMTP id d2e1a72fcca58-717449c5767mr7901572b3a.25.1725378573464;
        Tue, 03 Sep 2024 08:49:33 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858b7ddsm17303b3a.112.2024.09.03.08.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 08:49:32 -0700 (PDT)
Message-ID: <8d5a0a41-0112-4c53-a7c4-67bfc5332ba9@kernel.dk>
Date: Tue, 3 Sep 2024 09:49:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Export blk_alloc_discard_bio
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Zta6RR1gXPi7cRH3@infradead.org>
 <20240903073915.989741-1-luca.stefani.ge1@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240903073915.989741-1-luca.stefani.ge1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 1:39 AM, Luca Stefani wrote:
> The fs trim loops over ranges and sends discard requests, some ranges
> can be large so it's all transparently handled by blkdev_issue_discard()
> and processed in smaller chunks.
> 
> To support cancellation (or suspend) requests we need to insert checks
> into the the loop, exporting the symbol allows to reimplement
> such loop with the desired behavior.
> 
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> ---
>  block/blk-lib.c        | 1 +
>  include/linux/blkdev.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 4c9f20a689f7..ebaef47d8ce7 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -59,6 +59,7 @@ struct bio *blk_alloc_discard_bio(struct block_device *bdev,
>  	cond_resched();
>  	return bio;
>  }
> +EXPORT_SYMBOL_GPL(blk_alloc_discard_bio);
>  
>  int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b7664d593486..f3631044d905 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1088,6 +1088,8 @@ static inline long nr_blockdev_pages(void)
>  
>  extern void blk_io_schedule(void);
>  
> +struct bio *blk_alloc_discard_bio(struct block_device *bdev,
> +		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask);
>  int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask);
>  int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,

Since blk_alloc_discard_bio() is already defined in a header (otherwise
it would've been static and your export symbol above would have failed
miserably), why add it to another header?

-- 
Jens Axboe

