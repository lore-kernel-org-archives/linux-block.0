Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:45978 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdIUJ4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 05:56:51 -0400
Received: by mail-wm0-f43.google.com with SMTP id q124so255813wmb.0
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2017 02:56:50 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <032D1EF1-4F4A-45E1-BE6C-B8C9C9E0F6F7@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E8C676CD-B4D6-4435-A2EE-8C30155CA379";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: pblk: fix error path in
 pblk_lines_alloc_metadata
Date: Thu, 21 Sep 2017 11:56:46 +0200
In-Reply-To: <20170920195019.GA25759@dhcp-216.srv.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170920195019.GA25759@dhcp-216.srv.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_E8C676CD-B4D6-4435-A2EE-8C30155CA379
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 20 Sep 2017, at 21.50, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> Use appropriate memory free calls based on allocation type used and
> also fix number of times free is called if kmalloc fails.
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/pblk-init.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 7cf4b53..470ef04 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -624,12 +624,16 @@ static int pblk_lines_alloc_metadata(struct pblk =
*pblk)
>=20
> fail_free_emeta:
> 	while (--i >=3D 0) {
> -		vfree(l_mg->eline_meta[i]->buf);
> +		if (l_mg->emeta_alloc_type =3D=3D PBLK_VMALLOC_META)
> +			vfree(l_mg->eline_meta[i]->buf);
> +		else
> +			kfree(l_mg->eline_meta[i]->buf);
> 		kfree(l_mg->eline_meta[i]);
> 	}
>=20
> +	i =3D PBLK_DATA_LINES;
> fail_free_smeta:
> -	for (i =3D 0; i < PBLK_DATA_LINES; i++)
> +	while (--i >=3D 0)
> 		kfree(l_mg->sline_meta[i]);

It is safe to use kfree on NULL pointers. No need to do this. You can
either send a new patch, or we can change it when picking it up.

>=20
> 	return -ENOMEM;
> --
> 2.5.0

Rest looks good.


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_E8C676CD-B4D6-4435-A2EE-8C30155CA379
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZw4zfAAoJEGMfBTt1mRjKg2QQAKt5GhWr8rn3PbnlqawieeHd
Dfr+mENb9KIUBDXjxLgVZ+DS3clXQKSJfIq1y3jEaBCMELfn7sjmmoRwzSzKy7hf
JrQi1nxDsmZaWPhMB/0in8nCz9B8lqF6oLP+CPfwz40z8610HoQ50jkClnu/Pgv2
IZnqMVX0KmFvuJluROA6T+ZXeZZ/TQOj1mE1/jn3JBwbqqb49HSUHeoz/lvEKmhO
ogsH7iMhQvELqFPQZMn7xsiPPS6hEUy3KooFsZPg5uGgI5MA7Ux2sRRU887YWwHm
pqrzFU1rixlc98z9h4hsMMq49sHQg2TmgWJi9tGloCx5tGwGj1nqREFrm9RAd0SX
rZsyNRhqpC0WezPKLOzUu8HvdCAffQgOZcgUs5DsyGXVxWrRNqTxlglrfmXdg09w
jbSI+yDL41mW1i1HcW0gRfqcHSPOle1L06lTmfjTVTXrPl6Nxiv3T+j7Ad4WIsbr
GvnHgt8e0S9YApnswrySGUDW5FJn1b4esJjOd5xjsgekQDSZIo93inSiFs1oW3JW
TRZ6vSXyDGaNfyYDd4MC7I0psO7yyUaHFsJbu6glaSwO8BGrbYMZWD+Eo8JteBax
/G9UP4XRrc8f/KpliPYmynNKH6VMgxaCkKVxinVyibS8RplF6xpWqxH2v8FyXi0k
1g41ArcxgBdAzUn/+RJA
=uAH6
-----END PGP SIGNATURE-----

--Apple-Mail=_E8C676CD-B4D6-4435-A2EE-8C30155CA379--
