Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbeCOQVO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 12:21:14 -0400
Subject: Re: [PATCH 06/16] bcache: Suppress more warnings about
 set-but-not-used variables
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-bcache <linux-bcache@vger.kernel.org>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-7-bart.vanassche@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <53cbda05-917f-cce3-91ff-73e363448773@suse.de>
Date: Fri, 16 Mar 2018 00:20:10 +0800
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-7-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 15/03/2018 11:08 PM, Bart Van Assche wrote:
> This patch does not change any functionality.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Hi Bart,

This patch looks good to me. A question is, does GCC later than 4.3
supports such annotation like '__maybe_unused' ?

Thanks.

Coly Li

> ---
>  drivers/md/bcache/bset.c    | 4 ++--
>  drivers/md/bcache/journal.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
> index e56d3ecdbfcb..579c696a5fe0 100644
> --- a/drivers/md/bcache/bset.c
> +++ b/drivers/md/bcache/bset.c
> @@ -1072,7 +1072,7 @@ EXPORT_SYMBOL(bch_btree_iter_init);
>  static inline struct bkey *__bch_btree_iter_next(struct btree_iter *iter,
>  						 btree_iter_cmp_fn *cmp)
>  {
> -	struct btree_iter_set unused;
> +	struct btree_iter_set b __maybe_unused;
>  	struct bkey *ret = NULL;
>  
>  	if (!btree_iter_end(iter)) {
> @@ -1087,7 +1087,7 @@ static inline struct bkey *__bch_btree_iter_next(struct btree_iter *iter,
>  		}
>  
>  		if (iter->data->k == iter->data->end)
> -			heap_pop(iter, unused, cmp);
> +			heap_pop(iter, b, cmp);
>  		else
>  			heap_sift(iter, 0, cmp);
>  	}
> diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
> index 1b736b860739..605368ff13c9 100644
> --- a/drivers/md/bcache/journal.c
> +++ b/drivers/md/bcache/journal.c
> @@ -493,7 +493,7 @@ static void journal_reclaim(struct cache_set *c)
>  	struct cache *ca;
>  	uint64_t last_seq;
>  	unsigned iter, n = 0;
> -	atomic_t p;
> +	atomic_t p __maybe_unused;
>  
>  	atomic_long_inc(&c->reclaim);
>  
> 
