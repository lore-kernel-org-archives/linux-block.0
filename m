Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0060.outbound.protection.outlook.com ([104.47.32.60]:44032
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753979AbeFLOgq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jun 2018 10:36:46 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: limit get chk meta request size
Date: Tue, 12 Jun 2018 14:36:42 +0000
Message-ID: <D7A9D9EC-6182-421C-9A74-C03598483F16@cnexlabs.com>
References: <20180612103008.19436-1-mb@lightnvm.io>
In-Reply-To: <20180612103008.19436-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_A3A1AA09-F5B8-4F74-94DB-61857C4BD37B";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_A3A1AA09-F5B8-4F74-94DB-61857C4BD37B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 12 Jun 2018, at 03.30, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> For devices that does not specify a limit on its transfer size, the
> get_chk_meta command may send down a single I/O retrieving the full
> chunk metadata table. Resulting in large 2-4MB I/O requests. Instead,
> split up the I/Os to a maximum of 256KB and issue them separately to
> improve I/O latency.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/nvme/host/lightnvm.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index b9989717418d..3b644b0e9713 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -583,7 +583,13 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev =
*ndev,
> 	struct ppa_addr ppa;
> 	size_t left =3D nchks * sizeof(struct nvme_nvm_chk_meta);
> 	size_t log_pos, offset, len;
> -	int ret, i;
> +	int ret, i, max_len;
> +
> +	/*
> +	 * limit requests to maximum 256K to avoid issuing arbitrary =
large
> +	 * requests when the device does not specific a maximum transfer =
size.
> +	 */
> +	max_len =3D min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * =
1024);
>=20
> 	/* Normalize lba address space to obtain log offset */
> 	ppa.ppa =3D slba;
> @@ -596,7 +602,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev =
*ndev,
> 	offset =3D log_pos * sizeof(struct nvme_nvm_chk_meta);
>=20
> 	while (left) {
> -		len =3D min_t(unsigned int, left, ctrl->max_hw_sectors =
<< 9);
> +		len =3D min_t(unsigned int, left, max_len);
>=20
> 		ret =3D nvme_get_log_ext(ctrl, ns, =
NVME_NVM_LOG_REPORT_CHUNK,
> 				dev_meta, len, offset);
> --
> 2.11.0

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_A3A1AA09-F5B8-4F74-94DB-61857C4BD37B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsf2ncACgkQIX4xUKFR
nnR53BAArw+N/V/M+tkKTo/6nwccBX3v3xjUfluFb0KZpHgjbnCcL7/zQVZAsaXY
hjRqshku+3hOiil7JZewDis6YvKcdJdKUBYiDZ0dh1YeNJ8yPjFqavwI4JtNZZQ2
B+gAuUBghcZ8C5dcWK6KK7FCJjuB8PCzp2zCdtD4L3USGtgAW+vv3faTsIb+YL58
xf7V4ekdwr+9UFXNTXqLA+YWjaI38s/JyYHNbJ8Jn2UAm4XCisCTA0HLWoc9JDyR
DwmZtomzwT73GvFb4GpuHI1Vu2uA8+zJ6dDFcPt61cxuuE7rywCBupNt9ROX5SjG
5uiwq+obXOlEaFfs+qVe5TAgvQ8K9011aBItCfdpqbAwWPHuvptr2spZWMRklqX9
hdsE8K70RxGKGWmIJVScjyZCrjuU30d0ipcn8GngpEwNAQTQ6GC+kvJeGw4e+e6U
Mg5UXxoJnhgThL/PZ/5hnpnnIF39M6N7qKItgc1wOuleLRXDjJCb6LXPeuUEW4G6
0V3z/rZG1T0r2TmS/6UPgjajwZZNnC8++EdcWk/pJC+HnJ4ZWxVQd+iolXf6l16r
TIHj6sOQwn5z9H2SlrUiu6Eid3t7ZkB1rQuwsdFhSMKcKwxHQT2J7JpdegY6B1xi
OvQne/sQiY7A/8vFq+9vIfrVCKmsvJESG9KgVv9W10NsQl1llZs=
=Dw7H
-----END PGP SIGNATURE-----

--Apple-Mail=_A3A1AA09-F5B8-4F74-94DB-61857C4BD37B--
