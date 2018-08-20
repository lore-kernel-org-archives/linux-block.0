Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2nam02on0046.outbound.protection.outlook.com ([104.47.38.46]:59296
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbeHTP5x (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 11:57:53 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: introduce nvm_rq_to_ppa_list
Date: Mon, 20 Aug 2018 12:38:26 +0000
Message-ID: <DA2F1D94-23DC-4739-9056-351992D972EE@cnexlabs.com>
References: <20180820121217.11393-1-mb@lightnvm.io>
In-Reply-To: <20180820121217.11393-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9A359065-B7DB-422C-90E9-FD0D027ADBE3";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_9A359065-B7DB-422C-90E9-FD0D027ADBE3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 20 Aug 2018, at 14.12, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> There is a number of places in the lightnvm subsystem where the user
> iterates over the ppa list. Before iterating, the user must know if it
> is a single or multiple LBAs due to vector commands using either the
> nvm_rq ->ppa_addr or ->ppa_list fields on command submission, which
> leads to open-coding the if/else statement.
>=20
> Instead of having multiple if/else's, move it into a function that can
> be called by its users.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-read.c  | 4 +---
> drivers/lightnvm/pblk-write.c | 5 +----
> drivers/lightnvm/pblk.h       | 4 +---
> include/linux/lightnvm.h      | 5 +++++
> 4 files changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index f275c7e5abe4..696d3a9c9cf0 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -175,11 +175,9 @@ static void __pblk_read_put_line(struct pblk =
*pblk, struct ppa_addr ppa)
>=20
> static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
> {
> -	struct ppa_addr *ppa_list;
> +	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	int i;
>=20
> -	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
> -
> 	for (i =3D 0; i < rqd->nr_ppas; i++)
> 		__pblk_read_put_line(pblk, ppa_list[i]);
> }
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index df99c45778d4..a92450ec7698 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -212,10 +212,7 @@ static void pblk_submit_rec(struct work_struct =
*work)
>=20
> 	pblk_log_write_err(pblk, rqd);
>=20
> -	if (rqd->nr_ppas =3D=3D 1)
> -		ppa_list =3D &rqd->ppa_addr;
> -	else
> -		ppa_list =3D rqd->ppa_list;
> +	ppa_list =3D nvm_rq_to_ppa_list(rqd);
>=20
> 	pblk_map_remaining(pblk, ppa_list);
> 	pblk_queue_resubmit(pblk, c_ctx);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 64ae0c7ed3bb..bda098c7cc3b 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -1335,9 +1335,7 @@ static inline int =
pblk_boundary_ppa_checks(struct nvm_tgt_dev *tgt_dev,
> static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> -	struct ppa_addr *ppa_list;
> -
> -	ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : =
&rqd->ppa_addr;
> +	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
>=20
> 	if (pblk_boundary_ppa_checks(dev, ppa_list, rqd->nr_ppas)) {
> 		WARN_ON(1);
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 0106984400bc..1497e275f90f 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -487,6 +487,11 @@ static inline struct ppa_addr =
dev_to_generic_addr(struct nvm_dev *dev,
> 	return l;
> }
>=20
> +static inline struct ppa_addr *nvm_rq_to_ppa_list(struct nvm_rq *rqd)
> +{
> +	return (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
> +}
> +
> typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct =
bio *);
> typedef sector_t (nvm_tgt_capacity_fn)(void *);
> typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk =
*,
> --
> 2.11.0

Hans made a similar patch some time ago. There are a number of places
where you want to use this helper too, also outside of pblk. You can
look at it here [1]

[1] https://github.com/OpenChannelSSD/linux/commits/for-4.20/pblk

   fdd88185bfed
   17609afb2db9

Javier

--Apple-Mail=_9A359065-B7DB-422C-90E9-FD0D027ADBE3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt6tj8ACgkQIX4xUKFR
nnT1rxAAjxwQ8y0Bmk6XvXQDkGSEQ6jDv010l8Fpx6NcvjL/i1TXw7R9+xUHFtOu
3RqmYlmndmx5D0qjxOyVLQ/G3dGB0yEpK5vE/4al/RDhMRaM4vHMGLioESVuOYN1
jyXVE28XBiumKGD7zkFl/vybxgXxIcHlssi0MaMXFdkaDK2EFdvHEGF7FgihWKam
9oiC0rVMvjVHWM9hg7q8wLSNBjB/OabIWqMPye/WW4cVh3o4mWiU5nATdnwxUPaI
C+EdzwjpUo+5MIIwTtNNutMBdxPFxm9TqjUvCL79DJSWLRRv1Tpi/0LL/hsZykh3
FhWLTWUn/IhqKfirplpsHtDteVv7dIb3rcYJb/GyJkYkVM/OEwRyafTRrM16Os7O
LhOQzD+oi5sQquWkkNtc2f5cYhA9h164HEz030t+55wo5UOAdNhNVN/6oMilMMat
C0afBRp8S0wsa+FMUcZOQ0ooOaZVqrIbpBpQMEwmmL0UFZJod1FMFXqoy9tvjevI
V1L/vKf+yM5H9JgtNE/f/xBuk3A8eHwCHLDjxMefJfkt5SEyOYUtK06vQtRAWbu2
1d2kB2asx/429GDLbA/oHERh5KWcuiq1HfoM8YtkeJ2gaepfi5xGWkD6Ox4ZF3Pi
6/u9ksfgOncEJExgizwgLdI92A85Mr3+0T+FshCP0Q4+mZo+yEg=
=x6bS
-----END PGP SIGNATURE-----

--Apple-Mail=_9A359065-B7DB-422C-90E9-FD0D027ADBE3--
