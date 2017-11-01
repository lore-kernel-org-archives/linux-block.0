Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752143AbdKANrY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Nov 2017 09:47:24 -0400
Date: Wed, 1 Nov 2017 14:47:22 +0100
From: Jan Kara <jack@suse.cz>
To: weiping zhang <zhangweiping@didichuxing.com>
Cc: axboe@kernel.dk, jack@suse.cz, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] bdi: add error handle for bdi_debug_register
Message-ID: <20171101134722.GB28572@quack2.suse.cz>
References: <cover.1509415695.git.zhangweiping@didichuxing.com>
 <100ecef9a09dc2a95feb5f6fac21c8bfa26be4eb.1509415695.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <100ecef9a09dc2a95feb5f6fac21c8bfa26be4eb.1509415695.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue 31-10-17 18:38:24, weiping zhang wrote:
> In order to make error handle more cleaner we call bdi_debug_register
> before set state to WB_registered, that we can avoid call bdi_unregister
> in release_bdi().
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/backing-dev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index b5f940ce0143..84b2dc76f140 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -882,10 +882,13 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>  	if (IS_ERR(dev))
>  		return PTR_ERR(dev);
>  
> +	if (bdi_debug_register(bdi, dev_name(dev))) {
> +		device_destroy(bdi_class, dev->devt);
> +		return -ENOMEM;
> +	}
>  	cgwb_bdi_register(bdi);
>  	bdi->dev = dev;
>  
> -	bdi_debug_register(bdi, dev_name(dev));
>  	set_bit(WB_registered, &bdi->wb.state);
>  
>  	spin_lock_bh(&bdi_lock);
> -- 
> 2.14.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
