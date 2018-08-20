Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0086.outbound.protection.outlook.com ([104.47.42.86]:23293
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726705AbeHTQsv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 12:48:51 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: remove size and out of bounds read check
Date: Mon, 20 Aug 2018 13:31:27 +0000
Message-ID: <7A5BC594-414A-4851-9F16-A47A98CA0201@cnexlabs.com>
References: <20180820125953.15364-1-mb@lightnvm.io>
In-Reply-To: <20180820125953.15364-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_66145121-FE60-49A2-BF8E-5FD9CABC3192";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_66145121-FE60-49A2-BF8E-5FD9CABC3192
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 20 Aug 2018, at 14.59, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The I/O size and capacity check are already done by the block layer.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-read.c | 7 -------
> 1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index f275c7e5abe4..d0fbd50ecc90 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -452,13 +452,6 @@ int pblk_submit_read(struct pblk *pblk, struct =
bio *bio)
> 	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
> 	int ret =3D NVM_IO_ERR;
>=20
> -	/* logic error: lba out-of-bounds. Ignore read request */
> -	if (blba >=3D pblk->rl.nr_secs || nr_secs > NVM_MAX_VLBA) {
> -		WARN(1, "pblk: read lba out of bounds (lba:%llu, =
nr:%d)\n",
> -					(unsigned long long)blba, =
nr_secs);
> -		return NVM_IO_ERR;
> -	}
> -
> 	generic_start_io_acct(q, READ, bio_sectors(bio), =
&pblk->disk->part0);
>=20
> 	bitmap_zero(read_bitmap, nr_secs);
> --
> 2.11.0


Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_66145121-FE60-49A2-BF8E-5FD9CABC3192
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt6wqwACgkQIX4xUKFR
nnS/iw//QyPjLp7FtuILvIvh9ok+FLTOI3sR5cANLvQhxxjyfaNOdHm/ZW2pGCCD
yEL7cFM2rOl0zfZn7cL/k/p1XWvC8ELYZoKdFOFwGmPZFdWKnROkI+I6cVDvUeJw
4VcG1HA3PdfgXoXSN7vEoKeeGEZUlb4Mn0visHa6sgE5kv695+z7Ne89EeMlUYNb
eqUzc2HF2feVdaoSRqteEgaeAYH54uVIUSCUiUXGVB2L/cEV/BIw+Uwp+eBXmDn7
touB3TscIs3aY6LwE5o3ArQCh3MKBi/NisDfz+r35r9seNoVMvBJn0tPTutkpRdh
0X7JTtGD6t6SXVtvVEni/E3QMW9UPrrMKUlLgFtyZkq9Vua9sM2DP25zEJ5PEshV
yrqzVDbPGyUPAns/Q/9C6Kmlb9kzo1QFddVjH8ZJAnMP4a/oo2mR//6wiSeFIPOO
SZO2b/XVo6WrWCze1N/56s3vvERvYzaGFk4s//uDCGTuAn5jwrle4IVJuqurPQZX
0lHJD4jmPrn32usnHcb0U/TfaDE+oi0sZmu2IwMQCu+TQblCtiK3l3U2b3Sy/P8g
EbylLEB/KnHjujAUf72MVAYNQRXzWE7iB4MD18bm8qq4Gu5f4i1qe6MtjaxmcYqJ
gtFzn6zRyE9D94llrRb9zEpH6Q7PKfrktqOKJwjlNoWcnZM6c+s=
=5YAX
-----END PGP SIGNATURE-----

--Apple-Mail=_66145121-FE60-49A2-BF8E-5FD9CABC3192--
