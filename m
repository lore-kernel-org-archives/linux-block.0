Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/2] blk-sysfs: return EINVAL when user modify
 nr_request less than BLKDEV_MIN_RQ
To: weiping zhang <zhangweiping@didichuxing.com>
References: <cover.1506006064.git.zhangweiping@didichuxing.com>
 <da25b8d7b8ddd34e6e5f62f8c001f551ff3f1e04.1506006064.git.zhangweiping@didichuxing.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <efeb86f4-2752-975b-a5c9-bd08deb7fd21@kernel.dk>
Date: Thu, 21 Sep 2017 10:38:22 -0600
MIME-Version: 1.0
In-Reply-To: <da25b8d7b8ddd34e6e5f62f8c001f551ff3f1e04.1506006064.git.zhangweiping@didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/21/2017 09:17 AM, weiping zhang wrote:
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  block/blk-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index b8362c0..03a6e19 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -75,7 +75,7 @@ queue_requests_store(struct request_queue *q, const char *page, size_t count)
>  		return ret;
>  
>  	if (nr < BLKDEV_MIN_RQ)
> -		nr = BLKDEV_MIN_RQ;
> +		return -EINVAL;

This is potentially breaking existing scripts.

-- 
Jens Axboe
