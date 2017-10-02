Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:50620 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdJBL3d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 07:29:33 -0400
Received: by mail-wm0-f42.google.com with SMTP id u138so9889182wmu.5
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 04:29:33 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <1140487A-C473-4A23-BCAC-465C2CCC852D@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7AA91B5D-C752-4258-8272-16CAC9D60E62";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/6] lightnvm: pblk: remove useless line
Date: Mon, 2 Oct 2017 13:29:30 +0200
In-Reply-To: <20171001132302.GA5668@hercules.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20171001132302.GA5668@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_7AA91B5D-C752-4258-8272-16CAC9D60E62
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 1 Oct 2017, at 15.23, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/pblk-core.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 1f8aa94..4ffd1d6 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1053,7 +1053,6 @@ static int pblk_line_init_bb(struct pblk *pblk, =
struct pblk_line *line,
> 	/* Mark emeta metadata sectors as bad sectors. We need to =
consider bad
> 	 * blocks to make sure that there are enough sectors to store =
emeta
> 	 */
> -	bit =3D lm->sec_per_line;
> 	off =3D lm->sec_per_line - lm->emeta_sec[0];
> 	bitmap_set(line->invalid_bitmap, off, lm->emeta_sec[0]);
> 	while (nr_bb) {
> --
> 2.7.4

LGTM

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_7AA91B5D-C752-4258-8272-16CAC9D60E62
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnSIxoACgkQYx8FO3WZ
GMoKrQ/2I4nY+E73H0gZlSoYvmMVY/BJjIwyPEqF9okes4zc3R/VmmsfjUsQYAmE
wlss9KLJLt39+3sCM6NTruIXJzBzkoLG3rOVNokmWgkQU40M/Z3OzdF0lxhbL4hM
NT2suZySCgOrEH0YZ/KSrSM31+iMvIMJB2gf/Ai1TqExQIXQw/YRYs3aPlK89XO7
khXRKZKLpFMkrEKvy7y7PtzetdlUrKmvk3j6wBmHtAccHnNUnOCwuXIH5tpX4aNZ
9Q0X0he6TPai+TujejsolclnlxUoppsKgE1PcDCcp48bREi1efS5lvRxWb+eaqli
W0ST1bZ0bNbEYmYjsEveUUYLgInZscTkLbgUYvjxfY2sISUt/KFOo+/8CynSrytv
bk9CtEDfQxplEHgVYuEM0PZoTKxzuOiu+hwLly7kGRzIvJl8PO8ZwMvsw6CLfDr9
jcnXLNG3jl/0x1snU0qAkWWPb6KMEBR09kSvNqDFa3VJAVUswTRCQ6WmANNy0DYf
63FiqCJewD9O7kn3znKBgpWyUAtuRQUo4WacfhbaMSaf7hpFHWsLsgwJn3ew9mlB
tEqqVoOwBsY0WyP6TgcFnx74RgVGMsYB75nLEvEUMhFsCLJhZz/DWS+OZITXCdaa
j99ArDQwgS14L3tl9Pw0EVziD+JcAGBLQ4qMFUIqC4YmUNQkoA==
=TdgM
-----END PGP SIGNATURE-----

--Apple-Mail=_7AA91B5D-C752-4258-8272-16CAC9D60E62--
