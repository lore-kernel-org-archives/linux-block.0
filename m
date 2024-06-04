Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C50135A46
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717464223; cv=none; b=eO6NvgywSrQiNImYDuhdHR5IyQkl0l9E4kVyfRNQ0rK0U0BmdHxBeIpPP6PpiHXuWGjtdk08e61tHhtrNzxESuThikOjBhW50Fd+ArQ1DVwcQgW6KsyFL9Hu0keiqmGsljZYqx/ZLs1+E+Z/LFRzmqo06J2wS+BbudId3QGCYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717464223; c=relaxed/simple;
	bh=O15gvzyNr/pfCVUmDMde88fZxP3+gxS+gKbqMNJsk34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtSFFyNhMem5xr4iRALFmzAQKwLId1ctIRJIHKVFVOBl2yXhCye5FpOKVGbqSWV1VDWVJEvtFRZ6pHlFxOxoRiWbQoiYXCV8yJQkiQPZc+irRutEu4KIMn4tQeyevIKmaAt7+bosSPAwDDBCh+4KiAcqj5zRSMZ3mw1wI3qpbmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DH0p3aBJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DH0p3aBJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717464220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CN9M+8iaHy05w4rMwZa/6Tl2nAJQ0locPuboi6oJvpQ=;
	b=DH0p3aBJyHj6Zb1zxy8WcEMVgLbpeZFWv0voCLUSbwti2opoxsC/CVfhwyB3IGzSDROsc1
	6vUzBP/1yJmgyElzOJsxAZqlKbGrT9tnuPVWq3zbAylHJuaW0bqu0EZLcPiA0bn6kbHVeB
	B1xH5+Rbz9i3Zpyf4J40/vuNVSK+x8c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-3n6XFqYyNr2u0ebT9qndQg-1; Mon, 03 Jun 2024 21:23:36 -0400
X-MC-Unique: 3n6XFqYyNr2u0ebT9qndQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17F8A800CAC;
	Tue,  4 Jun 2024 01:23:36 +0000 (UTC)
Received: from fedora (unknown [10.72.116.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 95C0B4026CE1;
	Tue,  4 Jun 2024 01:23:31 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:23:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Message-ID: <Zl5sj6IC5sBqgAF2@fedora>
References: <20240527042654.2404-1-yang.yang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527042654.2404-1-yang.yang@vivo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Mon, May 27, 2024 at 12:26:50PM +0800, Yang Yang wrote:
> Configuration for sbq:
>   depth=64, wake_batch=6, shift=6, map_nr=1
> 
> 1. There are 64 requests in progress:
>   map->word = 0xFFFFFFFFFFFFFFFF
> 2. After all the 64 requests complete, and no more requests come:
>   map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
> 3. Now two tasks try to allocate requests:
>   T1:                                       T2:
>   __blk_mq_get_tag                          .
>   __sbitmap_queue_get                       .
>   sbitmap_get                               .
>   sbitmap_find_bit                          .
>   sbitmap_find_bit_in_word                  .
>   __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>   sbitmap_deferred_clear                    __sbitmap_queue_get
>   /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>     if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>       return false;                         __sbitmap_get_word -> nr=-1
>     mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>     atomic_long_andnot()                    /* map->cleared=0 */
>                                               if (!(map->cleared))
>                                                 return false;
>                                      /*
>                                       * map->cleared is cleared by T1
>                                       * T2 fail to acquire the tag
>                                       */
> 
> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> up due to the wake_batch being set at 6. If no more requests come, T1
> will wait here indefinitely.
> 
> Fix this issue by adding a new flag swap_inprogress to indicate whether
> the swap is ongoing.
> 
> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")

Indeed, commit 661d4f55a794 ("sbitmap: remove swap_lock") causes this
issue, and ->cleared and ->word should have been checked & updated
atomically.

> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>  include/linux/sbitmap.h |  5 +++++
>  lib/sbitmap.c           | 22 ++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index d662cf136021..b88a9e4997ab 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -36,6 +36,11 @@ struct sbitmap_word {
>  	 * @cleared: word holding cleared bits
>  	 */
>  	unsigned long cleared ____cacheline_aligned_in_smp;
> +
> +	/**
> +	 * @swap_inprogress: set to 1 when swapping word <-> cleared
> +	 */
> +	atomic_t swap_inprogress;
>  } ____cacheline_aligned_in_smp;
>  
>  /**
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 1e453f825c05..d4bb258fe8b0 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -62,10 +62,19 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>   */
>  static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>  {
> -	unsigned long mask;
> +	unsigned long mask, flags;
> +	int zero = 0;
>  
> -	if (!READ_ONCE(map->cleared))
> +	if (!READ_ONCE(map->cleared)) {
> +		if (atomic_read(&map->swap_inprogress))
> +			goto out_wait;
>  		return false;
> +	}
> +
> +	if (!atomic_try_cmpxchg(&map->swap_inprogress, &zero, 1))
> +		goto out_wait;
> +
> +	local_irq_save(flags);
>  
>  	/*
>  	 * First get a stable cleared mask, setting the old mask to 0.
> @@ -77,6 +86,15 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>  	 */
>  	atomic_long_andnot(mask, (atomic_long_t *)&map->word);
>  	BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
> +
> +	atomic_set(&map->swap_inprogress, 0);
> +	smp_mb__after_atomic();
> +	local_irq_restore(flags);
> +	return true;
> +
> +out_wait:
> +	while (atomic_read(&map->swap_inprogress))
> +		;
>  	return true;
>  }

IMO, the above fix looks a bit complicated, and I'd suggest to revert
661d4f55a794 ("sbitmap: remove swap_lock") if no clean & simple solution
can be figured out.

Thanks,
Ming

