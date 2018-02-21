Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41347 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937616AbeBUOa5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 09:30:57 -0500
Received: by mail-wr0-f196.google.com with SMTP id f14so5038926wre.8
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 06:30:56 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <8011E2FC-D5AC-4F18-B9B3-73B1DF03B435@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_3798F2B6-A897-4E5F-A8C1-9C2946ADE409";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 20/20] lightnvm: pblk: implement 2.0 support
Date: Wed, 21 Feb 2018 15:30:50 +0100
In-Reply-To: <1519205218-26994-21-git-send-email-javier@cnexlabs.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
To: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-21-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_3798F2B6-A897-4E5F-A8C1-9C2946ADE409
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

BTW, there is a V3 for this patch at least, adding holes in the mapping
bitmap to avoid the multiplications and divisions on the fast path, when
the media format is not a power of two. I'll send it this week; just
wanted to get this out for revision.

Javier

> On 21 Feb 2018, at 10.26, Javier Gonz=C3=A1lez <jg@lightnvm.io> wrote:
>=20
> Implement 2.0 support in pblk. This includes the address formatting =
and
> mapping paths, as well as the sysfs entries for them.
>=20
> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-init.c  |  57 ++++++++++--
> drivers/lightnvm/pblk-sysfs.c |  36 ++++++--
> drivers/lightnvm/pblk.h       | 198 =
++++++++++++++++++++++++++++++++----------
> 3 files changed, 233 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index c5c304a37554..ce9aa4b3b09a 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -231,20 +231,63 @@ static int pblk_set_addrf_12(struct nvm_geo =
*geo,
> 	return dst->blk_offset + src->blk_len;
> }
>=20
> +static int pblk_set_addrf_20(struct nvm_geo *geo,
> +			     struct nvm_addr_format *adst,
> +			     struct pblk_addr_format *udst)
> +{
> +	struct nvm_addr_format *src =3D &geo->c.addrf;
> +
> +	adst->ch_len =3D get_count_order(geo->num_ch);
> +	adst->lun_len =3D get_count_order(geo->num_lun);
> +	adst->chk_len =3D src->chk_len;
> +	adst->sec_len =3D src->sec_len;
> +
> +	adst->sec_offset =3D 0;
> +	adst->ch_offset =3D adst->sec_len;
> +	adst->lun_offset =3D adst->ch_offset + adst->ch_len;
> +	adst->chk_offset =3D adst->lun_offset + adst->lun_len;
> +
> +	adst->sec_mask =3D ((1ULL << adst->sec_len) - 1) << =
adst->sec_offset;
> +	adst->chk_mask =3D ((1ULL << adst->chk_len) - 1) << =
adst->chk_offset;
> +	adst->lun_mask =3D ((1ULL << adst->lun_len) - 1) << =
adst->lun_offset;
> +	adst->ch_mask =3D ((1ULL << adst->ch_len) - 1) << =
adst->ch_offset;
> +
> +	udst->sec_stripe =3D geo->c.ws_opt;
> +	udst->ch_stripe =3D geo->num_ch;
> +	udst->lun_stripe =3D geo->num_lun;
> +
> +	udst->sec_lun_stripe =3D udst->sec_stripe * udst->ch_stripe;
> +	udst->sec_ws_stripe =3D udst->sec_lun_stripe * udst->lun_stripe;
> +
> +	return adst->chk_offset + adst->chk_len;
> +}
> +
> static int pblk_set_addrf(struct pblk *pblk)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	int mod;
>=20
> -	div_u64_rem(geo->c.clba, pblk->min_write_pgs, &mod);
> -	if (mod) {
> -		pr_err("pblk: bad configuration of sectors/pages\n");
> +	switch (geo->c.version) {
> +	case NVM_OCSSD_SPEC_12:
> +		div_u64_rem(geo->c.clba, pblk->min_write_pgs, &mod);
> +		if (mod) {
> +			pr_err("pblk: bad configuration of =
sectors/pages\n");
> +			return -EINVAL;
> +		}
> +
> +		pblk->addrf_len =3D pblk_set_addrf_12(geo, (void =
*)&pblk->addrf);
> +		break;
> +	case NVM_OCSSD_SPEC_20:
> +		pblk->addrf_len =3D pblk_set_addrf_20(geo, (void =
*)&pblk->addrf,
> +								=
&pblk->uaddrf);
> +		break;
> +	default:
> +		pr_err("pblk: OCSSD revision not supported (%d)\n",
> +								=
geo->c.version);
> 		return -EINVAL;
> 	}
>=20
> -	pblk->addrf_len =3D pblk_set_addrf_12(geo, (void =
*)&pblk->addrf);
> -
> 	return 0;
> }
>=20
> @@ -1110,7 +1153,9 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
> 	struct pblk *pblk;
> 	int ret;
>=20
> -	if (geo->c.version !=3D NVM_OCSSD_SPEC_12) {
> +	/* pblk supports 1.2 and 2.0 versions */
> +	if (!(geo->c.version =3D=3D NVM_OCSSD_SPEC_12 ||
> +					geo->c.version =3D=3D =
NVM_OCSSD_SPEC_20)) {
> 		pr_err("pblk: OCSSD version not supported (%u)\n",
> 							geo->c.version);
> 		return ERR_PTR(-EINVAL);
> diff --git a/drivers/lightnvm/pblk-sysfs.c =
b/drivers/lightnvm/pblk-sysfs.c
> index 191af0c6591e..60b8d931e4ba 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -113,15 +113,16 @@ static ssize_t pblk_sysfs_ppaf(struct pblk =
*pblk, char *page)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> -	struct nvm_addr_format_12 *ppaf;
> -	struct nvm_addr_format_12 *geo_ppaf;
> 	ssize_t sz =3D 0;
>=20
> -	ppaf =3D (struct nvm_addr_format_12 *)&pblk->addrf;
> -	geo_ppaf =3D (struct nvm_addr_format_12 *)&geo->c.addrf;
> +	if (geo->c.version =3D=3D NVM_OCSSD_SPEC_12) {
> +		struct nvm_addr_format_12 *ppaf =3D
> +				(struct nvm_addr_format_12 =
*)&pblk->addrf;
> +		struct nvm_addr_format_12 *geo_ppaf =3D
> +				(struct nvm_addr_format_12 =
*)&geo->c.addrf;
>=20
> -	sz =3D snprintf(page, PAGE_SIZE,
> -		=
"pblk:(s:%d)ch:%d/%d,lun:%d/%d,blk:%d/%d,pg:%d/%d,pl:%d/%d,sec:%d/%d\n",
> +		sz =3D snprintf(page, PAGE_SIZE,
> +			=
"pblk:(s:%d)ch:%d/%d,lun:%d/%d,blk:%d/%d,pg:%d/%d,pl:%d/%d,sec:%d/%d\n",
> 			pblk->addrf_len,
> 			ppaf->ch_offset, ppaf->ch_len,
> 			ppaf->lun_offset, ppaf->lun_len,
> @@ -130,14 +131,33 @@ static ssize_t pblk_sysfs_ppaf(struct pblk =
*pblk, char *page)
> 			ppaf->pln_offset, ppaf->pln_len,
> 			ppaf->sec_offset, ppaf->sec_len);
>=20
> -	sz +=3D snprintf(page + sz, PAGE_SIZE - sz,
> -		=
"device:ch:%d/%d,lun:%d/%d,blk:%d/%d,pg:%d/%d,pl:%d/%d,sec:%d/%d\n",
> +		sz +=3D snprintf(page + sz, PAGE_SIZE - sz,
> +			=
"device:ch:%d/%d,lun:%d/%d,blk:%d/%d,pg:%d/%d,pl:%d/%d,sec:%d/%d\n",
> 			geo_ppaf->ch_offset, geo_ppaf->ch_len,
> 			geo_ppaf->lun_offset, geo_ppaf->lun_len,
> 			geo_ppaf->blk_offset, geo_ppaf->blk_len,
> 			geo_ppaf->pg_offset, geo_ppaf->pg_len,
> 			geo_ppaf->pln_offset, geo_ppaf->pln_len,
> 			geo_ppaf->sec_offset, geo_ppaf->sec_len);
> +	} else {
> +		struct nvm_addr_format *ppaf =3D &pblk->addrf;
> +		struct nvm_addr_format *geo_ppaf =3D &geo->c.addrf;
> +
> +		sz =3D snprintf(page, PAGE_SIZE,
> +			=
"pblk:(s:%d)ch:%d/%d,lun:%d/%d,chk:%d/%d/sec:%d/%d\n",
> +			pblk->addrf_len,
> +			ppaf->ch_offset, ppaf->ch_len,
> +			ppaf->lun_offset, ppaf->lun_len,
> +			ppaf->chk_offset, ppaf->chk_len,
> +			ppaf->sec_offset, ppaf->sec_len);
> +
> +		sz +=3D snprintf(page + sz, PAGE_SIZE - sz,
> +			=
"device:ch:%d/%d,lun:%d/%d,chk:%d/%d,sec:%d/%d\n",
> +			geo_ppaf->ch_offset, geo_ppaf->ch_len,
> +			geo_ppaf->lun_offset, geo_ppaf->lun_len,
> +			geo_ppaf->chk_offset, geo_ppaf->chk_len,
> +			geo_ppaf->sec_offset, geo_ppaf->sec_len);
> +	}
>=20
> 	return sz;
> }
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index c66fa0c28adf..b92a1145ad97 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -574,6 +574,18 @@ enum {
> 	PBLK_STATE_STOPPED =3D 3,
> };
>=20
> +/* Internal format to support not power-of-2 device formats (for now) =
*/
> +struct pblk_addr_format {
> +	/* gen to dev */
> +	int sec_stripe;
> +	int ch_stripe;
> +	int lun_stripe;
> +
> +	/* dev to gen */
> +	int sec_lun_stripe;
> +	int sec_ws_stripe;
> +};
> +
> struct pblk {
> 	struct nvm_tgt_dev *dev;
> 	struct gendisk *disk;
> @@ -586,7 +598,8 @@ struct pblk {
> 	struct pblk_line_mgmt l_mg;		/* Line management */
> 	struct pblk_line_meta lm;		/* Line metadata */
>=20
> -	struct nvm_addr_format addrf;
> +	struct nvm_addr_format addrf;	/* Aligned address format */
> +	struct pblk_addr_format uaddrf;	/* Unaligned address format */
> 	int addrf_len;
>=20
> 	struct pblk_rb rwb;
> @@ -967,17 +980,43 @@ static inline int pblk_ppa_to_pos(struct nvm_geo =
*geo, struct ppa_addr p)
> static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 =
paddr,
> 					      u64 line_id)
> {
> -	struct nvm_addr_format_12 *ppaf =3D
> -				(struct nvm_addr_format_12 =
*)&pblk->addrf;
> +	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> 	struct ppa_addr ppa;
>=20
> -	ppa.ppa =3D 0;
> -	ppa.g.blk =3D line_id;
> -	ppa.g.pg =3D (paddr & ppaf->pg_mask) >> ppaf->pg_offset;
> -	ppa.g.lun =3D (paddr & ppaf->lun_mask) >> ppaf->lun_offset;
> -	ppa.g.ch =3D (paddr & ppaf->ch_mask) >> ppaf->ch_offset;
> -	ppa.g.pl =3D (paddr & ppaf->pln_mask) >> ppaf->pln_offset;
> -	ppa.g.sec =3D (paddr & ppaf->sec_mask) >> ppaf->sec_offset;
> +	if (geo->c.version =3D=3D NVM_OCSSD_SPEC_12) {
> +		struct nvm_addr_format_12 *ppaf =3D
> +				(struct nvm_addr_format_12 =
*)&pblk->addrf;
> +
> +		ppa.ppa =3D 0;
> +		ppa.g.blk =3D line_id;
> +		ppa.g.pg =3D (paddr & ppaf->pg_mask) >> ppaf->pg_offset;
> +		ppa.g.lun =3D (paddr & ppaf->lun_mask) >> =
ppaf->lun_offset;
> +		ppa.g.ch =3D (paddr & ppaf->ch_mask) >> ppaf->ch_offset;
> +		ppa.g.pl =3D (paddr & ppaf->pln_mask) >> =
ppaf->pln_offset;
> +		ppa.g.sec =3D (paddr & ppaf->sec_mask) >> =
ppaf->sec_offset;
> +	} else {
> +		struct pblk_addr_format *uaddrf =3D &pblk->uaddrf;
> +		int secs, chnls, luns;
> +
> +		ppa.ppa =3D 0;
> +
> +		ppa.m.chk =3D line_id;
> +
> +		div_u64_rem(paddr, uaddrf->sec_stripe, &secs);
> +		ppa.m.sec =3D secs;
> +
> +		sector_div(paddr, uaddrf->sec_stripe);
> +		div_u64_rem(paddr, uaddrf->ch_stripe, &chnls);
> +		ppa.m.ch =3D chnls;
> +
> +		sector_div(paddr, uaddrf->ch_stripe);
> +		div_u64_rem(paddr, uaddrf->lun_stripe, &luns);
> +		ppa.m.lun =3D luns;
> +
> +		sector_div(paddr, uaddrf->lun_stripe);
> +		ppa.m.sec +=3D uaddrf->sec_stripe * paddr;
> +	}
>=20
> 	return ppa;
> }
> @@ -985,15 +1024,32 @@ static inline struct ppa_addr =
addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
> static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
> 							struct ppa_addr =
p)
> {
> -	struct nvm_addr_format_12 *ppaf =3D
> -				(struct nvm_addr_format_12 =
*)&pblk->addrf;
> +	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> 	u64 paddr;
>=20
> -	paddr =3D (u64)p.g.ch << ppaf->ch_offset;
> -	paddr |=3D (u64)p.g.lun << ppaf->lun_offset;
> -	paddr |=3D (u64)p.g.pg << ppaf->pg_offset;
> -	paddr |=3D (u64)p.g.pl << ppaf->pln_offset;
> -	paddr |=3D (u64)p.g.sec << ppaf->sec_offset;
> +	if (geo->c.version =3D=3D NVM_OCSSD_SPEC_12) {
> +		struct nvm_addr_format_12 *ppaf =3D
> +				(struct nvm_addr_format_12 =
*)&pblk->addrf;
> +
> +		paddr =3D (u64)p.g.ch << ppaf->ch_offset;
> +		paddr |=3D (u64)p.g.lun << ppaf->lun_offset;
> +		paddr |=3D (u64)p.g.pg << ppaf->pg_offset;
> +		paddr |=3D (u64)p.g.pl << ppaf->pln_offset;
> +		paddr |=3D (u64)p.g.sec << ppaf->sec_offset;
> +	} else {
> +		struct pblk_addr_format *uaddrf =3D &pblk->uaddrf;
> +		u64 secs =3D (u64)p.m.sec;
> +		int sec_stripe;
> +
> +		paddr =3D (u64)p.m.ch * uaddrf->sec_stripe;
> +		paddr +=3D (u64)p.m.lun * uaddrf->sec_lun_stripe;
> +
> +		div_u64_rem(secs, uaddrf->sec_stripe, &sec_stripe);
> +		sector_div(secs, uaddrf->sec_stripe);
> +		paddr +=3D secs * uaddrf->sec_ws_stripe;
> +		paddr +=3D sec_stripe;
> +	}
>=20
> 	return paddr;
> }
> @@ -1010,15 +1066,37 @@ static inline struct ppa_addr =
pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
> 		ppa64.c.line =3D ppa32 & ((~0U) >> 1);
> 		ppa64.c.is_cached =3D 1;
> 	} else {
> -		struct nvm_addr_format_12 *ppaf =3D
> +		struct nvm_tgt_dev *dev =3D pblk->dev;
> +		struct nvm_geo *geo =3D &dev->geo;
> +
> +		if (geo->c.version =3D=3D NVM_OCSSD_SPEC_12) {
> +			struct nvm_addr_format_12 *ppaf =3D
> 				(struct nvm_addr_format_12 =
*)&pblk->addrf;
>=20
> -		ppa64.g.ch =3D (ppa32 & ppaf->ch_mask) >> =
ppaf->ch_offset;
> -		ppa64.g.lun =3D (ppa32 & ppaf->lun_mask) >> =
ppaf->lun_offset;
> -		ppa64.g.blk =3D (ppa32 & ppaf->blk_mask) >> =
ppaf->blk_offset;
> -		ppa64.g.pg =3D (ppa32 & ppaf->pg_mask) >> =
ppaf->pg_offset;
> -		ppa64.g.pl =3D (ppa32 & ppaf->pln_mask) >> =
ppaf->pln_offset;
> -		ppa64.g.sec =3D (ppa32 & ppaf->sec_mask) >> =
ppaf->sec_offset;
> +			ppa64.g.ch =3D (ppa32 & ppaf->ch_mask) >>
> +							ppaf->ch_offset;
> +			ppa64.g.lun =3D (ppa32 & ppaf->lun_mask) >>
> +							=
ppaf->lun_offset;
> +			ppa64.g.blk =3D (ppa32 & ppaf->blk_mask) >>
> +							=
ppaf->blk_offset;
> +			ppa64.g.pg =3D (ppa32 & ppaf->pg_mask) >>
> +							ppaf->pg_offset;
> +			ppa64.g.pl =3D (ppa32 & ppaf->pln_mask) >>
> +							=
ppaf->pln_offset;
> +			ppa64.g.sec =3D (ppa32 & ppaf->sec_mask) >>
> +							=
ppaf->sec_offset;
> +		} else {
> +			struct nvm_addr_format *lbaf =3D &pblk->addrf;
> +
> +			ppa64.m.ch =3D (ppa32 & lbaf->ch_mask) >>
> +							lbaf->ch_offset;
> +			ppa64.m.lun =3D (ppa32 & lbaf->lun_mask) >>
> +							=
lbaf->lun_offset;
> +			ppa64.m.chk =3D (ppa32 & lbaf->chk_mask) >>
> +							=
lbaf->chk_offset;
> +			ppa64.m.sec =3D (ppa32 & lbaf->sec_mask) >>
> +							=
lbaf->sec_offset;
> +		}
> 	}
>=20
> 	return ppa64;
> @@ -1034,15 +1112,27 @@ static inline u32 pblk_ppa64_to_ppa32(struct =
pblk *pblk, struct ppa_addr ppa64)
> 		ppa32 |=3D ppa64.c.line;
> 		ppa32 |=3D 1U << 31;
> 	} else {
> -		struct nvm_addr_format_12 *ppaf =3D
> +		struct nvm_tgt_dev *dev =3D pblk->dev;
> +		struct nvm_geo *geo =3D &dev->geo;
> +
> +		if (geo->c.version =3D=3D NVM_OCSSD_SPEC_12) {
> +			struct nvm_addr_format_12 *ppaf =3D
> 				(struct nvm_addr_format_12 =
*)&pblk->addrf;
>=20
> -		ppa32 |=3D ppa64.g.ch << ppaf->ch_offset;
> -		ppa32 |=3D ppa64.g.lun << ppaf->lun_offset;
> -		ppa32 |=3D ppa64.g.blk << ppaf->blk_offset;
> -		ppa32 |=3D ppa64.g.pg << ppaf->pg_offset;
> -		ppa32 |=3D ppa64.g.pl << ppaf->pln_offset;
> -		ppa32 |=3D ppa64.g.sec << ppaf->sec_offset;
> +			ppa32 |=3D ppa64.g.ch << ppaf->ch_offset;
> +			ppa32 |=3D ppa64.g.lun << ppaf->lun_offset;
> +			ppa32 |=3D ppa64.g.blk << ppaf->blk_offset;
> +			ppa32 |=3D ppa64.g.pg << ppaf->pg_offset;
> +			ppa32 |=3D ppa64.g.pl << ppaf->pln_offset;
> +			ppa32 |=3D ppa64.g.sec << ppaf->sec_offset;
> +		} else {
> +			struct nvm_addr_format *lbaf =3D &pblk->addrf;
> +
> +			ppa32 |=3D ppa64.m.ch << lbaf->ch_offset;
> +			ppa32 |=3D ppa64.m.lun << lbaf->lun_offset;
> +			ppa32 |=3D ppa64.m.chk << lbaf->chk_offset;
> +			ppa32 |=3D ppa64.m.sec << lbaf->sec_offset;
> +		}
> 	}
>=20
> 	return ppa32;
> @@ -1160,6 +1250,9 @@ static inline int pblk_set_progr_mode(struct =
pblk *pblk, int type)
> 	struct nvm_geo *geo =3D &dev->geo;
> 	int flags;
>=20
> +	if (geo->c.version =3D=3D NVM_OCSSD_SPEC_20)
> +		return 0;
> +
> 	flags =3D geo->c.pln_mode >> 1;
>=20
> 	if (type =3D=3D PBLK_WRITE)
> @@ -1179,6 +1272,9 @@ static inline int pblk_set_read_mode(struct pblk =
*pblk, int type)
> 	struct nvm_geo *geo =3D &dev->geo;
> 	int flags;
>=20
> +	if (geo->c.version =3D=3D NVM_OCSSD_SPEC_20)
> +		return 0;
> +
> 	flags =3D NVM_IO_SUSPEND | NVM_IO_SCRAMBLE_ENABLE;
> 	if (type =3D=3D PBLK_READ_SEQUENTIAL)
> 		flags |=3D geo->c.pln_mode >> 1;
> @@ -1192,16 +1288,21 @@ static inline int pblk_io_aligned(struct pblk =
*pblk, int nr_secs)
> }
>=20
> #ifdef CONFIG_NVM_DEBUG
> -static inline void print_ppa(struct ppa_addr *p, char *msg, int =
error)
> +static inline void print_ppa(struct nvm_geo *geo, struct ppa_addr *p,
> +			     char *msg, int error)
> {
> 	if (p->c.is_cached) {
> 		pr_err("ppa: (%s: %x) cache line: %llu\n",
> 				msg, error, (u64)p->c.line);
> -	} else {
> +	} else if (geo->c.version =3D=3D NVM_OCSSD_SPEC_12) {
> 		pr_err("ppa: (%s: =
%x):ch:%d,lun:%d,blk:%d,pg:%d,pl:%d,sec:%d\n",
> 			msg, error,
> 			p->g.ch, p->g.lun, p->g.blk,
> 			p->g.pg, p->g.pl, p->g.sec);
> +	} else {
> +		pr_err("ppa: (%s: %x):ch:%d,lun:%d,chk:%d,sec:%d\n",
> +			msg, error,
> +			p->m.ch, p->m.lun, p->m.chk, p->m.sec);
> 	}
> }
>=20
> @@ -1211,13 +1312,13 @@ static inline void =
pblk_print_failed_rqd(struct pblk *pblk, struct nvm_rq *rqd,
> 	int bit =3D -1;
>=20
> 	if (rqd->nr_ppas =3D=3D  1) {
> -		print_ppa(&rqd->ppa_addr, "rqd", error);
> +		print_ppa(&pblk->dev->geo, &rqd->ppa_addr, "rqd", =
error);
> 		return;
> 	}
>=20
> 	while ((bit =3D find_next_bit((void *)&rqd->ppa_status, =
rqd->nr_ppas,
> 						bit + 1)) < =
rqd->nr_ppas) {
> -		print_ppa(&rqd->ppa_list[bit], "rqd", error);
> +		print_ppa(&pblk->dev->geo, &rqd->ppa_list[bit], "rqd", =
error);
> 	}
>=20
> 	pr_err("error:%d, ppa_status:%llx\n", error, rqd->ppa_status);
> @@ -1233,16 +1334,25 @@ static inline int =
pblk_boundary_ppa_checks(struct nvm_tgt_dev *tgt_dev,
> 	for (i =3D 0; i < nr_ppas; i++) {
> 		ppa =3D &ppas[i];
>=20
> -		if (!ppa->c.is_cached &&
> -				ppa->g.ch < geo->num_ch &&
> -				ppa->g.lun < geo->num_lun &&
> -				ppa->g.pl < geo->c.num_pln &&
> -				ppa->g.blk < geo->c.num_chk &&
> -				ppa->g.pg < geo->c.num_pg &&
> -				ppa->g.sec < geo->c.ws_min)
> -			continue;
> +		if (geo->c.version =3D=3D NVM_OCSSD_SPEC_12) {
> +			if (!ppa->c.is_cached &&
> +					ppa->g.ch < geo->num_ch &&
> +					ppa->g.lun < geo->num_lun &&
> +					ppa->g.pl < geo->c.num_pln &&
> +					ppa->g.blk < geo->c.num_chk &&
> +					ppa->g.pg < geo->c.num_pg &&
> +					ppa->g.sec < geo->c.ws_min)
> +				continue;
> +		} else {
> +			if (!ppa->c.is_cached &&
> +					ppa->m.ch < geo->num_ch &&
> +					ppa->m.lun < geo->num_lun &&
> +					ppa->m.chk < geo->c.num_chk &&
> +					ppa->m.sec < geo->c.clba)
> +				continue;
> +		}
>=20
> -		print_ppa(ppa, "boundary", i);
> +		print_ppa(geo, ppa, "boundary", i);
>=20
> 		return 1;
> 	}
> --
> 2.7.4
>=20
>=20
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

--Apple-Mail=_3798F2B6-A897-4E5F-A8C1-9C2946ADE409
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlqNgpoACgkQYx8FO3WZ
GMq8gRAAn4zb4ASOfXkzQK45yrcSLZwGQRWrMpx1sj1XQjqF5UsNef8sZJ8YEURa
Jrw4jkAnZ8UdjdFOd3nWCfgUojDCzvQphKCzeC6gIHTriR/0SgmpHnX99Co4HwcP
SobpZN/C8s0GIhrDU8P/FSs4TgYnAuYoP+SMKCwlwtFhfKT8f4PUjJirHgn/H/Hk
UpWRxTInkED4+Ykbrhfn/m7Jhh3FBj+0JfEvGpsM6v+S6bn1/ga6Z5t7WLh4CKEZ
WsykK3sdMVU58dLl3r4echGwrPb9Tf0V3T/JRXNCPExyxGuWRS+NMdizBKdjMp0A
bUnkumg6VPNjRPqIXRSahEeU7YU78Ix+TH+CIvdUGZXoBWrmFOz6EdDZuefZ1d3b
dp+BDmv8Rmi/jP7f7iFSqC9HD+pk11udLiwYY4Pq514XYupLOxxRj83cy4JjfvDj
JLB6wTctvxVwHdBdFH1rEGTJHmcN6acdj8ShLHdR1nkgX0AIoY67m7+lIHDlcxTE
eqNMfJARhNuoO0hCSQp2fssVFL5a7FVlnPxeg9UyHhM1GK0qHWMnRMR8Fvl5r9cm
bOOdQRz2lXkA7cOPf6zw1/gQKSUllKPotl1bgLF/1yLnQL7MLtgqC2r+lgVTIFvS
+b3f29595t8HDm28vb9tVE2XOju6hmo2QyvFv8gsgX8npgF1Qcs=
=oGzg
-----END PGP SIGNATURE-----

--Apple-Mail=_3798F2B6-A897-4E5F-A8C1-9C2946ADE409--
