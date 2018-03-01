Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44515 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966574AbeCAKpL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Mar 2018 05:45:11 -0500
Received: by mail-lf0-f66.google.com with SMTP id v9so8079359lfa.11
        for <linux-block@vger.kernel.org>; Thu, 01 Mar 2018 02:45:10 -0800 (PST)
Subject: Re: [PATCH 13/15] lightnvm: pblk: implement get log report chunk
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
 <1519832975-25432-14-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <24180126-bb2f-2114-ffbd-4a7fcda218af@lightnvm.io>
Date: Thu, 1 Mar 2018 11:45:06 +0100
MIME-Version: 1.0
In-Reply-To: <1519832975-25432-14-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/28/2018 04:49 PM, Javier González wrote:
> In preparation of pblk supporting 2.0, implement the get log report
> chunk in pblk. Also, define the chunk states as given in the 2.0 spec.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c | 139 +++++++++++++++++++++++----
>   drivers/lightnvm/pblk-init.c | 223 +++++++++++++++++++++++++++++++------------
>   drivers/lightnvm/pblk.h      |   7 ++
>   include/linux/lightnvm.h     |  13 +++
>   4 files changed, 301 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 2e10b18b61e3..cd663855ee88 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -44,11 +44,12 @@ static void pblk_line_mark_bb(struct work_struct *work)
>   }
>   
>   static void pblk_mark_bb(struct pblk *pblk, struct pblk_line *line,
> -			 struct ppa_addr *ppa)
> +			 struct ppa_addr ppa_addr)
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
> -	int pos = pblk_ppa_to_pos(geo, *ppa);
> +	struct ppa_addr *ppa;
> +	int pos = pblk_ppa_to_pos(geo, ppa_addr);
>   
>   	pr_debug("pblk: erase failed: line:%d, pos:%d\n", line->id, pos);
>   	atomic_long_inc(&pblk->erase_failed);
> @@ -58,26 +59,38 @@ static void pblk_mark_bb(struct pblk *pblk, struct pblk_line *line,
>   		pr_err("pblk: attempted to erase bb: line:%d, pos:%d\n",
>   							line->id, pos);
>   
> +	/* Not necessary to mark bad blocks on 2.0 spec. */
> +	if (geo->version == NVM_OCSSD_SPEC_20)
> +		return;
> +
> +	ppa = kmalloc(sizeof(struct ppa_addr), GFP_ATOMIC);
> +	if (!ppa)
> +		return;
> +
> +	*ppa = ppa_addr;
>   	pblk_gen_run_ws(pblk, NULL, ppa, pblk_line_mark_bb,
>   						GFP_ATOMIC, pblk->bb_wq);
>   }
>   
>   static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
>   {
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	struct nvm_chk_meta *chunk;
>   	struct pblk_line *line;
> +	int pos;
>   
>   	line = &pblk->lines[pblk_ppa_to_line(rqd->ppa_addr)];
> +	pos = pblk_ppa_to_pos(geo, rqd->ppa_addr);
> +	chunk = &line->chks[pos];
> +
>   	atomic_dec(&line->left_seblks);
>   
>   	if (rqd->error) {
> -		struct ppa_addr *ppa;
> -
> -		ppa = kmalloc(sizeof(struct ppa_addr), GFP_ATOMIC);
> -		if (!ppa)
> -			return;
> -
> -		*ppa = rqd->ppa_addr;
> -		pblk_mark_bb(pblk, line, ppa);
> +		chunk->state = NVM_CHK_ST_OFFLINE;
> +		pblk_mark_bb(pblk, line, rqd->ppa_addr);
> +	} else {
> +		chunk->state = NVM_CHK_ST_FREE;
>   	}
>   
>   	atomic_dec(&pblk->inflight_io);
> @@ -92,6 +105,50 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
>   	mempool_free(rqd, pblk->e_rq_pool);
>   }
>   
> +/*
> + * Get information for all chunks from the device.
> + *
> + * The caller is responsible for freeing the returned structure
> + */
> +struct nvm_chk_meta *pblk_chunk_get_info(struct pblk *pblk)
> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	struct nvm_chk_meta *meta;
> +	struct ppa_addr ppa;
> +	unsigned long len;
> +	int ret;
> +
> +	ppa.ppa = 0;
> +
> +	len = geo->all_chunks * sizeof(*meta);
> +	meta = kzalloc(len, GFP_KERNEL);
> +	if (!meta)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = nvm_get_chunk_meta(dev, meta, ppa, geo->all_chunks);
> +	if (ret) {
> +		pr_err("pblk: could not get chunk metadata (%d)\n", ret);

The error message can be omitted here. If there is an error, 
nvme_nvm_get_chk_meta will already had barfed.

> +		kfree(meta);
> +		return ERR_PTR(-EIO);
> +	}
> +
> +	return meta;
> +}
> +
> +struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
> +					      struct nvm_chk_meta *meta,
> +					      struct ppa_addr ppa)
> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	int ch_off = ppa.m.grp * geo->num_chk * geo->num_lun;
> +	int lun_off = ppa.m.pu * geo->num_chk;
> +	int chk_off = ppa.m.chk;
> +
> +	return meta + ch_off + lun_off + chk_off;
> +}
> +
>   void __pblk_map_invalidate(struct pblk *pblk, struct pblk_line *line,
>   			   u64 paddr)
>   {
> @@ -1094,10 +1151,34 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
>   	return 1;
>   }
>   
> +static int pblk_prepare_new_line(struct pblk *pblk, struct pblk_line *line)
> +{
> +	struct pblk_line_meta *lm = &pblk->lm;
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	int blk_to_erase = atomic_read(&line->blk_in_line);
> +	int i;
> +
> +	for (i = 0; i < lm->blk_per_line; i++) {
> +		struct pblk_lun *rlun = &pblk->luns[i];
> +		int pos = pblk_ppa_to_pos(geo, rlun->bppa);
> +		int state = line->chks[pos].state;
> +
> +		/* Free chunks should not be erased */
> +		if (state & NVM_CHK_ST_FREE) {
> +			set_bit(pblk_ppa_to_pos(geo, rlun->bppa),
> +							line->erase_bitmap);
> +			blk_to_erase--;
> +		}
> +	}
> +
> +	return blk_to_erase;
> +}
> +
>   static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
>   {
>   	struct pblk_line_meta *lm = &pblk->lm;
> -	int blk_in_line = atomic_read(&line->blk_in_line);
> +	int blk_to_erase;
>   
>   	line->map_bitmap = kzalloc(lm->sec_bitmap_len, GFP_ATOMIC);
>   	if (!line->map_bitmap)
> @@ -1110,7 +1191,21 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
>   		return -ENOMEM;
>   	}
>   
> +	/* Bad blocks do not need to be erased */
> +	bitmap_copy(line->erase_bitmap, line->blk_bitmap, lm->blk_per_line);
> +
>   	spin_lock(&line->lock);
> +
> +	/* If we have not written to this line, we need to mark up free chunks
> +	 * as already erased
> +	 */
> +	if (line->state == PBLK_LINESTATE_NEW) {
> +		blk_to_erase = pblk_prepare_new_line(pblk, line);
> +		line->state = PBLK_LINESTATE_FREE;
> +	} else {
> +		blk_to_erase = atomic_read(&line->blk_in_line);
> +	}
> +
>   	if (line->state != PBLK_LINESTATE_FREE) {
>   		kfree(line->map_bitmap);
>   		kfree(line->invalid_bitmap);
> @@ -1122,15 +1217,12 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
>   
>   	line->state = PBLK_LINESTATE_OPEN;
>   
> -	atomic_set(&line->left_eblks, blk_in_line);
> -	atomic_set(&line->left_seblks, blk_in_line);
> +	atomic_set(&line->left_eblks, blk_to_erase);
> +	atomic_set(&line->left_seblks, blk_to_erase);
>   
>   	line->meta_distance = lm->meta_distance;
>   	spin_unlock(&line->lock);
>   
> -	/* Bad blocks do not need to be erased */
> -	bitmap_copy(line->erase_bitmap, line->blk_bitmap, lm->blk_per_line);
> -
>   	kref_init(&line->ref);
>   
>   	return 0;
> @@ -1586,12 +1678,14 @@ static void pblk_line_should_sync_meta(struct pblk *pblk)
>   
>   void pblk_line_close(struct pblk *pblk, struct pblk_line *line)
>   {
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	struct pblk_line_meta *lm = &pblk->lm;
>   	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>   	struct list_head *move_list;
> +	int i;
>   
>   #ifdef CONFIG_NVM_DEBUG
> -	struct pblk_line_meta *lm = &pblk->lm;
> -
>   	WARN(!bitmap_full(line->map_bitmap, lm->sec_per_line),
>   				"pblk: corrupt closed line %d\n", line->id);
>   #endif
> @@ -1613,6 +1707,15 @@ void pblk_line_close(struct pblk *pblk, struct pblk_line *line)
>   	line->smeta = NULL;
>   	line->emeta = NULL;
>   
> +	for (i = 0; i < lm->blk_per_line; i++) {
> +		struct pblk_lun *rlun = &pblk->luns[i];
> +		int pos = pblk_ppa_to_pos(geo, rlun->bppa);
> +		int state = line->chks[pos].state;
> +
> +		if (!(state & NVM_CHK_ST_OFFLINE))
> +			state = NVM_CHK_ST_CLOSED;
> +	}
> +
>   	spin_unlock(&line->lock);
>   	spin_unlock(&l_mg->gc_lock);
>   }
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 73b221c69cfd..bd2592fc3378 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -401,6 +401,7 @@ static void pblk_line_meta_free(struct pblk_line *line)
>   {
>   	kfree(line->blk_bitmap);
>   	kfree(line->erase_bitmap);
> +	kfree(line->chks);
>   }
>   
>   static void pblk_lines_free(struct pblk *pblk)
> @@ -440,55 +441,44 @@ static int pblk_bb_get_tbl(struct nvm_tgt_dev *dev, struct pblk_lun *rlun,
>   	return 0;
>   }
>   
> -static void *pblk_bb_get_log(struct pblk *pblk)
> +static void *pblk_bb_get_meta(struct pblk *pblk)
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
> -	u8 *log;
> +	u8 *meta;
>   	int i, nr_blks, blk_per_lun;
>   	int ret;
>   
>   	blk_per_lun = geo->num_chk * geo->pln_mode;
>   	nr_blks = blk_per_lun * geo->all_luns;
>   
> -	log = kmalloc(nr_blks, GFP_KERNEL);
> -	if (!log)
> +	meta = kmalloc(nr_blks, GFP_KERNEL);
> +	if (!meta)
>   		return ERR_PTR(-ENOMEM);
>   
>   	for (i = 0; i < geo->all_luns; i++) {
>   		struct pblk_lun *rlun = &pblk->luns[i];
> -		u8 *log_pos = log + i * blk_per_lun;
> +		u8 *meta_pos = meta + i * blk_per_lun;
>   
> -		ret = pblk_bb_get_tbl(dev, rlun, log_pos, blk_per_lun);
> +		ret = pblk_bb_get_tbl(dev, rlun, meta_pos, blk_per_lun);
>   		if (ret) {
> -			kfree(log);
> +			kfree(meta);
>   			return ERR_PTR(-EIO);
>   		}
>   	}
>   
> -	return log;
> +	return meta;
>   }
>   
> -static int pblk_bb_line(struct pblk *pblk, struct pblk_line *line,
> -			u8 *bb_log, int blk_per_line)
> +static void *pblk_chunk_get_meta(struct pblk *pblk)
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
> -	int i, bb_cnt = 0;
> -	int blk_per_lun = geo->num_chk * geo->pln_mode;
>   
> -	for (i = 0; i < blk_per_line; i++) {
> -		struct pblk_lun *rlun = &pblk->luns[i];
> -		u8 *lun_bb_log = bb_log + i * blk_per_lun;
> -
> -		if (lun_bb_log[line->id] == NVM_BLK_T_FREE)
> -			continue;
> -
> -		set_bit(pblk_ppa_to_pos(geo, rlun->bppa), line->blk_bitmap);
> -		bb_cnt++;
> -	}
> -
> -	return bb_cnt;
> +	if (geo->version == NVM_OCSSD_SPEC_12)
> +		return pblk_bb_get_meta(pblk);
> +	else
> +		return pblk_chunk_get_info(pblk);
>   }
>   
>   static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
> @@ -696,8 +686,131 @@ static int pblk_lines_alloc_metadata(struct pblk *pblk)
>   	return -ENOMEM;
>   }
>   
> -static int pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
> -				void *chunk_log, long *nr_bad_blks)
> +static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
> +				   void *chunk_meta)
> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	struct pblk_line_meta *lm = &pblk->lm;
> +	int i, chk_per_lun, nr_bad_chks = 0;
> +
> +	chk_per_lun = geo->num_chk * geo->pln_mode;
> +
> +	for (i = 0; i < lm->blk_per_line; i++) {
> +		struct pblk_lun *rlun = &pblk->luns[i];
> +		struct nvm_chk_meta *chunk;
> +		int pos = pblk_ppa_to_pos(geo, rlun->bppa);
> +		u8 *lun_bb_meta = chunk_meta + pos * chk_per_lun;
> +
> +		chunk = &line->chks[pos];
> +
> +		/*
> +		 * In 1.2 spec. chunk state is not persisted by the device. Thus
> +		 * some of the values are reset each time pblk is instantiated.
> +		 */
> +		if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
> +			chunk->state =  NVM_CHK_ST_FREE;
> +		else
> +			chunk->state = NVM_CHK_ST_OFFLINE;
> +
> +		chunk->type = NVM_CHK_TP_W_SEQ;
> +		chunk->wi = 0;
> +		chunk->slba = -1;
> +		chunk->cnlb = geo->clba;
> +		chunk->wp = 0;
> +
> +		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
> +			continue;
> +
> +		set_bit(pos, line->blk_bitmap);
> +		nr_bad_chks++;
> +	}
> +
> +	return nr_bad_chks;
> +}
> +
> +static int pblk_setup_line_meta_20(struct pblk *pblk, struct pblk_line *line,
> +				   struct nvm_chk_meta *meta)
> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	struct pblk_line_meta *lm = &pblk->lm;
> +	int i, nr_bad_chks = 0;
> +
> +	for (i = 0; i < lm->blk_per_line; i++) {
> +		struct pblk_lun *rlun = &pblk->luns[i];
> +		struct nvm_chk_meta *chunk;
> +		struct nvm_chk_meta *chunk_meta;
> +		struct ppa_addr ppa;
> +		int pos;
> +
> +		ppa = rlun->bppa;
> +		pos = pblk_ppa_to_pos(geo, ppa);
> +		chunk = &line->chks[pos];
> +
> +		ppa.m.chk = line->id;
> +		chunk_meta = pblk_chunk_get_off(pblk, meta, ppa);
> +
> +		chunk->state = chunk_meta->state;
> +		chunk->type = chunk_meta->type;
> +		chunk->wi = chunk_meta->wi;
> +		chunk->slba = chunk_meta->slba;
> +		chunk->cnlb = chunk_meta->cnlb;
> +		chunk->wp = chunk_meta->wp;
> +
> +		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
> +			continue;
> +
> +		if (chunk->type & NVM_CHK_TP_SZ_SPEC) {
> +			WARN_ONCE(1, "pblk: custom-sized chunks unsupported\n");
> +			continue;
> +		}
> +
> +		set_bit(pos, line->blk_bitmap);
> +		nr_bad_chks++;
> +	}
> +
> +	return nr_bad_chks;
> +}
> +
> +static long pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
> +				 void *chunk_meta, int line_id)
> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
> +	struct pblk_line_meta *lm = &pblk->lm;
> +	long nr_bad_chks, chk_in_line;
> +
> +	line->pblk = pblk;
> +	line->id = line_id;
> +	line->type = PBLK_LINETYPE_FREE;
> +	line->state = PBLK_LINESTATE_NEW;
> +	line->gc_group = PBLK_LINEGC_NONE;
> +	line->vsc = &l_mg->vsc_list[line_id];
> +	spin_lock_init(&line->lock);
> +
> +	if (geo->version == NVM_OCSSD_SPEC_12)
> +		nr_bad_chks = pblk_setup_line_meta_12(pblk, line, chunk_meta);
> +	else
> +		nr_bad_chks = pblk_setup_line_meta_20(pblk, line, chunk_meta);
> +
> +	chk_in_line = lm->blk_per_line - nr_bad_chks;
> +	if (nr_bad_chks < 0 || nr_bad_chks > lm->blk_per_line ||
> +					chk_in_line < lm->min_blk_line) {
> +		line->state = PBLK_LINESTATE_BAD;
> +		list_add_tail(&line->list, &l_mg->bad_list);
> +		return 0;
> +	}
> +
> +	atomic_set(&line->blk_in_line, chk_in_line);
> +	list_add_tail(&line->list, &l_mg->free_list);
> +	l_mg->nr_free_lines++;
> +
> +	return chk_in_line;
> +}
> +
> +static int pblk_alloc_line_meta(struct pblk *pblk, struct pblk_line *line)
>   {
>   	struct pblk_line_meta *lm = &pblk->lm;
>   
> @@ -711,7 +824,13 @@ static int pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
>   		return -ENOMEM;
>   	}
>   
> -	*nr_bad_blks = pblk_bb_line(pblk, line, chunk_log, lm->blk_per_line);
> +	line->chks = kmalloc(lm->blk_per_line * sizeof(struct nvm_chk_meta),
> +								GFP_KERNEL);
> +	if (!line->chks) {
> +		kfree(line->erase_bitmap);
> +		kfree(line->blk_bitmap);
> +		return -ENOMEM;
> +	}
>   
>   	return 0;
>   }
> @@ -723,9 +842,9 @@ static int pblk_lines_init(struct pblk *pblk)
>   	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>   	struct pblk_line_meta *lm = &pblk->lm;
>   	struct pblk_line *line;
> -	void *chunk_log;
> +	void *chunk_meta;
>   	unsigned int smeta_len, emeta_len;
> -	long nr_bad_blks = 0, nr_free_blks = 0;
> +	long nr_free_chks = 0;
>   	int bb_distance, max_write_ppas;
>   	int i, ret;
>   
> @@ -842,53 +961,31 @@ static int pblk_lines_init(struct pblk *pblk)
>   		goto fail_free_bb_aux;
>   	}
>   
> -	chunk_log = pblk_bb_get_log(pblk);
> -	if (IS_ERR(chunk_log)) {
> -		pr_err("pblk: could not get bad block log (%lu)\n",
> -							PTR_ERR(chunk_log));
> -		ret = PTR_ERR(chunk_log);
> +	chunk_meta = pblk_chunk_get_meta(pblk);
> +	if (IS_ERR(chunk_meta)) {
> +		pr_err("pblk: could not get chunk log (%lu)\n",
> +							PTR_ERR(chunk_meta));
> +		ret = PTR_ERR(chunk_meta);
>   		goto fail_free_lines;
>   	}
>   
>   	for (i = 0; i < l_mg->nr_lines; i++) {
> -		int chk_in_line;
> -
>   		line = &pblk->lines[i];
>   
> -		line->pblk = pblk;
> -		line->id = i;
> -		line->type = PBLK_LINETYPE_FREE;
> -		line->state = PBLK_LINESTATE_FREE;
> -		line->gc_group = PBLK_LINEGC_NONE;
> -		line->vsc = &l_mg->vsc_list[i];
> -		spin_lock_init(&line->lock);
> -
> -		ret = pblk_setup_line_meta(pblk, line, chunk_log, &nr_bad_blks);
> +		ret = pblk_alloc_line_meta(pblk, line);
>   		if (ret)
> -			goto fail_free_chunk_log;
> +			goto fail_free_chunk_meta;
>   
> -		chk_in_line = lm->blk_per_line - nr_bad_blks;
> -		if (nr_bad_blks < 0 || nr_bad_blks > lm->blk_per_line ||
> -					chk_in_line < lm->min_blk_line) {
> -			line->state = PBLK_LINESTATE_BAD;
> -			list_add_tail(&line->list, &l_mg->bad_list);
> -			continue;
> -		}
> -
> -		nr_free_blks += chk_in_line;
> -		atomic_set(&line->blk_in_line, chk_in_line);
> -
> -		l_mg->nr_free_lines++;
> -		list_add_tail(&line->list, &l_mg->free_list);
> +		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_meta, i);
>   	}
>   
> -	pblk_set_provision(pblk, nr_free_blks);
> +	pblk_set_provision(pblk, nr_free_chks);
>   
> -	kfree(chunk_log);
> +	kfree(chunk_meta);
>   	return 0;
>   
> -fail_free_chunk_log:
> -	kfree(chunk_log);
> +fail_free_chunk_meta:
> +	kfree(chunk_meta);
>   	while (--i >= 0)
>   		pblk_line_meta_free(&pblk->lines[i]);
>   fail_free_lines:
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 6ac64d9eb57e..ee149766b7a0 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -297,6 +297,7 @@ enum {
>   	PBLK_LINETYPE_DATA = 2,
>   
>   	/* Line state */
> +	PBLK_LINESTATE_NEW = 9,
>   	PBLK_LINESTATE_FREE = 10,
>   	PBLK_LINESTATE_OPEN = 11,
>   	PBLK_LINESTATE_CLOSED = 12,
> @@ -426,6 +427,8 @@ struct pblk_line {
>   
>   	unsigned long *lun_bitmap;	/* Bitmap for LUNs mapped in line */
>   
> +	struct nvm_chk_meta *chks;	/* Chunks forming line */
> +
>   	struct pblk_smeta *smeta;	/* Start metadata */
>   	struct pblk_emeta *emeta;	/* End medatada */
>   
> @@ -729,6 +732,10 @@ void pblk_set_sec_per_write(struct pblk *pblk, int sec_per_write);
>   int pblk_setup_w_rec_rq(struct pblk *pblk, struct nvm_rq *rqd,
>   			struct pblk_c_ctx *c_ctx);
>   void pblk_discard(struct pblk *pblk, struct bio *bio);
> +struct nvm_chk_meta *pblk_chunk_get_info(struct pblk *pblk);
> +struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
> +					      struct nvm_chk_meta *lp,
> +					      struct ppa_addr ppa);
>   void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
>   void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 9fe37f7e8185..c120b2243758 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -232,6 +232,19 @@ struct nvm_addr_format {
>   	u64	rsv_mask[2];
>   };
>   
> +enum {
> +	/* Chunk states */
> +	NVM_CHK_ST_FREE =	1 << 0,
> +	NVM_CHK_ST_CLOSED =	1 << 1,
> +	NVM_CHK_ST_OPEN =	1 << 2,
> +	NVM_CHK_ST_OFFLINE =	1 << 3,
> +
> +	/* Chunk types */
> +	NVM_CHK_TP_W_SEQ =	1 << 0,
> +	NVM_CHK_TP_W_RAN =	1 << 1,
> +	NVM_CHK_TP_SZ_SPEC =	1 << 4,
> +};
> +
>   /*
>    * Note: The structure size is linked to nvme_nvm_chk_meta such that the same
>    * buffer can be used when converting from little endian to cpu addressing.
> 
