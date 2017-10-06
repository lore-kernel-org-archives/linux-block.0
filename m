Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-db5eur01on0114.outbound.protection.outlook.com ([104.47.2.114]:63584
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752929AbdJFJR7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Oct 2017 05:17:59 -0400
Subject: Re: [PATCH] lightnvm: pblk: remove spinlock when freeing line
 metadata
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <jg@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <1507192546-12156-1-git-send-email-hans.ml.holmberg@owltronix.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <7960b012-1154-fdad-0c45-c952357f13f5@virtuozzo.com>
Date: Fri, 6 Oct 2017 12:20:56 +0300
MIME-Version: 1.0
In-Reply-To: <1507192546-12156-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/05/2017 11:35 AM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> Lockdep complains about being in atomic context while freeing line
> metadata - and rightly so as we take a spinlock and end up calling
> vfree that might sleep(in pblk_mfree).
> 
> There is no need for holding the line manager free_lock while
> freeing line metadata, so remove the lock.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

I guess this also deserves stable tag. The bug was introduced in 4.13 by
commit 588726d3ec68 ("lightnvm: pblk: fail gracefully on irrec. error").


> ---
> This patch is for:
> https://github.com/OpenChannelSSD/linux branch for-4.15/pblk
> 
>  drivers/lightnvm/pblk-init.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index c452478..a645117 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -393,13 +393,11 @@ static void pblk_line_meta_free(struct pblk *pblk)
>  	kfree(l_mg->bb_aux);
>  	kfree(l_mg->vsc_list);
>  
> -	spin_lock(&l_mg->free_lock);
>  	for (i = 0; i < PBLK_DATA_LINES; i++) {
>  		kfree(l_mg->sline_meta[i]);
>  		pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
>  		kfree(l_mg->eline_meta[i]);
>  	}
> -	spin_unlock(&l_mg->free_lock);
>  
>  	kfree(pblk->lines);
>  }
> 
