Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:46178 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbdIVJBs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 05:01:48 -0400
Received: by mail-wm0-f51.google.com with SMTP id m72so1940870wmc.1
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2017 02:01:48 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <3814BFB5-5966-4737-8B98-7A2762E409FD@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2BE99669-8092-4018-9FF9-420326C0E444";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 5/6] lightnvm: pblk: print incompatible line version
 correctly
Date: Fri, 22 Sep 2017 11:01:45 +0200
In-Reply-To: <20170921112801.GA28567@dhcp-216.srv.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170921112801.GA28567@dhcp-216.srv.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_2BE99669-8092-4018-9FF9-420326C0E444
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 21 Sep 2017, at 13.28, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> Correct it by coverting little endian to cpu endian and also define a
> macro for line version so that maintenance is easy.
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/pblk-core.c     | 2 +-
> drivers/lightnvm/pblk-recovery.c | 4 ++--
> drivers/lightnvm/pblk.h          | 1 +
> 3 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 74ddb30..57583a1 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -991,7 +991,7 @@ static int pblk_line_init_metadata(struct pblk =
*pblk, struct pblk_line *line,
> 	memcpy(smeta_buf->header.uuid, pblk->instance_uuid, 16);
> 	smeta_buf->header.id =3D cpu_to_le32(line->id);
> 	smeta_buf->header.type =3D cpu_to_le16(line->type);
> -	smeta_buf->header.version =3D cpu_to_le16(1);
> +	smeta_buf->header.version =3D SMETA_VERSION;
>=20
> 	/* Start metadata */
> 	smeta_buf->seq_nr =3D cpu_to_le64(line->seq_nr);
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 1869eef..686bc17 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -876,9 +876,9 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
> 		if (le32_to_cpu(smeta_buf->header.identifier) !=3D =
PBLK_MAGIC)
> 			continue;
>=20
> -		if (le16_to_cpu(smeta_buf->header.version) !=3D 1) {
> +		if (smeta_buf->header.version !=3D SMETA_VERSION) {
> 			pr_err("pblk: found incompatible line version =
%u\n",
> -					smeta_buf->header.version);
> +					=
le16_to_cpu(smeta_buf->header.version));
> 			return ERR_PTR(-EINVAL);
> 		}
>=20
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index eaf5397..87b1d7f 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -318,6 +318,7 @@ enum {
> };
>=20
> #define PBLK_MAGIC 0x70626c6b /*pblk*/
> +#define SMETA_VERSION cpu_to_le16(1)
>=20
> struct line_header {
> 	__le32 crc;
> --
> 2.5.0

It's a different way of doing it, and it's fine to have a macro.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_2BE99669-8092-4018-9FF9-420326C0E444
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZxNF5AAoJEGMfBTt1mRjKo7YQAIS5Sll2L7ALM2WD8jHL1npV
kPmLsbEmlVZu3mE9HTXN24TGv4gW2X4ILx6xNMZFFMRF8+v3+UODLijTwjxZBSUo
uRT24VNCEm+K23tgcwQ9QLiVVxholCD/jQcJ7vvvdV8PeqVwwywVg/K+FikeIejr
1jY261tWwplvh6awZTOTi1ZjnoR8gmy/rctlGOsgetdCzmCrlVFfR6oSjyxlJwDs
cLFvPnvNxEMb8BuL8a+8Et23QRuxTVOaF7DnB6XTv1CMdm3ybart8QV9IjxP37CQ
bbgcUY6VTuJ0i+EmG8aW7esSuK3rU65gPqZyQ21pHfmgtAo5sxy5NX7s4KFG4gbp
rgggAZsc44QUjezVVscVba80Sr2Djy7E6/b8czIGiDUvz2E9LJV3AQ6CuI59Ck2p
bkPB4JPRYvIyfLFvtGy48IGEqVpWLaHJAjVSeTaxCQqVYsdnGBVKjaQu8K4j1cMD
7Un+MYIeKmV8syZ9NbpQnAw1gsgp7K3dqTau4O+deTWY+OgsB/PJnzdolMXMuWWU
Ejt05Vw5lECUxB2Jh3k7d0PR3C4Q4IzvhRi84u1FuX1j7DdJZYFpcYF5Vjs4M6do
k8Ch2If9NYjUG9lsdoJMPW8CWYwXPt8I5uHeNfrt07FVC40YqqyrFkO+b8S8bxle
vr1ESWTH+RXUt/EF8LOD
=2V0r
-----END PGP SIGNATURE-----

--Apple-Mail=_2BE99669-8092-4018-9FF9-420326C0E444--
