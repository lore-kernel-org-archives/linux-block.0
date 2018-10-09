Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38762 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJIQcm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 12:32:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so506624pgq.5
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 02:16:44 -0700 (PDT)
Subject: Re: [PATCH 3/3] lightnvm: pblk: support variable OOB size
To: javier@cnexlabs.com
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <1535537370-10729-4-git-send-email-javier@cnexlabs.com>
 <5298a07e-eecd-4eca-ce0b-a87977d0c298@lightnvm.io>
 <11C8E695-F9C3-4964-B0D7-FFBFD60E7B22@cnexlabs.com>
 <7a9773b4-140a-9362-bf70-ec5b7f80ba9d@intel.com>
 <5DD030E0-99D1-4B44-8B99-77572FE7CF3B@cnexlabs.com>
 <07311c72-b997-cc52-61c9-c03e0644acb4@lightnvm.io>
 <2E501E50-39BB-4CA7-92C3-DF495BE30965@cnexlabs.com>
 <8F77C084-6315-4344-B666-920C94874DCE@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <58138bf5-51d5-9447-e19b-8de385ceda14@lightnvm.io>
Date: Tue, 9 Oct 2018 11:16:38 +0200
MIME-Version: 1.0
In-Reply-To: <8F77C084-6315-4344-B666-920C94874DCE@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/05/2018 02:18 PM, Javier Gonzalez wrote:
>> On 18 Sep 2018, at 10.32, Javier Gonzalez <javier@cnexlabs.com> wrote:
>>
>>> On 18 Sep 2018, at 10.31, Matias Bjørling <mb@lightnvm.io> wrote:
>>>
>>> On 09/18/2018 10:09 AM, Javier Gonzalez wrote:
>>>>> On 11 Sep 2018, at 12.22, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 11.09.2018 11:14, Javier Gonzalez wrote:
>>>>>>> On 10 Sep 2018, at 12.21, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>>>>
>>>>>>> On 08/29/2018 12:09 PM, Javier González wrote:
>>>>>>>> pblk uses 8 bytes in the metadata region area exposed by the device
>>>>>>>> through the out of band area to store the lba mapped to the given
>>>>>>>> physical sector. This is used for recovery purposes. Given that the
>>>>>>>> first generation OCSSD devices exposed 16 bytes, pblk used a hard-coded
>>>>>>>> structure for this purpose.
>>>>>>>> This patch relaxes the 16 bytes assumption and uses the metadata size
>>>>>>>> reported by the device to layout metadata appropriately for the vector
>>>>>>>> commands. This adds support for arbitrary metadata sizes, as long as
>>>>>>>> these are larger than 8 bytes. Note that this patch does not address the
>>>>>>>> case in which the device does not expose an out of band area and that
>>>>>>>> pblk creation will fail in this case.
>>>>>>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>>>>>>> ---
>>>>>>>> drivers/lightnvm/pblk-core.c     | 56 ++++++++++++++++++++++++++++++----------
>>>>>>>> drivers/lightnvm/pblk-init.c     | 14 ++++++++++
>>>>>>>> drivers/lightnvm/pblk-map.c      | 19 +++++++++-----
>>>>>>>> drivers/lightnvm/pblk-read.c     | 55 +++++++++++++++++++++++++--------------
>>>>>>>> drivers/lightnvm/pblk-recovery.c | 34 +++++++++++++++++-------
>>>>>>>> drivers/lightnvm/pblk.h          | 18 ++++++++++---
>>>>>>>> 6 files changed, 143 insertions(+), 53 deletions(-)
>>>>>>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>>>>>>> index a311cc29afd8..d52e0047ae9d 100644
>>>>>>>> --- a/drivers/lightnvm/pblk-core.c
>>>>>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>>>>>> @@ -250,8 +250,20 @@ int pblk_setup_rqd(struct pblk *pblk, struct nvm_rq *rqd, gfp_t mem_flags,
>>>>>>>> 	if (!is_vector)
>>>>>>>> 		return 0;
>>>>>>>> -	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
>>>>>>>> -	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
>>>>>>>> +	if (pblk->dma_shared) {
>>>>>>>> +		rqd->ppa_list = rqd->meta_list + pblk->dma_meta_size;
>>>>>>>> +		rqd->dma_ppa_list = rqd->dma_meta_list + pblk->dma_meta_size;
>>>>>>>> +
>>>>>>>> +		return 0;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	rqd->ppa_list = nvm_dev_dma_alloc(dev->parent, mem_flags,
>>>>>>>> +							&rqd->dma_ppa_list);
>>>>>>>> +	if (!rqd->ppa_list) {
>>>>>>>> +		nvm_dev_dma_free(dev->parent, rqd->meta_list,
>>>>>>>> +							rqd->dma_meta_list);
>>>>>>>> +		return -ENOMEM;
>>>>>>>> +	}
>>>>>>>>    	return 0;
>>>>>>>> }
>>>>>>>> @@ -262,7 +274,11 @@ void pblk_clear_rqd(struct pblk *pblk, struct nvm_rq *rqd)
>>>>>>>>    	if (rqd->meta_list)
>>>>>>>> 		nvm_dev_dma_free(dev->parent, rqd->meta_list,
>>>>>>>> -				rqd->dma_meta_list);
>>>>>>>> +							rqd->dma_meta_list);
>>>>>>>> +
>>>>>>>> +	if (!pblk->dma_shared && rqd->ppa_list)
>>>>>>>> +		nvm_dev_dma_free(dev->parent, rqd->ppa_list,
>>>>>>>> +							rqd->dma_ppa_list);
>>>>>>>> }
>>>>>>>>    /* Caller must guarantee that the request is a valid type */
>>>>>>>> @@ -796,10 +812,12 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
>>>>>>>> 	rqd.is_seq = 1;
>>>>>>>>    	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
>>>>>>>> -		struct pblk_sec_meta *meta_list = rqd.meta_list;
>>>>>>>> +		struct pblk_sec_meta *meta;
>>>>>>>>    		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
>>>>>>>> -		meta_list[i].lba = lba_list[paddr] = addr_empty;
>>>>>>>> +
>>>>>>>> +		meta = sec_meta_index(pblk, rqd.meta_list, i);
>>>>>>>> +		meta->lba = lba_list[paddr] = addr_empty;
>>>>>>>> 	}
>>>>>>>>    	ret = pblk_submit_io_sync_sem(pblk, &rqd);
>>>>>>>> @@ -845,8 +863,17 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>>>>>>>> 	if (!meta_list)
>>>>>>>> 		return -ENOMEM;
>>>>>>>> -	ppa_list = meta_list + pblk_dma_meta_size;
>>>>>>>> -	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
>>>>>>>> +	if (pblk->dma_shared) {
>>>>>>>> +		ppa_list = meta_list + pblk->dma_meta_size;
>>>>>>>> +		dma_ppa_list = dma_meta_list + pblk->dma_meta_size;
>>>>>>>> +	} else {
>>>>>>>> +		ppa_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
>>>>>>>> +							&dma_ppa_list);
>>>>>>>> +		if (!ppa_list) {
>>>>>>>> +			ret = -ENOMEM;
>>>>>>>> +			goto free_meta_list;
>>>>>>>> +		}
>>>>>>>> +	}
>>>>>>>>    next_rq:
>>>>>>>> 	memset(&rqd, 0, sizeof(struct nvm_rq));
>>>>>>>> @@ -858,7 +885,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>>>>>>>> 					l_mg->emeta_alloc_type, GFP_KERNEL);
>>>>>>>> 	if (IS_ERR(bio)) {
>>>>>>>> 		ret = PTR_ERR(bio);
>>>>>>>> -		goto free_rqd_dma;
>>>>>>>> +		goto free_ppa_list;
>>>>>>>> 	}
>>>>>>>>    	bio->bi_iter.bi_sector = 0; /* internal bio */
>>>>>>>> @@ -884,7 +911,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>>>>>>>> 			if (pblk_boundary_paddr_checks(pblk, paddr)) {
>>>>>>>> 				bio_put(bio);
>>>>>>>> 				ret = -EINTR;
>>>>>>>> -				goto free_rqd_dma;
>>>>>>>> +				goto free_ppa_list;
>>>>>>>> 			}
>>>>>>>>    			ppa = addr_to_gen_ppa(pblk, paddr, line_id);
>>>>>>>> @@ -894,7 +921,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>>>>>>>> 		if (pblk_boundary_paddr_checks(pblk, paddr + min)) {
>>>>>>>> 			bio_put(bio);
>>>>>>>> 			ret = -EINTR;
>>>>>>>> -			goto free_rqd_dma;
>>>>>>>> +			goto free_ppa_list;
>>>>>>>> 		}
>>>>>>>>    		for (j = 0; j < min; j++, i++, paddr++)
>>>>>>>> @@ -905,7 +932,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>>>>>>>> 	if (ret) {
>>>>>>>> 		pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
>>>>>>>> 		bio_put(bio);
>>>>>>>> -		goto free_rqd_dma;
>>>>>>>> +		goto free_ppa_list;
>>>>>>>> 	}
>>>>>>>>    	atomic_dec(&pblk->inflight_io);
>>>>>>>> @@ -918,8 +945,11 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>>>>>>>> 	if (left_ppas)
>>>>>>>> 		goto next_rq;
>>>>>>>> -free_rqd_dma:
>>>>>>>> -	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
>>>>>>>> +free_ppa_list:
>>>>>>>> +	if (!pblk->dma_shared)
>>>>>>>> +		nvm_dev_dma_free(dev->parent, ppa_list, dma_ppa_list);
>>>>>>>> +free_meta_list:
>>>>>>>> +	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
>>>>>>>> 	return ret;
>>>>>>>> }
>>>>>>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>>>>>>> index a99854439224..57972156c318 100644
>>>>>>>> --- a/drivers/lightnvm/pblk-init.c
>>>>>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>>>>>> @@ -354,6 +354,20 @@ static int pblk_core_init(struct pblk *pblk)
>>>>>>>> 	struct nvm_geo *geo = &dev->geo;
>>>>>>>> 	int ret, max_write_ppas;
>>>>>>>> +	if (sizeof(struct pblk_sec_meta) > geo->sos) {
>>>>>>>> +		pblk_err(pblk, "OOB area too small. Min %lu bytes (%d)\n",
>>>>>>>> +			(unsigned long)sizeof(struct pblk_sec_meta), geo->sos);
>>>>>>>> +		return -EINTR;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	pblk->dma_ppa_size = (sizeof(u64) * NVM_MAX_VLBA);
>>>>>>>> +	pblk->dma_meta_size = geo->sos * NVM_MAX_VLBA;
>>>>>>>> +
>>>>>>>> +	if (pblk->dma_ppa_size + pblk->dma_meta_size > PAGE_SIZE)
>>>>>>>> +		pblk->dma_shared = false;
>>>>>>>> +	else
>>>>>>>> +		pblk->dma_shared = true;
>>>>>>>> +
>>>>>>>> 	atomic64_set(&pblk->user_wa, 0);
>>>>>>>> 	atomic64_set(&pblk->pad_wa, 0);
>>>>>>>> 	atomic64_set(&pblk->gc_wa, 0);
>>>>>>>> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
>>>>>>>> index dc0efb852475..55fca16d18e4 100644
>>>>>>>> --- a/drivers/lightnvm/pblk-map.c
>>>>>>>> +++ b/drivers/lightnvm/pblk-map.c
>>>>>>>> @@ -25,6 +25,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
>>>>>>>> 			      unsigned int valid_secs)
>>>>>>>> {
>>>>>>>> 	struct pblk_line *line = pblk_line_get_data(pblk);
>>>>>>>> +	struct pblk_sec_meta *meta;
>>>>>>>> 	struct pblk_emeta *emeta;
>>>>>>>> 	struct pblk_w_ctx *w_ctx;
>>>>>>>> 	__le64 *lba_list;
>>>>>>>> @@ -56,6 +57,8 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
>>>>>>>> 		/* ppa to be sent to the device */
>>>>>>>> 		ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
>>>>>>>> +		meta = sec_meta_index(pblk, meta_list, i);
>>>>>>>> +
>>>>>>>> 		/* Write context for target bio completion on write buffer. Note
>>>>>>>> 		 * that the write buffer is protected by the sync backpointer,
>>>>>>>> 		 * and a single writer thread have access to each specific entry
>>>>>>>> @@ -67,14 +70,14 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
>>>>>>>> 			kref_get(&line->ref);
>>>>>>>> 			w_ctx = pblk_rb_w_ctx(&pblk->rwb, sentry + i);
>>>>>>>> 			w_ctx->ppa = ppa_list[i];
>>>>>>>> -			meta_list[i].lba = cpu_to_le64(w_ctx->lba);
>>>>>>>> +			meta->lba = cpu_to_le64(w_ctx->lba);
>>>>>>>> 			lba_list[paddr] = cpu_to_le64(w_ctx->lba);
>>>>>>>> 			if (lba_list[paddr] != addr_empty)
>>>>>>>> 				line->nr_valid_lbas++;
>>>>>>>> 			else
>>>>>>>> 				atomic64_inc(&pblk->pad_wa);
>>>>>>>> 		} else {
>>>>>>>> -			lba_list[paddr] = meta_list[i].lba = addr_empty;
>>>>>>>> +			lba_list[paddr] = meta->lba = addr_empty;
>>>>>>>> 			__pblk_map_invalidate(pblk, line, paddr);
>>>>>>>> 		}
>>>>>>>> 	}
>>>>>>>> @@ -87,7 +90,7 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
>>>>>>>> 		 unsigned long *lun_bitmap, unsigned int valid_secs,
>>>>>>>> 		 unsigned int off)
>>>>>>>> {
>>>>>>>> -	struct pblk_sec_meta *meta_list = rqd->meta_list;
>>>>>>>> +	struct pblk_sec_meta *meta_list;
>>>>>>>> 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
>>>>>>>> 	unsigned int map_secs;
>>>>>>>> 	int min = pblk->min_write_pgs;
>>>>>>>> @@ -95,8 +98,10 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
>>>>>>>>    	for (i = off; i < rqd->nr_ppas; i += min) {
>>>>>>>> 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
>>>>>>>> +		meta_list = sec_meta_index(pblk, rqd->meta_list, i);
>>>>>>>> +
>>>>>>>> 		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
>>>>>>>> -					lun_bitmap, &meta_list[i], map_secs)) {
>>>>>>>> +					lun_bitmap, meta_list, map_secs)) {
>>>>>>>> 			bio_put(rqd->bio);
>>>>>>>> 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
>>>>>>>> 			pblk_pipeline_stop(pblk);
>>>>>>>> @@ -112,8 +117,8 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>> 	struct nvm_tgt_dev *dev = pblk->dev;
>>>>>>>> 	struct nvm_geo *geo = &dev->geo;
>>>>>>>> 	struct pblk_line_meta *lm = &pblk->lm;
>>>>>>>> -	struct pblk_sec_meta *meta_list = rqd->meta_list;
>>>>>>>> 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
>>>>>>>> +	struct pblk_sec_meta *meta_list;
>>>>>>>> 	struct pblk_line *e_line, *d_line;
>>>>>>>> 	unsigned int map_secs;
>>>>>>>> 	int min = pblk->min_write_pgs;
>>>>>>>> @@ -121,8 +126,10 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>>    	for (i = 0; i < rqd->nr_ppas; i += min) {
>>>>>>>> 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
>>>>>>>> +		meta_list = sec_meta_index(pblk, rqd->meta_list, i);
>>>>>>>> +
>>>>>>>> 		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
>>>>>>>> -					lun_bitmap, &meta_list[i], map_secs)) {
>>>>>>>> +					lun_bitmap, meta_list, map_secs)) {
>>>>>>>> 			bio_put(rqd->bio);
>>>>>>>> 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
>>>>>>>> 			pblk_pipeline_stop(pblk);
>>>>>>>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>>>>>>>> index 57d3155ef9a5..12b690e2abd9 100644
>>>>>>>> --- a/drivers/lightnvm/pblk-read.c
>>>>>>>> +++ b/drivers/lightnvm/pblk-read.c
>>>>>>>> @@ -42,7 +42,6 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>> 				 struct bio *bio, sector_t blba,
>>>>>>>> 				 unsigned long *read_bitmap)
>>>>>>>> {
>>>>>>>> -	struct pblk_sec_meta *meta_list = rqd->meta_list;
>>>>>>>> 	struct ppa_addr ppas[NVM_MAX_VLBA];
>>>>>>>> 	int nr_secs = rqd->nr_ppas;
>>>>>>>> 	bool advanced_bio = false;
>>>>>>>> @@ -51,13 +50,16 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>> 	pblk_lookup_l2p_seq(pblk, ppas, blba, nr_secs);
>>>>>>>>    	for (i = 0; i < nr_secs; i++) {
>>>>>>>> +		struct pblk_sec_meta *meta;
>>>>>>>> 		struct ppa_addr p = ppas[i];
>>>>>>>> 		sector_t lba = blba + i;
>>>>>>>> +		meta = sec_meta_index(pblk, rqd->meta_list, i);
>>>>>>>> retry:
>>>>>>>> 		if (pblk_ppa_empty(p)) {
>>>>>>>> 			WARN_ON(test_and_set_bit(i, read_bitmap));
>>>>>>>> -			meta_list[i].lba = cpu_to_le64(ADDR_EMPTY);
>>>>>>>> +
>>>>>>>> +			meta->lba = cpu_to_le64(ADDR_EMPTY);
>>>>>>>>    			if (unlikely(!advanced_bio)) {
>>>>>>>> 				bio_advance(bio, (i) * PBLK_EXPOSED_PAGE_SIZE);
>>>>>>>> @@ -77,7 +79,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>> 				goto retry;
>>>>>>>> 			}
>>>>>>>> 			WARN_ON(test_and_set_bit(i, read_bitmap));
>>>>>>>> -			meta_list[i].lba = cpu_to_le64(lba);
>>>>>>>> +			meta->lba = cpu_to_le64(lba);
>>>>>>>> 			advanced_bio = true;
>>>>>>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>>>>>>> 			atomic_long_inc(&pblk->cache_reads);
>>>>>>>> @@ -104,12 +106,15 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>> static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>> 				sector_t blba)
>>>>>>>> {
>>>>>>>> -	struct pblk_sec_meta *meta_lba_list = rqd->meta_list;
>>>>>>>> 	int nr_lbas = rqd->nr_ppas;
>>>>>>>> 	int i;
>>>>>>>>    	for (i = 0; i < nr_lbas; i++) {
>>>>>>>> -		u64 lba = le64_to_cpu(meta_lba_list[i].lba);
>>>>>>>> +		struct pblk_sec_meta *meta;
>>>>>>>> +		u64 lba;
>>>>>>>> +
>>>>>>>> +		meta = sec_meta_index(pblk, rqd->meta_list, i);
>>>>>>>> +		lba = le64_to_cpu(meta->lba);
>>>>>>>>    		if (lba == ADDR_EMPTY)
>>>>>>>> 			continue;
>>>>>>>> @@ -133,17 +138,18 @@ static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>> static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>> 				 u64 *lba_list, int nr_lbas)
>>>>>>>> {
>>>>>>>> -	struct pblk_sec_meta *meta_lba_list = rqd->meta_list;
>>>>>>>> 	int i, j;
>>>>>>>>    	for (i = 0, j = 0; i < nr_lbas; i++) {
>>>>>>>> +		struct pblk_sec_meta *meta;
>>>>>>>> 		u64 lba = lba_list[i];
>>>>>>>> 		u64 meta_lba;
>>>>>>>>    		if (lba == ADDR_EMPTY)
>>>>>>>> 			continue;
>>>>>>>> -		meta_lba = le64_to_cpu(meta_lba_list[j].lba);
>>>>>>>> +		meta = sec_meta_index(pblk, rqd->meta_list, j);
>>>>>>>> +		meta_lba = le64_to_cpu(meta->lba);
>>>>>>>>    		if (lba != meta_lba) {
>>>>>>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>>>>>>> @@ -218,7 +224,7 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>>>>>>>> 	struct bio *new_bio = rqd->bio;
>>>>>>>> 	struct bio *bio = pr_ctx->orig_bio;
>>>>>>>> 	struct bio_vec src_bv, dst_bv;
>>>>>>>> -	struct pblk_sec_meta *meta_list = rqd->meta_list;
>>>>>>>> +	struct pblk_sec_meta *meta;
>>>>>>>> 	int bio_init_idx = pr_ctx->bio_init_idx;
>>>>>>>> 	unsigned long *read_bitmap = pr_ctx->bitmap;
>>>>>>>> 	int nr_secs = pr_ctx->orig_nr_secs;
>>>>>>>> @@ -237,12 +243,13 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>>>>>>>> 	}
>>>>>>>>    	/* Re-use allocated memory for intermediate lbas */
>>>>>>>> -	lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
>>>>>>>> -	lba_list_media = (((void *)rqd->ppa_list) + 2 * pblk_dma_ppa_size);
>>>>>>>> +	lba_list_mem = (((void *)rqd->ppa_list) + pblk->dma_ppa_size);
>>>>>>>> +	lba_list_media = (((void *)rqd->ppa_list) + 2 * pblk->dma_ppa_size);
>>>>>>>>    	for (i = 0; i < nr_secs; i++) {
>>>>>>>> -		lba_list_media[i] = meta_list[i].lba;
>>>>>>>> -		meta_list[i].lba = lba_list_mem[i];
>>>>>>>> +		meta = sec_meta_index(pblk, rqd->meta_list, i);
>>>>>>>> +		lba_list_media[i] = meta->lba;
>>>>>>>> +		meta->lba = lba_list_mem[i];
>>>>>>>> 	}
>>>>>>>>    	/* Fill the holes in the original bio */
>>>>>>>> @@ -254,7 +261,8 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>>>>>>>> 		line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
>>>>>>>> 		kref_put(&line->ref, pblk_line_put);
>>>>>>>> -		meta_list[hole].lba = lba_list_media[i];
>>>>>>>> +		meta = sec_meta_index(pblk, rqd->meta_list, hole);
>>>>>>>> +		meta->lba = lba_list_media[i];
>>>>>>>>    		src_bv = new_bio->bi_io_vec[i++];
>>>>>>>> 		dst_bv = bio->bi_io_vec[bio_init_idx + hole];
>>>>>>>> @@ -290,8 +298,8 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>> 			    unsigned long *read_bitmap,
>>>>>>>> 			    int nr_holes)
>>>>>>>> {
>>>>>>>> -	struct pblk_sec_meta *meta_list = rqd->meta_list;
>>>>>>>> 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
>>>>>>>> +	struct pblk_sec_meta *meta;
>>>>>>>> 	struct pblk_pr_ctx *pr_ctx;
>>>>>>>> 	struct bio *new_bio, *bio = r_ctx->private;
>>>>>>>> 	__le64 *lba_list_mem;
>>>>>>>> @@ -299,7 +307,7 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>> 	int i;
>>>>>>>>    	/* Re-use allocated memory for intermediate lbas */
>>>>>>>> -	lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
>>>>>>>> +	lba_list_mem = (((void *)rqd->ppa_list) + pblk->dma_ppa_size);
>>>>>>>>    	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
>>>>>>>> @@ -315,8 +323,10 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>> 	if (!pr_ctx)
>>>>>>>> 		goto fail_free_pages;
>>>>>>>> -	for (i = 0; i < nr_secs; i++)
>>>>>>>> -		lba_list_mem[i] = meta_list[i].lba;
>>>>>>>> +	for (i = 0; i < nr_secs; i++) {
>>>>>>>> +		meta = sec_meta_index(pblk, rqd->meta_list, i);
>>>>>>>> +		lba_list_mem[i] = meta->lba;
>>>>>>>> +	}
>>>>>>>>    	new_bio->bi_iter.bi_sector = 0; /* internal bio */
>>>>>>>> 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
>>>>>>>> @@ -382,7 +392,7 @@ static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>> static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
>>>>>>>> 			 sector_t lba, unsigned long *read_bitmap)
>>>>>>>> {
>>>>>>>> -	struct pblk_sec_meta *meta_list = rqd->meta_list;
>>>>>>>> +	struct pblk_sec_meta *meta;
>>>>>>>> 	struct ppa_addr ppa;
>>>>>>>>    	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
>>>>>>>> @@ -394,7 +404,10 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
>>>>>>>> retry:
>>>>>>>> 	if (pblk_ppa_empty(ppa)) {
>>>>>>>> 		WARN_ON(test_and_set_bit(0, read_bitmap));
>>>>>>>> -		meta_list[0].lba = cpu_to_le64(ADDR_EMPTY);
>>>>>>>> +
>>>>>>>> +		meta = sec_meta_index(pblk, rqd->meta_list, 0);
>>>>>>>> +		meta->lba = cpu_to_le64(ADDR_EMPTY);
>>>>>>>> +
>>>>>>>> 		return;
>>>>>>>> 	}
>>>>>>>> @@ -408,7 +421,9 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
>>>>>>>> 		}
>>>>>>>>    		WARN_ON(test_and_set_bit(0, read_bitmap));
>>>>>>>> -		meta_list[0].lba = cpu_to_le64(lba);
>>>>>>>> +
>>>>>>>> +		meta = sec_meta_index(pblk, rqd->meta_list, 0);
>>>>>>>> +		meta->lba = cpu_to_le64(lba);
>>>>>>>>    #ifdef CONFIG_NVM_PBLK_DEBUG
>>>>>>>> 		atomic_long_inc(&pblk->cache_reads);
>>>>>>>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>>>>>>>> index 8114013c37b8..1ce92562603d 100644
>>>>>>>> --- a/drivers/lightnvm/pblk-recovery.c
>>>>>>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>>>>>>> @@ -157,7 +157,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>>>>>>>> {
>>>>>>>> 	struct nvm_tgt_dev *dev = pblk->dev;
>>>>>>>> 	struct nvm_geo *geo = &dev->geo;
>>>>>>>> -	struct pblk_sec_meta *meta_list;
>>>>>>>> +	struct pblk_sec_meta *meta;
>>>>>>>> 	struct pblk_pad_rq *pad_rq;
>>>>>>>> 	struct nvm_rq *rqd;
>>>>>>>> 	struct bio *bio;
>>>>>>>> @@ -218,8 +218,6 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>>>>>>>> 	rqd->end_io = pblk_end_io_recov;
>>>>>>>> 	rqd->private = pad_rq;
>>>>>>>> -	meta_list = rqd->meta_list;
>>>>>>>> -
>>>>>>>> 	for (i = 0; i < rqd->nr_ppas; ) {
>>>>>>>> 		struct ppa_addr ppa;
>>>>>>>> 		int pos;
>>>>>>>> @@ -241,8 +239,10 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>>>>>>>> 			dev_ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
>>>>>>>>    			pblk_map_invalidate(pblk, dev_ppa);
>>>>>>>> -			lba_list[w_ptr] = meta_list[i].lba = addr_empty;
>>>>>>>> 			rqd->ppa_list[i] = dev_ppa;
>>>>>>>> +
>>>>>>>> +			meta = sec_meta_index(pblk, rqd->meta_list, i);
>>>>>>>> +			lba_list[w_ptr] = meta->lba = addr_empty;
>>>>>>>> 		}
>>>>>>>> 	}
>>>>>>>> @@ -327,7 +327,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>>>>>>>> 	struct nvm_tgt_dev *dev = pblk->dev;
>>>>>>>> 	struct nvm_geo *geo = &dev->geo;
>>>>>>>> 	struct ppa_addr *ppa_list;
>>>>>>>> -	struct pblk_sec_meta *meta_list;
>>>>>>>> +	struct pblk_sec_meta *meta_list, *meta;
>>>>>>>> 	struct nvm_rq *rqd;
>>>>>>>> 	struct bio *bio;
>>>>>>>> 	void *data;
>>>>>>>> @@ -425,7 +425,10 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>>>>>>>> 	}
>>>>>>>>    	for (i = 0; i < rqd->nr_ppas; i++) {
>>>>>>>> -		u64 lba = le64_to_cpu(meta_list[i].lba);
>>>>>>>> +		u64 lba;
>>>>>>>> +
>>>>>>>> +		meta = sec_meta_index(pblk, meta_list, i);
>>>>>>>> +		lba = le64_to_cpu(meta->lba);
>>>>>>>>    		lba_list[paddr++] = cpu_to_le64(lba);
>>>>>>>> @@ -464,13 +467,22 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>>>>>>>> 	if (!meta_list)
>>>>>>>> 		return -ENOMEM;
>>>>>>>> -	ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
>>>>>>>> -	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
>>>>>>>> +	if (pblk->dma_shared) {
>>>>>>>> +		ppa_list = (void *)(meta_list) + pblk->dma_meta_size;
>>>>>>>> +		dma_ppa_list = dma_meta_list + pblk->dma_meta_size;
>>>>>>>> +	} else {
>>>>>>>> +		ppa_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
>>>>>>>> +							&dma_ppa_list);
>>>>>>>> +		if (!ppa_list) {
>>>>>>>> +			ret = -ENOMEM;
>>>>>>>> +			goto free_meta_list;
>>>>>>>> +		}
>>>>>>>> +	}
>>>>>>>>    	data = kcalloc(pblk->max_write_pgs, geo->csecs, GFP_KERNEL);
>>>>>>>> 	if (!data) {
>>>>>>>> 		ret = -ENOMEM;
>>>>>>>> -		goto free_meta_list;
>>>>>>>> +		goto free_ppa_list;
>>>>>>>> 	}
>>>>>>>>    	rqd = mempool_alloc(&pblk->r_rq_pool, GFP_KERNEL);
>>>>>>>> @@ -495,9 +507,11 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>>>>>>>> out:
>>>>>>>> 	mempool_free(rqd, &pblk->r_rq_pool);
>>>>>>>> 	kfree(data);
>>>>>>>> +free_ppa_list:
>>>>>>>> +	if (!pblk->dma_shared)
>>>>>>>> +		nvm_dev_dma_free(dev->parent, ppa_list, dma_ppa_list);
>>>>>>>> free_meta_list:
>>>>>>>> 	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
>>>>>>>> -
>>>>>>>> 	return ret;
>>>>>>>> }
>>>>>>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>>>>>>> index 22cc9bfbbb10..4526fee206d9 100644
>>>>>>>> --- a/drivers/lightnvm/pblk.h
>>>>>>>> +++ b/drivers/lightnvm/pblk.h
>>>>>>>> @@ -86,7 +86,6 @@ enum {
>>>>>>>> };
>>>>>>>>    struct pblk_sec_meta {
>>>>>>>> -	u64 reserved;
>>>>>>>> 	__le64 lba;
>>>>>>>> };
>>>>>>>> @@ -103,9 +102,6 @@ enum {
>>>>>>>> 	PBLK_RL_LOW = 4
>>>>>>>> };
>>>>>>>> -#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * NVM_MAX_VLBA)
>>>>>>>> -#define pblk_dma_ppa_size (sizeof(u64) * NVM_MAX_VLBA)
>>>>>>>> -
>>>>>>>> /* write buffer completion context */
>>>>>>>> struct pblk_c_ctx {
>>>>>>>> 	struct list_head list;		/* Head for out-of-order completion */
>>>>>>>> @@ -637,6 +633,10 @@ struct pblk {
>>>>>>>>    	int sec_per_write;
>>>>>>>> +	int dma_meta_size;
>>>>>>>> +	int dma_ppa_size;
>>>>>>>> +	bool dma_shared;
>>>>>>>> +
>>>>>>>> 	unsigned char instance_uuid[16];
>>>>>>>>    	/* Persistent write amplification counters, 4kb sector I/Os */
>>>>>>>> @@ -985,6 +985,16 @@ static inline void *emeta_to_vsc(struct pblk *pblk, struct line_emeta *emeta)
>>>>>>>> 	return (emeta_to_lbas(pblk, emeta) + pblk->lm.emeta_len[2]);
>>>>>>>> }
>>>>>>>> +static inline struct pblk_sec_meta *sec_meta_index(struct pblk *pblk,
>>>>>>>> +						   struct pblk_sec_meta *meta,
>>>>>>>> +						   int index)
>>>>>>>> +{
>>>>>>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>>>>>>> +	struct nvm_geo *geo = &dev->geo;
>>>>>>>> +
>>>>>>>> +	return ((void *)meta + index * geo->sos);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> static inline int pblk_line_vsc(struct pblk_line *line)
>>>>>>>> {
>>>>>>>> 	return le32_to_cpu(*line->vsc);
>>>>>>>
>>>>>>> It will be helpful to split this patch into two:
>>>>>>>
>>>>>>> - One that does the 8b conversion
>>>>>>> - One that makes the change to merge metadata and ppa list data buffers
>>>>>> pblk has always shared the dma buffer for the ppa list and the metadata
>>>>>> buffer. This patch adds the possibility to not merge if the metadata
>>>>>> size does not fit. I can separate it in 2 patches, but it seems to me
>>>>>> like a natural extension when relaxing the 16byte metadata size.
>>>>>>> - How about making it a simplification to only allow up to 32b
>>>>>>>    metadata buffers, then one doesn't have to think about it crossing
>>>>>>>    multiple pages.
>>>>>> You mean max. 56 bytes of metadata per 4KB right? That is what is left
>>>>>> on a 4KB pages after taking out the 512B needed by the ppa list. It's ok
>>>>>> by me, but I'd like to hear Igor's opinion, as this was Intel's use case
>>>>>> to start with.
>>>>>
>>>>> So I think that if we want to do this properly, we should support
>>>>> 'all' the metadata sizes, including >64K - which is not the case after
>>>>> Javier changes. In the past there were NVMe drives available with 128
>>>>> bytes of metadata per 4K sector, so it could be similar in future too
>>>>> for OC drives. I have somewhere patch which should work for any size
>>>>> of metadata with slightly different approach. I can send it (just need
>>>>> a moment for rebase) and you will decide which approach you would like
>>>>> to take.
>>>>>
>>>>>>> - You can also make a structure for it, use the first 3.5KB for meta,
>>>>>>>    and the next 512B for PPAs.
>>>>>> Looks like a huge structure for just managing a couple of pointers,
>>>>>> don't you think?
>>>>>> Javier
>>>> Matias,
>>>> Can you pick up this patch as is for this window and then Igor can extend
>>>> it to an arbitrary size in the future? We have a use case for 64B OOB /
>>>> 4KB, so 56B / 4KB is not enough in this case. Since pblk currently fixes
>>>> the metadata buffer, the code brakes under this configuration.
>>>> If you have any comments that can respect this requirement, I can apply
>>>> them and resubmit.
>>>
>>> Igor, you said you only needed a moment. It would be better to fix this up the right way, and still make it for this window.
>>
>> If we can make 4.20 then it is fine by me.
>>
>> Thanks,
>> Javier
> 
> Since not much has happened and we are closing on 4.20 PRs, can we take
> this patch for the 4.20 window and extend in the future if necessary?
> 
> Thanks,
> Javier
> 

Hans' comments on breaking the disk format is valid (and applies for 
this patch as well). Let's push this out until Igor's patches are in and 
the disk format updates are in place.
