Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37252 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933015AbeCGB77 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Mar 2018 20:59:59 -0500
Received: by mail-pl0-f67.google.com with SMTP id w12-v6so449449plp.4
        for <linux-block@vger.kernel.org>; Tue, 06 Mar 2018 17:59:59 -0800 (PST)
Subject: Re: [PATCH] [v2] bcache: fix using of loop variable in memory shrink
To: tang.junhui@zte.com.cn, colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1520322808-13187-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <286b81a9-ec66-28f7-47af-744597b095bd@lyle.org>
Date: Tue, 6 Mar 2018 17:59:56 -0800
MIME-Version: 1.0
In-Reply-To: <1520322808-13187-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tang Junhui--

On 03/05/2018 11:53 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> In bch_mca_scan(), There are some confusion and logical error in the use of
> loop variables. In this patch, we clarify them as:
> 1) nr: the number of btree nodes needs to scan, which will decrease after
> we scan a btree node, and should not be less than 0;
> 2) i: the number of btree nodes have scanned, includes both
> btree_cache_freeable and btree_cache, which should not be bigger than
> btree_cache_used;
> 3) freed: the number of btree nodes have freed.

Thanks-- this looks better.  Applied to my tree.

Incidentally, I still get DOS line endings with the patches you send
out, and I'm not sure why.  I can fix it with checkpatch, so it's not a
big deal.  Maybe it relates to the git version you're using?

Mike

> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
> ---
>  drivers/md/bcache/btree.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 81e8dc3..7487f8e 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -664,6 +664,7 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
>  	struct btree *b, *t;
>  	unsigned long i, nr = sc->nr_to_scan;
>  	unsigned long freed = 0;
> +	unsigned int btree_cache_used;
>  
>  	if (c->shrinker_disabled)
>  		return SHRINK_STOP;
> @@ -688,9 +689,10 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
>  	nr = min_t(unsigned long, nr, mca_can_free(c));
>  
>  	i = 0;
> +	btree_cache_used = c->btree_cache_used;
>  	list_for_each_entry_safe(b, t, &c->btree_cache_freeable, list) {
> -		if (freed >= nr)
> -			break;
> +		if (nr <= 0)
> +			goto out;
>  
>  		if (++i > 3 &&
>  		    !mca_reap(b, 0, false)) {
> @@ -698,9 +700,10 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
>  			rw_unlock(true, b);
>  			freed++;
>  		}
> +		nr--;
>  	}
>  
> -	for (i = 0; (nr--) && i < c->btree_cache_used; i++) {
> +	for (;  (nr--) && i < btree_cache_used; i++) {
>  		if (list_empty(&c->btree_cache))
>  			goto out;
>  
> 
