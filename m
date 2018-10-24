Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: place trace_block_getrq() in correct place
To: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-block@vger.kernel.org
Cc: axboe@kernel.dk
References: <20181023143050.121915-1-xiaoguang.wang@linux.alibaba.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3dc63d55-4546-ed73-f75d-6775b9f2df5c@oracle.com>
Date: Wed, 24 Oct 2018 09:30:07 +0800
MIME-Version: 1.0
In-Reply-To: <20181023143050.121915-1-xiaoguang.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 10/23/18 10:30 PM, Xiaoguang Wang wrote:
> trace_block_getrq() is to indicate a request struct has been allcoated
> for queue, so put it in right place.
> 
> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> ---
>  block/blk-mq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e3c39ea8e17b..93aec25f1340 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1833,8 +1833,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  
>  	rq_qos_throttle(q, bio, NULL);
>  
> -	trace_block_getrq(q, bio, bio->bi_opf);
> -
>  	rq = blk_mq_get_request(q, bio, bio->bi_opf, &data);
>  	if (unlikely(!rq)) {
>  		rq_qos_cleanup(q, bio);
> @@ -1843,6 +1841,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  		return BLK_QC_T_NONE;
>  	}
>  
> +	trace_block_getrq(q, bio, bio->bi_opf);
> +
>  	rq_qos_track(q, rq, bio);
>  
>  	cookie = request_to_qc_t(data.hctx, rq);
> 

Looks fine.

Reviewed-by:  Jianchao Wang <jianchao.w.wang@oracle.com>

Thanks
Jianchao
