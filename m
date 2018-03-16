Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbeCPErf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Mar 2018 00:47:35 -0400
Subject: Re: [PATCH 15/16] bcache: Fix an endianness bug
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-bcache <linux-bcache@vger.kernel.org>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-16-bart.vanassche@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <6b2b29bb-f26b-2df9-3609-26100cc1c9a5@suse.de>
Date: Fri, 16 Mar 2018 12:47:24 +0800
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-16-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 15/03/2018 11:08 PM, Bart Van Assche wrote:
> Ensure that byte swapping occurs on big endian architectures when
> reading or writing the superblock.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Hi Bart,

The code still does not work with your patch on big endian machine (e.g.
s390x). When I fix the bcache s390x bug, I did something like this patch
in my first try. It turns out more things need to be fixed,
1, some cache_sb members only swapped to cpu endianness when read in,
not swapped to little endian when write out. For example data_offset,
nbuckets, nr_in_set, nr_this_dev ...
2, checksum is calculated in cpu endiannness, not explicitly in little
endian.

Also user space tools need to update to support the endianness issue.

How about leave the endianness problem to me? I will pick code piece
from your patch and set 'From: Bart Van Assche <bart.vanassche@wdc.com>'
on the patch(s), and continue my fix for bcache on s390x.

Thanks.

Coly Li

> ---
>  drivers/md/bcache/bcache.h | 12 ++++++++++++
>  drivers/md/bcache/super.c  |  4 ++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> index 72b1ea4576d9..50ddc78596bf 100644
> --- a/drivers/md/bcache/bcache.h
> +++ b/drivers/md/bcache/bcache.h
> @@ -784,6 +784,18 @@ static inline bool ptr_available(struct cache_set *c, const struct bkey *k,
>  	bch_crc64(p, q - p);					\
>  })
>  
> +/*
> + * Variant of csum_set() for data structures in which (i)->keys has type
> + * __le16.
> + */
> +#define csum_set_le(i) ({						\
> +	const void *p = (void *)(i) + sizeof(uint64_t);			\
> +	const void *q = bkey_idx((struct bkey *)(i)->d,			\
> +				 le16_to_cpu((i)->keys));		\
> +									\
> +	bch_crc64(p, q - p);						\
> +})
> +
>  /* Error handling macros */
>  
>  #define btree_bug(b, ...)						\
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 39bec137f636..31d700aecd56 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -110,7 +110,7 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
>  		goto err;
>  
>  	err = "Bad checksum";
> -	if (s->csum != csum_set(s))
> +	if (s->csum != csum_set_le(s))
>  		goto err;
>  
>  	err = "Bad UUID";
> @@ -236,7 +236,7 @@ static void __write_super(struct cache_sb *sb, struct bio *bio)
>  	for (i = 0; i < sb->keys; i++)
>  		out->d[i] = cpu_to_le64(sb->d[i]);
>  
> -	out->csum = csum_set(out);
> +	out->csum = csum_set_le(out);
>  
>  	pr_debug("ver %llu, flags %llu, seq %llu",
>  		 sb->version, sb->flags, sb->seq);
> 
