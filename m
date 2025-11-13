Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB152E7658
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028915; cv=none; b=TByc1G0gNtDldR5FjZ7iAeo4/t+nzq7UFQzPKOUy/SuebmVSrWyFROrbBL50HEEJEUYXTQiP0+ifqkQrnZsL2tpBEnJVgm6LrXAa+mdkWR9p9g0u+WeTCpddWygHynmZlR4Myi0NjBhUn/K9k7hp9V/yZY3wLJTwquGWCR+EgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028915; c=relaxed/simple;
	bh=ShMy3nLafbdyxOStUvqd7oI2N/f66M1pOhgVh2OmtYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzighmAZJ6Q4IMUy2n5sNNa1/XJMY/eCXioW4gUyI8PpRxiOhA86NkxHSCTI2vR4sJSYyg4nByHJhSCWKzbQzqwzprqOaA2caPDLqm5GxpvSTt1Ogy6Py36drKBZBqvASNHI+XqQ9oVqPkc+pB1M+4lMHVuSPcerDXfGa6bTQX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1JOScuJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1JOScuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763028912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HD4mugaHkDDtHPnrViY3D59+rWWIvzs7KEepW4USoek=;
	b=g1JOScuJym43Q7589J62dvpcqBxLzzkgFxvAGR0zrJitLSFem0xixfjVkCar7g7RUgaj5v
	4PGinGNpNBnFs51b33iUxAcNl7SKtElKoMVw4bF4eJ04YWntMpseadVcGTFGNK9C8cz1FI
	R8ZlFuH6dtQfooyjv2MyuZqEQkZPHR8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-T0l06bT9OlKxDc6tf60pPQ-1; Thu,
 13 Nov 2025 05:15:09 -0500
X-MC-Unique: T0l06bT9OlKxDc6tf60pPQ-1
X-Mimecast-MFC-AGG-ID: T0l06bT9OlKxDc6tf60pPQ_1763028908
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C9B118002D0;
	Thu, 13 Nov 2025 10:15:07 +0000 (UTC)
Received: from fedora (unknown [10.72.116.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27143300018D;
	Thu, 13 Nov 2025 10:15:01 +0000 (UTC)
Date: Thu, 13 Nov 2025 18:14:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Xue He <xue01.he@samsung.com>
Cc: axboe@kernel.dk, yukuai@fnnas.com, akpm@linux-foundation.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 RESEND] block: plug attempts to batch allocate tags
 multiple times
Message-ID: <aRWvoOmo3_JTelPq@fedora>
References: <CGME20251113080643epcas5p154d9edfbf0f99e0d4c08408ad6cf68f4@epcas5p1.samsung.com>
 <20251113080202.193508-1-xue01.he@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113080202.193508-1-xue01.he@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Nov 13, 2025 at 08:02:02AM +0000, Xue He wrote:
> This patch aims to enable batch allocation of sufficient tags after
> batch IO submission with plug mechanism, thereby avoiding the need for
> frequent individual requests when the initial allocation is
> insufficient.
> 
> ------------------------------------------------------------
> Perf:
> base code: __blk_mq_alloc_requests() 1.31%
> patch: __blk_mq_alloc_requests() 0.7%
> ------------------------------------------------------------

Can you include the workload with perf together?

> 
> ---
> changes since v1:
> - Modify multiple batch registrations into a single loop to achieve
>   the batch quantity
> 
> changes since v2:
> - Modify the call location of remainder handling
> - Refactoring sbitmap cleanup time
> 
> changes since v3:
> - Add handle operation in loop
> - Add helper sbitmap_find_bits_in_word
> 
> changes since v4:
> - Split blk-mq.c changes from sbitmap
> 
> Signed-off-by: hexue <xue01.he@samsung.com>
> ---
>  block/blk-mq.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 09f579414161..64cd0a3c7cbf 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -467,26 +467,31 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
>  	unsigned long tag_mask;
>  	int i, nr = 0;
>  
> -	tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
> -	if (unlikely(!tag_mask))
> -		return NULL;
> +	do {
> +		tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
> +		if (unlikely(!tag_mask)) {
> +			if (nr == 0)
> +				return NULL;
> +			break;
> +		}
> +		tags = blk_mq_tags_from_data(data);
> +		for (i = 0; tag_mask; i++) {
> +			if (!(tag_mask & (1UL << i)))
> +				continue;
> +			tag = tag_offset + i;
> +			prefetch(tags->static_rqs[tag]);
> +			tag_mask &= ~(1UL << i);
> +			rq = blk_mq_rq_ctx_init(data, tags, tag);
> +			rq_list_add_head(data->cached_rqs, rq);
> +			data->nr_tags--;
> +			nr++;
> +		}
> +		if (!(data->rq_flags & RQF_SCHED_TAGS))
> +			blk_mq_add_active_requests(data->hctx, nr);

Here not only less-efficient, but also a over-counting bug, please
move the above two lines after `percpu_ref_get_many`.


Thanks, 
Ming

