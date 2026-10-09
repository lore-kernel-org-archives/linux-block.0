Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EF14DAF86
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554681; cv=none; b=q+YPTkwjI0BBzw2ljTBJHjdqFCu8DRFIGte2g/QJWkvmZjO9GksIk4gMHsWmEIStNp1ZKVWNlrxNLubL4CJXthA+DlOb6jZ+HUrUkHDztq8Q+knXgJhVoLDpfUc4O7/mj1eISKE89l0Xm91nTZdLPBLj0IF04hbVp+TNoKiuf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554681; c=relaxed/simple;
	bh=h7wNMyOFv7Xa3a/iiMwRypUFO+XdExoZNxOe5yaRTvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGZKSpGhEhArBAxARTLxeXImvKppPS6M0kEvsAS2FVhE9adKupU9LOlQLgIDYs6OdhEjC54+yzRV5vrrwOB34CS8NTrOwh5POqx0ORBRElTkBYAzCvQ4xPN3iEJMAygyLMr6UU8DeQnBEhoh5Ye9EO8qOIQyUNef0jklyNNw0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGPeZv6+; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGPeZv6+"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b056d58f2aso36028157b3.2
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791554679; x=1792159479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m2FCq9qOxNQX60l+rV0lKU7LWK8KnWq0TVWiX2tDzHc=;
        b=AGPeZv6+jMayyQ8M8CrRtcPd+5PuKwsrpinHPysejIScD0JvLyKT5dNWPDc9Q5qydC
         08u9gFVsUHnXrxLFPm8gXMyO8cuqRDD6g8j/EPvGD7FB43b4xQSWDj8jNZ8oaXPbLfdE
         ru8BKA6BBCSG8kJwcw/xe2dMZVPyQVEZX6bcSJlYeUDuy0LGtJrAuN9iQZ8y3ujn8bPS
         Dx0k35fcP2Zqh6bt+cFHpWhlAji1ah8hTCLBCu6+MTsLrcoh788BnEizKWk1yzhUZmMD
         UzQzgp5b4A4ISkFkwd09WVjz+ycXCRbyX0tKHehUw08vKFKT0aKnzxfF3R7N+rp3oYyc
         Ryfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554679; x=1792159479;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2FCq9qOxNQX60l+rV0lKU7LWK8KnWq0TVWiX2tDzHc=;
        b=hR4Jl/6j8M7sLMxtRBL7fYk4o7nnhH0GbLV7eLAIHXwabKhVDXkYLHwAa66e20yneZ
         qSVDaGmdDmOhpTOSyzwgMaXi304WO9gzQf1g2o6ClVFgfA/lACZXQ9XbII8ZkzuIZ1RX
         hpxP9ELig5tZbnN24NSIxheqzyBDu21AZq2Sq1Q2NLQNr9gn9S/CHPr2Tf6/ud4t6Ptp
         oq1nsXdXD25vJJbirIIm7wJv2dFVhRu6Mngkl+/JsHWcEJoL8p0LJbtOdQeal2GtDXp8
         CE3f13hHGUWPIEoQUubObhbN93cN0ZOEBsPGnta19QJ+c80MrT+haXvJ9t4KxsA2aKaX
         s/5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxvW8GHktxA48GYJSkcG2WlYJmfeBnLHcbOxxDO41M+4uGn6u7tZ0NiOCD/+I7bSUaCHEuw4hWcarKSRg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJc4xoYt0DFWsrhUEPKv5tiwZ2Id43q2TEc3k+iJYSQxEy0O3WI
	w7REp9mnuMNDzRaAjmvO26JgGFAdlLUsYRH6J3LmaPfoK+Q/ypD5/s0Le6wf2nmZ
X-Gm-Gg: AYBFou04o7yA1hvf2/vQyGYPZDCUROWXyEYg4YZfgQE3+WI/+FZDnEr/XG6BI8HpJm1
	yKHfUJVBd0Y7CywWhezylkmkYX5VpoV/M5XPjR3euI5fkSAiO9APcrua4lSLraH3SfouGyKSS8C
	hcPfxfiTqz/ZmoqUdUKOOpBYdRHMIAVdu4Q2up44qm2mUbE/8fagYnMkT7On2BAuON4T6LYangm
	Ck//EYdvWEfphPZqJgsjFlhFeRou9lF8EGo9UbXYqrQC917AUyN4v4bgEHCvuyy8iNXKiGuMN+j
	WVqSA04yLKUCdFkkV1yc0M8xkYzu/3UDowvjSctYA+AfERMUlICI/gPAT/CNZwwi/fpqEUXKsW2
	agwdAvFo7ye7G2sRKz6hBBY5gn2P9rl2kALZeyvxpV+Jg+Oq5kbM74FnK1xmzTvRSa1qkWLTwb3
	tHsCBFu+yIMsPIhylvr/cBssC29faBrbd5wuG61A40io6wxVqmDOiVCVJhRYdqzPsaX08Rs09Oq
	tq39vB8DtxlzpOQchNc9j4RkqH9PK8vteG2Loylh37nMvxlFRPL3g9Sz1ugr9Lk6u3fui9R8tIx
	jSo=
X-Received: by 2002:a05:690c:4382:b0:8a5:af04:fb8d with SMTP id 00721157ae682-8b07ee02915mr4232977b3.59.1791554678963;
        Fri, 09 Oct 2026 07:04:38 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1e8682sm7013017b3.19.2026.10.09.07.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:04:38 -0700 (PDT)
Date: Fri, 9 Oct 2026 09:04:29 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	csander@purestorage.com, jholzman@nvidia.com, omril@nvidia.com
Subject: Re: [PATCH v2 1/2] ublk: honor rq_affinity on request completion
Message-ID: <asj0bWwUSiSFh4hT@fedora-laptop>
References: <20261006190348.85094-1-yoav@nvidia.com>
 <20261006190348.85094-2-yoav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006190348.85094-2-yoav@nvidia.com>

On Tue, Oct 06, 2026 at 10:03:47PM +0300, Yoav Cohen wrote:
> ublk ends successfully completed requests inline on the server thread
> that issued UBLK_IO_COMMIT_AND_FETCH_REQ, so rq_affinity never
> redirects completion back to the submitting CPU, unlike NVMe, SCSI,
> virtio-blk, loop, nbd and rnbd.
> 
> Route completion through blk_mq_complete_request_remote(), with a new
> ->complete() callback, ublk_end_rq(). This covers every completion
> outcome -- reads, writes, flush/discard, errors, and the zero-copy/
> user-copy/auto-buf-reg/shmem-zc paths that skip the copy-back step --
> not just the classic-copy-mode successful-read case, since
> ublk_end_rq() re-derives which of those __ublk_complete_rq() took from
> @req and @io state rather than assuming one.
> 
> Gate it behind a new UBLK_F_SUPPORT_RQ_AFFINITY flag that a server
> must request at ADD_DEV time; servers that don't ask for it keep
> today's always-local completion unchanged. Add ublk_support_rq_affinity()
> alongside the existing ublk_support_*() helpers, and check it before
> calling blk_mq_complete_request_remote() at both call sites.
> 
> Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> ---
>  drivers/block/ublk_drv.c      | 98 +++++++++++++++++++++++++++--------
>  include/uapi/linux/ublk_cmd.h |  8 +++
>  2 files changed, 84 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 66eb55e7162e..b94293296b73 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -90,7 +90,8 @@
>  		| UBLK_F_BATCH_IO \
>  		| UBLK_F_NO_AUTO_PART_SCAN \
>  		| UBLK_F_SHMEM_ZC \
> -		| UBLK_F_IO_DESC_SIZE)
> +		| UBLK_F_IO_DESC_SIZE \
> +		| UBLK_F_SUPPORT_RQ_AFFINITY)
>  
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>  		| UBLK_F_USER_RECOVERY_REISSUE \
> @@ -452,6 +453,11 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
>  	return ubq->flags & UBLK_F_USER_COPY;
>  }
>  
> +static inline bool ublk_support_rq_affinity(const struct ublk_queue *ubq)
> +{
> +	return ubq->flags & UBLK_F_SUPPORT_RQ_AFFINITY;
> +}
> +
>  static inline bool ublk_dev_support_user_copy(const struct ublk_device *ub)
>  {
>  	return ub->dev_info.flags & UBLK_F_USER_COPY;
> @@ -1468,6 +1474,14 @@ static inline bool ublk_need_unmap_req(const struct request *req)
>  	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
>  }
>  
> +/* Whether __ublk_complete_rq() takes the copy-back/partial-completion path */
> +static inline bool ublk_rq_need_unmap(const struct ublk_queue *ubq,
> +				      struct request *req)
> +{
> +	return ublk_need_map_io(ubq) && ublk_need_unmap_req(req) &&
> +	       !ublk_iod_is_shmem_zc(ubq, req->tag);
> +}
> +
>  static unsigned int ublk_map_io(const struct request *req,
>  				const struct ublk_io *io)
>  {
> @@ -1549,13 +1563,62 @@ static void ublk_end_request(struct request *req, blk_status_t error)
>  	local_bh_enable();
>  }
>  
> +/*
> + * Update @req with its result and requeue it if it was only partially
> + * completed. Returns true if @req was requeued, in which case the caller
> + * must not touch it any further.
> + *
> + * Run bio->bi_end_io() with softirqs disabled. If the final fput happens
> + * off this path, then that will prevent ublk's blkdev_release() from
> + * being called on current's task work, see fput() implementation.
> + *
> + * This matters for the caller completing @req locally on the ublk
> + * server's own thread: it may already be holding disk->open_mutex, e.g.
> + * reading the partition table from bdev_open(), and an fput() running
> + * inline there could deadlock on it. Preferably we would not be doing
> + * IO with a mutex held that is also used for release, but this
> + * work-around will suffice for now. A caller reached instead via
> + * blk_mq_complete_request_remote()'s softirq/IPI redirect never runs on
> + * that thread, so it isn't exposed to this hazard, but disabling
> + * softirqs here is harmless for it too.
> + */
> +static inline bool ublk_update_and_requeue(struct request *req,
> +					   struct ublk_io *io)
> +{
> +	bool requeue;
> +
> +	local_bh_disable();
> +	requeue = blk_update_request(req, BLK_STS_OK, io->res);
> +	local_bh_enable();
> +	if (requeue)
> +		blk_mq_requeue_request(req, true);
> +	return requeue;
> +}
> +
> +static void ublk_end_rq(struct request *req)
> +{
> +	struct ublk_queue *ubq = req->mq_hctx->driver_data;
> +	struct ublk_io *io = &ubq->ios[req->tag];
> +
> +	/* matches the two outcomes __ublk_complete_rq() may have redirected */
> +	if (io->res >= 0 && ublk_rq_need_unmap(ubq, req)) {
> +		if (!ublk_update_and_requeue(req, io) &&
> +		    likely(!blk_should_fake_timeout(req->q)))
> +			__blk_mq_end_request(req, BLK_STS_OK);
> +		return;
> +	}

ublk_end_rq() may be run from remove cpu, then it becomes fragile to
touch `io` here, and not efficient to touch `ubq` as Caleb mentioned.

It could be simplified a lot to just deal with normal io->res == blk_rq_bytes(req)
here, meantime keep everything else(short write, failure, ...) in __ublk_complete_rq().


Thanks, 
Ming
