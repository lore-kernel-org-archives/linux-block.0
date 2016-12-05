Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751328AbcLEV1Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Dec 2016 16:27:25 -0500
Subject: Re: [Nbd] [PATCH] nbd: use dev_err_ratelimited in io path
To: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, mpa@pengutronix.de,
        nbd-general@lists.sourceforge.net
References: <1480972829-30845-1-git-send-email-jbacik@fb.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2544092-1e2a-3222-5134-ce8959ca377c@redhat.com>
Date: Mon, 5 Dec 2016 15:27:18 -0600
MIME-Version: 1.0
In-Reply-To: <1480972829-30845-1-git-send-email-jbacik@fb.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="STuwgMO9101OX8bcTL7hhWN6tQH9lX6Uk"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--STuwgMO9101OX8bcTL7hhWN6tQH9lX6Uk
Content-Type: multipart/mixed; boundary="9gVFBfQ3xdxcCalTHbQvJCeUXxt617dwM";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com, mpa@pengutronix.de, nbd-general@lists.sourceforge.net
Message-ID: <c2544092-1e2a-3222-5134-ce8959ca377c@redhat.com>
Subject: Re: [Nbd] [PATCH] nbd: use dev_err_ratelimited in io path
References: <1480972829-30845-1-git-send-email-jbacik@fb.com>
In-Reply-To: <1480972829-30845-1-git-send-email-jbacik@fb.com>

--9gVFBfQ3xdxcCalTHbQvJCeUXxt617dwM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2016 03:20 PM, Josef Bacik wrote:
> While doing stress tests we noticed that we'd get a lot of dmesg spam i=
f
> we suddenly disconnected teh nbd device out of band.  Rate limite the

s/teh/the/
s/limite/limit/

> messages in the io path in order to deal with this.
>=20
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  drivers/block/nbd.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9gVFBfQ3xdxcCalTHbQvJCeUXxt617dwM--

--STuwgMO9101OX8bcTL7hhWN6tQH9lX6Uk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRdu2AAoJEKeha0olJ0NqCmYIAJd1hRYtvKzEmxeHRfITc9bl
PQROd4KF6MqNPS5cq2/AtJKJx0lpoP6g8y9lJhP7Khge6tLOeXCTFnvMBZisaI1Z
ctq9qMD+2L4QaCiIkzgBR75dow3g1CjIkO8LP0Ei00dv7cFQUciqf8kWl1skFdNr
6x6BJwbzMi3bleApkwPuRf9BHhCwPKFjxB88VXDOxOd3XIeyFyRJ5A9n3xw/AFLs
1xWd5OM1LFMrTfq5n/IgGLUUJrCc+RSLjH2rzWf3vEOxoS0BfNEdXZOwkLxp5Uvt
FEdaht2ak9h9MNnv5B0nESv9YpRtnmx3TLvaI9u/KpygyD6t+RF7Rac9AhZp9rM=
=43br
-----END PGP SIGNATURE-----

--STuwgMO9101OX8bcTL7hhWN6tQH9lX6Uk--
