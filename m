Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2nam02on0045.outbound.protection.outlook.com ([104.47.38.45]:34956
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752189AbeDQJ0h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Apr 2018 05:26:37 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Wei Xu <wxu@cnexlabs.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: lightnvm: add granby support
Date: Tue, 17 Apr 2018 09:26:29 +0000
Message-ID: <C98EF5A1-0836-40B8-BEDD-8D66C0820257@cnexlabs.com>
References: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
In-Reply-To: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6192595E-A48C-4546-8A74-AAB6CB9E9072";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_6192595E-A48C-4546-8A74-AAB6CB9E9072
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Apr 2018, at 03.55, Wei Xu <wxu@cnexlabs.com> wrote:
>=20
> Add a new lightnvm quirk to identify CNEX=E2=80=99s Granby controller.
>=20
> Signed-off-by: Wei Xu <wxu@cnexlabs.com>
> ---
> drivers/nvme/host/pci.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cb73bc8..9419e88 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2529,6 +2529,8 @@ static const struct pci_device_id =
nvme_id_table[] =3D {
> 		.driver_data =3D NVME_QUIRK_LIGHTNVM, },
> 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
> 		.driver_data =3D NVME_QUIRK_LIGHTNVM, },
> +	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
> +		.driver_data =3D NVME_QUIRK_LIGHTNVM, },
> 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
> 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
> 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
> --
> 2.7.4


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_6192595E-A48C-4546-8A74-AAB6CB9E9072
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlrVvcMACgkQIX4xUKFR
nnTUexAA3+L+MAjO8TdarE2VZBqkQ3s+yvRuFkVyi0EGGhSvxqrRz+uyXra2ZShG
uCe3rqhy/kc2xvfa7TOzisL1lbyIz/Yl/HQV2aHczSAgH7x4ik8JQcq5GcBjd40X
P5UBjz2XZJKBd18U3XDWwpcQU0y9WlJ7GOYmym7sNy01PeGWUjbYX9cZPcBpmLo2
kxRci2IkbnNJZAW+LN8WJ/FdMeIktXhVXvjXjVp7N6gXZ7KSwffPimIiZLbl4Krd
tcp+BZ3CMTZLA5l+9OryPGx4EQJIbtf8ggBtUrgt93P0Uc0Huf37fsbrEb+q6CiN
2L5OFnsqvK258YZaX5jE1gx3AcZT025MDomv7c5z5TW6OsRN4RMN9+MzAYSybFDg
3P/akt8lebLw+V0Z4JeR757PY+cEzNt85AU6Eyk1jPQTSZmO6PY6D/51JFfaKxlY
bf0hhOK2sDAZMP04FU1fqwrT3tvNBRCiAdACFVLTd3O2rtp/EeJlz/bkrl4leF8g
uTCLOfooeseICHGXHalW9Ky7zaYt3CYcgDWzPFpzvgjCU1qGSr69pp9pn9Xy6csU
4LeGY0YZ0u4Y0Tz9ztTVsoDzOoQ9ScJFE9fi3JaPV5sUZXqs+RE2s2tviZXS8+uW
kJNAjJRro0Kz52UOgIgWcLguB6qBBaMwlNfZywQE874/KVPVreI=
=kyh3
-----END PGP SIGNATURE-----

--Apple-Mail=_6192595E-A48C-4546-8A74-AAB6CB9E9072--
