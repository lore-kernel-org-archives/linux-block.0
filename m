Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0066.outbound.protection.outlook.com ([104.47.36.66]:2272
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727540AbeHCOV3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Aug 2018 10:21:29 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: fix rqd.error return value in
 pblk_blk_erase_sync
Date: Fri, 3 Aug 2018 12:25:17 +0000
Message-ID: <A68E3E50-F18C-464D-8596-A6E269568B1B@cnexlabs.com>
References: <20180802205023.29094-1-mb@lightnvm.io>
In-Reply-To: <20180802205023.29094-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6CFDE94B-5740-495F-915C-065BDBC33459";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_6CFDE94B-5740-495F-915C-065BDBC33459
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 2 Aug 2018, at 22.50, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> rqd.error is masked by the return value of pblk_submit_io_sync.
> The rqd structure is then passed on to the end_io function, which
> assumes that any error should lead to a chunk being marked
> offline/bad. Since the pblk_submit_io_sync can fail before the
> command is issued to the device, the error value maybe not correspond
> to a media failure, leading to chunks being immaturely retired.
>=20
> Also, the pblk_blk_erase_sync function prints an error message in case
> the erase fails. Since the caller prints an error message by itself,
> remove the error message in this function.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-core.c | 19 ++-----------------
> 1 file changed, 2 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 72acf2f6dbd6..814204d22a2e 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -886,10 +886,8 @@ static void pblk_setup_e_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
>=20
> static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
> {
> -	struct nvm_rq rqd;
> -	int ret =3D 0;
> -
> -	memset(&rqd, 0, sizeof(struct nvm_rq));
> +	struct nvm_rq rqd =3D {0};

This is a matter of taste, but if you want to squeeze it in here, it is
fine by me. There are other places with the same pattern; if you feel
strongly about this then please send a patch changing it in all the
places.

> +	int ret;
>=20
> 	pblk_setup_e_rq(pblk, &rqd, ppa);
>=20
> @@ -897,19 +895,6 @@ static int pblk_blk_erase_sync(struct pblk *pblk, =
struct ppa_addr ppa)
> 	 * with writes. Thus, there is no need to take the LUN =
semaphore.
> 	 */
> 	ret =3D pblk_submit_io_sync(pblk, &rqd);
> -	if (ret) {
> -		struct nvm_tgt_dev *dev =3D pblk->dev;
> -		struct nvm_geo *geo =3D &dev->geo;
> -
> -		pblk_err(pblk, "could not sync erase line:%d,blk:%d\n",
> -					pblk_ppa_to_line(ppa),
> -					pblk_ppa_to_pos(geo, ppa));
> -
> -		rqd.error =3D ret;
> -		goto out;
> -	}
> -
> -out:
> 	rqd.private =3D pblk;
> 	__pblk_end_io_erase(pblk, &rqd);
>=20
> --
> 2.11.0

Otherwise, it looks like a good cleanup. Thanks.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_6CFDE94B-5740-495F-915C-065BDBC33459
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkSaoACgkQIX4xUKFR
nnR+DA/9EySYmNcWyZ0WN+88lnj2G6a8ZH56shSoGUVA7umVerp5JrnXupTx8ajx
WpiTYEVl3ubRZJKekqQw8jGjx/kSUJS7DvnuQiWQF3feWV/y3ExpjSALGEUEkPqR
F1an979L35HFQ3tBs9xDgp5uGiMb9VhK7+7jxGUiPXab0EY8wz/ZbwlA83A1Qu+d
DD+Nw0Zmn+8218R7/Gwvoj/+I8L6Ppiti7JbRsH+/RqBwZcIhfsGs4Q+epvonR67
Zowtn3gYWaMG3AglktyCN0Vo/bar+UNG2wOlO51NiFeMC+1DBUcMGuFXVPNR2M8O
8L+Y9YHxDNGH1sKMQ65cY3rlmcgOcr2b7cDa01XPsosv1PY4wt0cUb6I1zTepMtA
hY2ztQcr5JU5J9ONQpBHEah63SqKz9M7ILY5t8K79b0dKC18Teu5LpCXg6OrTebI
nItG3nAx2mrPrBq2zmbNkLSC2ExRTEnaFwVk8V7qcLL1bRRyyUTEEJhiRq15d9ca
vJ//8XrYoFY3Isc4q4g1bniBmcFR17DJBjP9iU2VejWoBHDUKyFff7ePS1FrINfc
5MrxVsbB6oMtxeuqjn0Fkhsrsakdz4RRqDIYIwbBE+5591d3fsh+FL6wxqFloUWu
FuhUx1SMbUxzwwe+TrzdD+g7Sy7y5TJyu3mY49ndQEfP2UF4nDk=
=0sX2
-----END PGP SIGNATURE-----

--Apple-Mail=_6CFDE94B-5740-495F-915C-065BDBC33459--
