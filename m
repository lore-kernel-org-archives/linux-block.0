Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr680040.outbound.protection.outlook.com ([40.107.68.40]:57856
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937647AbeFSLI4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jun 2018 07:08:56 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: "Konopko, Igor J" <igor.j.konopko@intel.com>
CC: =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "michal.sorn@intel.com" <michal.sorn@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
Subject: Re: [PATCH 4/5] lightnvm: pblk: Support for packed metadata in pblk.
Date: Tue, 19 Jun 2018 11:08:47 +0000
Message-ID: <D40AE239-2CCD-4484-8D18-65315DDBEDFD@cnexlabs.com>
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
 <20180615222706.3801-5-igor.j.konopko@intel.com>
In-Reply-To: <20180615222706.3801-5-igor.j.konopko@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_F205E415-E8FB-433A-AD59-B6DF148F4F55";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_F205E415-E8FB-433A-AD59-B6DF148F4F55
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 16 Jun 2018, at 00.27, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> In current pblk implementation, l2p mapping for not closed lines
> is always stored only in OOB metadata and recovered from it.
>=20
> Such a solution does not provide data integrity when drives does
> not have such a OOB metadata space.
>=20
> The goal of this patch is to add support for so called packed
> metadata, which store l2p mapping for open lines in last sector
> of every write unit.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c     | 52 =
++++++++++++++++++++++++++++++++++++----
> drivers/lightnvm/pblk-init.c     | 37 ++++++++++++++++++++++++++--
> drivers/lightnvm/pblk-rb.c       |  3 +++
> drivers/lightnvm/pblk-recovery.c | 25 +++++++++++++++----
> drivers/lightnvm/pblk-sysfs.c    |  7 ++++++
> drivers/lightnvm/pblk-write.c    | 14 +++++++----
> drivers/lightnvm/pblk.h          |  5 +++-
> 7 files changed, 128 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index c092ee93a18d..375c6430612e 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -340,7 +340,7 @@ void pblk_write_should_kick(struct pblk *pblk)
> {
> 	unsigned int secs_avail =3D pblk_rb_read_count(&pblk->rwb);
>=20
> -	if (secs_avail >=3D pblk->min_write_pgs)
> +	if (secs_avail >=3D pblk->min_write_pgs_data)
> 		pblk_write_kick(pblk);
> }
>=20
> @@ -371,7 +371,9 @@ struct list_head *pblk_line_gc_list(struct pblk =
*pblk, struct pblk_line *line)
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct list_head *move_list =3D NULL;
> -	int vsc =3D le32_to_cpu(*line->vsc);
> +	int packed_meta =3D (le32_to_cpu(*line->vsc) / =
pblk->min_write_pgs_data)
> +			* (pblk->min_write_pgs - =
pblk->min_write_pgs_data);
> +	int vsc =3D le32_to_cpu(*line->vsc) + packed_meta;
>=20
> 	lockdep_assert_held(&line->lock);
>=20
> @@ -540,12 +542,15 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, =
void *data,
> }
>=20
> int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
> -		   unsigned long secs_to_flush)
> +		   unsigned long secs_to_flush, bool skip_meta)
> {
> 	int max =3D pblk->sec_per_write;
> 	int min =3D pblk->min_write_pgs;
> 	int secs_to_sync =3D 0;
>=20
> +	if (skip_meta)
> +		min =3D max =3D pblk->min_write_pgs_data;
> +
> 	if (secs_avail >=3D max)
> 		secs_to_sync =3D max;
> 	else if (secs_avail >=3D min)
> @@ -663,7 +668,7 @@ static int pblk_line_submit_emeta_io(struct pblk =
*pblk, struct pblk_line *line,
> next_rq:
> 	memset(&rqd, 0, sizeof(struct nvm_rq));
>=20
> -	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0);
> +	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0, false);
> 	rq_len =3D rq_ppas * geo->csecs;
>=20
> 	bio =3D pblk_bio_map_addr(pblk, emeta_buf, rq_ppas, rq_len,
> @@ -2091,3 +2096,42 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, =
struct ppa_addr *ppas,
> 	}
> 	spin_unlock(&pblk->trans_lock);
> }
> +
> +void pblk_set_packed_meta(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	void *meta_list =3D rqd->meta_list;
> +	void *page;
> +	int i =3D 0;
> +
> +	if (pblk_is_oob_meta_supported(pblk))
> +		return;
> +
> +	/* We need to zero out metadata corresponding to packed meta =
page */
> +	pblk_get_meta_at(pblk, meta_list, rqd->nr_ppas - 1)->lba =3D =
ADDR_EMPTY;
> +
> +	page =3D page_to_virt(rqd->bio->bi_io_vec[rqd->bio->bi_vcnt - =
1].bv_page);
> +	/* We need to fill last page of request (packed metadata)
> +	 * with data from oob meta buffer.
> +	 */
> +	for (; i < rqd->nr_ppas; i++)
> +		memcpy(page + (i * sizeof(struct pblk_sec_meta)),
> +			pblk_get_meta_at(pblk, meta_list, i),
> +			sizeof(struct pblk_sec_meta));
> +}
> +
> +void pblk_get_packed_meta(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	void *meta_list =3D rqd->meta_list;
> +	void *page;
> +	int i =3D 0;
> +
> +	if (pblk_is_oob_meta_supported(pblk))
> +		return;
> +
> +	page =3D page_to_virt(rqd->bio->bi_io_vec[rqd->bio->bi_vcnt - =
1].bv_page);
> +	/* We need to fill oob meta buffer with data from packed =
metadata */
> +	for (; i < rqd->nr_ppas; i++)
> +		memcpy(pblk_get_meta_at(pblk, meta_list, i),
> +			page + (i * sizeof(struct pblk_sec_meta)),
> +			sizeof(struct pblk_sec_meta));
> +}
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index f05112230a52..5eb641da46ed 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -372,8 +372,40 @@ static int pblk_core_init(struct pblk *pblk)
> 	pblk->min_write_pgs =3D geo->ws_opt * (geo->csecs / PAGE_SIZE);
> 	max_write_ppas =3D pblk->min_write_pgs * geo->all_luns;
> 	pblk->max_write_pgs =3D min_t(int, max_write_ppas, =
NVM_MAX_VLBA);
> +	pblk->min_write_pgs_data =3D pblk->min_write_pgs;
> 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>=20
> +	if (!pblk_is_oob_meta_supported(pblk)) {
> +		/* For drives which does not have OOB metadata feature
> +		 * in order to support recovery feature we need to use
> +		 * so called packed metadata. Packed metada will store
> +		 * the same information as OOB metadata (l2p table =
mapping,
> +		 * but in the form of the single page at the end of
> +		 * every write request.
> +		 */
> +		if (pblk->min_write_pgs
> +			* sizeof(struct pblk_sec_meta) > PAGE_SIZE) {
> +			/* We want to keep all the packed metadata on =
single
> +			 * page per write requests. So we need to ensure =
that
> +			 * it will fit.
> +			 *
> +			 * This is more like sanity check, since there =
is
> +			 * no device with such a big minimal write size
> +			 * (above 1 metabytes).
> +			 */
> +			pr_err("pblk: Not supported min write size\n");
> +			return -EINVAL;
> +		}
> +		/* For packed meta approach we do some simplification.
> +		 * On read path we always issue requests which size
> +		 * equal to max_write_pgs, with all pages filled with
> +		 * user payload except of last one page which will be
> +		 * filled with packed metadata.
> +		 */
> +		pblk->max_write_pgs =3D pblk->min_write_pgs;
> +		pblk->min_write_pgs_data =3D pblk->min_write_pgs - 1;
> +	}
> +
> 	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
> 		pr_err("pblk: vector list too big(%u > %u)\n",
> 				pblk->max_write_pgs, =
PBLK_MAX_REQ_ADDRS);
> @@ -668,7 +700,7 @@ static void pblk_set_provision(struct pblk *pblk, =
long nr_free_blks)
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	sector_t provisioned;
> -	int sec_meta, blk_meta;
> +	int sec_meta, blk_meta, clba;
>=20
> 	if (geo->op =3D=3D NVM_TARGET_DEFAULT_OP)
> 		pblk->op =3D PBLK_DEFAULT_OP;
> @@ -691,7 +723,8 @@ static void pblk_set_provision(struct pblk *pblk, =
long nr_free_blks)
> 	sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * =
l_mg->nr_free_lines;
> 	blk_meta =3D DIV_ROUND_UP(sec_meta, geo->clba);
>=20
> -	pblk->capacity =3D (provisioned - blk_meta) * geo->clba;
> +	clba =3D (geo->clba / pblk->min_write_pgs) * =
pblk->min_write_pgs_data;
> +	pblk->capacity =3D (provisioned - blk_meta) * clba;
>=20
> 	atomic_set(&pblk->rl.free_blocks, nr_free_blks);
> 	atomic_set(&pblk->rl.free_user_blocks, nr_free_blks);
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index a81a97e8ea6d..081e73e7978f 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -528,6 +528,9 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb =
*rb, struct nvm_rq *rqd,
> 		to_read =3D count;
> 	}
>=20
> +	/* Add space for packed metadata if in use*/
> +	pad +=3D (pblk->min_write_pgs - pblk->min_write_pgs_data);
> +
> 	c_ctx->sentry =3D pos;
> 	c_ctx->nr_valid =3D to_read;
> 	c_ctx->nr_padded =3D pad;
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index f5853fc77a0c..0fab18fe30d9 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -138,7 +138,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, =
struct pblk_line *line,
> next_read_rq:
> 	memset(rqd, 0, pblk_g_rq_size);
>=20
> -	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0);
> +	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0, false);
> 	if (!rq_ppas)
> 		rq_ppas =3D pblk->min_write_pgs;
> 	rq_len =3D rq_ppas * geo->csecs;
> @@ -198,6 +198,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, =
struct pblk_line *line,
> 		return -EINTR;
> 	}
>=20
> +	pblk_get_packed_meta(pblk, rqd);
> 	for (i =3D 0; i < rqd->nr_ppas; i++) {
> 		u64 lba =3D le64_to_cpu(pblk_get_meta_at(pblk,
> 							meta_list, =
i)->lba);
> @@ -272,7 +273,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	kref_init(&pad_rq->ref);
>=20
> next_pad_rq:
> -	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0);
> +	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0, false);
> 	if (rq_ppas < pblk->min_write_pgs) {
> 		pr_err("pblk: corrupted pad line %d\n", line->id);
> 		goto fail_free_pad;
> @@ -418,7 +419,7 @@ static int pblk_recov_scan_all_oob(struct pblk =
*pblk, struct pblk_line *line,
> next_rq:
> 	memset(rqd, 0, pblk_g_rq_size);
>=20
> -	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0);
> +	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0, false);
> 	if (!rq_ppas)
> 		rq_ppas =3D pblk->min_write_pgs;
> 	rq_len =3D rq_ppas * geo->csecs;
> @@ -475,6 +476,7 @@ static int pblk_recov_scan_all_oob(struct pblk =
*pblk, struct pblk_line *line,
> 	 */
> 	if (!rec_round++ && !rqd->error) {
> 		rec_round =3D 0;
> +		pblk_get_packed_meta(pblk, rqd);
> 		for (i =3D 0; i < rqd->nr_ppas; i++, r_ptr++) {
> 			u64 lba =3D le64_to_cpu(pblk_get_meta_at(pblk,
> 							meta_list, =
i)->lba);
> @@ -492,6 +494,12 @@ static int pblk_recov_scan_all_oob(struct pblk =
*pblk, struct pblk_line *line,
> 		int ret;
>=20
> 		bit =3D find_first_bit((void *)&rqd->ppa_status, =
rqd->nr_ppas);
> +		if (!pblk_is_oob_meta_supported(pblk) && bit > 0) {
> +			/* This case should not happen since we always =
read in
> +			 * the same unit here as we wrote in writer =
thread.
> +			 */
> +			pr_err("pblk: Inconsistent packed metadata =
read\n");
> +		}
> 		nr_error_bits =3D rqd->nr_ppas - bit;
>=20
> 		/* Roll back failed sectors */
> @@ -550,7 +558,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> next_rq:
> 	memset(rqd, 0, pblk_g_rq_size);
>=20
> -	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0);
> +	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0, false);
> 	if (!rq_ppas)
> 		rq_ppas =3D pblk->min_write_pgs;
> 	rq_len =3D rq_ppas * geo->csecs;
> @@ -608,6 +616,14 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 		int nr_error_bits, bit;
>=20
> 		bit =3D find_first_bit((void *)&rqd->ppa_status, =
rqd->nr_ppas);
> +		if (!pblk_is_oob_meta_supported(pblk)) {
> +			/* For packed metadata we do not handle =
partially
> +			 * written requests here, since metadata is =
always
> +			 * in last page on the requests.
> +			 */
> +			bit =3D 0;
> +			*done =3D 0;
> +		}
> 		nr_error_bits =3D rqd->nr_ppas - bit;
>=20
> 		/* Roll back failed sectors */
> @@ -622,6 +638,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 			*done =3D 0;
> 	}
>=20
> +	pblk_get_packed_meta(pblk, rqd);
> 	for (i =3D 0; i < rqd->nr_ppas; i++) {
> 		u64 lba =3D le64_to_cpu(pblk_get_meta_at(pblk,
> 							meta_list, =
i)->lba);
> diff --git a/drivers/lightnvm/pblk-sysfs.c =
b/drivers/lightnvm/pblk-sysfs.c
> index b0e5e93a9d5f..aa7b4164ce9e 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -473,6 +473,13 @@ static ssize_t =
pblk_sysfs_set_sec_per_write(struct pblk *pblk,
> 	if (kstrtouint(page, 0, &sec_per_write))
> 		return -EINVAL;
>=20
> +	if (!pblk_is_oob_meta_supported(pblk)) {
> +		/* For packed metadata case it is
> +		 * not allowed to change sec_per_write.
> +		 */
> +		return -EINVAL;
> +	}
> +
> 	if (sec_per_write < pblk->min_write_pgs
> 				|| sec_per_write > pblk->max_write_pgs
> 				|| sec_per_write % pblk->min_write_pgs =
!=3D 0)
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index 6552db35f916..bb45c7e6c375 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -354,7 +354,7 @@ static int pblk_calc_secs_to_sync(struct pblk =
*pblk, unsigned int secs_avail,
> {
> 	int secs_to_sync;
>=20
> -	secs_to_sync =3D pblk_calc_secs(pblk, secs_avail, =
secs_to_flush);
> +	secs_to_sync =3D pblk_calc_secs(pblk, secs_avail, secs_to_flush, =
true);
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 	if ((!secs_to_sync && secs_to_flush)
> @@ -522,6 +522,11 @@ static int pblk_submit_io_set(struct pblk *pblk, =
struct nvm_rq *rqd)
> 		return NVM_IO_ERR;
> 	}
>=20
> +	/* This is the first place when we have write requests mapped
> +	 * and we can fill packed metadata with l2p mappings.
> +	 */
> +	pblk_set_packed_meta(pblk, rqd);
> +
> 	meta_line =3D pblk_should_submit_meta_io(pblk, rqd);
>=20
> 	/* Submit data write for current data line */
> @@ -572,7 +577,7 @@ static int pblk_submit_write(struct pblk *pblk)
> 	struct bio *bio;
> 	struct nvm_rq *rqd;
> 	unsigned int secs_avail, secs_to_sync, secs_to_com;
> -	unsigned int secs_to_flush;
> +	unsigned int secs_to_flush, packed_meta_pgs;
> 	unsigned long pos;
> 	unsigned int resubmit;
>=20
> @@ -608,7 +613,7 @@ static int pblk_submit_write(struct pblk *pblk)
> 			return 1;
>=20
> 		secs_to_flush =3D pblk_rb_flush_point_count(&pblk->rwb);
> -		if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
> +		if (!secs_to_flush && secs_avail < =
pblk->min_write_pgs_data)
> 			return 1;
>=20
> 		secs_to_sync =3D pblk_calc_secs_to_sync(pblk, =
secs_avail,
> @@ -623,7 +628,8 @@ static int pblk_submit_write(struct pblk *pblk)
> 		pos =3D pblk_rb_read_commit(&pblk->rwb, secs_to_com);
> 	}
>=20
> -	bio =3D bio_alloc(GFP_KERNEL, secs_to_sync);
> +	packed_meta_pgs =3D (pblk->min_write_pgs - =
pblk->min_write_pgs_data);
> +	bio =3D bio_alloc(GFP_KERNEL, secs_to_sync + packed_meta_pgs);
>=20
> 	bio->bi_iter.bi_sector =3D 0; /* internal bio */
> 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 4c61ede5b207..c95ecd8bcf79 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -605,6 +605,7 @@ struct pblk {
> 	int state;			/* pblk line state */
>=20
> 	int min_write_pgs; /* Minimum amount of pages required by =
controller */
> +	int min_write_pgs_data; /* Minimum amount of payload pages */
> 	int max_write_pgs; /* Maximum amount of pages supported by =
controller */
>=20
> 	sector_t capacity; /* Device capacity when bad blocks are =
subtracted */
> @@ -798,7 +799,7 @@ void pblk_dealloc_page(struct pblk *pblk, struct =
pblk_line *line, int nr_secs);
> u64 pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int =
nr_secs);
> u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int =
nr_secs);
> int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
> -		   unsigned long secs_to_flush);
> +		   unsigned long secs_to_flush, bool skip_meta);
> void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas);
> void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas,
> 		  unsigned long *lun_bitmap);
> @@ -823,6 +824,8 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, =
struct ppa_addr *ppas,
> 			  u64 *lba_list, int nr_secs);
> void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
> 			 sector_t blba, int nr_secs);
> +void pblk_set_packed_meta(struct pblk *pblk, struct nvm_rq *rqd);
> +void pblk_get_packed_meta(struct pblk *pblk, struct nvm_rq *rqd);
>=20
> /*
>  * pblk user I/O write path
> --
> 2.14.3

The functionality is good. A couple of comments though:
  - Have you considered the case when the device reports ws_min =3D =
ws_opt
    =3D 4096? Maybe checks preventing this case would be a good idea.
  - Have you checked for any conflicts in the write recovery path? You
    would need to deal with more corner cases (e.g., a write failure in
    the metadata page would require re-sending always all other =
sectors).
  - There are also corner cases on scan recovery: what if the metadata
    page cannot be read? In this case, data loss (at a drive level) will
    happen, but you will need to guarantee that reading garbage will not
    corrupt other data. In the OOB area case this is not a problem
    because data and metadata are always good/not good simultaneously.
  - I think it would be good to update the WA counters, since there is a
    significant write and space amplification in using (1 / ws_opt)
    pages for metadata.

Javier

--Apple-Mail=_F205E415-E8FB-433A-AD59-B6DF148F4F55
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlso5D0ACgkQIX4xUKFR
nnQUohAAzwQj6fIxZAgxC/IBspDCNln7JAE9llrfJA/rE3FZRbrt3OByAWxuiRsv
/aTJyRmC9y6HPcM2tRlxbL64zwjS0B1ilDpCq5RS0P7djYNy2/fonoRm13dVEaRN
eJzRUDEyTN3deyt9QTTJ0oSrd81IWj/apBlCrtln7Z16MLhn3gfZgAUmyUhsNUbv
nfglXB2xsZUH3xjKGvpfxiKp06s1BXIuBzf3cUxgqJGEysrit3OOXMQAJJU3hLaC
dbsb4WW1Gf+feqSuigBwmfXbYEd5CpsWdLyfJf00WdENW2XlW3Gfk6biAzZB5R2Q
jQxXc5ripNceXvDjFuYt0k6peR5Bqi/ElSrP19++ToGYvqW6nGNWc+oY0OQ1c5ic
CZsSWGzRnEDFl+u9blqW3rDTbY/f9TZY7AOoyfHUFakkwGrrpl24MynXmid6/7U3
maw6oWegtHDBniTjb4TPVa+P819WpYp/7WvSUdXMHc8cAIkMvzLto8XHmyFQUzds
+7zsJWudExfZgWvRO7tGxm8uLBaPLlHOTZJ3Asny6RtDm+GCHSo6v/eLN3AhaTJe
IRTDKobsrGC+2LQhw/5LwWJk3kiNZqYShHVImO8voSsuj251ZIHkFHcJYAiahV2X
A+IQKwe+mTmZdxJdDe0pqz4dV/Wl7UPOTvlU2dxFjJR6eKeGYgM=
=Emtg
-----END PGP SIGNATURE-----

--Apple-Mail=_F205E415-E8FB-433A-AD59-B6DF148F4F55--
