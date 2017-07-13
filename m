Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx.ewheeler.net ([66.155.3.69]:49172 "EHLO mail.ewheeler.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750718AbdGMDlY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 23:41:24 -0400
Date: Thu, 13 Jul 2017 03:41:22 +0000 (UTC)
From: Eric Wheeler <bcache@lists.ewheeler.net>
To: Tang Junhui <tang.junhui@zte.com.cn>
cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org
Subject: Re: [PATCH 13/19] bcache: delete redundant calling
 set_gc_sectors()
In-Reply-To: <1498855388-16990-13-git-send-email-bcache@lists.ewheeler.net>
Message-ID: <alpine.LRH.2.11.1707130340340.9683@mail.ewheeler.net>
References: <20170629134510.GA32385@infradead.org> <1498855388-16990-1-git-send-email-bcache@lists.ewheeler.net> <1498855388-16990-13-git-send-email-bcache@lists.ewheeler.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 30 Jun 2017, bcache@lists.ewheeler.net wrote:

> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> set_gc_sectors() has been called in bch_gc_thread(), and it was called
> again in bch_btree_gc_finish() . The following call is unnecessary, so
> delete it.


I'm trying to follow the call path that proves that this is safe, but I'm 
not seeing it.  Can you explain this in more detail?

--
Eric Wheeler



> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
> ---
>  drivers/md/bcache/btree.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 77aa20b..66d8036 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -1662,7 +1662,6 @@ static size_t bch_btree_gc_finish(struct cache_set *c)
>  
>  	mutex_lock(&c->bucket_lock);
>  
> -	set_gc_sectors(c);
>  	c->gc_mark_valid = 1;
>  	c->need_gc	= 0;
>  
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bcache" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
