Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA52F4A;
	Fri,  6 Sep 2024 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603512; cv=none; b=B4rSOApNcMAMvrkupRuopmwb1gEt/Vd65o75aadfg7mP/+ffFgXX6/FSqziaFaxjN5pBwXsxL/nb+SuJeV3GnFC4Duih8LAummgJQtzwtEjXbVeBl+wvQ7m69KxphoowQzmg9ahOiZJnLDEINXvaLv1+6+Y3kjpPcjLWEHHFpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603512; c=relaxed/simple;
	bh=pWynbT4Bo6x+Mpc5PslWstyrB67capCi++OODjFq6H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtpJhAoS5z2vRbKkdyEDVFXOYthQWHeIXyCtys2A6nMbrFhygsM+CC66fqbrS8Gcbw/TUsVNxjejG1U+Cy3tGp3dd+oaT/bR/fcdUn9zUfiG3QsDU6YwC+h277xa0p1rkZUiWeUiACbNweOz/Xuy2dhMB64OsrhDO02p/mVZlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK+Z2e2P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK+Z2e2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF326C4CEC4;
	Fri,  6 Sep 2024 06:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725603511;
	bh=pWynbT4Bo6x+Mpc5PslWstyrB67capCi++OODjFq6H8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CK+Z2e2P5EfK2ZDK86PGh9QayZggVJdvZxxsMZ7RsamBZAFGqzenwyXDpJYnj9X81
	 nbPZv2a3PEEJm4mZ96Uav/V1IP1vbcAUR8RSWqvTan3ca5uhfHKwlqIOxCGDx3g+2w
	 Wg/vkdnMjatToqrD67CRk76B0IjiGKnmcwKS/b8K75uMvHU252Fx7SHYfSo6sbncNt
	 86nwGIQunlRIJ4h2MUFbu8HRPM6G4iwGQn6Xzs5nn0D2wKLokKxsAjHsvf60TYWaw7
	 8bap/Vbt0+WPg/yyYr5OKv1LoKoHxj98AFgslgrXrboEfnrxstOnkuzyo0bMlPThcR
	 UeCU6DgmpWBmw==
Message-ID: <4ce112ca-9c2d-4091-9e98-f2d08e5db299@kernel.org>
Date: Fri, 6 Sep 2024 15:18:29 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: move non sync requests complete flow to softirq
To: ZhangHui <zhanghui31@xiaomi.com>, axboe@kernel.dk, bvanassche@acm.org,
 ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240906031431.366806-1-zhanghui31@xiaomi.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240906031431.366806-1-zhanghui31@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 12:14, ZhangHui wrote:
> From: zhanghui <zhanghui31@xiaomi.com>
> 
> Currently, for a controller that supports multiple queues, like UFS4.0,
> the mq_ops->complete is executed in the interrupt top-half. Therefore, 
> the file system's end io is executed during the request completion process,
> such as f2fs_write_end_io on smartphone.
> 
> However, we found that the execution time of the file system end io
> is strongly related to the size of the bio and the processing speed
> of the CPU. Because the file system's end io will traverse every page
> in bio, this is a very time-consuming operation.
> 
> We measured that the 80M bio write operation on the little CPU will
> cause the execution time of the top-half to be greater than 100ms,
> which will undoubtedly affect interrupt response latency.
> 
> Let's fixed this issue by moved non sync request completion flow to
> softirq, and keep the sync request completion in the top-half.

Typos/grammar:

Let's fix this issue by moving non sync requests completion to softirq context,
and keeping sync requests completion in the irq top-half context.

> 
> Signed-off-by: zhanghui <zhanghui31@xiaomi.com>
> ---
> Changes in v4:
> - fix commit log from "scheduling efficiency" to "interrupt response latency"
> 
> Changes in v3:
> - modify op_is_sync to rq_is_sync
> 
> Changes in v2:
> - fix build warning
> ---
>  block/blk-mq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e3c3c0c21b55..06b232edff11 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1193,6 +1193,8 @@ static void blk_mq_raise_softirq(struct request *rq)
>  
>  bool blk_mq_complete_request_remote(struct request *rq)
>  {
> +	const bool is_sync = rq_is_sync(rq);
> +
>  	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>  
>  	/*
> @@ -1210,7 +1212,7 @@ bool blk_mq_complete_request_remote(struct request *rq)
>  		return true;
>  	}
>  
> -	if (rq->q->nr_hw_queues == 1) {
> +	if ((rq->q->nr_hw_queues == 1) || !is_sync) {

I do not see the point of the is_sync variable, and you do not need the inner
parenthesis either. Why not:

	if (rq->q->nr_hw_queues == 1 || !rq_is_sync(rq)) {

And a comment before the "if" explaining why soft-irq is raised for non-sync
requests would be nice too.

>  		blk_mq_raise_softirq(rq);
>  		return true;
>  	}

-- 
Damien Le Moal
Western Digital Research

