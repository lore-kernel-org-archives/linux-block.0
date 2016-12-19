Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCHSET v4] blk-mq-scheduling framework
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1481933536-12844-1-git-send-email-axboe@fb.com>
Date: Mon, 19 Dec 2016 12:32:37 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Omar Sandoval <osandov@fb.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <7A8A5078-E9B8-4EBF-BAB1-9E8EEBF3A043@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
To: Jens Axboe <axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> This is version 4 of this patchset, version 3 was posted here:
>=20
> https://marc.info/?l=3Dlinux-block&m=3D148178513407631&w=3D2
>=20
> =46rom the discussion last time, I looked into the feasibility of =
having
> two sets of tags for the same request pool, to avoid having to copy
> some of the request fields at dispatch and completion time. To do =
that,
> we'd have to replace the driver tag map(s) with our own, and augment
> that with tag map(s) on the side representing the device queue depth.
> Queuing IO with the scheduler would allocate from the new map, and
> dispatching would acquire the "real" tag. We would need to change
> drivers to do this, or add an extra indirection table to map a real
> tag to the scheduler tag. We would also need a 1:1 mapping between
> scheduler and hardware tag pools, or additional info to track it.
> Unless someone can convince me otherwise, I think the current approach
> is cleaner.
>=20
> I wasn't going to post v4 so soon, but I discovered a bug that led
> to drastically decreased merging. Especially on rotating storage,
> this release should be fast, and on par with the merging that we
> get through the legacy schedulers.
>=20

I'm to modifying bfq.  You mentioned other missing pieces to come.  Do
you already have an idea of what they are, so that I am somehow
prepared to what won't work even if my changes are right?

Thanks,
Paolo

> Changes since v3:
>=20
> - Keep the blk_mq_free_request/__blk_mq_free_request() as the
>  interface, and have those functions call the scheduler API
>  instead.
>=20
> - Add insertion merging from unplugging.
>=20
> - Ensure that RQF_STARTED is cleared when we get a new shadow
>  request, or merging will fail if it is already set.
>=20
> - Improve the blk_mq_sched_init_hctx_data() implementation. =46rom =
Omar.
>=20
> - Make the shadow alloc/free interface more usable by schedulers
>  that use the software queues. =46rom Omar.
>=20
> - Fix a bug in the io context code.
>=20
> - Put the is_shadow() helper in generic code, instead of in =
mq-deadline.
>=20
> - Add prep patch that unexports blk_mq_free_hctx_request(), it's not
>  used by anyone.
>=20
> - Remove the magic '256' queue depth from mq-deadline, replace with a
>  module parameter, 'queue_depth', that defaults to 256.
>=20
> - Various cleanups.
>=20
