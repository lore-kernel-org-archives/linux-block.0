Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:41356 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeB0Sqo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 13:46:44 -0500
Received: by mail-lf0-f44.google.com with SMTP id m69so29047618lfe.8
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 10:46:43 -0800 (PST)
Subject: Re: [PATCH 17/19] lightnvm: pblk: implement get log report chunk
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
 <1519651038-16845-18-git-send-email-javier@cnexlabs.com>
 <7f82b801-acee-dc07-7604-e0c1c726516e@lightnvm.io>
 <FD411B5E-2A53-4FEE-B568-ABD8876FA38D@javigon.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <1883698b-8812-6c7a-cd59-dd24bde49f54@lightnvm.io>
Date: Tue, 27 Feb 2018 19:46:40 +0100
MIME-Version: 1.0
In-Reply-To: <FD411B5E-2A53-4FEE-B568-ABD8876FA38D@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/27/2018 03:40 PM, Javier González wrote:
>> On 26 Feb 2018, at 20.04, Matias Bjørling <mb@lightnvm.io> wrote:
>>
<snip>
>>
>>
>> Can you help me understand why you want to use The
>> NVM_CHK_ST_HOST_USE? Why would I care if the chunk state is HOST_USE?
>> A target instance should not be able to see states from other chunks
>> it doesn't own. and in that case, why have a separate state?
>>
> 
> The motivation for this state is that pblk does not maintain a per
> block/chunk state. On the first disk pass however, the state of the
> chunks is unknown, 

I don't understand this. Why is the state unknown? If assuming 1.2 
drive, one can do a scan of first page of each block. If the block 
returns success (it is in use), if 0x42ff, the block is empty, and if 
reading and it returns 0x4281, it is open.

thus we need to check for each one individually;
> after that, we know that good chunks need to be erased. Having this
> extra chunk state, frees us from maintaining this unnecessary intra-line
> state. Also, at the point I wrote this code, we did not have the report
> chunk on the erase path, so updating the chunk metadata would be
> something periodic.
> 
> I have taken a look at this again and I solved it in a different way -
> basically, only maintaining free/closed states, which is not much more
> expensive. It is included in the next version.
> 
>>
>>> +		}
>>> +
>>> +		WARN_ONCE(state & NVM_CHK_ST_OPEN,
>>> +				"pblk: open chunk in new line: %d\n",
>>> +				line->id);
>>> +	}
>>> +
>>> +	return blk_to_erase;
>>> +}
>>> +
>>>   static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
>>>   {
>>>   	struct pblk_line_meta *lm = &pblk->lm;
>>> -	int blk_in_line = atomic_read(&line->blk_in_line);
>>> +	int blk_to_erase;
>>>     	line->map_bitmap = kzalloc(lm->sec_bitmap_len, GFP_ATOMIC);
>>>   	if (!line->map_bitmap)
>>> @@ -1110,7 +1184,21 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
>>>   		return -ENOMEM;
>>>   	}
>>>   +	/* Bad blocks do not need to be erased */
>>> +	bitmap_copy(line->erase_bitmap, line->blk_bitmap, lm->blk_per_line);
>>> +
>>>   	spin_lock(&line->lock);
>>> +
>>> +	/* If we have not written to this line, we need to mark up free chunks
>>> +	 * as already erased
>>> +	 */
>>> +	if (line->state == PBLK_LINESTATE_NEW) {
>>> +		blk_to_erase = pblk_prepare_new_line(pblk, line);
>>> +		line->state = PBLK_LINESTATE_FREE;
>>> +	} else {
>>> +		blk_to_erase = atomic_read(&line->blk_in_line);
>>> +	}
>>> +
>>>   	if (line->state != PBLK_LINESTATE_FREE) {
>>>   		kfree(line->map_bitmap);
>>>   		kfree(line->invalid_bitmap);
>>> @@ -1122,15 +1210,12 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
>>>     	line->state = PBLK_LINESTATE_OPEN;
>>>   -	atomic_set(&line->left_eblks, blk_in_line);
>>> -	atomic_set(&line->left_seblks, blk_in_line);
>>> +	atomic_set(&line->left_eblks, blk_to_erase);
>>> +	atomic_set(&line->left_seblks, blk_to_erase);
>>>     	line->meta_distance = lm->meta_distance;
>>>   	spin_unlock(&line->lock);
>>>   -	/* Bad blocks do not need to be erased */
>>> -	bitmap_copy(line->erase_bitmap, line->blk_bitmap, lm->blk_per_line);
>>> -
>>>   	kref_init(&line->ref);
>>>     	return 0;
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>> index ec39800eea42..cf4f49d48aed 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -401,6 +401,7 @@ static void pblk_line_meta_free(struct pblk_line *line)
>>>   {
>>>   	kfree(line->blk_bitmap);
>>>   	kfree(line->erase_bitmap);
>>> +	kfree(line->chks);
>>>   }
>>>     static void pblk_lines_free(struct pblk *pblk)
>>> @@ -440,54 +441,44 @@ static int pblk_bb_get_tbl(struct nvm_tgt_dev *dev, struct pblk_lun *rlun,
>>>   	return 0;
>>>   }
>>>   -static void *pblk_bb_get_log(struct pblk *pblk)
>>> +static void *pblk_bb_get_meta(struct pblk *pblk)
>>>   {
>>>   	struct nvm_tgt_dev *dev = pblk->dev;
>>>   	struct nvm_geo *geo = &dev->geo;
>>> -	u8 *log;
>>> +	u8 *meta;
>>>   	int i, nr_blks, blk_per_lun;
>>>   	int ret;
>>>     	blk_per_lun = geo->c.num_chk * geo->c.pln_mode;
>>>   	nr_blks = blk_per_lun * geo->all_luns;
>>>   -	log = kmalloc(nr_blks, GFP_KERNEL);
>>> -	if (!log)
>>> +	meta = kmalloc(nr_blks, GFP_KERNEL);
>>> +	if (!meta)
>>>   		return ERR_PTR(-ENOMEM);
>>>     	for (i = 0; i < geo->all_luns; i++) {
>>>   		struct pblk_lun *rlun = &pblk->luns[i];
>>> -		u8 *log_pos = log + i * blk_per_lun;
>>> +		u8 *meta_pos = meta + i * blk_per_lun;
>>>   -		ret = pblk_bb_get_tbl(dev, rlun, log_pos, blk_per_lun);
>>> +		ret = pblk_bb_get_tbl(dev, rlun, meta_pos, blk_per_lun);
>>>   		if (ret) {
>>> -			kfree(log);
>>> +			kfree(meta);
>>>   			return ERR_PTR(-EIO);
>>>   		}
>>>   	}
>>>   -	return log;
>>> +	return meta;
>>>   }
>>>   -static int pblk_bb_line(struct pblk *pblk, struct pblk_line *line,
>>> -			u8 *bb_log, int blk_per_line)
>>> +static void *pblk_chunk_get_meta(struct pblk *pblk)
>>>   {
>>>   	struct nvm_tgt_dev *dev = pblk->dev;
>>>   	struct nvm_geo *geo = &dev->geo;
>>> -	int i, bb_cnt = 0;
>>>   -	for (i = 0; i < blk_per_line; i++) {
>>> -		struct pblk_lun *rlun = &pblk->luns[i];
>>> -		u8 *lun_bb_log = bb_log + i * blk_per_line;
>>> -
>>> -		if (lun_bb_log[line->id] == NVM_BLK_T_FREE)
>>> -			continue;
>>> -
>>> -		set_bit(pblk_ppa_to_pos(geo, rlun->bppa), line->blk_bitmap);
>>> -		bb_cnt++;
>>> -	}
>>> -
>>> -	return bb_cnt;
>>> +	if (geo->c.version == NVM_OCSSD_SPEC_12)
>>> +		return pblk_bb_get_meta(pblk);
>>> +	else
>>> +		return pblk_chunk_get_info(pblk);
>>
>> This 1.2 or 2.0 would be nice to have inside the lightnvm core. A
>> target should not care weather it is a 1.2 or 2.0 device.
>>
> 
> It is not an easy thing to do since the bad block format and chunk
> report return completely different formats. As I explained in a
> different thread, doing this in core would force 1.2 to understand fake
> chunk formats, which are not meaningful. It is better to leave the logic
> at the target level, where we know what to do with the format.

What if the core layer exported a generic "chunk meta" interface, and 
then filled it as is done in pblk. In the core, it will then fill out 
what it can fill out, and leave the rest of the fields untouched. The 
pblk code can then if () in certain places if for example wp attribute 
can,'t be used?

In the interest of time, and to get this moving, we can ignore it for now.

> 
>>>   }
>>>     static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
>>> @@ -516,6 +507,7 @@ static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
>>>     		rlun = &pblk->luns[i];
>>>   		rlun->bppa = luns[lunid];
>>> +		rlun->chunk_bppa = luns[i];
>>>     		sema_init(&rlun->wr_sem, 1);
>>>   	}
>>> @@ -695,8 +687,125 @@ static int pblk_lines_alloc_metadata(struct pblk *pblk)
>>>   	return -ENOMEM;
>>>   }
>>>   -static int pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
>>> -				void *chunk_log, long *nr_bad_blks)
>>> +static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
>>> +				   void *chunk_meta)
>>> +{
>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>> +	struct nvm_geo *geo = &dev->geo;
>>> +	struct pblk_line_meta *lm = &pblk->lm;
>>> +	int i, chk_per_lun, nr_bad_chks = 0;
>>> +
>>> +	chk_per_lun = geo->c.num_chk * geo->c.pln_mode;
>>> +
>>> +	for (i = 0; i < lm->blk_per_line; i++) {
>>> +		struct pblk_chunk *chunk = &line->chks[i];
>>> +		struct pblk_lun *rlun = &pblk->luns[i];
>>> +		u8 *lun_bb_meta = chunk_meta + i * chk_per_lun;
>>> +
>>> +		/*
>>> +		 * In 1.2 spec. chunk state is not persisted by the device. Thus
>>> +		 * some of the values are reset each time pblk is instantiated.
>>> +		 */
>>> +		if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
>>> +			chunk->state =  NVM_CHK_ST_HOST_USE;
>>> +		else
>>> +			chunk->state = NVM_CHK_ST_OFFLINE;
>>> +
>>> +		chunk->type = NVM_CHK_TP_W_SEQ;
>>> +		chunk->wi = 0;
>>> +		chunk->slba = -1;
>>> +		chunk->cnlb = geo->c.clba;
>>> +		chunk->wp = 0;
>>> +
>>> +		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
>>> +			continue;
>>> +
>>> +		set_bit(pblk_ppa_to_pos(geo, rlun->bppa), line->blk_bitmap);
>>> +		nr_bad_chks++;
>>> +	}
>>> +
>>> +	return nr_bad_chks;
>>> +}
>>> +
>>> +static int pblk_setup_line_meta_20(struct pblk *pblk, struct pblk_line *line,
>>> +				   struct nvm_chk_meta *meta)
>>> +{
>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>> +	struct nvm_geo *geo = &dev->geo;
>>> +	struct pblk_line_meta *lm = &pblk->lm;
>>> +	int i, nr_bad_chks = 0;
>>> +
>>> +	for (i = 0; i < lm->blk_per_line; i++) {
>>> +		struct pblk_chunk *chunk = &line->chks[i];
>>> +		struct pblk_lun *rlun = &pblk->luns[i];
>>> +		struct nvm_chk_meta *chunk_meta;
>>> +		struct ppa_addr ppa;
>>> +
>>> +		ppa = rlun->chunk_bppa;
>>> +		ppa.m.chk = line->id;
>>> +		chunk_meta = pblk_chunk_get_off(pblk, meta, ppa);
>>> +
>>> +		chunk->state = chunk_meta->state;
>>> +		chunk->type = chunk_meta->type;
>>> +		chunk->wi = chunk_meta->wi;
>>> +		chunk->slba = chunk_meta->slba;
>>> +		chunk->cnlb = chunk_meta->cnlb;
>>> +		chunk->wp = chunk_meta->wp;
>>> +
>>> +		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
>>> +			continue;
>>> +
>>> +		if (chunk->type & NVM_CHK_TP_SZ_SPEC) {
>>> +			WARN_ONCE(1, "pblk: custom-sized chunks unsupported\n");
>>> +			continue;
>>> +		}
>>> +
>>> +		set_bit(pblk_ppa_to_pos(geo, rlun->chunk_bppa),
>>> +							line->blk_bitmap);
>>> +		nr_bad_chks++;
>>> +	}
>>> +
>>> +	return nr_bad_chks;
>>> +}
>>> +
>>> +static long pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
>>> +				 void *chunk_meta, int line_id)
>>> +{
>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>> +	struct nvm_geo *geo = &dev->geo;
>>> +	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>>> +	struct pblk_line_meta *lm = &pblk->lm;
>>> +	long nr_bad_chks, chk_in_line;
>>> +
>>> +	line->pblk = pblk;
>>> +	line->id = line_id;
>>> +	line->type = PBLK_LINETYPE_FREE;
>>> +	line->state = PBLK_LINESTATE_NEW;
>>> +	line->gc_group = PBLK_LINEGC_NONE;
>>> +	line->vsc = &l_mg->vsc_list[line_id];
>>> +	spin_lock_init(&line->lock);
>>> +
>>> +	if (geo->c.version == NVM_OCSSD_SPEC_12)
>>> +		nr_bad_chks = pblk_setup_line_meta_12(pblk, line, chunk_meta);
>>> +	else
>>> +		nr_bad_chks = pblk_setup_line_meta_20(pblk, line, chunk_meta);
>>> +
>>> +	chk_in_line = lm->blk_per_line - nr_bad_chks;
>>> +	if (nr_bad_chks < 0 || nr_bad_chks > lm->blk_per_line ||
>>> +					chk_in_line < lm->min_blk_line) {
>>> +		line->state = PBLK_LINESTATE_BAD;
>>> +		list_add_tail(&line->list, &l_mg->bad_list);
>>> +		return 0;
>>> +	}
>>> +
>>> +	atomic_set(&line->blk_in_line, chk_in_line);
>>> +	list_add_tail(&line->list, &l_mg->free_list);
>>> +	l_mg->nr_free_lines++;
>>> +
>>> +	return chk_in_line;
>>> +}
>>> +
>>> +static int pblk_alloc_line_meta(struct pblk *pblk, struct pblk_line *line)
>>>   {
>>>   	struct pblk_line_meta *lm = &pblk->lm;
>>>   @@ -710,7 +819,13 @@ static int pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
>>>   		return -ENOMEM;
>>>   	}
>>>   -	*nr_bad_blks = pblk_bb_line(pblk, line, chunk_log, lm->blk_per_line);
>>> +	line->chks = kmalloc(lm->blk_per_line * sizeof(struct pblk_chunk),
>>> +								GFP_KERNEL);
>>> +	if (!line->chks) {
>>> +		kfree(line->erase_bitmap);
>>> +		kfree(line->blk_bitmap);
>>> +		return -ENOMEM;
>>> +	}
>>>     	return 0;
>>>   }
>>> @@ -722,9 +837,9 @@ static int pblk_lines_init(struct pblk *pblk)
>>>   	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>>>   	struct pblk_line_meta *lm = &pblk->lm;
>>>   	struct pblk_line *line;
>>> -	void *chunk_log;
>>> +	void *chunk_meta;
>>>   	unsigned int smeta_len, emeta_len;
>>> -	long nr_bad_blks = 0, nr_free_blks = 0;
>>> +	long nr_free_chks = 0;
>>>   	int bb_distance, max_write_ppas;
>>>   	int i, ret;
>>>   @@ -743,6 +858,7 @@ static int pblk_lines_init(struct pblk *pblk)
>>>   	l_mg->log_line = l_mg->data_line = NULL;
>>>   	l_mg->l_seq_nr = l_mg->d_seq_nr = 0;
>>>   	l_mg->nr_free_lines = 0;
>>> +	atomic_set(&l_mg->sysfs_line_state, -1);
>>>   	bitmap_zero(&l_mg->meta_bitmap, PBLK_DATA_LINES);
>>>     	lm->sec_per_line = geo->c.clba * geo->all_luns;
>>> @@ -841,53 +957,31 @@ static int pblk_lines_init(struct pblk *pblk)
>>>   		goto fail_free_bb_aux;
>>>   	}
>>>   -	chunk_log = pblk_bb_get_log(pblk);
>>> -	if (IS_ERR(chunk_log)) {
>>> -		pr_err("pblk: could not get bad block log (%lu)\n",
>>> -							PTR_ERR(chunk_log));
>>> -		ret = PTR_ERR(chunk_log);
>>> +	chunk_meta = pblk_chunk_get_meta(pblk);
>>> +	if (IS_ERR(chunk_meta)) {
>>> +		pr_err("pblk: could not get chunk log (%lu)\n",
>>> +							PTR_ERR(chunk_meta));
>>> +		ret = PTR_ERR(chunk_meta);
>>>   		goto fail_free_lines;
>>>   	}
>>>     	for (i = 0; i < l_mg->nr_lines; i++) {
>>> -		int chk_in_line;
>>> -
>>>   		line = &pblk->lines[i];
>>>   -		line->pblk = pblk;
>>> -		line->id = i;
>>> -		line->type = PBLK_LINETYPE_FREE;
>>> -		line->state = PBLK_LINESTATE_FREE;
>>> -		line->gc_group = PBLK_LINEGC_NONE;
>>> -		line->vsc = &l_mg->vsc_list[i];
>>> -		spin_lock_init(&line->lock);
>>> -
>>> -		ret = pblk_setup_line_meta(pblk, line, chunk_log, &nr_bad_blks);
>>> +		ret = pblk_alloc_line_meta(pblk, line);
>>>   		if (ret)
>>> -			goto fail_free_chunk_log;
>>> +			goto fail_free_chunk_meta;
>>>   -		chk_in_line = lm->blk_per_line - nr_bad_blks;
>>> -		if (nr_bad_blks < 0 || nr_bad_blks > lm->blk_per_line ||
>>> -					chk_in_line < lm->min_blk_line) {
>>> -			line->state = PBLK_LINESTATE_BAD;
>>> -			list_add_tail(&line->list, &l_mg->bad_list);
>>> -			continue;
>>> -		}
>>> -
>>> -		nr_free_blks += chk_in_line;
>>> -		atomic_set(&line->blk_in_line, chk_in_line);
>>> -
>>> -		l_mg->nr_free_lines++;
>>> -		list_add_tail(&line->list, &l_mg->free_list);
>>> +		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_meta, i);
>>>   	}
>>>   -	pblk_set_provision(pblk, nr_free_blks);
>>> +	pblk_set_provision(pblk, nr_free_chks);
>>>   -	kfree(chunk_log);
>>> +	kfree(chunk_meta);
>>>   	return 0;
>>>   -fail_free_chunk_log:
>>> -	kfree(chunk_log);
>>> +fail_free_chunk_meta:
>>> +	kfree(chunk_meta);
>>>   	while (--i >= 0)
>>>   		pblk_line_meta_free(&pblk->lines[i]);
>>>   fail_free_lines:
>>> diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
>>> index ccfb3abd2773..1ce5b956c622 100644
>>> --- a/drivers/lightnvm/pblk-sysfs.c
>>> +++ b/drivers/lightnvm/pblk-sysfs.c
>>> @@ -142,6 +142,40 @@ static ssize_t pblk_sysfs_ppaf(struct pblk *pblk, char *page)
>>>   	return sz;
>>>   }
>>>   +static ssize_t pblk_sysfs_line_state_show(struct pblk *pblk, char *page)
>>> +{
>>> +	struct pblk_line_meta *lm = &pblk->lm;
>>> +	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>>> +	struct pblk_line *line;
>>> +	int line_id = atomic_read(&l_mg->sysfs_line_state);
>>> +	ssize_t sz = 0;
>>> +	int i;
>>> +
>>> +	if (line_id < 0 || line_id >= l_mg->nr_lines)
>>> +		return 0;
>>> +
>>> +	sz = snprintf(page, PAGE_SIZE,
>>> +		"line\tchunk\tstate\ttype\twear-index\tslba\t\tcnlb\twp\n");
>>> +
>>> +	line = &pblk->lines[line_id];
>>> +
>>> +	for (i = 0; i < lm->blk_per_line; i++) {
>>> +		struct pblk_chunk *chunk = &line->chks[i];
>>> +
>>> +		sz += snprintf(page + sz, PAGE_SIZE - sz,
>>> +				"%d\t%d\t%d\t%d\t%d\t\t%llu\t\t%llu\t%llu\n",
>>> +				line->id, i,
>>> +				chunk->state,
>>> +				chunk->type,
>>> +				chunk->wi,
>>> +				chunk->slba,
>>> +				chunk->cnlb,
>>> +				chunk->wp);
>>> +	}
>>> +
>>> +	return sz;
>>> +}
>>> +
>>>   static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
>>>   {
>>>   	struct nvm_tgt_dev *dev = pblk->dev;
>>> @@ -398,6 +432,29 @@ static ssize_t pblk_sysfs_stats_debug(struct pblk *pblk, char *page)
>>>   }
>>>   #endif
>>>   +
>>> +static ssize_t pblk_sysfs_line_state_store(struct pblk *pblk, const char *page,
>>> +					   size_t len)
>>> +{
>>> +	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>>> +	size_t c_len;
>>> +	int line_id;
>>> +
>>> +	c_len = strcspn(page, "\n");
>>> +	if (c_len >= len)
>>> +		return -EINVAL;
>>> +
>>> +	if (kstrtouint(page, 0, &line_id))
>>> +		return -EINVAL;
>>> +
>>> +	if (line_id < 0 || line_id >= l_mg->nr_lines)
>>> +		return -EINVAL;
>>> +
>>> +	atomic_set(&l_mg->sysfs_line_state, line_id);
>>> +
>>> +	return len;
>>> +}
>>> +
>>>   static ssize_t pblk_sysfs_gc_force(struct pblk *pblk, const char *page,
>>>   				   size_t len)
>>>   {
>>> @@ -529,6 +586,11 @@ static struct attribute sys_lines_info_attr = {
>>>   	.mode = 0444,
>>>   };
>>>   +static struct attribute sys_line_state_attr = {
>>> +	.name = "line_state",
>>> +	.mode = 0644,
>>> +};
>>> +
>>>   static struct attribute sys_gc_force = {
>>>   	.name = "gc_force",
>>>   	.mode = 0200,
>>> @@ -572,6 +634,7 @@ static struct attribute *pblk_attrs[] = {
>>>   	&sys_stats_ppaf_attr,
>>>   	&sys_lines_attr,
>>>   	&sys_lines_info_attr,
>>> +	&sys_line_state_attr,
>>>   	&sys_write_amp_mileage,
>>>   	&sys_write_amp_trip,
>>>   	&sys_padding_dist,
>>> @@ -602,6 +665,8 @@ static ssize_t pblk_sysfs_show(struct kobject *kobj, struct attribute *attr,
>>>   		return pblk_sysfs_lines(pblk, buf);
>>>   	else if (strcmp(attr->name, "lines_info") == 0)
>>>   		return pblk_sysfs_lines_info(pblk, buf);
>>> +	else if (strcmp(attr->name, "line_state") == 0)
>>> +		return pblk_sysfs_line_state_show(pblk, buf);
>>>   	else if (strcmp(attr->name, "max_sec_per_write") == 0)
>>>   		return pblk_sysfs_get_sec_per_write(pblk, buf);
>>>   	else if (strcmp(attr->name, "write_amp_mileage") == 0)
>>> @@ -628,6 +693,8 @@ static ssize_t pblk_sysfs_store(struct kobject *kobj, struct attribute *attr,
>>>   		return pblk_sysfs_set_sec_per_write(pblk, buf, len);
>>>   	else if (strcmp(attr->name, "write_amp_trip") == 0)
>>>   		return pblk_sysfs_set_write_amp_trip(pblk, buf, len);
>>> +	else if (strcmp(attr->name, "line_state") == 0)
>>> +		return pblk_sysfs_line_state_store(pblk, buf, len);
>>>   	else if (strcmp(attr->name, "padding_dist") == 0)
>>>   		return pblk_sysfs_set_padding_dist(pblk, buf, len);
>>>   	return 0;
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index 6e1fcd1a538a..bc31c67b725f 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -201,6 +201,8 @@ struct pblk_rb {
>>>     struct pblk_lun {
>>>   	struct ppa_addr bppa;
>>> +	struct ppa_addr chunk_bppa;
>>> +
>>>   	struct semaphore wr_sem;
>>>   };
>>>   @@ -297,6 +299,7 @@ enum {
>>>   	PBLK_LINETYPE_DATA = 2,
>>>     	/* Line state */
>>> +	PBLK_LINESTATE_NEW = 9,
>>>   	PBLK_LINESTATE_FREE = 10,
>>>   	PBLK_LINESTATE_OPEN = 11,
>>>   	PBLK_LINESTATE_CLOSED = 12,
>>> @@ -412,6 +415,15 @@ struct pblk_smeta {
>>>   	struct line_smeta *buf;		/* smeta buffer in persistent format */
>>>   };
>>>   +struct pblk_chunk {
>>> +	int state;
>>> +	int type;
>>> +	int wi;
>>> +	u64 slba;
>>> +	u64 cnlb;
>>> +	u64 wp;
>>> +};
>>> +
>>
>> How come the code replicate the nvm_chk_meta data structure?
> 
> There is no need to maintain the chunk reserved bits in nvm_chk_meta and
> waste memory in the process, as these are alive for the whole life of
> the pblk instance. This structure only maintains the necessary bits.
>

nvm_chk_meta is 32 bytes:

struct nvm_chk_meta {
	u8                         state;                /* 0     1 */
	u8                         type;                 /* 1     1 */
	u8                         wli;                  /* 2     1 */
	u8                         rsvd[5];              /* 3     5 */
	u64                        slba;                 /* 8     8 */
	u64                        cnlb;                 /* 16     8 */
	u64                        wp;                   /* 24     8 */

	/* size: 32, cachelines: 1, members: 7 */
	/* last cacheline: 32 bytes */
};

pblk_chunk is 40 bytes:

struct pblk_chunk {
	int                        state;                /*  0     4 */
	int                        type;                 /*  4     4 */
	int                        wi;                   /*  8     4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        slba;                 /*  16     8 */
	u64                        cnlb;                 /*  24     8 */
	u64                        wp;                   /*  32     8 */

	/* size: 40, cachelines: 1, members: 6 */
	/* sum members: 36, holes: 1, sum holes: 4 */
	/* last cacheline: 40 bytes */
};

If assuming 64K chunks, pblk chunk uses 2560KB (and requires an extra 
traversal when the chunk meta information is returned to copy over the 
data to the new data structure), while nvm_chk_meta uses 2048KB. 
Granted, the nvm_chk_meta state/type/wli fields will be slightly slower 
to access due to the bit shifting, but I think it is worth it. One can 
measure and see if there is any performance difference.
