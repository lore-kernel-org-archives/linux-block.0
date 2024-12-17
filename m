Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040C1FA15E
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734478658; cv=none; b=ajiq7r01Ten+rkBXeLCEHFkYOnME40CpJxe/blk39GybJentNEwyrQn2h+xQRaBsP4aOfmsLc6nVn6u2UlVRAdM5usbW0ZXl5m/u7sEXqwE4TiiN0VR3TYe+JXmBzs5SeshIOW4JFCYNyzt+83ibO7Sl++yZxhuFU6eHUGQiIUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734478658; c=relaxed/simple;
	bh=wiFj/smh5AIfNxxey4dh9J6dL2Em2AL43D9akJSic9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1LYpkLtXfgX4nSRx7wuyygMC5+RMVtt+IfVCHcK7mD2NsqYU0My0OWwNmTuRgXcEiTP/u+mmz8Sa0+XB0m+C7M1pLScsjYj0zE1kB+c+LISLVsxmNkQQD3crhN01dzAD5kxB1ywb592+5IFjU8bSyHLB2Z518KPxTli21ZIdvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIzsF4cL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIzsF4cL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B44C4CED3;
	Tue, 17 Dec 2024 23:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734478657;
	bh=wiFj/smh5AIfNxxey4dh9J6dL2Em2AL43D9akJSic9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HIzsF4cLNXt3lVRNqfvw485pLSTew+/wqvIp9K9zvyMZIpEdzzCKwrKY3mKuUJR4K
	 fLSSSUK5Fak5q30pDgm1jyDkDJtHCx7Zt8KBN5yePWFVcDUuIF7OQQcBgkyFw40HLG
	 yjjNqUjkuYq4d5rhq4GDIBZ+mOKe11M2BARG9nMcJInYEafk204Qa/AkirxBIsJ7Rj
	 GRJ9RPFHI1StH+LylsEvDKFKcgwMS2xYlHcqIxmhHr3II9XDgTHvUqtHQCKzUkRvru
	 YwPUhIsHgpseO7kVnM9HrmWr6nY+Aksrc8xmzLmJwi8CEU0IhJd1MRT958urIXTv2f
	 sXVcxQHCJ3lzg==
Message-ID: <9c0b2f84-2562-48fb-98e8-343d68eb792d@kernel.org>
Date: Tue, 17 Dec 2024 15:37:37 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] blk-mq: Move more error handling into
 blk_mq_submit_bio()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20241217223809.683035-1-bvanassche@acm.org>
 <20241217223809.683035-3-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241217223809.683035-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/17 14:38, Bart Van Assche wrote:
> The error handling code in blk_mq_get_new_requests() cannot be understood
> without knowing that this function is only called by blk_mq_submit_bio().
> Hence move the code for handling blk_mq_get_new_requests() failures into
> blk_mq_submit_bio().
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8d2aab4d9ba9..f4300e608ed8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2968,12 +2968,9 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>  	}
>  
>  	rq = __blk_mq_alloc_requests(&data);
> -	if (rq)
> -		return rq;
> -	rq_qos_cleanup(q, bio);
> -	if (bio->bi_opf & REQ_NOWAIT)
> -		bio_wouldblock_error(bio);
> -	return NULL;
> +	if (!rq)

No unlikely() here ?

> +		rq_qos_cleanup(q, bio);
> +	return rq;
>  }
>  
>  /*
> @@ -3106,8 +3103,11 @@ void blk_mq_submit_bio(struct bio *bio)
>  		blk_mq_use_cached_rq(rq, plug, bio);
>  	} else {
>  		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
> -		if (unlikely(!rq))
> +		if (unlikely(!rq)) {
> +			if (bio->bi_opf & REQ_NOWAIT)
> +				bio_wouldblock_error(bio);
>  			goto queue_exit;
> +		}
>  	}
>  
>  	trace_block_getrq(bio);


-- 
Damien Le Moal
Western Digital Research
