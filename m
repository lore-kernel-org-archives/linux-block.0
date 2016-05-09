Return-Path: <broonie@sirena.org.uk>
Date: Mon, 9 May 2016 15:56:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Paolo <paolo.valente@linaro.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
	linus.walleij@linaro.org, stable@vger.kernel.org
Message-ID: <20160509145647.GB3458@sirena.org.uk>
References: <1462567512-3007-1-git-send-email-paolo.valente@linaro.org>
 <x49bn4f71qi.fsf@segfault.boston.devel.redhat.com>
 <x4937pr70z5.fsf@segfault.boston.devel.redhat.com>
 <5730A108.1000703@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
In-Reply-To: <5730A108.1000703@linaro.org>
Subject: Re: [PATCH BUGFIX] block: add missing group association in bio_split
List-ID: <linux-block@vger.kernel.org>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2016 at 04:39:04PM +0200, Paolo wrote:
> Il 09/05/2016 16:35, Jeff Moyer ha scritto:

> > Gah, I see that the bi_css member is only present for CONFIG_BLK_CGROUP.
> > I guess we'll have to live with the ifdef.

> We have already tried to remove it, but it seems it would require other
> major changes.

It probably should get fixed, but separately to the bug fix.

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXMKUuAAoJECTWi3JdVIfQpWcH/39VOFZFBySTZOvxjEq2DiCP
Le60WTxnoytTSZanjIi1UTr26uaf5IPbpkkEcWXt1ZHmirbuLVkqR83JbdkkpWEr
oU2qMFkxppoV3SXemEXXZdLcT67GbffFXDODiq9KytCH9zZBGItnHf6Aju41vQWC
2SCJktp0ztobWbBvuOQG67f4QioANpe7QLAAj2QsZUinweHqT3AUJcJ6Vr/R4PSX
82psxHnrR3Gwf0arXh8x5PGEBz3kTV+2EINZyWExhXSfqXtZQ4rkpSydeV5rvzTO
/u2tYBF5LHQaaI36zacnMlhwhGIeR8TVg2AHoJ5m7sMSnF4edv5hzzGVHVytbPk=
=tTP8
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
