Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E32749CF
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 01:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153898; cv=none; b=eymR6EHPPwkOhSBhCPIajA5uj/NwocRhhL2phqJO1JLUR37VWL8WA9WjF3l5CGmnJ7Yl7IGmydcGpfg7fouX8SkBtkLlLADa0rKiGtucaMWNDpoi1KwYueTpPfJJW5v0v5S/9nYKSJ3baAEG5EjBPFgfm2Bv9GrvKj0K5X2QF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153898; c=relaxed/simple;
	bh=VzMjhjnFJWz9dLD0rxOTzWJky+s5SLINInPF47To/v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2R80su2nwr9MptXRbL0qS6qWjlYbk68Xr9lTT7uZaecV5MFiE6Xd0OcJP5lH+9bj8hRTL5MwBNbnad8XZ3BU5CiQ0w349+vNAjCmLDQ3A9EaWMF7LLdDJ82iY7FtaVbcXXDhVQBOUfpP1+VEBd6CWcV3Ei9oC2PgFWrwcC+kro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7tA224f; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7tA224f"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-408778a8ec4so1906714fac.0
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 18:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779153896; x=1779758696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cq9cVpikNjuZFrIF8dtmXI9wmUwkCwAk9zI9DbaCQ0k=;
        b=G7tA224fP6p2n/SU36vihRoFWrY+JyllnMplwtmD8WPkhYfzB/0oB7/ukbaZ3aq+si
         U3Wt9W5H5XSpRbg2iZX+psrhhV5d+ZXxu1z1vwiCaRhMEKhuoav1tpR0AIpLHQedeNey
         YAJlyKT/geAcpnvg0C6EeZyJ5khn3eL38VmNm43cutdFWlj36YkSXCrzVazZozavq3S2
         E3ZpLM8AugWdks/pCNcsezFuWRvXIwQ6YJWUvhA4yoeAdkrrCc7167lj1NkfgxnbC4fu
         zppCPit/cz6pQtco9zEoNviWt9NnHAkMI05Hk1+cfiDrpj0D2MPjfVNnamrZ5BB8j3wp
         AEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153896; x=1779758696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cq9cVpikNjuZFrIF8dtmXI9wmUwkCwAk9zI9DbaCQ0k=;
        b=XNpdWNm+kHe6hFt4c+d/v4hoPOOH+tKPx8DY1jN4ru1GhtLDVs8797vVR1sdYFvtxf
         8fyMh3J/uRNLpYSZtW5KbfeDPVLOUAI2iFeowuA3tFz28r9EvCnEhENRynmVhXbsIrrz
         lHhLf3UGtwh/1+hWuOtuoCHvBjAkaQkmRwW0Etx7w9/fBxADfpNfCRGKCS7iN7G6OQmb
         nwB0qOuJ9N1VDV+fuQPcNQRAkce2XJhoEISV1sPnbZAZIUWTF+1MnQn68wWy0gW40nYb
         K7Bnv7pQYknSrWJoKk+KC7Ew0B6cy1R4+34jBpl9/F+PsKExgkP+VA7vfDmwjzidXvZ/
         kTcg==
X-Forwarded-Encrypted: i=1; AFNElJ9K2Hkrhj86pLLL4ULRt/q35nUwGLNhoKqzjGs3YL8QYRyYA7pbBsPL4MQ0ds9wl1vaTYcSog5SxMUS8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YztztreIDlb5GzWuRARaZfYC54W/OpH8iotHmYFSOSi83OIzJaD
	ntaysxq0umPoqARg8+nRW/ywNMr9I4YqDaVTZV0uNL1IpmQ0BDmuTRgH
X-Gm-Gg: Acq92OG1U5pVhk5ZY2nz7Cl56J4hwepsYu4imeT1Pats4hxJwQsFhTKq7g+CSMvEkEy
	Wc4bbXJBaTJwdmqfnjT9x0nXU68rAesW06NSA2aL2HO7zRjD2+RNapDCCo0fFApbO6jZ+ESk4S3
	HtTmlruOkR2f6UJIZBOZwPq2iN51431/QkQDp5g+qhJcNqfC2iYL1wm43EB3h67cyIWB4/BhbNs
	e4q8VSDLbclB6IOtZxZkV6jiKcW+YNkkJUiyTtp8WCKs31ioRfwibxrRRuMALws4bh1CjwEuC15
	EjFHdRLeOnlFn9uuGOUAC0/aUiegiKWZ7GA7ozywrH5+si+mQ4dsgOjvo+JU2PM2LaoXIJY89LB
	y3LXhjjYS6kyTSLwYl9fu9M81dE6VosjtqwKjeRGOddQpXEPmZJGzlhOAj6d1TfMQE78AW0OV42
	ZL41lSU00r0062auylkbspKJYqKkr7ES5ep1+fW5SCQ/xqmcfNsZC/rbrulOjnwGDVEme6UKvao
	a6y6fxy81rbDugVuNc/
X-Received: by 2002:a05:6820:4b15:b0:69b:34db:20cc with SMTP id 006d021491bc7-69c9bdbdddamr10588018eaf.43.1779153896149;
        Mon, 18 May 2026 18:24:56 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a957b5cf4sm5852128fac.17.2026.05.18.18.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:24:55 -0700 (PDT)
Date: Tue, 19 May 2026 09:24:50 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] blk-mq: check for stale cached request in
 blk_mq_submit_bio
Message-ID: <agu74lMg10kxPXrl@fedora>
References: <20260501174120.403960-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501174120.403960-1-kbusch@meta.com>

On Fri, May 01, 2026 at 10:41:19AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> When submitting a bio to blk-mq, if the task should sleep after peeking
> a cached request, but before it pops it, the plug flushes and calls
> blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
> use-after-free bug. Fix this by ensuring the cached_rqs still contains
> our peeked request, and retry the bio submission without it if the
> request had been freed.

Yeah, it is one real bug.

> 
> The code had already warned of this possibility, and specifically popped
> the request before other known blocking calls, but it didn't handle a
> blocking GFP_NOIO alloc. Under memory pressure, allocating the split bio
> or the integrity payload are two such cases that can block. The blk-mq
> submit_bio function continues using the peeked request that was already
> freed and re-initialized, so the driver receives that request with a
> NULL'ed mq_hctx, and inevitably panics.
> 
> Relevant kernel messages if you should encounter this condition, where
> the "WARNING" is the harbinger of the panic about to happen:
> 
> ------------[ cut here ]------------
>  WARNING: CPU: 4 PID: 80820 at block/blk-mq.c:3071 blk_mq_submit_bio+0x2cf/0x5b0
> ...
>  BUG: kernel NULL pointer dereference, address: 0000000000000100
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 6b367b067 P4D 6b367b067 PUD 6bb5eb067 PMD 0
>  Oops: Oops: 0000 [#1] SMP
> ...
>  Call Trace:
>   <TASK>
>   blk_mq_dispatch_queue_requests+0x46/0x120
>   blk_mq_flush_plug_list+0x38/0x130
>   blk_add_rq_to_plug+0xa2/0x160
>   blk_mq_submit_bio+0x3ab/0x5b0
>   __submit_bio+0x3a/0x260
>   submit_bio_noacct_nocheck+0xc6/0x2b0
>   btrfs_submit_bbio+0x14d/0x520
>   ? btrfs_get_extent+0x43f/0x640
>   submit_extent_folio+0x31f/0x340
>   btrfs_do_readpage+0x2d7/0xac0
>   btrfs_readahead+0x142/0x200
>   ? clear_state_bit+0x520/0x520
>   read_pages+0x57/0x200
>   ? folio_alloc_noprof+0x10c/0x310
>   page_cache_ra_unbounded+0x28c/0x480
>   ? asm_sysvec_call_function+0x16/0x20
>   ? blk_cgroup_congested+0xa/0x50
>   ? page_cache_sync_ra+0x41/0x2d0
>   filemap_get_pages+0x347/0xd50
>   filemap_read+0xd3/0x500
>   ? 0xffffffff81000000
>   __io_read+0x111/0x440
>   io_read+0x23/0x90
>   __io_issue_sqe+0x40/0x120
>   io_issue_sqe+0x3f/0x3a0
>   io_submit_sqes+0x2bd/0x790
>   __se_sys_io_uring_enter+0x100/0xc10
>   ? eventfd_read+0x100/0x1f0
>   ? futex_wake+0x1b9/0x260
>   ? syscall_trace_enter+0x34/0x1d0
>   do_syscall_64+0x6a/0x250
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> Fixes: b0077e269f6c1 ("blk-mq: make sure active queue usage is held for bio_integrity_prep()")
> Fixes: 7b4f36cd22a65 ("block: ensure we hold a queue reference when using queue limits")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>   Warn if the cached_rqs is not NULL when the peeked request isn't the
>   top. This should never happen, but such a bug would be difficult to
>   figure out was happening without the warning. The previous warn was
>   essential to figure out the bug this patch is addressing.
> 
>   If the peeked request was freed, rerun the entire bio setup. The first
>   version potentially performed operations outside the queue usage
>   counter protection, so may have resulted in an invalid bio if it was
>   racing against a driver updating queue limites. This retry also
>   required clearing the integrity allocation if it was done since
>   updated limits may make any previous setup invalid.
> 
>  block/blk-mq.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4c5c16cce4f8f..73ef3e4be5123 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3096,22 +3096,27 @@ static struct request *blk_mq_peek_cached_request(struct blk_plug *plug,
>  	return rq;
>  }
>  
> -static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
> +static bool blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
>  		struct bio *bio)
>  {
> -	if (rq_list_pop(&plug->cached_rqs) != rq)
> -		WARN_ON_ONCE(1);
> -
>  	/*
> -	 * If any qos ->throttle() end up blocking, we will have flushed the
> -	 * plug and hence killed the cached_rq list as well. Pop this entry
> -	 * before we throttle.
> +	 * We will have flushed the plug and hence killed the cached_rq list as
> +	 * well if anything had scheduled. Pop this entry before we throttle if
> +	 * the entry is still valid.
>  	 */
> +	struct request *popped = rq_list_pop(&plug->cached_rqs);
> +
> +	if (popped != rq) {
> +		WARN_ON_ONCE(popped);
> +		return false;
> +	}
> +
>  	rq_qos_throttle(rq->q, bio);
>  
>  	blk_mq_rq_time_init(rq, blk_time_get_ns());
>  	rq->cmd_flags = bio->bi_opf;
>  	INIT_LIST_HEAD(&rq->queuelist);
> +	return true;
>  }
>  
>  static bool bio_unaligned(const struct bio *bio, struct request_queue *q)
> @@ -3154,6 +3159,7 @@ void blk_mq_submit_bio(struct bio *bio)
>  	 */
>  	rq = blk_mq_peek_cached_request(plug, q, bio->bi_opf);
>  
> +retry:
>  	/*
>  	 * A BIO that was released from a zone write plug has already been
>  	 * through the preparation in this function, already holds a reference
> @@ -3211,7 +3217,14 @@ void blk_mq_submit_bio(struct bio *bio)
>  
>  new_request:
>  	if (rq) {
> -		blk_mq_use_cached_rq(rq, plug, bio);
> +		if (!blk_mq_use_cached_rq(rq, plug, bio)) {
> +			struct bio_integrity_payload *bip = bio_integrity(bio);
> +
> +			if (bip && (bip->bip_flags & BIP_BLOCK_INTEGRITY))
> +				bio_integrity_free(bio);
> +			rq = NULL;
> +			goto retry;
> +		}

This way still looks fragile, given rq isn't guaranteed to be live.

Just wondering why not pop it from plug->cached_rqs from beginning, and
move it back in case of `queue_exit:`?



Thanks,
Ming
