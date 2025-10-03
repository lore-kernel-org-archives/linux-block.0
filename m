Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111313A3ED;
	Fri,  3 Oct 2025 04:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465030; cv=none; b=Q18Gaek1ZzXLRdp9izuPPRGIncbWsS2oUqLQX8czmTSOy1DCGEMkJ6HCtIoiAjscVXq9w/wWKFwv1k1Jb8owpW4fx8gNjfDikGNUuthum38zpquR1uLSSohWyh8OPE9vNj480RcxYivLtgrWDsOkhwiWyjKpWsHpf6HF6R3MoL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465030; c=relaxed/simple;
	bh=WNhe/bSy1mRmeQ6EZEve+nGVfcnJGUPr+thX6Fl59+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+1qbecE+fLmNEuH1bOFzbGlRIOyBvWJw9KtlERnqhclEfjG6ZAsmU/YlXuwJ1UppuQrt2zdserfp1XG5kciEoXpFMahtpEjY3QykVthnDHBoLeX2GueOARznWnkF1iXH9BO8L6AtyP0afjobhxRgcbq7naA8txs4JA1OOAamuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKPHqoZD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKPHqoZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F071C4CEF5;
	Fri,  3 Oct 2025 04:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759465029;
	bh=WNhe/bSy1mRmeQ6EZEve+nGVfcnJGUPr+thX6Fl59+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WKPHqoZDRc3T2p6r2Ct6lcvb1WnkjgoVtIkcZm+7kfQ5c4MgSMninQ22dEub6B/Hp
	 dV5eI4hXkj99Ozf0SUgr/rI29etVWF1Mj25InIngWY/vXlRzIm1c04AuVanumt4RKv
	 sMDcha5/VZZXCxYZNV9Z6M6E4uN+hvnhFwn6dt1MhID88bOqNhicAZila0ocykT5Cn
	 bSjOcGXH0iHgn+bTjOqoHojlb1qvQo3UK8Zzkglx6a7AwZ29F4Xk+RiRMoLY57pbMX
	 r9uGVn7trtVp0nd5N/PFY2/A4UC0dw9KUQevkpWbl0J0UwKAvd28bXt045rS345Rdl
	 ou0QobphvcDYQ==
Message-ID: <836230c2-44d6-45e3-a25b-0ec5d56c5f7a@kernel.org>
Date: Fri, 3 Oct 2025 13:17:05 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] block/mq-deadline: adjust the timeout period of
 the per_prio->dispatch
To: chengkaitao <pilgrimtao@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 chengkaitao <chengkaitao@kylinos.cn>
References: <20250926023818.16223-1-pilgrimtao@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250926023818.16223-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 11:38, chengkaitao wrote:
> From: chengkaitao <chengkaitao@kylinos.cn>
> 
> Reference function started_after()

What does this mean ?

> Before modification:
> 	Timeout for dispatch{read}: 9.5s
> 	started_after - 0.5s < latest_start - 10s
> 	9.5s < latest_start - started_after
> 
> 	Timeout for dispatch{write}: 5s
> 	started_after - 5s < latest_start - 10s
> 	5s < latest_start - started_after
> 
> At this point, write requests have higher priority than read requests.
> 
> After modification:
> 	Timeout for dispatch{read/write}: 5s
> 	prio_aging_expire / 2 < latest_start - started_after

This is extremely hard to parse and understand. Can you please make full
sentences that explain what the problem is, and for your example, the starting
situation/state you are in ? E.g "If there are a lot of request inserted at
head, then ... Blah"

Also, in the title, s/timeout period/timeout

> Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
> ---
>  block/mq-deadline.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index b9b7cdf1d3c9..f311168f8dfe 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -672,7 +672,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	if (flags & BLK_MQ_INSERT_AT_HEAD) {
>  		list_add(&rq->queuelist, &per_prio->dispatch);
> -		rq->fifo_time = jiffies;
> +		rq->fifo_time = jiffies + dd->fifo_expire[data_dir]
> +				- dd->prio_aging_expire / 2;

The request is inserted to the dispatch list directly here. So why do we need to
change the timeout to switch to fifo ? Your commit message does not explain that
at all, and I do not see a trivial explanation for it myself. Please clarify.
I suspect that you have a situation where you see a lot of requeue at head and
that completely skew the fifo/prio aging ? I am memrely guessing here. Please
resend your patch with a clear commit message, and also a comment for the change
above explaining what is being done.

>  	} else {
>  		deadline_add_rq_rb(per_prio, rq);
>  


-- 
Damien Le Moal
Western Digital Research
