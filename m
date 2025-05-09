Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4EC17D2
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 01:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746753375; cv=none; b=oMg9qt2EweqSRNutg3B0dNFf6+y7Js+y9CUjj33UxaZCjFdbTIUCnWsXoopUqowuwJ+TRZo7HwM/P9rPa7OfK0ePIMPTEdSyZQQ7MQV5qSZQO1g/abRwOu4YjhtMDZ1rbaw/mVo9Xv8UbeqhLNTVUx2BocPbP2V840v557EBc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746753375; c=relaxed/simple;
	bh=xcY5su+BqZO4iQKnXxYPq42TI+QyB+JmiMioyjjRFa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUNvD8vYIrsmQKyVXGbgAhGzBuH/W7FcK5iCsY98Iis1A5rD7czCuKE2TnmfYluaytXY4aoZiw1H6cK6RxfbU3j6sNNQbZHB0Z4dxUUY+epovdl7EiMf9K+4KTCzZ4F1s+D1/07Deu4lzQnqTOZaUK2RRzWTK8gn7+u60prZt/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZqLAAYW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZqLAAYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BF7C4CEE7;
	Fri,  9 May 2025 01:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746753374;
	bh=xcY5su+BqZO4iQKnXxYPq42TI+QyB+JmiMioyjjRFa4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eZqLAAYWGASd8rxTPQ11nnoEdGT+Ymb6Eq/YrSQ2UmfmkgW2vQs20JYK8NIFO96gb
	 qTfgDOmzlwYUMx0x70PMOw1HiDl4Y/Cki+2J4nsyFVilXqL3WDMndIV+sZ/+Y+4KfT
	 DMeu7jGGKH+vcfuL2sHXXQd9qRPliVYyApv/lpQMoEETrWsUMFJV2DHQuj4hTpVWwk
	 k8pe0qQIqNd3qxnPp9q/f8GNWHcfV9VItQcKDKeGa+1atf0cxQFWIObRflDLhIv2lK
	 Emn71r3bkBE82BOtDpmmQkPZ2H4VoXsN74XbKgIp1eJS/p8nAr5D3sEp1w+6ynqjBx
	 NBjZ3W+oYV2IA==
Message-ID: <aa288ae2-e9db-462f-993c-9079a9a0ffad@kernel.org>
Date: Fri, 9 May 2025 10:15:03 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Submit split bios in order
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20250509004201.424932-1-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250509004201.424932-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 9:42 AM, Bart Van Assche wrote:
> If a bio is split, the bio fragments are added in reverse LBA order into
> the plug list. This triggers write errors with zoned storage and
> sequential writes. Fix this by preserving the LBA order when inserting in
> the plug list.

Preserving the order of the fragment would be a good thing for all block
devices. But what I fail to see here is how this lack of ordering affects zoned
block device writes since zone write plugging will split large BIOs when a
write BIO goes through zone write plugging. That happens before we have a
request, so we should never endup needing to split a zone write request.

> 
> This patch has been posted as an RFC because this patch changes the
> complexity of inserting in the plug list from O(1) into O(n).
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 796baeccd37b..e1311264a337 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1386,6 +1386,30 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
>  	return BLK_MAX_REQUEST_COUNT;
>  }
>  
> +/*
> + * If a bio is split, the bio fragments are submitted in opposite order. Hence
> + * this function that inserts in LBA order in the plug list.
> + */
> +static inline void rq_list_insert_sorted(struct rq_list *rl, struct request *rq)
> +{
> +	sector_t rq_pos = rq->bio->bi_iter.bi_sector;
> +	struct request *next, *prev;
> +
> +	for (prev = NULL, next = rl->head; next;
> +	     prev = next, next = next->rq_next)
> +		if (next->q == rq->q && rq_pos < next->bio->bi_iter.bi_sector)
> +			break;
> +
> +	if (!prev) {
> +		rq_list_add_head(rl, rq);
> +	} else if (!next) {
> +		rq_list_add_tail(rl, rq);
> +	} else {
> +		prev->rq_next = rq;
> +		rq->rq_next = next;
> +	}
> +}
> +
>  static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>  {
>  	struct request *last = rq_list_peek(&plug->mq_list);
> @@ -1408,7 +1432,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>  	 */
>  	if (!plug->has_elevator && (rq->rq_flags & RQF_SCHED_TAGS))
>  		plug->has_elevator = true;
> -	rq_list_add_tail(&plug->mq_list, rq);
> +	rq_list_insert_sorted(&plug->mq_list, rq);
>  	plug->rq_count++;
>  }
>  


-- 
Damien Le Moal
Western Digital Research
