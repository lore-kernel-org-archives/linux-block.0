Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:52397 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbdJBLmg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 07:42:36 -0400
Received: by mail-wm0-f50.google.com with SMTP id k4so7863951wmc.1
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 04:42:36 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <66FF3618-BAF0-4E32-A0D2-B5959D08D696@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_345B0CD2-FDDB-4E6E-90D5-F93276DC7E94";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/6] lightnvm: remove stable extern and unused exported
 symbols
Date: Mon, 2 Oct 2017 13:42:33 +0200
In-Reply-To: <20171001132516.GA5743@hercules.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20171001132516.GA5743@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_345B0CD2-FDDB-4E6E-90D5-F93276DC7E94
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 1 Oct 2017, at 15.25, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> Not all exported symbols are being used outside core and there were
> some stable entries in lightnvm.h
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/core.c  | 129 =
+++++++++++++++++++++++------------------------
> include/linux/lightnvm.h |   7 ---
> 2 files changed, 64 insertions(+), 72 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 9cd1c4b..2817b37 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -226,6 +226,24 @@ static const struct block_device_operations =
nvm_fops =3D {
> 	.owner		=3D THIS_MODULE,
> };
>=20
> +struct nvm_tgt_type *nvm_find_target_type(const char *name, int lock)
> +{
> +	struct nvm_tgt_type *tmp, *tt =3D NULL;
> +
> +	if (lock)
> +		down_write(&nvm_tgtt_lock);
> +
> +	list_for_each_entry(tmp, &nvm_tgt_types, list)
> +		if (!strcmp(name, tmp->name)) {
> +			tt =3D tmp;
> +			break;
> +		}
> +
> +	if (lock)
> +		up_write(&nvm_tgtt_lock);
> +	return tt;
> +}
> +
> static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create =
*create)
> {
> 	struct nvm_ioctl_create_simple *s =3D &create->conf.s;
> @@ -532,25 +550,6 @@ void nvm_part_to_tgt(struct nvm_dev *dev, =
sector_t *entries,
> }
> EXPORT_SYMBOL(nvm_part_to_tgt);
>=20
> -struct nvm_tgt_type *nvm_find_target_type(const char *name, int lock)
> -{
> -	struct nvm_tgt_type *tmp, *tt =3D NULL;
> -
> -	if (lock)
> -		down_write(&nvm_tgtt_lock);
> -
> -	list_for_each_entry(tmp, &nvm_tgt_types, list)
> -		if (!strcmp(name, tmp->name)) {
> -			tt =3D tmp;
> -			break;
> -		}
> -
> -	if (lock)
> -		up_write(&nvm_tgtt_lock);
> -	return tt;
> -}
> -EXPORT_SYMBOL(nvm_find_target_type);
> -
> int nvm_register_tgt_type(struct nvm_tgt_type *tt)
> {
> 	int ret =3D 0;
> @@ -602,6 +601,52 @@ static struct nvm_dev *nvm_find_nvm_dev(const =
char *name)
> 	return NULL;
> }
>=20
> +static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct =
nvm_rq *rqd,
> +			const struct ppa_addr *ppas, int nr_ppas)
> +{
> +	struct nvm_dev *dev =3D tgt_dev->parent;
> +	struct nvm_geo *geo =3D &tgt_dev->geo;
> +	int i, plane_cnt, pl_idx;
> +	struct ppa_addr ppa;
> +
> +	if (geo->plane_mode =3D=3D NVM_PLANE_SINGLE && nr_ppas =3D=3D 1) =
{
> +		rqd->nr_ppas =3D nr_ppas;
> +		rqd->ppa_addr =3D ppas[0];
> +
> +		return 0;
> +	}
> +
> +	rqd->nr_ppas =3D nr_ppas;
> +	rqd->ppa_list =3D nvm_dev_dma_alloc(dev, GFP_KERNEL, =
&rqd->dma_ppa_list);
> +	if (!rqd->ppa_list) {
> +		pr_err("nvm: failed to allocate dma memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	plane_cnt =3D geo->plane_mode;
> +	rqd->nr_ppas *=3D plane_cnt;
> +
> +	for (i =3D 0; i < nr_ppas; i++) {
> +		for (pl_idx =3D 0; pl_idx < plane_cnt; pl_idx++) {
> +			ppa =3D ppas[i];
> +			ppa.g.pl =3D pl_idx;
> +			rqd->ppa_list[(pl_idx * nr_ppas) + i] =3D ppa;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
> +			struct nvm_rq *rqd)
> +{
> +	if (!rqd->ppa_list)
> +		return;
> +
> +	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, =
rqd->dma_ppa_list);
> +}
> +
> +
> int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr =
*ppas,
> 		       int nr_ppas, int type)
> {
> @@ -775,52 +820,6 @@ void nvm_put_area(struct nvm_tgt_dev *tgt_dev, =
sector_t begin)
> }
> EXPORT_SYMBOL(nvm_put_area);
>=20
> -int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq =
*rqd,
> -			const struct ppa_addr *ppas, int nr_ppas)
> -{
> -	struct nvm_dev *dev =3D tgt_dev->parent;
> -	struct nvm_geo *geo =3D &tgt_dev->geo;
> -	int i, plane_cnt, pl_idx;
> -	struct ppa_addr ppa;
> -
> -	if (geo->plane_mode =3D=3D NVM_PLANE_SINGLE && nr_ppas =3D=3D 1) =
{
> -		rqd->nr_ppas =3D nr_ppas;
> -		rqd->ppa_addr =3D ppas[0];
> -
> -		return 0;
> -	}
> -
> -	rqd->nr_ppas =3D nr_ppas;
> -	rqd->ppa_list =3D nvm_dev_dma_alloc(dev, GFP_KERNEL, =
&rqd->dma_ppa_list);
> -	if (!rqd->ppa_list) {
> -		pr_err("nvm: failed to allocate dma memory\n");
> -		return -ENOMEM;
> -	}
> -
> -	plane_cnt =3D geo->plane_mode;
> -	rqd->nr_ppas *=3D plane_cnt;
> -
> -	for (i =3D 0; i < nr_ppas; i++) {
> -		for (pl_idx =3D 0; pl_idx < plane_cnt; pl_idx++) {
> -			ppa =3D ppas[i];
> -			ppa.g.pl =3D pl_idx;
> -			rqd->ppa_list[(pl_idx * nr_ppas) + i] =3D ppa;
> -		}
> -	}
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(nvm_set_rqd_ppalist);
> -
> -void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq =
*rqd)
> -{
> -	if (!rqd->ppa_list)
> -		return;
> -
> -	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, =
rqd->dma_ppa_list);
> -}
> -EXPORT_SYMBOL(nvm_free_rqd_ppalist);
> -
> void nvm_end_io(struct nvm_rq *rqd)
> {
> 	struct nvm_tgt_dev *tgt_dev =3D rqd->dev;
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index c8c014b..dfd4829 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -463,8 +463,6 @@ struct nvm_tgt_type {
> 	struct list_head list;
> };
>=20
> -extern struct nvm_tgt_type *nvm_find_target_type(const char *, int);
> -
> extern int nvm_register_tgt_type(struct nvm_tgt_type *);
> extern void nvm_unregister_tgt_type(struct nvm_tgt_type *);
>=20
> @@ -480,9 +478,6 @@ extern int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev =
*, struct ppa_addr *,
> extern int nvm_max_phys_sects(struct nvm_tgt_dev *);
> extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
> extern int nvm_erase_sync(struct nvm_tgt_dev *, struct ppa_addr *, =
int);
> -extern int nvm_set_rqd_ppalist(struct nvm_tgt_dev *, struct nvm_rq *,
> -					const struct ppa_addr *, int);
> -extern void nvm_free_rqd_ppalist(struct nvm_tgt_dev *, struct nvm_rq =
*);
> extern int nvm_get_l2p_tbl(struct nvm_tgt_dev *, u64, u32, =
nvm_l2p_update_fn *,
> 			   void *);
> extern int nvm_get_area(struct nvm_tgt_dev *, sector_t *, sector_t);
> @@ -491,8 +486,6 @@ extern void nvm_end_io(struct nvm_rq *);
> extern int nvm_bb_tbl_fold(struct nvm_dev *, u8 *, int);
> extern int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr, =
u8 *);
>=20
> -extern int nvm_dev_factory(struct nvm_dev *, int flags);
> -
> extern void nvm_part_to_tgt(struct nvm_dev *, sector_t *, int);
>=20
> #else /* CONFIG_NVM */
> --
> 2.7.4

LGTM (also stable > stale)

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_345B0CD2-FDDB-4E6E-90D5-F93276DC7E94
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnSJikACgkQYx8FO3WZ
GMpV1RAAt7jHpoKlpjPqiK/0448nXUM/49P68BaDoT/HWwAECseQqBaqnT9KFz+L
QfA7IdjkFKB91JuLRDnuT+Nofxg/B36L2WBbkeJ9bqtpgip7HlEMxLiLmdtzo80p
QFdwBTklXCFWIKHVvlAh9eaWi40/uYLJaPmyIjVuqlk9cNwUEp812ELt1Df5xQXS
r/wwoa0qB0LKLGWvxIV7bMc59NernRtLBVHnMVdrsmRG4NOwpPwgq3pnOvHbTB7A
Xckv1Mn1pKR5BWxLTD/ApgVDtBazCB9P6zyzjTZDT2+9Rp3gVM3QQbx3MOQBxKPA
QGDmEyYNFQD4VqTPr4MqtFbj+xsbEhA1yPeAkaFVJedTRakYCnoQ8yGNiycERpft
hjRwOqcgNTXFMKv3X8gU3q+FLTk4Sz160+WyFsBkw6EH7+a+wH6cxI5if8flrMgn
1EoP8ONpGbF2SOsX85d+SOIZudOxwlrv5n4JKu7KMlZvGIVhOdqZAErj6tbFRWm3
BHnuMLTf4/bAr0+gAoS+WYMyD0ht/v+2sHYpChcW40zQMuK0u3MNV9fVrYSCbtCx
+V2pssh20Xv/wnPamvBRqyMdkV18TipLiqzoKujmmBNdGz4GgbOUDBf9DIqyF+bC
gPlusRp96g3AfD8pooaOriacMt7e0ygNlf/us+IinYmn8WYRPck=
=LiSe
-----END PGP SIGNATURE-----

--Apple-Mail=_345B0CD2-FDDB-4E6E-90D5-F93276DC7E94--
