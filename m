Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:48823 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdJCKlo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:41:44 -0400
Received: by mail-wm0-f44.google.com with SMTP id i82so13601138wmd.3
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:41:43 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <B45E2486-501C-4827-8ADB-D7BEF41AC741@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8E73548C-52C8-43C4-BB59-01DD1C604675";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 9/9] lightnvm: pblk: correct valid lba count calculation
Date: Tue, 3 Oct 2017 12:41:41 +0200
In-Reply-To: <1507025113-13351-10-git-send-email-hans.ml.holmberg@owltronix.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1507025113-13351-10-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_8E73548C-52C8-43C4-BB59-01DD1C604675
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Oct 2017, at 12.05, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> During garbage collect, lbas being written can end up
> being invalidated. Make sure that this is reflected in
> the valid lba count.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-map.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 3bc4c94..6f3ecde 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -45,6 +45,8 @@ static void pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
> 	paddr =3D pblk_alloc_page(pblk, line, nr_secs);
>=20
> 	for (i =3D 0; i < nr_secs; i++, paddr++) {
> +		__le64 addr_empty =3D cpu_to_le64(ADDR_EMPTY);
> +
> 		/* ppa to be sent to the device */
> 		ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, line->id);
>=20
> @@ -61,10 +63,9 @@ static void pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
> 			w_ctx->ppa =3D ppa_list[i];
> 			meta_list[i].lba =3D cpu_to_le64(w_ctx->lba);
> 			lba_list[paddr] =3D cpu_to_le64(w_ctx->lba);
> -			line->nr_valid_lbas++;
> +			if (lba_list[paddr] !=3D addr_empty)
> +				line->nr_valid_lbas++;
> 		} else {
> -			__le64 addr_empty =3D cpu_to_le64(ADDR_EMPTY);
> -
> 			lba_list[paddr] =3D meta_list[i].lba =3D =
addr_empty;
> 			__pblk_map_invalidate(pblk, line, paddr);
> 		}
> --
> 2.7.4

LGTM.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

--Apple-Mail=_8E73548C-52C8-43C4-BB59-01DD1C604675
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTaWUACgkQYx8FO3WZ
GMqRtRAApmhdmZlpgCKcOwrk8o4arYm80rmKhum3u2dU+ylQ15WhqrpkZgzavqIB
WmG6iN003oTe92o5kIJTQlCy4o8OT0AXZcj4jgAGOrxzHINbJaXyqsC8biB1+PM2
7vCiHFCxxTbXZ5uB/qhwEM88HGY+pY3/bRwl4V6ISPvSUQETJgdiLASc80KdEwOP
F6JBol/T8Chm64xhBlgq7n5muSb9ggbiZFyfmq7XGdh77FRojjCplKoeRiTxsvKk
RtJdSrxmeS6yM03EyhbGQh7Is2HYxyoLsS1fefiFFxvbpqlSB/XPJruDEMTkf0EO
bC7EGtn3AbQgLIragWjIVWNklN+bvnwGWGWh3czBx4WDY2Ib8JIPwTJKmfFnZutn
Bn34ZKpwaoUO9au8WNSUVBUlzajuEOOUl2oA0/sQw+gGVX0EiSW+GXg1NEN44YFG
EFVwElbfif4Omyk1EJxt1N3J/UuC4UOrKJr8dLFqIser7Xb4spW3Yo3nT4NbHkQB
dOIfMTNwMdvozVp9Be8cZNXzTpjCDJ2FiZ//4ootdYGkNTZviet9BqxGl7i64Yfu
bBf+WcW2EDz2GYyGcUfPPkaS5Wt8/58C73ZWxEGLAiVQO98zrW/SFurCfIC6p3m+
ObydyVXKboiWHbsjcxHThCRF9nGZcBYzyuhSNeSAQH0DrP4PRD8=
=GPJ/
-----END PGP SIGNATURE-----

--Apple-Mail=_8E73548C-52C8-43C4-BB59-01DD1C604675--
