Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35644 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbcEWIc3 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 23 May 2016 04:32:29 -0400
Received: by mail-wm0-f45.google.com with SMTP id a136so8948157wme.0
        for <linux-block@vger.kernel.org>; Mon, 23 May 2016 01:32:28 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: expose mark_blk through core
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1462865126-6044-1-git-send-email-javier@cnexlabs.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	=?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5742C01A.300@lightnvm.io>
Date: Mon, 23 May 2016 10:32:26 +0200
MIME-Version: 1.0
In-Reply-To: <1462865126-6044-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/10/2016 09:25 AM, Javier González wrote:
> Expose mark_blk through the core LightNVM operations to hid the media
> manager, as we do for the rest of the block operations. This is
> necessary for targets to mark a growing bad block as bad before
> returning it to the media manager.
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/core.c  | 6 ++++++
>   include/linux/lightnvm.h | 2 ++
>   2 files changed, 8 insertions(+)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 160c1a6..13993c9 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -210,6 +210,12 @@ void nvm_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
>   }
>   EXPORT_SYMBOL(nvm_put_blk);
>
> +void nvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
> +{
> +	return dev->mt->mark_blk(dev, ppa, type);
> +}
> +EXPORT_SYMBOL(nvm_mark_blk);
> +
>   int nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
>   {
>   	return dev->mt->submit_io(dev, rqd);
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index ef2c7d2..9c56148 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -532,6 +532,8 @@ extern int nvm_register(struct request_queue *, char *,
>   						struct nvm_dev_ops *);
>   extern void nvm_unregister(char *);
>
> +void nvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type);
> +
>   extern int nvm_submit_io(struct nvm_dev *, struct nvm_rq *);
>   extern void nvm_generic_to_addr_mode(struct nvm_dev *, struct nvm_rq *);
>   extern void nvm_addr_to_generic_mode(struct nvm_dev *, struct nvm_rq *);
>

Thanks Javier. Applied for 4.8. I updated the description a bit.
