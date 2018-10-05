Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36224 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeJEPC7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Oct 2018 11:02:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id c26-v6so3165656edt.3
        for <linux-block@vger.kernel.org>; Fri, 05 Oct 2018 01:05:24 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <93D74649-8C00-479C-9273-C19969F44C8F@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_14792325-C871-40DA-867A-44758E42053D";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] lightnvm: consider max hw sectors supported for
 max_write_pgs
Date: Fri, 5 Oct 2018 10:05:21 +0200
In-Reply-To: <1538699190-4857-1-git-send-email-zjwu@marvell.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, hongd@marvell.com
To: Zhoujie Wu <zjwu@marvell.com>
References: <1538699190-4857-1-git-send-email-zjwu@marvell.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_14792325-C871-40DA-867A-44758E42053D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Oct 2018, at 02.26, Zhoujie Wu <zjwu@marvell.com> wrote:
>=20
> When do GC, the number of read/write sectors are determined
> by max_write_pgs(see gc_rq preparation in pblk_gc_line_prepare_ws).
>=20
> Due to max_write_pgs doesn't consider max hw sectors
> supported by nvme controller(128K), which leads to GC
> tries to read 64 * 4K in one command, and see below error
> caused by pblk_bio_map_addr in function pblk_submit_read_gc.
>=20
> [ 2923.005376] pblk: could not add page to bio
> [ 2923.005377] pblk: could not allocate GC bio (18446744073709551604)
>=20
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> ---
> drivers/lightnvm/pblk-init.c | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index e357388..2e51875 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -393,6 +393,7 @@ static int pblk_core_init(struct pblk *pblk)
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	int ret, max_write_ppas;
> +	struct request_queue *bqueue =3D dev->q;
>=20

Detail: Can you move this under struct nvm_tgt_dev *dev =3D pblk->dev;? =
So
that we maintain ordering?

> 	atomic64_set(&pblk->user_wa, 0);
> 	atomic64_set(&pblk->pad_wa, 0);
> @@ -407,6 +408,9 @@ static int pblk_core_init(struct pblk *pblk)
> 	pblk->min_write_pgs =3D geo->ws_opt;
> 	max_write_ppas =3D pblk->min_write_pgs * geo->all_luns;
> 	pblk->max_write_pgs =3D min_t(int, max_write_ppas, =
NVM_MAX_VLBA);
> +	/* consider the max hw sector as well */

No need for this comment.

> +	pblk->max_write_pgs =3D  min_t(int, pblk->max_write_pgs,
> +		queue_max_hw_sectors(bqueue) / (geo->csecs >> 9));
> 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>=20
> 	pblk->pad_dist =3D kcalloc(pblk->min_write_pgs - 1, =
sizeof(atomic64_t),
> --
> 1.9.1

Besides the comment above, it looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_14792325-C871-40DA-867A-44758E42053D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlu3G0EACgkQPEYBfS0l
eOCJBxAAy1Jhh39i53Uab/BnHshwaIhU0im4d0ntxWo+QHdXE+E+FtbGcjbaGWUD
nbaOG2+k5qoHO5UPJdtmv5gnlzkmvOFulxUxFBYUTx1ptKq2o3o8T2UCA6U+4Ake
IfDhFSy0+Q4aLBHToWh8iLx1d9Y6oZ+AXS+DO3s7II9Geh+70XMLqcm982YQG8hx
RNnU8LgULIf8D6+NFI4zneH3aPcbb50bsq85vB5pOProgruAAruPhweVp4jc0uQ1
iP+QAbYuEmgRZC4/3ynLNORVMOqeCzgSM5z3xeNn8Tyi3+ZwH48WRC5fqrtxSgCs
UfB8AGC8veKYy7035CPLsqTxbSy/y8FlPE69R6m4JCKY5z+1XJPttllAwsk8ZXg9
VpUQEVRU9zTpLO22LsLYNJ2yLOFIxPf66FxLs17YoHNeJJdjmCQUJP7AeHgTeAu0
ku4XUf/nJUAZP0Hr0R5flJbhRqczKY9LxkjQEHLwMcgzLY4asdjVrUMfLjQEDFjq
duln4ruz9YcKLRr8Sijm26ESBwWeF8PyHLJtJg+kFUTWXJNlBGe4ItDgqtbN8Gc0
5hVaMiGSEh18E8p6cjLMNQ0CQhtwgUiVym3CkqhClX9+u7znggfXG9dgXqxKku4y
wjWXG/GQJ9J4Hj5B6Z7oUnZCwDg/zlyZWYMWs/12CaY0LJ1uhtY=
=EAeu
-----END PGP SIGNATURE-----

--Apple-Mail=_14792325-C871-40DA-867A-44758E42053D--
