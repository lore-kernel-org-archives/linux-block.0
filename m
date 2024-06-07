Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599613790B
	for <linux-block@vger.kernel.org>; Fri,  7 Jun 2024 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753493; cv=none; b=bKWpt89RVk0eKzCuUv0qox2FUfXe7CTdazIGhF1Fp2Oduy9rOAupRQDAQswfiQIV3IWCc+ytJ1JTDM7xQ6so12NL2X/6N0XfsfE38h+e/3KKZAqmHt1coQJ+Ut8MixrMheTnfragBdgFF09eEXnGxLArg02T9Zgmx7PFBoJ85GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753493; c=relaxed/simple;
	bh=58yEbjyoqnb2b3XrlYBfqGyYUzJ4olbXtGEu7sBa9Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W86QlbPznwkkEAaBLfwL5XVtTXm5ScecpFHb1kWWTtl8FxLfhBxLN8oAakr5uXUuTaTT661UG75SlIzfUVKGMrUp7G8ERND0VOZBvcRvuqJRE95w5zJGD/Il7ZAiFYjl9sIb1hbDIw487vnA38Wwa9BfrsYoPYYBAXTi/s2vY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qo7LwORH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qo7LwORH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717753490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUY6PITGoFsRA8MAuBzmvx9AqHKWQlE4VIksKJma7kQ=;
	b=Qo7LwORHrvPmxMj7rOMmJ6XfMK6FjuTax658SxOof2DENmpBy++YP1DU9PTWXjmS7IMB9O
	tFcpr/9xsctrris4r4leMsp0euQeS+t+hd/13/TU1n8qktp0xew9pU7CLrOXu9OygFJzyr
	TISKlO5hOMMPT6JuCF7TPuIgiFTRU68=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-QuFkBLRKPLiPv6ApzWgYWw-1; Fri,
 07 Jun 2024 05:44:46 -0400
X-MC-Unique: QuFkBLRKPLiPv6ApzWgYWw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A8E61955E7F;
	Fri,  7 Jun 2024 09:44:44 +0000 (UTC)
Received: from fedora (unknown [10.72.112.50])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5295B19560B4;
	Fri,  7 Jun 2024 09:44:33 +0000 (UTC)
Date: Fri, 7 Jun 2024 17:44:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yang Yang <yang.yang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH v3] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Message-ID: <ZmLWfJ7OFgj+yoxV@fedora>
References: <20240606135723.2794-1-yang.yang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606135723.2794-1-yang.yang@vivo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Jun 06, 2024 at 09:57:21PM +0800, Yang Yang wrote:
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
> This patch achieves two purposes:
> First:
> Check on ->cleared and update on both ->cleared and ->word need to be
> done atomically, and using spinlock could be the simplest solution.
> So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
> may cause potential race.
> 
> Second:
> Add extra check in sbitmap_deferred_clear(), to identify whether
> map->cleared is cleared by another task after failing to get a tag.
> 
> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> 
> ---
> Changes from v2:
>   - Modify commit message by suggestion
>   - Add extra check in sbitmap_deferred_clear() by suggestion
> Changes from v1:
>   - simply revert commit 661d4f55a794 ("sbitmap: remove swap_lock")
> ---
>  include/linux/sbitmap.h |  5 +++++
>  lib/sbitmap.c           | 28 +++++++++++++++++++++-------
>  2 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index d662cf136021..ec0b0e73c906 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -36,6 +36,11 @@ struct sbitmap_word {
>  	 * @cleared: word holding cleared bits
>  	 */
>  	unsigned long cleared ____cacheline_aligned_in_smp;
> +
> +	/**
> +	 * @swap_lock: Held while swapping word <-> cleared
> +	 */
> +	spinlock_t swap_lock;
>  } ____cacheline_aligned_in_smp;
>  
>  /**
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 1e453f825c05..06b837311e03 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -60,12 +60,19 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>  /*
>   * See if we have deferred clears that we can batch move
>   */
> -static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
> +static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
> +		unsigned int depth)
>  {
>  	unsigned long mask;
> +	unsigned long flags;
> +	bool ret;
>  
> -	if (!READ_ONCE(map->cleared))
> -		return false;
> +	spin_lock_irqsave(&map->swap_lock, flags);
> +
> +	if (!map->cleared) {
> +		ret = find_first_zero_bit(&map->word, depth) >= depth ? false : true;
> +		goto out_unlock;
> +	}

Direct check over map->word should be more efficient than find_first_zero_bit():

  		if (READ_ONCE(map->word) == (1UL << depth) - 1)
			ret = false;
		else
			ret = true;

>  
>  	/*
>  	 * First get a stable cleared mask, setting the old mask to 0.
> @@ -77,7 +84,10 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>  	 */
>  	atomic_long_andnot(mask, (atomic_long_t *)&map->word);
>  	BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
> -	return true;
> +	ret = true;
> +out_unlock:
> +	spin_unlock_irqrestore(&map->swap_lock, flags);
> +	return ret;
>  }
>  
>  int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
> @@ -85,6 +95,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>  		      bool alloc_hint)
>  {
>  	unsigned int bits_per_word;
> +	int i;
>  
>  	if (shift < 0)
>  		shift = sbitmap_calculate_shift(depth);
> @@ -116,6 +127,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>  		return -ENOMEM;
>  	}
>  
> +	for (i = 0; i < sb->map_nr; i++)
> +		spin_lock_init(&sb->map[i].swap_lock);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_init_node);
> @@ -126,7 +140,7 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
>  	unsigned int i;
>  
>  	for (i = 0; i < sb->map_nr; i++)
> -		sbitmap_deferred_clear(&sb->map[i]);
> +		sbitmap_deferred_clear(&sb->map[i], depth);

The above 'depth' is whole sbitmap depth, and you need to figure out
word depth from __map_depth().


Thanks, 
Ming

