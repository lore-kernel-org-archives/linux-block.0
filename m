Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 1/4] block: add scalable completion tracking of requests
To: Jens Axboe <axboe@fb.com>, <axboe@kernel.dk>,
	<linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <1478034325-28232-2-git-send-email-axboe@fb.com>
CC: <hch@lst.de>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <12323199-84d1-7586-9189-3bf5644248a0@sandisk.com>
Date: Thu, 3 Nov 2016 08:10:16 -0600
MIME-Version: 1.0
In-Reply-To: <1478034325-28232-2-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: bart.vanassche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 11/01/2016 03:05 PM, Jens Axboe wrote:
> +void blk_stat_init(struct blk_rq_stat *stat)
> +{
> +	__blk_stat_init(stat, ktime_to_ns(ktime_get()));
> +}
> +
> +static bool __blk_stat_is_current(struct blk_rq_stat *stat, s64 now)
> +{
> +	return (now & BLK_STAT_NSEC_MASK) == (stat->time & BLK_STAT_NSEC_MASK);
> +}
> +
> +bool blk_stat_is_current(struct blk_rq_stat *stat)
> +{
> +	return __blk_stat_is_current(stat, ktime_to_ns(ktime_get()));
> +}

Hello Jens,

What is the performance impact of these patches? My experience is that 
introducing ktime_get() in the I/O path of high-performance I/O devices 
measurably slows down I/O. On https://lkml.org/lkml/2016/4/21/107 I read 
that a single ktime_get() call takes about 100 ns.

Bart.
