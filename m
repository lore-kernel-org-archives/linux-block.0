Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0087.outbound.protection.outlook.com ([104.47.40.87]:29424
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751511AbeD3JT2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Apr 2018 05:19:28 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v2 3/3] lightnvm: pblk: fix smeta write error path
Date: Mon, 30 Apr 2018 09:19:25 +0000
Message-ID: <E2E27D56-61CE-4882-8D78-1427CF70CE7A@cnexlabs.com>
References: <1524548732-4326-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1524548732-4326-4-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1524548732-4326-4-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_458DC4B9-5053-4139-9D6C-1FBF03526C97";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_458DC4B9-5053-4139-9D6C-1FBF03526C97
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 24 Apr 2018, at 07.45, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> Smeta write errors were previously ignored. Skip these
> lines instead and throw them back on the free
> list, so the chunks will go through a reset cycle
> before we attempt to use the line again.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-core.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 413cf3b..dec1bb4 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -849,9 +849,10 @@ static int pblk_line_submit_smeta_io(struct pblk =
*pblk, struct pblk_line *line,
> 	atomic_dec(&pblk->inflight_io);
>=20
> 	if (rqd.error) {
> -		if (dir =3D=3D PBLK_WRITE)
> +		if (dir =3D=3D PBLK_WRITE) {
> 			pblk_log_write_err(pblk, &rqd);
> -		else if (dir =3D=3D PBLK_READ)
> +			ret =3D 1;
> +		} else if (dir =3D=3D PBLK_READ)
> 			pblk_log_read_err(pblk, &rqd);
> 	}
>=20
> @@ -1120,7 +1121,7 @@ static int pblk_line_init_bb(struct pblk *pblk, =
struct pblk_line *line,
>=20
> 	if (init && pblk_line_submit_smeta_io(pblk, line, off, =
PBLK_WRITE)) {
> 		pr_debug("pblk: line smeta I/O failed. Retry\n");
> -		return 1;
> +		return 0;
> 	}
>=20
> 	bitmap_copy(line->invalid_bitmap, line->map_bitmap, =
lm->sec_per_line);
> --
> 2.7.4

LGTM

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_458DC4B9-5053-4139-9D6C-1FBF03526C97
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlrm35cACgkQIX4xUKFR
nnQDUBAA0eiAh9qCF3v0+BO8Gg2bv0P+xq7Bknyt3e10uJbbmcHfClOozEY/uHVp
TKTd117O/sx9JgduHw8zZt3u7NPguVLEs88JoRvSPR3ty49AXpbVbEodjC651a65
lahlbBMO6mn83LiVxbxzexFbtAhHeRXbGb8lvQyXxDs8wF1+beSbT+7WfZxCLjzO
+R6CzKlsF7B7KUj5XLV55ZghG0M7HIa6WtsS75nhYgxyfT+I4YpRonzUciIEmPcw
2wWP1zCil/T+YzqUpF8idgALtjdjWeJgD/uahncpolGwA/95gXAticFChj3VQML9
01iRB5wIbHDTioSlXsC9BV10LDWbYVSFLznP4JFEw5TeAeJU7TG++Pwjyc8oHiiT
7pZyKxVW3eukL9IAWIA6lSOLw/xv4TOwv1igXPg4UFEqCC4iMQMGsWnLWBsDoufh
+wEzrdoGrpmJvSc1ZDU3470pAEXhuuJksIisZl1cYYI+i1khcG+SWc14cQ6zn77T
u3a+kHq47qzPb6w1oEe7TPzWe8mF7MH0GWIww/XyoZg2kXw4nPRS3k0K1a3PGcw7
5WPbh4Lxz4O7hSIVhnyQ0XgxsYRlDK9j/Ut5+cc/x/c6j2zTdYDtHoW1Thu2iIWU
xRbwJ6NcV6DiPLeK7lwHLbz59EixN0hjjPXLCSRQqnRvk3vB73o=
=t/dS
-----END PGP SIGNATURE-----

--Apple-Mail=_458DC4B9-5053-4139-9D6C-1FBF03526C97--
