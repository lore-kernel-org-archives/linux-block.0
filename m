Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40327 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbeCEVty (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Mar 2018 16:49:54 -0500
Received: by mail-pl0-f66.google.com with SMTP id i6-v6so10528660plt.7
        for <linux-block@vger.kernel.org>; Mon, 05 Mar 2018 13:49:54 -0800 (PST)
Subject: Re: [PATCH] bcache: fix incorrect sysfs output value of strip size
To: tang.junhui@zte.com.cn, colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1518316200-31550-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <ee611450-b50d-d2c1-d17e-9ff3e4622505@lyle.org>
Date: Mon, 5 Mar 2018 13:49:51 -0800
MIME-Version: 1.0
In-Reply-To: <1518316200-31550-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

LGTM, applied.

On 02/10/2018 06:30 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> Stripe size is shown as zero when no strip in back end device:
> [root@ceph132 ~]# cat /sys/block/sdd/bcache/stripe_size
> 0.0k
> 
> Actually it should be 1T Bytes (1 << 31 sectors), but in sysfs
> interface, stripe_size was changed from sectors to bytes, and move
> 9 bits left, so the 32 bits variable overflows.
> 
> This patch change the variable to a 64 bits type before moving bits.
> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
> ---
>  drivers/md/bcache/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index b418409..240cbec 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -170,7 +170,7 @@
>  	sysfs_hprint(dirty_data,
>  		     bcache_dev_sectors_dirty(&dc->disk) << 9);
>  
> -	sysfs_hprint(stripe_size,	dc->disk.stripe_size << 9);
> +	sysfs_hprint(stripe_size,	 ((uint64_t)dc->disk.stripe_size) << 9);
>  	var_printf(partial_stripes_expensive,	"%u");
>  
>  	var_hprint(sequential_cutoff);
> 
