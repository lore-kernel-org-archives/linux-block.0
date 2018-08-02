Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr700086.outbound.protection.outlook.com ([40.107.70.86]:39552
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732270AbeHBPKI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Aug 2018 11:10:08 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: remove dependencies on BLK_DEV_NVME and PCI
Date: Thu, 2 Aug 2018 13:18:53 +0000
Message-ID: <B899AED5-11D4-4ACB-B10B-5C080AC9B882@cnexlabs.com>
References: <20180802110625.12463-1-mb@lightnvm.io>
In-Reply-To: <20180802110625.12463-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D1E0DCC2-711A-4576-A471-453AA1F88B05";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_D1E0DCC2-711A-4576-A471-453AA1F88B05
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 2 Aug 2018, at 13.06, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> No need to force NVMe device driver to be compiled in if the
> lightnvm subsystem is selected. Also no need for PCI to be selected
> as well, as it would be selected by the device driver that hooks into
> the subsystem.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/Kconfig | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
> index 439bf90d084d..a872cd720967 100644
> --- a/drivers/lightnvm/Kconfig
> +++ b/drivers/lightnvm/Kconfig
> @@ -4,8 +4,7 @@
>=20
> menuconfig NVM
> 	bool "Open-Channel SSD target support"
> -	depends on BLOCK && PCI
> -	select BLK_DEV_NVME
> +	depends on BLOCK
> 	help
> 	  Say Y here to get to enable Open-channel SSDs.
>=20
> --
> 2.11.0

Looks like a good dependency cleanup. Though the nvme driver is the
only one that hooks into LigthNVM today, so it will have to be compiled
anyway.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_D1E0DCC2-711A-4576-A471-453AA1F88B05
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltjBLoACgkQIX4xUKFR
nnQgmA//UVT276oGQeV9xzaMVC9heQ90/1ifJqucvUz49ZRgC73j9Fm7kdlwJ08P
hyi1gXUFjCgxa7+3g2nbQqTXrNsIjrtROjPyYa36/99hAqDLqOlQxnjgFO6UFAG1
3+0Rz3hTJGNZRL+SzMlcMc+Qpsk+Ezq6s3sajDQdc5Lx7qq25iF2dH+/1/iGgERW
zZlX1FOA3aQAWaFjXjw8tDCaM2rnH2p/39/Ekq4kk8/0ifOb0oYUtLJQ7F0k/kdH
vgyuejcU4YNfxHvcuITyc82HoR2Z7yZotWHliGpQVpIHwi58VTXbMyTpNGrI3nib
MM57u0HOGWfI6AS6zuJgApQGDa+wfPh7+TVsbMEEwAgV0ICDLJ8MfRVq2FlJ4p/s
bw+blqFglVdelH7NK53P1tBDwnqckJQpUQWCjsBvWKYPqrzgZ4tx/eoRogkiaN1Z
JBdbjfx5/r4hm1MFXuzQLvL7I952jKQNi5MX5Rbur35xyK/DcEgYr4vIHRMzx6TC
KHPx/m28Ce19d//Ey5EmXdhyWzhDbN/UN9ebackYxs85MDmwtP9MCdVPhIiJMneA
VRQL+gc5BIZtDQxhTJYjHN1AP3A0MTM4HTGI+nXseDX2yNeFxjRcg50jIaEJnizA
/0OJ3YmE3S8mMDnBgM89dyODHHSzDSvdo2C6tJSJpiALYfUI8Kg=
=ykDF
-----END PGP SIGNATURE-----

--Apple-Mail=_D1E0DCC2-711A-4576-A471-453AA1F88B05--
