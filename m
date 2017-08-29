Return-Path: <ben@decadent.org.uk>
Message-ID: <1504020486.4448.13.camel@decadent.org.uk>
Subject: Re: [PATCH 1/2] bfq: Re-enable auto-loading when built as a module
From: Ben Hutchings <ben@decadent.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org
Date: Tue, 29 Aug 2017 16:28:06 +0100
In-Reply-To: <20170829143130.GA4857@kernel.dk>
References: <20170813170219.GG18698@decadent.org.uk>
	 <20170829143130.GA4857@kernel.dk>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-cPQlLXedu0YKq8uPTLAO"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>


--=-cPQlLXedu0YKq8uPTLAO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-08-29 at 08:31 -0600, Jens Axboe wrote:
> On Sun, Aug 13 2017, Ben Hutchings wrote:
> > The block core requests modules with the "-iosched" name suffix, but
> > bfq no longer has that suffix.=C2=A0=C2=A0Add an alias.
>=20
> I'd apply these two, but both patches are mangled when saved. It's
> turning =3D=3D into =3D3D and so forth.
>=20
> Care to check your settings and resend?

Just tried saving and applying with 'git am' successfully.  I think the
problem is at your end.

Ben.

--=20
Ben Hutchings
Teamwork is essential - it allows you to blame someone else.


--=-cPQlLXedu0YKq8uPTLAO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlmliAYACgkQ57/I7JWG
EQlARQ/9FlbGqevFF9uRsiSwBj5+ka7kVm36xFPV5XlYokUptYS81ElHam//IuZY
EXTg/mytNtyW5cx9FOEBwLyrzP798lprEMy09ZK+RupgLO3LiGE9ZukcWybqqahK
XqtekPA/voRSydubpo2t3tOgTwzx9cUDnWC5OCyIGw/SuZyfgzPxNDIcIqgdO91X
jZdw9DZChGsDB8bBTDvhmNIZHhljxJP7A8rEhQexgTJ5+prVAecHJpinMeJrQ5Na
rCGmzLkSAy9zW1YC5aVt3ZY278MDIlTwsUfR+O4S+ATYdltfa8oLZNhh8cRkWU45
nt/gB3swkT89xarCKSfp5j6g3KnSWnabC+iN9r+FmnLcfBXcbD5JZ6eDvRR8EGuZ
uBvR6umq4hIi5eJbkWuJUzWqiE3ugwXX64Ol70pD9CAN69/igzkyZVMOgdsvnac9
mCIEGbBawcin1Lj3sVNn/PZIaQiJYNt1RAZB28SC5tC6SGvAxhOCHFKTK/PGof6U
wBJvILWOixB+C/oZvECaT1WQ6bAjRRLTx2+t89rLhjKHF9G/Pflq9DYaANUKhfBM
iT3NlgXZ8aaLnVYdK0qXkqOEAIgbOhSuyDa2gsZbozJCqVTh4mYSrZsDq8ZYFRKJ
qv8iiNklRWA+lI2p7QSL5+kPiJeTCIWyMglNPZJ4DjijTGtO5/o=
=7u1S
-----END PGP SIGNATURE-----

--=-cPQlLXedu0YKq8uPTLAO--
