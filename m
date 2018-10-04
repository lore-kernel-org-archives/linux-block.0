Return-Path: <broonie@sirena.org.uk>
Date: Thu, 4 Oct 2018 16:26:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, oleksandr@natalenko.name,
	Paolo Valente <paolo.valente@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,
	aherrmann@suse.com, mgorman@suse.com,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	bfq-iosched@googlegroups.com
Subject: Re: [PATCH] block: BFQ default for single queue devices
Message-ID: <20181004152632.GG6412@sirena.org.uk>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
 <CACRpkdYG2Y=rspbZ_o=H3REXTEfOcaiqEyQD4kzO=G=d63V3yA@mail.gmail.com>
 <20181004101305.GA6412@sirena.org.uk>
 <1538665857.230807.1.camel@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
In-Reply-To: <1538665857.230807.1.camel@acm.org>
List-ID: <linux-block@vger.kernel.org>


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 04, 2018 at 08:10:57AM -0700, Bart Van Assche wrote:
> On Thu, 2018-10-04 at 11:13 +0100, Mark Brown wrote:

> > Further, even those embedded systems that do use udev (some of them do
> > lean heavily on modern init stuff like that and systemd, especially when
> > boot time is a priority) they'll still need to get the relevant udev
> > rule installed somehow.

> Are you aware that the systemd source tree includes a set of udev rules?
> See also https://github.com/systemd/systemd/tree/master/rules.

Yeah, but then you're back to the situation where someone needs to go
pick up a new version of systemd to get the new rules along with the new
kernel.  It's not insurmountable but it's an obstacle.

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu2MSgACgkQJNaLcl1U
h9CDyQf+JMqi89C2uTWtYWW5I71q2dGmqnV0LsNCexXB7CbHPfnJCJqbERS0s8lz
oNC2wGensy/PhfnJkASWnlWYBd6XVJD5dn1TFqrOWEYCQwt55g/VwSwWYVQ3yGdX
wTEr9SRvjPbTx0qwVA+eEpGTpKI0TcR6SXsiVkGta5TG/+SEaMOeE6IQQCc/WgFf
I8Qg0RTvU2/QPIHggb2aLd5o/psU0kXQ3AP2ZBq+mJZWmBG+5meULIlR/ljyEiHM
6kKh2f5PeNNPE8ApaAdLP03IpjFd0CcjsobTWh3uAFpLkKtSpSjU+eYP30wAqZ/K
ywRiIyh4OO7P/XjgiN7jsEDAtDXSNA==
=Ux67
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
