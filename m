Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4596AA1
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxYnD7a+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469D0C433C8;
	Wed,  6 Dec 2023 02:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701830541;
	bh=O+zDl8lYB6kezcIvc28IrzA5YrULhL6467+WAAqJxxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sxYnD7a+9NQvuoV9MGm3tZk3f+E8NCdXkYrHSbxQ7fjQUa41dXDJsnVJ8X+MvWP8v
	 LeBlS8aEGJZWvaEWbStcMX0bKr6LAWG8ijQsE+/TwU4JaCWwA4PRF1uGFrdRqn8FFm
	 Gktg8kGyFMSGFgLN057tPWuQ4xtQ3Rw6fSYcavrPkT3tfdu4cUGRfgMOrOwS3xCLCy
	 kXEA1e89kx2nMYj50gYK0Q8ejGTq3NiOHhBzz4xDXxz8KNxwBquVEilNWZ1iMmfGmn
	 6GRmxXNx/b1hn9s5pmhBDGmScMBJiYHrhAHSPPezo7E+l3jX8Dmv2/HVotcj+neIxK
	 3Y3YXAAL1UOnw==
Message-ID: <100ddd75-eef5-44e9-93ff-34e093b19ab7@kernel.org>
Date: Wed, 6 Dec 2023 11:42:16 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231205053213.522772-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/23 14:32, Bart Van Assche wrote:
> Fix the following two issues:
> - Even with prio_aging_expire set to zero, I/O priorities still affect the
>   request order.
> - Assigning I/O priorities with the ioprio cgroup policy breaks zoned
>   storage support in the mq-deadline scheduler.

Can you provide more details ? E.g. an example of a setup that breaks ordering ?

> This patch fixes both issues by disabling I/O prioritization for these
> two cases.

... when prio_aging_expire is set to 0. Right ? Otherwise, the sentence above
reads as if you are disabling IO priority for zoned devices...

Also,

> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index fe5da2ade953..6781cef0109e 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -123,14 +123,16 @@ deadline_rb_root(struct dd_per_prio *per_prio, struct request *rq)
>   * Returns the I/O priority class (IOPRIO_CLASS_*) that has been assigned to a
>   * request.
>   */
> -static u8 dd_rq_ioclass(struct request *rq)
> +static u8 dd_rq_ioclass(struct deadline_data *dd, struct request *rq)
>  {
> -	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
> +	return dd->prio_aging_expire ? IOPRIO_PRIO_CLASS(req_get_ioprio(rq)) :
> +				       IOPRIO_CLASS_NONE;

I personally would prefer the simpler:

	if (!dd->prio_aging_expire)
		return IOPRIO_CLASS_NONE;
	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));

>  }
>  
> -static u8 dd_bio_ioclass(struct bio *bio)
> +static u8 dd_bio_ioclass(struct deadline_data *dd, struct bio *bio)
>  {
> -	return IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +	return dd->prio_aging_expire ? IOPRIO_PRIO_CLASS(bio->bi_ioprio) :
> +				       IOPRIO_CLASS_NONE;

Same comment as above.

>  }
>  
>  /*
> @@ -233,7 +235,7 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
>  			      enum elv_merge type)
>  {
>  	struct deadline_data *dd = q->elevator->elevator_data;
> -	const u8 ioprio_class = dd_rq_ioclass(req);
> +	const u8 ioprio_class = dd_rq_ioclass(dd, req);
>  	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>  	struct dd_per_prio *per_prio = &dd->per_prio[prio];
>  
> @@ -253,7 +255,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
>  			       struct request *next)
>  {
>  	struct deadline_data *dd = q->elevator->elevator_data;
> -	const u8 ioprio_class = dd_rq_ioclass(next);
> +	const u8 ioprio_class = dd_rq_ioclass(dd, next);
>  	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>  
>  	lockdep_assert_held(&dd->lock);
> @@ -550,7 +552,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>  	dd->batching++;
>  	deadline_move_request(dd, per_prio, rq);
>  done:
> -	ioprio_class = dd_rq_ioclass(rq);
> +	ioprio_class = dd_rq_ioclass(dd, rq);
>  	prio = ioprio_class_to_prio[ioprio_class];
>  	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
>  	dd->per_prio[prio].stats.dispatched++;
> @@ -749,7 +751,7 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
>  			    struct bio *bio)
>  {
>  	struct deadline_data *dd = q->elevator->elevator_data;
> -	const u8 ioprio_class = dd_bio_ioclass(bio);
> +	const u8 ioprio_class = dd_bio_ioclass(dd, bio);
>  	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>  	struct dd_per_prio *per_prio = &dd->per_prio[prio];
>  	sector_t sector = bio_end_sector(bio);
> @@ -814,7 +816,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	 */
>  	blk_req_zone_write_unlock(rq);
>  
> -	prio = ioprio_class_to_prio[dd_rq_ioclass(rq)];
> +	prio = ioprio_class_to_prio[dd_rq_ioclass(dd, rq)];
>  	per_prio = &dd->per_prio[prio];
>  	if (!rq->elv.priv[0]) {
>  		per_prio->stats.inserted++;
> @@ -923,7 +925,7 @@ static void dd_finish_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
>  	struct deadline_data *dd = q->elevator->elevator_data;
> -	const u8 ioprio_class = dd_rq_ioclass(rq);
> +	const u8 ioprio_class = dd_rq_ioclass(dd, rq);
>  	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>  	struct dd_per_prio *per_prio = &dd->per_prio[prio];

What about the call to dd_dispatch_prio_aged_requests() in
dd_dispatch_request() ? Shouldn't that call be skipped if prio_aging_expire is 0 ?

>  

-- 
Damien Le Moal
Western Digital Research

