Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34005 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbdEDIFG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 04:05:06 -0400
Received: by mail-lf0-f66.google.com with SMTP id q24so580074lfb.1
        for <linux-block@vger.kernel.org>; Thu, 04 May 2017 01:05:01 -0700 (PDT)
Subject: Re: [PATCH 2/2] lightnvm: fix bad back free on error path
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>, mb@lightnvm.io
References: <1493803145-18082-1-git-send-email-javier@cnexlabs.com>
 <1493803145-18082-2-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>,
        Jens Axboe <axboe@fb.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <f3ad881e-c777-0e31-c455-021f6688d4f1@bjorling.me>
Date: Thu, 4 May 2017 10:04:53 +0200
MIME-Version: 1.0
In-Reply-To: <1493803145-18082-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/03/2017 11:19 AM, Javier González wrote:
> Free memory correctly when an allocation fails on a loop and we free
> backwards previously successful allocations.
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 54a06c3a2b8c..6a4aa608ad95 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -74,7 +74,7 @@ static int nvm_reserve_luns(struct nvm_dev *dev, int lun_begin, int lun_end)
>
>  	return 0;
>  err:
> -	while (--i > lun_begin)
> +	while (--i >= lun_begin)
>  		clear_bit(i, dev->lun_map);
>
>  	return -EBUSY;
> @@ -211,7 +211,7 @@ static struct nvm_tgt_dev *nvm_create_tgt_dev(struct nvm_dev *dev,
>
>  	return tgt_dev;
>  err_ch:
> -	while (--i > 0)
> +	while (--i >= 0)
>  		kfree(dev_map->chnls[i].lun_offs);
>  	kfree(luns);
>  err_luns:
>

Reviewed-by: Matias Bjørling <matias@cnexlabs.com>

Jens, and this baby as well? :)
