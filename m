Return-Path: <jthumshirn@suse.de>
Date: Tue, 1 Nov 2016 16:25:51 -0600
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 1/4] block: add scalable completion tracking of requests
Message-ID: <20161101222550.u64m4txqjgoohwbv@linux-x5ow.site>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <1478034325-28232-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1478034325-28232-2-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 01, 2016 at 03:05:22PM -0600, Jens Axboe wrote:
> For legacy block, we simply track them in the request queue. For
> blk-mq, we track them on a per-sw queue basis, which we can then
> sum up through the hardware queues and finally to a per device
> state.
> 
> The stats are tracked in, roughly, 0.1s interval windows.
> 
> Add sysfs files to display the stats.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---

[...]

>  
>  	/* incremented at completion time */
>  	unsigned long		____cacheline_aligned_in_smp rq_completed[2];
> +	struct blk_rq_stat	stat[2];

Can you add an enum or define for the directions? Just 0 and 1 aren't very
intuitive.

	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
