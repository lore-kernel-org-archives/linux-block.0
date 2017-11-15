Return-Path: <pavel@ucw.cz>
Date: Wed, 15 Nov 2017 22:12:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Philipp Guendisch <philipp.guendisch@fau.de>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, axboe@kernel.dk,
	viro@zeniv.linux.org.uk, bart.vanassche@sandisk.com,
	martin.petersen@oracle.com, hare@suse.de, osandov@fb.com,
	dan.j.williams@intel.com, ming.lei@redhat.com,
	linux-kernel@i4.cs.fau.de, Mate Horvath <horvatmate@gmail.com>
Subject: Re: [PATCH] Support for secure erase functionality
Message-ID: <20171115211242.GE6183@amd>
References: <1505317073-22567-1-git-send-email-philipp.guendisch@fau.de>
 <2b2d3855-00e9-77d0-7ee4-050c210b718e@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
In-Reply-To: <2b2d3855-00e9-77d0-7ee4-050c210b718e@wdc.com>
List-ID: <linux-block@vger.kernel.org>


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On 9/14/17 00:37, Philipp Guendisch wrote:
> > This patch adds a software based secure erase option to improve data
> > confidentiality. The CONFIG_BLK_DEV_SECURE_ERASE option enables a mount
> > flag called 'sw_secure_erase'. When you mount a volume with this flag,
> > every discard call is prepended by an explicit write command to overwri=
te
> > the data before it is discarded. A volume without a discard compatibili=
ty
> > can be used as well but the discard calls will be enabled for this devi=
ce
> > and suppressed after the write call is made.
>=20
> Writing once to a sector stored on spinning rust will *not* fully erase
> the previous data. Part of the signal used for storing that data will
> remain on the track (because the disk head is never perfectly aligned on
> the track). With some signal processing work, the old data can be retriev=
ed.
>=20
> You will need a *lot* of normal writes to make sure nothing remains of
> the old data signal. Granted, even a single write will make it hard to
> get to the old data, but it is possible nevertheless. Hence the standard
> defined SANITIZE with cryptographic erase option to ensure that the old
> data is really dead.

Single overwrite is enough if you are not defending against with NSA
(or someone with way too much time and osciloscope). Two overwrites
should be enough against them, too.

OTOH... discard is performance optimalizaton. Are they sure it is
always used when they need it?

> I think that a similar problem also exist for SSDs, and it is even worse
> there since writing twice to the same logical sector does not even go to
> the same physical sector. The old data is not even overwritten.

Exactly -- overwrite will not help on SSD. But discard _should_
normally work on SSD, so this actually makes stuff worse on SSDs:
you'll write random data to a new place, and then discard will erase
that... making sure original data is intact.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloMrckACgkQMOfwapXb+vICVQCfRg9JwB5E9YEJKL36ZJTZbpat
hP8AniLrb5tREQyffzh8k6gnxp3mY8hA
=yQW5
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--
