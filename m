Return-Path: <broonie@sirena.org.uk>
Date: Wed, 3 Oct 2018 15:51:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,
	Andreas Herrmann <aherrmann@suse.com>,
	Mel Gorman <mgorman@suse.com>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Message-ID: <20181003145150.GC7132@sirena.org.uk>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
In-Reply-To: <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
List-ID: <linux-block@vger.kernel.org>


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 03, 2018 at 01:49:25PM +0200, Oleksandr Natalenko wrote:

> On another hand, the users of embedded devices, mentioned by Linus, should
> already know what scheduler to choose because dealing with embedded world
> assumes the person can decide this on their own, or with the help of
> abovementioned udev scripts and/or Documentation/ as a reference point.

That's not an entirely realistic assessment of a lot of practical
embedded development - while people *can* go in and tweak things to
their heart's content and some will have the time to do that there's a
lot of small teams pulling together entire systems who rely fairly
heavily on defaults, focusing most of their effort on the bits of code
they directly wrote.  You get things like people taking a copy of an
embedded distro at some point and then only updating components that
they specifically want to update like the new kernel with the drivers
for the SoC in the new product.

> So I see no obstacles here, and the choice to rely on udev by default sounds
> reasonable.

There's still a good number of users where there's a big discoverability
problem here I fear.

We have this regularly with the arm64 fixups for emulating old locking
constructs that were removed from the architecture (useful for running
old arm binaries on arm64 systems), that's got a Kconfig option but also
requires enabling at runtime.  I've had to help several users who were
completely frustrated trying to get their old binaries working having
upgraded to a kernel with the option, turned it on in Kconfig and then
being unaware that there was also this hoop userspace had to jump
through.  This is less severe as it's only a performance thing but still
potentially annoying.

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu014UACgkQJNaLcl1U
h9CNHQf8CO7g5Xt1Rend6gAv0mIhTBO2i/BGc//vXH3hlj5U4A8L/YmewudfJ/yJ
JEWeuQzbkt+DtrTpXjIc8O8NEqp6ACBqYdauhB0VGqG4ZX/1uxJOfrBgYoRpvAjb
FoNFTOQs2TUO8mEi6OJdC344986EWrnMEl3k2JZ1BYsMehJ+s4H7wSAEkSfXi/0k
w0NKNE9JqzqgelHnvMZKyDS6C8wkYCELLb2tCTsOs0gMoQeMvossGutxh6a7+z5v
vzuPF9Lazd+W1bNEO7QRlfcG9PHJ3Sl2clVjjNcc0ESsr324fK6uTIFXCSgrk4CD
TQ1zrBUMJ2b9GkVOUONUzOaB/YTw+w==
=fOIW
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
