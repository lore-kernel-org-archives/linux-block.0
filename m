Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37578 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754038AbdDKKmH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 06:42:07 -0400
Received: by mail-wm0-f48.google.com with SMTP id u2so57660009wmu.0
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 03:42:07 -0700 (PDT)
Subject: Re: [PATCH 4/4] lightnvm: allow to init targets on factory mode
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1491589874-26818-1-git-send-email-javier@cnexlabs.com>
 <1491589874-26818-4-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4db98bd7-0dc5-0520-6031-df383ed44156@lightnvm.io>
Date: Tue, 11 Apr 2017 12:41:59 +0200
MIME-Version: 1.0
In-Reply-To: <1491589874-26818-4-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/07/2017 08:31 PM, Javier González wrote:
> Target initialization has two responsibilities: creating the target
> partition and instantiating the target. This patch enables to create a
> factory partition (e.g., do not trigger recovery on the given target).
> This is useful for target development and for being able to restore the
> device state at any moment in time without requiring a full-device
> erase.
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/core.c       | 14 +++++++++++---
>  drivers/lightnvm/rrpc.c       |  3 ++-
>  include/linux/lightnvm.h      |  3 ++-
>  include/uapi/linux/lightnvm.h |  4 ++++
>  4 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 28e69a7..e4530c2 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -279,7 +279,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>  	tdisk->fops = &nvm_fops;
>  	tdisk->queue = tqueue;
>
> -	targetdata = tt->init(tgt_dev, tdisk);
> +	targetdata = tt->init(tgt_dev, tdisk, create->flags);
>  	if (IS_ERR(targetdata))
>  		goto err_init;
>
> @@ -1243,8 +1243,16 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
>  	create.tgtname[DISK_NAME_LEN - 1] = '\0';
>
>  	if (create.flags != 0) {
> -		pr_err("nvm: no flags supported\n");
> -		return -EINVAL;
> +		__u32 flags = create.flags;
> +
> +		/* Check for valid flags */
> +		if (flags & NVM_TARGET_FACTORY)
> +			flags &= ~NVM_TARGET_FACTORY;
> +
> +		if (flags) {
> +			pr_err("nvm: flag not supported\n");
> +			return -EINVAL;
> +		}
>  	}
>
>  	return __nvm_configure_create(&create);
> diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
> index 4e4c299..2c04ff3 100644
> --- a/drivers/lightnvm/rrpc.c
> +++ b/drivers/lightnvm/rrpc.c
> @@ -1515,7 +1515,8 @@ static int rrpc_luns_configure(struct rrpc *rrpc)
>
>  static struct nvm_tgt_type tt_rrpc;
>
> -static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk)
> +static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
> +		       int flags)
>  {
>  	struct request_queue *bqueue = dev->q;
>  	struct request_queue *tqueue = tdisk->queue;
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index bebea80..e88f7ef 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -436,7 +436,8 @@ static inline int ppa_cmp_blk(struct ppa_addr ppa1, struct ppa_addr ppa2)
>
>  typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
>  typedef sector_t (nvm_tgt_capacity_fn)(void *);
> -typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *);
> +typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
> +				int flags);
>  typedef void (nvm_tgt_exit_fn)(void *);
>  typedef int (nvm_tgt_sysfs_init_fn)(struct gendisk *);
>  typedef void (nvm_tgt_sysfs_exit_fn)(struct gendisk *);
> diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
> index fd19f36..c8aec4b 100644
> --- a/include/uapi/linux/lightnvm.h
> +++ b/include/uapi/linux/lightnvm.h
> @@ -85,6 +85,10 @@ struct nvm_ioctl_create_conf {
>  	};
>  };
>
> +enum {
> +	NVM_TARGET_FACTORY = 1 << 0,	/* Init target in factory mode */
> +};
> +
>  struct nvm_ioctl_create {
>  	char dev[DISK_NAME_LEN];		/* open-channel SSD device */
>  	char tgttype[NVM_TTYPE_NAME_MAX];	/* target type name */
>
Thanks. Applied for 4.12. Feel free to kick the part to Keith in the 
nvme-cli tool.
