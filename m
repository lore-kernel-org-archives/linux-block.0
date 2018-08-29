Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr720043.outbound.protection.outlook.com ([40.107.72.43]:11881
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbeH3ARS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 20:17:18 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC: =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH 4/4] lightnvm: pblk: add tracing for chunk resets
Date: Wed, 29 Aug 2018 20:09:38 +0000
Message-ID: <AE72A23A-F779-466B-89A7-846A232DD9B2@cnexlabs.com>
References: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1535545877-770-5-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1535545877-770-5-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_CB620C91-DF80-4D28-A9CE-FA7AA977389B";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_CB620C91-DF80-4D28-A9CE-FA7AA977389B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 29 Aug 2018, at 14.31, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> Trace state of chunk resets.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-core.c  | 12 ++++++++++++
> drivers/lightnvm/pblk-trace.h | 31 +++++++++++++++++++++++++++++++
> drivers/lightnvm/pblk.h       |  6 ++++++
> 3 files changed, 49 insertions(+)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 566a5d3165ee..b874001d1175 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -90,9 +90,15 @@ static void __pblk_end_io_erase(struct pblk *pblk, =
struct nvm_rq *rqd)
> 	atomic_dec(&line->left_seblks);
>=20
> 	if (rqd->error) {
> +		trace_pblk_chunk_reset(pblk_disk_name(pblk),
> +				&rqd->ppa_addr, =
PBLK_CHUNK_RESET_FAILED);
> +
> 		chunk->state =3D NVM_CHK_ST_OFFLINE;
> 		pblk_mark_bb(pblk, line, rqd->ppa_addr);
> 	} else {
> +		trace_pblk_chunk_reset(pblk_disk_name(pblk),
> +				&rqd->ppa_addr, PBLK_CHUNK_RESET_DONE);
> +
> 		chunk->state =3D NVM_CHK_ST_FREE;
> 	}
>=20
> @@ -958,6 +964,9 @@ int pblk_line_erase(struct pblk *pblk, struct =
pblk_line *line)
> 		WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
> 		spin_unlock(&line->lock);
>=20
> +		trace_pblk_chunk_reset(pblk_disk_name(pblk),
> +				&ppa, PBLK_CHUNK_RESET_START);
> +

Can you move this inside of pblk_blk_erase_sync() instead? I was looking
at the code now to implement a different thing and it is confusing to
see tracing inside erase_async and not in erase_sync.

Thanks,
Javier

--Apple-Mail=_CB620C91-DF80-4D28-A9CE-FA7AA977389B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluG/X8ACgkQIX4xUKFR
nnQeTg/48XG9dPgdwv6BwnYYiRWe0dxxUWZ4D3emWcY1mHgaLZMGcQBaQMVJ6kit
4e73epVxLC/12qSPVvFqT5YmJAkTafbB90IZaWzplW5BlUaMkAk633x0GV6jUx9J
ujjDXmg6N3SEPgQznUSo0gQR8R5EGDKHAo5MmEuQcj8htJEppsKmXHmJjhU2tifc
FZdi7tmNpyamLZmxZ/F+wbXRxCajEpK6TVNlYHVPSug4ygntGw+twjhEt1wvO0Fr
sqMQfytLHmMV0yTlGZJKTI47C3i8AaOx38hh9pUJidShliF7HRgAf+eAe7nu7Haa
cHya9anQjsj4aH4Qgz8wNb3ozxK+316Wsws4KUK6zRYG5ZTY+YExt069/TaFMXGt
5dg/baP7nCU2zzj/72vbdhKttxRz6/6yjzhFGn5Rqy2l5wFLaV4ncmPN7AU7dhlF
AkK52cFgvWUkLT2S4aln1Ry4dlUYYG0HzH7NdZs/fm0tthfXWXWGk9zz284HimUT
EGY4V5Bu2ldrbcotYBr2QSYbfTo7G0lABQTWs2kAaBkJzFjj7V2IVlzzCnzrSlqN
y1fIDlqRUQyX5Yg125FAn3sAwX7FPky1KF1iKPUVxt44mvXA0WUvnWHDCixA6j1s
mL311dWIqvZPiO5806djma5kgQa95fGydbILbu8AscK/NApBjA==
=QK3p
-----END PGP SIGNATURE-----

--Apple-Mail=_CB620C91-DF80-4D28-A9CE-FA7AA977389B--
