Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752013AbeCQOVV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Mar 2018 10:21:21 -0400
Subject: Re: [PATCH] bache: put all the sorted bucket in heap into the
 free_inc queue
To: tang.junhui@zte.com.cn, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1521277116-8470-1-git-send-email-tang.junhui@zte.com.cn>
From: Coly Li <colyli@suse.de>
Message-ID: <4e6d7162-65ff-3e5c-cab2-bef400af065e@suse.de>
Date: Sat, 17 Mar 2018 22:21:09 +0800
MIME-Version: 1.0
In-Reply-To: <1521277116-8470-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 17/03/2018 4:58 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> We make a lot of effort to sort buckets in heap, but we only pull
> half of buckets into free_inc queue, it's too wasteful.
> 
> And in incremental GC, we may run out of all buckets in free_inc
> queue during GC, so it would be useful if we have more buckets
> in free_inc queue.
> 
> This patch enlarge the size of free_inc queue as much as the heap.
> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
> ---
>  drivers/md/bcache/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index b4d2892..6f428c0 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1835,7 +1835,7 @@ static int cache_alloc(struct cache *ca)
>  	    !init_fifo_exact(&ca->free[RESERVE_PRIO], prio_buckets(ca), GFP_KERNEL) ||
>  	    !init_fifo(&ca->free[RESERVE_MOVINGGC], free, GFP_KERNEL) ||
>  	    !init_fifo(&ca->free[RESERVE_NONE], free, GFP_KERNEL) ||
> -	    !init_fifo(&ca->free_inc,	free << 2, GFP_KERNEL) ||
> +	    !init_fifo(&ca->free_inc,	free << 3, GFP_KERNEL) ||
>  	    !init_heap(&ca->heap,	free << 3, GFP_KERNEL) ||
>  	    !(ca->buckets	= vzalloc(sizeof(struct bucket) *
>  					  ca->sb.nbuckets)) ||
> 

Hi Junhui,

I feel the original code might be better. ca->heap is not a strict
ordered list, it just makes sure at some location in the heap list, all
prios before this location are larger than all prios after this location.

If ca->heap is x2 size of ca->free_inc, it means there is chance to
invalidate 50% buckets of higher prios. And the buckets with lower prios
can still stay in ca->heap until they have chance to be selected.

If ca->free_inc is set to same size as ca->heap, we need to know that
not all buckets in ca->heap can be invalidated, so after iterating all
buckets in ca->heap, maybe we can not make ca->free_inc to be full. In
this case, gc thread needs to be waken up. This will be a bug because it
is very probably that not all buckets from ca->heap can be pushed into
ca->free_inc, then gc thread is just frequently waken up for nothing.

Thanks.

Coly Li
