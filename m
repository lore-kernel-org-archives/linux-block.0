Return-Path: <axboe@kernel.dk>
Subject: Re: UBSAN: Undefined behaviour in block/blk-mq.c:1459:27 with
 pata_amd
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Meelis Roos <mroos@linux.ee>
References: <alpine.LRH.2.20.1605121902440.4797@math.ut.ee>
 <22191628.vH7YQZ1hRO@amdc1976>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
 linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
 Tejun Heo <tj@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5739ED73.4020009@kernel.dk>
Date: Mon, 16 May 2016 09:55:31 -0600
MIME-Version: 1.0
In-Reply-To: <22191628.vH7YQZ1hRO@amdc1976>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/13/2016 09:31 AM, Bartlomiej Zolnierkiewicz wrote:
> Does the patch below help?
>
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Subject: [PATCH] blk-mq: fix undefined behaviour in order_to_size()
>
> When this_order variable in blk_mq_init_rq_map() becomes zero
> the code incorrectly decrements the variable and passes the result
> to order_to_size() helper causing undefined behaviour:
>
>   UBSAN: Undefined behaviour in block/blk-mq.c:1459:27
>   shift exponent 4294967295 is too large for 32-bit type 'unsigned int'
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc6-00072-g33656a1 #22
>
> Fix the code by checking this_order variable for not having the zero
> value first.

Thanks Bart, added for 4.7.

-- 
Jens Axboe
