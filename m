Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0088.outbound.protection.outlook.com ([104.47.42.88]:55568
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933094AbeF1Hhk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jun 2018 03:37:40 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: fix read_bitmap for 32bit archs
Date: Thu, 28 Jun 2018 07:37:30 +0000
Message-ID: <53E32769-D1CC-4EDF-BCB7-4D53DBD6A5A2@cnexlabs.com>
References: <20180627194206.30384-1-mb@lightnvm.io>
In-Reply-To: <20180627194206.30384-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4CEFB2F5-A288-43FC-8858-94EFF19D6FBC";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_4CEFB2F5-A288-43FC-8858-94EFF19D6FBC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Jun 2018, at 21.42, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> If using pblk on a 32bit architecture, and there is a need to
> perform a partial read, the partial read bitmap will only have
> allocated 32 entries, where as 64 are needed.
>=20
> Make sure that the read_bitmap is initialized to 64bits on 32bit
> architectures as well.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-read.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 6e93c489ce57..671635275d56 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -401,7 +401,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio =
*bio)
> 	struct pblk_g_ctx *r_ctx;
> 	struct nvm_rq *rqd;
> 	unsigned int bio_init_idx;
> -	unsigned long read_bitmap; /* Max 64 ppas per request */
> +	DECLARE_BITMAP(read_bitmap, 64); /* Max 64 ppas per request */

When we removed max_hx_sect we added a constant (NVM_MAX_VLBA). Use this
instead? Now I see Igor already commented on this...

> 	int ret =3D NVM_IO_ERR;
>=20
> 	/* logic error: lba out-of-bounds. Ignore read request */
> @@ -413,7 +413,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio =
*bio)
>=20
> 	generic_start_io_acct(q, READ, bio_sectors(bio), =
&pblk->disk->part0);
>=20
> -	bitmap_zero(&read_bitmap, nr_secs);
> +	bitmap_zero(read_bitmap, nr_secs);
>=20
> 	rqd =3D pblk_alloc_rqd(pblk, PBLK_READ);
>=20
> @@ -444,19 +444,19 @@ int pblk_submit_read(struct pblk *pblk, struct =
bio *bio)
> 		rqd->ppa_list =3D rqd->meta_list + pblk_dma_meta_size;
> 		rqd->dma_ppa_list =3D rqd->dma_meta_list + =
pblk_dma_meta_size;
>=20
> -		pblk_read_ppalist_rq(pblk, rqd, bio, blba, =
&read_bitmap);
> +		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
> 	} else {
> -		pblk_read_rq(pblk, rqd, bio, blba, &read_bitmap);
> +		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
> 	}
>=20
> -	if (bitmap_full(&read_bitmap, nr_secs)) {
> +	if (bitmap_full(read_bitmap, nr_secs)) {
> 		atomic_inc(&pblk->inflight_io);
> 		__pblk_end_io_read(pblk, rqd, false);
> 		return NVM_IO_DONE;
> 	}
>=20
> 	/* All sectors are to be read from the device */
> -	if (bitmap_empty(&read_bitmap, rqd->nr_ppas)) {
> +	if (bitmap_empty(read_bitmap, rqd->nr_ppas)) {
> 		struct bio *int_bio =3D NULL;
>=20
> 		/* Clone read bio to deal with read errors internally */
> @@ -480,7 +480,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio =
*bio)
> 	/* The read bio request could be partially filled by the write =
buffer,
> 	 * but there are some holes that need to be read from the drive.
> 	 */
> -	return pblk_partial_read(pblk, rqd, bio, bio_init_idx, =
&read_bitmap);
> +	return pblk_partial_read(pblk, rqd, bio, bio_init_idx, =
read_bitmap);
>=20
> fail_rqd_free:
> 	pblk_free_rqd(pblk, rqd, PBLK_READ);
> --
> 2.11.0

Thanks for fixing it.


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_4CEFB2F5-A288-43FC-8858-94EFF19D6FBC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAls0kDIACgkQIX4xUKFR
nnRM8A/+NhRiFYOLmzpZ8YWr9s6KsYoHqF6zL3alzgsjn2MQFSd11tNJzDXE/miW
nRXr2NRjMx48rCxR4QM9CpeG7TVIY1JSsdZ0g28rA/wYGloc8abCpssl9NZAG2hU
d+7dDvE+//JChMddYKYhr/autIB+AUg1w1R0oJXiVFQ5bLc/MrzNbEOcKOUqi+Zq
G9hixFNHnRqtxPfp4myFlydKokh9vnaGq7bANCUCjmJ+Tnr7Ma+12FiN7busqNjK
NlOKmy+XlyfJNI4bFKFgmNllnT04Np7s1hmxEMyMEsMT07vtgfnIv9myGZGsf50g
KOUmpExV1tPWtzpjJ259uq3VPVA5v5I8ipsh0vHwh28aJ3t0AK0xfYxgC6qdpfnO
h8hHtpMUNZInvqiCU0oKw8HlSDiPuJGYv8CbxQAxnKT3BZQH1sM5M22mLKIc/eZ6
3Mh0ITK0nM5iLd7Mx5on+nwfKy9ps+EVHHM/di+wAAF8tq0YzcJ5J5VhHk+aJJqO
aDbi7/JvYBucI/2gpjM8ehc/eOgsBnwIfaLneE5V8sN8gg0AmFDqBsWjVfUNjGCd
TWMKiFE3zPOAdWmwbXMTmYk0KOKPAOh5wbfjPStjeHCdUKH3rWGj/vVRecgKAA/1
LsHGDye+wEf81GamVRkgFGELqaFYduWRErupDR3+1doSlYSEETY=
=doTg
-----END PGP SIGNATURE-----

--Apple-Mail=_4CEFB2F5-A288-43FC-8858-94EFF19D6FBC--
