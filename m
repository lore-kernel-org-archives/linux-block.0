Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:60384
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbeHTK75 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 06:59:57 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: fix incorrect min_write_pgs
Date: Mon, 20 Aug 2018 07:45:19 +0000
Message-ID: <6F75B3CB-23BA-4CCD-9EA7-8B8B00BFFB9E@cnexlabs.com>
References: <20180817143637.15943-1-mb@lightnvm.io>
In-Reply-To: <20180817143637.15943-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1AF0A1C8-ADBF-41BC-A0C1-0F6D4E82CE9F";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_1AF0A1C8-ADBF-41BC-A0C1-0F6D4E82CE9F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Aug 2018, at 16.36, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The calculation of pblk->min_write_pgs should only use the optimal
> write size attribute provided by the drive, it does not correlate to
> the memory page size of the system, which can be smaller or larger
> than the LBA size reported.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-init.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 9119c64d6f62..8adc8ac8b03c 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -371,7 +371,7 @@ static int pblk_core_init(struct pblk *pblk)
> 	atomic64_set(&pblk->nr_flush, 0);
> 	pblk->nr_flush_rst =3D 0;
>=20
> -	pblk->min_write_pgs =3D geo->ws_opt * (geo->csecs / PAGE_SIZE);
> +	pblk->min_write_pgs =3D geo->ws_opt;
> 	max_write_ppas =3D pblk->min_write_pgs * geo->all_luns;
> 	pblk->max_write_pgs =3D min_t(int, max_write_ppas, =
NVM_MAX_VLBA);
> 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
> --
> 2.11.0

Looks good to me.


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_1AF0A1C8-ADBF-41BC-A0C1-0F6D4E82CE9F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt6cY0ACgkQIX4xUKFR
nnQNmRAAgJxwq9yBZonp9i4GgHcr9g+7wT0y06HoX1lI64UbdzdSWE5EAXxaGR37
1+0Cw53iF0gwDG79SI4grudAtdMYUxppmHeJDFdOJOedHykiybqXNlRAoCeFx5fa
iBGS9HrAiqHJpQE7Mo5Ov3gCWDPrCgWUq13u3z33vq02t+pk3FLh9Rka71v4ID6k
l9imXjKmDHBfwsqbd8MPmfYvkfLCxg49uTkQ1FAs+q7nJPrfX3fPsvUnDAdul+Q5
KYx7MZNSzyyvuaQJb/wi9sDJBDmEtMAhEJYxw6Fd3tVAMtmFcub4VPLMlm3G23xp
ZI+ili6Wn+pWJ3cbv5MFf44s/1zmtGBsOH9XUtxE40aWqEKL6EJQ/PYXO2G6iRsg
stghihRLfkqAlhEUvtUGHyyVWT4uRPQsse8bDIco4Dr+yA7XiXkPOnn87V8tseUG
PYJ9oD4o2tAtxmLwph3mynNAtErGewleU2A0JqhnY+3/T5W+jWK9OGOwtMOqLlc1
2XRtRzcQotpPzc7hhBWzBFQh5JhN6ulZzAndwftemZPLww/BxZd7dFdFVOBcDjKT
n+QDToOgN3JCmi65B2R7WNUzx15hE3DbksUZyjDEwZU/BrC0ceoD5kCYjjDNgttO
+4CNWJq2SUlktMmrZ25v3c8DzetY+GINZVfiSM0vvcebs73IN4k=
=gWWt
-----END PGP SIGNATURE-----

--Apple-Mail=_1AF0A1C8-ADBF-41BC-A0C1-0F6D4E82CE9F--
