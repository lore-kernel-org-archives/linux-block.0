Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr690061.outbound.protection.outlook.com ([40.107.69.61]:47760
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbeHCODg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Aug 2018 10:03:36 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: remove minor version check for 2.0
Date: Fri, 3 Aug 2018 12:07:30 +0000
Message-ID: <7B08AEC1-90F8-4AE0-AE46-BADF8CC8D270@cnexlabs.com>
References: <20180803090237.2022-1-mb@lightnvm.io>
In-Reply-To: <20180803090237.2022-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6BA32728-121A-4EAB-BA22-5F3BDD9FDF5C";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_6BA32728-121A-4EAB-BA22-5F3BDD9FDF5C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 11.02, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> A minor version number increase should not break backwards
> compatibility.
>=20
> Fixes: 3cb98f84d368b ("lightnvm: add minor version to generic =
geometry")
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/nvme/host/lightnvm.c | 6 ------
> 1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index d9e4cccd5b66..a156fe3ca7d3 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -414,12 +414,6 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 =
*id,
> 	/* Set compacted version for upper layers */
> 	geo->version =3D NVM_OCSSD_SPEC_20;
>=20
> -	if (!(geo->major_ver_id =3D=3D 2 && geo->minor_ver_id =3D=3D 0)) =
{
> -		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
> -				geo->major_ver_id, geo->minor_ver_id);
> -		return -EINVAL;
> -	}
> -
> 	geo->num_ch =3D le16_to_cpu(id->num_grp);
> 	geo->num_lun =3D le16_to_cpu(id->num_pu);
> 	geo->all_luns =3D geo->num_ch * geo->num_lun;
> --
> 2.11.0

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_6BA32728-121A-4EAB-BA22-5F3BDD9FDF5C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkRX8ACgkQIX4xUKFR
nnTNehAAhYO4sb3WnD435eBZs+ZQlmEJG631NbXuYcLfxh68eI9Pba6oweQPzIL4
QuYyTJ88g/QUH1okZJFyZF05msQPB4koljZc1KAX8Bjt50zY9MWB9g0IthszT2fS
NjgzUaJjonyD7CZtpwZOPR869D9VrGv3MATrO9+P25VLfwz2VJrLA1C5zDjNZXqA
xqMtQ3tLR3qtmKXvVhWofAqEO1SXk9/i5foQcHLB4yAWpTrGltsCFrGMlhDq+1YC
902UBBpaAZZWOLdkzrmYVD++Rc7OV6gnnmU/5yQJLtEnhMV9Lx9bbkhRm59+JHcq
Pd0VBnxRuFamjMU3CeM6fCZrX4NbR6nXFk1YTsu00iY5r4qGyz+z8WSSlCxF1bsK
q2ZapOnH19LPkNhzcnA/pARa6TDVyllkylEBZIUbs9RSMr4jGkzlhM1V1H/t4oZL
22Nj3d/+kbi2snaV5XuA1S68pVaeLAfElSeICOaVJkj85XBORMiWGMCDN/xqx6Xn
ZLzSvc4C4Do8EDaoUDZHWShDS5kCpcSChAivttONZTLI/ALB6/8JejH7cV9x96kT
rfCX/hBu2+7PedOOt6kZO0Y1ceaEUg5Qq1+2qoGGMCDvBq/Uk6tdieFNjYk14Erv
dllFLF7PhOuWOWk6tg13jZOhbIu2Af+vZJghI1RIxoqC8CGh/SA=
=sVA3
-----END PGP SIGNATURE-----

--Apple-Mail=_6BA32728-121A-4EAB-BA22-5F3BDD9FDF5C--
