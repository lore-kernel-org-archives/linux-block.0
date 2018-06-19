Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com ([104.47.37.61]:38586
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937215AbeFSHod (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jun 2018 03:44:33 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: "Konopko, Igor J" <igor.j.konopko@intel.com>
CC: =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "michal.sorn@intel.com" <michal.sorn@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
Subject: Re: [PATCH 1/5] lightnvm: pblk: Helpers for OOB metadata
Date: Tue, 19 Jun 2018 07:44:27 +0000
Message-ID: <F9DD90CF-7923-493F-A62D-0A352974B19E@cnexlabs.com>
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
 <20180615222706.3801-2-igor.j.konopko@intel.com>
 <196B602A-34CD-444F-BB8A-E59F35046889@cnexlabs.com>
 <6640ddb3-e0de-d82b-5f57-5ee94daa5bad@intel.com>
In-Reply-To: <6640ddb3-e0de-d82b-5f57-5ee94daa5bad@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_F337E9CF-2ED8-4C02-B6FB-99E9DD6AADE3";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_F337E9CF-2ED8-4C02-B6FB-99E9DD6AADE3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

>=20
> On 18 Jun 2018, at 22.53, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
>=20
>=20
> On 18.06.2018 07:23, Javier Gonzalez wrote:
>>> On 16 Jun 2018, at 00.27, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>>>=20
>>> Currently pblk assumes that size of OOB metadata on drive is always
>>> equal to size of pblk_sec_meta struct. This commit add helpers which =
will
>>> allow to handle different sizes of OOB metadata on drive.
>>>=20
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-core.c     | 10 +++++----
>>> drivers/lightnvm/pblk-map.c      | 21 ++++++++++++-------
>>> drivers/lightnvm/pblk-read.c     | 45 =
+++++++++++++++++++++++++---------------
>>> drivers/lightnvm/pblk-recovery.c | 24 ++++++++++++---------
>>> drivers/lightnvm/pblk.h          | 29 ++++++++++++++++++++++++++
>>> 5 files changed, 91 insertions(+), 38 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>> index 66ab1036f2fb..8a0ac466872f 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -685,7 +685,7 @@ static int pblk_line_submit_emeta_io(struct pblk =
*pblk, struct pblk_line *line,
>>> 	rqd.nr_ppas =3D rq_ppas;
>>>=20
>>> 	if (dir =3D=3D PBLK_WRITE) {
>>> -		struct pblk_sec_meta *meta_list =3D rqd.meta_list;
>>> +		void *meta_list =3D rqd.meta_list;
>>>=20
>>> 		rqd.flags =3D pblk_set_progr_mode(pblk, PBLK_WRITE);
>>> 		for (i =3D 0; i < rqd.nr_ppas; ) {
>>> @@ -693,7 +693,8 @@ static int pblk_line_submit_emeta_io(struct pblk =
*pblk, struct pblk_line *line,
>>> 			paddr =3D __pblk_alloc_page(pblk, line, min);
>>> 			spin_unlock(&line->lock);
>>> 			for (j =3D 0; j < min; j++, i++, paddr++) {
>>> -				meta_list[i].lba =3D =
cpu_to_le64(ADDR_EMPTY);
>>> +				pblk_get_meta_at(pblk, meta_list, =
i)->lba =3D
>>> +					cpu_to_le64(ADDR_EMPTY);
>>> 				rqd.ppa_list[i] =3D
>>> 					addr_to_gen_ppa(pblk, paddr, =
id);
>>> 			}
>>> @@ -825,14 +826,15 @@ static int pblk_line_submit_smeta_io(struct =
pblk *pblk, struct pblk_line *line,
>>> 	rqd.nr_ppas =3D lm->smeta_sec;
>>>=20
>>> 	for (i =3D 0; i < lm->smeta_sec; i++, paddr++) {
>>> -		struct pblk_sec_meta *meta_list =3D rqd.meta_list;
>>> +		void *meta_list =3D rqd.meta_list;
>>>=20
>>> 		rqd.ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, =
line->id);
>>>=20
>>> 		if (dir =3D=3D PBLK_WRITE) {
>>> 			__le64 addr_empty =3D cpu_to_le64(ADDR_EMPTY);
>>>=20
>>> -			meta_list[i].lba =3D lba_list[paddr] =3D =
addr_empty;
>>> +			pblk_get_meta_at(pblk, meta_list, i)->lba =3D
>>> +				lba_list[paddr] =3D addr_empty;
>>> 		}
>>> 	}
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-map.c =
b/drivers/lightnvm/pblk-map.c
>>> index 953ca31dda68..92c40b546c4e 100644
>>> --- a/drivers/lightnvm/pblk-map.c
>>> +++ b/drivers/lightnvm/pblk-map.c
>>> @@ -21,7 +21,7 @@
>>> static int pblk_map_page_data(struct pblk *pblk, unsigned int =
sentry,
>>> 			      struct ppa_addr *ppa_list,
>>> 			      unsigned long *lun_bitmap,
>>> -			      struct pblk_sec_meta *meta_list,
>>> +			      void *meta_list,
>>> 			      unsigned int valid_secs)
>>> {
>>> 	struct pblk_line *line =3D pblk_line_get_data(pblk);
>>> @@ -67,14 +67,17 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
>>> 			kref_get(&line->ref);
>>> 			w_ctx =3D pblk_rb_w_ctx(&pblk->rwb, sentry + i);
>>> 			w_ctx->ppa =3D ppa_list[i];
>>> -			meta_list[i].lba =3D cpu_to_le64(w_ctx->lba);
>>> +			pblk_get_meta_at(pblk, meta_list, i)->lba =3D
>>> +							=
cpu_to_le64(w_ctx->lba);
>>> 			lba_list[paddr] =3D cpu_to_le64(w_ctx->lba);
>>> 			if (lba_list[paddr] !=3D addr_empty)
>>> 				line->nr_valid_lbas++;
>>> 			else
>>> 				atomic64_inc(&pblk->pad_wa);
>>> 		} else {
>>> -			lba_list[paddr] =3D meta_list[i].lba =3D =
addr_empty;
>>> +			lba_list[paddr] =3D
>>> +				pblk_get_meta_at(pblk, meta_list, =
i)->lba =3D
>>> +					addr_empty;
>>> 			__pblk_map_invalidate(pblk, line, paddr);
>>> 		}
>>> 	}
>>> @@ -87,7 +90,7 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
>>> 		 unsigned long *lun_bitmap, unsigned int valid_secs,
>>> 		 unsigned int off)
>>> {
>>> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
>>> +	void *meta_list =3D rqd->meta_list;
>>> 	unsigned int map_secs;
>>> 	int min =3D pblk->min_write_pgs;
>>> 	int i;
>>> @@ -95,7 +98,9 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
>>> 	for (i =3D off; i < rqd->nr_ppas; i +=3D min) {
>>> 		map_secs =3D (i + min > valid_secs) ? (valid_secs % min) =
: min;
>>> 		if (pblk_map_page_data(pblk, sentry + i, =
&rqd->ppa_list[i],
>>> -					lun_bitmap, &meta_list[i], =
map_secs)) {
>>> +					lun_bitmap,
>>> +					pblk_get_meta_at(pblk, =
meta_list, i),
>>> +					map_secs)) {
>>> 			bio_put(rqd->bio);
>>> 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
>>> 			pblk_pipeline_stop(pblk);
>>> @@ -111,7 +116,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> 	struct nvm_geo *geo =3D &dev->geo;
>>> 	struct pblk_line_meta *lm =3D &pblk->lm;
>>> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
>>> +	void *meta_list =3D rqd->meta_list;
>>> 	struct pblk_line *e_line, *d_line;
>>> 	unsigned int map_secs;
>>> 	int min =3D pblk->min_write_pgs;
>>> @@ -120,7 +125,9 @@ void pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
>>> 	for (i =3D 0; i < rqd->nr_ppas; i +=3D min) {
>>> 		map_secs =3D (i + min > valid_secs) ? (valid_secs % min) =
: min;
>>> 		if (pblk_map_page_data(pblk, sentry + i, =
&rqd->ppa_list[i],
>>> -					lun_bitmap, &meta_list[i], =
map_secs)) {
>>> +					lun_bitmap,
>>> +					pblk_get_meta_at(pblk, =
meta_list, i),
>>> +					map_secs)) {
>>> 			bio_put(rqd->bio);
>>> 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
>>> 			pblk_pipeline_stop(pblk);
>>> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
>>> index 6e93c489ce57..81cf79ea2dc6 100644
>>> --- a/drivers/lightnvm/pblk-read.c
>>> +++ b/drivers/lightnvm/pblk-read.c
>>> @@ -42,7 +42,7 @@ static void pblk_read_ppalist_rq(struct pblk =
*pblk, struct nvm_rq *rqd,
>>> 				 struct bio *bio, sector_t blba,
>>> 				 unsigned long *read_bitmap)
>>> {
>>> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
>>> +	void *meta_list =3D rqd->meta_list;
>>> 	struct ppa_addr ppas[PBLK_MAX_REQ_ADDRS];
>>> 	int nr_secs =3D rqd->nr_ppas;
>>> 	bool advanced_bio =3D false;
>>> @@ -57,7 +57,8 @@ static void pblk_read_ppalist_rq(struct pblk =
*pblk, struct nvm_rq *rqd,
>>> retry:
>>> 		if (pblk_ppa_empty(p)) {
>>> 			WARN_ON(test_and_set_bit(i, read_bitmap));
>>> -			meta_list[i].lba =3D cpu_to_le64(ADDR_EMPTY);
>>> +			pblk_get_meta_at(pblk, meta_list, i)->lba =3D
>>> +					cpu_to_le64(ADDR_EMPTY);
>>>=20
>>> 			if (unlikely(!advanced_bio)) {
>>> 				bio_advance(bio, (i) * =
PBLK_EXPOSED_PAGE_SIZE);
>>> @@ -77,7 +78,8 @@ static void pblk_read_ppalist_rq(struct pblk =
*pblk, struct nvm_rq *rqd,
>>> 				goto retry;
>>> 			}
>>> 			WARN_ON(test_and_set_bit(i, read_bitmap));
>>> -			meta_list[i].lba =3D cpu_to_le64(lba);
>>> +			pblk_get_meta_at(pblk, meta_list, i)->lba =3D
>>> +					cpu_to_le64(lba);
>>> 			advanced_bio =3D true;
>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>> 			atomic_long_inc(&pblk->cache_reads);
>>> @@ -106,13 +108,16 @@ static void pblk_read_ppalist_rq(struct pblk =
*pblk, struct nvm_rq *rqd,
>>> static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq =
*rqd,
>>> 				sector_t blba)
>>> {
>>> -	struct pblk_sec_meta *meta_lba_list =3D rqd->meta_list;
>>> +	void *meta_lba_list =3D rqd->meta_list;
>>> 	int nr_lbas =3D rqd->nr_ppas;
>>> 	int i;
>>>=20
>>> -	for (i =3D 0; i < nr_lbas; i++) {
>>> -		u64 lba =3D le64_to_cpu(meta_lba_list[i].lba);
>>> +	if (!pblk_is_oob_meta_supported(pblk))
>>> +		return;
>>>=20
>>> +	for (i =3D 0; i < nr_lbas; i++) {
>>> +		u64 lba =3D le64_to_cpu(
>>> +				pblk_get_meta_at(pblk, meta_lba_list, =
i)->lba);
>>> 		if (lba =3D=3D ADDR_EMPTY)
>>> 			continue;
>>>=20
>>> @@ -136,17 +141,21 @@ static void pblk_read_check_seq(struct pblk =
*pblk, struct nvm_rq *rqd,
>>> static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq =
*rqd,
>>> 				 u64 *lba_list, int nr_lbas)
>>> {
>>> -	struct pblk_sec_meta *meta_lba_list =3D rqd->meta_list;
>>> +	void *meta_lba_list =3D rqd->meta_list;
>>> 	int i, j;
>>>=20
>>> -	for (i =3D 0, j =3D 0; i < nr_lbas; i++) {
>>> +	if (!pblk_is_oob_meta_supported(pblk))
>>> +		return;
>>> +
>>> +	for (i =3D 0; j =3D 0, i < nr_lbas; i++) {
>>> 		u64 lba =3D lba_list[i];
>>> 		u64 meta_lba;
>>>=20
>>> 		if (lba =3D=3D ADDR_EMPTY)
>>> 			continue;
>>>=20
>>> -		meta_lba =3D le64_to_cpu(meta_lba_list[j].lba);
>>> +		meta_lba =3D le64_to_cpu(
>>> +				pblk_get_meta_at(pblk, meta_lba_list, =
i)->lba);
>>>=20
>>> 		if (lba !=3D meta_lba) {
>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>> @@ -235,7 +244,7 @@ static int pblk_partial_read(struct pblk *pblk, =
struct nvm_rq *rqd,
>>> 			     struct bio *orig_bio, unsigned int =
bio_init_idx,
>>> 			     unsigned long *read_bitmap)
>>> {
>>> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
>>> +	void *meta_list =3D rqd->meta_list;
>>> 	struct bio *new_bio;
>>> 	struct bio_vec src_bv, dst_bv;
>>> 	void *ppa_ptr =3D NULL;
>>> @@ -261,7 +270,7 @@ static int pblk_partial_read(struct pblk *pblk, =
struct nvm_rq *rqd,
>>> 	}
>>>=20
>>> 	for (i =3D 0; i < nr_secs; i++)
>>> -		lba_list_mem[i] =3D meta_list[i].lba;
>>> +		lba_list_mem[i] =3D pblk_get_meta_at(pblk, meta_list, =
i)->lba;
>>>=20
>>> 	new_bio->bi_iter.bi_sector =3D 0; /* internal bio */
>>> 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
>>> @@ -300,8 +309,8 @@ static int pblk_partial_read(struct pblk *pblk, =
struct nvm_rq *rqd,
>>> 	}
>>>=20
>>> 	for (i =3D 0; i < nr_secs; i++) {
>>> -		lba_list_media[i] =3D meta_list[i].lba;
>>> -		meta_list[i].lba =3D lba_list_mem[i];
>>> +		lba_list_media[i] =3D pblk_get_meta_at(pblk, meta_list, =
i)->lba;
>>> +		pblk_get_meta_at(pblk, meta_list, i)->lba =3D =
lba_list_mem[i];
>>> 	}
>>>=20
>>> 	/* Fill the holes in the original bio */
>>> @@ -313,7 +322,8 @@ static int pblk_partial_read(struct pblk *pblk, =
struct nvm_rq *rqd,
>>>=20
>>> 		kref_put(&line->ref, pblk_line_put);
>>>=20
>>> -		meta_list[hole].lba =3D lba_list_media[i];
>>> +		pblk_get_meta_at(pblk, meta_list, hole)->lba =3D
>>> +						lba_list_media[i];
>>>=20
>>> 		src_bv =3D new_bio->bi_io_vec[i++];
>>> 		dst_bv =3D orig_bio->bi_io_vec[bio_init_idx + hole];
>>> @@ -354,7 +364,7 @@ static int pblk_partial_read(struct pblk *pblk, =
struct nvm_rq *rqd,
>>> static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, =
struct bio *bio,
>>> 			 sector_t lba, unsigned long *read_bitmap)
>>> {
>>> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
>>> +	void *meta_list =3D rqd->meta_list;
>>> 	struct ppa_addr ppa;
>>>=20
>>> 	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
>>> @@ -366,7 +376,8 @@ static void pblk_read_rq(struct pblk *pblk, =
struct nvm_rq *rqd, struct bio *bio,
>>> retry:
>>> 	if (pblk_ppa_empty(ppa)) {
>>> 		WARN_ON(test_and_set_bit(0, read_bitmap));
>>> -		meta_list[0].lba =3D cpu_to_le64(ADDR_EMPTY);
>>> +		pblk_get_meta_at(pblk, meta_list, 0)->lba =3D
>>> +						cpu_to_le64(ADDR_EMPTY);
>>> 		return;
>>> 	}
>>>=20
>>> @@ -380,7 +391,7 @@ static void pblk_read_rq(struct pblk *pblk, =
struct nvm_rq *rqd, struct bio *bio,
>>> 		}
>>>=20
>>> 		WARN_ON(test_and_set_bit(0, read_bitmap));
>>> -		meta_list[0].lba =3D cpu_to_le64(lba);
>>> +		pblk_get_meta_at(pblk, meta_list, 0)->lba =3D =
cpu_to_le64(lba);
>>>=20
>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>> 		atomic_long_inc(&pblk->cache_reads);
>>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>>> index b1a91cb3ca4d..0007e8011476 100644
>>> --- a/drivers/lightnvm/pblk-recovery.c
>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>> @@ -98,7 +98,7 @@ static int pblk_calc_sec_in_line(struct pblk =
*pblk, struct pblk_line *line)
>>>=20
>>> struct pblk_recov_alloc {
>>> 	struct ppa_addr *ppa_list;
>>> -	struct pblk_sec_meta *meta_list;
>>> +	void *meta_list;
>>> 	struct nvm_rq *rqd;
>>> 	void *data;
>>> 	dma_addr_t dma_ppa_list;
>>> @@ -111,7 +111,7 @@ static int pblk_recov_read_oob(struct pblk =
*pblk, struct pblk_line *line,
>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> 	struct nvm_geo *geo =3D &dev->geo;
>>> 	struct ppa_addr *ppa_list;
>>> -	struct pblk_sec_meta *meta_list;
>>> +	void *meta_list;
>>> 	struct nvm_rq *rqd;
>>> 	struct bio *bio;
>>> 	void *data;
>>> @@ -199,7 +199,8 @@ static int pblk_recov_read_oob(struct pblk =
*pblk, struct pblk_line *line,
>>> 	}
>>>=20
>>> 	for (i =3D 0; i < rqd->nr_ppas; i++) {
>>> -		u64 lba =3D le64_to_cpu(meta_list[i].lba);
>>> +		u64 lba =3D le64_to_cpu(pblk_get_meta_at(pblk,
>>> +							meta_list, =
i)->lba);
>>>=20
>>> 		if (lba =3D=3D ADDR_EMPTY || lba > pblk->rl.nr_secs)
>>> 			continue;
>>> @@ -240,7 +241,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, =
struct pblk_line *line,
>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> 	struct nvm_geo *geo =3D &dev->geo;
>>> 	struct ppa_addr *ppa_list;
>>> -	struct pblk_sec_meta *meta_list;
>>> +	void *meta_list;
>>> 	struct pblk_pad_rq *pad_rq;
>>> 	struct nvm_rq *rqd;
>>> 	struct bio *bio;
>>> @@ -332,7 +333,8 @@ static int pblk_recov_pad_oob(struct pblk *pblk, =
struct pblk_line *line,
>>> 			dev_ppa =3D addr_to_gen_ppa(pblk, w_ptr, =
line->id);
>>>=20
>>> 			pblk_map_invalidate(pblk, dev_ppa);
>>> -			lba_list[w_ptr] =3D meta_list[i].lba =3D =
addr_empty;
>>> +			lba_list[w_ptr] =3D pblk_get_meta_at(pblk,
>>> +						meta_list, i)->lba =3D =
addr_empty;
>>> 			rqd->ppa_list[i] =3D dev_ppa;
>>> 		}
>>> 	}
>>> @@ -389,7 +391,7 @@ static int pblk_recov_scan_all_oob(struct pblk =
*pblk, struct pblk_line *line,
>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> 	struct nvm_geo *geo =3D &dev->geo;
>>> 	struct ppa_addr *ppa_list;
>>> -	struct pblk_sec_meta *meta_list;
>>> +	void *meta_list;
>>> 	struct nvm_rq *rqd;
>>> 	struct bio *bio;
>>> 	void *data;
>>> @@ -473,7 +475,8 @@ static int pblk_recov_scan_all_oob(struct pblk =
*pblk, struct pblk_line *line,
>>> 	if (!rec_round++ && !rqd->error) {
>>> 		rec_round =3D 0;
>>> 		for (i =3D 0; i < rqd->nr_ppas; i++, r_ptr++) {
>>> -			u64 lba =3D le64_to_cpu(meta_list[i].lba);
>>> +			u64 lba =3D le64_to_cpu(pblk_get_meta_at(pblk,
>>> +							meta_list, =
i)->lba);
>>>=20
>>> 			if (lba =3D=3D ADDR_EMPTY || lba > =
pblk->rl.nr_secs)
>>> 				continue;
>>> @@ -523,7 +526,7 @@ static int pblk_recov_scan_oob(struct pblk =
*pblk, struct pblk_line *line,
>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> 	struct nvm_geo *geo =3D &dev->geo;
>>> 	struct ppa_addr *ppa_list;
>>> -	struct pblk_sec_meta *meta_list;
>>> +	void *meta_list;
>>> 	struct nvm_rq *rqd;
>>> 	struct bio *bio;
>>> 	void *data;
>>> @@ -619,7 +622,8 @@ static int pblk_recov_scan_oob(struct pblk =
*pblk, struct pblk_line *line,
>>> 	}
>>>=20
>>> 	for (i =3D 0; i < rqd->nr_ppas; i++) {
>>> -		u64 lba =3D le64_to_cpu(meta_list[i].lba);
>>> +		u64 lba =3D le64_to_cpu(pblk_get_meta_at(pblk,
>>> +							meta_list, =
i)->lba);
>>>=20
>>> 		if (lba =3D=3D ADDR_EMPTY || lba > pblk->rl.nr_secs)
>>> 			continue;
>>> @@ -641,7 +645,7 @@ static int pblk_recov_l2p_from_oob(struct pblk =
*pblk, struct pblk_line *line)
>>> 	struct nvm_geo *geo =3D &dev->geo;
>>> 	struct nvm_rq *rqd;
>>> 	struct ppa_addr *ppa_list;
>>> -	struct pblk_sec_meta *meta_list;
>>> +	void *meta_list;
>>> 	struct pblk_recov_alloc p;
>>> 	void *data;
>>> 	dma_addr_t dma_ppa_list, dma_meta_list;
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index c072955d72c2..f82c3a0b0de5 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -1420,4 +1420,33 @@ static inline void pblk_setup_uuid(struct =
pblk *pblk)
>>> 	uuid_le_gen(&uuid);
>>> 	memcpy(pblk->instance_uuid, uuid.b, 16);
>>> }
>>> +
>>> +static inline int pblk_is_oob_meta_supported(struct pblk *pblk)
>>> +{
>>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> +	struct nvm_geo *geo =3D &dev->geo;
>>> +
>>> +	/* Pblk uses OOB meta to store LBA of given physical sector.
>>> +	 * The LBA is eventually used in recovery mode and/or for =
handling
>>> +	 * telemetry events (e.g., relocate sector).
>>> +	 */
>>> +
>>> +	return (geo->sos >=3D sizeof(struct pblk_sec_meta));
>>> +}
>>> +
>> In principle, we need 8 bytes for storing the lba in pblk, if the OOB
>> area is not big enough, I'm ok with making this optional, but if so,
>> there should be a comment that some of the pfail recovery will not be
>> supported.
>> If you are not facing this problem, then I would suggest failing pblk
>> creation in case the metadata size is not big store the lba.
>=20
> I belive that all the potential problems should be solved with
> functionality added in patch 4 (except of verifying LBA on read
> completion) - rest like dirty shutdown recovery, etc. should have the
> same level of confidence - if I'm missing sth else let me know.
>=20

I'll look at the other patches now. The case I'm thinking is if the
device reports a metadata size less than 8 bytes.

Regarding the lba check, it is not mandatory, but it is an usual check
that can safe debug time in case that the upper layers see data
corruption.


--Apple-Mail=_F337E9CF-2ED8-4C02-B6FB-99E9DD6AADE3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsotFgACgkQIX4xUKFR
nnTKCw/+ITs3ki+Rr4gs5SyIC+0jjKQeuMmqWsxNVi4vqruCz9NEX1ZF9xmW4hOC
MbjvQStSauMRlFIgkDLtWR9tmfRitrJOnRUctULQj/FruqfRCmgMjUgnQ/yeEFHK
loSBQEOZitQCcWTm63OpEU3mhPLDy6T/a4AJc7XHXDWlJ9NUktBBKmEGTUobxLdm
r9nxG9WZH9MsmhLpIowf74l8GbSaoA4LHPj7EDgRrewQjBQawhRzYNo5CUzoFs0M
ATsBfGh5LQFNTtICJHRKIfreqyEfbry+9OUd1ClORm25+eutxJ3kbhbhvC12jbVb
v9BNdJ7l+Zls8vzHuFbkarARWMgCopFq+xzUmyY4WG7e8+lqlzBfedVl0QWpumZe
LtSYc12FgNZIT+mIZI7qrwKdASXT/1oeDSKXUpTWdeCayxcJl4veHl6cXeJPMGjm
ItQ30TB00KZ64XoEBZGHdnxFKHCzRzxpiSpc4j3nbovKY1KZv/yf0YWN/v0gDSHO
yTzHU1sl/ORb1sldJWduRcZFdGP8Vuh7I9eQB6iR4ld0T4Ok1l0r7Nsbh+BYyn59
Du9hrwCW7kU3GHGiMnVffAQThclQsxFeIIFgy9ezSAD4ZlRA72AKZ0BLqeDGINdI
r3UJs/TmshJMPpnKha/Lgz2CuPnbTVKXeFNzuT+sXASP4HzGCew=
=FDni
-----END PGP SIGNATURE-----

--Apple-Mail=_F337E9CF-2ED8-4C02-B6FB-99E9DD6AADE3--
