Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RFC 01/14] block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <91b856e8-2c14-00b6-fdd8-b9879b1b9952@kernel.dk>
Date: Sun, 5 Mar 2017 17:02:19 +0100
Cc: Tejun Heo <tj@kernel.org>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org
Message-Id: <060CBCB3-AB73-4F88-9CDC-828F502A8FF7@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org> <20170304160131.57366-2-paolo.valente@linaro.org> <91b856e8-2c14-00b6-fdd8-b9879b1b9952@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 05 mar 2017, alle ore 16:16, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 03/04/2017 09:01 AM, Paolo Valente wrote:
>> We tag as v0 the version of BFQ containing only BFQ's engine plus
>> hierarchical support. BFQ's engine is introduced by this commit, =
while
>> hierarchical support is added by next commit. We use the v0 tag to
>> distinguish this minimal version of BFQ from the versions containing
>> also the features and the improvements added by next commits. BFQ-v0
>> coincides with the version of BFQ submitted a few years ago [1], =
apart
>> from the introduction of preemption, described below.
>>=20
>> BFQ is a proportional-share I/O scheduler, whose general structure,
>> plus a lot of code, are borrowed from CFQ.
>=20
> I'll take a closer look at this in the coming week.

ok

> But one quick
> comment - don't default to BFQ. Both because it might not be fully
> stable yet, and also because the performance limitation of it is
> quite severe. Whereas deadline doesn't really hurt single queue
> flash at all, BFQ will.
>=20

Ok, sorry.  I was doubtful on what to do, but, to not bother you on
every details, I went for setting it as default, because I thought
people would have preferred to test it, even from boot, in this
preliminary stage.  I reset elevator.c in the submission, unless you
want me to do it even before receiving your and others' reviews.

> Generally, I think that sort of logic should go into a udev rule. If
> a device is rotational it should default to BFQ once the dust has
> settled.
>=20

ok

Looking forward for your feedback,
Paolo

> --=20
> Jens Axboe
>=20
