Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com ([104.47.32.76]:8944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751657AbeBVHom (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 02:44:42 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 01/20] lightnvm: simplify geometry structure.
Date: Thu, 22 Feb 2018 07:44:38 +0000
Message-ID: <C2488688-5E97-4D50-AF3E-1737BC4EC2B4@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-2-git-send-email-javier@cnexlabs.com>
 <a2536c29-4e04-9b85-adb9-a014feb06cfd@lightnvm.io>
In-Reply-To: <a2536c29-4e04-9b85-adb9-a014feb06cfd@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_24659DA3-EC99-4059-9349-FA3DACCEC50D";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_24659DA3-EC99-4059-9349-FA3DACCEC50D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 22 Feb 2018, at 08.25, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/21/2018 10:26 AM, Javier Gonz=C3=A1lez wrote:
>> Currently, the device geometry is stored redundantly in the nvm_id =
and
>> nvm_geo structures at a device level. Moreover, when instantiating
>> targets on a specific number of LUNs, these structures are replicated
>> and manually modified to fit the instance channel and LUN =
partitioning.
>> Instead, create a generic geometry around two base structures:
>> nvm_dev_geo, which describes the geometry of the whole device and
>> nvm_geo, which describes the geometry of the instance. Since these =
share
>> a big part of the geometry, create a nvm_common_geo structure that =
keeps
>> the static geoometry values that are shared across instances.
>> As we introduce support for 2.0, these structures allow to abstract
>> spec. specific values and present a common geometry to targets.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/core.c          | 137 +++++++---------
>>  drivers/lightnvm/pblk-core.c     |  16 +-
>>  drivers/lightnvm/pblk-gc.c       |   2 +-
>>  drivers/lightnvm/pblk-init.c     | 123 +++++++-------
>>  drivers/lightnvm/pblk-read.c     |   2 +-
>>  drivers/lightnvm/pblk-recovery.c |  14 +-
>>  drivers/lightnvm/pblk-rl.c       |   2 +-
>>  drivers/lightnvm/pblk-sysfs.c    |  39 +++--
>>  drivers/lightnvm/pblk-write.c    |   2 +-
>>  drivers/lightnvm/pblk.h          |  93 +++++------
>>  drivers/nvme/host/lightnvm.c     | 339 =
+++++++++++++++++++++++----------------
>>  include/linux/lightnvm.h         | 204 ++++++++++++-----------
>>  12 files changed, 514 insertions(+), 459 deletions(-)
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 689c97b97775..42596afdf64c 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -111,6 +111,7 @@ static void nvm_release_luns_err(struct nvm_dev =
*dev, int lun_begin,
>>  static void nvm_remove_tgt_dev(struct nvm_tgt_dev *tgt_dev, int =
clear)
>>  {
>>  	struct nvm_dev *dev =3D tgt_dev->parent;
>> +	struct nvm_dev_geo *dev_geo =3D &dev->dev_geo;
>>  	struct nvm_dev_map *dev_map =3D tgt_dev->map;
>>  	int i, j;
>>  @@ -122,7 +123,7 @@ static void nvm_remove_tgt_dev(struct =
nvm_tgt_dev *tgt_dev, int clear)
>>  		if (clear) {
>>  			for (j =3D 0; j < ch_map->nr_luns; j++) {
>>  				int lun =3D j + lun_offs[j];
>> -				int lunid =3D (ch * dev->geo.nr_luns) + =
lun;
>> +				int lunid =3D (ch * dev_geo->nr_luns) + =
lun;
>>    				WARN_ON(!test_and_clear_bit(lunid,
>>  							dev->lun_map));
>> @@ -143,19 +144,20 @@ static struct nvm_tgt_dev =
*nvm_create_tgt_dev(struct nvm_dev *dev,
>>  					      u16 lun_begin, u16 =
lun_end,
>>  					      u16 op)
>>  {
>> +	struct nvm_dev_geo *dev_geo =3D &dev->dev_geo;
>>  	struct nvm_tgt_dev *tgt_dev =3D NULL;
>>  	struct nvm_dev_map *dev_rmap =3D dev->rmap;
>>  	struct nvm_dev_map *dev_map;
>>  	struct ppa_addr *luns;
>>  	int nr_luns =3D lun_end - lun_begin + 1;
>>  	int luns_left =3D nr_luns;
>> -	int nr_chnls =3D nr_luns / dev->geo.nr_luns;
>> -	int nr_chnls_mod =3D nr_luns % dev->geo.nr_luns;
>> -	int bch =3D lun_begin / dev->geo.nr_luns;
>> -	int blun =3D lun_begin % dev->geo.nr_luns;
>> +	int nr_chnls =3D nr_luns / dev_geo->nr_luns;
>> +	int nr_chnls_mod =3D nr_luns % dev_geo->nr_luns;
>> +	int bch =3D lun_begin / dev_geo->nr_luns;
>> +	int blun =3D lun_begin % dev_geo->nr_luns;
>>  	int lunid =3D 0;
>>  	int lun_balanced =3D 1;
>> -	int prev_nr_luns;
>> +	int sec_per_lun, prev_nr_luns;
>>  	int i, j;
>>    	nr_chnls =3D (nr_chnls_mod =3D=3D 0) ? nr_chnls : nr_chnls + 1;
>> @@ -173,15 +175,15 @@ static struct nvm_tgt_dev =
*nvm_create_tgt_dev(struct nvm_dev *dev,
>>  	if (!luns)
>>  		goto err_luns;
>>  -	prev_nr_luns =3D (luns_left > dev->geo.nr_luns) ?
>> -					dev->geo.nr_luns : luns_left;
>> +	prev_nr_luns =3D (luns_left > dev_geo->nr_luns) ?
>> +					dev_geo->nr_luns : luns_left;
>>  	for (i =3D 0; i < nr_chnls; i++) {
>>  		struct nvm_ch_map *ch_rmap =3D &dev_rmap->chnls[i + =
bch];
>>  		int *lun_roffs =3D ch_rmap->lun_offs;
>>  		struct nvm_ch_map *ch_map =3D &dev_map->chnls[i];
>>  		int *lun_offs;
>> -		int luns_in_chnl =3D (luns_left > dev->geo.nr_luns) ?
>> -					dev->geo.nr_luns : luns_left;
>> +		int luns_in_chnl =3D (luns_left > dev_geo->nr_luns) ?
>> +					dev_geo->nr_luns : luns_left;
>>    		if (lun_balanced && prev_nr_luns !=3D luns_in_chnl)
>>  			lun_balanced =3D 0;
>> @@ -215,18 +217,22 @@ static struct nvm_tgt_dev =
*nvm_create_tgt_dev(struct nvm_dev *dev,
>>  	if (!tgt_dev)
>>  		goto err_ch;
>>  -	memcpy(&tgt_dev->geo, &dev->geo, sizeof(struct nvm_geo));
>>  	/* Target device only owns a portion of the physical device */
>>  	tgt_dev->geo.nr_chnls =3D nr_chnls;
>> -	tgt_dev->geo.all_luns =3D nr_luns;
>>  	tgt_dev->geo.nr_luns =3D (lun_balanced) ? prev_nr_luns : -1;
>> +	tgt_dev->geo.all_luns =3D nr_luns;
>> +	tgt_dev->geo.all_chunks =3D nr_luns * dev_geo->c.num_chk;
>> +
>>  	tgt_dev->geo.op =3D op;
>> -	tgt_dev->total_secs =3D nr_luns * tgt_dev->geo.sec_per_lun;
>> +
>> +	sec_per_lun =3D dev_geo->c.clba * dev_geo->c.num_chk;
>> +	tgt_dev->geo.total_secs =3D nr_luns * sec_per_lun;
>> +
>> +	tgt_dev->geo.c =3D dev_geo->c;
>> +
>>  	tgt_dev->q =3D dev->q;
>>  	tgt_dev->map =3D dev_map;
>>  	tgt_dev->luns =3D luns;
>> -	memcpy(&tgt_dev->identity, &dev->identity, sizeof(struct =
nvm_id));
>> -
>>  	tgt_dev->parent =3D dev;
>>    	return tgt_dev;
>> @@ -268,12 +274,12 @@ static struct nvm_tgt_type =
*nvm_find_target_type(const char *name)
>>  	return tt;
>>  }
>>  -static int nvm_config_check_luns(struct nvm_geo *geo, int =
lun_begin,
>> +static int nvm_config_check_luns(struct nvm_dev_geo *dev_geo, int =
lun_begin,
>>  				 int lun_end)
>>  {
>> -	if (lun_begin > lun_end || lun_end >=3D geo->all_luns) {
>> +	if (lun_begin > lun_end || lun_end >=3D dev_geo->all_luns) {
>>  		pr_err("nvm: lun out of bound (%u:%u > %u)\n",
>> -			lun_begin, lun_end, geo->all_luns - 1);
>> +			lun_begin, lun_end, dev_geo->all_luns - 1);
>>  		return -EINVAL;
>>  	}
>>  @@ -283,24 +289,24 @@ static int nvm_config_check_luns(struct =
nvm_geo *geo, int lun_begin,
>>  static int __nvm_config_simple(struct nvm_dev *dev,
>>  			       struct nvm_ioctl_create_simple *s)
>>  {
>> -	struct nvm_geo *geo =3D &dev->geo;
>> +	struct nvm_dev_geo *dev_geo =3D &dev->dev_geo;
>>    	if (s->lun_begin =3D=3D -1 && s->lun_end =3D=3D -1) {
>>  		s->lun_begin =3D 0;
>> -		s->lun_end =3D geo->all_luns - 1;
>> +		s->lun_end =3D dev_geo->all_luns - 1;
>>  	}
>>  -	return nvm_config_check_luns(geo, s->lun_begin, s->lun_end);
>> +	return nvm_config_check_luns(dev_geo, s->lun_begin, s->lun_end);
>>  }
>>    static int __nvm_config_extended(struct nvm_dev *dev,
>>  				 struct nvm_ioctl_create_extended *e)
>>  {
>> -	struct nvm_geo *geo =3D &dev->geo;
>> +	struct nvm_dev_geo *dev_geo =3D &dev->dev_geo;
>>    	if (e->lun_begin =3D=3D 0xFFFF && e->lun_end =3D=3D 0xFFFF) {
>>  		e->lun_begin =3D 0;
>> -		e->lun_end =3D dev->geo.all_luns - 1;
>> +		e->lun_end =3D dev_geo->all_luns - 1;
>>  	}
>>    	/* op not set falls into target's default */
>> @@ -313,7 +319,7 @@ static int __nvm_config_extended(struct nvm_dev =
*dev,
>>  		return -EINVAL;
>>  	}
>>  -	return nvm_config_check_luns(geo, e->lun_begin, e->lun_end);
>> +	return nvm_config_check_luns(dev_geo, e->lun_begin, e->lun_end);
>>  }
>>    static int nvm_create_tgt(struct nvm_dev *dev, struct =
nvm_ioctl_create *create)
>> @@ -408,7 +414,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_create *create)
>>  	tqueue->queuedata =3D targetdata;
>>    	blk_queue_max_hw_sectors(tqueue,
>> -			(dev->geo.sec_size >> 9) * NVM_MAX_VLBA);
>> +			(dev->dev_geo.c.csecs >> 9) * NVM_MAX_VLBA);
>>    	set_capacity(tdisk, tt->capacity(targetdata));
>>  	add_disk(tdisk);
>> @@ -497,6 +503,7 @@ static int nvm_remove_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_remove *remove)
>>    static int nvm_register_map(struct nvm_dev *dev)
>>  {
>> +	struct nvm_dev_geo *dev_geo =3D &dev->dev_geo;
>>  	struct nvm_dev_map *rmap;
>>  	int i, j;
>>  @@ -504,15 +511,15 @@ static int nvm_register_map(struct nvm_dev =
*dev)
>>  	if (!rmap)
>>  		goto err_rmap;
>>  -	rmap->chnls =3D kcalloc(dev->geo.nr_chnls, sizeof(struct =
nvm_ch_map),
>> +	rmap->chnls =3D kcalloc(dev_geo->nr_chnls, sizeof(struct =
nvm_ch_map),
>>  								=
GFP_KERNEL);
>>  	if (!rmap->chnls)
>>  		goto err_chnls;
>>  -	for (i =3D 0; i < dev->geo.nr_chnls; i++) {
>> +	for (i =3D 0; i < dev_geo->nr_chnls; i++) {
>>  		struct nvm_ch_map *ch_rmap;
>>  		int *lun_roffs;
>> -		int luns_in_chnl =3D dev->geo.nr_luns;
>> +		int luns_in_chnl =3D dev_geo->nr_luns;
>>    		ch_rmap =3D &rmap->chnls[i];
>>  @@ -543,10 +550,11 @@ static int nvm_register_map(struct nvm_dev =
*dev)
>>    static void nvm_unregister_map(struct nvm_dev *dev)
>>  {
>> +	struct nvm_dev_geo *dev_geo =3D &dev->dev_geo;
>>  	struct nvm_dev_map *rmap =3D dev->rmap;
>>  	int i;
>>  -	for (i =3D 0; i < dev->geo.nr_chnls; i++)
>> +	for (i =3D 0; i < dev_geo->nr_chnls; i++)
>>  		kfree(rmap->chnls[i].lun_offs);
>>    	kfree(rmap->chnls);
>> @@ -675,7 +683,7 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev =
*tgt_dev, struct nvm_rq *rqd,
>>  	int i, plane_cnt, pl_idx;
>>  	struct ppa_addr ppa;
>>  -	if (geo->plane_mode =3D=3D NVM_PLANE_SINGLE && nr_ppas =3D=3D 1) =
{
>> +	if (geo->c.pln_mode =3D=3D NVM_PLANE_SINGLE && nr_ppas =3D=3D 1) =
{
>>  		rqd->nr_ppas =3D nr_ppas;
>>  		rqd->ppa_addr =3D ppas[0];
>>  @@ -689,7 +697,7 @@ static int nvm_set_rqd_ppalist(struct =
nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
>>  		return -ENOMEM;
>>  	}
>>  -	plane_cnt =3D geo->plane_mode;
>> +	plane_cnt =3D geo->c.pln_mode;
>>  	rqd->nr_ppas *=3D plane_cnt;
>>    	for (i =3D 0; i < nr_ppas; i++) {
>> @@ -804,18 +812,18 @@ EXPORT_SYMBOL(nvm_end_io);
>>   */
>>  int nvm_bb_tbl_fold(struct nvm_dev *dev, u8 *blks, int nr_blks)
>>  {
>> -	struct nvm_geo *geo =3D &dev->geo;
>> +	struct nvm_dev_geo *dev_geo =3D &dev->dev_geo;
>>  	int blk, offset, pl, blktype;
>>  -	if (nr_blks !=3D geo->nr_chks * geo->plane_mode)
>> +	if (nr_blks !=3D dev_geo->c.num_chk * dev_geo->c.pln_mode)
>>  		return -EINVAL;
>>  -	for (blk =3D 0; blk < geo->nr_chks; blk++) {
>> -		offset =3D blk * geo->plane_mode;
>> +	for (blk =3D 0; blk < dev_geo->c.num_chk; blk++) {
>> +		offset =3D blk * dev_geo->c.pln_mode;
>>  		blktype =3D blks[offset];
>>    		/* Bad blocks on any planes take precedence over other =
types */
>> -		for (pl =3D 0; pl < geo->plane_mode; pl++) {
>> +		for (pl =3D 0; pl < dev_geo->c.pln_mode; pl++) {
>>  			if (blks[offset + pl] &
>>  					=
(NVM_BLK_T_BAD|NVM_BLK_T_GRWN_BAD)) {
>>  				blktype =3D blks[offset + pl];
>> @@ -826,7 +834,7 @@ int nvm_bb_tbl_fold(struct nvm_dev *dev, u8 =
*blks, int nr_blks)
>>  		blks[blk] =3D blktype;
>>  	}
>>  -	return geo->nr_chks;
>> +	return dev_geo->c.num_chk;
>>  }
>>  EXPORT_SYMBOL(nvm_bb_tbl_fold);
>>  @@ -843,41 +851,10 @@ EXPORT_SYMBOL(nvm_get_tgt_bb_tbl);
>>    static int nvm_core_init(struct nvm_dev *dev)
>>  {
>> -	struct nvm_id *id =3D &dev->identity;
>> -	struct nvm_geo *geo =3D &dev->geo;
>> +	struct nvm_dev_geo *dev_geo =3D &dev->dev_geo;
>>  	int ret;
>>  -	memcpy(&geo->ppaf, &id->ppaf, sizeof(struct nvm_addr_format));
>> -
>> -	if (id->mtype !=3D 0) {
>> -		pr_err("nvm: memory type not supported\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	/* Whole device values */
>> -	geo->nr_chnls =3D id->num_ch;
>> -	geo->nr_luns =3D id->num_lun;
>> -
>> -	/* Generic device geometry values */
>> -	geo->ws_min =3D id->ws_min;
>> -	geo->ws_opt =3D id->ws_opt;
>> -	geo->ws_seq =3D id->ws_seq;
>> -	geo->ws_per_chk =3D id->ws_per_chk;
>> -	geo->nr_chks =3D id->num_chk;
>> -	geo->mccap =3D id->mccap;
>> -
>> -	geo->sec_per_chk =3D id->clba;
>> -	geo->sec_per_lun =3D geo->sec_per_chk * geo->nr_chks;
>> -	geo->all_luns =3D geo->nr_luns * geo->nr_chnls;
>> -
>> -	/* 1.2 spec device geometry values */
>> -	geo->plane_mode =3D 1 << geo->ws_seq;
>> -	geo->nr_planes =3D geo->ws_opt / geo->ws_min;
>> -	geo->sec_per_pg =3D geo->ws_min;
>> -	geo->sec_per_pl =3D geo->sec_per_pg * geo->nr_planes;
>> -
>> -	dev->total_secs =3D geo->all_luns * geo->sec_per_lun;
>> -	dev->lun_map =3D kcalloc(BITS_TO_LONGS(geo->all_luns),
>> +	dev->lun_map =3D kcalloc(BITS_TO_LONGS(dev_geo->all_luns),
>>  					sizeof(unsigned long), =
GFP_KERNEL);
>>  	if (!dev->lun_map)
>>  		return -ENOMEM;
>> @@ -912,19 +889,17 @@ static void nvm_free(struct nvm_dev *dev)
>>    static int nvm_init(struct nvm_dev *dev)
>>  {
>> -	struct nvm_geo *geo =3D &dev->geo;
>> +	struct nvm_dev_geo *dev_geo =3D &dev->dev_geo;
>>  	int ret =3D -EINVAL;
>>  -	if (dev->ops->identity(dev, &dev->identity)) {
>> +	if (dev->ops->identity(dev)) {
>>  		pr_err("nvm: device could not be identified\n");
>>  		goto err;
>>  	}
>>  -	if (dev->identity.ver_id !=3D 1 && dev->identity.ver_id !=3D 2) =
{
>> -		pr_err("nvm: device ver_id %d not supported by =
kernel.\n",
>> -				dev->identity.ver_id);
>> -		goto err;
>> -	}
>> +	pr_debug("nvm: ver:%u nvm_vendor:%x\n",
>> +				dev_geo->ver_id,
>> +				dev_geo->c.vmnt);
>>    	ret =3D nvm_core_init(dev);
>>  	if (ret) {
>> @@ -932,10 +907,10 @@ static int nvm_init(struct nvm_dev *dev)
>>  		goto err;
>>  	}
>>  -	pr_info("nvm: registered %s [%u/%u/%u/%u/%u/%u]\n",
>> -			dev->name, geo->sec_per_pg, geo->nr_planes,
>> -			geo->ws_per_chk, geo->nr_chks,
>> -			geo->all_luns, geo->nr_chnls);
>> +	pr_info("nvm: registered %s [%u/%u/%u/%u/%u]\n",
>> +			dev->name, dev_geo->c.ws_min, dev_geo->c.ws_opt,
>> +			dev_geo->c.num_chk, dev_geo->all_luns,
>> +			dev_geo->nr_chnls);
>>  	return 0;
>>  err:
>>  	pr_err("nvm: failed to initialize nvm\n");
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 22e61cd4f801..519af8b9eab7 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -613,7 +613,7 @@ static int pblk_line_submit_emeta_io(struct pblk =
*pblk, struct pblk_line *line,
>>  	memset(&rqd, 0, sizeof(struct nvm_rq));
>>    	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0);
>> -	rq_len =3D rq_ppas * geo->sec_size;
>> +	rq_len =3D rq_ppas * geo->c.csecs;
>>    	bio =3D pblk_bio_map_addr(pblk, emeta_buf, rq_ppas, rq_len,
>>  					l_mg->emeta_alloc_type, =
GFP_KERNEL);
>> @@ -722,7 +722,7 @@ u64 pblk_line_smeta_start(struct pblk *pblk, =
struct pblk_line *line)
>>  	if (bit >=3D lm->blk_per_line)
>>  		return -1;
>>  -	return bit * geo->sec_per_pl;
>> +	return bit * geo->c.ws_opt;
>>  }
>>    static int pblk_line_submit_smeta_io(struct pblk *pblk, struct =
pblk_line *line,
>> @@ -1035,19 +1035,19 @@ static int pblk_line_init_bb(struct pblk =
*pblk, struct pblk_line *line,
>>  	/* Capture bad block information on line mapping bitmaps */
>>  	while ((bit =3D find_next_bit(line->blk_bitmap, =
lm->blk_per_line,
>>  					bit + 1)) < lm->blk_per_line) {
>> -		off =3D bit * geo->sec_per_pl;
>> +		off =3D bit * geo->c.ws_opt;
>>  		bitmap_shift_left(l_mg->bb_aux, l_mg->bb_template, off,
>>  							=
lm->sec_per_line);
>>  		bitmap_or(line->map_bitmap, line->map_bitmap, =
l_mg->bb_aux,
>>  							=
lm->sec_per_line);
>> -		line->sec_in_line -=3D geo->sec_per_chk;
>> +		line->sec_in_line -=3D geo->c.clba;
>>  		if (bit >=3D lm->emeta_bb)
>>  			nr_bb++;
>>  	}
>>    	/* Mark smeta metadata sectors as bad sectors */
>>  	bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
>> -	off =3D bit * geo->sec_per_pl;
>> +	off =3D bit * geo->c.ws_opt;
>>  	bitmap_set(line->map_bitmap, off, lm->smeta_sec);
>>  	line->sec_in_line -=3D lm->smeta_sec;
>>  	line->smeta_ssec =3D off;
>> @@ -1066,10 +1066,10 @@ static int pblk_line_init_bb(struct pblk =
*pblk, struct pblk_line *line,
>>  	emeta_secs =3D lm->emeta_sec[0];
>>  	off =3D lm->sec_per_line;
>>  	while (emeta_secs) {
>> -		off -=3D geo->sec_per_pl;
>> +		off -=3D geo->c.ws_opt;
>>  		if (!test_bit(off, line->invalid_bitmap)) {
>> -			bitmap_set(line->invalid_bitmap, off, =
geo->sec_per_pl);
>> -			emeta_secs -=3D geo->sec_per_pl;
>> +			bitmap_set(line->invalid_bitmap, off, =
geo->c.ws_opt);
>> +			emeta_secs -=3D geo->c.ws_opt;
>>  		}
>>  	}
>>  diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
>> index 320f99af99e9..16afea3f5541 100644
>> --- a/drivers/lightnvm/pblk-gc.c
>> +++ b/drivers/lightnvm/pblk-gc.c
>> @@ -88,7 +88,7 @@ static void pblk_gc_line_ws(struct work_struct =
*work)
>>    	up(&gc->gc_sem);
>>  -	gc_rq->data =3D vmalloc(gc_rq->nr_secs * geo->sec_size);
>> +	gc_rq->data =3D vmalloc(gc_rq->nr_secs * geo->c.csecs);
>>  	if (!gc_rq->data) {
>>  		pr_err("pblk: could not GC line:%d (%d/%d)\n",
>>  					line->id, *line->vsc, =
gc_rq->nr_secs);
>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>> index 5261702e9ff7..95ecb0ec736b 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -146,7 +146,7 @@ static int pblk_rwb_init(struct pblk *pblk)
>>  		return -ENOMEM;
>>    	power_size =3D get_count_order(nr_entries);
>> -	power_seg_sz =3D get_count_order(geo->sec_size);
>> +	power_seg_sz =3D get_count_order(geo->c.csecs);
>>    	return pblk_rb_init(&pblk->rwb, entries, power_size, =
power_seg_sz);
>>  }
>> @@ -154,11 +154,11 @@ static int pblk_rwb_init(struct pblk *pblk)
>>  /* Minimum pages needed within a lun */
>>  #define ADDR_POOL_SIZE 64
>>  -static int pblk_set_ppaf(struct pblk *pblk)
>> +static int pblk_set_addrf_12(struct nvm_geo *geo,
>> +			     struct nvm_addr_format_12 *dst)
>>  {
>> -	struct nvm_tgt_dev *dev =3D pblk->dev;
>> -	struct nvm_geo *geo =3D &dev->geo;
>> -	struct nvm_addr_format ppaf =3D geo->ppaf;
>> +	struct nvm_addr_format_12 *src =3D
>> +				(struct nvm_addr_format_12 =
*)&geo->c.addrf;
>>  	int power_len;
>>    	/* Re-calculate channel and lun format to adapt to configuration =
*/
>> @@ -167,34 +167,50 @@ static int pblk_set_ppaf(struct pblk *pblk)
>>  		pr_err("pblk: supports only power-of-two channel =
config.\n");
>>  		return -EINVAL;
>>  	}
>> -	ppaf.ch_len =3D power_len;
>> +	dst->ch_len =3D power_len;
>>    	power_len =3D get_count_order(geo->nr_luns);
>>  	if (1 << power_len !=3D geo->nr_luns) {
>>  		pr_err("pblk: supports only power-of-two LUN =
config.\n");
>>  		return -EINVAL;
>>  	}
>> -	ppaf.lun_len =3D power_len;
>> +	dst->lun_len =3D power_len;
>>  -	pblk->ppaf.sec_offset =3D 0;
>> -	pblk->ppaf.pln_offset =3D ppaf.sect_len;
>> -	pblk->ppaf.ch_offset =3D pblk->ppaf.pln_offset + ppaf.pln_len;
>> -	pblk->ppaf.lun_offset =3D pblk->ppaf.ch_offset + ppaf.ch_len;
>> -	pblk->ppaf.pg_offset =3D pblk->ppaf.lun_offset + ppaf.lun_len;
>> -	pblk->ppaf.blk_offset =3D pblk->ppaf.pg_offset + ppaf.pg_len;
>> -	pblk->ppaf.sec_mask =3D (1ULL << ppaf.sect_len) - 1;
>> -	pblk->ppaf.pln_mask =3D ((1ULL << ppaf.pln_len) - 1) <<
>> -							=
pblk->ppaf.pln_offset;
>> -	pblk->ppaf.ch_mask =3D ((1ULL << ppaf.ch_len) - 1) <<
>> -							=
pblk->ppaf.ch_offset;
>> -	pblk->ppaf.lun_mask =3D ((1ULL << ppaf.lun_len) - 1) <<
>> -							=
pblk->ppaf.lun_offset;
>> -	pblk->ppaf.pg_mask =3D ((1ULL << ppaf.pg_len) - 1) <<
>> -							=
pblk->ppaf.pg_offset;
>> -	pblk->ppaf.blk_mask =3D ((1ULL << ppaf.blk_len) - 1) <<
>> -							=
pblk->ppaf.blk_offset;
>> +	dst->blk_len =3D src->blk_len;
>> +	dst->pg_len =3D src->pg_len;
>> +	dst->pln_len =3D src->pln_len;
>> +	dst->sect_len =3D src->sect_len;
>>  -	pblk->ppaf_bitsize =3D pblk->ppaf.blk_offset + ppaf.blk_len;
>> +	dst->sect_offset =3D 0;
>> +	dst->pln_offset =3D dst->sect_len;
>> +	dst->ch_offset =3D dst->pln_offset + dst->pln_len;
>> +	dst->lun_offset =3D dst->ch_offset + dst->ch_len;
>> +	dst->pg_offset =3D dst->lun_offset + dst->lun_len;
>> +	dst->blk_offset =3D dst->pg_offset + dst->pg_len;
>> +
>> +	dst->sec_mask =3D ((1ULL << dst->sect_len) - 1) << =
dst->sect_offset;
>> +	dst->pln_mask =3D ((1ULL << dst->pln_len) - 1) << =
dst->pln_offset;
>> +	dst->ch_mask =3D ((1ULL << dst->ch_len) - 1) << dst->ch_offset;
>> +	dst->lun_mask =3D ((1ULL << dst->lun_len) - 1) << =
dst->lun_offset;
>> +	dst->pg_mask =3D ((1ULL << dst->pg_len) - 1) << dst->pg_offset;
>> +	dst->blk_mask =3D ((1ULL << dst->blk_len) - 1) << =
dst->blk_offset;
>> +
>> +	return dst->blk_offset + src->blk_len;
>> +}
>> +
>> +static int pblk_set_ppaf(struct pblk *pblk)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	int mod;
>> +
>> +	div_u64_rem(geo->c.clba, pblk->min_write_pgs, &mod);
>> +	if (mod) {
>> +		pr_err("pblk: bad configuration of sectors/pages\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	pblk->ppaf_bitsize =3D pblk_set_addrf_12(geo, (void =
*)&pblk->ppaf);
>>    	return 0;
>>  }
>> @@ -253,8 +269,7 @@ static int pblk_core_init(struct pblk *pblk)
>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  	struct nvm_geo *geo =3D &dev->geo;
>>  -	pblk->pgs_in_buffer =3D NVM_MEM_PAGE_WRITE * geo->sec_per_pg *
>> -						geo->nr_planes * =
geo->all_luns;
>> +	pblk->pgs_in_buffer =3D geo->c.mw_cunits * geo->c.ws_opt * =
geo->all_luns;
>>    	if (pblk_init_global_caches(pblk))
>>  		return -ENOMEM;
>> @@ -433,7 +448,7 @@ static void *pblk_bb_get_log(struct pblk *pblk)
>>  	int i, nr_blks, blk_per_lun;
>>  	int ret;
>>  -	blk_per_lun =3D geo->nr_chks * geo->plane_mode;
>> +	blk_per_lun =3D geo->c.num_chk * geo->c.pln_mode;
>>  	nr_blks =3D blk_per_lun * geo->all_luns;
>>    	log =3D kmalloc(nr_blks, GFP_KERNEL);
>> @@ -551,18 +566,18 @@ static unsigned int calc_emeta_len(struct pblk =
*pblk)
>>  	/* Round to sector size so that lba_list starts on its own =
sector */
>>  	lm->emeta_sec[1] =3D DIV_ROUND_UP(
>>  			sizeof(struct line_emeta) + lm->blk_bitmap_len +
>> -			sizeof(struct wa_counters), geo->sec_size);
>> -	lm->emeta_len[1] =3D lm->emeta_sec[1] * geo->sec_size;
>> +			sizeof(struct wa_counters), geo->c.csecs);
>> +	lm->emeta_len[1] =3D lm->emeta_sec[1] * geo->c.csecs;
>>    	/* Round to sector size so that vsc_list starts on its own =
sector */
>>  	lm->dsec_per_line =3D lm->sec_per_line - lm->emeta_sec[0];
>>  	lm->emeta_sec[2] =3D DIV_ROUND_UP(lm->dsec_per_line * =
sizeof(u64),
>> -			geo->sec_size);
>> -	lm->emeta_len[2] =3D lm->emeta_sec[2] * geo->sec_size;
>> +			geo->c.csecs);
>> +	lm->emeta_len[2] =3D lm->emeta_sec[2] * geo->c.csecs;
>>    	lm->emeta_sec[3] =3D DIV_ROUND_UP(l_mg->nr_lines * sizeof(u32),
>> -			geo->sec_size);
>> -	lm->emeta_len[3] =3D lm->emeta_sec[3] * geo->sec_size;
>> +			geo->c.csecs);
>> +	lm->emeta_len[3] =3D lm->emeta_sec[3] * geo->c.csecs;
>>    	lm->vsc_list_len =3D l_mg->nr_lines * sizeof(u32);
>>  @@ -593,13 +608,13 @@ static void pblk_set_provision(struct pblk =
*pblk, long nr_free_blks)
>>  	 * on user capacity consider only provisioned blocks
>>  	 */
>>  	pblk->rl.total_blocks =3D nr_free_blks;
>> -	pblk->rl.nr_secs =3D nr_free_blks * geo->sec_per_chk;
>> +	pblk->rl.nr_secs =3D nr_free_blks * geo->c.clba;
>>    	/* Consider sectors used for metadata */
>>  	sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * =
l_mg->nr_free_lines;
>> -	blk_meta =3D DIV_ROUND_UP(sec_meta, geo->sec_per_chk);
>> +	blk_meta =3D DIV_ROUND_UP(sec_meta, geo->c.clba);
>>  -	pblk->capacity =3D (provisioned - blk_meta) * geo->sec_per_chk;
>> +	pblk->capacity =3D (provisioned - blk_meta) * geo->c.clba;
>>    	atomic_set(&pblk->rl.free_blocks, nr_free_blks);
>>  	atomic_set(&pblk->rl.free_user_blocks, nr_free_blks);
>> @@ -710,10 +725,10 @@ static int pblk_lines_init(struct pblk *pblk)
>>  	void *chunk_log;
>>  	unsigned int smeta_len, emeta_len;
>>  	long nr_bad_blks =3D 0, nr_free_blks =3D 0;
>> -	int bb_distance, max_write_ppas, mod;
>> +	int bb_distance, max_write_ppas;
>>  	int i, ret;
>>  -	pblk->min_write_pgs =3D geo->sec_per_pl * (geo->sec_size / =
PAGE_SIZE);
>> +	pblk->min_write_pgs =3D geo->c.ws_opt * (geo->c.csecs / =
PAGE_SIZE);
>>  	max_write_ppas =3D pblk->min_write_pgs * geo->all_luns;
>>  	pblk->max_write_pgs =3D min_t(int, max_write_ppas, =
NVM_MAX_VLBA);
>>  	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>> @@ -724,19 +739,13 @@ static int pblk_lines_init(struct pblk *pblk)
>>  		return -EINVAL;
>>  	}
>>  -	div_u64_rem(geo->sec_per_chk, pblk->min_write_pgs, &mod);
>> -	if (mod) {
>> -		pr_err("pblk: bad configuration of sectors/pages\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	l_mg->nr_lines =3D geo->nr_chks;
>> +	l_mg->nr_lines =3D geo->c.num_chk;
>>  	l_mg->log_line =3D l_mg->data_line =3D NULL;
>>  	l_mg->l_seq_nr =3D l_mg->d_seq_nr =3D 0;
>>  	l_mg->nr_free_lines =3D 0;
>>  	bitmap_zero(&l_mg->meta_bitmap, PBLK_DATA_LINES);
>>  -	lm->sec_per_line =3D geo->sec_per_chk * geo->all_luns;
>> +	lm->sec_per_line =3D geo->c.clba * geo->all_luns;
>>  	lm->blk_per_line =3D geo->all_luns;
>>  	lm->blk_bitmap_len =3D BITS_TO_LONGS(geo->all_luns) * =
sizeof(long);
>>  	lm->sec_bitmap_len =3D BITS_TO_LONGS(lm->sec_per_line) * =
sizeof(long);
>> @@ -750,8 +759,8 @@ static int pblk_lines_init(struct pblk *pblk)
>>  	 */
>>  	i =3D 1;
>>  add_smeta_page:
>> -	lm->smeta_sec =3D i * geo->sec_per_pl;
>> -	lm->smeta_len =3D lm->smeta_sec * geo->sec_size;
>> +	lm->smeta_sec =3D i * geo->c.ws_opt;
>> +	lm->smeta_len =3D lm->smeta_sec * geo->c.csecs;
>>    	smeta_len =3D sizeof(struct line_smeta) + lm->lun_bitmap_len;
>>  	if (smeta_len > lm->smeta_len) {
>> @@ -764,8 +773,8 @@ static int pblk_lines_init(struct pblk *pblk)
>>  	 */
>>  	i =3D 1;
>>  add_emeta_page:
>> -	lm->emeta_sec[0] =3D i * geo->sec_per_pl;
>> -	lm->emeta_len[0] =3D lm->emeta_sec[0] * geo->sec_size;
>> +	lm->emeta_sec[0] =3D i * geo->c.ws_opt;
>> +	lm->emeta_len[0] =3D lm->emeta_sec[0] * geo->c.csecs;
>>    	emeta_len =3D calc_emeta_len(pblk);
>>  	if (emeta_len > lm->emeta_len[0]) {
>> @@ -778,7 +787,7 @@ static int pblk_lines_init(struct pblk *pblk)
>>  	lm->min_blk_line =3D 1;
>>  	if (geo->all_luns > 1)
>>  		lm->min_blk_line +=3D DIV_ROUND_UP(lm->smeta_sec +
>> -					lm->emeta_sec[0], =
geo->sec_per_chk);
>> +					lm->emeta_sec[0], geo->c.clba);
>>    	if (lm->min_blk_line > lm->blk_per_line) {
>>  		pr_err("pblk: config. not supported. Min. LUN in =
line:%d\n",
>> @@ -802,9 +811,9 @@ static int pblk_lines_init(struct pblk *pblk)
>>  		goto fail_free_bb_template;
>>  	}
>>  -	bb_distance =3D (geo->all_luns) * geo->sec_per_pl;
>> +	bb_distance =3D (geo->all_luns) * geo->c.ws_opt;
>>  	for (i =3D 0; i < lm->sec_per_line; i +=3D bb_distance)
>> -		bitmap_set(l_mg->bb_template, i, geo->sec_per_pl);
>> +		bitmap_set(l_mg->bb_template, i, geo->c.ws_opt);
>>    	INIT_LIST_HEAD(&l_mg->free_list);
>>  	INIT_LIST_HEAD(&l_mg->corrupt_list);
>> @@ -981,9 +990,9 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
>>  	struct pblk *pblk;
>>  	int ret;
>>  -	if (dev->identity.dom & NVM_RSP_L2P) {
>> +	if (dev->geo.c.dom & NVM_RSP_L2P) {
>>  		pr_err("pblk: host-side L2P table not supported. =
(%x)\n",
>> -							=
dev->identity.dom);
>> +							dev->geo.c.dom);
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  @@ -1091,7 +1100,7 @@ static void *pblk_init(struct nvm_tgt_dev =
*dev, struct gendisk *tdisk,
>>    	blk_queue_write_cache(tqueue, true, false);
>>  -	tqueue->limits.discard_granularity =3D geo->sec_per_chk * =
geo->sec_size;
>> +	tqueue->limits.discard_granularity =3D geo->c.clba * =
geo->c.csecs;
>>  	tqueue->limits.discard_alignment =3D 0;
>>  	blk_queue_max_discard_sectors(tqueue, UINT_MAX >> 9);
>>  	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, tqueue);
>> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
>> index 2f761283f43e..ebb6bae3a3b8 100644
>> --- a/drivers/lightnvm/pblk-read.c
>> +++ b/drivers/lightnvm/pblk-read.c
>> @@ -563,7 +563,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct =
pblk_gc_rq *gc_rq)
>>  	if (!(gc_rq->secs_to_gc))
>>  		goto out;
>>  -	data_len =3D (gc_rq->secs_to_gc) * geo->sec_size;
>> +	data_len =3D (gc_rq->secs_to_gc) * geo->c.csecs;
>>  	bio =3D pblk_bio_map_addr(pblk, gc_rq->data, gc_rq->secs_to_gc, =
data_len,
>>  						PBLK_VMALLOC_META, =
GFP_KERNEL);
>>  	if (IS_ERR(bio)) {
>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>> index aaab9a5c17cc..1574dbbfbb1c 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -184,7 +184,7 @@ static int pblk_calc_sec_in_line(struct pblk =
*pblk, struct pblk_line *line)
>>  	int nr_bb =3D bitmap_weight(line->blk_bitmap, lm->blk_per_line);
>>    	return lm->sec_per_line - lm->smeta_sec - lm->emeta_sec[0] -
>> -				nr_bb * geo->sec_per_chk;
>> +				nr_bb * geo->c.clba;
>>  }
>>    struct pblk_recov_alloc {
>> @@ -232,7 +232,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, =
struct pblk_line *line,
>>  	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0);
>>  	if (!rq_ppas)
>>  		rq_ppas =3D pblk->min_write_pgs;
>> -	rq_len =3D rq_ppas * geo->sec_size;
>> +	rq_len =3D rq_ppas * geo->c.csecs;
>>    	bio =3D bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
>>  	if (IS_ERR(bio))
>> @@ -351,7 +351,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, =
struct pblk_line *line,
>>  	if (!pad_rq)
>>  		return -ENOMEM;
>>  -	data =3D vzalloc(pblk->max_write_pgs * geo->sec_size);
>> +	data =3D vzalloc(pblk->max_write_pgs * geo->c.csecs);
>>  	if (!data) {
>>  		ret =3D -ENOMEM;
>>  		goto free_rq;
>> @@ -368,7 +368,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, =
struct pblk_line *line,
>>  		goto fail_free_pad;
>>  	}
>>  -	rq_len =3D rq_ppas * geo->sec_size;
>> +	rq_len =3D rq_ppas * geo->c.csecs;
>>    	meta_list =3D nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, =
&dma_meta_list);
>>  	if (!meta_list) {
>> @@ -509,7 +509,7 @@ static int pblk_recov_scan_all_oob(struct pblk =
*pblk, struct pblk_line *line,
>>  	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0);
>>  	if (!rq_ppas)
>>  		rq_ppas =3D pblk->min_write_pgs;
>> -	rq_len =3D rq_ppas * geo->sec_size;
>> +	rq_len =3D rq_ppas * geo->c.csecs;
>>    	bio =3D bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
>>  	if (IS_ERR(bio))
>> @@ -640,7 +640,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
>>  	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0);
>>  	if (!rq_ppas)
>>  		rq_ppas =3D pblk->min_write_pgs;
>> -	rq_len =3D rq_ppas * geo->sec_size;
>> +	rq_len =3D rq_ppas * geo->c.csecs;
>>    	bio =3D bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
>>  	if (IS_ERR(bio))
>> @@ -745,7 +745,7 @@ static int pblk_recov_l2p_from_oob(struct pblk =
*pblk, struct pblk_line *line)
>>  	ppa_list =3D (void *)(meta_list) + pblk_dma_meta_size;
>>  	dma_ppa_list =3D dma_meta_list + pblk_dma_meta_size;
>>  -	data =3D kcalloc(pblk->max_write_pgs, geo->sec_size, =
GFP_KERNEL);
>> +	data =3D kcalloc(pblk->max_write_pgs, geo->c.csecs, GFP_KERNEL);
>>  	if (!data) {
>>  		ret =3D -ENOMEM;
>>  		goto free_meta_list;
>> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
>> index 0d457b162f23..bcab203477ec 100644
>> --- a/drivers/lightnvm/pblk-rl.c
>> +++ b/drivers/lightnvm/pblk-rl.c
>> @@ -200,7 +200,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
>>    	/* Consider sectors used for metadata */
>>  	sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * =
l_mg->nr_free_lines;
>> -	blk_meta =3D DIV_ROUND_UP(sec_meta, geo->sec_per_chk);
>> +	blk_meta =3D DIV_ROUND_UP(sec_meta, geo->c.clba);
>>    	rl->high =3D pblk->op_blks - blk_meta - lm->blk_per_line;
>>  	rl->high_pw =3D get_count_order(rl->high);
>> diff --git a/drivers/lightnvm/pblk-sysfs.c =
b/drivers/lightnvm/pblk-sysfs.c
>> index d93e9b1f083a..5eb21a279361 100644
>> --- a/drivers/lightnvm/pblk-sysfs.c
>> +++ b/drivers/lightnvm/pblk-sysfs.c
>> @@ -113,26 +113,31 @@ static ssize_t pblk_sysfs_ppaf(struct pblk =
*pblk, char *page)
>>  {
>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  	struct nvm_geo *geo =3D &dev->geo;
>> +	struct nvm_addr_format_12 *ppaf;
>> +	struct nvm_addr_format_12 *geo_ppaf;
>>  	ssize_t sz =3D 0;
>>  -	sz =3D snprintf(page, PAGE_SIZE - sz,
>> -		=
"g:(b:%d)blk:%d/%d,pg:%d/%d,lun:%d/%d,ch:%d/%d,pl:%d/%d,sec:%d/%d\n",
>> -		pblk->ppaf_bitsize,
>> -		pblk->ppaf.blk_offset, geo->ppaf.blk_len,
>> -		pblk->ppaf.pg_offset, geo->ppaf.pg_len,
>> -		pblk->ppaf.lun_offset, geo->ppaf.lun_len,
>> -		pblk->ppaf.ch_offset, geo->ppaf.ch_len,
>> -		pblk->ppaf.pln_offset, geo->ppaf.pln_len,
>> -		pblk->ppaf.sec_offset, geo->ppaf.sect_len);
>> +	ppaf =3D (struct nvm_addr_format_12 *)&pblk->ppaf;
>> +	geo_ppaf =3D (struct nvm_addr_format_12 *)&geo->c.addrf;
>> +
>> +	sz =3D snprintf(page, PAGE_SIZE,
>> +		=
"pblk:(s:%d)ch:%d/%d,lun:%d/%d,blk:%d/%d,pg:%d/%d,pl:%d/%d,sec:%d/%d\n",
>> +			pblk->ppaf_bitsize,
>> +			ppaf->ch_offset, ppaf->ch_len,
>> +			ppaf->lun_offset, ppaf->lun_len,
>> +			ppaf->blk_offset, ppaf->blk_len,
>> +			ppaf->pg_offset, ppaf->pg_len,
>> +			ppaf->pln_offset, ppaf->pln_len,
>> +			ppaf->sect_offset, ppaf->sect_len);
>>    	sz +=3D snprintf(page + sz, PAGE_SIZE - sz,
>> -		=
"d:blk:%d/%d,pg:%d/%d,lun:%d/%d,ch:%d/%d,pl:%d/%d,sec:%d/%d\n",
>> -		geo->ppaf.blk_offset, geo->ppaf.blk_len,
>> -		geo->ppaf.pg_offset, geo->ppaf.pg_len,
>> -		geo->ppaf.lun_offset, geo->ppaf.lun_len,
>> -		geo->ppaf.ch_offset, geo->ppaf.ch_len,
>> -		geo->ppaf.pln_offset, geo->ppaf.pln_len,
>> -		geo->ppaf.sect_offset, geo->ppaf.sect_len);
>> +		=
"device:ch:%d/%d,lun:%d/%d,blk:%d/%d,pg:%d/%d,pl:%d/%d,sec:%d/%d\n",
>> +			geo_ppaf->ch_offset, geo_ppaf->ch_len,
>> +			geo_ppaf->lun_offset, geo_ppaf->lun_len,
>> +			geo_ppaf->blk_offset, geo_ppaf->blk_len,
>> +			geo_ppaf->pg_offset, geo_ppaf->pg_len,
>> +			geo_ppaf->pln_offset, geo_ppaf->pln_len,
>> +			geo_ppaf->sect_offset, geo_ppaf->sect_len);
>>    	return sz;
>>  }
>> @@ -288,7 +293,7 @@ static ssize_t pblk_sysfs_lines_info(struct pblk =
*pblk, char *page)
>>  				"blk_line:%d, sec_line:%d, =
sec_blk:%d\n",
>>  					lm->blk_per_line,
>>  					lm->sec_per_line,
>> -					geo->sec_per_chk);
>> +					geo->c.clba);
>>    	return sz;
>>  }
>> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
>> index aae86ed60b98..c49b27539d5a 100644
>> --- a/drivers/lightnvm/pblk-write.c
>> +++ b/drivers/lightnvm/pblk-write.c
>> @@ -333,7 +333,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct =
pblk_line *meta_line)
>>  	m_ctx =3D nvm_rq_to_pdu(rqd);
>>  	m_ctx->private =3D meta_line;
>>  -	rq_len =3D rq_ppas * geo->sec_size;
>> +	rq_len =3D rq_ppas * geo->c.csecs;
>>  	data =3D ((void *)emeta->buf) + emeta->mem;
>>    	bio =3D pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index 282dfc8780e8..67ffb53608f7 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -551,21 +551,6 @@ struct pblk_line_meta {
>>  	unsigned int meta_distance;	/* Distance between data and =
metadata */
>>  };
>>  -struct pblk_addr_format {
>> -	u64	ch_mask;
>> -	u64	lun_mask;
>> -	u64	pln_mask;
>> -	u64	blk_mask;
>> -	u64	pg_mask;
>> -	u64	sec_mask;
>> -	u8	ch_offset;
>> -	u8	lun_offset;
>> -	u8	pln_offset;
>> -	u8	blk_offset;
>> -	u8	pg_offset;
>> -	u8	sec_offset;
>> -};
>> -
>>  enum {
>>  	PBLK_STATE_RUNNING =3D 0,
>>  	PBLK_STATE_STOPPING =3D 1,
>> @@ -585,8 +570,8 @@ struct pblk {
>>  	struct pblk_line_mgmt l_mg;		/* Line management */
>>  	struct pblk_line_meta lm;		/* Line metadata */
>>  +	struct nvm_addr_format ppaf;
>>  	int ppaf_bitsize;
>> -	struct pblk_addr_format ppaf;
>>    	struct pblk_rb rwb;
>>  @@ -941,14 +926,12 @@ static inline int pblk_line_vsc(struct =
pblk_line *line)
>>  	return le32_to_cpu(*line->vsc);
>>  }
>>  -#define NVM_MEM_PAGE_WRITE (8)
>> -
>>  static inline int pblk_pad_distance(struct pblk *pblk)
>>  {
>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  	struct nvm_geo *geo =3D &dev->geo;
>>  -	return NVM_MEM_PAGE_WRITE * geo->all_luns * geo->sec_per_pl;
>> +	return geo->c.mw_cunits * geo->all_luns * geo->c.ws_opt;
>>  }
>>    static inline int pblk_ppa_to_line(struct ppa_addr p)
>> @@ -964,15 +947,17 @@ static inline int pblk_ppa_to_pos(struct =
nvm_geo *geo, struct ppa_addr p)
>>  static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 =
paddr,
>>  					      u64 line_id)
>>  {
>> +	struct nvm_addr_format_12 *ppaf =3D
>> +				(struct nvm_addr_format_12 =
*)&pblk->ppaf;
>>  	struct ppa_addr ppa;
>>    	ppa.ppa =3D 0;
>>  	ppa.g.blk =3D line_id;
>> -	ppa.g.pg =3D (paddr & pblk->ppaf.pg_mask) >> =
pblk->ppaf.pg_offset;
>> -	ppa.g.lun =3D (paddr & pblk->ppaf.lun_mask) >> =
pblk->ppaf.lun_offset;
>> -	ppa.g.ch =3D (paddr & pblk->ppaf.ch_mask) >> =
pblk->ppaf.ch_offset;
>> -	ppa.g.pl =3D (paddr & pblk->ppaf.pln_mask) >> =
pblk->ppaf.pln_offset;
>> -	ppa.g.sec =3D (paddr & pblk->ppaf.sec_mask) >> =
pblk->ppaf.sec_offset;
>> +	ppa.g.pg =3D (paddr & ppaf->pg_mask) >> ppaf->pg_offset;
>> +	ppa.g.lun =3D (paddr & ppaf->lun_mask) >> ppaf->lun_offset;
>> +	ppa.g.ch =3D (paddr & ppaf->ch_mask) >> ppaf->ch_offset;
>> +	ppa.g.pl =3D (paddr & ppaf->pln_mask) >> ppaf->pln_offset;
>> +	ppa.g.sec =3D (paddr & ppaf->sec_mask) >> ppaf->sect_offset;
>>    	return ppa;
>>  }
>> @@ -980,13 +965,15 @@ static inline struct ppa_addr =
addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
>>  static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
>>  							struct ppa_addr =
p)
>>  {
>> +	struct nvm_addr_format_12 *ppaf =3D
>> +				(struct nvm_addr_format_12 =
*)&pblk->ppaf;
>>  	u64 paddr;
>>  -	paddr =3D (u64)p.g.pg << pblk->ppaf.pg_offset;
>> -	paddr |=3D (u64)p.g.lun << pblk->ppaf.lun_offset;
>> -	paddr |=3D (u64)p.g.ch << pblk->ppaf.ch_offset;
>> -	paddr |=3D (u64)p.g.pl << pblk->ppaf.pln_offset;
>> -	paddr |=3D (u64)p.g.sec << pblk->ppaf.sec_offset;
>> +	paddr =3D (u64)p.g.ch << ppaf->ch_offset;
>> +	paddr |=3D (u64)p.g.lun << ppaf->lun_offset;
>> +	paddr |=3D (u64)p.g.pg << ppaf->pg_offset;
>> +	paddr |=3D (u64)p.g.pl << ppaf->pln_offset;
>> +	paddr |=3D (u64)p.g.sec << ppaf->sect_offset;
>>    	return paddr;
>>  }
>> @@ -1003,18 +990,15 @@ static inline struct ppa_addr =
pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
>>  		ppa64.c.line =3D ppa32 & ((~0U) >> 1);
>>  		ppa64.c.is_cached =3D 1;
>>  	} else {
>> -		ppa64.g.blk =3D (ppa32 & pblk->ppaf.blk_mask) >>
>> -							=
pblk->ppaf.blk_offset;
>> -		ppa64.g.pg =3D (ppa32 & pblk->ppaf.pg_mask) >>
>> -							=
pblk->ppaf.pg_offset;
>> -		ppa64.g.lun =3D (ppa32 & pblk->ppaf.lun_mask) >>
>> -							=
pblk->ppaf.lun_offset;
>> -		ppa64.g.ch =3D (ppa32 & pblk->ppaf.ch_mask) >>
>> -							=
pblk->ppaf.ch_offset;
>> -		ppa64.g.pl =3D (ppa32 & pblk->ppaf.pln_mask) >>
>> -							=
pblk->ppaf.pln_offset;
>> -		ppa64.g.sec =3D (ppa32 & pblk->ppaf.sec_mask) >>
>> -							=
pblk->ppaf.sec_offset;
>> +		struct nvm_addr_format_12 *ppaf =3D
>> +				(struct nvm_addr_format_12 =
*)&pblk->ppaf;
>> +
>> +		ppa64.g.ch =3D (ppa32 & ppaf->ch_mask) >> =
ppaf->ch_offset;
>> +		ppa64.g.lun =3D (ppa32 & ppaf->lun_mask) >> =
ppaf->lun_offset;
>> +		ppa64.g.blk =3D (ppa32 & ppaf->blk_mask) >> =
ppaf->blk_offset;
>> +		ppa64.g.pg =3D (ppa32 & ppaf->pg_mask) >> =
ppaf->pg_offset;
>> +		ppa64.g.pl =3D (ppa32 & ppaf->pln_mask) >> =
ppaf->pln_offset;
>> +		ppa64.g.sec =3D (ppa32 & ppaf->sec_mask) >> =
ppaf->sect_offset;
>>  	}
>>    	return ppa64;
>> @@ -1030,12 +1014,15 @@ static inline u32 pblk_ppa64_to_ppa32(struct =
pblk *pblk, struct ppa_addr ppa64)
>>  		ppa32 |=3D ppa64.c.line;
>>  		ppa32 |=3D 1U << 31;
>>  	} else {
>> -		ppa32 |=3D ppa64.g.blk << pblk->ppaf.blk_offset;
>> -		ppa32 |=3D ppa64.g.pg << pblk->ppaf.pg_offset;
>> -		ppa32 |=3D ppa64.g.lun << pblk->ppaf.lun_offset;
>> -		ppa32 |=3D ppa64.g.ch << pblk->ppaf.ch_offset;
>> -		ppa32 |=3D ppa64.g.pl << pblk->ppaf.pln_offset;
>> -		ppa32 |=3D ppa64.g.sec << pblk->ppaf.sec_offset;
>> +		struct nvm_addr_format_12 *ppaf =3D
>> +				(struct nvm_addr_format_12 =
*)&pblk->ppaf;
>> +
>> +		ppa32 |=3D ppa64.g.ch << ppaf->ch_offset;
>> +		ppa32 |=3D ppa64.g.lun << ppaf->lun_offset;
>> +		ppa32 |=3D ppa64.g.blk << ppaf->blk_offset;
>> +		ppa32 |=3D ppa64.g.pg << ppaf->pg_offset;
>> +		ppa32 |=3D ppa64.g.pl << ppaf->pln_offset;
>> +		ppa32 |=3D ppa64.g.sec << ppaf->sect_offset;
>>  	}
>>    	return ppa32;
>> @@ -1153,7 +1140,7 @@ static inline int pblk_set_progr_mode(struct =
pblk *pblk, int type)
>>  	struct nvm_geo *geo =3D &dev->geo;
>>  	int flags;
>>  -	flags =3D geo->plane_mode >> 1;
>> +	flags =3D geo->c.pln_mode >> 1;
>>    	if (type =3D=3D PBLK_WRITE)
>>  		flags |=3D NVM_IO_SCRAMBLE_ENABLE;
>> @@ -1174,7 +1161,7 @@ static inline int pblk_set_read_mode(struct =
pblk *pblk, int type)
>>    	flags =3D NVM_IO_SUSPEND | NVM_IO_SCRAMBLE_ENABLE;
>>  	if (type =3D=3D PBLK_READ_SEQUENTIAL)
>> -		flags |=3D geo->plane_mode >> 1;
>> +		flags |=3D geo->c.pln_mode >> 1;
>>    	return flags;
>>  }
>> @@ -1229,10 +1216,10 @@ static inline int =
pblk_boundary_ppa_checks(struct nvm_tgt_dev *tgt_dev,
>>  		if (!ppa->c.is_cached &&
>>  				ppa->g.ch < geo->nr_chnls &&
>>  				ppa->g.lun < geo->nr_luns &&
>> -				ppa->g.pl < geo->nr_planes &&
>> -				ppa->g.blk < geo->nr_chks &&
>> -				ppa->g.pg < geo->ws_per_chk &&
>> -				ppa->g.sec < geo->sec_per_pg)
>> +				ppa->g.pl < geo->c.num_pln &&
>> +				ppa->g.blk < geo->c.num_chk &&
>> +				ppa->g.pg < geo->c.num_pg &&
>> +				ppa->g.sec < geo->c.ws_min)
>>  			continue;
>>    		print_ppa(ppa, "boundary", i);
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index 839c0b96466a..c81e64cc20d7 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -152,8 +152,8 @@ struct nvme_nvm_id12_addrf {
>>  	__u8			blk_len;
>>  	__u8			pg_offset;
>>  	__u8			pg_len;
>> -	__u8			sect_offset;
>> -	__u8			sect_len;
>> +	__u8			sec_offset;
>> +	__u8			sec_len;
>>  	__u8			res[4];
>>  } __packed;
>>  @@ -254,106 +254,157 @@ static inline void =
_nvme_nvm_check_size(void)
>>  	BUILD_BUG_ON(sizeof(struct nvme_nvm_id20) !=3D =
NVME_IDENTIFY_DATA_SIZE);
>>  }
>>  -static int init_grp(struct nvm_id *nvm_id, struct nvme_nvm_id12 =
*id12)
>> +static void nvme_nvm_set_addr_12(struct nvm_addr_format_12 *dst,
>> +				 struct nvme_nvm_id12_addrf *src)
>> +{
>> +	dst->ch_len =3D src->ch_len;
>> +	dst->lun_len =3D src->lun_len;
>> +	dst->blk_len =3D src->blk_len;
>> +	dst->pg_len =3D src->pg_len;
>> +	dst->pln_len =3D src->pln_len;
>> +	dst->sect_len =3D src->sec_len;
>> +
>> +	dst->ch_offset =3D src->ch_offset;
>> +	dst->lun_offset =3D src->lun_offset;
>> +	dst->blk_offset =3D src->blk_offset;
>> +	dst->pg_offset =3D src->pg_offset;
>> +	dst->pln_offset =3D src->pln_offset;
>> +	dst->sect_offset =3D src->sec_offset;
>> +
>> +	dst->ch_mask =3D ((1ULL << dst->ch_len) - 1) << dst->ch_offset;
>> +	dst->lun_mask =3D ((1ULL << dst->lun_len) - 1) << =
dst->lun_offset;
>> +	dst->blk_mask =3D ((1ULL << dst->blk_len) - 1) << =
dst->blk_offset;
>> +	dst->pg_mask =3D ((1ULL << dst->pg_len) - 1) << dst->pg_offset;
>> +	dst->pln_mask =3D ((1ULL << dst->pln_len) - 1) << =
dst->pln_offset;
>> +	dst->sec_mask =3D ((1ULL << dst->sect_len) - 1) << =
dst->sect_offset;
>> +}
>> +
>> +static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
>> +			     struct nvm_dev_geo *dev_geo)
>>  {
>>  	struct nvme_nvm_id12_grp *src;
>>  	int sec_per_pg, sec_per_pl, pg_per_blk;
>>  -	if (id12->cgrps !=3D 1)
>> +	if (id->cgrps !=3D 1)
>>  		return -EINVAL;
>>  -	src =3D &id12->grp;
>> +	src =3D &id->grp;
>>  -	nvm_id->mtype =3D src->mtype;
>> -	nvm_id->fmtype =3D src->fmtype;
>> +	if (src->mtype !=3D 0) {
>> +		pr_err("nvm: memory type not supported\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* 1.2 spec. only reports a single version id - unfold */
>> +	dev_geo->ver_id =3D id->ver_id;
>>  -	nvm_id->num_ch =3D src->num_ch;
>> -	nvm_id->num_lun =3D src->num_lun;
>> +	dev_geo->nr_chnls =3D src->num_ch;
>> +	dev_geo->nr_luns =3D src->num_lun;
>> +	dev_geo->all_luns =3D dev_geo->nr_chnls * dev_geo->nr_luns;
>>  -	nvm_id->num_chk =3D le16_to_cpu(src->num_chk);
>> -	nvm_id->csecs =3D le16_to_cpu(src->csecs);
>> -	nvm_id->sos =3D le16_to_cpu(src->sos);
>> +	dev_geo->c.num_chk =3D le16_to_cpu(src->num_chk);
>> +	dev_geo->c.csecs =3D le16_to_cpu(src->csecs);
>> +	dev_geo->c.sos =3D le16_to_cpu(src->sos);
>>    	pg_per_blk =3D le16_to_cpu(src->num_pg);
>> -	sec_per_pg =3D le16_to_cpu(src->fpg_sz) / nvm_id->csecs;
>> +	sec_per_pg =3D le16_to_cpu(src->fpg_sz) / dev_geo->c.csecs;
>>  	sec_per_pl =3D sec_per_pg * src->num_pln;
>> -	nvm_id->clba =3D sec_per_pl * pg_per_blk;
>> -	nvm_id->ws_per_chk =3D pg_per_blk;
>> -
>> -	nvm_id->mpos =3D le32_to_cpu(src->mpos);
>> -	nvm_id->cpar =3D le16_to_cpu(src->cpar);
>> -	nvm_id->mccap =3D le32_to_cpu(src->mccap);
>> -
>> -	nvm_id->ws_opt =3D nvm_id->ws_min =3D sec_per_pg;
>> -	nvm_id->ws_seq =3D NVM_IO_SNGL_ACCESS;
>> -
>> -	if (nvm_id->mpos & 0x020202) {
>> -		nvm_id->ws_seq =3D NVM_IO_DUAL_ACCESS;
>> -		nvm_id->ws_opt <<=3D 1;
>> -	} else if (nvm_id->mpos & 0x040404) {
>> -		nvm_id->ws_seq =3D NVM_IO_QUAD_ACCESS;
>> -		nvm_id->ws_opt <<=3D 2;
>> +	dev_geo->c.clba =3D sec_per_pl * pg_per_blk;
>> +
>> +	dev_geo->c.ws_min =3D sec_per_pg;
>> +	dev_geo->c.ws_opt =3D sec_per_pg;
>> +	dev_geo->c.mw_cunits =3D 8;		/* default to MLC safe =
values */
>> +
>> +	dev_geo->c.mccap =3D le32_to_cpu(src->mccap);
>> +
>> +	dev_geo->c.trdt =3D le32_to_cpu(src->trdt);
>> +	dev_geo->c.trdm =3D le32_to_cpu(src->trdm);
>> +	dev_geo->c.tprt =3D le32_to_cpu(src->tprt);
>> +	dev_geo->c.tprm =3D le32_to_cpu(src->tprm);
>> +	dev_geo->c.tbet =3D le32_to_cpu(src->tbet);
>> +	dev_geo->c.tbem =3D le32_to_cpu(src->tbem);
>> +
>> +	/* 1.2 compatibility */
>> +	dev_geo->c.vmnt =3D id->vmnt;
>> +	dev_geo->c.cap =3D le32_to_cpu(id->cap);
>> +	dev_geo->c.dom =3D le32_to_cpu(id->dom);
>> +
>> +	dev_geo->c.mtype =3D src->mtype;
>> +	dev_geo->c.fmtype =3D src->fmtype;
>> +
>> +	dev_geo->c.cpar =3D le16_to_cpu(src->cpar);
>> +	dev_geo->c.mpos =3D le32_to_cpu(src->mpos);
>> +
>> +	dev_geo->c.pln_mode =3D NVM_PLANE_SINGLE;
>> +
>> +	if (dev_geo->c.mpos & 0x020202) {
>> +		dev_geo->c.pln_mode =3D NVM_PLANE_DOUBLE;
>> +		dev_geo->c.ws_opt <<=3D 1;
>> +	} else if (dev_geo->c.mpos & 0x040404) {
>> +		dev_geo->c.pln_mode =3D NVM_PLANE_QUAD;
>> +		dev_geo->c.ws_opt <<=3D 2;
>>  	}
>>  -	nvm_id->trdt =3D le32_to_cpu(src->trdt);
>> -	nvm_id->trdm =3D le32_to_cpu(src->trdm);
>> -	nvm_id->tprt =3D le32_to_cpu(src->tprt);
>> -	nvm_id->tprm =3D le32_to_cpu(src->tprm);
>> -	nvm_id->tbet =3D le32_to_cpu(src->tbet);
>> -	nvm_id->tbem =3D le32_to_cpu(src->tbem);
>> -
>> -	/* 1.2 compatibility */
>> -	nvm_id->num_pln =3D src->num_pln;
>> -	nvm_id->num_pg =3D le16_to_cpu(src->num_pg);
>> -	nvm_id->fpg_sz =3D le16_to_cpu(src->fpg_sz);
>> +	dev_geo->c.num_pln =3D src->num_pln;
>> +	dev_geo->c.num_pg =3D le16_to_cpu(src->num_pg);
>> +	dev_geo->c.fpg_sz =3D le16_to_cpu(src->fpg_sz);
>> +
>> +	nvme_nvm_set_addr_12((struct nvm_addr_format_12 =
*)&dev_geo->c.addrf,
>> +								=
&id->ppaf);
>>    	return 0;
>>  }
>>  -static int nvme_nvm_setup_12(struct nvm_dev *nvmdev, struct nvm_id =
*nvm_id,
>> -		struct nvme_nvm_id12 *id)
>> +static void nvme_nvm_set_addr_20(struct nvm_addr_format *dst,
>> +				 struct nvme_nvm_id20_addrf *src)
>>  {
>> -	nvm_id->ver_id =3D id->ver_id;
>> -	nvm_id->vmnt =3D id->vmnt;
>> -	nvm_id->cap =3D le32_to_cpu(id->cap);
>> -	nvm_id->dom =3D le32_to_cpu(id->dom);
>> -	memcpy(&nvm_id->ppaf, &id->ppaf,
>> -					sizeof(struct nvm_addr_format));
>> -
>> -	return init_grp(nvm_id, id);
>> +	dst->ch_len =3D src->grp_len;
>> +	dst->lun_len =3D src->pu_len;
>> +	dst->chk_len =3D src->chk_len;
>> +	dst->sec_len =3D src->lba_len;
>> +
>> +	dst->sec_offset =3D 0;
>> +	dst->chk_offset =3D dst->sec_len;
>> +	dst->lun_offset =3D dst->chk_offset + dst->chk_len;
>> +	dst->ch_offset =3D dst->lun_offset + dst->lun_len;
>> +
>> +	dst->ch_mask =3D ((1ULL << dst->ch_len) - 1) << dst->ch_offset;
>> +	dst->lun_mask =3D ((1ULL << dst->lun_len) - 1) << =
dst->lun_offset;
>> +	dst->chk_mask =3D ((1ULL << dst->chk_len) - 1) << =
dst->chk_offset;
>> +	dst->sec_mask =3D ((1ULL << dst->sec_len) - 1) << =
dst->sec_offset;
>>  }
>>  -static int nvme_nvm_setup_20(struct nvm_dev *nvmdev, struct nvm_id =
*nvm_id,
>> -		struct nvme_nvm_id20 *id)
>> +static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
>> +			     struct nvm_dev_geo *dev_geo)
>>  {
>> -	nvm_id->ver_id =3D id->mjr;
>> +	dev_geo->ver_id =3D id->mjr;
>>  -	nvm_id->num_ch =3D le16_to_cpu(id->num_grp);
>> -	nvm_id->num_lun =3D le16_to_cpu(id->num_pu);
>> -	nvm_id->num_chk =3D le32_to_cpu(id->num_chk);
>> -	nvm_id->clba =3D le32_to_cpu(id->clba);
>> +	dev_geo->nr_chnls =3D le16_to_cpu(id->num_grp);
>> +	dev_geo->nr_luns =3D le16_to_cpu(id->num_pu);
>> +	dev_geo->all_luns =3D dev_geo->nr_chnls * dev_geo->nr_luns;
>>  -	nvm_id->ws_min =3D le32_to_cpu(id->ws_min);
>> -	nvm_id->ws_opt =3D le32_to_cpu(id->ws_opt);
>> -	nvm_id->mw_cunits =3D le32_to_cpu(id->mw_cunits);
>> +	dev_geo->c.num_chk =3D le32_to_cpu(id->num_chk);
>> +	dev_geo->c.clba =3D le32_to_cpu(id->clba);
>> +	dev_geo->c.csecs =3D -1;		/* Set by nvme identify =
*/
>> +	dev_geo->c.sos =3D -1;		/* Set bu nvme identify */
>>  -	nvm_id->trdt =3D le32_to_cpu(id->trdt);
>> -	nvm_id->trdm =3D le32_to_cpu(id->trdm);
>> -	nvm_id->tprt =3D le32_to_cpu(id->twrt);
>> -	nvm_id->tprm =3D le32_to_cpu(id->twrm);
>> -	nvm_id->tbet =3D le32_to_cpu(id->tcrst);
>> -	nvm_id->tbem =3D le32_to_cpu(id->tcrsm);
>> +	dev_geo->c.ws_min =3D le32_to_cpu(id->ws_min);
>> +	dev_geo->c.ws_opt =3D le32_to_cpu(id->ws_opt);
>> +	dev_geo->c.mw_cunits =3D le32_to_cpu(id->mw_cunits);
>>  -	/* calculated values */
>> -	nvm_id->ws_per_chk =3D nvm_id->clba / nvm_id->ws_min;
>> +	dev_geo->c.trdt =3D le32_to_cpu(id->trdt);
>> +	dev_geo->c.trdm =3D le32_to_cpu(id->trdm);
>> +	dev_geo->c.tprt =3D le32_to_cpu(id->twrt);
>> +	dev_geo->c.tprm =3D le32_to_cpu(id->twrm);
>> +	dev_geo->c.tbet =3D le32_to_cpu(id->tcrst);
>> +	dev_geo->c.tbem =3D le32_to_cpu(id->tcrsm);
>>  -	/* 1.2 compatibility */
>> -	nvm_id->ws_seq =3D NVM_IO_SNGL_ACCESS;
>> +	nvme_nvm_set_addr_20(&dev_geo->c.addrf, &id->lbaf);
>>    	return 0;
>>  }
>>  -static int nvme_nvm_identity(struct nvm_dev *nvmdev, struct nvm_id =
*nvm_id)
>> +static int nvme_nvm_identity(struct nvm_dev *nvmdev)
>>  {
>>  	struct nvme_ns *ns =3D nvmdev->q->queuedata;
>>  	struct nvme_nvm_id12 *id;
>> @@ -380,18 +431,18 @@ static int nvme_nvm_identity(struct nvm_dev =
*nvmdev, struct nvm_id *nvm_id)
>>  	 */
>>  	switch (id->ver_id) {
>>  	case 1:
>> -		ret =3D nvme_nvm_setup_12(nvmdev, nvm_id, id);
>> +		ret =3D nvme_nvm_setup_12(id, &nvmdev->dev_geo);
>>  		break;
>>  	case 2:
>> -		ret =3D nvme_nvm_setup_20(nvmdev, nvm_id,
>> -				(struct nvme_nvm_id20 *)id);
>> +		ret =3D nvme_nvm_setup_20((struct nvme_nvm_id20 *)id,
>> +							=
&nvmdev->dev_geo);
>>  		break;
>>  	default:
>> -		dev_err(ns->ctrl->device,
>> -			"OCSSD revision not supported (%d)\n",
>> -			nvm_id->ver_id);
>> +		dev_err(ns->ctrl->device, "OCSSD revision not supported =
(%d)\n",
>> +							id->ver_id);
>>  		ret =3D -EINVAL;
>>  	}
>> +
>>  out:
>>  	kfree(id);
>>  	return ret;
>> @@ -401,12 +452,12 @@ static int nvme_nvm_get_bb_tbl(struct nvm_dev =
*nvmdev, struct ppa_addr ppa,
>>  								u8 =
*blks)
>>  {
>>  	struct request_queue *q =3D nvmdev->q;
>> -	struct nvm_geo *geo =3D &nvmdev->geo;
>> +	struct nvm_dev_geo *dev_geo =3D &nvmdev->dev_geo;
>>  	struct nvme_ns *ns =3D q->queuedata;
>>  	struct nvme_ctrl *ctrl =3D ns->ctrl;
>>  	struct nvme_nvm_command c =3D {};
>>  	struct nvme_nvm_bb_tbl *bb_tbl;
>> -	int nr_blks =3D geo->nr_chks * geo->plane_mode;
>> +	int nr_blks =3D dev_geo->c.num_chk * dev_geo->c.num_pln;
>>  	int tblsz =3D sizeof(struct nvme_nvm_bb_tbl) + nr_blks;
>>  	int ret =3D 0;
>>  @@ -447,7 +498,7 @@ static int nvme_nvm_get_bb_tbl(struct nvm_dev =
*nvmdev, struct ppa_addr ppa,
>>  		goto out;
>>  	}
>>  -	memcpy(blks, bb_tbl->blk, geo->nr_chks * geo->plane_mode);
>> +	memcpy(blks, bb_tbl->blk, dev_geo->c.num_chk * =
dev_geo->c.num_pln);
>>  out:
>>  	kfree(bb_tbl);
>>  	return ret;
>> @@ -815,9 +866,10 @@ int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned =
int cmd, unsigned long arg)
>>  void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>>  {
>>  	struct nvm_dev *ndev =3D ns->ndev;
>> +	struct nvm_dev_geo *dev_geo =3D &ndev->dev_geo;
>>  -	ndev->identity.csecs =3D ndev->geo.sec_size =3D 1 << =
ns->lba_shift;
>> -	ndev->identity.sos =3D ndev->geo.oob_size =3D ns->ms;
>> +	dev_geo->c.csecs =3D 1 << ns->lba_shift;
>> +	dev_geo->c.sos =3D ns->ms;
>>  }
>>    int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int =
node)
>> @@ -850,23 +902,22 @@ static ssize_t nvm_dev_attr_show(struct device =
*dev,
>>  {
>>  	struct nvme_ns *ns =3D nvme_get_ns_from_dev(dev);
>>  	struct nvm_dev *ndev =3D ns->ndev;
>> -	struct nvm_id *id;
>> +	struct nvm_dev_geo *dev_geo =3D &ndev->dev_geo;
>>  	struct attribute *attr;
>>    	if (!ndev)
>>  		return 0;
>>  -	id =3D &ndev->identity;
>>  	attr =3D &dattr->attr;
>>    	if (strcmp(attr->name, "version") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->ver_id);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->ver_id);
>>  	} else if (strcmp(attr->name, "capabilities") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->cap);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.cap);
>>  	} else if (strcmp(attr->name, "read_typ") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->trdt);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.trdt);
>>  	} else if (strcmp(attr->name, "read_max") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->trdm);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.trdm);
>>  	} else {
>>  		return scnprintf(page,
>>  				 PAGE_SIZE,
>> @@ -875,75 +926,79 @@ static ssize_t nvm_dev_attr_show(struct device =
*dev,
>>  	}
>>  }
>>  +static ssize_t nvm_dev_attr_show_ppaf(struct nvm_addr_format_12 =
*ppaf,
>> +					 char *page)
>> +{
>> +	return scnprintf(page, PAGE_SIZE,
>> +		"0x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x\n",
>> +				ppaf->ch_offset, ppaf->ch_len,
>> +				ppaf->lun_offset, ppaf->lun_len,
>> +				ppaf->pln_offset, ppaf->pln_len,
>> +				ppaf->blk_offset, ppaf->blk_len,
>> +				ppaf->pg_offset, ppaf->pg_len,
>> +				ppaf->sect_offset, ppaf->sect_len);
>> +}
>> +
>>  static ssize_t nvm_dev_attr_show_12(struct device *dev,
>>  		struct device_attribute *dattr, char *page)
>>  {
>>  	struct nvme_ns *ns =3D nvme_get_ns_from_dev(dev);
>>  	struct nvm_dev *ndev =3D ns->ndev;
>> -	struct nvm_id *id;
>> +	struct nvm_dev_geo *dev_geo =3D &ndev->dev_geo;
>>  	struct attribute *attr;
>>    	if (!ndev)
>>  		return 0;
>>  -	id =3D &ndev->identity;
>>  	attr =3D &dattr->attr;
>>    	if (strcmp(attr->name, "vendor_opcode") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->vmnt);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.vmnt);
>>  	} else if (strcmp(attr->name, "device_mode") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->dom);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.dom);
>>  	/* kept for compatibility */
>>  	} else if (strcmp(attr->name, "media_manager") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%s\n", "gennvm");
>>  	} else if (strcmp(attr->name, "ppa_format") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE,
>> -			=
"0x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x\n",
>> -			id->ppaf.ch_offset, id->ppaf.ch_len,
>> -			id->ppaf.lun_offset, id->ppaf.lun_len,
>> -			id->ppaf.pln_offset, id->ppaf.pln_len,
>> -			id->ppaf.blk_offset, id->ppaf.blk_len,
>> -			id->ppaf.pg_offset, id->ppaf.pg_len,
>> -			id->ppaf.sect_offset, id->ppaf.sect_len);
>> +		return nvm_dev_attr_show_ppaf((void *)&dev_geo->c.addrf, =
page);
>>  	} else if (strcmp(attr->name, "media_type") =3D=3D 0) {	/* u8 */
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->mtype);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.mtype);
>>  	} else if (strcmp(attr->name, "flash_media_type") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->fmtype);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.fmtype);
>>  	} else if (strcmp(attr->name, "num_channels") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->num_ch);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->nr_chnls);
>>  	} else if (strcmp(attr->name, "num_luns") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->num_lun);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->nr_luns);
>>  	} else if (strcmp(attr->name, "num_planes") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->num_pln);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.num_pln);
>>  	} else if (strcmp(attr->name, "num_blocks") =3D=3D 0) {	/* u16 =
*/
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->num_chk);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.num_chk);
>>  	} else if (strcmp(attr->name, "num_pages") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->num_pg);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.num_pg);
>>  	} else if (strcmp(attr->name, "page_size") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->fpg_sz);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.fpg_sz);
>>  	} else if (strcmp(attr->name, "hw_sector_size") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->csecs);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.csecs);
>>  	} else if (strcmp(attr->name, "oob_sector_size") =3D=3D 0) {/* =
u32 */
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->sos);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.sos);
>>  	} else if (strcmp(attr->name, "prog_typ") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->tprt);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tprt);
>>  	} else if (strcmp(attr->name, "prog_max") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->tprm);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tprm);
>>  	} else if (strcmp(attr->name, "erase_typ") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->tbet);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tbet);
>>  	} else if (strcmp(attr->name, "erase_max") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->tbem);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tbem);
>>  	} else if (strcmp(attr->name, "multiplane_modes") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "0x%08x\n", id->mpos);
>> +		return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.mpos);
>>  	} else if (strcmp(attr->name, "media_capabilities") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
id->mccap);
>> +		return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.mccap);
>>  	} else if (strcmp(attr->name, "max_phys_secs") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", NVM_MAX_VLBA);
>>  	} else {
>> -		return scnprintf(page,
>> -				 PAGE_SIZE,
>> -				 "Unhandled attr(%s) in =
`nvm_dev_attr_show_12`\n",
>> -				 attr->name);
>> +		return scnprintf(page, PAGE_SIZE,
>> +			"Unhandled attr(%s) in =
`nvm_dev_attr_show_12`\n",
>> +			attr->name);
>>  	}
>>  }
>>  @@ -952,42 +1007,40 @@ static ssize_t nvm_dev_attr_show_20(struct =
device *dev,
>>  {
>>  	struct nvme_ns *ns =3D nvme_get_ns_from_dev(dev);
>>  	struct nvm_dev *ndev =3D ns->ndev;
>> -	struct nvm_id *id;
>> +	struct nvm_dev_geo *dev_geo =3D &ndev->dev_geo;
>>  	struct attribute *attr;
>>    	if (!ndev)
>>  		return 0;
>>  -	id =3D &ndev->identity;
>>  	attr =3D &dattr->attr;
>>    	if (strcmp(attr->name, "groups") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->num_ch);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->nr_chnls);
>>  	} else if (strcmp(attr->name, "punits") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->num_lun);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->nr_luns);
>>  	} else if (strcmp(attr->name, "chunks") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->num_chk);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.num_chk);
>>  	} else if (strcmp(attr->name, "clba") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->clba);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.clba);
>>  	} else if (strcmp(attr->name, "ws_min") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->ws_min);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.ws_min);
>>  	} else if (strcmp(attr->name, "ws_opt") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->ws_opt);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.ws_opt);
>>  	} else if (strcmp(attr->name, "mw_cunits") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
id->mw_cunits);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.mw_cunits);
>>  	} else if (strcmp(attr->name, "write_typ") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->tprt);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tprt);
>>  	} else if (strcmp(attr->name, "write_max") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->tprm);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tprm);
>>  	} else if (strcmp(attr->name, "reset_typ") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->tbet);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tbet);
>>  	} else if (strcmp(attr->name, "reset_max") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", id->tbem);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tbem);
>>  	} else {
>> -		return scnprintf(page,
>> -				 PAGE_SIZE,
>> -				 "Unhandled attr(%s) in =
`nvm_dev_attr_show_20`\n",
>> -				 attr->name);
>> +		return scnprintf(page, PAGE_SIZE,
>> +			"Unhandled attr(%s) in =
`nvm_dev_attr_show_20`\n",
>> +			attr->name);
>>  	}
>>  }
>>  @@ -1106,10 +1159,13 @@ static const struct attribute_group =
nvm_dev_attr_group_20 =3D {
>>    int nvme_nvm_register_sysfs(struct nvme_ns *ns)
>>  {
>> -	if (!ns->ndev)
>> +	struct nvm_dev *ndev =3D ns->ndev;
>> +	struct nvm_dev_geo *dev_geo =3D &ndev->dev_geo;
>> +
>> +	if (!ndev)
>>  		return -EINVAL;
>>  -	switch (ns->ndev->identity.ver_id) {
>> +	switch (dev_geo->ver_id) {
>>  	case 1:
>>  		return sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
>>  					&nvm_dev_attr_group_12);
>> @@ -1123,7 +1179,10 @@ int nvme_nvm_register_sysfs(struct nvme_ns =
*ns)
>>    void nvme_nvm_unregister_sysfs(struct nvme_ns *ns)
>>  {
>> -	switch (ns->ndev->identity.ver_id) {
>> +	struct nvm_dev *ndev =3D ns->ndev;
>> +	struct nvm_dev_geo *dev_geo =3D &ndev->dev_geo;
>> +
>> +	switch (dev_geo->ver_id) {
>>  	case 1:
>>  		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
>>  					&nvm_dev_attr_group_12);
>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>> index e55b10573c99..18e3751b1632 100644
>> --- a/include/linux/lightnvm.h
>> +++ b/include/linux/lightnvm.h
>> @@ -50,7 +50,7 @@ struct nvm_id;
>>  struct nvm_dev;
>>  struct nvm_tgt_dev;
>>  -typedef int (nvm_id_fn)(struct nvm_dev *, struct nvm_id *);
>> +typedef int (nvm_id_fn)(struct nvm_dev *);
>>  typedef int (nvm_op_bb_tbl_fn)(struct nvm_dev *, struct ppa_addr, u8 =
*);
>>  typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, struct ppa_addr *, =
int, int);
>>  typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
>> @@ -152,62 +152,107 @@ struct nvm_id_lp_tbl {
>>  	struct nvm_id_lp_mlc mlc;
>>  };
>>  -struct nvm_addr_format {
>> -	u8	ch_offset;
>> +struct nvm_addr_format_12 {
>>  	u8	ch_len;
>> -	u8	lun_offset;
>>  	u8	lun_len;
>> -	u8	pln_offset;
>> +	u8	blk_len;
>> +	u8	pg_len;
>>  	u8	pln_len;
>> +	u8	sect_len;
>> +
>> +	u8	ch_offset;
>> +	u8	lun_offset;
>>  	u8	blk_offset;
>> -	u8	blk_len;
>>  	u8	pg_offset;
>> -	u8	pg_len;
>> +	u8	pln_offset;
>>  	u8	sect_offset;
>> -	u8	sect_len;
>> +
>> +	u64	ch_mask;
>> +	u64	lun_mask;
>> +	u64	blk_mask;
>> +	u64	pg_mask;
>> +	u64	pln_mask;
>> +	u64	sec_mask;
>> +};
>> +
>> +struct nvm_addr_format {
>> +	u8	ch_len;
>> +	u8	lun_len;
>> +	u8	chk_len;
>> +	u8	sec_len;
>> +	u8	rsv_len[2];
>> +
>> +	u8	ch_offset;
>> +	u8	lun_offset;
>> +	u8	chk_offset;
>> +	u8	sec_offset;
>> +	u8	rsv_off[2];
>> +
>> +	u64	ch_mask;
>> +	u64	lun_mask;
>> +	u64	chk_mask;
>> +	u64	sec_mask;
>> +	u64	rsv_mask[2];
>>  };
>>  -struct nvm_id {
>> -	u8	ver_id;
>> +/* Device common geometry */
>> +struct nvm_common_geo {
>> +	/* chunk geometry */
>> +	u32	num_chk;	/* chunks per lun */
>> +	u32	clba;		/* sectors per chunk */
>> +	u16	csecs;		/* sector size */
>> +	u16	sos;		/* out-of-band area size */
>> +
>> +	/* device write constrains */
>> +	u32	ws_min;		/* minimum write size */
>> +	u32	ws_opt;		/* optimal write size */
>> +	u32	mw_cunits;	/* distance required for successful read =
*/
>> +
>> +	/* device capabilities */
>> +	u32	mccap;
>> +
>> +	/* device timings */
>> +	u32	trdt;		/* Avg. Tread (ns) */
>> +	u32	trdm;		/* Max Tread (ns) */
>> +	u32	tprt;		/* Avg. Tprog (ns) */
>> +	u32	tprm;		/* Max Tprog (ns) */
>> +	u32	tbet;		/* Avg. Terase (ns) */
>> +	u32	tbem;		/* Max Terase (ns) */
>> +
>> +	/* generic address format */
>> +	struct nvm_addr_format addrf;
>> +
>> +	/* 1.2 compatibility */
>>  	u8	vmnt;
>>  	u32	cap;
>>  	u32	dom;
>>  -	struct	nvm_addr_format ppaf;
>> -
>> -	u8	num_ch;
>> -	u8	num_lun;
>> -	u16	num_chk;
>> -	u16	clba;
>> -	u16	csecs;
>> -	u16	sos;
>> -
>> -	u32	ws_min;
>> -	u32	ws_opt;
>> -	u32	mw_cunits;
>> -
>> -	u32	trdt;
>> -	u32	trdm;
>> -	u32	tprt;
>> -	u32	tprm;
>> -	u32	tbet;
>> -	u32	tbem;
>> -	u32	mpos;
>> -	u32	mccap;
>> -	u16	cpar;
>> -
>> -	/* calculated values */
>> -	u16	ws_seq;
>> -	u16	ws_per_chk;
>> -
>> -	/* 1.2 compatibility */
>>  	u8	mtype;
>>  	u8	fmtype;
>>  +	u16	cpar;
>> +	u32	mpos;
>> +
>>  	u8	num_pln;
>> +	u8	pln_mode;
>>  	u16	num_pg;
>>  	u16	fpg_sz;
>> -} __packed;
>> +};
>> +
>> +/* Device identified geometry */
>> +struct nvm_dev_geo {
>> +	/* device reported version */
>> +	u8	ver_id;
>> +
>> +	/* full device geometry */
>> +	u16	nr_chnls;
>> +	u16	nr_luns;
>> +
>> +	/* calculated values */
>> +	u16	all_luns;
>> +
>> +	struct nvm_common_geo c;
>> +};
>>    struct nvm_target {
>>  	struct list_head list;
>> @@ -274,36 +319,22 @@ enum {
>>  	NVM_BLK_ST_BAD =3D	0x8,	/* Bad block */
>>  };
>>  -
>> -/* Device generic information */
>> +/* Instance geometry */
>>  struct nvm_geo {
>> -	/* generic geometry */
>> +	/* instance specific geometry */
>>  	int nr_chnls;
>> -	int all_luns; /* across channels */
>> -	int nr_luns; /* per channel */
>> -	int nr_chks; /* per lun */
>> -
>> -	int sec_size;
>> -	int oob_size;
>> -	int mccap;
>> -
>> -	int sec_per_chk;
>> -	int sec_per_lun;
>> -
>> -	int ws_min;
>> -	int ws_opt;
>> -	int ws_seq;
>> -	int ws_per_chk;
>> +	int nr_luns;		/* per channel */
>>    	int op;
>>  -	struct nvm_addr_format ppaf;
>> +	/* common geometry */
>> +	struct nvm_common_geo c;
>>  -	/* Legacy 1.2 specific geometry */
>> -	int plane_mode; /* drive device in single, double or quad mode =
*/
>> -	int nr_planes;
>> -	int sec_per_pg; /* only sectors for a single page */
>> -	int sec_per_pl; /* all sectors across planes */
>> +	/* calculated values */
>> +	int all_luns;		/* across channels */
>> +	int all_chunks;		/* across channels */
>> +
>> +	sector_t total_secs;	/* across channels */
>>  };
>>    /* sub-device structure */
>> @@ -314,9 +345,6 @@ struct nvm_tgt_dev {
>>  	/* Base ppas for target LUNs */
>>  	struct ppa_addr *luns;
>>  -	sector_t total_secs;
>> -
>> -	struct nvm_id identity;
>>  	struct request_queue *q;
>>    	struct nvm_dev *parent;
>> @@ -329,15 +357,11 @@ struct nvm_dev {
>>  	struct list_head devices;
>>    	/* Device information */
>> -	struct nvm_geo geo;
>> -
>> -	unsigned long total_secs;
>> +	struct nvm_dev_geo dev_geo;
>>    	unsigned long *lun_map;
>>  	void *dma_pool;
>>  -	struct nvm_id identity;
>> -
>>  	/* Backend device */
>>  	struct request_queue *q;
>>  	char name[DISK_NAME_LEN];
>> @@ -357,14 +381,16 @@ static inline struct ppa_addr =
generic_to_dev_addr(struct nvm_tgt_dev *tgt_dev,
>>  						  struct ppa_addr r)
>>  {
>>  	struct nvm_geo *geo =3D &tgt_dev->geo;
>> +	struct nvm_addr_format_12 *ppaf =3D
>> +				(struct nvm_addr_format_12 =
*)&geo->c.addrf;
>>  	struct ppa_addr l;
>>  -	l.ppa =3D ((u64)r.g.blk) << geo->ppaf.blk_offset;
>> -	l.ppa |=3D ((u64)r.g.pg) << geo->ppaf.pg_offset;
>> -	l.ppa |=3D ((u64)r.g.sec) << geo->ppaf.sect_offset;
>> -	l.ppa |=3D ((u64)r.g.pl) << geo->ppaf.pln_offset;
>> -	l.ppa |=3D ((u64)r.g.lun) << geo->ppaf.lun_offset;
>> -	l.ppa |=3D ((u64)r.g.ch) << geo->ppaf.ch_offset;
>> +	l.ppa =3D ((u64)r.g.ch) << ppaf->ch_offset;
>> +	l.ppa |=3D ((u64)r.g.lun) << ppaf->lun_offset;
>> +	l.ppa |=3D ((u64)r.g.blk) << ppaf->blk_offset;
>> +	l.ppa |=3D ((u64)r.g.pg) << ppaf->pg_offset;
>> +	l.ppa |=3D ((u64)r.g.pl) << ppaf->pln_offset;
>> +	l.ppa |=3D ((u64)r.g.sec) << ppaf->sect_offset;
>>    	return l;
>>  }
>> @@ -373,24 +399,18 @@ static inline struct ppa_addr =
dev_to_generic_addr(struct nvm_tgt_dev *tgt_dev,
>>  						  struct ppa_addr r)
>>  {
>>  	struct nvm_geo *geo =3D &tgt_dev->geo;
>> +	struct nvm_addr_format_12 *ppaf =3D
>> +				(struct nvm_addr_format_12 =
*)&geo->c.addrf;
>>  	struct ppa_addr l;
>>    	l.ppa =3D 0;
>> -	/*
>> -	 * (r.ppa << X offset) & X len bitmask. X eq. blk, pg, etc.
>> -	 */
>> -	l.g.blk =3D (r.ppa >> geo->ppaf.blk_offset) &
>> -					(((1 << geo->ppaf.blk_len) - =
1));
>> -	l.g.pg |=3D (r.ppa >> geo->ppaf.pg_offset) &
>> -					(((1 << geo->ppaf.pg_len) - 1));
>> -	l.g.sec |=3D (r.ppa >> geo->ppaf.sect_offset) &
>> -					(((1 << geo->ppaf.sect_len) - =
1));
>> -	l.g.pl |=3D (r.ppa >> geo->ppaf.pln_offset) &
>> -					(((1 << geo->ppaf.pln_len) - =
1));
>> -	l.g.lun |=3D (r.ppa >> geo->ppaf.lun_offset) &
>> -					(((1 << geo->ppaf.lun_len) - =
1));
>> -	l.g.ch |=3D (r.ppa >> geo->ppaf.ch_offset) &
>> -					(((1 << geo->ppaf.ch_len) - 1));
>> +
>> +	l.g.ch =3D (r.ppa & ppaf->ch_mask) >> ppaf->ch_offset;
>> +	l.g.lun =3D (r.ppa & ppaf->lun_mask) >> ppaf->lun_offset;
>> +	l.g.blk =3D (r.ppa & ppaf->blk_mask) >> ppaf->blk_offset;
>> +	l.g.pg =3D (r.ppa & ppaf->pg_mask) >> ppaf->pg_offset;
>> +	l.g.pl =3D (r.ppa & ppaf->pln_mask) >> ppaf->pln_offset;
>> +	l.g.sec =3D (r.ppa & ppaf->sec_mask) >> ppaf->sect_offset;
>>    	return l;
>>  }
>=20
> Thanks for the patch. I appreciate the work, but it is not the way I
> want the 2.0 representation to go. The 2.0 variables should stay in
> the nvm_geo data structure, and then if any 1.2 variables are on the
> side, they can be in a substructure.

I don't understand. Everything is in nvm_geo, with the only different
that there is nvm_common_geo, which contains the shared geometry between
all instances. As mentioned before, if only having nvm_geo, then we are
truncating the structure for each instance with different channel/lun
values, which is very from a target perspective (the target can access
the underlying device's values, which is _very_ error prone). This
structure represents all 2.0 variables as they are.I can move all 1.2
variables to a sub structure if that helps.

If this is not it, can you explain in detail what the problem is? In
pblk, I don't want to deal with a device-centric structure and variables
spread out across what was identity and nvm_geo, I want a single
structure that contains everything, which is the motivation for this
patch.

Javier


--Apple-Mail=_24659DA3-EC99-4059-9349-FA3DACCEC50D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqOdOEACgkQIX4xUKFR
nnRhohAA0X2NyU2/QlzeQ7BBvRwAeHRDyhNJcprSsd1PavqCg1L5VCB8VAZJLsTX
APkUMjD+KdftLbXN3LJqw8DDj/d+SajezRoK/pkCyMsxpZ/pnR+o2o+8kHwq3J1V
+7JF9bFXtK3fpWkuulbpz8x2GDOZDz+PPrQdA2HRraQwqqK97s4Xb+UgqUB8C/4L
gPMxkV3YcaYEWfddVDmuK5oeA53FGXBVOCuCcONGQAriEwpu73coYnfQ6lJEyLL2
4hJn2pSJ34uAH7jQD0oe940+cchwYNX0WRn48pHVUVgZjSBFFxc4kcpNAFDHw/C5
4yjK8XYsJCqLdmvCJVfSIoXipUk6OcAkv57vg1A4w6iTbIOEfD201wsiJuB6fky/
Q01OPIlR86qjP2kOwM0mR0efzZlSHJH3BMujXWXBE8sG4XeXsCA5Ly7PiMa8dTkL
4xy2sejy+zg59XFgG3SN5/dZT9eusNhv7pE/bq1sdqxQ+M/b2FIVhjTyEwH0mrR+
R0azoPxRKEESeS6I+eM62Bds7uCY6aKXYXQhXmd5+B77pxj6+s8cco/cYS1o58+X
77k7Z+K0Zve6uWpNgsDri6tpEMYldyquRWA02NrxLPcgiOhxpFNA6oy865ViTNDy
sQ4iCodPM0aLR9RN3NGDa8LCJqcCDcz1NiWx0t0xmMFKq03c5Uw=
=zi1q
-----END PGP SIGNATURE-----

--Apple-Mail=_24659DA3-EC99-4059-9349-FA3DACCEC50D--
