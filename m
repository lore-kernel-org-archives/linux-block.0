Return-Path: <broonie@sirena.org.uk>
Date: Fri, 28 Oct 2016 18:17:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paolo Valente <paolo.valente@linaro.org>,
	Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <20161028171744.n3l7brpcphi4duah@sirena.org.uk>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <CACRpkda0fmPdM2WZ_gtW=T7xvMfP_4ErtNZseExN2AggzZbcDQ@mail.gmail.com>
 <3d0b38bb-537d-94ff-574f-587bad949fdd@kernel.dk>
 <2423164.8ioLhGisxr@wuerfel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cpog7nqtpk6cugy2"
In-Reply-To: <2423164.8ioLhGisxr@wuerfel>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
List-ID: <linux-block@vger.kernel.org>


--cpog7nqtpk6cugy2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2016 at 06:05:35PM +0200, Arnd Bergmann wrote:
> On Friday, October 28, 2016 9:30:07 AM CEST Jens Axboe wrote:

> > Also, 4.8 and newer have support for BLK_MQ_F_BLOCKING, if you need to
> > block in ->queue_rq(). That could eliminate the need to offload to a
> > kthread manually.

> I think the main reason for the kthread is that on ARM and other
> architectures, the dma mapping operations are fairly slow (for
> cache flushes or bounce buffering) and we want to minimize the
> time between subsequent requests being handled by the hardware.

> This is not unique to MMC in any way, MMC just happens to be
> common on ARM and it is limited by its lack of hardware
> command queuing.

Plus the fact that MMC (and SD) have some *relatively* high performance
implementations which amplify the effects of desaturating the hardware -
the faster the hardware is the more noticable the overhead of stalling
it becomes.

--cpog7nqtpk6cugy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYE4g4AAoJECTWi3JdVIfQ3WAH+gLuYxkY5tlON/3vAdv/Fl0t
L6Q7pgMANhF6B8HRStco7AQAqVvb5cFcD8QLV8Opi36eq9nadmI26R3JvktzLagH
fdtq+Aqqs1ldjBSULOmn15PioF6n46lpz9v6TM0MY0WWj1kFARfzGrZ64jUMTCR1
BuGCFhutnmFRLK+SOjxh7YgdW7t30YV+wYtYb7XYy/una7GvdolOzCN3puWjWWDr
IssJLzyfhMO8f7oO9n1W+mBHgOEPx0+ht62eZdGfSMNpQJwg2tAd5LNgaj4OwC0n
REdjDS0nX1JSauhWOMzv7CLUmodVQ+Prsp9k8xZ8t3dR3TODgn/FxxdZzpRtp60=
=lkfo
-----END PGP SIGNATURE-----

--cpog7nqtpk6cugy2--
