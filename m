Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0068.outbound.protection.outlook.com ([104.47.41.68]:27005
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727708AbeIFRxt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Sep 2018 13:53:49 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] lightnvm: pblk-recovery: lightnvm: pblk: Fix two
 sleep-in-atomic-context bugs
Date: Thu, 6 Sep 2018 13:18:15 +0000
Message-ID: <4FEA8984-5E08-44E1-9E5C-03A6516AF7F6@cnexlabs.com>
References: <20180905084017.27593-1-baijiaju1990@gmail.com>
In-Reply-To: <20180905084017.27593-1-baijiaju1990@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C094016C-30C4-4EC1-BC7A-5E402DAB2C9A";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_C094016C-30C4-4EC1-BC7A-5E402DAB2C9A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Sep 2018, at 01.40, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>=20
> The driver may sleep with holding a spinlock.
>=20
> The function call paths (from bottom to top) in Linux-4.16 are:
>=20
> [FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
> drivers/lightnvm/pblk-core.c, 754:
> 	nvm_dev_dma_alloc in pblk_line_submit_smeta_io
> drivers/lightnvm/pblk-core.c, 1048:
> 	pblk_line_submit_smeta_io in pblk_line_init_bb
> drivers/lightnvm/pblk-core.c, 1434:
> 	pblk_line_init_bb in pblk_line_replace_data
> drivers/lightnvm/pblk-recovery.c, 980:
> 	pblk_line_replace_data in pblk_recov_l2p
> drivers/lightnvm/pblk-recovery.c, 976:
> 	spin_lock in pblk_recov_l2p
>=20
> [FUNC] bio_map_kern(GFP_KERNEL)
> drivers/lightnvm/pblk-core.c, 762:
> 	bio_map_kern in pblk_line_submit_smeta_io
> drivers/lightnvm/pblk-core.c, 1048:
> 	pblk_line_submit_smeta_io in pblk_line_init_bb
> drivers/lightnvm/pblk-core.c, 1434:
> 	pblk_line_init_bb in pblk_line_replace_data
> drivers/lightnvm/pblk-recovery.c, 980:
> 	pblk_line_replace_data in pblk_recov_l2p
> drivers/lightnvm/pblk-recovery.c, 976:
> 	spin_lock in pblk_recov_l2p
>=20
> To fix these bugs, the call to pblk_line_replace_data()
> is moved out of the spinlock protection.
>=20
> These bugs are found by my static analysis tool DSAC.
>=20
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> v2:
> * Move the call to pblk_line_replace_data() out of the spinlock
>  protection, instead of v1 that changes GFP_KERNEL to GFP_ATOMIC in
>  the calls to bio_map_kern() and nvm_dev_dma_alloc().
>  Thanks Javier for good advice.
> ---
> drivers/lightnvm/pblk-recovery.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 3a5069183859..5fde414d78bb 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -955,12 +955,14 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
> 		}
> 	}
>=20
> -	spin_lock(&l_mg->free_lock);
> 	if (!open_lines) {
> +		spin_lock(&l_mg->free_lock);
> 		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
> 							=
&l_mg->meta_bitmap));
> +		spin_unlock(&l_mg->free_lock);
> 		pblk_line_replace_data(pblk);
> 	} else {
> +		spin_lock(&l_mg->free_lock);
> 		/* Allocate next line for preparation */
> 		l_mg->data_next =3D pblk_line_get(pblk);
> 		if (l_mg->data_next) {
> @@ -968,8 +970,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
> 			l_mg->data_next->type =3D PBLK_LINETYPE_DATA;
> 			is_next =3D 1;
> 		}
> +		spin_unlock(&l_mg->free_lock);
> 	}
> -	spin_unlock(&l_mg->free_lock);
>=20
> 	if (is_next)
> 		pblk_line_erase(pblk, l_mg->data_next);
> --
> 2.17.0

It looks good to me. Thanks Jia-Ju.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_C094016C-30C4-4EC1-BC7A-5E402DAB2C9A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluRKR8ACgkQIX4xUKFR
nnQFkhAAvP4midbMvRza2U1VfCsqQCUNa8O5AEblpZ3G4SJiU4N9Z9E+I5BMS+N3
5w7Ajku9kBkycCcGV36SOyIgVaSoOEa78c7UJat/+Gj+ZvNsDRlILCcDvNl+ek0g
TqyG7SPXSz5iBL/sDqWw1ZSEpkEQBLhF44WS8Mt/mxIUZNDufz6/9UZpBOaCmo41
a2fRHmTpmKMVG2GOAVM18O1PAyNarS0pcPYKVoFMO6wpIoCd8dF9bOf4RUh+qLwJ
5T1m3Buv1QYW89o+dhjnrq6baRt4r581SBAw3GU1WQRd5HA6BJvqNLcd2Z9S8NJe
+HJymfNoKGstFTH5blP3OsuxedG4OnLODEIFTTOZNE8Y3AFpmTR0xxrbN+I8x1qA
jgEh6QvFwpZ4VW7HuvvfyOjmNcULd0IdSZGcO4XW8vOblA4CPAPLuubsPxvcaL49
gbPM18zpYe8WQXyhvEQoWrNfE0DH3wUm3UUBU+y+i6RDlACjqmgVzTg96z6wAkYz
fwkvtEsjYsRiDpbDf22SZ2DPb7bipoGM5guRwYBhE2FsKvodhpiMKo8lR1PEwOlF
nd2DYjUiYMURTyl7t3BmJeiw1bH2ip2IWwPNi3MgnPpxoWF7djauF/rc6mugVHUI
0riBqh+Z4+/RiBpqSFlhxubD+2DGH50wR7fFfvDpCfOSCbU6BgI=
=R6h9
-----END PGP SIGNATURE-----

--Apple-Mail=_C094016C-30C4-4EC1-BC7A-5E402DAB2C9A--
