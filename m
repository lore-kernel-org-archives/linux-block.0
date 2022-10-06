Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F5C433F5
	for <linux-block@archiver.kernel.org>; Thu,  6 Oct 2022 14:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiJFOr1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Oct 2022 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJFOr0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2022 10:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED5613F27
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665067644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7KJVCGDP1E6PHwh3K1PS2Vq1v9Vxn8/icFx8u9Ndy0=;
        b=XqgEKismmGIM24m199r/4u3ovTyieop7DVDW6GOvzlC0FxnbVS/NoI9p62kDZKa62++5tQ
        toGH9BBd6M2cvOo8Hteqj5+keNd6hY1fpR+ojYqpWC2v+2XlRgS2853Bn72ho3AlIyrcJ6
        cJapXVBQUsBy3lT2R5kjz4ssLQuVGh0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-578-qW6-sE_PNsaaO3Dt4r3zig-1; Thu, 06 Oct 2022 10:47:23 -0400
X-MC-Unique: qW6-sE_PNsaaO3Dt4r3zig-1
Received: by mail-qv1-f70.google.com with SMTP id q20-20020ad44354000000b004afb5a0d33cso1227689qvs.12
        for <linux-block@vger.kernel.org>; Thu, 06 Oct 2022 07:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7KJVCGDP1E6PHwh3K1PS2Vq1v9Vxn8/icFx8u9Ndy0=;
        b=z9cwA41xUFFgI7eMgMlcinuGeJWgtdktmxhhnw/QnX6ShpWRRj7GUC19lhzOBydSwV
         jjJpapFmfBJ9Ds8FM5+K2lmpylMv+NCB6xkt8F3D6UmAVQwI5rep7+osI4DvRIM3lSh8
         BKSgXJnIR3Kdk3/0pAU9m4jg4VFi3Ojv+sEXHzLRv80cOfelEcqmpHZlANhMPIMvOfUk
         rbzuAogXU9lQzDLuYuR5F8qERTpL0DopV2JzdEP6Dbd6az16vUvinI91vZtV/O5pNv4M
         IEQpj9F4vy2JuLErBDxZC72IhXgXLkv9UzY1YhPHinSzPA8ouxHf5Kalojt4/tyhIqiN
         FdDg==
X-Gm-Message-State: ACrzQf1LfKSe25JR++ta7gIzBcp+J84D8ExpRI2bbQPLNCQ/eoqCyKmW
        bB2F+rKor9TvbGYltExCehQ7YNKMTCGfJFcTEATqY1BJMfG8IX4S0TR2k92FrMtXMYipZAQ4KjL
        y4Df0RGsTDgW7QJ6W92BBXnw=
X-Received: by 2002:a05:6214:242a:b0:4aa:9c94:5d77 with SMTP id gy10-20020a056214242a00b004aa9c945d77mr83383qvb.99.1665067642952;
        Thu, 06 Oct 2022 07:47:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5OOQ87tnoM4g+nsxhTviTOUzCc0wFPb5JS+fAFspnuAaAOWqj1mCTZjwNgGex0q2mmvO7zGg==
X-Received: by 2002:a05:6214:242a:b0:4aa:9c94:5d77 with SMTP id gy10-20020a056214242a00b004aa9c945d77mr83348qvb.99.1665067642543;
        Thu, 06 Oct 2022 07:47:22 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a244600b006d94c499d8fsm5500940qkn.50.2022.10.06.07.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:47:22 -0700 (PDT)
Date:   Thu, 6 Oct 2022 10:47:20 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: mempool: introduce page bulk allocator
Message-ID: <Yz7qeI0s6TjSEIFe@bfoster>
References: <20221005180341.1738796-1-shy828301@gmail.com>
 <20221005180341.1738796-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005180341.1738796-3-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 05, 2022 at 11:03:39AM -0700, Yang Shi wrote:
> Since v5.13 the page bulk allocator was introduced to allocate order-0
> pages in bulk.  There are a few mempool allocator callers which does
> order-0 page allocation in a loop, for example, dm-crypt, f2fs compress,
> etc.  A mempool page bulk allocator seems useful.  So introduce the
> mempool page bulk allocator.
> 
> It introduces the below APIs:
>   - mempool_init_pages_bulk()
>   - mempool_create_pages_bulk()
> They initialize the mempool for page bulk allocator.  The pool is filled
> by alloc_page() in a loop.
> 
>   - mempool_alloc_pages_bulk_list()
>   - mempool_alloc_pages_bulk_array()
> They do bulk allocation from mempool.
> They do the below conceptually:
>   1. Call bulk page allocator
>   2. If the allocation is fulfilled then return otherwise try to
>      allocate the remaining pages from the mempool
>   3. If it is fulfilled then return otherwise retry from #1 with sleepable
>      gfp
>   4. If it is still failed, sleep for a while to wait for the mempool is
>      refilled, then retry from #1
> The populated pages will stay on the list or array until the callers
> consume them or free them.
> Since mempool allocator is guaranteed to success in the sleepable context,
> so the two APIs return true for success or false for fail.  It is the
> caller's responsibility to handle failure case (partial allocation), just
> like the page bulk allocator.
> 
> The mempool typically is an object agnostic allocator, but bulk allocation
> is only supported by pages, so the mempool bulk allocator is for page
> allocation only as well.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---

Hi Yang,

I'm not terribly familiar with either component so I'm probably missing
context/details, but just a couple high level thoughts when reading your
patches...

>  include/linux/mempool.h |  19 ++++
>  mm/mempool.c            | 188 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 197 insertions(+), 10 deletions(-)
> 
...
> diff --git a/mm/mempool.c b/mm/mempool.c
> index ba32151f3843..7711ca2e6d66 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -177,6 +177,7 @@ void mempool_destroy(mempool_t *pool)
>  EXPORT_SYMBOL(mempool_destroy);
>  
>  static inline int __mempool_init(mempool_t *pool, int min_nr,
> +				 mempool_alloc_pages_bulk_t *alloc_pages_bulk_fn,
>  				 mempool_alloc_t *alloc_fn,
>  				 mempool_free_t *free_fn, void *pool_data,
>  				 gfp_t gfp_mask, int node_id)
> @@ -186,8 +187,11 @@ static inline int __mempool_init(mempool_t *pool, int min_nr,
>  	pool->pool_data = pool_data;
>  	pool->alloc	= alloc_fn;
>  	pool->free	= free_fn;
> +	pool->alloc_pages_bulk = alloc_pages_bulk_fn;
>  	init_waitqueue_head(&pool->wait);
>  
> +	WARN_ON_ONCE(alloc_pages_bulk_fn && alloc_fn);
> +
>  	pool->elements = kmalloc_array_node(min_nr, sizeof(void *),
>  					    gfp_mask, node_id);
>  	if (!pool->elements)
> @@ -199,7 +203,10 @@ static inline int __mempool_init(mempool_t *pool, int min_nr,
>  	while (pool->curr_nr < pool->min_nr) {
>  		void *element;
>  
> -		element = pool->alloc(gfp_mask, pool->pool_data);
> +		if (pool->alloc_pages_bulk)
> +			element = alloc_page(gfp_mask);

Any reason to not use the callback from the caller for the bulk variant
here? It looks like some users might expect consistency between the
alloc / free callbacks for the pool. I.e., I'm not familiar with
dm-crypt, but the code modified in the subsequent patches looks like it
keeps an allocated page count. Will that still work with this, assuming
these pages are freed through free_fn?

> +		else
> +			element = pool->alloc(gfp_mask, pool->pool_data);
>  		if (unlikely(!element)) {
>  			mempool_exit(pool);
>  			return -ENOMEM;
...
> @@ -457,6 +499,132 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(mempool_alloc);
>  
> +/**
> + * mempool_alloc_pages_bulk - allocate a bulk of pagesfrom a specific
> + *                           memory pool
> + * @pool:       pointer to the memory pool which was allocated via
> + *              mempool_create().
> + * @gfp_mask:   the usual allocation bitmask.
> + * @nr:         the number of requested pages.
> + * @page_list:  the list the pages will be added to.
> + * @page_array: the array the pages will be added to.
> + *
> + * this function only sleeps if the alloc_pages_bulk_fn() function sleeps
> + * or the allocation can not be satisfied even though the mempool is depleted.
> + * Note that due to preallocation, this function *never* fails when called
> + * from process contexts. (it might fail if called from an IRQ context.)
> + * Note: using __GFP_ZERO is not supported.  And the caller should not pass
> + * in both valid page_list and page_array.
> + *
> + * Return: true when nr pages are allocated or false if not.  It is the
> + *         caller's responsibility to free the partial allocated pages.
> + */
> +static bool mempool_alloc_pages_bulk(mempool_t *pool, gfp_t gfp_mask,
> +				     unsigned int nr,
> +				     struct list_head *page_list,
> +				     struct page **page_array)
> +{
> +	unsigned long flags;
> +	wait_queue_entry_t wait;
> +	gfp_t gfp_temp;
> +	int i;
> +	unsigned int ret, nr_remaining;
> +	struct page *page;
> +

This looks like a lot of duplicate boilerplate from mempool_alloc().
Could this instead do something like: rename the former to
__mempool_alloc() and add a count parameter, implement bulk alloc
support in there for count > 1, then let traditional (i.e., non-bulk)
mempool_alloc() callers pass a count of 1?

Along the same lines, I also wonder if there's any value in generic bulk
alloc support for mempool. For example, I suppose technically this could
be implemented via one change to support a pool->alloc_bulk() callback
that any user could implement via a loop if they wanted
mempool_alloc_bulk() support backed by a preallocated pool. The page
based user could then just use that to call alloc_pages_bulk_*() as an
optimization without the mempool layer needing to know or care about
whether the underlying elements are pages or not. Hm?

Brian

> +	VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
> +	might_alloc(gfp_mask);
> +
> +	gfp_mask |= __GFP_NOMEMALLOC;   /* don't allocate emergency reserves */
> +	gfp_mask |= __GFP_NORETRY;      /* don't loop in __alloc_pages */
> +	gfp_mask |= __GFP_NOWARN;       /* failures are OK */
> +
> +	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
> +
> +repeat_alloc:
> +	i = 0;
> +	ret = pool->alloc_pages_bulk(gfp_temp, nr, pool->pool_data, page_list,
> +				     page_array);
> +
> +	if (ret == nr)
> +		return true;
> +
> +	nr_remaining = nr - ret;
> +
> +	spin_lock_irqsave(&pool->lock, flags);
> +	/* Allocate page from the pool and add to the list or array */
> +	while (pool->curr_nr && (nr_remaining > 0)) {
> +		page = remove_element(pool);
> +		spin_unlock_irqrestore(&pool->lock, flags);
> +		smp_wmb();
> +
> +		kmemleak_update_trace((void *)page);
> +
> +		if (page_list)
> +			list_add(&page->lru, page_list);
> +		else
> +			page_array[ret + i] = page;
> +
> +		i++;
> +		nr_remaining--;
> +
> +		spin_lock_irqsave(&pool->lock, flags);
> +	}
> +
> +	spin_unlock_irqrestore(&pool->lock, flags);
> +
> +	if (!nr_remaining)
> +		return true;
> +
> +	/*
> +	 * The bulk allocator counts in the populated pages for array,
> +	 * but don't do it for list.
> +	 */
> +	if (page_list)
> +		nr = nr_remaining;
> +
> +	/*
> +	 * We use gfp mask w/o direct reclaim or IO for the first round.  If
> +	 * alloc failed with that and @pool was empty, retry immediately.
> +	 */
> +	if (gfp_temp != gfp_mask) {
> +		gfp_temp = gfp_mask;
> +		goto repeat_alloc;
> +	}
> +
> +	/* We must not sleep if !__GFP_DIRECT_RECLAIM */
> +	if (!(gfp_mask & __GFP_DIRECT_RECLAIM))
> +		return false;
> +
> +	/* Let's wait for someone else to return an element to @pool */
> +	init_wait(&wait);
> +	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
> +
> +	/*
> +	 * FIXME: this should be io_schedule().  The timeout is there as a
> +	 * workaround for some DM problems in 2.6.18.
> +	 */
> +	io_schedule_timeout(5*HZ);
> +
> +	finish_wait(&pool->wait, &wait);
> +	goto repeat_alloc;
> +}
> +
> +bool mempool_alloc_pages_bulk_list(mempool_t *pool, gfp_t gfp_mask,
> +				   unsigned int nr,
> +				   struct list_head *page_list)
> +{
> +	return mempool_alloc_pages_bulk(pool, gfp_mask, nr, page_list, NULL);
> +}
> +EXPORT_SYMBOL(mempool_alloc_pages_bulk_list);
> +
> +bool mempool_alloc_pages_bulk_array(mempool_t *pool, gfp_t gfp_mask,
> +				    unsigned int nr,
> +				    struct page **page_array)
> +{
> +	return mempool_alloc_pages_bulk(pool, gfp_mask, nr, NULL, page_array);
> +}
> +EXPORT_SYMBOL(mempool_alloc_pages_bulk_array);
> +
>  /**
>   * mempool_free - return an element to the pool.
>   * @element:   pool element pointer.
> -- 
> 2.26.3
> 

