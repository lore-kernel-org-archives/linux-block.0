Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0067.outbound.protection.outlook.com ([104.47.41.67]:40602
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750852AbeBXJLy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Feb 2018 04:11:54 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Heiner Litz <hlitz@ucsc.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "matias@lightnvm.io" <matias@lightnvm.io>
Subject: Re: [PATCH] lightnvm: fix bad block initialization
Date: Sat, 24 Feb 2018 09:11:51 +0000
Message-ID: <90B573AB-6969-4159-9DCF-62EC47022AD1@cnexlabs.com>
References: <20180223174016.6104-1-hlitz@ucsc.edu>
 <02770a13-9699-aa8d-bcf2-c7aaefe28623@lightnvm.io>
In-Reply-To: <02770a13-9699-aa8d-bcf2-c7aaefe28623@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_3BAB4D37-AC7D-4D7B-B9C2-D9B6BF07A90E";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_3BAB4D37-AC7D-4D7B-B9C2-D9B6BF07A90E
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




--Apple-Mail=_3BAB4D37-AC7D-4D7B-B9C2-D9B6BF07A90E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqRLFQACgkQIX4xUKFR
nnTLtA/8CD6vKRRLua5VWq+ZvSPfwRsnOmqdddaQLJ31ZKLEgJF5kSZAy9tjMq5I
qLVMtL02wtB2hyTlWjjwzg9Rm0cZ9/Z9x4uEjO/Ll5DNQmggVrrksLgKDEif22AS
hrimHY9OtuALz65ZL0GUTEVnMawlOtSuc1F7xbNGkrYAv6TjKN6V39PVLqCcfbZ8
6CVS4ID77HAT5viWD0wNOFUKLDY639XsjL8k+QOiBTcGbYJN0e2wzRplVTfG68t+
iP7Low2WKoSRiQum5Q73nDKFbP+gjIaA9MokLQBZ19KTw5LDHes0/Vszn/yapdNN
eyEkbE3t2ITvus6gn+0kPtSBMlt21KUmZdFDfLRCWljToCbgIaCRQmAIhfmdaoOW
H+gqgc2A8ZF+22CltGuAImqcMRXCQg8IlwrN9fa1sIAnN5J7A4aMic+JxiAkoP3j
stGFRxxVpV4/ZHbuAXiS53tZ4r0yDrmVvGhKMsvuTTy06Is5d3BcsQ0qYPmHX0TN
MKdk1HBfmxxU+sTvzpsNs5rkgwE8HM4JrLIiyYjAtjliarTsAhzf3cmpXHkYPiKJ
+fC9sypje5Zwya3/SB0mGn7cUctHRZTZNepgWZbSGBi1LiOcwXQnzJV27PGaKI7B
RBHSbm6wOKopuoFP0k3OPj8MsMj4L6ZTlhjZAWp1YewYEJ/3caU=
=CY9g
-----END PGP SIGNATURE-----

--Apple-Mail=_3BAB4D37-AC7D-4D7B-B9C2-D9B6BF07A90E--
