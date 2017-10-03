Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr30129.outbound.protection.outlook.com ([40.107.3.129]:29265
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751514AbdJCOEZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Oct 2017 10:04:25 -0400
Subject: Re: [PATCH] lightnvm: pblk: use vfree_atomic when freeing line
 metadata
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <jg@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <1507038524-24587-1-git-send-email-hans.ml.holmberg@owltronix.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <5f64209d-ba28-a642-ed44-66a5eced9a99@virtuozzo.com>
Date: Tue, 3 Oct 2017 17:07:23 +0300
MIME-Version: 1.0
In-Reply-To: <1507038524-24587-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 10/03/2017 04:48 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> The commit bf22e37a6413 ("mm: add vfree_atomic()") made vfree unsafe to
> call in atomic context (unless the call came from an interrupt) and
> introduced vfree_atomic that is safe to call in atomic context.
> 
> So, since we're holding locks when freeing line metadata, we need to
> use the atomic version of vfree.
> 
> Fix this by introducing an atomic variant of pblk_mfree and
> switching to that in pblk_line_meta_free.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> 
> The patch is for:
> https://github.com/OpenChannelSSD/linux branch for-4.15/pblk
> 
>  drivers/lightnvm/pblk-init.c | 3 ++-
>  drivers/lightnvm/pblk.h      | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index c452478..3a191a6 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -396,7 +396,8 @@ static void pblk_line_meta_free(struct pblk *pblk)
>  	spin_lock(&l_mg->free_lock);

What's the point in holding ->free_lock here? It seems like it could be just dropped.

>  	for (i = 0; i < PBLK_DATA_LINES; i++) {
>  		kfree(l_mg->sline_meta[i]);
> -		pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
> +		pblk_mfree_atomic(l_mg->eline_meta[i]->buf,
> +				  l_mg->emeta_alloc_type);
>  		kfree(l_mg->eline_meta[i]);
>  	}
>  	spin_unlock(&l_mg->free_lock);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 03965da..93f98e3 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -881,6 +881,14 @@ static inline void pblk_mfree(void *ptr, int type)
>  		vfree(ptr);
>  }
>  
> +static inline void pblk_mfree_atomic(void *ptr, int type)
> +{
> +	if (type == PBLK_KMALLOC_META)
> +		kfree(ptr);
> +	else
> +		vfree_atomic(ptr);
> +}
> +
>  static inline struct nvm_rq *nvm_rq_from_c_ctx(void *c_ctx)
>  {
>  	return c_ctx - sizeof(struct nvm_rq);
> 
