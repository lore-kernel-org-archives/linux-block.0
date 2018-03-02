Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mxhk.zte.com.cn ([63.217.80.70]:54052 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935894AbeCBFnY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Mar 2018 00:43:24 -0500
From: tang.junhui@zte.com.cn
To: mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: Re: [PATCH] bcache: don't attach backing with duplicate UUID
Date: Fri, 2 Mar 2018 13:45:49 +0800
Message-Id: <1519969549-28993-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

Hello, Mike

This patch looks good, but has some conflicts with this patch:
bcache: fix for data collapse after re-attaching an attached device
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=73ac105be390c1de42a2f21643c9778a5e002930
Could you modify your fix base on the previous patch?

> This can happen e.g. during disk cloning.
> 
> This is an incomplete fix: it does not catch duplicate UUIDs earlier
> when things are still unattached.  It does not unregister the device.
> Further changes to cope better with this are planned but conflict with
> Coly's ongoing improvements to handling device errors.  In the meantime,
> one can manually stop the device after this has happened.
> 
> Attempts to attach a duplicate device result in:
> 
> [  136.372404] loop: module loaded
> [  136.424461] bcache: register_bdev() registered backing device loop0
> [  136.424464] bcache: bch_cached_dev_attach() Tried to attach loop0 but duplicate UUID already attached
> 
> My test procedure is:
> 
>   dd if=/dev/sdb1 of=imgfile bs=1024 count=262144
>   losetup -f imgfile
> 
> Signed-off-by: Michael Lyle <mlyle@lyle.org>
> ---
>  drivers/md/bcache/super.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 9c141a8aaacc..5cace6892958 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -963,6 +963,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
>      uint32_t rtime = cpu_to_le32(get_seconds());
>      struct uuid_entry *u;
>      char buf[BDEVNAME_SIZE];
> +    struct cached_dev *exist_dc, *t;
>  
>      bdevname(dc->bdev, buf);
>  
> @@ -987,6 +988,16 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
>          return -EINVAL;
>      }
>  
> +    /* Check whether already attached */
> +    list_for_each_entry_safe(exist_dc, t, &c->cached_devs, list) {
> +        if (!memcmp(dc->sb.uuid, exist_dc->sb.uuid, 16)) {
> +            pr_err("Tried to attach %s but duplicate UUID already attached",
> +                buf);
> +
> +            return -EINVAL;
> +        }
> +    }
> +
>      u = uuid_find(c, dc->sb.uuid);
>  
>      if (u &&
> -- 
> 2.14.1

Thanks
Tang Junhui
