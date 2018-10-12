Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0088.outbound.protection.outlook.com ([104.47.32.88]:26880
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbeJLTYy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Oct 2018 15:24:54 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Igor Konopko <igor.j.konopko@intel.com>
CC: "mb@lightnvm.io" <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
Subject: Re: [PATCH 2/5] lightnvm: pblk: Helpers for OOB metadata
Date: Fri, 12 Oct 2018 11:52:38 +0000
Message-ID: <785BAF00-5693-459E-B2E1-45B5BF7DEFE5@cnexlabs.com>
References: <20181005133437.25255-1-igor.j.konopko@intel.com>
 <20181005133437.25255-3-igor.j.konopko@intel.com>
In-Reply-To: <20181005133437.25255-3-igor.j.konopko@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1D0C310A-B525-4064-949D-A1F9A7DB1FD0";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_1D0C310A-B525-4064-949D-A1F9A7DB1FD0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 5 Oct 2018, at 15.34, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently pblk assumes that size of OOB metadata on drive is always
> equal to size of pblk_sec_meta struct. This commit add helpers which =
will
> allow to handle different sizes of OOB metadata on drive.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c     |  6 ++---
> drivers/lightnvm/pblk-map.c      | 21 ++++++++++------
> drivers/lightnvm/pblk-read.c     | 41 +++++++++++++++++++-------------
> drivers/lightnvm/pblk-recovery.c | 14 ++++++-----
> drivers/lightnvm/pblk.h          | 37 +++++++++++++++++++++++++++-
> 5 files changed, 86 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 6944aac43b01..7cb39d84c833 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -743,7 +743,6 @@ int pblk_line_smeta_read(struct pblk *pblk, struct =
pblk_line *line)
> 	rqd.opcode =3D NVM_OP_PREAD;
> 	rqd.nr_ppas =3D lm->smeta_sec;
> 	rqd.is_seq =3D 1;
> -

no need for removing this space

> 	for (i =3D 0; i < lm->smeta_sec; i++, paddr++)
> 		rqd.ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, =
line->id);
>=20
> @@ -796,10 +795,11 @@ static int pblk_line_smeta_write(struct pblk =
*pblk, struct pblk_line *line,
> 	rqd.is_seq =3D 1;
>=20
> 	for (i =3D 0; i < lm->smeta_sec; i++, paddr++) {
> -		struct pblk_sec_meta *meta_list =3D rqd.meta_list;
> +		void *meta_list =3D rqd.meta_list;
>=20
> 		rqd.ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, =
line->id);
> -		meta_list[i].lba =3D lba_list[paddr] =3D addr_empty;
> +		pblk_set_meta_lba(pblk, meta_list, i, ADDR_EMPTY);
> +		lba_list[paddr] =3D addr_empty;
> 	}
>=20
> 	ret =3D pblk_submit_io_sync_sem(pblk, &rqd);
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 6dcbd44e3acb..4c7a9909308e 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -22,7 +22,7 @@
> static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
> 			      struct ppa_addr *ppa_list,
> 			      unsigned long *lun_bitmap,
> -			      struct pblk_sec_meta *meta_list,
> +			      void *meta_list,
> 			      unsigned int valid_secs)
> {
> 	struct pblk_line *line =3D pblk_line_get_data(pblk);
> @@ -68,14 +68,15 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
> 			kref_get(&line->ref);
> 			w_ctx =3D pblk_rb_w_ctx(&pblk->rwb, sentry + i);
> 			w_ctx->ppa =3D ppa_list[i];
> -			meta_list[i].lba =3D cpu_to_le64(w_ctx->lba);
> +			pblk_set_meta_lba(pblk, meta_list, i, =
w_ctx->lba);
> 			lba_list[paddr] =3D cpu_to_le64(w_ctx->lba);
> 			if (lba_list[paddr] !=3D addr_empty)
> 				line->nr_valid_lbas++;
> 			else
> 				atomic64_inc(&pblk->pad_wa);
> 		} else {
> -			lba_list[paddr] =3D meta_list[i].lba =3D =
addr_empty;
> +			lba_list[paddr] =3D addr_empty;
> +			pblk_set_meta_lba(pblk, meta_list, i, =
ADDR_EMPTY);
> 			__pblk_map_invalidate(pblk, line, paddr);
> 		}
> 	}
> @@ -88,7 +89,7 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
> 		 unsigned long *lun_bitmap, unsigned int valid_secs,
> 		 unsigned int off)
> {
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	unsigned int map_secs;
> 	int min =3D pblk->min_write_pgs;
> @@ -97,7 +98,10 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
> 	for (i =3D off; i < rqd->nr_ppas; i +=3D min) {
> 		map_secs =3D (i + min > valid_secs) ? (valid_secs % min) =
: min;
> 		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
> -					lun_bitmap, &meta_list[i], =
map_secs)) {
> +					lun_bitmap,
> +					pblk_get_meta_buffer(pblk,
> +							     meta_list, =
i),
> +					map_secs)) {

This part of the code is already difficult to read with so many
parameters. Can you assign the metadata buffer before instead to make it
clearer?

> 			bio_put(rqd->bio);
> 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
> 			pblk_pipeline_stop(pblk);
> @@ -113,7 +117,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	struct pblk_line *e_line, *d_line;
> 	unsigned int map_secs;
> @@ -123,7 +127,10 @@ void pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
> 	for (i =3D 0; i < rqd->nr_ppas; i +=3D min) {
> 		map_secs =3D (i + min > valid_secs) ? (valid_secs % min) =
: min;
> 		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
> -					lun_bitmap, &meta_list[i], =
map_secs)) {
> +					lun_bitmap,
> +					pblk_get_meta_buffer(pblk,
> +							     meta_list, =
i),
> +					map_secs)) {

Same as above

> 			bio_put(rqd->bio);
> 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
> 			pblk_pipeline_stop(pblk);
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 08f6ebd4bc48..6584a2588f61 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -43,7 +43,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> 				 struct bio *bio, sector_t blba,
> 				 unsigned long *read_bitmap)
> {
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	struct ppa_addr ppas[NVM_MAX_VLBA];
> 	int nr_secs =3D rqd->nr_ppas;
> 	bool advanced_bio =3D false;
> @@ -58,7 +58,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> retry:
> 		if (pblk_ppa_empty(p)) {
> 			WARN_ON(test_and_set_bit(i, read_bitmap));
> -			meta_list[i].lba =3D cpu_to_le64(ADDR_EMPTY);
> +			pblk_set_meta_lba(pblk, meta_list, i, =
ADDR_EMPTY);
>=20
> 			if (unlikely(!advanced_bio)) {
> 				bio_advance(bio, (i) * =
PBLK_EXPOSED_PAGE_SIZE);
> @@ -78,7 +78,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> 				goto retry;
> 			}
> 			WARN_ON(test_and_set_bit(i, read_bitmap));
> -			meta_list[i].lba =3D cpu_to_le64(lba);
> +			pblk_set_meta_lba(pblk, meta_list, i, lba);
> 			advanced_bio =3D true;
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 			atomic_long_inc(&pblk->cache_reads);
> @@ -105,12 +105,15 @@ static void pblk_read_ppalist_rq(struct pblk =
*pblk, struct nvm_rq *rqd,
> static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
> 				sector_t blba)
> {
> -	struct pblk_sec_meta *meta_lba_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	int nr_lbas =3D rqd->nr_ppas;
> 	int i;
>=20
> +	if (!pblk_is_oob_meta_supported(pblk))
> +		return;
> +

Since this patch is only creating the helpers, I would add this to the
patch when you add support for packed metadata.

> 	for (i =3D 0; i < nr_lbas; i++) {
> -		u64 lba =3D le64_to_cpu(meta_lba_list[i].lba);
> +		u64 lba =3D pblk_get_meta_lba(pblk, meta_list, i);
>=20
> 		if (lba =3D=3D ADDR_EMPTY)
> 			continue;
> @@ -134,9 +137,12 @@ static void pblk_read_check_seq(struct pblk =
*pblk, struct nvm_rq *rqd,
> static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq =
*rqd,
> 				 u64 *lba_list, int nr_lbas)
> {
> -	struct pblk_sec_meta *meta_lba_list =3D rqd->meta_list;
> +	void *meta_lba_list =3D rqd->meta_list;
> 	int i, j;
>=20
> +	if (!pblk_is_oob_meta_supported(pblk))
> +		return;

Same as above

> +
> 	for (i =3D 0, j =3D 0; i < nr_lbas; i++) {
> 		u64 lba =3D lba_list[i];
> 		u64 meta_lba;
> @@ -144,7 +150,7 @@ static void pblk_read_check_rand(struct pblk =
*pblk, struct nvm_rq *rqd,
> 		if (lba =3D=3D ADDR_EMPTY)
> 			continue;
>=20
> -		meta_lba =3D le64_to_cpu(meta_lba_list[j].lba);
> +		meta_lba =3D pblk_get_meta_lba(pblk, meta_lba_list, j);
>=20
> 		if (lba !=3D meta_lba) {
> #ifdef CONFIG_NVM_PBLK_DEBUG
> @@ -219,7 +225,7 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 	struct bio *new_bio =3D rqd->bio;
> 	struct bio *bio =3D pr_ctx->orig_bio;
> 	struct bio_vec src_bv, dst_bv;
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	int bio_init_idx =3D pr_ctx->bio_init_idx;
> 	unsigned long *read_bitmap =3D pr_ctx->bitmap;
> 	int nr_secs =3D pr_ctx->orig_nr_secs;
> @@ -237,8 +243,10 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 	}
>=20
> 	for (i =3D 0; i < nr_secs; i++) {
> -		pr_ctx->lba_list_media[i] =3D meta_list[i].lba;
> -		meta_list[i].lba =3D pr_ctx->lba_list_mem[i];
> +		pr_ctx->lba_list_media[i] =3D pblk_get_meta_lba(pblk,
> +							meta_list, i);
> +		pblk_set_meta_lba(pblk, meta_list, i,
> +				  pr_ctx->lba_list_mem[i]);

This fits in a single line

> 	}
>=20
> 	/* Fill the holes in the original bio */
> @@ -250,7 +258,8 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 		line =3D pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
> 		kref_put(&line->ref, pblk_line_put);
>=20
> -		meta_list[hole].lba =3D pr_ctx->lba_list_media[i];
> +		pblk_set_meta_lba(pblk, meta_list, hole,
> +				  pr_ctx->lba_list_media[i]);
>=20
> 		src_bv =3D new_bio->bi_io_vec[i++];
> 		dst_bv =3D bio->bi_io_vec[bio_init_idx + hole];
> @@ -286,7 +295,7 @@ static int pblk_setup_partial_read(struct pblk =
*pblk, struct nvm_rq *rqd,
> 			    unsigned long *read_bitmap,
> 			    int nr_holes)
> {
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> 	struct pblk_pr_ctx *pr_ctx;
> 	struct bio *new_bio, *bio =3D r_ctx->private;
> @@ -308,7 +317,7 @@ static int pblk_setup_partial_read(struct pblk =
*pblk, struct nvm_rq *rqd,
> 		goto fail_free_pages;
>=20
> 	for (i =3D 0; i < nr_secs; i++)
> -		pr_ctx->lba_list_mem[i] =3D meta_list[i].lba;
> +		pr_ctx->lba_list_mem[i] =3D pblk_get_meta_lba(pblk, =
meta_list, i);
>=20
> 	new_bio->bi_iter.bi_sector =3D 0; /* internal bio */
> 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
> @@ -373,7 +382,7 @@ static int pblk_partial_read_bio(struct pblk =
*pblk, struct nvm_rq *rqd,
> static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct =
bio *bio,
> 			 sector_t lba, unsigned long *read_bitmap)
> {
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	struct ppa_addr ppa;
>=20
> 	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
> @@ -385,7 +394,7 @@ static void pblk_read_rq(struct pblk *pblk, struct =
nvm_rq *rqd, struct bio *bio,
> retry:
> 	if (pblk_ppa_empty(ppa)) {
> 		WARN_ON(test_and_set_bit(0, read_bitmap));
> -		meta_list[0].lba =3D cpu_to_le64(ADDR_EMPTY);
> +		pblk_set_meta_lba(pblk, meta_list, 0, ADDR_EMPTY);
> 		return;
> 	}
>=20
> @@ -399,7 +408,7 @@ static void pblk_read_rq(struct pblk *pblk, struct =
nvm_rq *rqd, struct bio *bio,
> 		}
>=20
> 		WARN_ON(test_and_set_bit(0, read_bitmap));
> -		meta_list[0].lba =3D cpu_to_le64(lba);
> +		pblk_set_meta_lba(pblk, meta_list, 0, lba);
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 		atomic_long_inc(&pblk->cache_reads);
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 5740b7509bd8..fa63f9fa5ba8 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -124,7 +124,7 @@ static u64 pblk_sec_in_open_line(struct pblk =
*pblk, struct pblk_line *line)
>=20
> struct pblk_recov_alloc {
> 	struct ppa_addr *ppa_list;
> -	struct pblk_sec_meta *meta_list;
> +	void *meta_list;
> 	struct nvm_rq *rqd;
> 	void *data;
> 	dma_addr_t dma_ppa_list;
> @@ -158,7 +158,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> -	struct pblk_sec_meta *meta_list;
> +	void *meta_list;
> 	struct pblk_pad_rq *pad_rq;
> 	struct nvm_rq *rqd;
> 	struct bio *bio;
> @@ -242,7 +242,8 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> 			dev_ppa =3D addr_to_gen_ppa(pblk, w_ptr, =
line->id);
>=20
> 			pblk_map_invalidate(pblk, dev_ppa);
> -			lba_list[w_ptr] =3D meta_list[i].lba =3D =
addr_empty;
> +			lba_list[w_ptr] =3D addr_empty;
> +			pblk_set_meta_lba(pblk, meta_list, i, =
ADDR_EMPTY);
> 			rqd->ppa_list[i] =3D dev_ppa;
> 		}
> 	}
> @@ -325,6 +326,7 @@ static int pblk_line_wp_is_unbalanced(struct pblk =
*pblk,
> 			return 1;
> 		else if (chunk->wp < line_wp)
> 			line_wp =3D chunk->wp;
> +
> 	}
>=20
> 	return 0;
> @@ -336,7 +338,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct ppa_addr *ppa_list;
> -	struct pblk_sec_meta *meta_list;
> +	void *meta_list;
> 	struct nvm_rq *rqd;
> 	struct bio *bio;
> 	void *data;
> @@ -434,7 +436,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	}
>=20
> 	for (i =3D 0; i < rqd->nr_ppas; i++) {
> -		u64 lba =3D le64_to_cpu(meta_list[i].lba);
> +		u64 lba =3D pblk_get_meta_lba(pblk, meta_list, i);
>=20
> 		lba_list[paddr++] =3D cpu_to_le64(lba);
>=20
> @@ -463,7 +465,7 @@ static int pblk_recov_l2p_from_oob(struct pblk =
*pblk, struct pblk_line *line)
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct nvm_rq *rqd;
> 	struct ppa_addr *ppa_list;
> -	struct pblk_sec_meta *meta_list;
> +	void *meta_list;
> 	struct pblk_recov_alloc p;
> 	void *data;
> 	dma_addr_t dma_ppa_list, dma_meta_list;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index aea09879636f..53156b6f99a3 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -87,7 +87,6 @@ enum {
> };
>=20
> struct pblk_sec_meta {
> -	u64 reserved;
> 	__le64 lba;
> };

i would move this to a separate patch. I would suggest that you do it
together with the patch that changes the device format adding
information on the OOB area supported and making this part of smeta and
emeta. When we push the ftl log, we will take this into account too.

>=20
> @@ -1366,4 +1365,40 @@ static inline char *pblk_disk_name(struct pblk =
*pblk)
>=20
> 	return disk->disk_name;
> }
> +
> +static inline int pblk_is_oob_meta_supported(struct pblk *pblk)
> +{
> +	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> +
> +	/* Pblk uses OOB meta to store LBA of given physical sector.
> +	 * The LBA is eventually used in recovery mode and/or for =
handling
> +	 * telemetry events (e.g., relocate sector).
> +	 */
> +

If you want to keep this comment, I think it is more informative on top
of struct pblk_sec_meta (). Here you can explain when metadata is packed
and when in OOB.

> +	return (geo->sos >=3D sizeof(struct pblk_sec_meta));
> +}
> +
> +static inline struct pblk_sec_meta *pblk_get_meta_buffer(struct pblk =
*pblk,
> +							 void *meta_ptr,
> +							 int index)
> +{
> +	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> +
> +	return meta_ptr + max_t(int, geo->sos, sizeof(struct =
pblk_sec_meta))
> +		* index;
> +}
> +
> +static inline void pblk_set_meta_lba(struct pblk *pblk, void =
*meta_ptr,
> +				     int index, u64 lba)
> +{
> +	pblk_get_meta_buffer(pblk, meta_ptr, index)->lba =3D =
cpu_to_le64(lba);
> +}
> +
> +static inline u64 pblk_get_meta_lba(struct pblk *pblk, void =
*meta_ptr,
> +				    int index)
> +{
> +	return le64_to_cpu(pblk_get_meta_buffer(pblk, meta_ptr, =
index)->lba);
> +}
> #endif /* PBLK_H_ */
> --
> 2.17.1

Apart form the comments above, the patch looks good to me

Javier

--Apple-Mail=_1D0C310A-B525-4064-949D-A1F9A7DB1FD0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlvAiwQACgkQIX4xUKFR
nnRc2A/+LkBRPbfeHPEbWanoZtgQwBccI3K4c2/7NUnXzrQNAnirBKs2lMORbxSu
3DPHGKlO3ZcRARm0UwEnGrlOzN0XiFOQEK2OrcKNpzTFF/3bA58DmKZhDtzK0RVT
ojtEQqiUmfMR3AedgfZZayHTzX4K4PGv4R64TO4rQon3g7yoo99SImh8ptplZqFL
LZ6/hy1fkjmo8aVSxdXeMsOF/RWZ+3Zh6uU0jE8+PFdymFjv4Kmtq4kQ8edKaXm4
DwGVoBmQUazn23PlD8fDS/s/1D5tVesD1AufM7LO7tLfRCP1eiKQaEfQGXD60EqZ
PPLEm3OspWRS73l0DnnugkHtyUk1H9ay8edOSihlhXSL1gRNhOUTdx0LNwvf0pLN
l4fHzYTmxWCCQnD05mEiUwRmanMnvT4TmoVHPX1jvExzr/PC1sQG2ym6mV9WyMym
SQfpLCAPMzLOvCdkusd5s9CEm5BamayMPJIjr/Y4QMr05PqbU7n9Yo9lTq/4UQJ5
+sHQ8DeZE30O2eQnROc2S5NTw8GGI3KQvmTKzYlSfkvzkbV05xRVa6gdtCAOEJ+F
88rjpsBAU/VpzfRE7A2O+GGR0M6uqCsHDyIZypGwNE/6Z7gmwmsPl2DedpDZ6kCD
Bgqonyio9o3hBjOqvtjCPKynA/Nlq2/Qj8gZsXwaL7eRZvCk1Og=
=zb61
-----END PGP SIGNATURE-----

--Apple-Mail=_1D0C310A-B525-4064-949D-A1F9A7DB1FD0--
