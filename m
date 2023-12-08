Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2894C60
	for <linux-block@vger.kernel.org>; Fri,  8 Dec 2023 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0PjQTVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D190BC433C7;
	Fri,  8 Dec 2023 03:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702006675;
	bh=9SCEYl+KewgxDkj1I8Bn5lIVPoRX1EKQC9T7qsVgEEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p0PjQTVcLc8gSQ0fXVUUMvu1bYa0HR2Y/WeS5O5hEmZGb6pKTp6/3LdBRcCZVqmq+
	 m+otqBb+PTnwIuUv3WL0+NHwK8eAe0qoC0fxIXJzCqwwL5i3fnDfjoMF0voO8We1RO
	 +GO3D5iUJ7zf7unvggTCrXTqbhHrfyeMLra0p28DxpGx8Z7NYBJDyDqDlKhwAS3cat
	 ePsKDKIHx0EmeqCm6aGy+3n/11F/rpKWJ3/J7ME9RnU6EpfEsqZyBw8OOrts5jWZL3
	 OOSNMf7JAdbHNYf3WEeKnpVCd6qGB+RaT3gaE/FGM6GoE52+TPh4I20+7k1Bfdl9RN
	 rgYNh3z2O3cxg==
Message-ID: <37f3179a-9add-4ee6-9ae9-cf84c1584366@kernel.org>
Date: Fri, 8 Dec 2023 12:37:51 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org>
 <100ddd75-eef5-44e9-93ff-34e093b19ab7@kernel.org>
 <4d506909-e063-4918-a9d3-e91bfa5a41a3@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4d506909-e063-4918-a9d3-e91bfa5a41a3@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/23 09:03, Bart Van Assche wrote:
> On 12/5/23 16:42, Damien Le Moal wrote:
>> ... when prio_aging_expire is set to 0. Right ? Otherwise, the sentence above
>> reads as if you are disabling IO priority for zoned devices...
> 
> Hi Damien,
> 
> I just noticed that I posted an old version of this patch (3/3). In the patch
> below I/O priorities are ignored for zoned writes.
> 
> Thanks,
> 
> Bart.
> 
> 
> Subject: [PATCH] block/mq-deadline: Disable I/O prioritization in certain cases
> 
> Fix the following two issues:
> - Even with prio_aging_expire set to zero, I/O priorities still affect the
>    request order.
> - Assigning I/O priorities with the ioprio cgroup policy breaks zoned
>    storage support in the mq-deadline scheduler.
> 
> This patch fixes both issues by disabling I/O prioritization for these
> two cases.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 37 ++++++++++++++++++++++++-------------
>   1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index fe5da2ade953..310ff133ce20 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -119,18 +119,27 @@ deadline_rb_root(struct dd_per_prio *per_prio, struct request *rq)
>   	return &per_prio->sort_list[rq_data_dir(rq)];
>   }
> 
> +static bool dd_use_io_priority(struct deadline_data *dd, enum req_op op)
> +{
> +	return dd->prio_aging_expire != 0 && !op_needs_zoned_write_locking(op);
> +}

Hard NACK on this. The reason is that this will disable IO priority also for
sensible use cases that use libaio/io_uring with direct IOs, with an application
that does the right thing for writes, namely assigning the same priority for all
writes to a zone. There are some use cases like this in production.

I do understand that there is a problem when IO priorities come from cgroups and
the user go through a file system. But that should be handled by the file
system. That is, for f2fs, all writes going to the same zone should have the
same priority. Otherwise, priority inversion issues will lead to non sequential
write patterns.

Ideally, we should indeed have a generic solution for the cgroup case. But it
seems that for now, the simplest thing to do is to not allow priorities through
cgroups for writes to zoned devices, unless cgroups is made more intellignet
about it and manage bio priorities per zone to avoid priority inversion within a
zone.

> +
>   /*
>    * Returns the I/O priority class (IOPRIO_CLASS_*) that has been assigned to a
>    * request.
>    */
> -static u8 dd_rq_ioclass(struct request *rq)
> +static u8 dd_rq_ioclass(struct deadline_data *dd, struct request *rq)
>   {
> -	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
> +	if (dd_use_io_priority(dd, req_op(rq)))
> +		return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
> +	return IOPRIO_CLASS_NONE;
>   }
> 
> -static u8 dd_bio_ioclass(struct bio *bio)
> +static u8 dd_bio_ioclass(struct deadline_data *dd, struct bio *bio)
>   {
> -	return IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +	if (dd_use_io_priority(dd, bio_op(bio)))
> +		return IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +	return IOPRIO_CLASS_NONE;
>   }
> 
>   /*
> @@ -233,7 +242,7 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
>   			      enum elv_merge type)
>   {
>   	struct deadline_data *dd = q->elevator->elevator_data;
> -	const u8 ioprio_class = dd_rq_ioclass(req);
> +	const u8 ioprio_class = dd_rq_ioclass(dd, req);
>   	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>   	struct dd_per_prio *per_prio = &dd->per_prio[prio];
> 
> @@ -253,7 +262,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
>   			       struct request *next)
>   {
>   	struct deadline_data *dd = q->elevator->elevator_data;
> -	const u8 ioprio_class = dd_rq_ioclass(next);
> +	const u8 ioprio_class = dd_rq_ioclass(dd, next);
>   	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
> 
>   	lockdep_assert_held(&dd->lock);
> @@ -550,7 +559,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>   	dd->batching++;
>   	deadline_move_request(dd, per_prio, rq);
>   done:
> -	ioprio_class = dd_rq_ioclass(rq);
> +	ioprio_class = dd_rq_ioclass(dd, rq);
>   	prio = ioprio_class_to_prio[ioprio_class];
>   	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
>   	dd->per_prio[prio].stats.dispatched++;
> @@ -606,9 +615,11 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   	enum dd_prio prio;
> 
>   	spin_lock(&dd->lock);
> -	rq = dd_dispatch_prio_aged_requests(dd, now);
> -	if (rq)
> -		goto unlock;
> +	if (dd->prio_aging_expire != 0) {
> +		rq = dd_dispatch_prio_aged_requests(dd, now);
> +		if (rq)
> +			goto unlock;
> +	}
> 
>   	/*
>   	 * Next, dispatch requests in priority order. Ignore lower priority
> @@ -749,7 +760,7 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
>   			    struct bio *bio)
>   {
>   	struct deadline_data *dd = q->elevator->elevator_data;
> -	const u8 ioprio_class = dd_bio_ioclass(bio);
> +	const u8 ioprio_class = dd_bio_ioclass(dd, bio);
>   	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>   	struct dd_per_prio *per_prio = &dd->per_prio[prio];
>   	sector_t sector = bio_end_sector(bio);
> @@ -814,7 +825,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   	 */
>   	blk_req_zone_write_unlock(rq);
> 
> -	prio = ioprio_class_to_prio[dd_rq_ioclass(rq)];
> +	prio = ioprio_class_to_prio[dd_rq_ioclass(dd, rq)];
>   	per_prio = &dd->per_prio[prio];
>   	if (!rq->elv.priv[0]) {
>   		per_prio->stats.inserted++;
> @@ -923,7 +934,7 @@ static void dd_finish_request(struct request *rq)
>   {
>   	struct request_queue *q = rq->q;
>   	struct deadline_data *dd = q->elevator->elevator_data;
> -	const u8 ioprio_class = dd_rq_ioclass(rq);
> +	const u8 ioprio_class = dd_rq_ioclass(dd, rq);
>   	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>   	struct dd_per_prio *per_prio = &dd->per_prio[prio];
> 
> 

-- 
Damien Le Moal
Western Digital Research

