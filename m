Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40884 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932837AbeCENpf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Mar 2018 08:45:35 -0500
Received: by mail-wm0-f66.google.com with SMTP id t6so15618529wmt.5
        for <linux-block@vger.kernel.org>; Mon, 05 Mar 2018 05:45:35 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <12DCD7A9-01CB-4CCE-8F6A-6B892056F5F0@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1969DF07-46FB-44BF-8209-4E04B8EA0E5C";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] lightnvm: pblk: refactor init/exit sequences
Date: Mon, 5 Mar 2018 14:45:29 +0100
In-Reply-To: <64fdacf9-fc89-48fb-4a8d-a8dada708329@lightnvm.io>
Cc: linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1519919998-20829-1-git-send-email-javier@cnexlabs.com>
 <1519919998-20829-2-git-send-email-javier@cnexlabs.com>
 <8586a9e4-c76f-e38a-edcf-201cc7e2ddfb@lightnvm.io>
 <ED151D27-0D29-451F-9E9D-155E6C8C6224@javigon.com>
 <64fdacf9-fc89-48fb-4a8d-a8dada708329@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_1969DF07-46FB-44BF-8209-4E04B8EA0E5C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Mar 2018, at 14.38, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 03/01/2018 08:29 PM, Javier Gonz=C3=A1lez wrote:
>>> On 1 Mar 2018, at 19.49, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 03/01/2018 04:59 PM, Javier Gonz=C3=A1lez wrote:
>>>> Refactor init and exit sequences to eliminate dependencies among =
init
>>>> modules and improve readability.
>>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>> ---
>>>>  drivers/lightnvm/pblk-init.c | 415 =
+++++++++++++++++++++----------------------
>>>>  1 file changed, 206 insertions(+), 209 deletions(-)
>>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>>> index 25fc70ca07f7..87c390667dd6 100644
>>>> --- a/drivers/lightnvm/pblk-init.c
>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>> @@ -103,7 +103,40 @@ static void pblk_l2p_free(struct pblk *pblk)
>>>>  	vfree(pblk->trans_map);
>>>>  }
>>>>  -static int pblk_l2p_init(struct pblk *pblk)
>>>> +static int pblk_l2p_recover(struct pblk *pblk, bool factory_init)
>>>> +{
>>>> +	struct pblk_line *line =3D NULL;
>>>> +
>>>> +	if (factory_init) {
>>>> +		pblk_setup_uuid(pblk);
>>>> +	} else {
>>>> +		line =3D pblk_recov_l2p(pblk);
>>>> +		if (IS_ERR(line)) {
>>>> +			pr_err("pblk: could not recover l2p table\n");
>>>> +			return -EFAULT;
>>>> +		}
>>>> +	}
>>>> +
>>>> +#ifdef CONFIG_NVM_DEBUG
>>>> +	pr_info("pblk init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
>>>> +#endif
>>>> +
>>>> +	/* Free full lines directly as GC has not been started yet */
>>>> +	pblk_gc_free_full_lines(pblk);
>>>> +
>>>> +	if (!line) {
>>>> +		/* Configure next line for user data */
>>>> +		line =3D pblk_line_get_first_data(pblk);
>>>> +		if (!line) {
>>>> +			pr_err("pblk: line list corrupted\n");
>>>> +			return -EFAULT;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
>>>>  {
>>>>  	sector_t i;
>>>>  	struct ppa_addr ppa;
>>>> @@ -119,7 +152,7 @@ static int pblk_l2p_init(struct pblk *pblk)
>>>>  	for (i =3D 0; i < pblk->rl.nr_secs; i++)
>>>>  		pblk_trans_map_set(pblk, i, ppa);
>>>>  -	return 0;
>>>> +	return pblk_l2p_recover(pblk, factory_init);
>>>>  }
>>>>    static void pblk_rwb_free(struct pblk *pblk)
>>>> @@ -159,7 +192,13 @@ static int pblk_set_ppaf(struct pblk *pblk)
>>>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>  	struct nvm_geo *geo =3D &dev->geo;
>>>>  	struct nvm_addr_format ppaf =3D geo->ppaf;
>>>> -	int power_len;
>>>> +	int mod, power_len;
>>>> +
>>>> +	div_u64_rem(geo->sec_per_chk, pblk->min_write_pgs, &mod);
>>>> +	if (mod) {
>>>> +		pr_err("pblk: bad configuration of sectors/pages\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>>    	/* Re-calculate channel and lun format to adapt to =
configuration */
>>>>  	power_len =3D get_count_order(geo->nr_chnls);
>>>> @@ -252,12 +291,39 @@ static int pblk_core_init(struct pblk *pblk)
>>>>  {
>>>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>  	struct nvm_geo *geo =3D &dev->geo;
>>>> +	int max_write_ppas;
>>>> +
>>>> +	atomic64_set(&pblk->user_wa, 0);
>>>> +	atomic64_set(&pblk->pad_wa, 0);
>>>> +	atomic64_set(&pblk->gc_wa, 0);
>>>> +	pblk->user_rst_wa =3D 0;
>>>> +	pblk->pad_rst_wa =3D 0;
>>>> +	pblk->gc_rst_wa =3D 0;
>>>> +
>>>> +	atomic64_set(&pblk->nr_flush, 0);
>>>> +	pblk->nr_flush_rst =3D 0;
>>>>    	pblk->pgs_in_buffer =3D NVM_MEM_PAGE_WRITE * =
geo->sec_per_pg *
>>>>  						geo->nr_planes * =
geo->all_luns;
>>>>  +	pblk->min_write_pgs =3D geo->sec_per_pl * (geo->sec_size / =
PAGE_SIZE);
>>>> +	max_write_ppas =3D pblk->min_write_pgs * geo->all_luns;
>>>> +	pblk->max_write_pgs =3D min_t(int, max_write_ppas, =
NVM_MAX_VLBA);
>>>> +	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>>>> +
>>>> +	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
>>>> +		pr_err("pblk: vector list too big(%u > %u)\n",
>>>> +				pblk->max_write_pgs, =
PBLK_MAX_REQ_ADDRS);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	pblk->pad_dist =3D kzalloc((pblk->min_write_pgs - 1) * =
sizeof(atomic64_t),
>>>> +								=
GFP_KERNEL);
>>>> +	if (!pblk->pad_dist)
>>>> +		return -ENOMEM;
>>>> +
>>>>  	if (pblk_init_global_caches(pblk))
>>>> -		return -ENOMEM;
>>>> +		goto fail_free_pad_dist;
>>>>    	/* Internal bios can be at most the sectors signaled by =
the device. */
>>>>  	pblk->page_bio_pool =3D mempool_create_page_pool(NVM_MAX_VLBA, =
0);
>>>> @@ -307,10 +373,8 @@ static int pblk_core_init(struct pblk *pblk)
>>>>  	if (pblk_set_ppaf(pblk))
>>>>  		goto free_r_end_wq;
>>>>  -	if (pblk_rwb_init(pblk))
>>>> -		goto free_r_end_wq;
>>>> -
>>>>  	INIT_LIST_HEAD(&pblk->compl_list);
>>>> +
>>>>  	return 0;
>>>>    free_r_end_wq:
>>>> @@ -333,6 +397,8 @@ static int pblk_core_init(struct pblk *pblk)
>>>>  	mempool_destroy(pblk->page_bio_pool);
>>>>  free_global_caches:
>>>>  	pblk_free_global_caches(pblk);
>>>> +fail_free_pad_dist:
>>>> +	kfree(pblk->pad_dist);
>>>>  	return -ENOMEM;
>>>>  }
>>>>  @@ -354,14 +420,8 @@ static void pblk_core_free(struct pblk *pblk)
>>>>  	mempool_destroy(pblk->e_rq_pool);
>>>>  	mempool_destroy(pblk->w_rq_pool);
>>>>  -	pblk_rwb_free(pblk);
>>>> -
>>>>  	pblk_free_global_caches(pblk);
>>>> -}
>>>> -
>>>> -static void pblk_luns_free(struct pblk *pblk)
>>>> -{
>>>> -	kfree(pblk->luns);
>>>> +	kfree(pblk->pad_dist);
>>>>  }
>>>>    static void pblk_line_mg_free(struct pblk *pblk)
>>>> @@ -378,8 +438,6 @@ static void pblk_line_mg_free(struct pblk =
*pblk)
>>>>  		pblk_mfree(l_mg->eline_meta[i]->buf, =
l_mg->emeta_alloc_type);
>>>>  		kfree(l_mg->eline_meta[i]);
>>>>  	}
>>>> -
>>>> -	kfree(pblk->lines);
>>>>  }
>>>>    static void pblk_line_meta_free(struct pblk_line *line)
>>>> @@ -402,6 +460,11 @@ static void pblk_lines_free(struct pblk *pblk)
>>>>  		pblk_line_meta_free(line);
>>>>  	}
>>>>  	spin_unlock(&l_mg->free_lock);
>>>> +
>>>> +	pblk_line_mg_free(pblk);
>>>> +
>>>> +	kfree(pblk->luns);
>>>> +	kfree(pblk->lines);
>>>>  }
>>>>    static int pblk_bb_get_tbl(struct nvm_tgt_dev *dev, struct =
pblk_lun *rlun,
>>>> @@ -476,7 +539,7 @@ static int pblk_bb_line(struct pblk *pblk, =
struct pblk_line *line,
>>>>  	return bb_cnt;
>>>>  }
>>>>  -static int pblk_luns_init(struct pblk *pblk, struct ppa_addr =
*luns)
>>>> +static int pblk_luns_init(struct pblk *pblk)
>>>>  {
>>>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>  	struct nvm_geo *geo =3D &dev->geo;
>>>> @@ -501,7 +564,7 @@ static int pblk_luns_init(struct pblk *pblk, =
struct ppa_addr *luns)
>>>>  		int lunid =3D lun_raw + ch * geo->nr_luns;
>>>>    		rlun =3D &pblk->luns[i];
>>>> -		rlun->bppa =3D luns[lunid];
>>>> +		rlun->bppa =3D dev->luns[lunid];
>>>>    		sema_init(&rlun->wr_sem, 1);
>>>>  	}
>>>> @@ -509,38 +572,6 @@ static int pblk_luns_init(struct pblk *pblk, =
struct ppa_addr *luns)
>>>>  	return 0;
>>>>  }
>>>>  -static int pblk_lines_configure(struct pblk *pblk, int flags)
>>>> -{
>>>> -	struct pblk_line *line =3D NULL;
>>>> -	int ret =3D 0;
>>>> -
>>>> -	if (!(flags & NVM_TARGET_FACTORY)) {
>>>> -		line =3D pblk_recov_l2p(pblk);
>>>> -		if (IS_ERR(line)) {
>>>> -			pr_err("pblk: could not recover l2p table\n");
>>>> -			ret =3D -EFAULT;
>>>> -		}
>>>> -	}
>>>> -
>>>> -#ifdef CONFIG_NVM_DEBUG
>>>> -	pr_info("pblk init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
>>>> -#endif
>>>> -
>>>> -	/* Free full lines directly as GC has not been started yet */
>>>> -	pblk_gc_free_full_lines(pblk);
>>>> -
>>>> -	if (!line) {
>>>> -		/* Configure next line for user data */
>>>> -		line =3D pblk_line_get_first_data(pblk);
>>>> -		if (!line) {
>>>> -			pr_err("pblk: line list corrupted\n");
>>>> -			ret =3D -EFAULT;
>>>> -		}
>>>> -	}
>>>> -
>>>> -	return ret;
>>>> -}
>>>> -
>>>>  /* See comment over struct line_emeta definition */
>>>>  static unsigned int calc_emeta_len(struct pblk *pblk)
>>>>  {
>>>> @@ -606,11 +637,70 @@ static void pblk_set_provision(struct pblk =
*pblk, long nr_free_blks)
>>>>  	atomic_set(&pblk->rl.free_user_blocks, nr_free_blks);
>>>>  }
>>>>  -static int pblk_lines_alloc_metadata(struct pblk *pblk)
>>>> +static int pblk_setup_line_meta(struct pblk *pblk, struct =
pblk_line *line,
>>>> +				void *chunk_log, long *nr_bad_blks)
>>>>  {
>>>> +	struct pblk_line_meta *lm =3D &pblk->lm;
>>>> +
>>>> +	line->blk_bitmap =3D kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
>>>> +	if (!line->blk_bitmap)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	line->erase_bitmap =3D kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
>>>> +	if (!line->erase_bitmap) {
>>>> +		kfree(line->blk_bitmap);
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	*nr_bad_blks =3D pblk_bb_line(pblk, line, chunk_log, =
lm->blk_per_line);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int pblk_line_mg_init(struct pblk *pblk)
>>>> +{
>>>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>> +	struct nvm_geo *geo =3D &dev->geo;
>>>>  	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
>>>>  	struct pblk_line_meta *lm =3D &pblk->lm;
>>>> -	int i;
>>>> +	int i, bb_distance;
>>>> +
>>>> +	l_mg->nr_lines =3D geo->nr_chks;
>>>> +	l_mg->log_line =3D l_mg->data_line =3D NULL;
>>>> +	l_mg->l_seq_nr =3D l_mg->d_seq_nr =3D 0;
>>>> +	l_mg->nr_free_lines =3D 0;
>>>> +	bitmap_zero(&l_mg->meta_bitmap, PBLK_DATA_LINES);
>>>> +
>>>> +	INIT_LIST_HEAD(&l_mg->free_list);
>>>> +	INIT_LIST_HEAD(&l_mg->corrupt_list);
>>>> +	INIT_LIST_HEAD(&l_mg->bad_list);
>>>> +	INIT_LIST_HEAD(&l_mg->gc_full_list);
>>>> +	INIT_LIST_HEAD(&l_mg->gc_high_list);
>>>> +	INIT_LIST_HEAD(&l_mg->gc_mid_list);
>>>> +	INIT_LIST_HEAD(&l_mg->gc_low_list);
>>>> +	INIT_LIST_HEAD(&l_mg->gc_empty_list);
>>>> +
>>>> +	INIT_LIST_HEAD(&l_mg->emeta_list);
>>>> +
>>>> +	l_mg->gc_lists[0] =3D &l_mg->gc_high_list;
>>>> +	l_mg->gc_lists[1] =3D &l_mg->gc_mid_list;
>>>> +	l_mg->gc_lists[2] =3D &l_mg->gc_low_list;
>>>> +
>>>> +	spin_lock_init(&l_mg->free_lock);
>>>> +	spin_lock_init(&l_mg->close_lock);
>>>> +	spin_lock_init(&l_mg->gc_lock);
>>>> +
>>>> +	l_mg->vsc_list =3D kcalloc(l_mg->nr_lines, sizeof(__le32), =
GFP_KERNEL);
>>>> +	if (!l_mg->vsc_list)
>>>> +		goto fail;
>>>> +
>>>> +	l_mg->bb_template =3D kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
>>>> +	if (!l_mg->bb_template)
>>>> +		goto fail_free_vsc_list;
>>>> +
>>>> +	l_mg->bb_aux =3D kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
>>>> +	if (!l_mg->bb_aux)
>>>> +		goto fail_free_bb_template;
>>>>    	/* smeta is always small enough to fit on a kmalloc =
memory allocation,
>>>>  	 * emeta depends on the number of LUNs allocated to the pblk =
instance
>>>> @@ -656,13 +746,13 @@ static int pblk_lines_alloc_metadata(struct =
pblk *pblk)
>>>>  		}
>>>>  	}
>>>>  -	l_mg->vsc_list =3D kcalloc(l_mg->nr_lines, sizeof(__le32), =
GFP_KERNEL);
>>>> -	if (!l_mg->vsc_list)
>>>> -		goto fail_free_emeta;
>>>> -
>>>>  	for (i =3D 0; i < l_mg->nr_lines; i++)
>>>>  		l_mg->vsc_list[i] =3D cpu_to_le32(EMPTY_ENTRY);
>>>>  +	bb_distance =3D (geo->all_luns) * geo->ws_opt;
>>>> +	for (i =3D 0; i < lm->sec_per_line; i +=3D bb_distance)
>>>> +		bitmap_set(l_mg->bb_template, i, geo->ws_opt);
>>>> +
>>>>  	return 0;
>>>>    fail_free_emeta:
>>>> @@ -673,69 +763,25 @@ static int pblk_lines_alloc_metadata(struct =
pblk *pblk)
>>>>  			kfree(l_mg->eline_meta[i]->buf);
>>>>  		kfree(l_mg->eline_meta[i]);
>>>>  	}
>>>> -
>>>>  fail_free_smeta:
>>>>  	for (i =3D 0; i < PBLK_DATA_LINES; i++)
>>>>  		kfree(l_mg->sline_meta[i]);
>>>> -
>>>> +	kfree(l_mg->bb_aux);
>>>> +fail_free_bb_template:
>>>> +	kfree(l_mg->bb_template);
>>>> +fail_free_vsc_list:
>>>> +	kfree(l_mg->vsc_list);
>>>> +fail:
>>>>  	return -ENOMEM;
>>>>  }
>>>>  -static int pblk_setup_line_meta(struct pblk *pblk, struct =
pblk_line *line,
>>>> -				void *chunk_log, long *nr_bad_blks)
>>>> -{
>>>> -	struct pblk_line_meta *lm =3D &pblk->lm;
>>>> -
>>>> -	line->blk_bitmap =3D kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
>>>> -	if (!line->blk_bitmap)
>>>> -		return -ENOMEM;
>>>> -
>>>> -	line->erase_bitmap =3D kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
>>>> -	if (!line->erase_bitmap) {
>>>> -		kfree(line->blk_bitmap);
>>>> -		return -ENOMEM;
>>>> -	}
>>>> -
>>>> -	*nr_bad_blks =3D pblk_bb_line(pblk, line, chunk_log, =
lm->blk_per_line);
>>>> -
>>>> -	return 0;
>>>> -}
>>>> -
>>>> -static int pblk_lines_init(struct pblk *pblk)
>>>> +static int pblk_line_meta_init(struct pblk *pblk)
>>>>  {
>>>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>  	struct nvm_geo *geo =3D &dev->geo;
>>>> -	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
>>>>  	struct pblk_line_meta *lm =3D &pblk->lm;
>>>> -	struct pblk_line *line;
>>>> -	void *chunk_log;
>>>>  	unsigned int smeta_len, emeta_len;
>>>> -	long nr_bad_blks =3D 0, nr_free_blks =3D 0;
>>>> -	int bb_distance, max_write_ppas, mod;
>>>> -	int i, ret;
>>>> -
>>>> -	pblk->min_write_pgs =3D geo->sec_per_pl * (geo->sec_size / =
PAGE_SIZE);
>>>> -	max_write_ppas =3D pblk->min_write_pgs * geo->all_luns;
>>>> -	pblk->max_write_pgs =3D min_t(int, max_write_ppas, =
NVM_MAX_VLBA);
>>>> -	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>>>> -
>>>> -	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
>>>> -		pr_err("pblk: vector list too big(%u > %u)\n",
>>>> -				pblk->max_write_pgs, =
PBLK_MAX_REQ_ADDRS);
>>>> -		return -EINVAL;
>>>> -	}
>>>> -
>>>> -	div_u64_rem(geo->sec_per_chk, pblk->min_write_pgs, &mod);
>>>> -	if (mod) {
>>>> -		pr_err("pblk: bad configuration of sectors/pages\n");
>>>> -		return -EINVAL;
>>>> -	}
>>>> -
>>>> -	l_mg->nr_lines =3D geo->nr_chks;
>>>> -	l_mg->log_line =3D l_mg->data_line =3D NULL;
>>>> -	l_mg->l_seq_nr =3D l_mg->d_seq_nr =3D 0;
>>>> -	l_mg->nr_free_lines =3D 0;
>>>> -	bitmap_zero(&l_mg->meta_bitmap, PBLK_DATA_LINES);
>>>> +	int i;
>>>>    	lm->sec_per_line =3D geo->sec_per_chk * geo->all_luns;
>>>>  	lm->blk_per_line =3D geo->all_luns;
>>>> @@ -787,58 +833,43 @@ static int pblk_lines_init(struct pblk *pblk)
>>>>  		return -EINVAL;
>>>>  	}
>>>>  -	ret =3D pblk_lines_alloc_metadata(pblk);
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int pblk_lines_init(struct pblk *pblk)
>>>> +{
>>>> +	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
>>>> +	struct pblk_line_meta *lm =3D &pblk->lm;
>>>> +	struct pblk_line *line;
>>>> +	void *chunk_log;
>>>> +	long nr_bad_blks =3D 0, nr_free_blks =3D 0;
>>>> +	int i, ret;
>>>> +
>>>> +	ret =3D pblk_line_meta_init(pblk);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret =3D pblk_line_mg_init(pblk);
>>>>  	if (ret)
>>>>  		return ret;
>>>>  -	l_mg->bb_template =3D kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
>>>> -	if (!l_mg->bb_template) {
>>>> -		ret =3D -ENOMEM;
>>>> +	ret =3D pblk_luns_init(pblk);
>>>> +	if (ret)
>>>>  		goto fail_free_meta;
>>>> -	}
>>>> -
>>>> -	l_mg->bb_aux =3D kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
>>>> -	if (!l_mg->bb_aux) {
>>>> -		ret =3D -ENOMEM;
>>>> -		goto fail_free_bb_template;
>>>> -	}
>>>> -
>>>> -	bb_distance =3D (geo->all_luns) * geo->sec_per_pl;
>>>> -	for (i =3D 0; i < lm->sec_per_line; i +=3D bb_distance)
>>>> -		bitmap_set(l_mg->bb_template, i, geo->sec_per_pl);
>>>> -
>>>> -	INIT_LIST_HEAD(&l_mg->free_list);
>>>> -	INIT_LIST_HEAD(&l_mg->corrupt_list);
>>>> -	INIT_LIST_HEAD(&l_mg->bad_list);
>>>> -	INIT_LIST_HEAD(&l_mg->gc_full_list);
>>>> -	INIT_LIST_HEAD(&l_mg->gc_high_list);
>>>> -	INIT_LIST_HEAD(&l_mg->gc_mid_list);
>>>> -	INIT_LIST_HEAD(&l_mg->gc_low_list);
>>>> -	INIT_LIST_HEAD(&l_mg->gc_empty_list);
>>>> -
>>>> -	INIT_LIST_HEAD(&l_mg->emeta_list);
>>>> -
>>>> -	l_mg->gc_lists[0] =3D &l_mg->gc_high_list;
>>>> -	l_mg->gc_lists[1] =3D &l_mg->gc_mid_list;
>>>> -	l_mg->gc_lists[2] =3D &l_mg->gc_low_list;
>>>> -
>>>> -	spin_lock_init(&l_mg->free_lock);
>>>> -	spin_lock_init(&l_mg->close_lock);
>>>> -	spin_lock_init(&l_mg->gc_lock);
>>>> -
>>>> -	pblk->lines =3D kcalloc(l_mg->nr_lines, sizeof(struct =
pblk_line),
>>>> -								=
GFP_KERNEL);
>>>> -	if (!pblk->lines) {
>>>> -		ret =3D -ENOMEM;
>>>> -		goto fail_free_bb_aux;
>>>> -	}
>>>>    	chunk_log =3D pblk_bb_get_log(pblk);
>>>>  	if (IS_ERR(chunk_log)) {
>>>>  		pr_err("pblk: could not get bad block log (%lu)\n",
>>>>  							=
PTR_ERR(chunk_log));
>>>>  		ret =3D PTR_ERR(chunk_log);
>>>> -		goto fail_free_lines;
>>>> +		goto fail_free_luns;
>>>> +	}
>>>> +
>>>> +	pblk->lines =3D kcalloc(l_mg->nr_lines, sizeof(struct =
pblk_line),
>>>> +								=
GFP_KERNEL);
>>>> +	if (!pblk->lines) {
>>>> +		ret =3D -ENOMEM;
>>>> +		goto fail_free_chunk_log;
>>>>  	}
>>>>    	for (i =3D 0; i < l_mg->nr_lines; i++) {
>>>> @@ -856,7 +887,7 @@ static int pblk_lines_init(struct pblk *pblk)
>>>>    		ret =3D pblk_setup_line_meta(pblk, line, =
chunk_log, &nr_bad_blks);
>>>>  		if (ret)
>>>> -			goto fail_free_chunk_log;
>>>> +			goto fail_free_lines;
>>>>    		chk_in_line =3D lm->blk_per_line - nr_bad_blks;
>>>>  		if (nr_bad_blks < 0 || nr_bad_blks > lm->blk_per_line ||
>>>> @@ -878,16 +909,14 @@ static int pblk_lines_init(struct pblk *pblk)
>>>>  	kfree(chunk_log);
>>>>  	return 0;
>>>>  -fail_free_chunk_log:
>>>> -	kfree(chunk_log);
>>>> +fail_free_lines:
>>>>  	while (--i >=3D 0)
>>>>  		pblk_line_meta_free(&pblk->lines[i]);
>>>> -fail_free_lines:
>>>>  	kfree(pblk->lines);
>>>> -fail_free_bb_aux:
>>>> -	kfree(l_mg->bb_aux);
>>>> -fail_free_bb_template:
>>>> -	kfree(l_mg->bb_template);
>>>> +fail_free_chunk_log:
>>>> +	kfree(chunk_log);
>>>> +fail_free_luns:
>>>> +	kfree(pblk->luns);
>>>>  fail_free_meta:
>>>>  	pblk_line_mg_free(pblk);
>>>>  @@ -930,12 +959,10 @@ static void pblk_writer_stop(struct pblk =
*pblk)
>>>>    static void pblk_free(struct pblk *pblk)
>>>>  {
>>>> -	pblk_luns_free(pblk);
>>>>  	pblk_lines_free(pblk);
>>>> -	kfree(pblk->pad_dist);
>>>> -	pblk_line_mg_free(pblk);
>>>> -	pblk_core_free(pblk);
>>>>  	pblk_l2p_free(pblk);
>>>> +	pblk_rwb_free(pblk);
>>>> +	pblk_core_free(pblk);
>>>>    	kfree(pblk);
>>>>  }
>>>> @@ -1000,19 +1027,6 @@ static void *pblk_init(struct nvm_tgt_dev =
*dev, struct gendisk *tdisk,
>>>>  	spin_lock_init(&pblk->trans_lock);
>>>>  	spin_lock_init(&pblk->lock);
>>>>  -	if (flags & NVM_TARGET_FACTORY)
>>>> -		pblk_setup_uuid(pblk);
>>>> -
>>>> -	atomic64_set(&pblk->user_wa, 0);
>>>> -	atomic64_set(&pblk->pad_wa, 0);
>>>> -	atomic64_set(&pblk->gc_wa, 0);
>>>> -	pblk->user_rst_wa =3D 0;
>>>> -	pblk->pad_rst_wa =3D 0;
>>>> -	pblk->gc_rst_wa =3D 0;
>>>> -
>>>> -	atomic64_set(&pblk->nr_flush, 0);
>>>> -	pblk->nr_flush_rst =3D 0;
>>>> -
>>>>  #ifdef CONFIG_NVM_DEBUG
>>>>  	atomic_long_set(&pblk->inflight_writes, 0);
>>>>  	atomic_long_set(&pblk->padded_writes, 0);
>>>> @@ -1036,48 +1050,35 @@ static void *pblk_init(struct nvm_tgt_dev =
*dev, struct gendisk *tdisk,
>>>>  	atomic_long_set(&pblk->write_failed, 0);
>>>>  	atomic_long_set(&pblk->erase_failed, 0);
>>>>  -	ret =3D pblk_luns_init(pblk, dev->luns);
>>>> -	if (ret) {
>>>> -		pr_err("pblk: could not initialize luns\n");
>>>> -		goto fail;
>>>> -	}
>>>> -
>>>> -	ret =3D pblk_lines_init(pblk);
>>>> -	if (ret) {
>>>> -		pr_err("pblk: could not initialize lines\n");
>>>> -		goto fail_free_luns;
>>>> -	}
>>>> -
>>>> -	pblk->pad_dist =3D kzalloc((pblk->min_write_pgs - 1) * =
sizeof(atomic64_t),
>>>> -				 GFP_KERNEL);
>>>> -	if (!pblk->pad_dist) {
>>>> -		ret =3D -ENOMEM;
>>>> -		goto fail_free_line_meta;
>>>> -	}
>>>> -
>>>>  	ret =3D pblk_core_init(pblk);
>>>>  	if (ret) {
>>>>  		pr_err("pblk: could not initialize core\n");
>>>> -		goto fail_free_pad_dist;
>>>> +		goto fail;
>>>>  	}
>>>>  -	ret =3D pblk_l2p_init(pblk);
>>>> +	ret =3D pblk_lines_init(pblk);
>>>>  	if (ret) {
>>>> -		pr_err("pblk: could not initialize maps\n");
>>>> +		pr_err("pblk: could not initialize lines\n");
>>>>  		goto fail_free_core;
>>>>  	}
>>>>  -	ret =3D pblk_lines_configure(pblk, flags);
>>>> +	ret =3D pblk_rwb_init(pblk);
>>>>  	if (ret) {
>>>> -		pr_err("pblk: could not configure lines\n");
>>>> -		goto fail_free_l2p;
>>>> +		pr_err("pblk: could not initialize write buffer\n");
>>>> +		goto fail_free_lines;
>>>> +	}
>>>> +
>>>> +	ret =3D pblk_l2p_init(pblk, flags & NVM_TARGET_FACTORY);
>>>> +	if (ret) {
>>>> +		pr_err("pblk: could not initialize maps\n");
>>>> +		goto fail_free_rwb;
>>>>  	}
>>>>    	ret =3D pblk_writer_init(pblk);
>>>>  	if (ret) {
>>>>  		if (ret !=3D -EINTR)
>>>>  			pr_err("pblk: could not initialize write =
thread\n");
>>>> -		goto fail_free_lines;
>>>> +		goto fail_free_l2p;
>>>>  	}
>>>>    	ret =3D pblk_gc_init(pblk);
>>>> @@ -1112,18 +1113,14 @@ static void *pblk_init(struct nvm_tgt_dev =
*dev, struct gendisk *tdisk,
>>>>    fail_stop_writer:
>>>>  	pblk_writer_stop(pblk);
>>>> -fail_free_lines:
>>>> -	pblk_lines_free(pblk);
>>>>  fail_free_l2p:
>>>>  	pblk_l2p_free(pblk);
>>>> +fail_free_rwb:
>>>> +	pblk_rwb_free(pblk);
>>>> +fail_free_lines:
>>>> +	pblk_lines_free(pblk);
>>>>  fail_free_core:
>>>>  	pblk_core_free(pblk);
>>>> -fail_free_pad_dist:
>>>> -	kfree(pblk->pad_dist);
>>>> -fail_free_line_meta:
>>>> -	pblk_line_mg_free(pblk);
>>>> -fail_free_luns:
>>>> -	pblk_luns_free(pblk);
>>>>  fail:
>>>>  	kfree(pblk);
>>>>  	return ERR_PTR(ret);
>>>=20
>>> Thanks. I'm not able to squash it without conflict. Is it based on =
for-4.17/core?
>> Yes, it's based on for-4.17/core, but I can see a small conflict due =
to
>> the patches applied in the middle of these two. How do you want to do
>> it? We can keep them separately, or do a rebase on the current =
patches.
>=20
> This is all a bit of a mess- Can you send a fix I can apply that fixes
> up the 0-day, and then this larger patch can be applied afterwards?
> (e.g., before at after your other patches)

Not really. The problem is that the original refactoring for the bad
block table was a bandage on the init/exit sequence problem. The
init/ext patch is the one that does it properly.

What we can do, since this is only in your tree, is rebase and pull the
bad block patch up and then merge with init/exit. This way we fix the
original problem and the introduced double free is non-existing.

I can do the rebasing this evening and put it in a different branch you
can review.

Javier

--Apple-Mail=_1969DF07-46FB-44BF-8209-4E04B8EA0E5C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlqdSfkACgkQPEYBfS0l
eOB9XQ/8CIDZDj0VTwyIodCiu7dczmV8vB01JesDUNrWE1XiTuhTdQvEaN6kAmrL
6WPtCxYRZP2EfEv/TsMfNrGvOTwk/FSna9g+xNSlsNZ/MdS94CIjo8mK79n3Vatq
fz6vqd8e0vhghoMgqBLNAQdBYNLQaIYWNbawZlbHXB45eAvLTp64iqRwUL1bFXJ1
1rUNSxsOHjRGfIIZxsvLHn9vl4SZzf7VSbEni9Zb8splNrFrtAG1Em+iQWMcahoe
QNUgL9jMGUejqAN1sAsB4oXzhJPMdUv8q4WIiqjS4uqCvU8sisOCteAA/bpMu6Yx
Wx9Ac/153Zw72rv+vGbZWmWEtO+NlnSyl24zVU0IlEh7bdDH2+ir/kfZpxRaUti4
Ot9uq1BuE0Wx5Qnt3uEyCtMFGiFRmMNpVBneSEDHVop6xslFtH527jeihDw6HoI9
DsMni/ny2gYXgwnRoYU0BIt7ctP2GixTJADHPW/LksLWssFZKl65B/QfQXg7eOFu
V2YRPPFuvL9IJGJXr4+F6ENVvugq4JxDE2yFot1jmTYxLy5i8X8Zc9f8hcd6NKhb
QzkBAQAT3ISrC9Be+W0/pin7Ed3EmMTg6zFPRpgtOmgwt8AjfIySA7CrrZhO03sE
poU3cKbFBKfMsZ1Tevp2/MBXHCVgwWd1KnO4tBzWLjZ2H85Eq2w=
=gikR
-----END PGP SIGNATURE-----

--Apple-Mail=_1969DF07-46FB-44BF-8209-4E04B8EA0E5C--
