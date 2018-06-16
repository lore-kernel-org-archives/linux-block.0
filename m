Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44169 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPTdD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jun 2018 15:33:03 -0400
Received: by mail-lf0-f67.google.com with SMTP id p23-v6so7493129lfh.11
        for <linux-block@vger.kernel.org>; Sat, 16 Jun 2018 12:33:02 -0700 (PDT)
Subject: Re: [PATCH 3/5] lightnvm: Flexible DMA pool entry size
To: igor.j.konopko@intel.com, javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, michal.sorn@intel.com,
        marcin.dziegielewski@intel.com
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
 <20180615222706.3801-4-igor.j.konopko@intel.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <26bcfc73-f343-d7f9-3b7c-83be092128d3@lightnvm.io>
Date: Sat, 16 Jun 2018 21:32:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180615222706.3801-4-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/16/2018 12:27 AM, Igor Konopko wrote:
> Currently whole lightnvm and pblk uses single DMA pool,
> for which entry size is always equal to PAGE_SIZE.
> PPA list always needs 8b*64, so there is only 56b*64
> space for OOB meta. Since NVMe OOB meta can be bigger,
> such as 128b, this solution is not robustness.
> 
> This patch add the possiblity to support OOB meta above
> 56b by creating separate DMA pool for PBLK with entry
> size which is big enough to store both PPA list and such
> a OOB metadata.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/core.c          | 33 ++++++++++++++++++++++++---------
>   drivers/lightnvm/pblk-core.c     | 24 +++++++++++++-----------
>   drivers/lightnvm/pblk-init.c     |  9 +++++++++
>   drivers/lightnvm/pblk-read.c     | 40 +++++++++++++++++++++++++++-------------
>   drivers/lightnvm/pblk-recovery.c | 18 ++++++++++--------
>   drivers/lightnvm/pblk-write.c    |  8 ++++----
>   drivers/lightnvm/pblk.h          | 11 ++++++++++-
>   drivers/nvme/host/lightnvm.c     |  6 ++++--
>   include/linux/lightnvm.h         |  8 +++++---
>   9 files changed, 106 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 60aa7bc5a630..bc8e6ecea083 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -642,20 +642,33 @@ void nvm_unregister_tgt_type(struct nvm_tgt_type *tt)
>   }
>   EXPORT_SYMBOL(nvm_unregister_tgt_type);
>   
> -void *nvm_dev_dma_alloc(struct nvm_dev *dev, gfp_t mem_flags,
> -							dma_addr_t *dma_handler)
> +void *nvm_dev_dma_alloc(struct nvm_dev *dev, void *pool,
> +				gfp_t mem_flags, dma_addr_t *dma_handler)
>   {
> -	return dev->ops->dev_dma_alloc(dev, dev->dma_pool, mem_flags,
> -								dma_handler);
> +	return dev->ops->dev_dma_alloc(dev, pool ?: dev->dma_pool,
> +						mem_flags, dma_handler);

Nitpick. Let's pass in dev->dma_pool in that case. So we don't need to 
if it here.

>   }
>   EXPORT_SYMBOL(nvm_dev_dma_alloc);
>   
> -void nvm_dev_dma_free(struct nvm_dev *dev, void *addr, dma_addr_t dma_handler)
> +void nvm_dev_dma_free(struct nvm_dev *dev, void *pool,
> +				void *addr, dma_addr_t dma_handler)
>   {
> -	dev->ops->dev_dma_free(dev->dma_pool, addr, dma_handler);
> +	dev->ops->dev_dma_free(pool ?: dev->dma_pool, addr, dma_handler);
>   }
>   EXPORT_SYMBOL(nvm_dev_dma_free);

Sa,e-

>   
> +void *nvm_dev_dma_create(struct nvm_dev *dev, int size, char *name)
> +{
> +	return dev->ops->create_dma_pool(dev, name, size);
> +}
> +EXPORT_SYMBOL(nvm_dev_dma_create);
> +
> +void nvm_dev_dma_destroy(struct nvm_dev *dev, void *pool)
> +{
> +	dev->ops->destroy_dma_pool(pool);
> +}
> +EXPORT_SYMBOL(nvm_dev_dma_destroy);
> +

Let's make these _GPL.

>   static struct nvm_dev *nvm_find_nvm_dev(const char *name)
>   {
>   	struct nvm_dev *dev;
> @@ -683,7 +696,8 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
>   	}
>   
>   	rqd->nr_ppas = nr_ppas;
> -	rqd->ppa_list = nvm_dev_dma_alloc(dev, GFP_KERNEL, &rqd->dma_ppa_list);
> +	rqd->ppa_list = nvm_dev_dma_alloc(dev, NULL, GFP_KERNEL,
> +						&rqd->dma_ppa_list);
>   	if (!rqd->ppa_list) {
>   		pr_err("nvm: failed to allocate dma memory\n");
>   		return -ENOMEM;
> @@ -709,7 +723,8 @@ static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
>   	if (!rqd->ppa_list)
>   		return;
>   
> -	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
> +	nvm_dev_dma_free(tgt_dev->parent, NULL, rqd->ppa_list,
> +				rqd->dma_ppa_list);
>   }
>   
>   int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct nvm_chk_meta *meta,
> @@ -933,7 +948,7 @@ int nvm_register(struct nvm_dev *dev)
>   	if (!dev->q || !dev->ops)
>   		return -EINVAL;
>   
> -	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
> +	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist", PAGE_SIZE);
>   	if (!dev->dma_pool) {
>   		pr_err("nvm: could not create dma pool\n");
>   		return -ENOMEM;
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 8a0ac466872f..c092ee93a18d 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -279,7 +279,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
>   	}
>   
>   	if (rqd->meta_list)
> -		nvm_dev_dma_free(dev->parent, rqd->meta_list,
> +		nvm_dev_dma_free(dev->parent, pblk->dma_pool, rqd->meta_list,
>   				rqd->dma_meta_list);
>   	mempool_free(rqd, pool);
>   }
> @@ -652,13 +652,13 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
>   	} else
>   		return -EINVAL;
>   
> -	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> -							&dma_meta_list);
> +	meta_list = nvm_dev_dma_alloc(dev->parent, pblk->dma_pool,
> +					GFP_KERNEL, &dma_meta_list);
>   	if (!meta_list)
>   		return -ENOMEM;
>   
> -	ppa_list = meta_list + pblk_dma_meta_size;
> -	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
> +	ppa_list = meta_list + pblk_dma_meta_size(pblk);
> +	dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
>   
>   next_rq:
>   	memset(&rqd, 0, sizeof(struct nvm_rq));
> @@ -758,7 +758,8 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
>   	if (left_ppas)
>   		goto next_rq;
>   free_rqd_dma:
> -	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
> +	nvm_dev_dma_free(dev->parent, pblk->dma_pool, rqd.meta_list,
> +						rqd.dma_meta_list);
>   	return ret;
>   }
>   
> @@ -803,13 +804,13 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>   
>   	memset(&rqd, 0, sizeof(struct nvm_rq));
>   
> -	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> -							&rqd.dma_meta_list);
> +	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, pblk->dma_pool,
> +						GFP_KERNEL, &rqd.dma_meta_list);
>   	if (!rqd.meta_list)
>   		return -ENOMEM;
>   
> -	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
> -	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
> +	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size(pblk);
> +	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size(pblk);
>   
>   	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
>   	if (IS_ERR(bio)) {
> @@ -861,7 +862,8 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>   	}
>   
>   free_ppa_list:
> -	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
> +	nvm_dev_dma_free(dev->parent, pblk->dma_pool, rqd.meta_list,
> +						rqd.dma_meta_list);
>   
>   	return ret;
>   }
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index aa2426403171..f05112230a52 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1142,6 +1142,7 @@ static void pblk_free(struct pblk *pblk)
>   	pblk_l2p_free(pblk);
>   	pblk_rwb_free(pblk);
>   	pblk_core_free(pblk);
> +	nvm_dev_dma_destroy(pblk->dev->parent, pblk->dma_pool);
>   
>   	kfree(pblk);
>   }
> @@ -1212,6 +1213,13 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>   	pblk->disk = tdisk;
>   	pblk->state = PBLK_STATE_RUNNING;
>   	pblk->gc.gc_enabled = 0;
> +	pblk->dma_pool = nvm_dev_dma_create(dev->parent, (pblk_dma_ppa_size +
> +						pblk_dma_meta_size(pblk)),
> +						tdisk->disk_name);
> +	if (!pblk->dma_pool) {
> +		kfree(pblk);
> +		return ERR_PTR(-ENOMEM);
> +	}
>   
>   	spin_lock_init(&pblk->resubmit_lock);
>   	spin_lock_init(&pblk->trans_lock);
> @@ -1312,6 +1320,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>   fail_free_core:
>   	pblk_core_free(pblk);
>   fail:
> +	nvm_dev_dma_destroy(dev->parent, pblk->dma_pool);
>   	kfree(pblk);
>   	return ERR_PTR(ret);
>   }
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 81cf79ea2dc6..9ff4f48c4168 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -255,9 +255,13 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
>   	int nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
>   	int i, ret, hole;
>   
> -	/* Re-use allocated memory for intermediate lbas */
> -	lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
> -	lba_list_media = (((void *)rqd->ppa_list) + 2 * pblk_dma_ppa_size);
> +	lba_list_mem = kcalloc(nr_secs, sizeof(__le64), GFP_KERNEL);
> +	if (!lba_list_mem)
> +		goto err_alloc_mem;
> +
> +	lba_list_media = kcalloc(nr_secs, sizeof(__le64), GFP_KERNEL);
> +	if (!lba_list_media)
> +		goto err_alloc_media;
>   
>   	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
>   
> @@ -349,6 +353,8 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
>   	rqd->bio = NULL;
>   	rqd->nr_ppas = nr_secs;
>   
> +	kfree(lba_list_media);
> +	kfree(lba_list_mem);
>   	__pblk_end_io_read(pblk, rqd, false);
>   	return NVM_IO_DONE;
>   
> @@ -356,6 +362,10 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
>   	/* Free allocated pages in new bio */
>   	pblk_bio_free_pages(pblk, new_bio, 0, new_bio->bi_vcnt);
>   fail_add_pages:
> +	kfree(lba_list_media);
> +err_alloc_media:
> +	kfree(lba_list_mem);
> +err_alloc_mem:
>   	pr_err("pblk: failed to perform partial read\n");
>   	__pblk_end_io_read(pblk, rqd, false);
>   	return NVM_IO_ERR;
> @@ -444,16 +454,17 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>   	 */
>   	bio_init_idx = pblk_get_bi_idx(bio);
>   
> -	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> -							&rqd->dma_meta_list);
> +	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, pblk->dma_pool,
> +					GFP_KERNEL, &rqd->dma_meta_list);
>   	if (!rqd->meta_list) {
>   		pr_err("pblk: not able to allocate ppa list\n");
>   		goto fail_rqd_free;
>   	}
>   
>   	if (nr_secs > 1) {
> -		rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
> -		rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
> +		rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size(pblk);
> +		rqd->dma_ppa_list = rqd->dma_meta_list +
> +					pblk_dma_meta_size(pblk);
>   
>   		pblk_read_ppalist_rq(pblk, rqd, bio, blba, &read_bitmap);
>   	} else {
> @@ -578,14 +589,15 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
>   
>   	memset(&rqd, 0, sizeof(struct nvm_rq));
>   
> -	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> -							&rqd.dma_meta_list);
> +	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, pblk->dma_pool,
> +						GFP_KERNEL, &rqd.dma_meta_list);
>   	if (!rqd.meta_list)
>   		return -ENOMEM;
>   
>   	if (gc_rq->nr_secs > 1) {
> -		rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
> -		rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
> +		rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size(pblk);
> +		rqd.dma_ppa_list = rqd.dma_meta_list +
> +					pblk_dma_meta_size(pblk);
>   
>   		gc_rq->secs_to_gc = read_ppalist_rq_gc(pblk, &rqd, gc_rq->line,
>   							gc_rq->lba_list,
> @@ -642,12 +654,14 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
>   #endif
>   
>   out:
> -	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
> +	nvm_dev_dma_free(dev->parent, pblk->dma_pool, rqd.meta_list,
> +						rqd.dma_meta_list);
>   	return ret;
>   
>   err_free_bio:
>   	bio_put(bio);
>   err_free_dma:
> -	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
> +	nvm_dev_dma_free(dev->parent, pblk->dma_pool, rqd.meta_list,
> +						rqd.dma_meta_list);
>   	return ret;
>   }
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 0007e8011476..f5853fc77a0c 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -280,14 +280,15 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
>   
>   	rq_len = rq_ppas * geo->csecs;
>   
> -	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
> +	meta_list = nvm_dev_dma_alloc(dev->parent, pblk->dma_pool,
> +					 GFP_KERNEL, &dma_meta_list);
>   	if (!meta_list) {
>   		ret = -ENOMEM;
>   		goto fail_free_pad;
>   	}
>   
> -	ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
> -	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
> +	ppa_list = (void *)(meta_list) + pblk_dma_meta_size(pblk);
> +	dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
>   
>   	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
>   						PBLK_VMALLOC_META, GFP_KERNEL);
> @@ -373,7 +374,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
>   fail_free_bio:
>   	bio_put(bio);
>   fail_free_meta:
> -	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
> +	nvm_dev_dma_free(dev->parent, pblk->dma_pool, meta_list, dma_meta_list);
>   fail_free_pad:
>   	kfree(pad_rq);
>   	vfree(data);
> @@ -651,12 +652,13 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>   	dma_addr_t dma_ppa_list, dma_meta_list;
>   	int done, ret = 0;
>   
> -	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
> +	meta_list = nvm_dev_dma_alloc(dev->parent, pblk->dma_pool,
> +					 GFP_KERNEL, &dma_meta_list);
>   	if (!meta_list)
>   		return -ENOMEM;
>   
> -	ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
> -	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
> +	ppa_list = (void *)(meta_list) + pblk_dma_meta_size(pblk);
> +	dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
>   
>   	data = kcalloc(pblk->max_write_pgs, geo->csecs, GFP_KERNEL);
>   	if (!data) {
> @@ -693,7 +695,7 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>   out:
>   	kfree(data);
>   free_meta_list:
> -	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
> +	nvm_dev_dma_free(dev->parent, pblk->dma_pool, meta_list, dma_meta_list);
>   
>   	return ret;
>   }
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 5f44df999aed..6552db35f916 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -306,13 +306,13 @@ static int pblk_alloc_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
>   	rqd->private = pblk;
>   	rqd->end_io = end_io;
>   
> -	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> -							&rqd->dma_meta_list);
> +	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, pblk->dma_pool,
> +					GFP_KERNEL, &rqd->dma_meta_list);
>   	if (!rqd->meta_list)
>   		return -ENOMEM;
>   
> -	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
> -	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
> +	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size(pblk);
> +	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size(pblk);
>   
>   	return 0;
>   }
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 27658dc6fc1a..4c61ede5b207 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -98,7 +98,6 @@ enum {
>   	PBLK_RL_LOW = 4
>   };
>   
> -#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * PBLK_MAX_REQ_ADDRS)
>   #define pblk_dma_ppa_size (sizeof(u64) * PBLK_MAX_REQ_ADDRS)
>   
>   /* write buffer completion context */
> @@ -690,6 +689,7 @@ struct pblk {
>   	struct timer_list wtimer;
>   
>   	struct pblk_gc gc;
> +	void *dma_pool;
>   };
>   
>   struct pblk_line_ws {
> @@ -1448,4 +1448,13 @@ static inline struct pblk_sec_meta *pblk_get_meta_at(struct pblk *pblk,
>   		 */
>   		return meta_ptr + sizeof(struct pblk_sec_meta) * index;
>   }
> +
> +static inline int pblk_dma_meta_size(struct pblk *pblk)
> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +
> +	return max(((int)sizeof(struct pblk_sec_meta)), ((int)geo->sos))
> +				* PBLK_MAX_REQ_ADDRS;
> +}
>   #endif /* PBLK_H_ */
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 006d09e0af74..670478abc754 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -729,11 +729,13 @@ static int nvme_nvm_submit_io_sync(struct nvm_dev *dev, struct nvm_rq *rqd)
>   	return ret;
>   }
>   
> -static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name)
> +static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name,
> +					int size)
>   {
>   	struct nvme_ns *ns = nvmdev->q->queuedata;
>   
> -	return dma_pool_create(name, ns->ctrl->dev, PAGE_SIZE, PAGE_SIZE, 0);
> +	size = round_up(size, PAGE_SIZE);
> +	return dma_pool_create(name, ns->ctrl->dev, size, PAGE_SIZE, 0);
>   }
>   
>   static void nvme_nvm_destroy_dma_pool(void *pool)
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index e9e0d1c7eaf5..72a55d71917e 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -90,7 +90,7 @@ typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, struct nvm_chk_meta *,
>   								sector_t, int);
>   typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
>   typedef int (nvm_submit_io_sync_fn)(struct nvm_dev *, struct nvm_rq *);
> -typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *);
> +typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, int);
>   typedef void (nvm_destroy_dma_pool_fn)(void *);
>   typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
>   								dma_addr_t *);
> @@ -517,8 +517,10 @@ struct nvm_tgt_type {
>   extern int nvm_register_tgt_type(struct nvm_tgt_type *);
>   extern void nvm_unregister_tgt_type(struct nvm_tgt_type *);
>   
> -extern void *nvm_dev_dma_alloc(struct nvm_dev *, gfp_t, dma_addr_t *);
> -extern void nvm_dev_dma_free(struct nvm_dev *, void *, dma_addr_t);
> +extern void *nvm_dev_dma_alloc(struct nvm_dev *, void *, gfp_t, dma_addr_t *);
> +extern void nvm_dev_dma_free(struct nvm_dev *, void *, void *, dma_addr_t);
> +extern void *nvm_dev_dma_create(struct nvm_dev *, int, char *);
> +extern void nvm_dev_dma_destroy(struct nvm_dev *, void *);
>   
>   extern struct nvm_dev *nvm_alloc_dev(int);
>   extern int nvm_register(struct nvm_dev *);
> 

Looks good to me.
