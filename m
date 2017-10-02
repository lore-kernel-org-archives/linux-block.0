Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:45881 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbdJBLkj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 07:40:39 -0400
Received: by mail-wm0-f42.google.com with SMTP id q124so10016295wmb.0
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 04:40:38 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <40AAFFAC-BDF9-44CD-838E-2152CD9FDB21@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A6FE78BD-E3CB-49AF-BC25-A89FDA9C3CF7";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/6] lightnvm: remove unused argument from
 nvm_set_tgt_bb_tbl
Date: Mon, 2 Oct 2017 13:40:36 +0200
In-Reply-To: <20171001132434.GA5714@hercules.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20171001132434.GA5714@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_A6FE78BD-E3CB-49AF-BC25-A89FDA9C3CF7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 1 Oct 2017, at 15.24, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> vblk isn't being used anyway and if we ever have a usecase we can
> introduce this again.  This makes the logic easier and removes
> unnecessary checks.
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/core.c  | 29 ++++++++++++-----------------
> include/linux/lightnvm.h |  2 +-
> 2 files changed, 13 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index ddae430..9cd1c4b 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -616,7 +616,7 @@ int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev =
*tgt_dev, struct ppa_addr *ppas,
>=20
> 	memset(&rqd, 0, sizeof(struct nvm_rq));
>=20
> -	nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas, 1);
> +	nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas);
> 	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
>=20
> 	ret =3D dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, =
type);
> @@ -680,7 +680,7 @@ int nvm_erase_sync(struct nvm_tgt_dev *tgt_dev, =
struct ppa_addr *ppas,
> 	rqd.private =3D &wait;
> 	rqd.flags =3D geo->plane_mode >> 1;
>=20
> -	ret =3D nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas, 1);
> +	ret =3D nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas);
> 	if (ret)
> 		return ret;
>=20
> @@ -776,14 +776,14 @@ void nvm_put_area(struct nvm_tgt_dev *tgt_dev, =
sector_t begin)
> EXPORT_SYMBOL(nvm_put_area);
>=20
> int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq =
*rqd,
> -			const struct ppa_addr *ppas, int nr_ppas, int =
vblk)
> +			const struct ppa_addr *ppas, int nr_ppas)
> {
> 	struct nvm_dev *dev =3D tgt_dev->parent;
> 	struct nvm_geo *geo =3D &tgt_dev->geo;
> 	int i, plane_cnt, pl_idx;
> 	struct ppa_addr ppa;
>=20
> -	if ((!vblk || geo->plane_mode =3D=3D NVM_PLANE_SINGLE) && =
nr_ppas =3D=3D 1) {
> +	if (geo->plane_mode =3D=3D NVM_PLANE_SINGLE && nr_ppas =3D=3D 1) =
{
> 		rqd->nr_ppas =3D nr_ppas;
> 		rqd->ppa_addr =3D ppas[0];
>=20
> @@ -797,19 +797,14 @@ int nvm_set_rqd_ppalist(struct nvm_tgt_dev =
*tgt_dev, struct nvm_rq *rqd,
> 		return -ENOMEM;
> 	}
>=20
> -	if (!vblk) {
> -		for (i =3D 0; i < nr_ppas; i++)
> -			rqd->ppa_list[i] =3D ppas[i];
> -	} else {
> -		plane_cnt =3D geo->plane_mode;
> -		rqd->nr_ppas *=3D plane_cnt;
> -
> -		for (i =3D 0; i < nr_ppas; i++) {
> -			for (pl_idx =3D 0; pl_idx < plane_cnt; pl_idx++) =
{
> -				ppa =3D ppas[i];
> -				ppa.g.pl =3D pl_idx;
> -				rqd->ppa_list[(pl_idx * nr_ppas) + i] =3D =
ppa;
> -			}
> +	plane_cnt =3D geo->plane_mode;
> +	rqd->nr_ppas *=3D plane_cnt;
> +
> +	for (i =3D 0; i < nr_ppas; i++) {
> +		for (pl_idx =3D 0; pl_idx < plane_cnt; pl_idx++) {
> +			ppa =3D ppas[i];
> +			ppa.g.pl =3D pl_idx;
> +			rqd->ppa_list[(pl_idx * nr_ppas) + i] =3D ppa;
> 		}
> 	}
>=20
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 81b71c6d..c8c014b 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -481,7 +481,7 @@ extern int nvm_max_phys_sects(struct nvm_tgt_dev =
*);
> extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
> extern int nvm_erase_sync(struct nvm_tgt_dev *, struct ppa_addr *, =
int);
> extern int nvm_set_rqd_ppalist(struct nvm_tgt_dev *, struct nvm_rq *,
> -					const struct ppa_addr *, int, =
int);
> +					const struct ppa_addr *, int);
> extern void nvm_free_rqd_ppalist(struct nvm_tgt_dev *, struct nvm_rq =
*);
> extern int nvm_get_l2p_tbl(struct nvm_tgt_dev *, u64, u32, =
nvm_l2p_update_fn *,
> 			   void *);
> --
> 2.7.4

This was used when using MLC media as SLC back in the days, when we had
the host media manager (spec 1.2). We probably want to have a path to
use NAND as SLC, but I agree that it should be separated in order to
reduce the number of checks (considering that this is for a very
specific purpose).


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_A6FE78BD-E3CB-49AF-BC25-A89FDA9C3CF7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnSJbQACgkQYx8FO3WZ
GMpV9BAAg9IjgV0HC2W+J4h5osF9PZkLZaCPtqo8fWnPLqXwrB4T5tV9FutAAl/1
CewK1RlXfnTpaVUNZg+YJS4at3V5A+wZbg4cXV1ujFAIViNbHyNhDcI9zdxhIFCs
f5xWjK0msmuIWdVaZG9dahjZFrBfJYmCVYIur49nzv7Jzt57v6rq5iU5bhlOHSaC
FaFN1yFAoQap/IcvZm8gzvMAwUwvd6wntbwU89B5VCsWfoLFb4Yc9weS9nUmsqMt
1dNPqL1ltBl7mh1qS48sOWR+TSSIpRdegIZG+fjsICsu18dtn/9NT5pEs7UieGq8
1rgUgoKGqcpv/UehXyMkE+CGRxskwoLL33uvsIhdq1AAgpFTb2bq32sGxNbIXmUN
ghVvyZjp18QXjm48DobEUR4cvLwWP7Y2mecajCudva4wCseoeNnyvUsGBNxSPuE4
j3OES/1Pmjfe1/L1DxSFqSrjYUFN3LSw7tZ/40kr+43aMXqkfNHS7+gsL8eHTEsU
TrFvakCKv+UwfH6qkYhLlcjsFFerPmwxTe4sbHo6e6L++u6OiVvBfDt8nQDFNfdg
d/nkg7Lc2Tuu0n6LGCBrNrmJbQiunWOP4zEBAj0AI9uVIRByzeqcN5k3y8g6O+n2
kic+SbLLtajLp89qMNE+HdnsgOgDQgPAPHlfYd0GhCrY5qTtfcU=
=Q8Mh
-----END PGP SIGNATURE-----

--Apple-Mail=_A6FE78BD-E3CB-49AF-BC25-A89FDA9C3CF7--
