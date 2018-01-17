Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42394 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbeAQIBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jan 2018 03:01:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id b141so13324842wme.1
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2018 00:01:12 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <59734A0E-32C0-4011-9C7D-F002C9B93E7B@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_40D1BBC2-20C9-4561-B0C7-01BEE18249DC";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] lightnvm/pblk-gc: Delete an error message for a failed
 memory allocation in pblk_gc_line_prepare_ws()
Date: Wed, 17 Jan 2018 09:01:07 +0100
In-Reply-To: <0ef6e852-9c76-ce74-6f21-c0398722c9e5@users.sourceforge.net>
Cc: linux-block@vger.kernel.org,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
References: <0ef6e852-9c76-ce74-6f21-c0398722c9e5@users.sourceforge.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_40D1BBC2-20C9-4561-B0C7-01BEE18249DC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 16 Jan 2018, at 22.10, SF Markus Elfring =
<elfring@users.sourceforge.net> wrote:
>=20
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 16 Jan 2018 22:00:15 +0100
>=20
> Omit an extra message for a memory allocation failure in this =
function.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> drivers/lightnvm/pblk-gc.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 9c8e114c8a54..54cdb4360366 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -147,10 +147,8 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
> 	int ret;
>=20
> 	invalid_bitmap =3D kmalloc(lm->sec_bitmap_len, GFP_KERNEL);
> -	if (!invalid_bitmap) {
> -		pr_err("pblk: could not allocate GC invalid bitmap\n");
> +	if (!invalid_bitmap)
> 		goto fail_free_ws;
> -	}
>=20
> 	emeta_buf =3D pblk_malloc(lm->emeta_len[0], =
l_mg->emeta_alloc_type,
> 								=
GFP_KERNEL);
> --
> 2.15.1

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_40D1BBC2-20C9-4561-B0C7-01BEE18249DC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlpfAsMACgkQYx8FO3WZ
GMq/Lw/+L18ZTy6nm5dBuqe3xpY/jZaIT7ZKvt8q+IgeoMzURxJ3UcwYAD1P1M3w
z5KADEl4IRjM2K1jRk2LTOHK3E+hP0Qyi/Ign+DjD5eMOb/ARHniyELMyyEwVjRG
YrNed0VtZvis5b+sbQPK/vIZd39tedwmxeCMAgKOIZnfWwEc40DWVOlxbmKfNpME
UNvqh9hRRRnQ2RLe9QImQ8IcvgI1luYJ2srhSaKFf7ar7fZo2VAq2+BQ+AayvjmD
jbqPTTgXBPI88oX/WERLRnXB7g6FTGggIp4Wmu/fLTgWF/GD7l8YYHjgtHiKDXKx
hwXVCyS9cN1BnAXLjhIZYgjFM7Rb+8PNX9yOD4b9SZ+nAtK5QqCpOwRL/sSeARAp
AS06i8E5qWVmors/mk5ne+YwpS0TO/UAE/ppsm3OpQkcXJE6gBx6gQURo27Pt3RZ
dhTTXzb/arTnKneAQml+nTyB8r0L28RGI1MPqoeIuR1pN2kGjOlP51Fm79PDLVuP
1ZHABu3q1RTyIpG0uQVUwUo/ljTKTvARdWwAdbNPcOqr4ORVF20/P5SCQYprKx+1
dCkGLzN86LVI/K1jj1JpnuBS7H3v6mWtezOwJ2Xul+daOJR3wwdYyvE4IBnXWKiF
xDjVQhfcOAZpVWw7OeS8YpBXsa2tyChUrbxqU32SymMUaPt5pHA=
=lsEb
-----END PGP SIGNATURE-----

--Apple-Mail=_40D1BBC2-20C9-4561-B0C7-01BEE18249DC--
