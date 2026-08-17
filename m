Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300C432316
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973010; cv=none; b=ozc1K7x0RO4aYPbtvf3Niswt5ceeErhdCF5Bg1ooHILBin+q2j4uEK53tRZwRdVowHu/OXZpUReeRJWbsjvRmdw1H7m/jkEzpThoYhGua180345Tnb04BG1GOQJI4BLf4FaIMoo14VcGSRYuapUPZGvatA+XhHRI8/0sxIQ4tvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973010; c=relaxed/simple;
	bh=0vB0+SXD1wPvYOuq5dSb7Mk++3xM1AI4VgtI5vwfN0E=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=eqx8Fxhi94+fEFNWFEHCkkokVtn1itDt+X1EVoeJUbpj5cIM4is5CSWsd7Tbywt13pn7fFbum0W4eHmZlfZFnMXxtAFDc0CHFvKbCsRMuyUaTSAOcjW0pO4CukBw9NFxRVEbfh8Hh5MdI7CtyJYU2esbaEhlaOdH8Hlefj5oMUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2MfUSrw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pChBE7ek; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2MfUSrw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pChBE7ek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786973005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MCS0C4w6z2feiQqFwp6dHkY/PSJTm+5CQIMULXMvb5Q=;
	b=K2MfUSrwlKO+GL1J/lvA9C8WoL6voBvCAE+FiMQfgqomt1R5v8k9xcfWTREz6HVgB6z+4F
	CFfPgHy4YFqULZfXOOBhWXMU3/N8dBd8ElTUVJMHWkOBBB/IbfLXoyKk/zzTBIiHhAOAAZ
	aiw+rmyGlo3CLwX6dSjLYEwFfCi8c8U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-pBgRwEKLPvez-nah5B4EtQ-1; Mon, 17 Aug 2026 09:23:17 -0400
X-MC-Unique: pBgRwEKLPvez-nah5B4EtQ-1
X-Mimecast-MFC-AGG-ID: pBgRwEKLPvez-nah5B4EtQ_1786972997
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495529a93f9so34098105e9.3
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786972997; x=1787577797; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MCS0C4w6z2feiQqFwp6dHkY/PSJTm+5CQIMULXMvb5Q=;
        b=pChBE7ekYtmN5v94DCizLzKLDUeVeLoDZvtkrOTeq0AJvQRxdPQq/Q4PT+5oJhSaX6
         2XosoudUVpoSDh4BKUjrN8oyzGgAPf47uTCc0rNhIJruvouSYMOj6ndo+lcFGynaNKye
         x2NaCFdiMWXcoqYKtnyEmp6qoqqJWwEKQz4Gmrbnt6WsoPyHdlP0VR9zhVf8DwN8TgON
         YuN2QZbsq/EeKW+3/mx78f3wmSmkvQgNYUlBJ5RklprJ57kQh3NPfuRqrI1lXvNjxGav
         gcKqFJh2w1OErViJFFfLWPZ8LpMTz2M5lbu8G0fifb1xhVT2zGchHXun2fXr3n6FYMMK
         iTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786972997; x=1787577797;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCS0C4w6z2feiQqFwp6dHkY/PSJTm+5CQIMULXMvb5Q=;
        b=DDsMFme4Xfh4a41Fz4eu+8fiIvxvRR+8LvdnA/qjaYZY4lJkgoQ89Wz/QpW8a+/dUt
         BiufLZbbhOrhpIQ2RWszYW89j1sgSfqcUtb3oTAe9VC4KkXu48qQk2YL2mP8j58VkpwU
         fSNmnTyaqkGnUHXvuK39eQCSP0x28HOhbBILkVhzIQUk474KH8D4L0exjQsjkOXQOAMI
         y1ZeXCSb+2GapXQHktvVUqPSaoRcW0NQs7nKcw5ZMwknf5hsf7KnCUHPh70HkCwh986Q
         6YUVitjGnH31+zsIiEv2kioV51eTh9Gv8Jdt5Nai/IczI1jSGa7A+bKoG+ONkcN/qO/J
         ocOg==
X-Forwarded-Encrypted: i=1; AHgh+RpRoWjPovzpjWomq28b9bensz/KUV+rhDPyFDzN2WbWZv61tdp2w/6ax9EeAJuJXzofaTk1HszrNibLSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/MMxS93dV4ZAiTCSvF8HZgMjLHNVX2LqTZeyLkf3T2KqppZBb
	zkflLiJxKAW/bDAYdzfCOBYK/Ey3lGXE51AusOMbfOeqaj1prZ0o1GIr14/PvmFPYwndTT/LUyc
	RElfyXBzEGgc+R6BplSavmVLexee388zEJp2AarYcmC9lTqI8IRA4w0Pn2XKb3WLvHy7DlOnC
X-Gm-Gg: AR+sD10oWfkim6x9rfhrQn7exkWFnjkIPZaChCFaEgyBgqb/9paLUz00xF8YePZLhIA
	TOPkXxlUNa76E0pqAGQrvqh7wqHfeWfE+JjPftR/0ZCdT9uFgXnZ3mCJXfgHsodN4A5ISJNtx9h
	YkfCCQiTml08AA0K56hMQfBXhOw7WkKh4W3JhgU1h8mk8axymHvnlVoiX8YbRNnLoP8UeMAWku3
	vODDszyrFn/B9WjY6nhciaB6f/MBM3nYC6ELuVWP8i3Y1IeXl2ZfzsI0+tf48P1pd39xM6sn5fE
	ALLdeJyyUfz3kTwQBo/XdgHmk9/ZfMHdgTfIuF68FWpSNW2RCKqNdoTPXbFdNteV+9zcEYcP+qf
	/O3AQ8WAl+aI0frHbozII6V3bObMtvy6Sqh9tM4R7+zE=
X-Received: by 2002:a05:600c:46d4:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-4998aff59d6mr293102305e9.14.1786972996491;
        Mon, 17 Aug 2026 06:23:16 -0700 (PDT)
X-Received: by 2002:a05:600c:46d4:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-4998aff59d6mr293101445e9.14.1786972995959;
        Mon, 17 Aug 2026 06:23:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d0876b8sm57303745e9.8.2026.08.17.06.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 06:23:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------8CAmikxCf33xtcNkEMDTdIzg"
Message-ID: <1805eed3-90ec-4f62-9d71-e3f898a464ad@redhat.com>
Date: Mon, 17 Aug 2026 15:23:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Auger <eauger@redhat.com>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
To: Keith Busch <kbusch@meta.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, axboe@kernel.dk
Cc: Keith Busch <kbusch@kernel.org>, Jeff Moyer <jmoyer@redhat.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
Content-Language: en-US
In-Reply-To: <20251014150456.2219261-2-kbusch@meta.com>

This is a multi-part message in MIME format.
--------------8CAmikxCf33xtcNkEMDTdIzg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Keith, Christoph,

On 10/14/25 5:04 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The blk-mq dma iterator has an optimization for requests that align to
> the device's iommu merge boundary. This boundary may be larger than the
> device's virtual boundary, but the code had been depending on that queue
> limit to know ahead of time if the request is guaranteed to align to
> that optimization.
> 
> Rather than rely on that queue limit, which many devices may not report,
> save the lowest set bit of any boundary gap between each segment in the
> bio while checking the segments. The request stores the value for
> merging and quickly checking per io if the request can use iova
> optimizations.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/bio.c               |  1 +
>  block/blk-map.c           |  3 +++
>  block/blk-merge.c         | 39 ++++++++++++++++++++++++++++++++++++---
>  block/blk-mq-dma.c        |  3 +--
>  block/blk-mq.c            |  6 ++++++
>  include/linux/bio.h       |  2 ++
>  include/linux/blk-mq.h    | 16 ++++++++++++++++
>  include/linux/blk_types.h | 12 ++++++++++++
>  8 files changed, 77 insertions(+), 5 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index b3a79285c278d..7b13bdf72de09 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -253,6 +253,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
>  	bio->bi_write_hint = 0;
>  	bio->bi_write_stream = 0;
>  	bio->bi_status = 0;
> +	bio->bi_bvec_gap_bit = 0;
>  	bio->bi_iter.bi_sector = 0;
>  	bio->bi_iter.bi_size = 0;
>  	bio->bi_iter.bi_idx = 0;
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 60faf036fb6e4..17a1dc2886786 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -459,6 +459,8 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
>  	if (rq->bio) {
>  		if (!ll_back_merge_fn(rq, bio, nr_segs))
>  			return -EINVAL;
> +		rq->phys_gap_bit = bio_seg_gap(rq->q, rq->biotail, bio,
> +					       rq->phys_gap_bit);
>  		rq->biotail->bi_next = bio;
>  		rq->biotail = bio;
>  		rq->__data_len += bio->bi_iter.bi_size;
> @@ -469,6 +471,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
>  	rq->nr_phys_segments = nr_segs;
>  	rq->bio = rq->biotail = bio;
>  	rq->__data_len = bio->bi_iter.bi_size;
> +	rq->phys_gap_bit = bio->bi_bvec_gap_bit;
>  	return 0;
>  }
>  EXPORT_SYMBOL(blk_rq_append_bio);
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 002c594798242..2a1da435462de 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -302,6 +302,12 @@ static unsigned int bio_split_alignment(struct bio *bio,
>  	return lim->logical_block_size;
>  }
>  
> +static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
> +					struct bio_vec *bv)
> +{
> +	return bv->bv_offset | (bvprv->bv_offset + bvprv->bv_len);
> +}
> +
>  /**
>   * bio_split_io_at - check if and where to split a bio
>   * @bio:  [in] bio to be split
> @@ -319,8 +325,8 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  		unsigned *segs, unsigned max_bytes, unsigned len_align_mask)
>  {
>  	struct bio_vec bv, bvprv, *bvprvp = NULL;
> +	unsigned nsegs = 0, bytes = 0, gaps = 0;
>  	struct bvec_iter iter;
> -	unsigned nsegs = 0, bytes = 0;
>  
>  	bio_for_each_bvec(bv, bio, iter) {
>  		if (bv.bv_offset & lim->dma_alignment ||
> @@ -331,8 +337,11 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  		 * If the queue doesn't support SG gaps and adding this
>  		 * offset would create a gap, disallow it.
>  		 */
> -		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
> -			goto split;
> +		if (bvprvp) {
> +			if (bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
> +				goto split;
> +			gaps |= bvec_seg_gap(bvprvp, &bv);
> +		}
>  
>  		if (nsegs < lim->max_segments &&
>  		    bytes + bv.bv_len <= max_bytes &&
> @@ -350,6 +359,7 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  	}
>  
>  	*segs = nsegs;
> +	bio->bi_bvec_gap_bit = ffs(gaps);
>  	return 0;
>  split:
>  	if (bio->bi_opf & REQ_ATOMIC)
> @@ -385,6 +395,7 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  	 * big IO can be trival, disable iopoll when split needed.
>  	 */
>  	bio_clear_polled(bio);
> +	bio->bi_bvec_gap_bit = ffs(gaps);
>  	return bytes >> SECTOR_SHIFT;
>  }
>  EXPORT_SYMBOL_GPL(bio_split_io_at);
> @@ -721,6 +732,21 @@ static bool blk_atomic_write_mergeable_rqs(struct request *rq,
>  	return (rq->cmd_flags & REQ_ATOMIC) == (next->cmd_flags & REQ_ATOMIC);
>  }
>  
> +u8 bio_seg_gap(struct request_queue *q, struct bio *prev, struct bio *next,
> +	       u8 gaps_bit)
> +{
> +	struct bio_vec pb, nb;
> +
> +	gaps_bit = min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
> +	gaps_bit = min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
> +
> +	bio_get_last_bvec(prev, &pb);
> +	bio_get_first_bvec(next, &nb);
> +	if (!biovec_phys_mergeable(q, &pb, &nb))
> +		gaps_bit = min_not_zero(gaps_bit, ffs(bvec_seg_gap(&pb, &nb)));
> +	return gaps_bit;
> +}
> +
>  /*
>   * For non-mq, this has to be called with the request spinlock acquired.
>   * For mq with scheduling, the appropriate queue wide lock should be held.
> @@ -785,6 +811,9 @@ static struct request *attempt_merge(struct request_queue *q,
>  	if (next->start_time_ns < req->start_time_ns)
>  		req->start_time_ns = next->start_time_ns;
>  
> +	req->phys_gap_bit = bio_seg_gap(req->q, req->biotail, next->bio,
> +					min_not_zero(next->phys_gap_bit,
> +						     req->phys_gap_bit));
>  	req->biotail->bi_next = next->bio;
>  	req->biotail = next->biotail;
>  
> @@ -908,6 +937,8 @@ enum bio_merge_status bio_attempt_back_merge(struct request *req,
>  	if (req->rq_flags & RQF_ZONE_WRITE_PLUGGING)
>  		blk_zone_write_plug_bio_merged(bio);
>  
> +	req->phys_gap_bit = bio_seg_gap(req->q, req->biotail, bio,
> +					req->phys_gap_bit);
>  	req->biotail->bi_next = bio;
>  	req->biotail = bio;
>  	req->__data_len += bio->bi_iter.bi_size;
> @@ -942,6 +973,8 @@ static enum bio_merge_status bio_attempt_front_merge(struct request *req,
>  
>  	blk_update_mixed_merge(req, bio, true);
>  
> +	req->phys_gap_bit = bio_seg_gap(req->q, bio, req->bio,
> +					req->phys_gap_bit);
>  	bio->bi_next = req->bio;
>  	req->bio = bio;
>  
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index 449950029872a..94d3461b5bc8e 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -79,8 +79,7 @@ static bool blk_map_iter_next(struct request *req, struct blk_map_iter *iter,
>  static inline bool blk_can_dma_map_iova(struct request *req,
>  		struct device *dma_dev)
>  {
> -	return !((queue_virt_boundary(req->q) + 1) &
> -		dma_get_merge_boundary(dma_dev));
> +	return !(req_phys_gap_mask(req) & dma_get_merge_boundary(dma_dev));

I observe a regression on RHEL due to that change in
blk_can_dma_map_iova() with a 64kB host. This also occurs with upstream
(7.2-rc7).

For an NVME device blk_can_dma_map_iova() now returns trues while it did
not before. And it seems it shouldn't because it then causes some errors
on the dma_iova_link() path due to unaligned iova:

[ 4486.655564] iommu: unaligned: iova 0x14c34000 pa 0x000010764d790000
size 0x1d0000 min_pagesz 0x10000

It occurs when launching a 4kB guest with virtio-blk.

I traced:
nvme 0015:01:00.0: req_phys_gap_mask=0xffffffffffff0000,
queue_virt_boundary+1=0x1, get_merge_boundary=0xffff

See additional traces attached.

Does that ring a bell for you?

Thank you in advance

Best Regards

Eric


>  }
>  
>  static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 09f5794141615..c12e5ee315fce 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -376,6 +376,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
>  	INIT_LIST_HEAD(&rq->queuelist);
>  	rq->q = q;
>  	rq->__sector = (sector_t) -1;
> +	rq->phys_gap_bit = 0;
>  	INIT_HLIST_NODE(&rq->hash);
>  	RB_CLEAR_NODE(&rq->rb_node);
>  	rq->tag = BLK_MQ_NO_TAG;
> @@ -668,6 +669,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
>  			goto out_queue_exit;
>  	}
>  	rq->__data_len = 0;
> +	rq->phys_gap_bit = 0;
>  	rq->__sector = (sector_t) -1;
>  	rq->bio = rq->biotail = NULL;
>  	return rq;
> @@ -748,6 +750,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
>  	blk_mq_rq_time_init(rq, alloc_time_ns);
>  	rq->__data_len = 0;
> +	rq->phys_gap_bit = 0;
>  	rq->__sector = (sector_t) -1;
>  	rq->bio = rq->biotail = NULL;
>  	return rq;
> @@ -2674,6 +2677,8 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
>  	rq->bio = rq->biotail = bio;
>  	rq->__sector = bio->bi_iter.bi_sector;
>  	rq->__data_len = bio->bi_iter.bi_size;
> +	rq->phys_gap_bit = bio->bi_bvec_gap_bit;
> +
>  	rq->nr_phys_segments = nr_segs;
>  	if (bio_integrity(bio))
>  		rq->nr_integrity_segments = blk_rq_count_integrity_sg(rq->q,
> @@ -3380,6 +3385,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>  	}
>  	rq->nr_phys_segments = rq_src->nr_phys_segments;
>  	rq->nr_integrity_segments = rq_src->nr_integrity_segments;
> +	rq->phys_gap_bit = rq_src->phys_gap_bit;
>  
>  	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
>  		goto free_and_out;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 16c1c85613b76..ad2d57908c1c0 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -324,6 +324,8 @@ extern struct bio *bio_split(struct bio *bio, int sectors,
>  			     gfp_t gfp, struct bio_set *bs);
>  int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  		unsigned *segs, unsigned max_bytes, unsigned len_align);
> +u8 bio_seg_gap(struct request_queue *q, struct bio *prev, struct bio *next,
> +		u8 gaps_bit);
>  
>  /**
>   * bio_next_split - get next @sectors from a bio, splitting if necessary
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index b25d12545f46d..ddda00f07fae4 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -152,6 +152,14 @@ struct request {
>  	unsigned short nr_phys_segments;
>  	unsigned short nr_integrity_segments;
>  
> +	/*
> +	 * The lowest set bit for address gaps between physical segments. This
> +	 * provides information necessary for dma optimization opprotunities,
> +	 * like for testing if the segments can be coalesced against the
> +	 * device's iommu granule.
> +	 */
> +	unsigned char phys_gap_bit;
> +
>  #ifdef CONFIG_BLK_INLINE_ENCRYPTION
>  	struct bio_crypt_ctx *crypt_ctx;
>  	struct blk_crypto_keyslot *crypt_keyslot;
> @@ -208,6 +216,14 @@ struct request {
>  	void *end_io_data;
>  };
>  
> +/*
> + * Returns a mask with all bits starting at req->phys_gap_bit set to 1.
> + */
> +static inline unsigned long req_phys_gap_mask(const struct request *req)
> +{
> +	return ~(((1 << req->phys_gap_bit) >> 1) - 1);
> +}
> +
>  static inline enum req_op req_op(const struct request *req)
>  {
>  	return req->cmd_flags & REQ_OP_MASK;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 8e8d1cc8b06c4..53501ebb0623e 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -218,6 +218,18 @@ struct bio {
>  	enum rw_hint		bi_write_hint;
>  	u8			bi_write_stream;
>  	blk_status_t		bi_status;
> +
> +	/*
> +	 * The bvec gap bit indicates the lowest set bit in any address offset
> +	 * between all bi_io_vecs. This field is initialized only after the bio
> +	 * is split to the hardware limits (see bio_split_io_at()). The value
> +	 * may be used to consider DMA optimization when performing that
> +	 * mapping. The value is compared to a power of two mask where the
> +	 * result depends on any bit set within the mask, so saving the lowest
> +	 * bit is sufficient to know if any segment gap collides with the mask.
> +	 */
> +	u8			bi_bvec_gap_bit;
> +
>  	atomic_t		__bi_remaining;
>  
>  	struct bvec_iter	bi_iter;

--------------8CAmikxCf33xtcNkEMDTdIzg
Content-Type: text/plain; charset=UTF-8; name="IOerrors.txt"
Content-Disposition: attachment; filename="IOerrors.txt"
Content-Transfer-Encoding: base64

WyA0NDgzLjU4ODg0M10gVGFpbnRlZDogW1ddPVdBUk4KWyA0NDgzLjU5MTg3Ml0gSGFyZHdh
cmUgbmFtZTogRGVsbCBJbmMuIERlbGwgU2VydmVyIDk3MTJhL0RlbGwgOTcxMmEsIEJJT1Mg
Mi4xNiAwNi8xOS8yMDI1ClsgNDQ4My42MDAwNTddIHBzdGF0ZTogMjM0MDAwMDkgKG56Q3Yg
ZGFpZiArUEFOIC1VQU8gK1RDTyArRElUIC1TU0JTIEJUWVBFPS0tKQpbIDQ0ODMuNjA3MTc1
XSBwYyA6IGRtYV9pb3ZhX2xpbmsrMHgxYTAvMHgyMjAKWyA0NDgzLjYxMTM1OV0gbHIgOiBk
bWFfaW92YV9saW5rKzB4NDgvMHgyMjAKWyA0NDgzLjYxNTQ1NF0gc3AgOiBmZmZmODAwMTkw
MWVmNDYwClsgNDQ4My42MTg4MzddIHgyOTogZmZmZjgwMDE5MDFlZjQ2MCB4Mjg6IDAwMDAw
MDAwMDAwMDAwMDAgeDI3OiBmZmZmMTAwMDQ4YTIyYjAwClsgNDQ4My42MjYxMzNdIHgyNjog
ZmZmZjEwMDRkNjYyODE3OCB4MjU6IDAwMDAwMDAwMDAwMDAwMDAgeDI0OiAwMDAwMDAwMDAw
MDAwMDAyClsgNDQ4My42MzM0MjldIHgyMzogZmZmZjEwMDAwZDUxZTBkMCB4MjI6IDAwMDAw
MDAwMDAwMDQwMDAgeDIxOiAwMDAwMTA3ODI2Mzg0MDAwClsgNDQ4My42NDA3MjVdIHgyMDog
MDAwMDAwMDAwMDAwNDAwMCB4MTk6IDAwMDAwMDAwMDAwMDQwMDAgeDE4OiAwMDAwMDAwMDAw
MDAwMDAwClsgNDQ4My42NDgwMjFdIHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAw
MDAwMDAwMDAwMDYgeDE1OiAwMDAwMTA3ODI2Mzg4MDAwClsgNDQ4My42NTUzMTZdIHgxNDog
MDAwMDAwMDAwMDAwNDAwMCB4MTM6IDAwMDAwMDAwMDAwMDQwMDAgeDEyOiAwMDAwMDAwMGQ5
YzdjMDAwClsgNDQ4My42NjI2MTJdIHgxMTogMDAwMDAwMDAwMDAwMDAwMiB4MTA6IDAwMDAw
MDAwMDAxZjgwMDAgeDkgOiBmZmZmZDQ2OTc0Zjc5MWUwClsgNDQ4My42Njk5MDhdIHg4IDog
MDAwMDEwNzgyNjM4NDAwMCB4NyA6IDAwMDAwMDAwMDAwMGZmZmYgeDYgOiAwMDAwMDAwMDAw
MDAwMDAwClsgNDQ4My42NzcyMDRdIHg1IDogMDAwMDAwMDAwMDAwMDAwMiB4NCA6IDAwMDAw
MDAwMDAwMDQwMDAgeDMgOiAwMDAwMDAwMDAwMDA0MDAwClsgNDQ4My42ODQ1MDBdIHgyIDog
MDAwMDEwNzgyNjM4NDAwMCB4MSA6IGZmZmYxMDA0ZDY2MjgxNzggeDAgOiBmZmZmMTAwMDQ4
YTJlZDIwClsgNDQ4My42OTE3OThdIENhbGwgdHJhY2U6ClsgNDQ4My42OTg0ODBdICBibGtf
ZG1hX21hcF9pdGVyX3N0YXJ0KzB4MWUwLzB4MmM4ClsgNDQ4My43MDMxMTZdICBibGtfcnFf
ZG1hX21hcF9pdGVyX3N0YXJ0KzB4NDgvMHhjMApbIDQ0ODMuNzA3ODM0XSAgbnZtZV9tYXBf
ZGF0YSsweDk0LzB4MjE4IFtudm1lXQpbIDQ0ODMuNzEyMjA2XSAgbnZtZV9wcmVwX3JxLnBh
cnQuMCsweDM0LzB4MWQwIFtudm1lXQpbIDQ0ODMuNzE3MTAxXSAgbnZtZV9xdWV1ZV9ycXMr
MHgxODQvMHgyYzggW252bWVdClsgNDQ4My43MjE2NDFdICBibGtfbXFfZGlzcGF0Y2hfcXVl
dWVfcmVxdWVzdHMrMHgxNzAvMHgxYTAKWyA0NDgzLjcyNjk4OF0gIGJsa19tcV9mbHVzaF9w
bHVnX2xpc3QrMHhhNC8weDFhMApbIDQ0ODMuNzMxNTMwXSAgYmxrX2FkZF9ycV90b19wbHVn
KzB4ZWMvMHgxZTAKWyA0NDgzLjczNTcxNV0gIGJsa19tcV9zdWJtaXRfYmlvKzB4NThjLzB4
ODAwClsgNDQ4My43Mzk5MDBdICBfX3N1Ym1pdF9iaW8rMHg4Yy8weDIzOApbIDQ0ODMuNzQz
NTU2XSAgX19zdWJtaXRfYmlvX25vYWNjdCsweDY4LzB4MWQ4ClsgNDQ4My43NDc4MjldICBz
dWJtaXRfYmlvX25vYWNjdF9ub2NoZWNrKzB4MWE0LzB4MWUwClsgNDQ4My43NTI3MjZdICBz
dWJtaXRfYmlvX25vYWNjdCsweDEwYy8weDQyOApbIDQ0ODMuNzU2OTExXSAgc3VibWl0X2Jp
bysweGFjLzB4MjM4ClsgNDQ4My43NjAzODNdICBpb21hcF9kaW9fc3VibWl0X2JpbysweDk4
LzB4ZDAKWyA0NDgzLjc2NDY2Nl0gIGlvbWFwX2Rpb19iaW9faXRlcisweDM0OC8weDUxOApb
IDQ0ODMuNzY4OTQwXSAgaW9tYXBfZGlvX2l0ZXIrMHhkMC8weDExOApbIDQ0ODMuNzcyNzY5
XSAgX19pb21hcF9kaW9fcncrMHgxN2MvMHg1YzgKWyA0NDgzLjc3NjY4OF0gIGlvbWFwX2Rp
b19ydysweDE4LzB4NTgKWyA0NDgzLjc4MDI1MV0gIHhmc19maWxlX2Rpb19yZWFkKzB4MTA0
LzB4MTY4IFt4ZnNdClsgNDQ4My43ODUwNDVdICB4ZnNfZmlsZV9yZWFkX2l0ZXIrMHhlYy8w
eDEwOCBbeGZzXQpbIDQ0ODMuNzg5ODA3XSAgZG9faXRlcl9yZWFkdl93cml0ZXYrMHgxYjAv
MHgyMDAKWyA0NDgzLjc5NDI2Ml0gIHZmc19yZWFkdisweDE5MC8weDI5MApbIDQ0ODMuNzk3
NzM1XSAgX19hcm02NF9zeXNfcHJlYWR2KzB4ZTAvMHgxMjgKWyA0NDgzLjgwMTkyMl0gIGlu
dm9rZV9zeXNjYWxsLmNvbnN0cHJvcC4wKzB4NzQvMHhkMApbIDQ0ODMuODA2NzMzXSAgZG9f
ZWwwX3N2YysweGI4LzB4ZDAKWyA0NDgzLjgxMDExN10gIGVsMF9zdmMrMHg0NC8weDFiOApb
IDQ0ODMuODEzMzI5XSAgZWwwdF82NF9zeW5jX2hhbmRsZXIrMHhhMC8weGYwClsgNDQ4My44
MTc2MDNdICBlbDB0XzY0X3N5bmMrMHgxYWMvMHgxYjAKWyA0NDgzLjgyMTM0Nl0gLS0tWyBl
bmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tClsgNDQ4My44MjYxMTBdIEkvTyBlcnJv
ciwgZGV2IG52bWUxbjEsIHNlY3RvciA3NjQ0NzgwMCBvcCAweDA6KFJFQUQpIGZsYWdzIDB4
YzgwMCBwaHlzX3NlZyAyOCBwcmlvIGNsYXNzIDIKWyA0NDg0LjI0NzczMF0gSS9PIGVycm9y
LCBkZXYgbnZtZTFuMSwgc2VjdG9yIDc5MDg1MTkyIG9wIDB4MDooUkVBRCkgZmxhZ3MgMHhj
ODAwIHBoeXNfc2VnIDMxIHByaW8gY2xhc3MgMgpbIDQ0ODQuMjY5NzM1XSBJL08gZXJyb3Is
IGRldiBudm1lMW4xLCBzZWN0b3IgNzc0MDQwNDggb3AgMHgwOihSRUFEKSBmbGFncyAweGM4
MDAgcGh5c19zZWcgMTggcHJpbyBjbGFzcyAyClsgNDQ4NC45Njk3MDddIEkvTyBlcnJvciwg
ZGV2IG52bWUxbjEsIHNlY3RvciA3NjQ2NTg2NCBvcCAweDA6KFJFQUQpIGZsYWdzIDB4Yzgw
MCBwaHlzX3NlZyAzMSBwcmlvIGNsYXNzIDIKWyA0NDg1LjA0MDMyN10gSS9PIGVycm9yLCBk
ZXYgbnZtZTFuMSwgc2VjdG9yIDgyMzM5MDQ4IG9wIDB4MDooUkVBRCkgZmxhZ3MgMHhjODAw
IHBoeXNfc2VnIDIyIHByaW8gY2xhc3MgMgpbIDQ0ODUuNjA2Mzg1XSBJL08gZXJyb3IsIGRl
diBudm1lMW4xLCBzZWN0b3IgODY1MjkyOTYgb3AgMHgwOihSRUFEKSBmbGFncyAweGM4MDAg
cGh5c19zZWcgNCBwcmlvIGNsYXNzIDIKWyA0NDg2LjU2NDQ3Ml0gSS9PIGVycm9yLCBkZXYg
bnZtZTFuMSwgc2VjdG9yIDgwMzg4MzkyIG9wIDB4MDooUkVBRCkgZmxhZ3MgMHhjODAwIHBo
eXNfc2VnIDQgcHJpbyBjbGFzcyAyClsgNDQ4Ni42NTU1NjRdIGlvbW11OiB1bmFsaWduZWQ6
IGlvdmEgMHgxNGMzNDAwMCBwYSAweDAwMDAxMDc2NGQ3OTAwMDAgc2l6ZSAweDFkMDAwMCBt
aW5fcGFnZXN6IDB4MTAwMDAKWyA0NDg2LjY2NDkxNV0gaW9tbXU6IHVuYWxpZ25lZDogaW92
YSAweDE0ODM0MDAwIHBhIDB4MDAwMDEwNzY0ZDc5MDAwMCBzaXplIDB4MWQwMDAwIG1pbl9w
YWdlc3ogMHgxMDAwMApbIDQ0ODYuNjc0MjYzXSBpbnZhbGlkIGVycm9yLCBkZXYgbnZtZTFu
MSwgc2VjdG9yIDM3MTYwNDMzODQgb3AgMHgwOihSRUFEKSBmbGFncyAweGM4MDAgcGh5c19z
ZWcgMiBwcmlvIGNsYXNzIDIKWyA0NDg3LjMwNDI3Ml0gSS9PIGVycm9yLCBkZXYgbnZtZTFu
MSwgc2VjdG9yIDg2MTAxNjE2IG9wIDB4MDooUkVBRCkgZmxhZ3MgMHhjODAwIHBoeXNfc2Vn
IDMgcHJpbyBjbGFzcyAyClsgNDQ4Ny4zMDU4OTRdIEkvTyBlcnJvciwgZGV2IG52bWUxbjEs
IHNlY3RvciA4NjEwOTgwOCBvcCAweDA6KFJFQUQpIGZsYWdzIDB4YzgwMCBwaHlzX3NlZyAz
IHByaW8gY2xhc3MgMgoK

--------------8CAmikxCf33xtcNkEMDTdIzg--

