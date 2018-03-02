Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56234 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936297AbeCBMAE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Mar 2018 07:00:04 -0500
Received: by mail-wm0-f68.google.com with SMTP id q83so2677228wme.5
        for <linux-block@vger.kernel.org>; Fri, 02 Mar 2018 04:00:03 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <7965F260-45CD-47F4-8063-33F392295950@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C0B23A2F-F0E4-4840-B979-AE5C2F8FFA17";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 02/15] lightnvm: add controller capabilities to 2.0
Date: Fri, 2 Mar 2018 12:59:59 +0100
In-Reply-To: <e435dd71-a83d-1888-0e1b-cd1b62181e4c@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
 <1519832975-25432-3-git-send-email-javier@cnexlabs.com>
 <e435dd71-a83d-1888-0e1b-cd1b62181e4c@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_C0B23A2F-F0E4-4840-B979-AE5C2F8FFA17
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 1 Mar 2018, at 11.33, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/28/2018 04:49 PM, Javier Gonz=C3=A1lez wrote:
>> Assign missing mccap value on 2.0 path
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/nvme/host/lightnvm.c | 4 +++-
>>  include/linux/lightnvm.h     | 8 +++++---
>>  2 files changed, 8 insertions(+), 4 deletions(-)
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index e276ace28c64..5b2024ebac76 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -318,7 +318,7 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 =
*id,
>>  	geo->ws_opt =3D sec_per_pg;
>>  	geo->mw_cunits =3D geo->ws_opt << 3;	/* default to MLC safe =
values */
>>  -	geo->mccap =3D le32_to_cpu(src->mccap);
>> +	geo->cap =3D le32_to_cpu(src->mccap);
>>    	geo->trdt =3D le32_to_cpu(src->trdt);
>>  	geo->trdm =3D le32_to_cpu(src->trdm);
>> @@ -396,6 +396,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 =
*id,
>>  	geo->ws_opt =3D le32_to_cpu(id->ws_opt);
>>  	geo->mw_cunits =3D le32_to_cpu(id->mw_cunits);
>>  +	geo->cap =3D le32_to_cpu(id->mccap);
>> +
>>  	geo->trdt =3D le32_to_cpu(id->trdt);
>>  	geo->trdm =3D le32_to_cpu(id->trdm);
>>  	geo->tprt =3D le32_to_cpu(id->twrt);
>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>> index 16255fcd5250..b9f0d2070de9 100644
>> --- a/include/linux/lightnvm.h
>> +++ b/include/linux/lightnvm.h
>> @@ -288,8 +288,10 @@ struct nvm_geo {
>>  	u32	ws_opt;		/* optimal write size */
>>  	u32	mw_cunits;	/* distance required for successful read =
*/
>>  -	/* device capabilities */
>> -	u32	mccap;
>> +	/* device capabilities. Note that this represents capabilities =
in 1.2
>> +	 * and media and controller capabilities in 2.0
>> +	 */
>> +	u32	cap;
>=20
> Here is a list of capabilities:
>=20
> 1.2
> Bad block mgmt
> Hybrid command support
>=20
> 2.0
>=20
> Vector copy
> Double reset
>=20
> The way I was thinking it would be implemented is to split the upper =
cap bits to 2.0, and let the lower bits be reserved for 1.2.
>=20
> Such that one would define the following:
>=20
> enum {
> 	NVM_CAP_BBM 	1 << 0;
> 	NVM_CAP_HCS 	1 << 1;
>=20
> 	NVM_CAP_VCPY 	1 << 16;
> 	NVM_CAP_DRST	1 << 17;
> };
>=20
> That way, the assignment from 2.0 can easily be done with cap =3D =
le32_to_cpu(id->mccap) << 16;
>=20
> and targets and other don't need to understand the difference between =
1.2 and 2.0 format.

I can see that you already have a way to do it in mind. I'll remove this
patch and you can implement it later on.

Javier

--Apple-Mail=_C0B23A2F-F0E4-4840-B979-AE5C2F8FFA17
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlqZPL8ACgkQYx8FO3WZ
GMoSQw/5AYXtlBMYpgem4lSVvJqWIn3oRfLMnCK82eonCw52bmvuktvRLsxO1A4t
0sA/ku1k7isnnI4NbyF47Hl1+f4sdZZ6i8+okvytQjJcFz63Jg3Mn62g/gne42yO
RSCXwpta1G0VEJoJog4YCdW+bFrFfd6pr4ZrqSokwY/NMNc9vARKKR8ysferXXPq
fCym8rWZWuTxMjMmR1PwfGfcIIAOMgzqBcWOtvYqK8uhawiIae7XADQh5yj4fRiq
0AqpOAhMStpeXfFEtfjEjI+A/ds78qM1bBx27p11e0pnkZxaSfdc7A/mMADOzf8Q
w9HFLPJ6h8qqBHjAF/y0wF8oEgImw5XtDKPBczv1rEnmmxBxauebiUB5xQHU33MF
c2ifNvu2HdV/4SQbC9d9nOANV5uP/cYtgpxpv21GCpMvHC5Vdb9GbqHumiJSRpOZ
ogJSL6RcA6Gft+e7LSqACsA6/WSKC3ay7Qo9Y3Ud31YUq25AL9MMf23NOA1sGCdz
eShM4FlY+WUQFOfFulUBj9OoLK+RSqDNA5PIN0IqacUbKdqzzg1/SyGM9ri/zViQ
s3vDH+9b+7wuBac3zwIDKQkxApgWd+eOmH7eEWeJJRH42ZRbiliOy5/sm/bkszNl
i/e/YPKu+SBMe1qB/Ow2rtJmWUUPtYzY4xlKdm9Wsj+hrvO5CQA=
=bWAG
-----END PGP SIGNATURE-----

--Apple-Mail=_C0B23A2F-F0E4-4840-B979-AE5C2F8FFA17--
