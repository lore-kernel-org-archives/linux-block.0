Return-Path: <broonie@sirena.org.uk>
Date: Wed, 31 Aug 2016 23:09:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
	linus.walleij@linaro.org, Omar Sandoval <osandov@fb.com>
Message-ID: <20160831220949.GD5967@sirena.org.uk>
References: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
 <20160808131954.GA12647@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
In-Reply-To: <20160808131954.GA12647@infradead.org>
Subject: Re: [PATCH V2 00/22] Replace the CFQ I/O Scheduler with BFQ
List-ID: <linux-block@vger.kernel.org>


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2016 at 06:19:54AM -0700, Christoph Hellwig wrote:

> please don't spend more time on the legacy request interface.  If you
> want your work included and make an impact add it to blk-mq.

So, an update on this: off-list Tejun said that he'd spoken with Jens
and agreed that nothing should be changed in the block layer and
everything should be focused on blk-mq at this point.  This is obviously
very disappointing especially given the previous reviews - Christoph had
been very clear but it wasn't clear to us that everyone agreed with him.

I do agree (as I think everyone looking at BFQ does) that we do want to
work to replace the current block code with blk-mq but it really feels
that we're still quite a way from being able to deploy it on systems
with MMC or SD storage where we're particularly looking with this work.
The big thing that needs doing is the queuing and scheduling which these
devices don't make any effort to do in hardware.  Omar has been working
on this but the work has mostly been off-list thus far AFAICT so not
terribly visible.  Once that's there the individual subsystems will need
to be converted, that's fairly mechanical code wise but is obviously
going to need some studying of the performance in order to make sure we
don't cause problems for users.  This all seems like at least a couple
of releases worth of work rather than being at the point where the
current code can be deprecated.

So, how do we take this forward?  In terms of Linaro's work what we've
been thinking is:

 - Send a proposal for a face to face discussion at Kernel Summit (Paolo
   will be going there), Paolo said he was drafting a mail.
 - Continue maintaining and testing BFQ, most likely reverting to a
   separate scheduler rather than replacing CFQ.
 - Do some benchmarks on the current status of the various branches on
   relevant hardware (including trying to convert some of these slower
   devices to blk-mq and seeing what happens).  Linus has been working
   on this already in the context of MMC.
 - Try to pitch in to the blk-mq development, we'll need to work out how
   to coordinate with everyone else here.

I personally feel that given that it looks like this is all going to
take a while it'd still be good to merge BFQ at least as an alternative
scheduler so that people can take advantage of it while the work on
modernising everything to use blk-mq - that way we can hopefully improve
the state of the art for users in the short term or at least help get
some wider feedback on how well this works in the real world
independently of the work on blk-mq.

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXx1WrAAoJECTWi3JdVIfQuPsH/2LeWTL9qiL50Nw50IzAfuo4
bPOBtYDwbAiZI1d/aJZMmf2cEw3PH8i/2log+6ZMwLDSImolUTeJfci9KUOgL9fV
PoIkUEGwQZcLWD3OqBIR1x7nF5zmPtkryCsb1pQiFrvTRzk3SNIKdJFvPu5x5ubD
4burh+AtDkYvKUuCOhKUPQURbwUZK1C3j2zkTC5pLPqeH5ZHJFHVvmNn08usFOi0
dU49mwIhxOgpeC1Rd9daT432hS2cRb0zExanKw67CnQ7ODRp2sJHXJlKIGpR4zIy
tclO296Xx9T3YzvjUHNfgBXzfNPks5ugYxoiCoOEzAmrx7fcRPYgpOhPMcMh00s=
=48Y6
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
