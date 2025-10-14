Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1CF9C0
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 04:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760415423; cv=none; b=IgKk2WiYRa9KsNv32dzKa031IqkTvHgWI7eBUfzlmSLWjctE+DZsh+6D7svNL+ABanGZVEGnHZ/FABBlucZXTLddStsHJGuc+sN5jI6LOwqjO1Tx1ETxONGg9QULx/6CWssB15z3IRE+psYRL/cG0bn6QmAz/iAdw7bpQTyEisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760415423; c=relaxed/simple;
	bh=FpL06gZb1uaSAD7UGS5WtuCLiRdDkf6wCanwloMbn5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQpIHNyUDEVkx63Ppd9oemVgz978lcOwX7o5AFHKNbfg15FYeg5z4z17ni/qBVE+HUID3EF0JELkj9TJGnKBDAzjFPSvG5+ZOWTCQ3YxBFeepiMgJGFY48KPbW3hEfiooBFQRnVcdCUTuQLVVR75JNnAaTAAEHP+UwQSG3PtT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeYFGUBK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeYFGUBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC70C4CEE7;
	Tue, 14 Oct 2025 04:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760415422;
	bh=FpL06gZb1uaSAD7UGS5WtuCLiRdDkf6wCanwloMbn5M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MeYFGUBKo+Ds0ypzgOpzd9GW7UIOk6J4Vu3FvgtJGcMRNrNZMDw+mjZA1GhXmVXaz
	 TVVCXHjtzDgG7fTlarsiz/ttUf6C7V4skjcnk6vmyN6YL1QO3Nn0qT7ZTTYQW84wor
	 LSZR7kJ020XvE1UHYBTnPj4ac7Robn6n1uR6Otkm3HHmz+bGE/v8peloRyNMT70Y1I
	 51b/NMgTMq186cxumL8vXT707jCRq2UL4EKbtW7jC1cvCXwXFttVyaaX2fdfJgMwTB
	 i45RPeSKbQAxUMRPUNCz+64irMXFv9PjJwQ+iDJAjOKZtLscAJDc7cfRx24hbNKSCk
	 BtC/yFf/xR/DQ==
Message-ID: <063353d7-9d79-461e-a974-4419a5b6421c@kernel.org>
Date: Tue, 14 Oct 2025 13:16:58 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/mq-deadline: Introduce dd_start_request()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Yu Kuai <yukuai@kernel.org>, chengkaitao <chengkaitao@kylinos.cn>
References: <20251013192803.4168772-1-bvanassche@acm.org>
 <20251013192803.4168772-2-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013192803.4168772-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/14 4:28, Bart Van Assche wrote:
> Prepare for adding a second caller of this function. No functionality
> has been changed.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Yu Kuai <yukuai@kernel.org>
> Cc: chengkaitao <chengkaitao@kylinos.cn>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

One nit below.

Other than that, looks fine to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/mq-deadline.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 3e741d33142d..647a45f6d935 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -306,6 +306,19 @@ static bool started_after(struct deadline_data *dd, struct request *rq,
>  	return time_after(start_time, latest_start);
>  }
>  
> +static struct request *dd_start_request(struct deadline_data *dd,
> +					enum dd_data_dir data_dir,
> +					struct request *rq)

Why return the request that is passed ? Not sure that is necessary.


> +{
> +	u8 ioprio_class = dd_rq_ioclass(rq);
> +	enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
> +
> +	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
> +	dd->per_prio[prio].stats.dispatched++;
> +	rq->rq_flags |= RQF_STARTED;
> +	return rq;
> +}



-- 
Damien Le Moal
Western Digital Research
