Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:56926 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbdJBLdB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 07:33:01 -0400
Received: by mail-wm0-f41.google.com with SMTP id e195so6184177wma.5
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 04:33:00 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <0EF0B6C0-4335-43F8-85F3-3AF93225A01A@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_821380C9-548B-43F2-ACB3-A05BD68609E0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/6] lightnvm: pblk: reduce arguments in
 __pblk_rb_update_l2p
Date: Mon, 2 Oct 2017 13:32:57 +0200
In-Reply-To: <20171001132352.GA5697@hercules.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20171001132352.GA5697@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_821380C9-548B-43F2-ACB3-A05BD68609E0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 1 Oct 2017, at 15.23, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> We already pass the structure pointer so no need to pass the member.
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/pblk-rb.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index 05e6b2e..920ffac 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -201,9 +201,9 @@ unsigned int pblk_rb_read_commit(struct pblk_rb =
*rb, unsigned int nr_entries)
> 	return subm;
> }
>=20
> -static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int =
*l2p_upd,
> -				unsigned int to_update)
> +static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int =
to_update)
> {
> +	unsigned int l2p_update =3D rb->l2p_update;
> 	struct pblk *pblk =3D container_of(rb, struct pblk, rwb);
> 	struct pblk_line *line;
> 	struct pblk_rb_entry *entry;
> @@ -213,7 +213,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb =
*rb, unsigned int *l2p_upd,
> 	int flags;
>=20
> 	for (i =3D 0; i < to_update; i++) {
> -		entry =3D &rb->entries[*l2p_upd];
> +		entry =3D &rb->entries[l2p_update];
> 		w_ctx =3D &entry->w_ctx;
>=20
> 		flags =3D READ_ONCE(entry->w_ctx.flags);
> @@ -230,7 +230,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb =
*rb, unsigned int *l2p_upd,
> 		line =3D &pblk->lines[pblk_tgt_ppa_to_line(w_ctx->ppa)];
> 		kref_put(&line->ref, pblk_line_put);
> 		clean_wctx(w_ctx);
> -		*l2p_upd =3D (*l2p_upd + 1) & (rb->nr_entries - 1);
> +		rb->l2p_update =3D (l2p_update + 1) & (rb->nr_entries - =
1);
> 	}
>=20
> 	pblk_rl_out(&pblk->rl, user_io, gc_io);
> @@ -258,7 +258,7 @@ static int pblk_rb_update_l2p(struct pblk_rb *rb, =
unsigned int nr_entries,
>=20
> 	count =3D nr_entries - space;
> 	/* l2p_update used exclusively under rb->w_lock */
> -	ret =3D __pblk_rb_update_l2p(rb, &rb->l2p_update, count);
> +	ret =3D __pblk_rb_update_l2p(rb, count);
>=20
> out:
> 	return ret;
> @@ -280,7 +280,7 @@ void pblk_rb_sync_l2p(struct pblk_rb *rb)
> 	sync =3D smp_load_acquire(&rb->sync);
>=20
> 	to_update =3D pblk_rb_ring_count(sync, rb->l2p_update, =
rb->nr_entries);
> -	__pblk_rb_update_l2p(rb, &rb->l2p_update, to_update);
> +	__pblk_rb_update_l2p(rb, to_update);
>=20
> 	spin_unlock(&rb->w_lock);
> }
> --
> 2.7.4

This in inherited from the time when the buffer pointers where kept in a
separate structure. While they are kept in struct pblk_rb, this is a
good cleanup.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_821380C9-548B-43F2-ACB3-A05BD68609E0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnSI+kACgkQYx8FO3WZ
GMqytBAA2wgGKIvqHJbkZhbkVYsvqk0ihU0XEJsuZDVAEwcqiR3JhvVvp8xKhqgu
1EevpF88H5n9EzZo5ibIMvWzyEIgtBXRFjlsqOpHqRop5SXT69C7hUamDaOu/e1n
mEpyFZPecXsz4+OyYPLOZgZlPmjxY7MAJps3UAHpoTQODyiqM3WEwXFa/IoEQyLj
GXZm5FZzCf7TEp2HP7iWcGsxKXUfpIp9P4lwqeTL3kOJk/SUgvIqDMYRMINVFuyi
m/DhqP7tjH+uy+/kmcBLfi79KoNR+9sLDYBmoK84Dxh2Pg48TZyeJNEjNhyL+ytN
mXZwoGKELrR+CqPVTXdgCzMx7IKHs7gsn96NOSfI5YV4op3mnq8Z80kuDjmzN15G
K3bLVSNqj6bOTIe/3wgHxYmQy4dFp7nGHs8fWVrqyzVYpP3/1OC5sZknWIPca9I6
MEP70ng/md7Hz9MNMF6sQ++epQNDpxWa15DA7XxakKsUaMaBWHmkQjICPLxWwRaW
0nkY5mwy3zXiBGwU7iuOlQ72os2LqVmmypuklqNqw3+WGkd+ulJB+Sdk6kXjYPA5
GNGJT+dk1juFAi3L6zQAGs5MSm3LkGKw6Xsa4kEvCB7s9w1539A5vPsWy80FhRD4
hJf9vhFbErQVa55mdIX35oA9yHxBIpxJkMMAvG9uqEysSIX3uZg=
=8nCb
-----END PGP SIGNATURE-----

--Apple-Mail=_821380C9-548B-43F2-ACB3-A05BD68609E0--
