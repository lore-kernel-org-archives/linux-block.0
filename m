Return-Path: <pavel@ucw.cz>
Date: Fri, 5 Oct 2018 10:04:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
	Paolo Valente <paolo.valente@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Message-ID: <20181005080457.GB14466@amd>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
In-Reply-To: <20181002124329.21248-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I talked to Pavel a bit back and it turns out he has a
> usecase for BFQ as well and I bet he also would like it
> as default scheduler for that system (Pavel tell us more,
> I don't remember what it was!)

I'm not sure I remember clearly, either.

IIRC I was working with ionice on spinning disks, and it had no
effect. I switched to BFQ and suddenly ionice was effective.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu3GykACgkQMOfwapXb+vLPwACfdqGloCd9CjmTKQ5BeYsHA9Jc
AZoAoKwt4ORtanA0S3EqgvOJ2hMzMIp5
=s0++
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
