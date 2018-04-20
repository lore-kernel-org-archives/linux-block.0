Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0055.outbound.protection.outlook.com ([104.47.36.55]:50336
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750985AbeDTSvu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Apr 2018 14:51:50 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH 3/3] lightnvm: pblk: fix smeta write error path
Date: Fri, 20 Apr 2018 18:51:47 +0000
Message-ID: <621D78CA-8246-43D0-930D-866C3EBA5FA2@cnexlabs.com>
References: <1524155964-3743-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1524155964-3743-4-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1524155964-3743-4-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E8618736-166D-4F11-A6EF-EA599FBF81B1";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_E8618736-166D-4F11-A6EF-EA599FBF81B1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 19 Apr 2018, at 09.39, Hans Holmberg =
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
> index f6135e4..485fe8c 100644
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

Looks good to me..

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>



--Apple-Mail=_E8618736-166D-4F11-A6EF-EA599FBF81B1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlraNr8ACgkQIX4xUKFR
nnQ5jQ//dF985kd7LBAsmSbHMt2nM4pjd6iBpGhi0S0+n3IBCOGd9DrtSAIWlV6N
rn0ON0iU3i3I47FAL846SK56aFYOBF4mAyNtZXLwH3JVJ2JF9V4q6LP1+6B43RuV
+0jIBQ8uW0lg1JnqlphFHu8GsznXUHJPjAtRaWEPXBcOeulfCqCR6yCL9FPb0fYO
e+X4ggQyY1zuiKo0Ro5N2JTNk3xIr/bXrK9vwPoqGiZs5w1zFKxZxjK9WRkFZDI1
1wfvNJe7ZHYUs3eAzThZl6A+ibbKHTf//dYlsZnIOYCaq83vppXCzFWE+7YzqVrT
Tf97hl0AU0FcM9301mXJaiIqBxLFH5RGRvUpO8lEECd9C6qgOgPgy9MratBwNA09
ClTgb4vuymy+Gv/hHPL3gJOUtBKGrOasdMKzBfAoCkSlYuJQLbTl7T3a1522nfa4
vJVfoGa3OVRwNkl92+nOUVllGGsMqmWo5CoCBXM4j0mx1zwjevdkYhx7tdreJdbt
ClcwhsXbUNisVB2F3uE6a5Hy+BsVt6ATAxc/NmUD9i+nWZCJeVw93DinC/LC6qBi
vAhNGdrQpZ9Z/zUtCgOP+676A3FYCo4K15ufsjirt/0+FJPcl7VrVDF3y7cHItBj
sVqD9IERkw8QxpJKbEOqCGpH63+ikewWLNw79IqmmEyV39tPI2g=
=uwEZ
-----END PGP SIGNATURE-----

--Apple-Mail=_E8618736-166D-4F11-A6EF-EA599FBF81B1--
