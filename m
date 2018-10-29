Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0089.outbound.protection.outlook.com ([104.47.42.89]:61360
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729631AbeJ2TBf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Oct 2018 15:01:35 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: "Konopko, Igor J" <igor.j.konopko@intel.com>
CC: =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "hans.ml.holmberg@owltronix.com" <hans.ml.holmberg@owltronix.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] lightnvm: pblk: Helpers for OOB metadata
Date: Mon, 29 Oct 2018 10:13:32 +0000
Message-ID: <CB3F0005-5801-45B5-8DE3-6FFB7FE9B002@cnexlabs.com>
References: <20181022103611.39271-1-igor.j.konopko@intel.com>
 <20181022103611.39271-3-igor.j.konopko@intel.com>
In-Reply-To: <20181022103611.39271-3-igor.j.konopko@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1F04CE32-DE6A-4854-BA2B-E982C12D5B8F";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_1F04CE32-DE6A-4854-BA2B-E982C12D5B8F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 22 Oct 2018, at 12.36, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently pblk assumes that size of OOB metadata on drive is always
> equal to size of pblk_sec_meta struct. This commit add helpers which =
will
> allow to handle different sizes of OOB metadata on drive.

Probably want to mention the constrain that the OOB is still required to
the > sizeof(struct pblk_sec_meta). We will add a new disk format and
remove this on a later patch (I was actually expecting this to be on the
current series though).

>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c     |  5 +++--
> drivers/lightnvm/pblk-map.c      | 20 +++++++++++-------
> drivers/lightnvm/pblk-read.c     | 45 =
+++++++++++++++++++++++++---------------
> drivers/lightnvm/pblk-recovery.c | 13 ++++++------
> drivers/lightnvm/pblk.h          | 22 ++++++++++++++++++++
> 5 files changed, 73 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 6944aac43b01..0f33055f40eb 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -796,10 +796,11 @@ static int pblk_line_smeta_write(struct pblk =
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
> +		pblk_set_meta_lba(pblk, meta_list, i, addr_empty);
> +		lba_list[paddr] =3D addr_empty;
> 	}
>=20
> 	ret =3D pblk_submit_io_sync_sem(pblk, &rqd);
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 6dcbd44e3acb..4bae30129bc9 100644
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
> @@ -68,14 +68,16 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
> 			kref_get(&line->ref);
> 			w_ctx =3D pblk_rb_w_ctx(&pblk->rwb, sentry + i);
> 			w_ctx->ppa =3D ppa_list[i];
> -			meta_list[i].lba =3D cpu_to_le64(w_ctx->lba);
> +			pblk_set_meta_lba(pblk, meta_list, i,
> +					  cpu_to_le64(w_ctx->lba));
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
addr_empty);
> 			__pblk_map_invalidate(pblk, line, paddr);
> 		}
> 	}
> @@ -88,7 +90,8 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
> 		 unsigned long *lun_bitmap, unsigned int valid_secs,
> 		 unsigned int off)
> {
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> +	void *meta_buffer;
> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	unsigned int map_secs;
> 	int min =3D pblk->min_write_pgs;
> @@ -96,8 +99,9 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
>=20
> 	for (i =3D off; i < rqd->nr_ppas; i +=3D min) {
> 		map_secs =3D (i + min > valid_secs) ? (valid_secs % min) =
: min;
> +		meta_buffer =3D pblk_get_meta(pblk, meta_list, i);
> 		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
> -					lun_bitmap, &meta_list[i], =
map_secs)) {
> +					lun_bitmap, meta_buffer, =
map_secs)) {
> 			bio_put(rqd->bio);
> 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
> 			pblk_pipeline_stop(pblk);
> @@ -113,7 +117,8 @@ void pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> +	void *meta_buffer;
> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	struct pblk_line *e_line, *d_line;
> 	unsigned int map_secs;
> @@ -122,8 +127,9 @@ void pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
>=20
> 	for (i =3D 0; i < rqd->nr_ppas; i +=3D min) {
> 		map_secs =3D (i + min > valid_secs) ? (valid_secs % min) =
: min;
> +		meta_buffer =3D pblk_get_meta(pblk, meta_list, i);
> 		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
> -					lun_bitmap, &meta_list[i], =
map_secs)) {
> +					lun_bitmap, meta_buffer, =
map_secs)) {
> 			bio_put(rqd->bio);
> 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
> 			pblk_pipeline_stop(pblk);
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 19917d3c19b3..cc73a1594180 100644
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
> @@ -57,8 +57,10 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
>=20
> retry:
> 		if (pblk_ppa_empty(p)) {
> +			__le64 addr_empty =3D cpu_to_le64(ADDR_EMPTY);
> +
> 			WARN_ON(test_and_set_bit(i, read_bitmap));
> -			meta_list[i].lba =3D cpu_to_le64(ADDR_EMPTY);
> +			pblk_set_meta_lba(pblk, meta_list, i, =
addr_empty);
>=20
> 			if (unlikely(!advanced_bio)) {
> 				bio_advance(bio, (i) * =
PBLK_EXPOSED_PAGE_SIZE);
> @@ -78,7 +80,8 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> 				goto retry;
> 			}
> 			WARN_ON(test_and_set_bit(i, read_bitmap));
> -			meta_list[i].lba =3D cpu_to_le64(lba);
> +			pblk_set_meta_lba(pblk, meta_list, i,
> +					  cpu_to_le64(lba));
> 			advanced_bio =3D true;
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 			atomic_long_inc(&pblk->cache_reads);
> @@ -105,12 +108,12 @@ static void pblk_read_ppalist_rq(struct pblk =
*pblk, struct nvm_rq *rqd,
> static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
> 				sector_t blba)
> {
> -	struct pblk_sec_meta *meta_lba_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	int nr_lbas =3D rqd->nr_ppas;
> 	int i;
>=20
> 	for (i =3D 0; i < nr_lbas; i++) {
> -		u64 lba =3D le64_to_cpu(meta_lba_list[i].lba);
> +		u64 lba =3D le64_to_cpu(pblk_get_meta_lba(pblk, =
meta_list, i));
>=20
> 		if (lba =3D=3D ADDR_EMPTY)
> 			continue;
> @@ -134,7 +137,7 @@ static void pblk_read_check_seq(struct pblk *pblk, =
struct nvm_rq *rqd,
> static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq =
*rqd,
> 				 u64 *lba_list, int nr_lbas)
> {
> -	struct pblk_sec_meta *meta_lba_list =3D rqd->meta_list;
> +	void *meta_lba_list =3D rqd->meta_list;
> 	int i, j;
>=20
> 	for (i =3D 0, j =3D 0; i < nr_lbas; i++) {
> @@ -144,7 +147,8 @@ static void pblk_read_check_rand(struct pblk =
*pblk, struct nvm_rq *rqd,
> 		if (lba =3D=3D ADDR_EMPTY)
> 			continue;
>=20
> -		meta_lba =3D le64_to_cpu(meta_lba_list[j].lba);
> +		meta_lba =3D le64_to_cpu(pblk_get_meta_lba(pblk,
> +							 meta_lba_list, =
j));
>=20
> 		if (lba !=3D meta_lba) {
> #ifdef CONFIG_NVM_PBLK_DEBUG
> @@ -219,7 +223,7 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 	struct bio *new_bio =3D rqd->bio;
> 	struct bio *bio =3D pr_ctx->orig_bio;
> 	struct bio_vec src_bv, dst_bv;
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	int bio_init_idx =3D pr_ctx->bio_init_idx;
> 	unsigned long *read_bitmap =3D pr_ctx->bitmap;
> 	int nr_secs =3D pr_ctx->orig_nr_secs;
> @@ -237,8 +241,10 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 	}
>=20
> 	for (i =3D 0; i < nr_secs; i++) {
> -		pr_ctx->lba_list_media[i] =3D meta_list[i].lba;
> -		meta_list[i].lba =3D pr_ctx->lba_list_mem[i];
> +		pr_ctx->lba_list_media[i] =3D =
le64_to_cpu(pblk_get_meta_lba(pblk,
> +							meta_list, i));
> +		pblk_set_meta_lba(pblk, meta_list, i,
> +				  cpu_to_le64(pr_ctx->lba_list_mem[i]));
> 	}
>=20
> 	/* Fill the holes in the original bio */
> @@ -250,7 +256,8 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 		line =3D pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
> 		kref_put(&line->ref, pblk_line_put);
>=20
> -		meta_list[hole].lba =3D pr_ctx->lba_list_media[i];
> +		pblk_set_meta_lba(pblk, meta_list, hole,
> +				  =
cpu_to_le64(pr_ctx->lba_list_media[i]));
>=20
> 		src_bv =3D new_bio->bi_io_vec[i++];
> 		dst_bv =3D bio->bi_io_vec[bio_init_idx + hole];
> @@ -286,7 +293,7 @@ static int pblk_setup_partial_read(struct pblk =
*pblk, struct nvm_rq *rqd,
> 			    unsigned long *read_bitmap,
> 			    int nr_holes)
> {
> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> +	void *meta_list =3D rqd->meta_list;
> 	struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> 	struct pblk_pr_ctx *pr_ctx;
> 	struct bio *new_bio, *bio =3D r_ctx->private;
> @@ -307,8 +314,10 @@ static int pblk_setup_partial_read(struct pblk =
*pblk, struct nvm_rq *rqd,
> 	if (!pr_ctx)
> 		goto fail_free_pages;
>=20
> -	for (i =3D 0; i < nr_secs; i++)
> -		pr_ctx->lba_list_mem[i] =3D meta_list[i].lba;
> +	for (i =3D 0; i < nr_secs; i++) {
> +		pr_ctx->lba_list_mem[i] =3D =
le64_to_cpu(pblk_get_meta_lba(pblk,
> +							      meta_list, =
i));
> +	}
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
> @@ -384,8 +393,10 @@ static void pblk_read_rq(struct pblk *pblk, =
struct nvm_rq *rqd, struct bio *bio,
>=20
> retry:
> 	if (pblk_ppa_empty(ppa)) {
> +		__le64 addr_empty =3D cpu_to_le64(ADDR_EMPTY);
> +
> 		WARN_ON(test_and_set_bit(0, read_bitmap));
> -		meta_list[0].lba =3D cpu_to_le64(ADDR_EMPTY);
> +		pblk_set_meta_lba(pblk, meta_list, 0, addr_empty);
> 		return;
> 	}
>=20
> @@ -399,7 +410,7 @@ static void pblk_read_rq(struct pblk *pblk, struct =
nvm_rq *rqd, struct bio *bio,
> 		}
>=20
> 		WARN_ON(test_and_set_bit(0, read_bitmap));
> -		meta_list[0].lba =3D cpu_to_le64(lba);
> +		pblk_set_meta_lba(pblk, meta_list, 0, cpu_to_le64(lba));
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 		atomic_long_inc(&pblk->cache_reads);
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 5740b7509bd8..977b2ca5d849 100644
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
addr_empty);
> 			rqd->ppa_list[i] =3D dev_ppa;
> 		}
> 	}
> @@ -336,7 +337,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct ppa_addr *ppa_list;
> -	struct pblk_sec_meta *meta_list;
> +	void *meta_list;
> 	struct nvm_rq *rqd;
> 	struct bio *bio;
> 	void *data;
> @@ -434,7 +435,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	}
>=20
> 	for (i =3D 0; i < rqd->nr_ppas; i++) {
> -		u64 lba =3D le64_to_cpu(meta_list[i].lba);
> +		u64 lba =3D le64_to_cpu(pblk_get_meta_lba(pblk, =
meta_list, i));
>=20
> 		lba_list[paddr++] =3D cpu_to_le64(lba);
>=20
> @@ -463,7 +464,7 @@ static int pblk_recov_l2p_from_oob(struct pblk =
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
> index 2aca840c7838..d09c1b341e07 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -1372,4 +1372,26 @@ static inline char *pblk_disk_name(struct pblk =
*pblk)
>=20
> 	return disk->disk_name;
> }
> +
> +static inline struct pblk_sec_meta *pblk_get_meta(struct pblk *pblk,
> +							 void *meta, int =
index)
> +{
> +	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> +
> +	return meta + max_t(int, geo->sos, sizeof(struct pblk_sec_meta))
> +		* index;
> +}
> +
> +static inline void pblk_set_meta_lba(struct pblk *pblk, void *meta,
> +				     int index, __le64 lba)
> +{
> +	pblk_get_meta(pblk, meta, index)->lba =3D lba;
> +}
> +
> +static inline __le64 pblk_get_meta_lba(struct pblk *pblk, void *meta,
> +				    int index)
> +{
> +	return pblk_get_meta(pblk, meta, index)->lba;
> +}
> #endif /* PBLK_H_ */

Why not just return pblk_sec_meta and remove the set/get helpers? It
also simplifies some of the changes you have all over the code to cast
to void *meta_list.

Javier

--Apple-Mail=_1F04CE32-DE6A-4854-BA2B-E982C12D5B8F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlvW3UsACgkQIX4xUKFR
nnRMqxAAnKvI/uK/dzJCcyq09/Ku4sHhEVu51rfXvo9gFwQUd6KzlbDvN8qiYkjL
XhNCb2+Yyo89pYC9c4EzQsZMtPQ/ZO5LrVd0hhuEVyHjGoMvbaTHPOH6EmZaGy8i
O+Lw65MzwWMjTtkmyCOvDdyzGGU1+ufkYd4Q3JSNi4LT2gTJd//PHQCTMvyycJMQ
YteuQh2FvQBg1F0qu9Kd+D+9IWcqYe6m5wD0OTrwopB4f4Vjf5c/O7PVg4ze9bfN
Kx2qb8yVBf4fTFycBpvM8QpudqlX3b5Zyh/h+1BqT2TahkqP9HpCwyELied/rZea
wNDyVt8Onq8Kb4Jzkuzg+wpt84HtqfxY0cOAEYOgYK0ySqh0JFR+VVkZh4DTOijU
W/M1HCS0a1OBymbfkrmabXmIKpDZf0FBPKKTjQg9WXHAIFxSwkPFuA1SMVA70qlB
yFh003IhdSD6yeV02TjQrZHchVKrZN+xYpRIBHKq6+7N7fiACzjC2SKA+heBGHlR
Rifa+qIycUjjpl1eRLBrBoRFUNZVGVeq4QfXfT9YfaGUKTxlNUrE84JK/HB8baxS
ys7hwehPCsk61hDTkzMNzetxDJgq6HXbeaR5cmKgD9AYL5zcfeDUusSL7EO92L/q
8lDjLLndFb2MPMEUlUtI0qWEm1xGYcs1y+sjh17p4oDwfNfWNqE=
=7YjC
-----END PGP SIGNATURE-----

--Apple-Mail=_1F04CE32-DE6A-4854-BA2B-E982C12D5B8F--
