Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0078.outbound.protection.outlook.com ([104.47.41.78]:17054
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750852AbeBXJPP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Feb 2018 04:15:15 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Heiner Litz <hlitz@ucsc.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: fix bad block initialization
Date: Sat, 24 Feb 2018 09:15:13 +0000
Message-ID: <667A51B2-2026-471D-BFDB-3847B121817C@cnexlabs.com>
References: <20180223174016.6104-1-hlitz@ucsc.edu>
 <02770a13-9699-aa8d-bcf2-c7aaefe28623@lightnvm.io>
In-Reply-To: <02770a13-9699-aa8d-bcf2-c7aaefe28623@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_960CF976-AD03-4B38-A30B-11D4678CC573";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_960CF976-AD03-4B38-A30B-11D4678CC573
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 23 Feb 2018, at 19.45, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/23/2018 06:40 PM, Heiner Litz wrote:
>> fix reading bad block device information to correctly setup the per =
line
>> blk_bitmap during lightnvm initialization
>>=20
>> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
>> ---
>>  drivers/lightnvm/pblk-init.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>> index 86a94a7faa96..e0eba150ac7e 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -461,10 +461,11 @@ static int pblk_bb_line(struct pblk *pblk, =
struct pblk_line *line,
>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  	struct nvm_geo *geo =3D &dev->geo;
>>  	int i, bb_cnt =3D 0;
>> +	int blk_per_lun =3D geo->nr_chks * geo->plane_mode;
>>=20
>>  	for (i =3D 0; i < blk_per_line; i++) {
>>  		struct pblk_lun *rlun =3D &pblk->luns[i];
>> -		u8 *lun_bb_log =3D bb_log + i * blk_per_line;
>> +		u8 *lun_bb_log =3D bb_log + i * blk_per_lun;
>>=20
>>  		if (lun_bb_log[line->id] =3D=3D NVM_BLK_T_FREE)
>>  			continue;
>=20
> Thanks Heiner. Applied.

The patch looks good, but it is missing:

   Fixes: 36b3b712e81dc ("lightnvm: pblk: refactor bad block =
identification")

Matias, please add this when picking up.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


PS:
Heiner: Matias' lightnvm.io address is mb@lightnvm.io

--Apple-Mail=_960CF976-AD03-4B38-A30B-11D4678CC573
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqRLR8ACgkQIX4xUKFR
nnS4DRAAi4Rvr3TQcKWHEW3og8zB+t+b87+FM7/yUsus5ECI2clFbIGVjSSDJ3UK
SMmwBNCtUQAViRpXnqPcGt2AZO+sPuTUzWIGLtW3y1wMznvzAfnwmyDgZ+OrxQuk
HfZ/QOmNLkFx/3WDajVC2wMEhPj8TuumVsaqfBgeQv7U0vPT9miuLSFTYXXJUZfY
JXVI2B17m0PcC2K2xjx9Bi0XatJmkuhUgLCQAjgi/kqXnWCgMkqx8+XTnRkTD0Ct
bAjpkLgnYRRKYznBLzDSjwri/b1BSsPvY8pCVu3LF1WxjdgBiu+sETvtJPKwubGG
MSL9/C27M6WUikcRafochar/NDrKTQvkZzNj8zkzF9GwX6/iU1xfp9YAHbHmlWZ0
DddbPlHUijyHPkKz0adiHM5LrnkPHKfa05ErFV9pH1/TIuP9kl/++NFaGxhuMsl4
oUAj4QZdmd+4I8DgwguixpdwM9YJY9US5GMZkWlj55ZtHTk8yheMEUCZSr9NEk5z
/ZtO1KFwHq/UZKR5CqA1P+LdMO/5lQMYTDS6JdjfD/OSE5AE7og1XByCEi3ZvwrS
9XfwEKsSNRGSRQcXjLj+Nlra/9BjBHwJzhvwMtiA6fbAQ/Nt41HdRcXwqw7PLHt5
E5SsO0s+cJFJdQ7fjn7LcTjQHj3IxXfio/XswUeas4nyAB0Znv0=
=8DdO
-----END PGP SIGNATURE-----

--Apple-Mail=_960CF976-AD03-4B38-A30B-11D4678CC573--
