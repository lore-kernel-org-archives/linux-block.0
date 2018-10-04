Return-Path: <broonie@sirena.org.uk>
Date: Thu, 4 Oct 2018 11:13:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>,
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
Message-ID: <20181004101305.GA6412@sirena.org.uk>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
 <CACRpkdYG2Y=rspbZ_o=H3REXTEfOcaiqEyQD4kzO=G=d63V3yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
In-Reply-To: <CACRpkdYG2Y=rspbZ_o=H3REXTEfOcaiqEyQD4kzO=G=d63V3yA@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 04, 2018 at 10:14:38AM +0200, Linus Walleij wrote:

> And these are millions and millions of deployed
> systems not using udev+systemd we are talking about,
> they are not fringe hobby projects. It's not that I
> personally dislike udev or anything, I kind of like
> it, but these tailored distros simply don't use it
> and they are huge in numbers. They need help to do
> the right thing. Fixing a udev rule doesn't solve
> even half the world's problems I'm afraid.

Further, even those embedded systems that do use udev (some of them do
lean heavily on modern init stuff like that and systemd, especially when
boot time is a priority) they'll still need to get the relevant udev
rule installed somehow.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu157EACgkQJNaLcl1U
h9BBkwf/Q9GIidNJDuHpmm+LavB0wocpu32qHC5GsxYNyo2v5lRvYq6YBUzZmG1J
U3aytRnyQh/4/0ttPCUxh/9weXA3P5uyOaQdYz7LMQ2RcsXV0hgqxqvrQAzzUaEA
ZjpzjCa9WxCvwf6RSiDkqzgPfPIXDFRKu9WMBX2hHt9VGMWszD5lJI9FjRUROr/s
QtV4jjf0vvxPDefhe3YuOhYmCAPsgVlSunFAC8LjYilLOxoOIruGD6AfJinr7f6v
6ANVMSrdRGb89J0BgU+FCXO2KJMYx9T0ETsSN0Tbr1FUNPdfFDelyY78qnokMzGj
wV16/LdECx8c5qQ4KSf3CdpNMDOS+w==
=TeIs
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
