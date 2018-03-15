Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57695 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeCOQIU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 12:08:20 -0400
Subject: Re: [PATCH 08/16] bcache: Fix a compiler warning in
 bcache_device_init()
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-bcache <linux-bcache@vger.kernel.org>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-9-bart.vanassche@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <ed10c7f2-8dfd-f7cb-4db5-10b3f2e71fb9@suse.de>
Date: Fri, 16 Mar 2018 00:07:12 +0800
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-9-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 15/03/2018 11:08 PM, Bart Van Assche wrote:
> Avoid that building with W=1 triggers the following compiler warning:
> 
> drivers/md/bcache/super.c:776:20: warning: comparison is always false due to limited range of data type [-Wtype-limits]
>       d->nr_stripes > SIZE_MAX / sizeof(atomic_t)) {
>                     ^
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Reviewed-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/md/bcache/super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index e8dfa804bd98..87c1f853bbb3 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -769,6 +769,8 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
>  			      sector_t sectors)
>  {
>  	struct request_queue *q;
> +	const size_t max_stripes = min_t(size_t, INT_MAX,
> +					 SIZE_MAX / sizeof(atomic_t));
>  	size_t n;
>  	int idx;
>  
> @@ -777,9 +779,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
>  
>  	d->nr_stripes = DIV_ROUND_UP_ULL(sectors, d->stripe_size);
>  
> -	if (!d->nr_stripes ||
> -	    d->nr_stripes > INT_MAX ||
> -	    d->nr_stripes > SIZE_MAX / sizeof(atomic_t)) {
> +	if (!d->nr_stripes || d->nr_stripes > max_stripes) {
>  		pr_err("nr_stripes too large or invalid: %u (start sector beyond end of disk?)",
>  			(unsigned)d->nr_stripes);
>  		return -ENOMEM;
> 
