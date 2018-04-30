Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0089.outbound.protection.outlook.com ([104.47.34.89]:48753
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752778AbeD3JOB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Apr 2018 05:14:01 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v2 1/3] lightnvm: pblk: rework write error recovery path
Date: Mon, 30 Apr 2018 09:13:57 +0000
Message-ID: <05B9AA2C-0438-4784-BDE6-2A6CE901ACFD@cnexlabs.com>
References: <1524548732-4326-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1524548732-4326-2-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1524548732-4326-2-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_60769FFB-7656-4F40-869F-0DD67EA417C0";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_60769FFB-7656-4F40-869F-0DD67EA417C0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 24 Apr 2018, at 07.45, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> The write error recovery path is incomplete, so rework
> the write error recovery handling to do resubmits directly
> from the write buffer.
>=20
> When a write error occurs, the remaining sectors in the chunk are
> mapped out and invalidated and the request inserted in a resubmit =
list.
>=20
> The writer thread checks if there are any requests to resubmit,
> scans and invalidates any lbas that have been overwritten by later
> writes and resubmits the failed entries.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-init.c     |   2 +
> drivers/lightnvm/pblk-rb.c       |  39 ------
> drivers/lightnvm/pblk-recovery.c |  91 -------------
> drivers/lightnvm/pblk-write.c    | 267 =
++++++++++++++++++++++++++-------------
> drivers/lightnvm/pblk.h          |  11 +-
> 5 files changed, 181 insertions(+), 229 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index bfc488d..6f06727 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -426,6 +426,7 @@ static int pblk_core_init(struct pblk *pblk)
> 		goto free_r_end_wq;
>=20
> 	INIT_LIST_HEAD(&pblk->compl_list);
> +	INIT_LIST_HEAD(&pblk->resubmit_list);
>=20
> 	return 0;
>=20
> @@ -1185,6 +1186,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
> 	pblk->state =3D PBLK_STATE_RUNNING;
> 	pblk->gc.gc_enabled =3D 0;
>=20
> +	spin_lock_init(&pblk->resubmit_lock);
> 	spin_lock_init(&pblk->trans_lock);
> 	spin_lock_init(&pblk->lock);
>=20
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index 024a366..00cd1f2 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -503,45 +503,6 @@ int pblk_rb_may_write_gc(struct pblk_rb *rb, =
unsigned int nr_entries,
> }
>=20
> /*
> - * The caller of this function must ensure that the backpointer will =
not
> - * overwrite the entries passed on the list.
> - */
> -unsigned int pblk_rb_read_to_bio_list(struct pblk_rb *rb, struct bio =
*bio,
> -				      struct list_head *list,
> -				      unsigned int max)
> -{
> -	struct pblk_rb_entry *entry, *tentry;
> -	struct page *page;
> -	unsigned int read =3D 0;
> -	int ret;
> -
> -	list_for_each_entry_safe(entry, tentry, list, index) {
> -		if (read > max) {
> -			pr_err("pblk: too many entries on list\n");
> -			goto out;
> -		}
> -
> -		page =3D virt_to_page(entry->data);
> -		if (!page) {
> -			pr_err("pblk: could not allocate write bio =
page\n");
> -			goto out;
> -		}
> -
> -		ret =3D bio_add_page(bio, page, rb->seg_size, 0);
> -		if (ret !=3D rb->seg_size) {
> -			pr_err("pblk: could not add page to write =
bio\n");
> -			goto out;
> -		}
> -
> -		list_del(&entry->index);
> -		read++;
> -	}
> -
> -out:
> -	return read;
> -}
> -
> -/*
>  * Read available entries on rb and add them to the given bio. To =
avoid a memory
>  * copy, a page reference to the write buffer is used to be added to =
the bio.
>  *
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 9cb6d5d..5983428 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -16,97 +16,6 @@
>=20
> #include "pblk.h"
>=20
> -void pblk_submit_rec(struct work_struct *work)
> -{
> -	struct pblk_rec_ctx *recovery =3D
> -			container_of(work, struct pblk_rec_ctx, ws_rec);
> -	struct pblk *pblk =3D recovery->pblk;
> -	struct nvm_rq *rqd =3D recovery->rqd;
> -	struct pblk_c_ctx *c_ctx =3D nvm_rq_to_pdu(rqd);
> -	struct bio *bio;
> -	unsigned int nr_rec_secs;
> -	unsigned int pgs_read;
> -	int ret;
> -
> -	nr_rec_secs =3D bitmap_weight((unsigned long int =
*)&rqd->ppa_status,
> -								=
NVM_MAX_VLBA);
> -
> -	bio =3D bio_alloc(GFP_KERNEL, nr_rec_secs);
> -
> -	bio->bi_iter.bi_sector =3D 0;
> -	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> -	rqd->bio =3D bio;
> -	rqd->nr_ppas =3D nr_rec_secs;
> -
> -	pgs_read =3D pblk_rb_read_to_bio_list(&pblk->rwb, bio, =
&recovery->failed,
> -								=
nr_rec_secs);
> -	if (pgs_read !=3D nr_rec_secs) {
> -		pr_err("pblk: could not read recovery entries\n");
> -		goto err;
> -	}
> -
> -	if (pblk_setup_w_rec_rq(pblk, rqd, c_ctx)) {
> -		pr_err("pblk: could not setup recovery request\n");
> -		goto err;
> -	}
> -
> -#ifdef CONFIG_NVM_DEBUG
> -	atomic_long_add(nr_rec_secs, &pblk->recov_writes);
> -#endif
> -
> -	ret =3D pblk_submit_io(pblk, rqd);
> -	if (ret) {
> -		pr_err("pblk: I/O submission failed: %d\n", ret);
> -		goto err;
> -	}
> -
> -	mempool_free(recovery, pblk->rec_pool);
> -	return;
> -
> -err:
> -	bio_put(bio);
> -	pblk_free_rqd(pblk, rqd, PBLK_WRITE);
> -}
> -
> -int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
> -			struct pblk_rec_ctx *recovery, u64 *comp_bits,
> -			unsigned int comp)
> -{
> -	struct nvm_rq *rec_rqd;
> -	struct pblk_c_ctx *rec_ctx;
> -	int nr_entries =3D c_ctx->nr_valid + c_ctx->nr_padded;
> -
> -	rec_rqd =3D pblk_alloc_rqd(pblk, PBLK_WRITE);
> -	rec_ctx =3D nvm_rq_to_pdu(rec_rqd);
> -
> -	/* Copy completion bitmap, but exclude the first X completed =
entries */
> -	bitmap_shift_right((unsigned long int *)&rec_rqd->ppa_status,
> -				(unsigned long int *)comp_bits,
> -				comp, NVM_MAX_VLBA);
> -
> -	/* Save the context for the entries that need to be re-written =
and
> -	 * update current context with the completed entries.
> -	 */
> -	rec_ctx->sentry =3D pblk_rb_wrap_pos(&pblk->rwb, c_ctx->sentry + =
comp);
> -	if (comp >=3D c_ctx->nr_valid) {
> -		rec_ctx->nr_valid =3D 0;
> -		rec_ctx->nr_padded =3D nr_entries - comp;
> -
> -		c_ctx->nr_padded =3D comp - c_ctx->nr_valid;
> -	} else {
> -		rec_ctx->nr_valid =3D c_ctx->nr_valid - comp;
> -		rec_ctx->nr_padded =3D c_ctx->nr_padded;
> -
> -		c_ctx->nr_valid =3D comp;
> -		c_ctx->nr_padded =3D 0;
> -	}
> -
> -	recovery->rqd =3D rec_rqd;
> -	recovery->pblk =3D pblk;
> -
> -	return 0;
> -}
> -
> int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta =
*emeta_buf)
> {
> 	u32 crc;
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index 3e6f1eb..f62e432f 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -103,68 +103,149 @@ static void pblk_complete_write(struct pblk =
*pblk, struct nvm_rq *rqd,
> 	pblk_rb_sync_end(&pblk->rwb, &flags);
> }
>=20
> -/* When a write fails, we are not sure whether the block has grown =
bad or a page
> - * range is more susceptible to write errors. If a high number of =
pages fail, we
> - * assume that the block is bad and we mark it accordingly. In all =
cases, we
> - * remap and resubmit the failed entries as fast as possible; if a =
flush is
> - * waiting on a completion, the whole stack would stall otherwise.
> - */
> -static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
> +/* Map remaining sectors in chunk, starting from ppa */
> +static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr =
*ppa)
> {
> -	void *comp_bits =3D &rqd->ppa_status;
> -	struct pblk_c_ctx *c_ctx =3D nvm_rq_to_pdu(rqd);
> -	struct pblk_rec_ctx *recovery;
> -	struct ppa_addr *ppa_list =3D rqd->ppa_list;
> -	int nr_ppas =3D rqd->nr_ppas;
> -	unsigned int c_entries;
> -	int bit, ret;
> +	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> +	struct pblk_line *line;
> +	struct ppa_addr map_ppa =3D *ppa;
> +	u64 paddr;
> +	int done =3D 0;
>=20
> -	if (unlikely(nr_ppas =3D=3D 1))
> -		ppa_list =3D &rqd->ppa_addr;
> +	line =3D &pblk->lines[pblk_ppa_to_line(*ppa)];
> +	spin_lock(&line->lock);
>=20
> -	recovery =3D mempool_alloc(pblk->rec_pool, GFP_ATOMIC);
> +	while (!done)  {
> +		paddr =3D pblk_dev_ppa_to_line_addr(pblk, map_ppa);
>=20
> -	INIT_LIST_HEAD(&recovery->failed);
> +		if (!test_and_set_bit(paddr, line->map_bitmap))
> +			line->left_msecs--;
>=20
> -	bit =3D -1;
> -	while ((bit =3D find_next_bit(comp_bits, nr_ppas, bit + 1)) < =
nr_ppas) {
> -		struct pblk_rb_entry *entry;
> -		struct ppa_addr ppa;
> +		if (!test_and_set_bit(paddr, line->invalid_bitmap))
> +			le32_add_cpu(line->vsc, -1);
>=20
> -		/* Logic error */
> -		if (bit > c_ctx->nr_valid) {
> -			WARN_ONCE(1, "pblk: corrupted write request\n");
> -			mempool_free(recovery, pblk->rec_pool);
> -			goto out;
> +		if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
> +			map_ppa.ppa++;
> +			if (map_ppa.g.pg =3D=3D geo->num_pg)
> +				done =3D 1;
> +		} else {
> +			map_ppa.m.sec++;
> +			if (map_ppa.m.sec =3D=3D geo->clba)
> +				done =3D 1;
> 		}
> +	}
>=20
> -		ppa =3D ppa_list[bit];
> -		entry =3D pblk_rb_sync_scan_entry(&pblk->rwb, &ppa);
> -		if (!entry) {
> -			pr_err("pblk: could not scan entry on write =
failure\n");
> -			mempool_free(recovery, pblk->rec_pool);
> -			goto out;
> -		}
> +	spin_unlock(&line->lock);
> +}
> +
> +static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int =
sentry,
> +				  unsigned int nr_entries)
> +{
> +	struct pblk_rb *rb =3D &pblk->rwb;
> +	struct pblk_rb_entry *entry;
> +	struct pblk_line *line;
> +	struct pblk_w_ctx *w_ctx;
> +	struct ppa_addr ppa_l2p;
> +	int flags;
> +	unsigned int pos, i;
> +
> +	spin_lock(&pblk->trans_lock);
> +	pos =3D sentry;
> +	for (i =3D 0; i < nr_entries; i++) {
> +		entry =3D &rb->entries[pos];
> +		w_ctx =3D &entry->w_ctx;
> +
> +		/* Check if the lba has been overwritten */
> +		ppa_l2p =3D pblk_trans_map_get(pblk, w_ctx->lba);
> +		if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
> +			w_ctx->lba =3D ADDR_EMPTY;
> +
> +		/* Mark up the entry as submittable again */
> +		flags =3D READ_ONCE(w_ctx->flags);
> +		flags |=3D PBLK_WRITTEN_DATA;
> +		/* Release flags on write context. Protect from writes =
*/
> +		smp_store_release(&w_ctx->flags, flags);
>=20
> -		/* The list is filled first and emptied afterwards. No =
need for
> -		 * protecting it with a lock
> +		/* Decrese the reference count to the line as we will
> +		 * re-map these entries
> 		 */
> -		list_add_tail(&entry->index, &recovery->failed);
> +		line =3D &pblk->lines[pblk_ppa_to_line(w_ctx->ppa)];
> +		kref_put(&line->ref, pblk_line_put);
> +
> +		pos =3D (pos + 1) & (rb->nr_entries - 1);
> 	}
> +	spin_unlock(&pblk->trans_lock);
> +}
>=20
> -	c_entries =3D find_first_bit(comp_bits, nr_ppas);
> -	ret =3D pblk_recov_setup_rq(pblk, c_ctx, recovery, comp_bits, =
c_entries);
> -	if (ret) {
> -		pr_err("pblk: could not recover from write failure\n");
> -		mempool_free(recovery, pblk->rec_pool);
> -		goto out;
> +static void pblk_queue_resubmit(struct pblk *pblk, struct pblk_c_ctx =
*c_ctx)
> +{
> +	struct pblk_c_ctx *r_ctx;
> +
> +	r_ctx =3D kzalloc(sizeof(struct pblk_c_ctx), GFP_KERNEL);
> +	if (!r_ctx)
> +		return;
> +
> +	r_ctx->lun_bitmap =3D NULL;
> +	r_ctx->sentry =3D c_ctx->sentry;
> +	r_ctx->nr_valid =3D c_ctx->nr_valid;
> +	r_ctx->nr_padded =3D c_ctx->nr_padded;
> +
> +	spin_lock(&pblk->resubmit_lock);
> +	list_add_tail(&r_ctx->list, &pblk->resubmit_list);
> +	spin_unlock(&pblk->resubmit_lock);
> +
> +#ifdef CONFIG_NVM_DEBUG
> +	atomic_long_add(c_ctx->nr_valid, &pblk->recov_writes);
> +#endif
> +}
> +
> +static void pblk_submit_rec(struct work_struct *work)
> +{
> +	struct pblk_rec_ctx *recovery =3D
> +			container_of(work, struct pblk_rec_ctx, ws_rec);
> +	struct pblk *pblk =3D recovery->pblk;
> +	struct nvm_rq *rqd =3D recovery->rqd;
> +	struct pblk_c_ctx *c_ctx =3D nvm_rq_to_pdu(rqd);
> +	struct ppa_addr *ppa_list;
> +
> +	pblk_log_write_err(pblk, rqd);
> +
> +	if (rqd->nr_ppas =3D=3D 1)
> +		ppa_list =3D &rqd->ppa_addr;
> +	else
> +		ppa_list =3D rqd->ppa_list;
> +
> +	pblk_map_remaining(pblk, ppa_list);
> +	pblk_queue_resubmit(pblk, c_ctx);
> +
> +	pblk_up_rq(pblk, rqd->ppa_list, rqd->nr_ppas, =
c_ctx->lun_bitmap);
> +	if (c_ctx->nr_padded)
> +		pblk_bio_free_pages(pblk, rqd->bio, c_ctx->nr_valid,
> +							=
c_ctx->nr_padded);
> +	bio_put(rqd->bio);
> +	pblk_free_rqd(pblk, rqd, PBLK_WRITE);
> +	mempool_free(recovery, pblk->rec_pool);
> +
> +	atomic_dec(&pblk->inflight_io);
> +}
> +
> +
> +static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	struct pblk_rec_ctx *recovery;
> +
> +	recovery =3D mempool_alloc(pblk->rec_pool, GFP_ATOMIC);
> +	if (!recovery) {
> +		pr_err("pblk: could not allocate recovery work\n");
> +		return;
> 	}
>=20
> +	recovery->pblk =3D pblk;
> +	recovery->rqd =3D rqd;
> +
> 	INIT_WORK(&recovery->ws_rec, pblk_submit_rec);
> 	queue_work(pblk->close_wq, &recovery->ws_rec);
> -
> -out:
> -	pblk_complete_write(pblk, rqd, c_ctx);
> }
>=20
> static void pblk_end_io_write(struct nvm_rq *rqd)
> @@ -173,8 +254,8 @@ static void pblk_end_io_write(struct nvm_rq *rqd)
> 	struct pblk_c_ctx *c_ctx =3D nvm_rq_to_pdu(rqd);
>=20
> 	if (rqd->error) {
> -		pblk_log_write_err(pblk, rqd);
> -		return pblk_end_w_fail(pblk, rqd);
> +		pblk_end_w_fail(pblk, rqd);
> +		return;
> 	}
> #ifdef CONFIG_NVM_DEBUG
> 	else
> @@ -266,31 +347,6 @@ static int pblk_setup_w_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> 	return 0;
> }
>=20
> -int pblk_setup_w_rec_rq(struct pblk *pblk, struct nvm_rq *rqd,
> -			struct pblk_c_ctx *c_ctx)
> -{
> -	struct pblk_line_meta *lm =3D &pblk->lm;
> -	unsigned long *lun_bitmap;
> -	int ret;
> -
> -	lun_bitmap =3D kzalloc(lm->lun_bitmap_len, GFP_KERNEL);
> -	if (!lun_bitmap)
> -		return -ENOMEM;
> -
> -	c_ctx->lun_bitmap =3D lun_bitmap;
> -
> -	ret =3D pblk_alloc_w_rq(pblk, rqd, rqd->nr_ppas, =
pblk_end_io_write);
> -	if (ret)
> -		return ret;
> -
> -	pblk_map_rq(pblk, rqd, c_ctx->sentry, lun_bitmap, =
c_ctx->nr_valid, 0);
> -
> -	rqd->ppa_status =3D (u64)0;
> -	rqd->flags =3D pblk_set_progr_mode(pblk, PBLK_WRITE);
> -
> -	return ret;
> -}
> -
> static int pblk_calc_secs_to_sync(struct pblk *pblk, unsigned int =
secs_avail,
> 				  unsigned int secs_to_flush)
> {
> @@ -339,6 +395,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct =
pblk_line *meta_line)
> 	bio =3D pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
> 					l_mg->emeta_alloc_type, =
GFP_KERNEL);
> 	if (IS_ERR(bio)) {
> +		pr_err("pblk: failed to map emeta io");
> 		ret =3D PTR_ERR(bio);
> 		goto fail_free_rqd;
> 	}
> @@ -515,26 +572,54 @@ static int pblk_submit_write(struct pblk *pblk)
> 	unsigned int secs_avail, secs_to_sync, secs_to_com;
> 	unsigned int secs_to_flush;
> 	unsigned long pos;
> +	unsigned int resubmit;
>=20
> -	/* If there are no sectors in the cache, flushes (bios without =
data)
> -	 * will be cleared on the cache threads
> -	 */
> -	secs_avail =3D pblk_rb_read_count(&pblk->rwb);
> -	if (!secs_avail)
> -		return 1;
> -
> -	secs_to_flush =3D pblk_rb_flush_point_count(&pblk->rwb);
> -	if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
> -		return 1;
> -
> -	secs_to_sync =3D pblk_calc_secs_to_sync(pblk, secs_avail, =
secs_to_flush);
> -	if (secs_to_sync > pblk->max_write_pgs) {
> -		pr_err("pblk: bad buffer sync calculation\n");
> -		return 1;
> -	}
> +	spin_lock(&pblk->resubmit_lock);
> +	resubmit =3D !list_empty(&pblk->resubmit_list);
> +	spin_unlock(&pblk->resubmit_lock);
> +
> +	/* Resubmit failed writes first */
> +	if (resubmit) {
> +		struct pblk_c_ctx *r_ctx;
> +
> +		spin_lock(&pblk->resubmit_lock);
> +		r_ctx =3D list_first_entry(&pblk->resubmit_list,
> +					struct pblk_c_ctx, list);
> +		list_del(&r_ctx->list);
> +		spin_unlock(&pblk->resubmit_lock);
> +
> +		secs_avail =3D r_ctx->nr_valid;
> +		pos =3D r_ctx->sentry;
> +
> +		pblk_prepare_resubmit(pblk, pos, secs_avail);
> +		secs_to_sync =3D pblk_calc_secs_to_sync(pblk, =
secs_avail,
> +				secs_avail);
>=20
> -	secs_to_com =3D (secs_to_sync > secs_avail) ? secs_avail : =
secs_to_sync;
> -	pos =3D pblk_rb_read_commit(&pblk->rwb, secs_to_com);
> +		kfree(r_ctx);
> +	} else {
> +		/* If there are no sectors in the cache,
> +		 * flushes (bios without data) will be cleared on
> +		 * the cache threads
> +		 */
> +		secs_avail =3D pblk_rb_read_count(&pblk->rwb);
> +		if (!secs_avail)
> +			return 1;
> +
> +		secs_to_flush =3D pblk_rb_flush_point_count(&pblk->rwb);
> +		if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
> +			return 1;
> +
> +		secs_to_sync =3D pblk_calc_secs_to_sync(pblk, =
secs_avail,
> +					secs_to_flush);
> +		if (secs_to_sync > pblk->max_write_pgs) {
> +			pr_err("pblk: bad buffer sync calculation\n");
> +			return 1;
> +		}
> +
> +		secs_to_com =3D (secs_to_sync > secs_avail) ?
> +			secs_avail : secs_to_sync;
> +		pos =3D pblk_rb_read_commit(&pblk->rwb, secs_to_com);
> +	}
>=20
> 	bio =3D bio_alloc(GFP_KERNEL, secs_to_sync);
>=20
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 9838d03..f8434a3 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -128,7 +128,6 @@ struct pblk_pad_rq {
> struct pblk_rec_ctx {
> 	struct pblk *pblk;
> 	struct nvm_rq *rqd;
> -	struct list_head failed;
> 	struct work_struct ws_rec;
> };
>=20
> @@ -664,6 +663,9 @@ struct pblk {
>=20
> 	struct list_head compl_list;
>=20
> +	spinlock_t resubmit_lock;	 /* Resubmit list lock */
> +	struct list_head resubmit_list; /* Resubmit list for failed =
writes*/
> +
> 	mempool_t *page_bio_pool;
> 	mempool_t *gen_ws_pool;
> 	mempool_t *rec_pool;
> @@ -713,9 +715,6 @@ void pblk_rb_sync_l2p(struct pblk_rb *rb);
> unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq =
*rqd,
> 				 unsigned int pos, unsigned int =
nr_entries,
> 				 unsigned int count);
> -unsigned int pblk_rb_read_to_bio_list(struct pblk_rb *rb, struct bio =
*bio,
> -				      struct list_head *list,
> -				      unsigned int max);
> int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t =
lba,
> 			struct ppa_addr ppa, int bio_iter, bool =
advanced_bio);
> unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int =
entries);
> @@ -849,13 +848,9 @@ int pblk_submit_read_gc(struct pblk *pblk, struct =
pblk_gc_rq *gc_rq);
> /*
>  * pblk recovery
>  */
> -void pblk_submit_rec(struct work_struct *work);
> struct pblk_line *pblk_recov_l2p(struct pblk *pblk);
> int pblk_recov_pad(struct pblk *pblk);
> int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta =
*emeta);
> -int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
> -			struct pblk_rec_ctx *recovery, u64 *comp_bits,
> -			unsigned int comp);
>=20
> /*
>  * pblk gc
> --
> 2.7.4

LGTM

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_60769FFB-7656-4F40-869F-0DD67EA417C0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlrm3lIACgkQIX4xUKFR
nnT4wRAAvy0pymbnSL2tv3x8NBG6dqtuwvGCRfClOuIJwuQH0j1vPWOUXUXpZKUk
ebYGNhelQC83pTh7zwOcDyamOWvKMGjo2g/ij39nJiwHN7agZZ2C9qbD0GrzWjwo
pTewmTF0Tjx+c7yzrFQi3AV4ouW06AmArqs8gYGxueLOWfp8FXeaFsQCYxCCsnh9
3u0THigKUueT+8vcsxB3G0dW8APgXfdA6kWYUIHR+ryqWEybfCq1HWefI0wxgh7S
Qde+BWgRJLVEH2GSNIhETPgmdtgS0L4HpHSNp80AorNo10o7iRYxoQRyp4RYH05T
/rxRq3Wt9JF8sfox7kKu2M3N8ru4+7VzAXzP6D6rEsTK7K1SPUeDCUN9OBcoA+/h
Mz2UJ2lUJT8Y32GyB7bHpZE0/XBNRdDFHlwl/s6CyhMJOt2Oen7G96rCTDQ46zWW
ODFgpn9CxCnIueQYOVEzc5Pe+iHwNJw+IEQe73EkTqn1XQ7WJGkofFWUeWUM9E9M
/yScGRqjdfF+82YYf31bcEWXj85K+mTbdN+VdopQo2kq+2ehbnlvqgwt/StSWc1f
PvgDFDAT7GYZhU55ybSBLAhXFUjntZ/Qk7yKvjpmaD7FjvhMy90bemNwUS++vokH
B4iE8B+jd+8PrnpffI0blY1uWaCoUSVZueAVD62bgdQaw+v7D0o=
=8seO
-----END PGP SIGNATURE-----

--Apple-Mail=_60769FFB-7656-4F40-869F-0DD67EA417C0--
