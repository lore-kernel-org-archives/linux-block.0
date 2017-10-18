Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:49765 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752711AbdJRHth (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2017 03:49:37 -0400
Received: by mail-wm0-f53.google.com with SMTP id b189so8102520wmd.4
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2017 00:49:36 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <572A88BE-7356-4A3D-BF96-F1653FB0E41A@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1CEA7807-A836-4BF7-B56D-7DD06C9F4938";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: pblk: fix error codes in pblk_submit_read_gc()
Date: Wed, 18 Oct 2017 09:49:33 +0200
In-Reply-To: <20171018074246.nmi75jmrpuu5g74y@mwanda>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20171018074246.nmi75jmrpuu5g74y@mwanda>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_1CEA7807-A836-4BF7-B56D-7DD06C9F4938
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 18 Oct 2017, at 09.42, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>=20
> There is a missing error code if pblk_bio_map_addr() fails.  This
> function used to return NVM_IO_ERR on error and it still returns
> NVM_IO_OK (which is zero) on success, but now it returns negative =
error
> codes on failure.

Good catch. Thanks Dan.

> I decided to use a standard error code and remove the
> reference to NVM_IO_OK so that no one was confused.

It's ok with me. We only use the internal codes NVM_IO_X on the user
data path to know if we need to complete the bio or not (e.g., in case
of a REQ_FLUSH). GC is better off with standard error codes.

>=20
> Fixes: d340121eb770 ("lightnvm: pblk: simplify data validity check on =
GC")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index ca79d8fb3e60..c26f527dbf86 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -528,7 +528,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct =
pblk_gc_rq *gc_rq)
> 	struct bio *bio;
> 	struct nvm_rq rqd;
> 	int data_len;
> -	int ret =3D NVM_IO_OK;
> +	int ret;
>=20
> 	memset(&rqd, 0, sizeof(struct nvm_rq));
>=20
> @@ -561,6 +561,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct =
pblk_gc_rq *gc_rq)
> 						PBLK_VMALLOC_META, =
GFP_KERNEL);
> 	if (IS_ERR(bio)) {
> 		pr_err("pblk: could not allocate GC bio (%lu)\n", =
PTR_ERR(bio));
> +		ret =3D PTR_ERR(bio);
> 		goto err_free_dma;
> 	}
>=20
> @@ -595,7 +596,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct =
pblk_gc_rq *gc_rq)
>=20
> out:
> 	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
> -	return ret;
> +	return 0;
>=20
> err_free_bio:
> 	bio_put(bio);


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_1CEA7807-A836-4BF7-B56D-7DD06C9F4938
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnnB40ACgkQYx8FO3WZ
GMo/HBAAtozLEXDOvx5uzuxvILviaV/rbZB/ILC0Qp/ZvhUZUkNv4TRu6C5E72b2
kSr1ttCwhKkP/4ZOVwKojs4Eczzd9R+/1Rdk/NXYVrEagEnh1ABGz4iD4LoH+Lcn
LbrBknjkjBn97HxDZYSbd1hhKu92ILn7ewvkgtkLOTs4bbCtEMjQLTK3O2aABIeu
+8WbHkzsd6mF9UmLQdTh3MB6QNnbfU0bqIRy/lDeCTpWbXl5+2TeZJBjrGZwDRdd
r/pfCx8Bg+zYbzfLfJyv6UCvteVON9phG8+29u5GhQKovG2ZpTzG1L2SVlYlt1DZ
ofRFLSYy0idPmQGrVgdVjmyS3FdERYObdlTduxS0fS/wc1acFGWefCc6xdAI2OnM
RDrKX6x34YeCrp9qYd4PMnfswENGT0pGGN5dm34ADyVCKBIvEpl7gqa+DlG/g7ZC
17LVJRn6GmCXJLmbHNAeESz9AW1+xJqUzypSwb6MtlW+OMRQVcKcpv2heXWC54dW
DWXtfNbziQ7QT+C3Jvn30PS4m7upjHMPPSjGutz/rPldBpU/RwX6BoCvHixebB25
zFDSBi2G620zowm20OO4OwCgqcq+g+hbwBaGBY1vS8cz33ELmtYgZ5KjPX8Ymy7v
hITqMJ5uys2Tgkcic+nu7WKrAlzTvU2RfGiKkW/ymdyaR0P56U8=
=qt2F
-----END PGP SIGNATURE-----

--Apple-Mail=_1CEA7807-A836-4BF7-B56D-7DD06C9F4938--
