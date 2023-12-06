Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3CD27A
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQtQqg3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D56C433C8;
	Wed,  6 Dec 2023 02:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701830117;
	bh=CASAG12PJh5P+0wyZlov9TRtYzrjHTSdYIsrfn/Glxc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FQtQqg3MYg2aXmGskM/12Vcp5tIcez+eWLpqE2qOm9/OB9nKjEVQrRbhukqAeYtNu
	 aiK4eEatJGU88x4tJK7Y9GbMI9pz/X5Wt6b/JnhqpxJjfJ7ZJPuY5n1aC82HSmvUC4
	 dlgsOGd0C1rBGTUE6IZKdEzbS93BAwNga8gqng2qD6rLbtlKlL9vi3ohZYeBQaTvKi
	 71z5idVwLDICoggh1L/zO+SRkaF4/SNvIuQ0lOrOKiI3+Vj9dO5lnNaIiJxM1cYYyS
	 n0TH9SA1JAaBWgVpH2LwTT94SbP0/q1xsbdxBcw022JjN2UeokTZ4Uoc0CPl4SNqCo
	 LqohtNMgFgg6g==
Message-ID: <97f19fe6-fdca-487e-80f6-fa246013fc88@kernel.org>
Date: Wed, 6 Dec 2023 11:35:15 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block/mq-deadline: Use dd_rq_ioclass() instead of
 open-coding it
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-2-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231205053213.522772-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/23 14:32, Bart Van Assche wrote:
> Use an existing helper function instead of open-coding it. No
> functionality is changed by this patch.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/mq-deadline.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index f958e79277b8..e558f3660357 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -798,8 +798,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	struct request_queue *q = hctx->queue;
>  	struct deadline_data *dd = q->elevator->elevator_data;
>  	const enum dd_data_dir data_dir = rq_data_dir(rq);
> -	u16 ioprio = req_get_ioprio(rq);
> -	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
>  	struct dd_per_prio *per_prio;
>  	enum dd_prio prio;
>  
> @@ -811,7 +809,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	 */
>  	blk_req_zone_write_unlock(rq);
>  
> -	prio = ioprio_class_to_prio[ioprio_class];
> +	prio = ioprio_class_to_prio[dd_rq_ioclass(rq)];
>  	per_prio = &dd->per_prio[prio];
>  	if (!rq->elv.priv[0]) {
>  		per_prio->stats.inserted++;

-- 
Damien Le Moal
Western Digital Research

