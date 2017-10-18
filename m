Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: high overhead of functions blkg_*stats_* in bfq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <74e06bc1-bf75-aac1-cef3-87609af8da70@kernel.dk>
Date: Wed, 18 Oct 2017 17:05:38 +0200
Cc: Tejun Heo <tj@kernel.org>,
 linux-block <linux-block@vger.kernel.org>,
 Luca Miccio <lucmiccio@gmail.com>
Message-Id: <D8400344-DD9D-498B-A177-9F2E396C8930@linaro.org>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org> <20171018131918.GB1302522@devbig577.frc2.facebook.com> <74e06bc1-bf75-aac1-cef3-87609af8da70@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 18 ott 2017, alle ore 16:45, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 10/18/2017 07:19 AM, Tejun Heo wrote:
>>> We tried to understand the reason for this high overhead, and, in
>>> particular, to find out whether whether there was some issue that we
>>> could address on our own.  But the causes seem somehow substantial:
>>> one of the most time-consuming operations needed by some =
blkg_*stats_*
>>> functions is, e.g., find_next_bit, for which we don't see any =
trivial
>>> replacement.
>>=20
>> Can you point to the specific ones?  I can't find find_next_bit =
usages
>> in generic blkg code.
>=20
> Yeah, in general a report like this is pretty much useless without
> any sort of call traces or perf output. The best way to get help
> is to post exactly what to run to reproduce the performance issue,
> and profile output that shows/highlights the issues.
>=20

Yes, sorry.  To be very brief, I just provided a link to the script
with which one can immediately reproduce the issue.

I hope the information I have now provided in my reply to Tejun are
enough.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
