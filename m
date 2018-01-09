Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: unify the interface of the proportional-share policy in blkio/io
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <28156887-c8eb-f142-f6c4-db726680305b@kernel.dk>
Date: Tue, 9 Jan 2018 23:28:55 +0100
Cc: Tejun Heo <tj@kernel.org>,
 lennart@poettering.net,
 linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 ANGELO RUOCCO <220530@studenti.unimore.it>
Message-Id: <2BEF2051-3C39-4CE1-A460-BBAE586A528F@linaro.org>
References: <56EFD7A1-A894-410D-A923-E33911ED4647@linaro.org>
 <20180109195205.GP3668920@devbig577.frc2.facebook.com>
 <28156887-c8eb-f142-f6c4-db726680305b@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 09 gen 2018, alle ore 20:53, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 1/9/18 12:52 PM, Tejun Heo wrote:
>> Hello, Paolo.
>>=20
>> On Thu, Jan 04, 2018 at 08:00:02PM +0100, Paolo Valente wrote:
>>> The solution for the second type of parameters may prove useful to
>>> unify also the computation of statistics for the throttling policy.
>>>=20
>>> Does this proposal sound reasonable?
>>=20
>> So, the above should work too but I wonder whether we could do this
>> simpler.  Frankly, I wouldn't mind if cfq and bfq can't be mixed on a
>> system - e.g. they can be built together but you can't enable bfq on
>> some devides and cfq on others.  If we do that, all we need to do is
>> just removing / adding cftypes when either gets activated which =
cgroup
>> already does.
>=20
> Not sure that would fly, since cfq is legacy and bfq is mq. You don't
> always have a free choice of which one to use...
>=20

Yep.  So, do you guys think that our proposal may be ok?  We are
waiting just for the green light to start implementing it.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
