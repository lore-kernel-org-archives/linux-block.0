Return-Path: <pavel@ucw.cz>
Date: Fri, 5 Oct 2018 11:49:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,
	aherrmann@suse.com, mgorman@suse.com,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	bfq-iosched@googlegroups.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Message-ID: <20181005094909.GB17069@amd>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
 <CACRpkdYG2Y=rspbZ_o=H3REXTEfOcaiqEyQD4kzO=G=d63V3yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
In-Reply-To: <CACRpkdYG2Y=rspbZ_o=H3REXTEfOcaiqEyQD4kzO=G=d63V3yA@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On another hand, the users of embedded devices, mentioned by Linus,
> > should already know what scheduler to choose because dealing with
> > embedded world assumes the person can decide this on their own, or with
> > the help of abovementioned udev scripts and/or Documentation/ as a
> > reference point.
> >
> > So I see no obstacles here, and the choice to rely on udev by default
> > sounds reasonable.
> >
>=20
> I am sorry but I do not agree with this.
>=20
> There are several historical precedents where we have
> concluded that just "have the kernel do the right thing
> by default" is the way to go.

Kernel should do the right thing by default, I agree with Linus W.

Having reasonable defaults is useful; yes, my desktop has udev etc,
but I still want reasonable scheduler when doing fsck in
init=3D/bin/bash.

Plus, I update kernels more often than distros, and I run various
embedded stuff.

Kernel should just provide reasonable defaults.

And yes, we have "ionice" command and yes, it would be nice if it
worked by default...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu3M5UACgkQMOfwapXb+vJ6eACfcuqmLHOP0/KPd0GVpLGns0P0
WcIAoJmlmzUGDFB4GFpMdVF0osheZdbP
=pxio
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
