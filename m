Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:20928
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753723AbeD3JOo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Apr 2018 05:14:44 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v2 2/3] lightnvm: pblk: garbage collect lines with failed
 writes
Date: Mon, 30 Apr 2018 09:14:40 +0000
Message-ID: <269EA9FA-DD9B-4D22-A7F6-6AB8B937D930@cnexlabs.com>
References: <1524548732-4326-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1524548732-4326-3-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1524548732-4326-3-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_FACEC179-DAA1-4DAB-ABDC-F84ED4BCE27E";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_FACEC179-DAA1-4DAB-ABDC-F84ED4BCE27E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 24 Apr 2018, at 07.45, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> Write failures should not happen under normal circumstances,
> so in order to bring the chunk back into a known state as soon
> as possible, evacuate all the valid data out of the line and let the
> fw judge if the block can be written to in the next reset cycle.
>=20
> Do this by introducing a new gc list for lines with failed writes,
> and ensure that the rate limiter allocates a small portion of
> the write bandwidth to get the job done.
>=20
> The lba list is saved in memory for use during gc as we
> cannot gurantee that the emeta data is readable if a write
> error occurred.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-core.c  |  45 ++++++++++++++++++-
> drivers/lightnvm/pblk-gc.c    | 102 =
+++++++++++++++++++++++++++---------------
> drivers/lightnvm/pblk-init.c  |  45 ++++++++++++-------
> drivers/lightnvm/pblk-rl.c    |  29 ++++++++++--
> drivers/lightnvm/pblk-sysfs.c |  15 ++++++-
> drivers/lightnvm/pblk-write.c |   2 +
> drivers/lightnvm/pblk.h       |  25 +++++++++--
> 7 files changed, 199 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 7762e89..413cf3b 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -373,7 +373,13 @@ struct list_head *pblk_line_gc_list(struct pblk =
*pblk, struct pblk_line *line)
>=20
> 	lockdep_assert_held(&line->lock);
>=20
> -	if (!vsc) {
> +	if (line->w_err_gc->has_write_err) {
> +		if (line->gc_group !=3D PBLK_LINEGC_WERR) {
> +			line->gc_group =3D PBLK_LINEGC_WERR;
> +			move_list =3D &l_mg->gc_werr_list;
> +			pblk_rl_werr_line_in(&pblk->rl);
> +		}
> +	} else if (!vsc) {
> 		if (line->gc_group !=3D PBLK_LINEGC_FULL) {
> 			line->gc_group =3D PBLK_LINEGC_FULL;
> 			move_list =3D &l_mg->gc_full_list;
> @@ -1603,8 +1609,13 @@ static void __pblk_line_put(struct pblk *pblk, =
struct pblk_line *line)
> 	line->state =3D PBLK_LINESTATE_FREE;
> 	line->gc_group =3D PBLK_LINEGC_NONE;
> 	pblk_line_free(line);
> -	spin_unlock(&line->lock);
>=20
> +	if (line->w_err_gc->has_write_err) {
> +		pblk_rl_werr_line_out(&pblk->rl);
> +		line->w_err_gc->has_write_err =3D 0;
> +	}
> +
> +	spin_unlock(&line->lock);
> 	atomic_dec(&gc->pipeline_gc);
>=20
> 	spin_lock(&l_mg->free_lock);
> @@ -1767,11 +1778,34 @@ void pblk_line_close_meta(struct pblk *pblk, =
struct pblk_line *line)
>=20
> 	spin_lock(&l_mg->close_lock);
> 	spin_lock(&line->lock);
> +
> +	/* Update the in-memory start address for emeta, in case it has
> +	 * shifted due to write errors
> +	 */
> +	if (line->emeta_ssec !=3D line->cur_sec)
> +		line->emeta_ssec =3D line->cur_sec;
> +
> 	list_add_tail(&line->list, &l_mg->emeta_list);
> 	spin_unlock(&line->lock);
> 	spin_unlock(&l_mg->close_lock);
>=20
> 	pblk_line_should_sync_meta(pblk);
> +
> +
> +}
> +
> +static void pblk_save_lba_list(struct pblk *pblk, struct pblk_line =
*line)
> +{
> +	struct pblk_line_meta *lm =3D &pblk->lm;
> +	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> +	unsigned int lba_list_size =3D lm->emeta_len[2];
> +	struct pblk_w_err_gc *w_err_gc =3D line->w_err_gc;
> +	struct pblk_emeta *emeta =3D line->emeta;
> +
> +	w_err_gc->lba_list =3D pblk_malloc(lba_list_size,
> +					 l_mg->emeta_alloc_type, =
GFP_KERNEL);
> +	memcpy(w_err_gc->lba_list, emeta_to_lbas(pblk, emeta->buf),
> +				lba_list_size);
> }
>=20
> void pblk_line_close_ws(struct work_struct *work)
> @@ -1780,6 +1814,13 @@ void pblk_line_close_ws(struct work_struct =
*work)
> 									=
ws);
> 	struct pblk *pblk =3D line_ws->pblk;
> 	struct pblk_line *line =3D line_ws->line;
> +	struct pblk_w_err_gc *w_err_gc =3D line->w_err_gc;
> +
> +	/* Write errors makes the emeta start address stored in smeta =
invalid,
> +	 * so keep a copy of the lba list until we've gc'd the line
> +	 */
> +	if (w_err_gc->has_write_err)
> +		pblk_save_lba_list(pblk, line);
>=20
> 	pblk_line_close(pblk, line);
> 	mempool_free(line_ws, pblk->gen_ws_pool);
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index b0cc277..df88f1b 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -129,6 +129,53 @@ static void pblk_gc_line_ws(struct work_struct =
*work)
> 	kfree(gc_rq_ws);
> }
>=20
> +static __le64 *get_lba_list_from_emeta(struct pblk *pblk,
> +				       struct pblk_line *line)
> +{
> +	struct line_emeta *emeta_buf;
> +	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> +	struct pblk_line_meta *lm =3D &pblk->lm;
> +	unsigned int lba_list_size =3D lm->emeta_len[2];
> +	__le64 *lba_list;
> +	int ret;
> +
> +	emeta_buf =3D pblk_malloc(lm->emeta_len[0],
> +				l_mg->emeta_alloc_type, GFP_KERNEL);
> +	if (!emeta_buf)
> +		return NULL;
> +
> +	ret =3D pblk_line_read_emeta(pblk, line, emeta_buf);
> +	if (ret) {
> +		pr_err("pblk: line %d read emeta failed (%d)\n",
> +				line->id, ret);
> +		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
> +		return NULL;
> +	}
> +
> +	/* If this read fails, it means that emeta is corrupted.
> +	 * For now, leave the line untouched.
> +	 * TODO: Implement a recovery routine that scans and moves
> +	 * all sectors on the line.
> +	 */
> +
> +	ret =3D pblk_recov_check_emeta(pblk, emeta_buf);
> +	if (ret) {
> +		pr_err("pblk: inconsistent emeta (line %d)\n",
> +				line->id);
> +		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
> +		return NULL;
> +	}
> +
> +	lba_list =3D pblk_malloc(lba_list_size,
> +			       l_mg->emeta_alloc_type, GFP_KERNEL);
> +	if (lba_list)
> +		memcpy(lba_list, emeta_to_lbas(pblk, emeta_buf), =
lba_list_size);
> +
> +	pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
> +
> +	return lba_list;
> +}
> +
> static void pblk_gc_line_prepare_ws(struct work_struct *work)
> {
> 	struct pblk_line_ws *line_ws =3D container_of(work, struct =
pblk_line_ws,
> @@ -138,46 +185,26 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct pblk_gc *gc =3D &pblk->gc;
> -	struct line_emeta *emeta_buf;
> 	struct pblk_line_ws *gc_rq_ws;
> 	struct pblk_gc_rq *gc_rq;
> 	__le64 *lba_list;
> 	unsigned long *invalid_bitmap;
> 	int sec_left, nr_secs, bit;
> -	int ret;
>=20
> 	invalid_bitmap =3D kmalloc(lm->sec_bitmap_len, GFP_KERNEL);
> 	if (!invalid_bitmap)
> 		goto fail_free_ws;
>=20
> -	emeta_buf =3D pblk_malloc(lm->emeta_len[0], =
l_mg->emeta_alloc_type,
> -								=
GFP_KERNEL);
> -	if (!emeta_buf) {
> -		pr_err("pblk: cannot use GC emeta\n");
> -		goto fail_free_bitmap;
> -	}
> -
> -	ret =3D pblk_line_read_emeta(pblk, line, emeta_buf);
> -	if (ret) {
> -		pr_err("pblk: line %d read emeta failed (%d)\n", =
line->id, ret);
> -		goto fail_free_emeta;
> -	}
> -
> -	/* If this read fails, it means that emeta is corrupted. For =
now, leave
> -	 * the line untouched. TODO: Implement a recovery routine that =
scans and
> -	 * moves all sectors on the line.
> -	 */
> -
> -	ret =3D pblk_recov_check_emeta(pblk, emeta_buf);
> -	if (ret) {
> -		pr_err("pblk: inconsistent emeta (line %d)\n", =
line->id);
> -		goto fail_free_emeta;
> -	}
> -
> -	lba_list =3D emeta_to_lbas(pblk, emeta_buf);
> -	if (!lba_list) {
> -		pr_err("pblk: could not interpret emeta (line %d)\n", =
line->id);
> -		goto fail_free_emeta;
> +	if (line->w_err_gc->has_write_err) {
> +		lba_list =3D line->w_err_gc->lba_list;
> +		line->w_err_gc->lba_list =3D NULL;
> +	} else {
> +		lba_list =3D get_lba_list_from_emeta(pblk, line);
> +		if (!lba_list) {
> +			pr_err("pblk: could not interpret emeta (line =
%d)\n",
> +					line->id);
> +			goto fail_free_ws;
> +		}
> 	}
>=20
> 	spin_lock(&line->lock);
> @@ -187,14 +214,14 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
>=20
> 	if (sec_left < 0) {
> 		pr_err("pblk: corrupted GC line (%d)\n", line->id);
> -		goto fail_free_emeta;
> +		goto fail_free_lba_list;
> 	}
>=20
> 	bit =3D -1;
> next_rq:
> 	gc_rq =3D kmalloc(sizeof(struct pblk_gc_rq), GFP_KERNEL);
> 	if (!gc_rq)
> -		goto fail_free_emeta;
> +		goto fail_free_lba_list;
>=20
> 	nr_secs =3D 0;
> 	do {
> @@ -240,7 +267,7 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
> 		goto next_rq;
>=20
> out:
> -	pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
> +	pblk_mfree(lba_list, l_mg->emeta_alloc_type);
> 	kfree(line_ws);
> 	kfree(invalid_bitmap);
>=20
> @@ -251,9 +278,8 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
>=20
> fail_free_gc_rq:
> 	kfree(gc_rq);
> -fail_free_emeta:
> -	pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
> -fail_free_bitmap:
> +fail_free_lba_list:
> +	pblk_mfree(lba_list, l_mg->emeta_alloc_type);
> 	kfree(invalid_bitmap);
> fail_free_ws:
> 	kfree(line_ws);
> @@ -349,12 +375,14 @@ static struct pblk_line =
*pblk_gc_get_victim_line(struct pblk *pblk,
> static bool pblk_gc_should_run(struct pblk_gc *gc, struct pblk_rl *rl)
> {
> 	unsigned int nr_blocks_free, nr_blocks_need;
> +	unsigned int werr_lines =3D atomic_read(&rl->werr_lines);
>=20
> 	nr_blocks_need =3D pblk_rl_high_thrs(rl);
> 	nr_blocks_free =3D pblk_rl_nr_free_blks(rl);
>=20
> 	/* This is not critical, no need to take lock here */
> -	return ((gc->gc_active) && (nr_blocks_need > nr_blocks_free));
> +	return ((werr_lines > 0) ||
> +		((gc->gc_active) && (nr_blocks_need > nr_blocks_free)));
> }
>=20
> void pblk_gc_free_full_lines(struct pblk *pblk)
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 6f06727..931ba32 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -493,11 +493,16 @@ static void pblk_line_mg_free(struct pblk *pblk)
> 	}
> }
>=20
> -static void pblk_line_meta_free(struct pblk_line *line)
> +static void pblk_line_meta_free(struct pblk_line_mgmt *l_mg, struct =
pblk_line *line)
> {
> +	struct pblk_w_err_gc *w_err_gc =3D line->w_err_gc;
> +
> 	kfree(line->blk_bitmap);
> 	kfree(line->erase_bitmap);
> 	kfree(line->chks);
> +
> +	pblk_mfree(w_err_gc->lba_list, l_mg->emeta_alloc_type);
> +	kfree(w_err_gc);
> }
>=20
> static void pblk_lines_free(struct pblk *pblk)
> @@ -511,7 +516,7 @@ static void pblk_lines_free(struct pblk *pblk)
> 		line =3D &pblk->lines[i];
>=20
> 		pblk_line_free(line);
> -		pblk_line_meta_free(line);
> +		pblk_line_meta_free(l_mg, line);
> 	}
> 	spin_unlock(&l_mg->free_lock);
>=20
> @@ -813,20 +818,28 @@ static int pblk_alloc_line_meta(struct pblk =
*pblk, struct pblk_line *line)
> 		return -ENOMEM;
>=20
> 	line->erase_bitmap =3D kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
> -	if (!line->erase_bitmap) {
> -		kfree(line->blk_bitmap);
> -		return -ENOMEM;
> -	}
> +	if (!line->erase_bitmap)
> +		goto free_blk_bitmap;
> +
>=20
> 	line->chks =3D kmalloc(lm->blk_per_line * sizeof(struct =
nvm_chk_meta),
> 								=
GFP_KERNEL);
> -	if (!line->chks) {
> -		kfree(line->erase_bitmap);
> -		kfree(line->blk_bitmap);
> -		return -ENOMEM;
> -	}
> +	if (!line->chks)
> +		goto free_erase_bitmap;
> +
> +	line->w_err_gc =3D kzalloc(sizeof(struct pblk_w_err_gc), =
GFP_KERNEL);
> +	if (!line->w_err_gc)
> +		goto free_chks;
>=20
> 	return 0;
> +
> +free_chks:
> +	kfree(line->chks);
> +free_erase_bitmap:
> +	kfree(line->erase_bitmap);
> +free_blk_bitmap:
> +	kfree(line->blk_bitmap);
> +	return -ENOMEM;
> }
>=20
> static int pblk_line_mg_init(struct pblk *pblk)
> @@ -851,12 +864,14 @@ static int pblk_line_mg_init(struct pblk *pblk)
> 	INIT_LIST_HEAD(&l_mg->gc_mid_list);
> 	INIT_LIST_HEAD(&l_mg->gc_low_list);
> 	INIT_LIST_HEAD(&l_mg->gc_empty_list);
> +	INIT_LIST_HEAD(&l_mg->gc_werr_list);
>=20
> 	INIT_LIST_HEAD(&l_mg->emeta_list);
>=20
> -	l_mg->gc_lists[0] =3D &l_mg->gc_high_list;
> -	l_mg->gc_lists[1] =3D &l_mg->gc_mid_list;
> -	l_mg->gc_lists[2] =3D &l_mg->gc_low_list;
> +	l_mg->gc_lists[0] =3D &l_mg->gc_werr_list;
> +	l_mg->gc_lists[1] =3D &l_mg->gc_high_list;
> +	l_mg->gc_lists[2] =3D &l_mg->gc_mid_list;
> +	l_mg->gc_lists[3] =3D &l_mg->gc_low_list;
>=20
> 	spin_lock_init(&l_mg->free_lock);
> 	spin_lock_init(&l_mg->close_lock);
> @@ -1063,7 +1078,7 @@ static int pblk_lines_init(struct pblk *pblk)
>=20
> fail_free_lines:
> 	while (--i >=3D 0)
> -		pblk_line_meta_free(&pblk->lines[i]);
> +		pblk_line_meta_free(l_mg, &pblk->lines[i]);
> 	kfree(pblk->lines);
> fail_free_chunk_meta:
> 	kfree(chunk_meta);
> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> index 883a711..6a0616a 100644
> --- a/drivers/lightnvm/pblk-rl.c
> +++ b/drivers/lightnvm/pblk-rl.c
> @@ -73,6 +73,16 @@ void pblk_rl_user_in(struct pblk_rl *rl, int =
nr_entries)
> 	pblk_rl_kick_u_timer(rl);
> }
>=20
> +void pblk_rl_werr_line_in(struct pblk_rl *rl)
> +{
> +	atomic_inc(&rl->werr_lines);
> +}
> +
> +void pblk_rl_werr_line_out(struct pblk_rl *rl)
> +{
> +	atomic_dec(&rl->werr_lines);
> +}
> +
> void pblk_rl_gc_in(struct pblk_rl *rl, int nr_entries)
> {
> 	atomic_add(nr_entries, &rl->rb_gc_cnt);
> @@ -99,11 +109,21 @@ static void __pblk_rl_update_rates(struct pblk_rl =
*rl,
> {
> 	struct pblk *pblk =3D container_of(rl, struct pblk, rl);
> 	int max =3D rl->rb_budget;
> +	int werr_gc_needed =3D atomic_read(&rl->werr_lines);
>=20
> 	if (free_blocks >=3D rl->high) {
> -		rl->rb_user_max =3D max;
> -		rl->rb_gc_max =3D 0;
> -		rl->rb_state =3D PBLK_RL_HIGH;
> +		if (werr_gc_needed) {
> +			/* Allocate a small budget for recovering
> +			 * lines with write errors
> +			 */
> +			rl->rb_gc_max =3D 1 << rl->rb_windows_pw;
> +			rl->rb_user_max =3D max - rl->rb_gc_max;
> +			rl->rb_state =3D PBLK_RL_WERR;
> +		} else {
> +			rl->rb_user_max =3D max;
> +			rl->rb_gc_max =3D 0;
> +			rl->rb_state =3D PBLK_RL_OFF;
> +		}
> 	} else if (free_blocks < rl->high) {
> 		int shift =3D rl->high_pw - rl->rb_windows_pw;
> 		int user_windows =3D free_blocks >> shift;
> @@ -124,7 +144,7 @@ static void __pblk_rl_update_rates(struct pblk_rl =
*rl,
> 		rl->rb_state =3D PBLK_RL_LOW;
> 	}
>=20
> -	if (rl->rb_state =3D=3D (PBLK_RL_MID | PBLK_RL_LOW))
> +	if (rl->rb_state !=3D PBLK_RL_OFF)
> 		pblk_gc_should_start(pblk);
> 	else
> 		pblk_gc_should_stop(pblk);
> @@ -221,6 +241,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
> 	atomic_set(&rl->rb_user_cnt, 0);
> 	atomic_set(&rl->rb_gc_cnt, 0);
> 	atomic_set(&rl->rb_space, -1);
> +	atomic_set(&rl->werr_lines, 0);
>=20
> 	timer_setup(&rl->u_timer, pblk_rl_u_timer, 0);
>=20
> diff --git a/drivers/lightnvm/pblk-sysfs.c =
b/drivers/lightnvm/pblk-sysfs.c
> index e61909a..88a0a7c 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -173,6 +173,8 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, =
char *page)
> 	int free_line_cnt =3D 0, closed_line_cnt =3D 0, emeta_line_cnt =3D=
 0;
> 	int d_line_cnt =3D 0, l_line_cnt =3D 0;
> 	int gc_full =3D 0, gc_high =3D 0, gc_mid =3D 0, gc_low =3D 0, =
gc_empty =3D 0;
> +	int gc_werr =3D 0;
> +
> 	int bad =3D 0, cor =3D 0;
> 	int msecs =3D 0, cur_sec =3D 0, vsc =3D 0, sec_in_line =3D 0;
> 	int map_weight =3D 0, meta_weight =3D 0;
> @@ -237,6 +239,15 @@ static ssize_t pblk_sysfs_lines(struct pblk =
*pblk, char *page)
> 		gc_empty++;
> 	}
>=20
> +	list_for_each_entry(line, &l_mg->gc_werr_list, list) {
> +		if (line->type =3D=3D PBLK_LINETYPE_DATA)
> +			d_line_cnt++;
> +		else if (line->type =3D=3D PBLK_LINETYPE_LOG)
> +			l_line_cnt++;
> +		closed_line_cnt++;
> +		gc_werr++;
> +	}
> +
> 	list_for_each_entry(line, &l_mg->bad_list, list)
> 		bad++;
> 	list_for_each_entry(line, &l_mg->corrupt_list, list)
> @@ -275,8 +286,8 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, =
char *page)
> 					l_mg->nr_lines);
>=20
> 	sz +=3D snprintf(page + sz, PAGE_SIZE - sz,
> -		"GC: full:%d, high:%d, mid:%d, low:%d, empty:%d, =
queue:%d\n",
> -			gc_full, gc_high, gc_mid, gc_low, gc_empty,
> +		"GC: full:%d, high:%d, mid:%d, low:%d, empty:%d, werr: =
%d, queue:%d\n",
> +			gc_full, gc_high, gc_mid, gc_low, gc_empty, =
gc_werr,
> 			atomic_read(&pblk->gc.read_inflight_gc));
>=20
> 	sz +=3D snprintf(page + sz, PAGE_SIZE - sz,
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index f62e432f..f33c2c3 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -136,6 +136,7 @@ static void pblk_map_remaining(struct pblk *pblk, =
struct ppa_addr *ppa)
> 		}
> 	}
>=20
> +	line->w_err_gc->has_write_err =3D 1;
> 	spin_unlock(&line->lock);
> }
>=20
> @@ -279,6 +280,7 @@ static void pblk_end_io_write_meta(struct nvm_rq =
*rqd)
> 	if (rqd->error) {
> 		pblk_log_write_err(pblk, rqd);
> 		pr_err("pblk: metadata I/O failed. Line %d\n", =
line->id);
> +		line->w_err_gc->has_write_err =3D 1;
> 	}
>=20
> 	sync =3D atomic_add_return(rqd->nr_ppas, &emeta->sync);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index f8434a3..25ad026 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -89,12 +89,14 @@ struct pblk_sec_meta {
> /* The number of GC lists and the rate-limiter states go together. =
This way the
>  * rate-limiter can dictate how much GC is needed based on resource =
utilization.
>  */
> -#define PBLK_GC_NR_LISTS 3
> +#define PBLK_GC_NR_LISTS 4
>=20
> enum {
> -	PBLK_RL_HIGH =3D 1,
> -	PBLK_RL_MID =3D 2,
> -	PBLK_RL_LOW =3D 3,
> +	PBLK_RL_OFF =3D 0,
> +	PBLK_RL_WERR =3D 1,
> +	PBLK_RL_HIGH =3D 2,
> +	PBLK_RL_MID =3D 3,
> +	PBLK_RL_LOW =3D 4
> };
>=20
> #define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * =
PBLK_MAX_REQ_ADDRS)
> @@ -278,6 +280,8 @@ struct pblk_rl {
> 	int rb_user_active;
> 	int rb_gc_active;
>=20
> +	atomic_t werr_lines;	/* Number of write error lines that =
needs gc */
> +
> 	struct timer_list u_timer;
>=20
> 	unsigned long long nr_secs;
> @@ -311,6 +315,7 @@ enum {
> 	PBLK_LINEGC_MID =3D 23,
> 	PBLK_LINEGC_HIGH =3D 24,
> 	PBLK_LINEGC_FULL =3D 25,
> +	PBLK_LINEGC_WERR =3D 26
> };
>=20
> #define PBLK_MAGIC 0x70626c6b /*pblk*/
> @@ -412,6 +417,11 @@ struct pblk_smeta {
> 	struct line_smeta *buf;		/* smeta buffer in persistent =
format */
> };
>=20
> +struct pblk_w_err_gc {
> +	int has_write_err;
> +	__le64 *lba_list;
> +};
> +
> struct pblk_line {
> 	struct pblk *pblk;
> 	unsigned int id;		/* Line number corresponds to =
the
> @@ -457,6 +467,8 @@ struct pblk_line {
>=20
> 	struct kref ref;		/* Write buffer L2P references =
*/
>=20
> +	struct pblk_w_err_gc *w_err_gc;	/* Write error gc recovery =
metadata */
> +
> 	spinlock_t lock;		/* Necessary for invalid_bitmap =
only */
> };
>=20
> @@ -488,6 +500,8 @@ struct pblk_line_mgmt {
> 	struct list_head gc_mid_list;	/* Full lines ready to GC, mid =
isc */
> 	struct list_head gc_low_list;	/* Full lines ready to GC, low =
isc */
>=20
> +	struct list_head gc_werr_list;  /* Write err recovery list */
> +
> 	struct list_head gc_full_list;	/* Full lines ready to GC, no =
valid */
> 	struct list_head gc_empty_list;	/* Full lines close, all valid =
*/
>=20
> @@ -891,6 +905,9 @@ void pblk_rl_free_lines_dec(struct pblk_rl *rl, =
struct pblk_line *line,
> 			    bool used);
> int pblk_rl_is_limit(struct pblk_rl *rl);
>=20
> +void pblk_rl_werr_line_in(struct pblk_rl *rl);
> +void pblk_rl_werr_line_out(struct pblk_rl *rl);
> +
> /*
>  * pblk sysfs
>  */
> --
> 2.7.4

LGTM

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_FACEC179-DAA1-4DAB-ABDC-F84ED4BCE27E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlrm3n0ACgkQIX4xUKFR
nnTq5Q//QqGfYT2/HrLhXzT/fUROctSaqWb+0j3JrUDZk5msN7nAdaVHeFwxPN2O
KNI1cjun8iXmVrXPrZWwWTg4+e2Gc/VTEdwok02GvBgbfmx7exFcscmM5lqBg3Jb
6bZFG49TiF859tU2/YX7Gc+owIjM5WNr0ZgDZeTSYyJ2ByqUne2BoA4J21sbSU7t
aS9BAOK2tQ7/IDMkVUM/2NH47QtDsFVbo79rSftLnkcvxwmyAjbEQ0Z9ICfc67HH
aiG56m9s6Wzwk0ZqU30tXdIZmR4Y3xEP4ILK2g2Rw5fqvVaVoyFRz5BgDlNOHUqZ
fxlZjCdxfbwcp2UJ+JgXVqmp95b2h9wt2i3Z7wGPUMPc535otAAOivzfZsXZmRTC
4RwAVdxTmADdFTuIJMphpW6n9O6ygEmpKOVH/35fQviIxAcDQNbXD+knXQADGGMN
P+jyxTDsLXoDHS/6r/PULeTD54325kbD3zkqeaQIUr43qNTuJ4XM+lRYLqHLIN0e
IPRts4kXQbCMnz81AZmTG+0Gkr2mQ3wM5TE6pBShzp66W8bEGN8rHNMStv26atP3
pHbZ4Q5WzDJ704NPKkFZdR8PnXIHj6e93ZLYWIYCMLUnvRmTbVvo0eRhRsDEwtXH
6k3+tJwCtQO7hSxJJYVIk7Z9GOme8rSK7QAtDz2yE7BEVr1z3UA=
=Q9xL
-----END PGP SIGNATURE-----

--Apple-Mail=_FACEC179-DAA1-4DAB-ABDC-F84ED4BCE27E--
