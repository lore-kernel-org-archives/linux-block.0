Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0058.outbound.protection.outlook.com ([104.47.32.58]:43648
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728950AbeJ2VGW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Oct 2018 17:06:22 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: "Konopko, Igor J" <igor.j.konopko@intel.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "hans.ml.holmberg@owltronix.com" <hans.ml.holmberg@owltronix.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] lightnvm: Disable interleaved metadata
Date: Mon, 29 Oct 2018 12:17:53 +0000
Message-ID: <CB9DC8EC-A581-4858-825B-A6F5B9FDA229@cnexlabs.com>
References: <20181022103611.39271-1-igor.j.konopko@intel.com>
 <20181022103611.39271-5-igor.j.konopko@intel.com>
In-Reply-To: <20181022103611.39271-5-igor.j.konopko@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_655AA39B-431A-439E-8A1A-38145B645060";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_655AA39B-431A-439E-8A1A-38145B645060
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Oct 2018, at 12.36, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently pblk and lightnvm does only check for size
> of OOB metadata and does not care wheather this meta
> is located in separate buffer or is interleaved with
> data in single buffer.
>=20
> In reality only the first scenario is supported, where
> second mode will break pblk functionality during any
> IO operation.
>=20
> The goal of this patch is to block creation of pblk
> devices in case of interleaved metadata
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-init.c | 6 ++++++
> drivers/nvme/host/lightnvm.c | 1 +
> include/linux/lightnvm.h     | 1 +
> 3 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 13822594647c..ded0618f6cda 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1154,6 +1154,12 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
> 		return ERR_PTR(-EINVAL);
> 	}
>=20
> +	if (geo->ext) {
> +		pblk_err(pblk, "extended metadata not supported\n");
> +		kfree(pblk);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> 	spin_lock_init(&pblk->resubmit_lock);
> 	spin_lock_init(&pblk->trans_lock);
> 	spin_lock_init(&pblk->lock);
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index d1e47a93bcfd..b71c730a6e32 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -983,6 +983,7 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>=20
> 	geo->csecs =3D 1 << ns->lba_shift;
> 	geo->sos =3D ns->ms;
> +	geo->ext =3D ns->ext;
>=20
> 	if (nvm_realloc_dma_pool(ndev))
> 		nvm_unregister(ndev);
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 9d3b7c627cac..4870022ebff1 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -357,6 +357,7 @@ struct nvm_geo {
> 	u32	clba;		/* sectors per chunk */
> 	u16	csecs;		/* sector size */
> 	u16	sos;		/* out-of-band area size */
> +	bool	ext;		/* metadata in extended data buffer */
>=20
> 	/* device write constrains */
> 	u32	ws_min;		/* minimum write size */
> --
> 2.14.4

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_655AA39B-431A-439E-8A1A-38145B645060
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlvW+m8ACgkQIX4xUKFR
nnRo0A//bjtl9UNGU06xWpyl/NtbFQuFPdIUqmTM8SX0l0W/2V5Kc/X16EMHEL6W
x47qBbGNJckwOHuMwKhajaNdQFk/BdbWZPhfc0jaxAjPipoocrI1SN+deZKFzTIx
kl6dG8cWDsX1MpC5cjM3NQDA/VEzULjJu1WlXoTiCAppmVg5LCOCUxbSPqB5ccAA
gLuv2YA8WurgPbnkDoXRN5QKq3UzlSp3KWa9/gRWlR7qM7w5Gd9IHbl3/xsBIn2J
av/o5Ab82A91vv6Lc1t+TbVTmyX1mdVge1aMQcgv3vQBwiJr9FDIJIPPlpzlJ1NY
zh7s+ngaOxG67oUePpf9YMVpWB9b8F26HYUGvT3ljMx4E1bLr2x97dxQvmBGNOeY
CblZmHsIzfpF+ErFo+NYDBTVaHusdhljy0mtPA20NAZN3eIF42/xmEca2wF7owy+
doyhNyLS3GfoKInGgXqvYxcoDnKitx/EOzmWowHannyooycauNOjCtoiJjcDcghT
6znXRDrvJoRBOqs+CmzzHkk6ga6KaIZqQfZLBI4vFD9kfXikj9TuSSeNtG8XsP4i
u1iUWMFk9Or2itN/rEM4KqHSMKh0AOVpF6iO9wuDA86VXdiFyW7NhY6luBXIxr1h
By2ms2RB854y8zw+2yKu0TpgPMQm4wtYSp3efMo6ZS+mjLUeYkA=
=7hba
-----END PGP SIGNATURE-----

--Apple-Mail=_655AA39B-431A-439E-8A1A-38145B645060--
