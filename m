Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33301 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdBXRI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2017 12:08:27 -0500
Received: by mail-wm0-f50.google.com with SMTP id t18so9694257wmt.0
        for <linux-block@vger.kernel.org>; Fri, 24 Feb 2017 09:08:26 -0800 (PST)
Subject: Re: [PATCH 3/3] lightnvm: free reverse device map
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1487952846-29476-1-git-send-email-javier@cnexlabs.com>
 <1487952846-29476-3-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <c30a575d-e8e3-6637-cff9-96f9be0de2e1@lightnvm.io>
Date: Fri, 24 Feb 2017 18:08:19 +0100
MIME-Version: 1.0
In-Reply-To: <1487952846-29476-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/24/2017 05:14 PM, Javier González wrote:
> Free the reverse mapping table correctly on target tear down
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/core.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index ca48792..f1cb485 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -413,6 +413,18 @@ static int nvm_register_map(struct nvm_dev *dev)
>  	return -ENOMEM;
>  }
>
> +static void nvm_unregister_map(struct nvm_dev *dev)
> +{
> +	struct nvm_dev_map *rmap = dev->rmap;
> +	int i;
> +
> +	for (i = 0; i < dev->geo.nr_chnls; i++)
> +		kfree(rmap->chnls[i].lun_offs);
> +
> +	kfree(rmap->chnls);
> +	kfree(rmap);
> +}
> +
>  static void nvm_map_to_dev(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
>  {
>  	struct nvm_dev_map *dev_map = tgt_dev->map;
> @@ -994,7 +1006,7 @@ void nvm_free(struct nvm_dev *dev)
>  	if (dev->dma_pool)
>  		dev->ops->destroy_dma_pool(dev->dma_pool);
>
> -	kfree(dev->rmap);
> +	nvm_unregister_map(dev);
>  	kfree(dev->lptbl);
>  	kfree(dev->lun_map);
>  	kfree(dev);
>
Thanks, applied for 4.12.
