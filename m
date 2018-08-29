Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40013 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbeH2R0F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 13:26:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id s13-v6so2275787pfi.7
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 06:29:07 -0700 (PDT)
Subject: Re: [PATCH 4/7] lightnvm: pblk: move global caches to module
 init/exit
To: hans.ml.holmberg@owltronix.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1535545414-550-5-git-send-email-hans.ml.holmberg@owltronix.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <92a2b562-c485-47ff-7aa9-5aa82b992e40@lightnvm.io>
Date: Wed, 29 Aug 2018 15:29:02 +0200
MIME-Version: 1.0
In-Reply-To: <1535545414-550-5-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/29/2018 02:23 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> Pblk's global caches should not be initialized every time
> a pblk instance is created, so move the creation and destruction
> of the caches to module init/exit.
> 
> Also remove the global pblk lock as it is no longer needed after
> the move.
> 

The original goal was to not allocate memory for the caches unless a 
pblk instance was initialized. This instead uses up memory without pblk 
being used, which I don't think is a good idea.

> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-init.c | 42 ++++++++++++++++++++----------------------
>   1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 76a4a271b9cf..0be64220b5d8 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -27,7 +27,6 @@ MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
>   
>   static struct kmem_cache *pblk_ws_cache, *pblk_rec_cache, *pblk_g_rq_cache,
>   				*pblk_w_rq_cache;
> -static DECLARE_RWSEM(pblk_lock);
>   struct bio_set pblk_bio_set;
>   
>   static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
> @@ -306,21 +305,17 @@ static int pblk_set_addrf(struct pblk *pblk)
>   	return 0;
>   }
>   
> -static int pblk_init_global_caches(struct pblk *pblk)
> +static int pblk_init_global_caches(void)
>   {
> -	down_write(&pblk_lock);
>   	pblk_ws_cache = kmem_cache_create("pblk_blk_ws",
>   				sizeof(struct pblk_line_ws), 0, 0, NULL);
> -	if (!pblk_ws_cache) {
> -		up_write(&pblk_lock);
> +	if (!pblk_ws_cache)
>   		return -ENOMEM;
> -	}
>   
>   	pblk_rec_cache = kmem_cache_create("pblk_rec",
>   				sizeof(struct pblk_rec_ctx), 0, 0, NULL);
>   	if (!pblk_rec_cache) {
>   		kmem_cache_destroy(pblk_ws_cache);
> -		up_write(&pblk_lock);
>   		return -ENOMEM;
>   	}
>   
> @@ -329,7 +324,6 @@ static int pblk_init_global_caches(struct pblk *pblk)
>   	if (!pblk_g_rq_cache) {
>   		kmem_cache_destroy(pblk_ws_cache);
>   		kmem_cache_destroy(pblk_rec_cache);
> -		up_write(&pblk_lock);
>   		return -ENOMEM;
>   	}
>   
> @@ -339,15 +333,13 @@ static int pblk_init_global_caches(struct pblk *pblk)
>   		kmem_cache_destroy(pblk_ws_cache);
>   		kmem_cache_destroy(pblk_rec_cache);
>   		kmem_cache_destroy(pblk_g_rq_cache);
> -		up_write(&pblk_lock);
>   		return -ENOMEM;
>   	}
> -	up_write(&pblk_lock);
>   
>   	return 0;
>   }
>   
> -static void pblk_free_global_caches(struct pblk *pblk)
> +static void pblk_free_global_caches(void)
>   {
>   	kmem_cache_destroy(pblk_ws_cache);
>   	kmem_cache_destroy(pblk_rec_cache);
> @@ -381,13 +373,10 @@ static int pblk_core_init(struct pblk *pblk)
>   	if (!pblk->pad_dist)
>   		return -ENOMEM;
>   
> -	if (pblk_init_global_caches(pblk))
> -		goto fail_free_pad_dist;
> -
>   	/* Internal bios can be at most the sectors signaled by the device. */
>   	ret = mempool_init_page_pool(&pblk->page_bio_pool, NVM_MAX_VLBA, 0);
>   	if (ret)
> -		goto free_global_caches;
> +		goto free_pad_dist;
>   
>   	ret = mempool_init_slab_pool(&pblk->gen_ws_pool, PBLK_GEN_WS_POOL_SIZE,
>   				     pblk_ws_cache);
> @@ -455,9 +444,7 @@ static int pblk_core_init(struct pblk *pblk)
>   	mempool_exit(&pblk->gen_ws_pool);
>   free_page_bio_pool:
>   	mempool_exit(&pblk->page_bio_pool);
> -free_global_caches:
> -	pblk_free_global_caches(pblk);
> -fail_free_pad_dist:
> +free_pad_dist:
>   	kfree(pblk->pad_dist);
>   	return -ENOMEM;
>   }
> @@ -480,7 +467,6 @@ static void pblk_core_free(struct pblk *pblk)
>   	mempool_exit(&pblk->e_rq_pool);
>   	mempool_exit(&pblk->w_rq_pool);
>   
> -	pblk_free_global_caches(pblk);
>   	kfree(pblk->pad_dist);
>   }
>   
> @@ -1067,7 +1053,6 @@ static void pblk_exit(void *private, bool graceful)
>   {
>   	struct pblk *pblk = private;
>   
> -	down_write(&pblk_lock);
>   	pblk_gc_exit(pblk, graceful);
>   	pblk_tear_down(pblk, graceful);
>   
> @@ -1076,7 +1061,6 @@ static void pblk_exit(void *private, bool graceful)
>   #endif
>   
>   	pblk_free(pblk);
> -	up_write(&pblk_lock);
>   }
>   
>   static sector_t pblk_capacity(void *private)
> @@ -1237,9 +1221,22 @@ static int __init pblk_module_init(void)
>   	ret = bioset_init(&pblk_bio_set, BIO_POOL_SIZE, 0, 0);
>   	if (ret)
>   		return ret;
> +
>   	ret = nvm_register_tgt_type(&tt_pblk);
>   	if (ret)
> -		bioset_exit(&pblk_bio_set);
> +		goto fail_exit_bioset;
> +
> +	ret = pblk_init_global_caches();
> +	if (ret)
> +		goto fail_unregister_tgt_type;
> +
> +	return 0;
> +
> +fail_unregister_tgt_type:
> +	nvm_unregister_tgt_type(&tt_pblk);
> +fail_exit_bioset:
> +	bioset_exit(&pblk_bio_set);
> +
>   	return ret;
>   }
>   
> @@ -1247,6 +1244,7 @@ static void pblk_module_exit(void)
>   {
>   	bioset_exit(&pblk_bio_set);
>   	nvm_unregister_tgt_type(&tt_pblk);
> +	pblk_free_global_caches();
>   }
>   
>   module_init(pblk_module_init);
> 
