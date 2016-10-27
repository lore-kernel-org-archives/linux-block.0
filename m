Return-Path: <broonie@sirena.org.uk>
Date: Thu, 27 Oct 2016 20:41:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Paolo Valente <paolo.valente@linaro.org>,
	Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hannes Reinecke <hare@suse.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Message-ID: <20161027194127.GT25322@sirena.org.uk>
References: <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
 <12386463.fJy0cVexVD@wuerfel>
 <20161026152955.GA21262@infradead.org>
 <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk>
 <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
 <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
 <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk>
 <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
 <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pd495SECmvzXpBRb"
In-Reply-To: <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
List-ID: <linux-block@vger.kernel.org>


--pd495SECmvzXpBRb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2016 at 12:21:06PM -0600, Jens Axboe wrote:
> On 10/27/2016 12:13 PM, Ulf Hansson wrote:

> > I can imagine, that it's not always a straight forward "convert to blk
> > mq" patch for every block device driver.

> Well, I've actually done a few conversions, and it's not difficult at
> all. The grunt of the work is usually around converting to using some of
> the blk-mq features for parts of the driver that it had implemented
> privately, like timeout handling, etc.

Plus the benchmarking to verify that it works well of course, especially
initially where it'll also be a new queue infrastructure as well as the
blk-mq conversion itself.  It does feel like something that's going to
take at least a couple of kernel releases to get through.

> > > > 3)
> > > > While we work on scheduling in blkmq (at least for single queue
> > > > devices), it's of course important that we set high goals. Having B=
FQ
> > > > (and the other schedulers) in the legacy blk, provides a good
> > > > reference for what we could aim for.

> > > Sure, but you don't need BFQ to be included in the kernel for that.

> > Perhaps not.

> > But does that mean, you expect Paolo to maintain an up to date BFQ
> > tree for you?

> I don't expect anything. If Paolo or others want to compare with BFQ on
> the legacy IO path, then they can do that however way they want. If you
> (and others) want to have that reference point, it's up to you how to
> accomplish that.

I think there's also value in having improvements there for people who
benefit from them while queue infrastructure for blk-mq is being worked
on. =20

--pd495SECmvzXpBRb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYElhmAAoJECTWi3JdVIfQF6gH/3DeW5arMwpFE9MsoCJHkryN
pbn3XFFIYo4Uqbz5ypJ0t6fnpG4fijYexZGS24TTsIWboVfPfrzyY/8XotOnxbeP
++HbOYqSFGZyU3sp0eY+FvdutVkUuUKNp/oKb+g1fWqfpe62v78azPp2Tsh4/tjX
AmRsJb9rZ1RDhyZLGJIb5HDFlXTyd5+/dFfwjE1/B/mmMBAY07jHt7dvnARFKK0b
3ChlCAJu0yc84Mih4GuA2CojdipkY0tj0s+hD/r2G5Gr8SMZ+FO695VnWbgrhINZ
LojKXt5rC4tzd7jofBqpAUNq+E8I4QZ0bf8ZP+2LY17A9OQD9Zmq9D9Vud/z2bI=
=EmZ5
-----END PGP SIGNATURE-----

--pd495SECmvzXpBRb--
