Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37322 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbdA3K3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2017 05:29:01 -0500
Received: by mail-wm0-f42.google.com with SMTP id v77so40919776wmv.0
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2017 02:27:48 -0800 (PST)
Subject: Re: [PATCH 2/3] lightnvm: allow targets to use sysfs
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1485431260-20268-1-git-send-email-javier@cnexlabs.com>
 <1485431260-20268-2-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <582417dd-99c1-7329-ebff-b5bac0970c74@lightnvm.io>
Date: Mon, 30 Jan 2017 11:27:46 +0100
MIME-Version: 1.0
In-Reply-To: <1485431260-20268-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/26/2017 12:47 PM, Javier González wrote:
> In order to register through the sysfs interface, a driver needs to know
> its kobject. On a disk structure, this happens when the partition
> information is added (device_add_disk), which for lightnvm takes place
> after the target has been initialized. This means that on target
> initialization, the kboject has not been created yet.
> 
> This patch adds a target function to let targets initialize their own
> kboject as a child of the disk kobject.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/core.c  | 9 +++++++++
>  include/linux/lightnvm.h | 5 +++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 3a3e91d..8baae61 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -289,6 +289,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>  	set_capacity(tdisk, tt->capacity(targetdata));
>  	add_disk(tdisk);
>  
> +	if (tt->sysfs_init && tt->sysfs_init(tdisk))
> +		goto err_sysfs;
> +
>  	t->type = tt;
>  	t->disk = tdisk;
>  	t->dev = tgt_dev;
> @@ -298,6 +301,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>  	mutex_unlock(&dev->mlock);
>  
>  	return 0;
> +err_sysfs:
> +	if (tt->exit)
> +		tt->exit(targetdata);
>  err_init:
>  	put_disk(tdisk);
>  err_queue:
> @@ -320,6 +326,9 @@ static void __nvm_remove_target(struct nvm_target *t)
>  	del_gendisk(tdisk);
>  	blk_cleanup_queue(q);
>  
> +	if (tt->sysfs_exit)
> +		tt->sysfs_exit(tdisk->private_data);

Lets pass gendisk here.

> +
>  	if (tt->exit)
>  		tt->exit(tdisk->private_data);
>  
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index a75d8c0..11c318e 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -440,6 +440,7 @@ typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
>  typedef sector_t (nvm_tgt_capacity_fn)(void *);
>  typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *);
>  typedef void (nvm_tgt_exit_fn)(void *);
> +typedef int (nvm_tgt_sysfs_init_fn)(struct gendisk *);
>  
>  struct nvm_tgt_type {
>  	const char *name;
> @@ -453,6 +454,10 @@ struct nvm_tgt_type {
>  	nvm_tgt_init_fn *init;
>  	nvm_tgt_exit_fn *exit;
>  
> +	/* sysfs */
> +	nvm_tgt_sysfs_init_fn *sysfs_init;
> +	nvm_tgt_exit_fn *sysfs_exit;

Might as well typedef an exit for synergy.

> +
>  	/* For internal use */
>  	struct list_head list;
>  };
> 

Thanks. Applied. I have made the above modifications.
