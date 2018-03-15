Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59401 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751542AbeCOQXK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 12:23:10 -0400
Subject: Re: [PATCH 09/16] bcache: Remove a redundant assignment
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-10-bart.vanassche@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <3e6a2256-891a-2e4e-1676-d692bc158ddb@suse.de>
Date: Fri, 16 Mar 2018 00:22:28 +0800
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-10-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 15/03/2018 11:08 PM, Bart Van Assche wrote:
> A bio_set_op_attrs() call a little further down overwrites bio->bi_opf.
> That means that the bio->bi_opf assignment is redundant. Hence remove it.
> See also commit ad0d9e76a412 ("bcache: use bio op accessors").
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Mike Christie <mchristi@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>

Reviewed-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/md/bcache/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 87c1f853bbb3..d19a44cd1fd7 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -353,7 +353,6 @@ static void uuid_io(struct cache_set *c, int op, unsigned long op_flags,
>  	for (i = 0; i < KEY_PTRS(k); i++) {
>  		struct bio *bio = bch_bbio_alloc(c);
>  
> -		bio->bi_opf = REQ_SYNC | REQ_META | op_flags;
>  		bio->bi_iter.bi_size = KEY_SIZE(k) << 9;
>  
>  		bio->bi_end_io	= uuid_endio;
> 
