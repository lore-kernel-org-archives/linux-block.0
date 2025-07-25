Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46022A808;
	Fri, 25 Jul 2025 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438869; cv=none; b=Yo9gp5xQJE443lIFojEfFtkqocfkqzcbkp8Jg4Mo4UETbqomR0SE8/kewVOSVspSVJ+u3+Wyv5D3LHIZo1Z7UYxc+xcxed0aaavU2mJOOOsz4uF9ZhDmNcCgld9FTB1wRbW1tN75URxo8BBJC0KFVVLVNRSFek8Acdz63xaSecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438869; c=relaxed/simple;
	bh=CQaDYEvyI/89r3xyhVKCo7dR35Wb+w1sxKMA6thkqOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZou22PTNZRpatg0VCsVpRylkqVCdyoGEP76DwSnZLn/pGPz6U9x060gGmp1eSGMdlFNw8mWYh3vgxvZodLGal+8KvStz9wdHVM2Y7GF0oKQ6V6SPBhNIX736qNFuLUFn/b865S4CFbVUtNmTJ14HLMPy0TnrC4pmhOx6kbaK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/Qcyc+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/Qcyc+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC36C4CEE7;
	Fri, 25 Jul 2025 10:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753438869;
	bh=CQaDYEvyI/89r3xyhVKCo7dR35Wb+w1sxKMA6thkqOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f/Qcyc+fJLIRbdioNuXv9/ezHm21Kz0V4EjSRH8ZjKkdcP2ciCtSGF+IO1j0LNQa/
	 0UF2dFKTJDao/bKaNPGD1wn5WFGgBBO+kjemXiyJ89p4pS0e29l43kfPfcRLHy/pay
	 /C7jMetkMklMttCN+NgN2Sf8yp1yu2+QcSsHz9P2e7Gq6Fs91COMBPYWgQf+v0wflj
	 9YfDfKS0n3wSS1rFPRILqfmn1+egy6Q/MhFLX/xxo5X456ZTpBnpNbJmo8K2vWSq3Z
	 6S/l6UZltTFjx7grMGwHSm1QK3U8r2FfzXEPzrXjkGY5LL6++x77CG8oDUwHmkeHgN
	 WqKWih64fnCtQ==
Message-ID: <3653febf-0c36-48ca-9d51-7cf93e5b25f1@kernel.org>
Date: Fri, 25 Jul 2025 19:21:06 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] blk-ioc: add a new helper ioc_lookup_icq_rcu()
To: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250725070547.3953398-1-yukuai1@huaweicloud.com>
 <20250725070547.3953398-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250725070547.3953398-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/25 16:05, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> ioc_lookup_icq() is used by bfq to lookup bfqq from IO path, the helper
> have to be protected by queue_lock, which is too heavy. Hence add a new
> helper that is lookless, this is safe because both request_queue and ioc
> can be pinged by IO that is still issuing.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-ioc.c | 34 ++++++++++++++++++++++++++++++++++
>  block/blk.h     |  1 +
>  2 files changed, 35 insertions(+)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index ce82770c72ab..4945b48dfdb6 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -343,6 +343,40 @@ struct io_cq *ioc_lookup_icq(struct request_queue *q)
>  }
>  EXPORT_SYMBOL(ioc_lookup_icq);
>  
> +/**
> + * ioc_lookup_icq_rcu - lookup io_cq from ioc in io path
> + * @q: the associated request_queue
> + *
> + * Look up io_cq associated with @ioc - @q pair from @ioc. Must be called from
> + * io issue path, either return NULL if current issue io to @q for the first
> + * time, or return a valid icq.
> + */
> +struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q)
> +{
> +	struct io_context *ioc = current->io_context;
> +	struct io_cq *icq;
> +
> +	WARN_ON_ONCE(percpu_ref_is_zero(&q->q_usage_counter));

I do not think this is necessary.

> +
> +	if (!ioc)
> +		return NULL;
> +
> +	icq = rcu_dereference(ioc->icq_hint);
> +	if (icq && icq->q == q)
> +		return icq;
> +
> +	icq = radix_tree_lookup(&ioc->icq_tree, q->id);
> +	if (!icq)
> +		return NULL;
> +
> +	if (WARN_ON_ONCE(icq->q != q))
> +		return NULL;
> +
> +	rcu_assign_pointer(ioc->icq_hint, icq);
> +	return icq;
> +}
> +EXPORT_SYMBOL(ioc_lookup_icq_rcu);

Patch 2 calls this function with the rcu_read_lock() held. Why not move that rcu
read lock here inside this function ? That is how ioc_lookup_icq() was doing
things, with code that is more compact than this.

And since ioc_lookup_icq() was already using RCU, it seems that the only change
you need is to remove the "lockdep_assert_held(&q->queue_lock);" from that
function to endup with the same above functionality. So why all the churn ?

Another question is: is it safe to call radix_tree_lookup() without any lock
held ? What if this races with a radix tree insertion ? (I may be wrong here as
I am not familiar with that code).

> +
>  /**
>   * ioc_create_icq - create and link io_cq
>   * @q: request_queue of interest
> diff --git a/block/blk.h b/block/blk.h
> index 468aa83c5a22..ef31b3ec1c69 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -461,6 +461,7 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
>   */
>  struct io_cq *ioc_find_get_icq(struct request_queue *q);
>  struct io_cq *ioc_lookup_icq(struct request_queue *q);
> +struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q);
>  #ifdef CONFIG_BLK_ICQ
>  void ioc_clear_queue(struct request_queue *q);
>  #else


-- 
Damien Le Moal
Western Digital Research
