Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35368 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbeCEWCM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Mar 2018 17:02:12 -0500
Received: by mail-pl0-f68.google.com with SMTP id bb3-v6so10572224plb.2
        for <linux-block@vger.kernel.org>; Mon, 05 Mar 2018 14:02:12 -0800 (PST)
Subject: Re: [PATCH] bcache: fix error count in memory shrink
To: tang.junhui@zte.com.cn, colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1517366812-26957-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <e16b63e3-0123-96f4-ce82-4e1022fc83fa@lyle.org>
Date: Mon, 5 Mar 2018 14:02:09 -0800
MIME-Version: 1.0
In-Reply-To: <1517366812-26957-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tang Junhui---

I'm not really sure about this one.  It changes the semantics of the
amount of work done-- nr_to_scan now means number of things to free
instead of the number to check.

If the system is under severe memory pressure, and most of the cache is
essential/actively used, this could greatly increase the amount of work
done.

As to the i < btree_cache_used, it's arguably a bug, but it only reduces
the amount of work done if the cache is very, very small.

Mike

On 01/30/2018 06:46 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> In bch_mca_scan(), nr btree nodes are expected to shrink, so the for(;;)
> loop need to satisfy the condition freed < nr.
> And since c->btree_cache_used always decrease after mca_data_free() calling
> in for(;;) loop,  so we need a auto variable to record c->btree_cache_used
> before the for(;;) loop.
> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
> ---
>  drivers/md/bcache/btree.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 81e8dc3..7e9ef3d 100644
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
> @@ -700,7 +701,8 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
>  		}
>  	}
>  
> -	for (i = 0; (nr--) && i < c->btree_cache_used; i++) {
> +	btree_cache_used = c->btree_cache_used;
> +	for (i = 0; freed < nr && i < btree_cache_used; i++) {
>  		if (list_empty(&c->btree_cache))
>  			goto out;
>  
> 
