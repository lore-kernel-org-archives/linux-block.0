Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5203246F7
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374808; cv=none; b=EDRYc8lmVCx/N4qH/Uy7EAvQFr35zn82lfBn8S0prEm4Ka6LrrOSbwdnRVfI3yEYiFs5i4lctlgsoz0ZS677EX0CRkoOg5WCpdLAVXaGNcov6xwgDIU1Gce67lRTYsUO6jnKp7U4zxVSV11BKuhncSUpILweXxzlU9lNGAa2LBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374808; c=relaxed/simple;
	bh=bwibJvJLkyc6FQip7uiNg567UrLP3BL61zUuGv4aF0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4nY+oqnC30qxeoD9RPYAB9+eoV+TGBKgaons9ebGAQZ8DE5TgKZ2OeO5ctW11gR9WZfcv3Hq47TNl2mfCH9kp2bHewdsMPQNOtWXjxcczCSGTrW55uyRzbQVQQo0VhGuRGFfvGZ//bzBZEDEkYefuYnbCSRi5BeI4GMaGEe/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPl2iTZR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPl2iTZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763374805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jWSFS1b8eCV2LAK4lG/dUgCUlWq07WRAkz4T4C61+JM=;
	b=bPl2iTZRJBG4GKDKzeZ/mFn4KvYICD+RW6O8ZqRIb/LR6D0LnhHCF3VvcrkDskWHtdA2m9
	in98o1wFiUwOEfzol+L0QAKNYusBbaAtQbZNnPZdw0HOW0kDabbRTj9cZ8o4+qGqZ2U5kc
	yfyjhC37ISkZSTIt9oF0iIBzds6ZZHk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-fhPPRLYKNc6d9pzkQZVHnA-1; Mon,
 17 Nov 2025 05:20:01 -0500
X-MC-Unique: fhPPRLYKNc6d9pzkQZVHnA-1
X-Mimecast-MFC-AGG-ID: fhPPRLYKNc6d9pzkQZVHnA_1763374800
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3D771956095;
	Mon, 17 Nov 2025 10:19:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CC16180049F;
	Mon, 17 Nov 2025 10:19:55 +0000 (UTC)
Date: Mon, 17 Nov 2025 18:19:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Xue He <xue01.he@samsung.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai@fnnas.com
Subject: Re: [PATCH v6] block: plug attempts to batch allocate tags multiple
 times
Message-ID: <aRr2x89ShJa08jNk@fedora>
References: <CGME20251117085321epcas5p3de0647f01a818db024bea32870f223f4@epcas5p3.samsung.com>
 <20251117084845.254680-1-xue01.he@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117084845.254680-1-xue01.he@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Nov 17, 2025 at 08:48:45AM +0000, Xue He wrote:
> This patch aims to enable batch allocation of sufficient tags after
> batch IO submission with plug mechanism, thereby avoiding the need for
> frequent individual requests when the initial allocation is
> insufficient.
> -----------------------------------------------------------
> HW:
> 16 CPUs/16 poll queues
> Disk: Samsung PM9A3 Gen4 3.84T
> 
> CMD:
> [global]
> ioengine=io_uring
> group_reporting=1
> time_based=1
> runtime=1m
> refill_buffers=1
> norandommap=1
> randrepeat=0
> fixedbufs=1
> registerfiles=1
> rw=randread
> iodepth=128
> iodepth_batch_submit=32
> iodepth_batch_complete_min=32
> iodepth_batch_complete_max=128
> iodepth_low=32
> bs=4k
> numjobs=1
> direct=1
> hipri=1
> 
> [job1]
> filename=/dev/nvme0n1
> name=batch_test
> ------------------------------------------------------------
> Perf:
> base code: __blk_mq_alloc_requests() 1.47%
> patch: __blk_mq_alloc_requests() 0.78%
> ------------------------------------------------------------
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
> changes since v5:
> - Add workload with perf
> - Modify over-counting bug
> 
> Signed-off-by: hexue <xue01.he@samsung.com>
> ---
>  block/blk-mq.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d626d32f6e57..9e6fca1b5fb7 100644
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

You may keep the original batch update on `data->nr_tags` by passing
`data->nr_tags - nr`.

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

data->nr_tags-- can be killed.

> +			nr++;
> +		}
> +	} while (data->nr_tags);

Replace the above check with `data->nr_tags > nr`

>  
> -	tags = blk_mq_tags_from_data(data);
> -	for (i = 0; tag_mask; i++) {
> -		if (!(tag_mask & (1UL << i)))
> -			continue;
> -		tag = tag_offset + i;
> -		prefetch(tags->static_rqs[tag]);
> -		tag_mask &= ~(1UL << i);
> -		rq = blk_mq_rq_ctx_init(data, tags, tag);
> -		rq_list_add_head(data->cached_rqs, rq);
> -		nr++;
> -	}
> -	if (!(data->rq_flags & RQF_SCHED_TAGS))
> -		blk_mq_add_active_requests(data->hctx, nr);
>  	/* caller already holds a reference, add for remainder */
>  	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
> -	data->nr_tags -= nr;

The above line needs to keep.

> +	if (!(data->rq_flags & RQF_SCHED_TAGS))
> +		blk_mq_add_active_requests(data->hctx, nr);

The above two lines can be kept in original position, then the change
outside loop can be avoided.

With above update, feel free to add:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

