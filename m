Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD102A8D3
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 04:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770444; cv=none; b=jrmM+RTrQjX+VdhFwNUzjOyNOWT8DnkvHcZzmdBJGq8l5KkbLmx2sgWDrcNKpBpooCi3+18SuKLZwy0KEp4flW6SC9mxQSRwnvUGuaWlIFz3+K5N8kKHs8DLAVXmDZKhz0YoCUlxhlmpYl4HCweq/27WDAJb+Vx8jSTeEqmKAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770444; c=relaxed/simple;
	bh=FAHJLm/pvpg/dpB1ukrI1HDhmIPd7VAPuEiEoX8SW9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bh3DnTIhfWwAXyhX9ggGcc+5FePav0vh1hxcFTlYCAQfY0n4JbfvhCuJTmYTET918S4KQhBwOXhE2kI8OUCXGeU7JAIq5HomIT6iXuEOlIqu6TJa27WNnkgp2GqBxR0R2PjpZ3XFDvuhjlDru0WxqfwiVLg/tR7e5c4vh7cAnec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH8r/Zef; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH8r/Zef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E71EC2BBFC;
	Wed, 19 Jun 2024 04:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718770444;
	bh=FAHJLm/pvpg/dpB1ukrI1HDhmIPd7VAPuEiEoX8SW9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rH8r/ZefCrlUzZ8czUKh/tdajGJds/OxrgYX0bfAeCV+nH5QIbUwhGbEHUoEMztNN
	 ClK5YmFF53fSSi4NGJ1LLPLMtfkr7uHb3eW3DyMPMfm9rvrBH87kPrY/+ORRh15PjW
	 0lcDNbAbfJ+20lounTjsU0ij8d1hFkvOxH0n3bD2y00wKfmtHrY9Io0OgeIEJJVZMZ
	 dq2OvfXbQIjCxcIBTUjDgcrughYXtpq+JyyyMoMHXidEjW8qZwhrKDj2qUWLYZZW7N
	 os67eO+blnfy5aJLoXQcoQAFQ8zZofsHJHi9BJbTp8hDdDN9PJtUC2+w1LqquJVWAk
	 vsjvyMILLuBHQ==
Message-ID: <7ed12f7e-f59a-4f6f-975b-ce7bb21652de@kernel.org>
Date: Wed, 19 Jun 2024 13:14:02 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: check bio alignment in blk_mq_submit_bio
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 Ye Bin <yebin10@huawei.com>
References: <20240619033443.3017568-1-ming.lei@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240619033443.3017568-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 12:34, Ming Lei wrote:
> IO logical block size is one fundamental queue limit, and every IO has
> to be aligned with logical block size because our bio split can't deal
> with unaligned bio.
> 
> The check has to be done with queue usage counter grabbed because device
> reconfiguration may change logical block size, and we can prevent the
> reconfiguration from happening by holding queue usage counter.
> 
> logical_block_size stays in the 1st cache line of queue_limits, and this
> cache line is always fetched in fast path via bio_may_exceed_limits(),
> so IO perf won't be affected by this check.
> 
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ye Bin <yebin10@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3b4df8e5ac9e..7bb50b6b9567 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2914,6 +2914,21 @@ static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
>  	INIT_LIST_HEAD(&rq->queuelist);
>  }
>  
> +static bool bio_unaligned(const struct bio *bio,
> +		const struct request_queue *q)
> +{
> +	unsigned int bs = queue_logical_block_size(q);
> +
> +	if (bio->bi_iter.bi_size & (bs - 1))
> +		return true;
> +
> +	if (bio->bi_iter.bi_size &&
> +	    ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1)))

Hmmm... Some BIO operations have a 0 size but do specify a sector (e.g. zone
management operations). So this seems incorrect to me...

> +		return true;
> +
> +	return false;
> +}
> +
>  /**
>   * blk_mq_submit_bio - Create and send a request to block device.
>   * @bio: Bio pointer.
> @@ -2966,6 +2981,15 @@ void blk_mq_submit_bio(struct bio *bio)
>  			return;
>  	}
>  
> +	/*
> +	 * Device reconfiguration may change logical block size, so alignment
> +	 * check has to be done with queue usage counter held
> +	 */
> +	if (unlikely(bio_unaligned(bio, q))) {
> +		bio_io_error(bio);
> +		goto queue_exit;
> +	}
> +
>  	if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
>  		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
>  		if (!bio)

-- 
Damien Le Moal
Western Digital Research

