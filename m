Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52349 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967212AbeCALFb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Mar 2018 06:05:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id t3so10768332wmc.2
        for <linux-block@vger.kernel.org>; Thu, 01 Mar 2018 03:05:30 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <670BB02F-9ADC-4685-9A6E-6CA5D2C0F5FB@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_2D1136D4-E182-4CC7-AD17-8C8D2014B25A";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 12/15] lightnvn: pblk: use generic address format
Date: Thu, 1 Mar 2018 12:05:24 +0100
In-Reply-To: <f1468f08-9412-0243-440a-b79615814b1e@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
 <1519832975-25432-13-git-send-email-javier@cnexlabs.com>
 <f1468f08-9412-0243-440a-b79615814b1e@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_2D1136D4-E182-4CC7-AD17-8C8D2014B25A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 1 Mar 2018, at 11.41, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/28/2018 04:49 PM, Javier Gonz=C3=A1lez wrote:
>> Use the generic address format on common address manipulations.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-core.c  | 10 +++++-----
>>  drivers/lightnvm/pblk-map.c   |  4 ++--
>>  drivers/lightnvm/pblk-sysfs.c |  4 ++--
>>  drivers/lightnvm/pblk.h       |  4 ++--
>>  4 files changed, 11 insertions(+), 11 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 7d0bd33f11d9..2e10b18b61e3 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -885,7 +885,7 @@ int pblk_line_erase(struct pblk *pblk, struct =
pblk_line *line)
>>  		}
>>    		ppa =3D pblk->luns[bit].bppa; /* set ch and lun */
>> -		ppa.g.blk =3D line->id;
>> +		ppa.a.blk =3D line->id;
>>    		atomic_dec(&line->left_eblks);
>>  		WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
>> @@ -1686,8 +1686,8 @@ static void __pblk_down_page(struct pblk *pblk, =
struct ppa_addr *ppa_list,
>>  	int i;
>>    	for (i =3D 1; i < nr_ppas; i++)
>> -		WARN_ON(ppa_list[0].g.lun !=3D ppa_list[i].g.lun ||
>> -				ppa_list[0].g.ch !=3D ppa_list[i].g.ch);
>> +		WARN_ON(ppa_list[0].a.lun !=3D ppa_list[i].a.lun ||
>> +				ppa_list[0].a.ch !=3D ppa_list[i].a.ch);
>>  #endif
>>    	ret =3D down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
>> @@ -1731,8 +1731,8 @@ void pblk_up_page(struct pblk *pblk, struct =
ppa_addr *ppa_list, int nr_ppas)
>>  	int i;
>>    	for (i =3D 1; i < nr_ppas; i++)
>> -		WARN_ON(ppa_list[0].g.lun !=3D ppa_list[i].g.lun ||
>> -				ppa_list[0].g.ch !=3D ppa_list[i].g.ch);
>> +		WARN_ON(ppa_list[0].a.lun !=3D ppa_list[i].a.lun ||
>> +				ppa_list[0].a.ch !=3D ppa_list[i].a.ch);
>>  #endif
>>    	rlun =3D &pblk->luns[pos];
>> diff --git a/drivers/lightnvm/pblk-map.c =
b/drivers/lightnvm/pblk-map.c
>> index 04e08d76ea5f..20dbaa89c9df 100644
>> --- a/drivers/lightnvm/pblk-map.c
>> +++ b/drivers/lightnvm/pblk-map.c
>> @@ -127,7 +127,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
>>  			atomic_dec(&e_line->left_eblks);
>>    			*erase_ppa =3D rqd->ppa_list[i];
>> -			erase_ppa->g.blk =3D e_line->id;
>> +			erase_ppa->a.blk =3D e_line->id;
>>    			spin_unlock(&e_line->lock);
>>  @@ -168,6 +168,6 @@ void pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
>>  		set_bit(bit, e_line->erase_bitmap);
>>  		atomic_dec(&e_line->left_eblks);
>>  		*erase_ppa =3D pblk->luns[bit].bppa; /* set ch and lun =
*/
>> -		erase_ppa->g.blk =3D e_line->id;
>> +		erase_ppa->a.blk =3D e_line->id;
>>  	}
>>  }
>> diff --git a/drivers/lightnvm/pblk-sysfs.c =
b/drivers/lightnvm/pblk-sysfs.c
>> index cbb5b6edb7bf..a643dc623731 100644
>> --- a/drivers/lightnvm/pblk-sysfs.c
>> +++ b/drivers/lightnvm/pblk-sysfs.c
>> @@ -39,8 +39,8 @@ static ssize_t pblk_sysfs_luns_show(struct pblk =
*pblk, char *page)
>>  		sz +=3D snprintf(page + sz, PAGE_SIZE - sz,
>>  				"pblk: pos:%d, ch:%d, lun:%d - %d\n",
>>  					i,
>> -					rlun->bppa.g.ch,
>> -					rlun->bppa.g.lun,
>> +					rlun->bppa.a.ch,
>> +					rlun->bppa.a.lun,
>>  					active);
>>  	}
>>  diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index dd0089fe62b9..6ac64d9eb57e 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -936,12 +936,12 @@ static inline int pblk_pad_distance(struct pblk =
*pblk)
>>    static inline int pblk_ppa_to_line(struct ppa_addr p)
>>  {
>> -	return p.g.blk;
>> +	return p.a.blk;
>>  }
>>    static inline int pblk_ppa_to_pos(struct nvm_geo *geo, struct =
ppa_addr p)
>>  {
>> -	return p.g.lun * geo->num_ch + p.g.ch;
>> +	return p.a.lun * geo->num_ch + p.a.ch;
>>  }
>>    static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, =
u64 paddr,
>=20
> Would it make sense to merge this with 7/15?

Sure. I've tried to decouple pblk and lightnvm core patches, but they
can go together. I'll merge in V5.

Javier

--Apple-Mail=_2D1136D4-E182-4CC7-AD17-8C8D2014B25A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlqX3nQACgkQYx8FO3WZ
GMqw9A/+NDDZd0d/+5tfhwlrk9HHDVNekXKS2Zoavc/tdvyxdpkpEEdeLzsjQHl0
dCHiFN4Qj/kfw9I+595Zh7s0GZRstXvbRZ0HGCayJasHvuZmtINadLoj8X3maGCH
1mqZQgijsOyO+fqYInxcUV5M0fp5QkFWBAe4wuWm99ofrP7ROX3t/2uFh1wA5WbP
6h/XjyI5qYO8VrVLuw2rVS2rNIvhHq/gJjZmyC8lnbLjGpLA+EVy7gihjtK4dpS3
vVbOw8r9SRhfEsCsM5DMU5cQn31CHY7Vea2qnKw/ZuNbAI5cCHbiHGwLxPmsxra7
AGUwrYmh2YkPiNgdk1sXQZre+WR9OWZFUxMnSdqSEqwUyrt2+mkiXLfHkUsncZ57
ztq9WlVjjWIZ7uVYwkqR8VFMG6dIaAoy1PxmOJTm+iCKt9JDMO1yBYNV0wryzBTf
3DGY52K+ihOLywDYoR6YblRsVEaj/FOhXiQrtMPY8RWXzY03KQtaShGf4OyE6wk+
LAoa+DlCCGDqs0wxZepaaG4RKGu4VfqArl1bigHjdLqJ/vd0rKOmpn4PtJrQqnGi
/HEaewOeOX2VePd00LpIoSia5zyQrhGozKOnYhgagBUBKS8pOrvqxwHu6/9NH4LO
yrdwEfa2fecY9wfi5ccuWZkXZCVp2sFah1Ucg1j0RAB5DnU/Y/4=
=7erB
-----END PGP SIGNATURE-----

--Apple-Mail=_2D1136D4-E182-4CC7-AD17-8C8D2014B25A--
