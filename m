Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/4] bfq: two fixes and one improvement
 related to I/O control
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <5ac17a9b-1c38-0664-15e3-ff75c9671388@kernel.dk>
Date: Fri, 17 Aug 2018 18:21:57 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org,
 bfq-iosched@googlegroups.com,
 oleksandr@natalenko.name
Message-Id: <4873FEA2-9E53-4C76-A6B9-4AC82CDC8E6E@linaro.org>
References: <20180816165118.17402-1-paolo.valente@linaro.org>
 <5ac17a9b-1c38-0664-15e3-ff75c9671388@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 16 ago 2018, alle ore 21:10, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 8/16/18 10:51 AM, Paolo Valente wrote:
>> Hi Jens,
>>=20
>> while working a little bit on cgroups I/O control, I found two nasty
>> bugs in bfq. They break bandwidth control in simple configurations
>> with one-process groups. These bugs are fixed by the first two =
patches
>> in this series.
>>=20
>> These fixes improved I/O control so much, that I could reduce the
>> write overcharge factor, used by bfq to counter write-induced
>> issues. This reduction is performed by the third patch.
>>=20
>> The fourth patch contains a little code improvement I made in a
>> function that has to do with I/O control.
>>=20
>> I hope we are still in time for 4.19.
>=20
> Patches look fine to me. You are in fact several weeks late for 4.19, =
I
> need to have anything that's going in to 4.19 by -rc6 or -rc7 time
> (depending on whether we have an -rc8 or not). This is to ensure that =
it
> gets plenty of time in linux-next as well. I've queued up patches this
> time (since they were small), but please send them in in due time next
> time.
>=20

Thanks for your patience. Next time I'll respect due time.

Paolo

> --=20
> Jens Axboe
>=20
