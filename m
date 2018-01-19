Return-Path: <axboe@kernel.dk>
Received: from ?IPv6:2620:10d:c081:1130::124f? ([2620:10d:c090:180::f3])
        by smtp.gmail.com with ESMTPSA id 191sm18833716pfv.127.2018.01.19.11.58.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2018 11:58:12 -0800 (PST)
Subject: Re: [PATCH] blk-throttle: use queue_is_rq_based
To: linux-block@vger.kernel.org
References: <20180119174053.GA967@localhost.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2197d5a1-0e93-e554-4645-2220e2a0b3ae@kernel.dk>
Date: Fri, 19 Jan 2018 12:58:10 -0700
MIME-Version: 1.0
In-Reply-To: <20180119174053.GA967@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/19/18 10:40 AM, weiping zhang wrote:
> use queue_is_rq_based instead of open code.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  block/blk-throttle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 96ad326..457e985 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2456,7 +2456,7 @@ void blk_throtl_register_queue(struct request_queue *q)
>  	td->throtl_slice = DFL_THROTL_SLICE_HD;
>  #endif
>  
> -	td->track_bio_latency = !q->mq_ops && !q->request_fn;
> +	td->track_bio_latency = !(queue_is_rq_based(q));

Kill the extra parenthesis here.

-- 
Jens Axboe
