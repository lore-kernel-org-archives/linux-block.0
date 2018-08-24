Return-Path: <massimo@burcheri.de>
Message-ID: <1535092156.11909.8.camel@burcheri.de>
Subject: Re: MQ-BFQ crashing on battery mode
From: Massimo Burcheri <massimo@burcheri.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Omar
 Sandoval <osandov@osandov.com>
In-Reply-To: <a43c5bdd-06ec-ae23-ebd3-bda8c0ea4f5c@kernel.dk>
References: <1534926011.18658.29.camel@burcheri.de>
	 <a43c5bdd-06ec-ae23-ebd3-bda8c0ea4f5c@kernel.dk>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-g/wU6nwrQoj7I+d5cqX4"
Date: Fri, 24 Aug 2018 08:29:16 +0200
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>


--=-g/wU6nwrQoj7I+d5cqX4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-08-22 at 11:42 -0600, Jens Axboe wrote:
> Any chance you can try 4.18 at least?

Of course, I tried the kernel.org sources now, sys-kernel/vanilla-sources-4=
.18.3=20
on Gentoo. The issue is the same.

I wonder that nobody has noticed that issue that I can reproduce on many ke=
rnels
since 4.13 or even older. Is it a rare combination with my bcache, luks or
btrfs? Or hardware specific? Or scheduler specific, as even BFQ is not that=
 well
tested on btrfs like the default one.

> Schedulers are specific to the queuing infrastructure, so certain types
> will only be available with MQ and certain types will only be available
> on !MQ.

I noticed that. It's just a bit intransparent from the menuconfig, options =
don't
mention if a scheduler is working on MQ or not, like CONFIG_IOSCHED_BFQ.
There it's written in the description, while CONFIG_MQ_IOSCHED_KYBER has th=
e
note in the name.
Actually MQ schedulers could depend on BLK_MQ to make it obvious.

Best regards,
Massimo
--=-g/wU6nwrQoj7I+d5cqX4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjdL61EKP3VOAA+I8lQj3p5VSZjIFAlt/pbwACgkQlQj3p5VS
ZjLVbhAAiSmWLiGV5zu+M11FU6Z4W5Emdl6fZHJG9w424mH/7A0hRwgpVup79uJ3
nHW7W/oZMc5g3dshJ6raZICSiEnWc4ichvgXcTIY5jNQdmntG1KstFszucT8z7iP
MC5NfteTJGjgvH//INcIkId71d8BFbynqUNZA8uYGsNrq8i1IjTYb3VIhtnafGWf
dei2cKwGhFVKA7vOZkSRaD/u1eR7lKfoLewUuVC09ufVrKlkiAZ1fEEUc0RL6UZ9
/LGkBwoywBGSaLfIk306P3mWfJN4Bc+X2qO/N3Nqq1f4jbtG+7NYnGhi+t9+1zXu
/0/GxnGJ8OAwd4i83bMwahaYNu3/5Zqe6/UlU3Vq5/UHWdjTyFoWYs29IA6cL+Kg
65+h6YQ8hY78pvhnicH756+OGkf40rr+NIwzAZZ4nqfFiLn/lzJlVQcP4E9bY5ni
XTDUfprpeAUDeuFtD9gDtdm523dKXXsKcDOMJGpeeIJgDwagG/g8QuOrr0xFkQ+c
5m3BxGAdTBQeSbjxh34Av53sK8CRr7mm8bYNYepBXpYnfTMzrtfKzRRoqcr3Dv7E
HnHk12l3SeyljRpmfQ9UtkrAIyjW0PbVwu7B3WekFV5Sh6NO1tTYJXj0MBzCJGov
aTbBA0uD7jgQta6SrHlWk9Z65YtI4Ax5eI6H4sU25rmGSAf11mQ=
=vvfj
-----END PGP SIGNATURE-----

--=-g/wU6nwrQoj7I+d5cqX4--
