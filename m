Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-sched: Enable merging discard bio into request
To: Keith Busch <keith.busch@intel.com>,
 Linux Block <linux-block@vger.kernel.org>
Cc: Linux NVMe <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <20180201214115.24909-1-keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9e92670b-2e60-c8fb-54f8-84c2959a3c8f@kernel.dk>
Date: Thu, 1 Feb 2018 14:45:44 -0700
MIME-Version: 1.0
In-Reply-To: <20180201214115.24909-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/1/18 2:41 PM, Keith Busch wrote:
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  block/blk-mq-sched.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 55c0a745b427..25c14c58385c 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -259,6 +259,8 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
>  		if (!*merged_request)
>  			elv_merged_request(q, rq, ELEVATOR_FRONT_MERGE);
>  		return true;
> +	case ELEVATOR_DISCARD_MERGE:
> +		return bio_attempt_discard_merge(q, rq, bio);
>  	default:
>  		return false;

Thanks Keith, applied.

-- 
Jens Axboe
