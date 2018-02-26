Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-cys01nam02on0051.outbound.protection.outlook.com ([104.47.37.51]:48000
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752629AbeBZUgE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 15:36:04 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: Heiner Litz <hlitz@ucsc.edu>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>
Subject: Re: [PATCH][RESEND] lightnvm: Avoid validation of default op value
Date: Mon, 26 Feb 2018 20:35:59 +0000
Message-ID: <A2D48F7C-66B7-4515-BAFB-244010ACE486@cnexlabs.com>
References: <20180226202219.2880-1-hlitz@ucsc.edu>
In-Reply-To: <20180226202219.2880-1-hlitz@ucsc.edu>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D085BDD5-0E34-4034-9081-553B6607BE77";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_D085BDD5-0E34-4034-9081-553B6607BE77
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 26 Feb 2018, at 21.22, Heiner Litz <hlitz@ucsc.edu> wrote:
>=20
> Fixes: 38401d231de65 ("lightnvm: set target over-provision on create =
ioctl")
>=20
> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> ---
> drivers/lightnvm/core.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index dcc9e621e651..74b53fc1b813 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -304,11 +304,9 @@ static int __nvm_config_extended(struct nvm_dev =
*dev,
> 	}
>=20
> 	/* op not set falls into target's default */
> -	if (e->op =3D=3D 0xFFFF)
> +	if (e->op =3D=3D 0xFFFF) {
> 		e->op =3D NVM_TARGET_DEFAULT_OP;
> -
> -	if (e->op < NVM_TARGET_MIN_OP ||
> -	    e->op > NVM_TARGET_MAX_OP) {
> +	} else if (e->op < NVM_TARGET_MIN_OP || e->op > =
NVM_TARGET_MAX_OP) {
> 		pr_err("nvm: invalid over provisioning value\n");
> 		return -EINVAL;
> 	}
> --
> 2.14.1

Thanks for applying the changes. Looks good to me now.


--Apple-Mail=_D085BDD5-0E34-4034-9081-553B6607BE77
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqUb60ACgkQIX4xUKFR
nnSMkQ//QwejaIL2T1x6gAGRbQpp+CYqsMFJPSP21vxA6rJC2yiLfZNuWwnYQl9J
isT9m8NM3MBdbIFvT1eTgDGyXH7hOEfrcKrqQl99Xcgxe5UP7xMCjsxP7JRvuH7p
DHNXZ4xaF/1Tz6rks54EMC4GMP5LaA5iZupPcRyZEfsCwY3zuECoJYtth/MDqdgp
b03Cy/a+hlWaWrS9HvFT6kfq4pqU4yTgzHbcSjU9MWoT2eIXsXDoQ7ET6HEjQQ69
6aTV7kAyoPDfbiztnYWTPOlUYN5q1Z6XRBGKJRJIOScPEcz+9TwIrcCEGkeIwxXA
BvIc75IL0oIVo3O3HaRPALlB6jgdVAo+gjIojW3fbO3cV1hX6WKc7HgFymKNCnjk
dLNZJ0ItVPTxLgQgWpHkCAZ5eIKCOe6z64FuhdXUaGY9XKG3nRZHtvsYsTeBYCfb
8s+5oVANaJCE9v7e0/hnXvlzaP0aF6O/T5vc6QjWTYvKkDqo70GF2zTvyrcm3hbY
OaKerjYnn3IYygXdCnWVosH/h3XZjuBMDag7TDkPnzyeMIpNZVz3uNniZCozBFsL
hQ4GW8EM2bm/ocs9fsdbDww1peKDv+3e1oo+v/Y38z+t4j7ZOpcIxuVI27Y1KZZr
4fV+cnS6UU5T5CZoGcdWH3qyutvi2J5QVf/cczJGlemTrdTNolk=
=IwcY
-----END PGP SIGNATURE-----

--Apple-Mail=_D085BDD5-0E34-4034-9081-553B6607BE77--
