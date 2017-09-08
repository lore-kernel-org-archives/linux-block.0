Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:46657 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755392AbdIHNBd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Sep 2017 09:01:33 -0400
Received: by mail-wm0-f47.google.com with SMTP id i189so4447881wmf.1
        for <linux-block@vger.kernel.org>; Fri, 08 Sep 2017 06:01:33 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: prevent target type module removal when in use
To: Rakesh Pandit <rakesh@tuxera.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <20170908123527.GA48728@dhcp-216.srv.tuxera.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <005a38cc-d120-12ce-39b1-cd1503f72e8d@lightnvm.io>
Date: Fri, 8 Sep 2017 15:01:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170908123527.GA48728@dhcp-216.srv.tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/08/2017 02:35 PM, Rakesh Pandit wrote:
> If target type module e.g. pblk here is unloaded (rmmod) while module
> is in use (after creating target) system crashes.  We fix this by
> using module API refcnt.
> 
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
>   drivers/lightnvm/core.c      | 4 ++++
>   drivers/lightnvm/pblk-init.c | 1 +
>   include/linux/lightnvm.h     | 1 +
>   3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index bbea2c8..c39f87d 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -22,6 +22,7 @@
>   #include <linux/types.h>
>   #include <linux/sem.h>
>   #include <linux/bitmap.h>
> +#include <linux/module.h>
>   #include <linux/moduleparam.h>
>   #include <linux/miscdevice.h>
>   #include <linux/lightnvm.h>
> @@ -316,6 +317,8 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>   	list_add_tail(&t->list, &dev->targets);
>   	mutex_unlock(&dev->mlock);
>   
> +	__module_get(tt->owner);
> +
>   	return 0;
>   err_sysfs:
>   	if (tt->exit)
> @@ -351,6 +354,7 @@ static void __nvm_remove_target(struct nvm_target *t)
>   
>   	nvm_remove_tgt_dev(t->dev, 1);
>   	put_disk(tdisk);
> +	module_put(t->type->owner);
>   
>   	list_del(&t->list);
>   	kfree(t);
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 5fe926b..77d6120 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1059,6 +1059,7 @@ static struct nvm_tgt_type tt_pblk = {
>   
>   	.sysfs_init	= pblk_sysfs_init,
>   	.sysfs_exit	= pblk_sysfs_exit,
> +	.owner		= THIS_MODULE,
>   };
>   
>   static int __init pblk_module_init(void)
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 81b71c6d..78a22e0 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -461,6 +461,7 @@ struct nvm_tgt_type {
>   
>   	/* For internal use */
>   	struct list_head list;
> +	struct module *owner;
>   };
>   
>   extern struct nvm_tgt_type *nvm_find_target_type(const char *, int);
> 

Thanks Rakesh. I've picked it up for 4.15.
