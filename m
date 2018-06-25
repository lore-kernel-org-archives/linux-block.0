Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX 0/4] bfq: fix bugs breaking bandwidth guarantees
 occasionally
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20180625194806.7619-1-paolo.valente@linaro.org>
Date: Mon, 25 Jun 2018 21:51:01 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 ulf.hansson@linaro.org,
 broonie@kernel.org,
 linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com,
 oleksandr@natalenko.name
Message-Id: <9BFD7497-CA97-413B-9387-0A192B5D1835@linaro.org>
References: <20180625194806.7619-1-paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Sorry, one commit message broken, resending ...

> Il giorno 25 giu 2018, alle ore 21:48, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi,
> during some bandwidth tests, I found some occasional but severe
> malfunctions (losses of bandwidth control). The first three patches in
> this series fix the bugs that caused these malfunctions. The last
> patch is a fix/improvement of the name of one of the functions
> involved with these bugs.
>=20
> I guess these patches are appropriate for next kernel release.
>=20
> Thanks,
> Paolo
>=20
> Paolo Valente (4):
>  block, bfq: add/remove entity weights correctly
>  block, bfq: do not expire a queue that will deserve dispatch plugging
>  block, bfq: fix service being wrongly set to zero in case of
>    preemption
>  block, bfq: fix service being wrongly set to zero in case of
>    preemption
>=20
> block/bfq-iosched.c | 131 =
+++++++++++++++++++++++++++++++++++++++++++---------
> block/bfq-iosched.h |   7 ++-
> block/bfq-wf2q.c    |  30 ++++++------
> 3 files changed, 128 insertions(+), 40 deletions(-)
>=20
> --
> 2.16.1
