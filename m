Return-Path: <broonie@sirena.org.uk>
Date: Thu, 27 Oct 2016 23:01:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
	Paolo Valente <paolo.valente@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hannes Reinecke <hare@suse.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Message-ID: <20161027220105.GV25322@sirena.org.uk>
References: <20161026152955.GA21262@infradead.org>
 <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk>
 <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
 <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
 <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk>
 <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
 <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk>
 <20161027194127.GT25322@sirena.org.uk>
 <20161027194548.GA30332@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FQ9/qgh0YgB02Feu"
In-Reply-To: <20161027194548.GA30332@infradead.org>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
List-ID: <linux-block@vger.kernel.org>


--FQ9/qgh0YgB02Feu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2016 at 12:45:48PM -0700, Christoph Hellwig wrote:
> On Thu, Oct 27, 2016 at 08:41:27PM +0100, Mark Brown wrote:

> > Plus the benchmarking to verify that it works well of course, especially
> > initially where it'll also be a new queue infrastructure as well as the
> > blk-mq conversion itself.  It does feel like something that's going to
> > take at least a couple of kernel releases to get through.

> Or to put it the other way around:  it could have been long done
> if people had started it the first it was suggestead.  Instead you guys
> keep arguing and nothing gets done.  Get started now, waiting won't
> make anything go faster.

There are things going on already like the effort to convert MMC to
blk-mq and there have been some initial emails with Omar about how best
to collaborate on his existing work (which was pointed out as the way
forwards) so that things are useful and we avoid duplication of effort.
In any case the situation is what it is, we can't change the past.

> > I think there's also value in having improvements there for people who
> > benefit from them while queue infrastructure for blk-mq is being worked
> > on. =20

> Well, apply it to you vendor tree then and maintain it yourself if you
> disagree with our direction.

I don't think there's any substantial disagreement about where we want
to end up, it's a much more tactical discussion about what we do while
we're on the way there.  Just saying put the changes in your vendor tree
isn't ideal, it's not like there's some singular vendor tree out there
that everyone uses and doing things in vendor trees is what we mostly
encourage people to avoid doing.

If it were something that was actively disruptive for other users or it
made the blk-mq code harder to work with then it'd be clear that having
it upstream would cause problems but that doesn't seem to be the case
here.  Similarly if blk-mq were already at the point where it could
replace blk then it'd be clear that drivers should just be being
converted.  Instead we're in the middle somewhere, it wouldn't be
entirely free to put something in but on the other hand helps solve
people's problems and where it's causing costs those costs are also
providing a hook that helps pull people into working with the community
more.

--FQ9/qgh0YgB02Feu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEnkgAAoJECTWi3JdVIfQtOkH/0RcXCrlU8IegNXKWMlHz5i/
M/ihxAE/Uk2sicgYMsBprrvX8E+A9tTtvHTUiMPwoAoAwDOAQxYDBxUrqEp0uJtg
SXS2Jp5KBgGqNIczL3M7x62SuqAlt16D3/MqOtWe+kqnfxxB4qZXuQh4DoWVr9pA
05cZSO9/NYExhsLNjUjpz0FqZtitN1OO59W7Dl1T0uzBZx8P6KkHE+WOTq+WG/Fa
4pRJlx3nyC+Xw8PPQ3ijmcEVKdsLvQQeYTDjepMBcYaj48NKa0aIss2C1wDJGjZH
DjXg3XprHXvrI4RYX5hailTot1J1R6IbA/xf5NlbCvwSszq/192rTN6sqe21NQI=
=QRFW
-----END PGP SIGNATURE-----

--FQ9/qgh0YgB02Feu--
