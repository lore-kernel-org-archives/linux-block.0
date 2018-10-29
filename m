Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0063.outbound.protection.outlook.com ([104.47.41.63]:6074
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729459AbeJ2Sjc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Oct 2018 14:39:32 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: "Konopko, Igor J" <igor.j.konopko@intel.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] lightnvm: pblk: Move lba list to partial read
 context
Date: Mon, 29 Oct 2018 09:51:33 +0000
Message-ID: <DA401113-E529-4803-9877-22462557FEB9@cnexlabs.com>
References: <20181022103611.39271-1-igor.j.konopko@intel.com>
 <20181022103611.39271-2-igor.j.konopko@intel.com>
In-Reply-To: <20181022103611.39271-2-igor.j.konopko@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_CD40B27D-6CE7-43FD-B12F-6204E9F946CE";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_CD40B27D-6CE7-43FD-B12F-6204E9F946CE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Oct 2018, at 12.36, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently DMA allocated memory is reused on partial read
> for lba_list_mem and lba_list_media arrays. In preparation
> for dynamic DMA pool sizes we need to move this arrays
> into pblk_pr_ctx structures.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-read.c | 20 +++++---------------
> drivers/lightnvm/pblk.h      |  2 ++
> 2 files changed, 7 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 9fba614adeeb..19917d3c19b3 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -224,7 +224,6 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 	unsigned long *read_bitmap =3D pr_ctx->bitmap;
> 	int nr_secs =3D pr_ctx->orig_nr_secs;
> 	int nr_holes =3D nr_secs - bitmap_weight(read_bitmap, nr_secs);
> -	__le64 *lba_list_mem, *lba_list_media;
> 	void *src_p, *dst_p;
> 	int hole, i;
>=20
> @@ -237,13 +236,9 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 		rqd->ppa_list[0] =3D ppa;
> 	}
>=20
> -	/* Re-use allocated memory for intermediate lbas */
> -	lba_list_mem =3D (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
> -	lba_list_media =3D (((void *)rqd->ppa_list) + 2 * =
pblk_dma_ppa_size);
> -
> 	for (i =3D 0; i < nr_secs; i++) {
> -		lba_list_media[i] =3D meta_list[i].lba;
> -		meta_list[i].lba =3D lba_list_mem[i];
> +		pr_ctx->lba_list_media[i] =3D meta_list[i].lba;
> +		meta_list[i].lba =3D pr_ctx->lba_list_mem[i];
> 	}
>=20
> 	/* Fill the holes in the original bio */
> @@ -255,7 +250,7 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 		line =3D pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
> 		kref_put(&line->ref, pblk_line_put);
>=20
> -		meta_list[hole].lba =3D lba_list_media[i];
> +		meta_list[hole].lba =3D pr_ctx->lba_list_media[i];
>=20
> 		src_bv =3D new_bio->bi_io_vec[i++];
> 		dst_bv =3D bio->bi_io_vec[bio_init_idx + hole];
> @@ -295,13 +290,9 @@ static int pblk_setup_partial_read(struct pblk =
*pblk, struct nvm_rq *rqd,
> 	struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> 	struct pblk_pr_ctx *pr_ctx;
> 	struct bio *new_bio, *bio =3D r_ctx->private;
> -	__le64 *lba_list_mem;
> 	int nr_secs =3D rqd->nr_ppas;
> 	int i;
>=20
> -	/* Re-use allocated memory for intermediate lbas */
> -	lba_list_mem =3D (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
> -
> 	new_bio =3D bio_alloc(GFP_KERNEL, nr_holes);
>=20
> 	if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
> @@ -312,12 +303,12 @@ static int pblk_setup_partial_read(struct pblk =
*pblk, struct nvm_rq *rqd,
> 		goto fail_free_pages;
> 	}
>=20
> -	pr_ctx =3D kmalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
> +	pr_ctx =3D kzalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
> 	if (!pr_ctx)
> 		goto fail_free_pages;
>=20
> 	for (i =3D 0; i < nr_secs; i++)
> -		lba_list_mem[i] =3D meta_list[i].lba;
> +		pr_ctx->lba_list_mem[i] =3D meta_list[i].lba;
>=20
> 	new_bio->bi_iter.bi_sector =3D 0; /* internal bio */
> 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
> @@ -325,7 +316,6 @@ static int pblk_setup_partial_read(struct pblk =
*pblk, struct nvm_rq *rqd,
> 	rqd->bio =3D new_bio;
> 	rqd->nr_ppas =3D nr_holes;
>=20
> -	pr_ctx->ppa_ptr =3D NULL;
> 	pr_ctx->orig_bio =3D bio;
> 	bitmap_copy(pr_ctx->bitmap, read_bitmap, NVM_MAX_VLBA);
> 	pr_ctx->bio_init_idx =3D bio_init_idx;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 02bb2e98f8a9..2aca840c7838 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -132,6 +132,8 @@ struct pblk_pr_ctx {
> 	unsigned int bio_init_idx;
> 	void *ppa_ptr;
> 	dma_addr_t dma_ppa_list;
> +	__le64 lba_list_mem[NVM_MAX_VLBA];
> +	__le64 lba_list_media[NVM_MAX_VLBA];
> };
>=20
> /* Pad context */
> --
> 2.14.4


Looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_CD40B27D-6CE7-43FD-B12F-6204E9F946CE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlvW2CQACgkQIX4xUKFR
nnSVMA/9FhU/hnOdzkoUXNjXsJ0Jm0kJh55FDv+bgGv+Mjigp0ZuRGn2mF8ZVD9U
wrETmSLK1uXKFM1L8GrkNKMDx9nNLTYtPH7Yko2z401eva5LzMXJuP4YGa4BwdPU
AQ5Hc6eGrZUc26P74mJCd59yvagD0zehSn79MtoVrHZDfmRA99QrbesnIRwNWS91
5P3K+N2OtWN8DjoUSL6sY11eSkez7TvDdtXug/6Rt+wXWZNb5fL46K29w9ZuBNlO
WBlCeEYT7Hk5u4L7oNqJtIn57cxRfTE0qq//qIrLYNiJAiTUUwfcrPqZYJ2zjDDS
Ge2yu+EtYY7DX/6SMVz197DrHSV5U4IXwVinPUklLLAwOgY8Qi0uPKdAN48bGqCa
TS29/VHMQ6RRpkr+0TuafdSvypWGXXQbk+6Pk+RnXGNTobJeRFaRlIm3Gl18Rk2L
Q45pRMDYuYly3akxudTIFs4YHrGlwpM0WWNSxa8vITv1KSTDuNueOimID9sbSdm3
C8m4ElHFm1sTHHQeXookc0GlVmf8TdxDhWJI8vmKXZ6OCgW+MjdU2Zp4VOflYnQO
7DqQAZldZv1NVILcz+VkFaAufH/YgYtAmpHKwAIPAyyP5YLgMWS5defAd4stMZ9C
YKmx0gSS8JL7HZntmPz2/mTsWMkG+2NiJkTEaHyfMBNkWVer4Uk=
=rL2+
-----END PGP SIGNATURE-----

--Apple-Mail=_CD40B27D-6CE7-43FD-B12F-6204E9F946CE--
