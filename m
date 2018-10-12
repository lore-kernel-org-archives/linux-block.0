Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr680056.outbound.protection.outlook.com ([40.107.68.56]:59642
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbeJLTE6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Oct 2018 15:04:58 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Igor Konopko <igor.j.konopko@intel.com>
CC: "mb@lightnvm.io" <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
Subject: Re: [PATCH 1/5] lightnvm: pblk: Do not reuse DMA memory on partial
 read
Date: Fri, 12 Oct 2018 11:32:50 +0000
Message-ID: <30166CF3-15A5-43A6-BC13-5A98D8F8F23A@cnexlabs.com>
References: <20181005133437.25255-1-igor.j.konopko@intel.com>
 <20181005133437.25255-2-igor.j.konopko@intel.com>
In-Reply-To: <20181005133437.25255-2-igor.j.konopko@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_911BD43D-DA43-47D2-AC46-937C6152FBC7";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_911BD43D-DA43-47D2-AC46-937C6152FBC7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 5 Oct 2018, at 15.34, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently DMA allocated memory is reused on partial read
> path for some internal pblk structs. In preparation for
> dynamic DMA pool sizes we need to change it to kmalloc
> allocated memory.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-read.c | 20 +++++---------------
> drivers/lightnvm/pblk.h      |  2 ++
> 2 files changed, 7 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index d340dece1d00..08f6ebd4bc48 100644
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
> index 0f98ea24ee59..aea09879636f 100644
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
> 2.17.1

The patch looks good but the commit message is a bit confusing, as it
implies that we do specific allocations for the lba and meta lists, when
in reality the patch extends the partial context with a fixed
NVM_MAX_VLBA length.

It would help if you can make this clear on V2

Javier

--Apple-Mail=_911BD43D-DA43-47D2-AC46-937C6152FBC7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlvAhmEACgkQIX4xUKFR
nnRs2BAAnoc0dTuvovZB6cZel0dyH/gn/om1Z57gX2BWfu1A8afjVht9OjnxmoD8
qrYE4iW5pZbbDiS+BenP6GSrz5EfLoPo4wlL9sSNok0zMzsfW3c69Vi3I60yG4ld
uzN3/HkJBH01DT25U/G23wVMVg30IU7mTiwHpG8x2CKWv8gOhZ+2OORCeMUsuGe1
J8BgIMExlyLcxdjtBUr7OVBCGP7oRSs2DMVyxQ2i2sRml2x6uA0jK5W6w8Xv+rqi
UJBE7XvOLJFdylFwNK/9qjNLEiXA/fEld5gGrgyUNTEhse9D2gmXwE71eO9MOfeZ
bmkNKEAAjaf9y8PtoDcnQIHzqu/jW0U3WFXBgpZqdTKunHyRoGSfojXEY2M15C/+
b/4Kf2QBurEn3NGrhqSG6yHwRU4l4IihFYewb4T3PomVug70tjh9yNfUo9VRHxGl
7VUO/E8ItWsdeEChHfbEI9GH7Y5bdQ6Kg2iqPaYp8h7PLAWEBdBREGHaMi30J6J5
gun/e9P1t2BEJc0CYxFUPWXn6fEZC/CZd832UzQ3cMa5gaSUAJ3snaGUOdVQZsDa
EKvwF4CeTsqyZv2NPsr6cRhxlAOQSDAURXWz8TSFYGSOBUv+5HPkPi9QXNHuU+7L
7dCkbD1DaSzUjiTfwFpYjggTyyhDA7K6Uk5dJ33yaEmUbWESwuc=
=0b7/
-----END PGP SIGNATURE-----

--Apple-Mail=_911BD43D-DA43-47D2-AC46-937C6152FBC7--
