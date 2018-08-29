Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0040.outbound.protection.outlook.com ([104.47.41.40]:45568
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbeH3A4q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 20:56:46 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: move ppa transformations to core
Date: Wed, 29 Aug 2018 20:27:58 +0000
Message-ID: <7CC06FE6-1678-4AC5-A249-893AF36A30E9@cnexlabs.com>
References: <1535551926-4731-1-git-send-email-javier@cnexlabs.com>
 <e40fc6c5-3cc7-89bc-089f-0c9882324d32@lightnvm.io>
In-Reply-To: <e40fc6c5-3cc7-89bc-089f-0c9882324d32@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D65446E6-827E-44BC-B3B9-96814D01D66A";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_D65446E6-827E-44BC-B3B9-96814D01D66A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 29 Aug 2018, at 16.30, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 04:12 PM, Javier Gonz=C3=A1lez wrote:
>> Continuing the effort of moving 1.2 and 2.0 specific code to core, =
move
>> 64_to_32 and 32_to_64 ppa helpers from pblk to core.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk.h  | 78 =
+++------------------------------------------
>>  include/linux/lightnvm.h | 83 =
++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 87 insertions(+), 74 deletions(-)
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index f95fe75fef6e..88ff529290f8 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -1086,86 +1086,16 @@ static inline u64 =
pblk_dev_ppa_to_line_addr(struct pblk *pblk,
>>    static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk =
*pblk, u32 ppa32)
>>  {
>> -	struct ppa_addr ppa64;
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  -	ppa64.ppa =3D 0;
>> -
>> -	if (ppa32 =3D=3D -1) {
>> -		ppa64.ppa =3D ADDR_EMPTY;
>> -	} else if (ppa32 & (1U << 31)) {
>> -		ppa64.c.line =3D ppa32 & ((~0U) >> 1);
>> -		ppa64.c.is_cached =3D 1;
>> -	} else {
>> -		struct nvm_tgt_dev *dev =3D pblk->dev;
>> -		struct nvm_geo *geo =3D &dev->geo;
>> -
>> -		if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
>> -			struct nvm_addrf_12 *ppaf =3D
>> -					(struct nvm_addrf_12 =
*)&pblk->addrf;
>> -
>> -			ppa64.g.ch =3D (ppa32 & ppaf->ch_mask) >>
>> -							ppaf->ch_offset;
>> -			ppa64.g.lun =3D (ppa32 & ppaf->lun_mask) >>
>> -							=
ppaf->lun_offset;
>> -			ppa64.g.blk =3D (ppa32 & ppaf->blk_mask) >>
>> -							=
ppaf->blk_offset;
>> -			ppa64.g.pg =3D (ppa32 & ppaf->pg_mask) >>
>> -							ppaf->pg_offset;
>> -			ppa64.g.pl =3D (ppa32 & ppaf->pln_mask) >>
>> -							=
ppaf->pln_offset;
>> -			ppa64.g.sec =3D (ppa32 & ppaf->sec_mask) >>
>> -							=
ppaf->sec_offset;
>> -		} else {
>> -			struct nvm_addrf *lbaf =3D &pblk->addrf;
>> -
>> -			ppa64.m.grp =3D (ppa32 & lbaf->ch_mask) >>
>> -							lbaf->ch_offset;
>> -			ppa64.m.pu =3D (ppa32 & lbaf->lun_mask) >>
>> -							=
lbaf->lun_offset;
>> -			ppa64.m.chk =3D (ppa32 & lbaf->chk_mask) >>
>> -							=
lbaf->chk_offset;
>> -			ppa64.m.sec =3D (ppa32 & lbaf->sec_mask) >>
>> -							=
lbaf->sec_offset;
>> -		}
>> -	}
>> -
>> -	return ppa64;
>> +	return ppa32_to_ppa64(dev->parent, &pblk->addrf, ppa32);
>>  }
>>    static inline u32 pblk_ppa64_to_ppa32(struct pblk *pblk, struct =
ppa_addr ppa64)
>>  {
>> -	u32 ppa32 =3D 0;
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  -	if (ppa64.ppa =3D=3D ADDR_EMPTY) {
>> -		ppa32 =3D ~0U;
>> -	} else if (ppa64.c.is_cached) {
>> -		ppa32 |=3D ppa64.c.line;
>> -		ppa32 |=3D 1U << 31;
>> -	} else {
>> -		struct nvm_tgt_dev *dev =3D pblk->dev;
>> -		struct nvm_geo *geo =3D &dev->geo;
>> -
>> -		if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
>> -			struct nvm_addrf_12 *ppaf =3D
>> -					(struct nvm_addrf_12 =
*)&pblk->addrf;
>> -
>> -			ppa32 |=3D ppa64.g.ch << ppaf->ch_offset;
>> -			ppa32 |=3D ppa64.g.lun << ppaf->lun_offset;
>> -			ppa32 |=3D ppa64.g.blk << ppaf->blk_offset;
>> -			ppa32 |=3D ppa64.g.pg << ppaf->pg_offset;
>> -			ppa32 |=3D ppa64.g.pl << ppaf->pln_offset;
>> -			ppa32 |=3D ppa64.g.sec << ppaf->sec_offset;
>> -		} else {
>> -			struct nvm_addrf *lbaf =3D &pblk->addrf;
>> -
>> -			ppa32 |=3D ppa64.m.grp << lbaf->ch_offset;
>> -			ppa32 |=3D ppa64.m.pu << lbaf->lun_offset;
>> -			ppa32 |=3D ppa64.m.chk << lbaf->chk_offset;
>> -			ppa32 |=3D ppa64.m.sec << lbaf->sec_offset;
>> -		}
>> -	}
>> -
>> -	return ppa32;
>> +	return ppa64_to_ppa32(dev->parent, &pblk->addrf, ppa64);
>>  }
>>    static inline struct ppa_addr pblk_trans_map_get(struct pblk =
*pblk,
>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>> index 77743a02ec0d..7107a8b84039 100644
>> --- a/include/linux/lightnvm.h
>> +++ b/include/linux/lightnvm.h
>> @@ -506,6 +506,89 @@ static inline u64 dev_to_chunk_addr(struct =
nvm_dev *dev, void *addrf,
>>  	return caddr;
>>  }
>>  +static inline struct ppa_addr ppa32_to_ppa64(struct nvm_dev *dev,
>> +					     void *addrf, u32 ppa32)
>> +{
>> +	struct ppa_addr ppa64;
>> +
>> +	ppa64.ppa =3D 0;
>> +
>> +	if (ppa32 =3D=3D -1) {
>> +		ppa64.ppa =3D ADDR_EMPTY;
>> +	} else if (ppa32 & (1U << 31)) {
>> +		ppa64.c.line =3D ppa32 & ((~0U) >> 1);
>> +		ppa64.c.is_cached =3D 1;
>> +	} else {
>> +		struct nvm_geo *geo =3D &dev->geo;
>> +
>> +		if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
>> +			struct nvm_addrf_12 *ppaf =3D addrf;
>> +
>> +			ppa64.g.ch =3D (ppa32 & ppaf->ch_mask) >>
>> +							ppaf->ch_offset;
>> +			ppa64.g.lun =3D (ppa32 & ppaf->lun_mask) >>
>> +							=
ppaf->lun_offset;
>> +			ppa64.g.blk =3D (ppa32 & ppaf->blk_mask) >>
>> +							=
ppaf->blk_offset;
>> +			ppa64.g.pg =3D (ppa32 & ppaf->pg_mask) >>
>> +							ppaf->pg_offset;
>> +			ppa64.g.pl =3D (ppa32 & ppaf->pln_mask) >>
>> +							=
ppaf->pln_offset;
>> +			ppa64.g.sec =3D (ppa32 & ppaf->sec_mask) >>
>> +							=
ppaf->sec_offset;
>> +		} else {
>> +			struct nvm_addrf *lbaf =3D addrf;
>> +
>> +			ppa64.m.grp =3D (ppa32 & lbaf->ch_mask) >>
>> +							lbaf->ch_offset;
>> +			ppa64.m.pu =3D (ppa32 & lbaf->lun_mask) >>
>> +							=
lbaf->lun_offset;
>> +			ppa64.m.chk =3D (ppa32 & lbaf->chk_mask) >>
>> +							=
lbaf->chk_offset;
>> +			ppa64.m.sec =3D (ppa32 & lbaf->sec_mask) >>
>> +							=
lbaf->sec_offset;
>> +		}
>> +	}
>> +
>> +	return ppa64;
>> +}
>> +
>> +static inline u32 ppa64_to_ppa32(struct nvm_dev *dev,
>> +				 void *addrf, struct ppa_addr ppa64)
>> +{
>> +	u32 ppa32 =3D 0;
>> +
>> +	if (ppa64.ppa =3D=3D ADDR_EMPTY) {
>> +		ppa32 =3D ~0U;
>> +	} else if (ppa64.c.is_cached) {
>> +		ppa32 |=3D ppa64.c.line;
>> +		ppa32 |=3D 1U << 31;
>> +	} else {
>> +		struct nvm_geo *geo =3D &dev->geo;
>> +
>> +		if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
>> +			struct nvm_addrf_12 *ppaf =3D addrf;
>> +
>> +			ppa32 |=3D ppa64.g.ch << ppaf->ch_offset;
>> +			ppa32 |=3D ppa64.g.lun << ppaf->lun_offset;
>> +			ppa32 |=3D ppa64.g.blk << ppaf->blk_offset;
>> +			ppa32 |=3D ppa64.g.pg << ppaf->pg_offset;
>> +			ppa32 |=3D ppa64.g.pl << ppaf->pln_offset;
>> +			ppa32 |=3D ppa64.g.sec << ppaf->sec_offset;
>> +		} else {
>> +			struct nvm_addrf *lbaf =3D addrf;
>> +
>> +			ppa32 |=3D ppa64.m.grp << lbaf->ch_offset;
>> +			ppa32 |=3D ppa64.m.pu << lbaf->lun_offset;
>> +			ppa32 |=3D ppa64.m.chk << lbaf->chk_offset;
>> +			ppa32 |=3D ppa64.m.sec << lbaf->sec_offset;
>> +		}
>> +	}
>> +
>> +	return ppa32;
>> +}
>> +
>> +
>>  typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct =
bio *);
>>  typedef sector_t (nvm_tgt_capacity_fn)(void *);
>>  typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk =
*,
>=20
> Thanks. Applied for 4.20. I've updated the global =
ppa[32/64]_to_ppa[64/32] to prepend nvm_.

Cool, thanks. Should we do the same for the rest of the helpers =
dev_to_*?

--Apple-Mail=_D65446E6-827E-44BC-B3B9-96814D01D66A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluHAcsACgkQIX4xUKFR
nnQbqxAAh1oQmOwBc0J+yrF7OIyrc5UuvHsfeDoVNu2dUE+VoFD8Rq/7ZuCWB6i1
3nbwQ87TW796rVJdeh6XpK8vgqLt+dK+QdZ/veR/rmqo4ld/1QjDlKzCXnCbIkZr
0Zo5JqalOzb1q4RelDvUUX4ydlWwsGytPkRML/nKHbhIRmLF+ieHqcppa6bTguUK
zHQ6XqabgtoUywDDbFAzAH5krzOyeJNFSr58w9RbWHxybX6Kd0b8wWae9t6wbQeu
Q+kNm3kNaQC/ReKerbdvcUcfV7ESU3OQWppKwqR4ceCYP4IeXnsqQkkfegpm7Vgp
vSAQ7NdaVA6A8OkgYTqCqDHu8JiOjTJBPJNlusCXY4urLkdaR6FNWlrglIKydq/H
WgrcLtBHkmQYu/7EELXjWZn005eyQeMzfyqEpkumsnOO0/jCVrJQEeajjf2LTjEG
X1F2C9sHzbKgHEgrV0gpuUUq6zyUxxNrTYH8kDhYNbvl2wTWf4TjGpPYsXVSFrNp
VQxS9/RB76GYvLT1LhgE8bQSukp+wxe5SvktV7oEtQTfErO9mh7fY0LcxRKa8mKf
Q7V6cik6VaDqvqwVjX2cAFxNzM1O1Y2V9xy10FFzj2R/Xx0d5JVPVd+Pq9rt/+SK
qpMKRd/SIxFk36I/vpkMk2J3F5M+FVT7fwJKyHX4QM3u6yKOmhA=
=bMcL
-----END PGP SIGNATURE-----

--Apple-Mail=_D65446E6-827E-44BC-B3B9-96814D01D66A--
