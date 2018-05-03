Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: testing io.low limit for blk-throttle
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20180426183200.GK1911913@devbig577.frc2.facebook.com>
Date: Thu, 3 May 2018 18:35:01 +0200
Cc: Joseph Qi <jiangqi903@gmail.com>,
 linux-block <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Shaohua Li <shli@fb.com>,
 Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <11A022BD-AAE9-4508-A233-AE05DE33C60A@linaro.org>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
 <4c6b86d9-1668-43c3-c159-e6e23ffb04b4@gmail.com>
 <A0424504-2778-41F4-B1C6-BE1B0253E524@linaro.org>
 <18accc1e-c7b3-86a7-091b-1d4b631fcd4a@gmail.com>
 <536A1B1D-575F-4193-ADA6-BA832AEC7179@linaro.org>
 <20180426183200.GK1911913@devbig577.frc2.facebook.com>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 26 apr 2018, alle ore 20:32, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello,
>=20
> On Tue, Apr 24, 2018 at 02:12:51PM +0200, Paolo Valente wrote:
>> +Tejun (I guess he might be interested in the results below)
>=20
> Our experiments didn't work out too well either.  At this point, it
> isn't clear whether io.low will ever leave experimental state.  We're
> trying to find a working solution.
>=20

Thanks for this update, Tejun.  I'm still working (very slowly) on a
survey of the current state of affairs in terms of bandwidth and
latency guarantees in the block layer.  The synthesis of the results
I've collected so far is, more or less:

"The problem of reaching a high throughput and, at the same time,
guaranteeing bandwidth and latency is still unsolved, apart from
simple cases, such as homogenous, constant workloads"

I'm anticipating this, because I don't want to risk to underestimate
anybody's work.  So, if anyone has examples of how, e.g., to
distribute I/O bandwidth as desired among heterogenous workloads (for
instance, random vs sequential workloads) that might fluctuate over
time, without losing total throughput, please tell me, and I'll test
them.

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun
