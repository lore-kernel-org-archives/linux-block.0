Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FE748A
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxu+Ug21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB59C433C7;
	Wed,  6 Dec 2023 02:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701830158;
	bh=3xT/dSZYjn2JqqeQxdIfESMb5/2CNmztx5T3NpHSzns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wxu+Ug21tGO+jSAW05zOEyr+7plJGFdfULSKxddwMocG8t8qF2zcMa3MiUsL5xTS0
	 yZMdTdoSPrEIR2B53OCcp9lvJvA6+ZNEf/eemvJ7946MuMwSI+cJiQj1fETGdXYAgK
	 sO9SGB2mkttSRVUn4X2XJWDN60KKSQhQhnmON1S/mtKbKM85YoCFYmRpCyDAzs3jby
	 t8EJlvkL+PTMe3yVGgX1za244ZX5/GH7yebVRe0Q4XUoF7ZBNRvs5U396NN2BX7V1i
	 CUe3trlbGBB926Qbx5IitXAD0EL9s8UpfRobmJYh2Cm/S1SRyyNiaeo8Oasj13ROX2
	 3RnfUGa9kfRLA==
Message-ID: <b1072f3e-8e18-4484-970d-89c9fb02dfb1@kernel.org>
Date: Wed, 6 Dec 2023 11:35:57 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block/mq-deadline: Introduce dd_bio_ioclass()
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-3-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231205053213.522772-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/23 14:32, Bart Van Assche wrote:
> Prepare for disabling I/O prioritization in certain cases.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/mq-deadline.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index e558f3660357..fe5da2ade953 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -128,6 +128,11 @@ static u8 dd_rq_ioclass(struct request *rq)
>  	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
>  }
>  
> +static u8 dd_bio_ioclass(struct bio *bio)
> +{
> +	return IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +}
> +
>  /*
>   * get the request before `rq' in sector-sorted order
>   */
> @@ -744,7 +749,7 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
>  			    struct bio *bio)
>  {
>  	struct deadline_data *dd = q->elevator->elevator_data;
> -	const u8 ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +	const u8 ioprio_class = dd_bio_ioclass(bio);
>  	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>  	struct dd_per_prio *per_prio = &dd->per_prio[prio];
>  	sector_t sector = bio_end_sector(bio);

-- 
Damien Le Moal
Western Digital Research

