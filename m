Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:42938 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeDRLxR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Apr 2018 07:53:17 -0400
Received: by mail-io0-f194.google.com with SMTP id l2-v6so577257iog.9
        for <linux-block@vger.kernel.org>; Wed, 18 Apr 2018 04:53:16 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <5C311756-8AF8-47B1-98A0-C76F650F3BC2@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0B178F72-CFFD-4312-B725-3168A27EFD5A";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 03/11] lightnvm: pblk: check read lba on gc path
Date: Wed, 18 Apr 2018 04:53:06 -0700
In-Reply-To: <f41f6858-77d1-5856-0719-a765251f5679@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
 <1523874332-6272-4-git-send-email-javier@cnexlabs.com>
 <f41f6858-77d1-5856-0719-a765251f5679@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_0B178F72-CFFD-4312-B725-3168A27EFD5A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Apr 2018, at 05.03, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 4/16/18 12:25 PM, Javier Gonz=C3=A1lez wrote:
>> Check that the lba stored in the LBA metadata is correct in the GC =
path
>> too. This requires a new helper function to check random reads in the
>> vector read.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-read.c | 39 =
+++++++++++++++++++++++++++++++++------
>>  1 file changed, 33 insertions(+), 6 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
>> index 9eee10f69df0..0d45d4ffc370 100644
>> --- a/drivers/lightnvm/pblk-read.c
>> +++ b/drivers/lightnvm/pblk-read.c
>> @@ -113,15 +113,14 @@ static int pblk_submit_read_io(struct pblk =
*pblk, struct nvm_rq *rqd)
>>  	return NVM_IO_OK;
>>  }
>>  -static void pblk_read_check(struct pblk *pblk, struct nvm_rq *rqd,
>> -			   sector_t blba)
>> +static void pblk_read_check_seq(struct pblk *pblk, void *meta_list,
>> +				sector_t blba, int nr_lbas)
>>  {
>> -	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
>> -	int nr_lbas =3D rqd->nr_ppas;
>> +	struct pblk_sec_meta *meta_lba_list =3D meta_list;
>>  	int i;
>>    	for (i =3D 0; i < nr_lbas; i++) {
>> -		u64 lba =3D le64_to_cpu(meta_list[i].lba);
>> +		u64 lba =3D le64_to_cpu(meta_lba_list[i].lba);
>>    		if (lba =3D=3D ADDR_EMPTY)
>>  			continue;
>> @@ -130,6 +129,32 @@ static void pblk_read_check(struct pblk *pblk, =
struct nvm_rq *rqd,
>>  	}
>>  }
>>  +/*
>> + * There can be wholes in the lba list.
>> + */
>=20
> holes

Can you change it?

>=20
>> +static void pblk_read_check_rand(struct pblk *pblk, void *meta_list,
>> +				u64 *lba_list, int nr_lbas)
>> +{
>> +	struct pblk_sec_meta *meta_lba_list =3D meta_list;
>> +	int i, j;
>> +
>> +	for (i =3D 0, j =3D 0; i < nr_lbas; i++) {
>> +		u64 lba =3D lba_list[i];
>> +		u64 meta_lba;
>> +
>> +		if (lba =3D=3D ADDR_EMPTY)
>> +			continue;
>> +
>> +		meta_lba =3D le64_to_cpu(meta_lba_list[j++].lba);
>=20
> You can move the j++ into the for loop. Although, why not use just the =
i iterator?

Look above, we only increase on valid lbas.

>=20
>> +
>> +		if (lba !=3D meta_lba) {
>> +			pr_err("pblk: corrupted read LBA (%llu/%llu)\n",
>> +								lba, =
meta_lba);
>> +			WARN_ON(1);
>=20
> I don't understand this, if a corrupted LBA is found here, how is it
> communicated back to pblk and the LBA can be recovered from elsewhere.
> If the data is wrong, this should have been communicated by the drive
> on the completion path. The drive is defect if this happens.
>=20

This happens if a read does not match the lba stored on the LBA. This is
definitely an error and it has helped us in the past to find race
conditions on pblk's read path, specially when forming partial I/Os.

If the read failed from the drive (e.g., when enabling HECC), we still
want information about where it failed for debugging purposes. Same we
do on the normal read path.

Javier

--Apple-Mail=_0B178F72-CFFD-4312-B725-3168A27EFD5A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlrXMaIACgkQPEYBfS0l
eODjeA/9Fox9qyYRikEBg8oV/nJLu5I2UkcIH44IHOQfICfnlcmfXhZZbVsG9WZZ
w9URG2rv6V4roBVqAHKmkYFmflgqWqtzMbytbvn7J2KYBjNy7BtmYOfyCWfLTyxU
EGNV7bQODzgJYrjzRuqCOHuMe5ZsAXjd7ofWKSo+njaP0Kt7xEHESSNNolDhtXoD
MtupRECA86WgkAmMjvWb+AR7PmsFAQ3o++Ig27xJlsU2qrh7rf1sGaLDe7CVs6N/
IGV2uQuiFj5Kj0VElHDQ8lQ0W/wUfx+ZwBArkmHBvKPyjWrcdhW9Tfxjwv4Cd4ph
eo0E9RQAbdiFmsO+XZpDnPuBKOCWYsfXGxEiNVpsze18dXYbntRGjqEinpDlGRt4
mVFx1pE9iWr33e8AJDBPPRS8Bx8Ub8H4K93TEkFPMOOUbdy682pchBHOHJ/Ifm5l
mzW5Q5hzeFkijsoWKnjypDJK2KhhkuT3pMs3JJiUadD4S7jnDLk8HVOnocC8XsF2
dZNgjE6wTSAmRFIqTYw58kl76is+tO6ESaV3ADfVFP+Cq3HWdVBVXnPtOy3pq+vF
Og9kqK+VJdRgyBcmluonnuD6jn2E8DEq/yZyiWJImDdTqIl38XuhcLiUBNh/oSoH
NqTY1+1TaL26nEUjHIN6MtgdpiaVgeDQuiynJwwVTxS4RFE9BsM=
=iksq
-----END PGP SIGNATURE-----

--Apple-Mail=_0B178F72-CFFD-4312-B725-3168A27EFD5A--
