Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932406AbeCOPuH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:50:07 -0400
Subject: Re: [PATCH 01/16] bcache: Fix indentation
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-2-bart.vanassche@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <fd5a6a7a-b9c7-1364-22aa-e0b4521b6933@suse.de>
Date: Thu, 15 Mar 2018 23:49:10 +0800
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-2-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 15/03/2018 11:07 PM, Bart Van Assche wrote:
> This patch avoids that smatch complains about inconsistent indentation.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Reviewed-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/md/bcache/btree.c     | 2 +-
>  drivers/md/bcache/writeback.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index fad9fe8817eb..c30609c54c03 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -2170,7 +2170,7 @@ int bch_btree_insert_check_key(struct btree *b, struct btree_op *op,
>  
>  		if (b->key.ptr[0] != btree_ptr ||
>                     b->seq != seq + 1) {
> -                       op->lock = b->level;
> +			op->lock = b->level;
>  			goto out;
>                 }
>  	}
> diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
> index 587b25599856..a102d40a58bc 100644
> --- a/drivers/md/bcache/writeback.h
> +++ b/drivers/md/bcache/writeback.h
> @@ -39,7 +39,7 @@ static inline uint64_t  bcache_flash_devs_sectors_dirty(struct cache_set *c)
>  
>  		if (!d || !UUID_FLASH_ONLY(&c->uuids[i]))
>  			continue;
> -	   ret += bcache_dev_sectors_dirty(d);
> +		ret += bcache_dev_sectors_dirty(d);
>  	}
>  
>  	mutex_unlock(&bch_register_lock);
> 
