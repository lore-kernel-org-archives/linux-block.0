Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36706 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbdDKKlZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 06:41:25 -0400
Received: by mail-wm0-f43.google.com with SMTP id o81so59776665wmb.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 03:41:24 -0700 (PDT)
Subject: Re: [PATCH 1/4] lightnvm: double-clear of dev->lun_map on target init
 error
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1491589874-26818-1-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <64c22c5c-9fd0-ffcf-5762-bef15489ee1b@lightnvm.io>
Date: Tue, 11 Apr 2017 12:41:21 +0200
MIME-Version: 1.0
In-Reply-To: <1491589874-26818-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/07/2017 08:31 PM, Javier González wrote:
> The dev->lun_map bits are cleared twice if an target init error occurs.
> First in the target clean routine, and then next in the nvm_tgt_create
> error function. Make sure that it is only cleared once by extending
> nvm_remove_tgt_devi() with a clear bit, such that clearing of bits can
> ignored when cleaning up a successful initialized target.
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
> ---
>  drivers/lightnvm/core.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 2122922..da4c082 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -89,7 +89,7 @@ static void nvm_release_luns_err(struct nvm_dev *dev, int lun_begin,
>  		WARN_ON(!test_and_clear_bit(i, dev->lun_map));
>  }
>
> -static void nvm_remove_tgt_dev(struct nvm_tgt_dev *tgt_dev)
> +static void nvm_remove_tgt_dev(struct nvm_tgt_dev *tgt_dev, int clear)
>  {
>  	struct nvm_dev *dev = tgt_dev->parent;
>  	struct nvm_dev_map *dev_map = tgt_dev->map;
> @@ -100,11 +100,13 @@ static void nvm_remove_tgt_dev(struct nvm_tgt_dev *tgt_dev)
>  		int *lun_offs = ch_map->lun_offs;
>  		int ch = i + ch_map->ch_off;
>
> -		for (j = 0; j < ch_map->nr_luns; j++) {
> -			int lun = j + lun_offs[j];
> -			int lunid = (ch * dev->geo.luns_per_chnl) + lun;
> +		if (clear) {
> +			for (j = 0; j < ch_map->nr_luns; j++) {
> +				int lun = j + lun_offs[j];
> +				int lunid = (ch * dev->geo.luns_per_chnl) + lun;
>
> -			WARN_ON(!test_and_clear_bit(lunid, dev->lun_map));
> +				WARN_ON(!test_and_clear_bit(lunid, dev->lun_map));
> +			}
>  		}
>
>  		kfree(ch_map->lun_offs);
> @@ -309,7 +311,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>  err_queue:
>  	blk_cleanup_queue(tqueue);
>  err_dev:
> -	nvm_remove_tgt_dev(tgt_dev);
> +	nvm_remove_tgt_dev(tgt_dev, 0);
>  err_t:
>  	kfree(t);
>  err_reserve:
> @@ -332,7 +334,7 @@ static void __nvm_remove_target(struct nvm_target *t)
>  	if (tt->exit)
>  		tt->exit(tdisk->private_data);
>
> -	nvm_remove_tgt_dev(t->dev);
> +	nvm_remove_tgt_dev(t->dev, 1);
>  	put_disk(tdisk);
>
>  	list_del(&t->list);
>

Thanks. Applied for 4.12.
