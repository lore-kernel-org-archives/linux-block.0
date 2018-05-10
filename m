Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCHSET v2 0/7] blk-mq-sched and sbitmap shallow depth
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
Date: Thu, 10 May 2018 06:32:22 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@fb.com>,
 Mike Galbraith <efault@gmx.de>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <BB4243FC-1AC7-4200-86D4-CC088F38A4DA@linaro.org>
References: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 09 mag 2018, alle ore 22:49, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> Omar had some valid complaints about the previous patchset, mostly
> around the fact that we should not be updating depths on a per-IO
> basis.  He's right. In fact, BFQ oddly enough does it from the
> ->limit_depth hook, but the shallow depth counts remain static.
>=20
> This series cleans that up the ->limit_depth() handling, and keeps it
> out of the hot path.
>=20
> Mike, this should (still) fix your hangs with BFQ. This series is
> (functionally) identical to the bundled up version I sent you earlier.
>=20

Only one question/curiosity: is performance unaffected by the lowering =
of
the wake batch counts?

Apart from that,
Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thanks,
Paolo

> block/bfq-iosched.c     |  113 =
+++++++++++++++++++++++++-----------------------
> block/bfq-iosched.h     |    6 --
> block/blk-mq.c          |    6 +-
> block/kyber-iosched.c   |    3 +
> include/linux/sbitmap.h |   11 ++++
> lib/sbitmap.c           |   19 +++++++-
> 6 files changed, 95 insertions(+), 63 deletions(-)
>=20
> --=20
> Jens Axboe
>=20
