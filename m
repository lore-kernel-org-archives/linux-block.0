Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35635 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbdDKKl3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 06:41:29 -0400
Received: by mail-wr0-f182.google.com with SMTP id o21so137635973wrb.2
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 03:41:28 -0700 (PDT)
Subject: Re: [PATCH 2/4] lightnvm: fix cleanup order of disk on init error
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1491589874-26818-1-git-send-email-javier@cnexlabs.com>
 <1491589874-26818-2-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a4dede60-3492-895e-f0c2-0edbeb4c338b@lightnvm.io>
Date: Tue, 11 Apr 2017 12:41:26 +0200
MIME-Version: 1.0
In-Reply-To: <1491589874-26818-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/07/2017 08:31 PM, Javier González wrote:
> Reorder disk allocation such that the disk structure can be put
> safely.
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index da4c082..28e69a7 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -263,15 +263,15 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>  		goto err_t;
>  	}
>
> +	tdisk = alloc_disk(0);
> +	if (!tdisk)
> +		goto err_dev;
> +
>  	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
>  	if (!tqueue)
> -		goto err_dev;
> +		goto err_disk;
>  	blk_queue_make_request(tqueue, tt->make_rq);
>
> -	tdisk = alloc_disk(0);
> -	if (!tdisk)
> -		goto err_queue;
> -
>  	sprintf(tdisk->disk_name, "%s", create->tgtname);
>  	tdisk->flags = GENHD_FL_EXT_DEVT;
>  	tdisk->major = 0;
> @@ -307,9 +307,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>  	if (tt->exit)
>  		tt->exit(targetdata);
>  err_init:
> -	put_disk(tdisk);
> -err_queue:
>  	blk_cleanup_queue(tqueue);
> +err_disk:
> +	put_disk(tdisk);
>  err_dev:
>  	nvm_remove_tgt_dev(tgt_dev, 0);
>  err_t:
>
Thanks. Applied for 4.12.
