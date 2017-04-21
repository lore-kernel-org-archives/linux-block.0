Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34898 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426066AbdDUWY4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 18:24:56 -0400
Received: by mail-io0-f179.google.com with SMTP id r16so130149676ioi.2
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2017 15:24:56 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <E2348B07-559F-4874-A3A4-C1079A2A09D2@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1BECD083-A84F-4EF8-BE8B-C4156932B0BD";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] lightnvm: potential underflow in pblk_read_rq()
Date: Sat, 22 Apr 2017 00:24:50 +0200
In-Reply-To: <20170421205301.3ds7jrgcktuldvrp@mwanda>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20170421205301.3ds7jrgcktuldvrp@mwanda>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_1BECD083-A84F-4EF8-BE8B-C4156932B0BD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 21 Apr 2017, at 22.53, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>=20
> This is a static checker fix, and perhaps not a real bug.  The static
> checker thinks that nr_secs could be negative.  It would result in
> zeroing more memory than intended.  Anyway, even if it's not a bug,
> changing this variable to unsigned makes the code easier to audit.
>=20
> Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index bce7ed5fc73f..c9daa33e8d9c 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -288,7 +288,7 @@ static void pblk_read_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
> int pblk_submit_read(struct pblk *pblk, struct bio *bio)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> -	int nr_secs =3D pblk_get_secs(bio);
> +	unsigned int nr_secs =3D pblk_get_secs(bio);
> 	struct nvm_rq *rqd;
> 	unsigned long read_bitmap; /* Max 64 ppas per request */
> 	unsigned int bio_init_idx;

Thanks Dan. While you are at it, can you also modify the type on the
other 2 calls to pblk_get_secs in pblk-cache and pblk-core?

Otherwise, it is a good catch.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

Javier

--Apple-Mail=_1BECD083-A84F-4EF8-BE8B-C4156932B0BD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY+oazAAoJEGMfBTt1mRjK3eIP/iTyAyJgIvBItGMBJ1jx5l+T
iI5bBox2fnPIrDHC4baC2q+lFbAvD1DY+2KBjLMEWCjMTy5YBsF45kXVq2w13XtD
eOdovJEMYItvxyRt6y+1yRyrTzuE/Ex2B70Wcyfk6Z10z/LGGs0hmK/e2QYBQzIf
4mi1xcC4fvufS1EQMHLs8ZEanMYGvOrQF4SEID8ipjeoHvWNhLMfyIfeCvTnqbEE
Nrwj0EaVuVZH65/o6Un+syPDTSbm5BCA3CDFcngQoiol7052BhmJK3n9Ia1CsnaK
XQ197Qv9mxa7Aw4X+ObAHwmJMHIKmJoIGLMSfVniDgWqHdMymnfqhTLKCsBrDnZU
oDAqefC/l057JnnpUeNL9xxfyySql7PrCMAejYcO1dxNPrLFk+oEd1lmapFKoJiE
DbwLoRTGwuuE/BoLXibt+lwKtUZy99fYWEuZgfk1ptiTGhr73Zs6gAY6yrIi4NfK
NJT8ZQTNBfee2/NXVi2ghpApBj1KZ5TtH7CmzRWiEKq7plh6FMHrYfRcm/1kYD8A
bG6nm+S4fivC7SB3k1KKPvztAV/cdi0dhkmulI34zt+NJRVHmafqsGI9AkE6CfAo
vARsRbMuAMNJEOwJMKf2aGcYyQCVIhrrUIxrJ0cyYW572TK+QqjNNIaH+mjL137o
IcaoIZF6llsaPKQCvKs6
=oGiv
-----END PGP SIGNATURE-----

--Apple-Mail=_1BECD083-A84F-4EF8-BE8B-C4156932B0BD--
