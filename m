Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33125 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdA3KuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2017 05:50:11 -0500
Received: by mail-wm0-f48.google.com with SMTP id t18so9311008wmt.0
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2017 02:50:10 -0800 (PST)
Subject: Re: [PATCH] lightnvm: free properly on target creation error
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1485446259-2396-1-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <2d46b6b6-4339-a51d-a3fb-1de70b48fe82@lightnvm.io>
Date: Mon, 30 Jan 2017 11:19:31 +0100
MIME-Version: 1.0
In-Reply-To: <1485446259-2396-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/26/2017 04:57 PM, Javier González wrote:
> Fix a memory leak when target creation fails. More specifically, free
> the entire device structure given to the target (tgt_dev).
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 8baae61..d5bb5e1 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -309,7 +309,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>  err_queue:
>  	blk_cleanup_queue(tqueue);
>  err_dev:
> -	kfree(tgt_dev);
> +	nvm_remove_tgt_dev(tgt_dev);
>  err_t:
>  	kfree(t);
>  err_reserve:
> 

Thanks. Applied.
