Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH RFC] block, bfq: set default slice_idle to zero for
 non-rotational devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <317076f7-f84f-c08f-5fb5-b227094cabfd@applied-asynchrony.com>
Date: Fri, 2 Nov 2018 21:18:26 +0300
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
 linux-block <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org
Message-Id: <E50DB19F-D744-4E6B-ADDC-A2546484ADF0@linaro.org>
References: <154109421062.925711.4117729151502021084.stgit@buzz>
 <317076f7-f84f-c08f-5fb5-b227094cabfd@applied-asynchrony.com>
To: =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 1 nov 2018, alle ore 22:06, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>=20
> On 11/01/18 18:43, Konstantin Khlebnikov wrote:
>> With default 8ms idle slice BFQ is up to 10 times slower than CFQ
>> for massive random read workloads for common SATA SSD.
>> For now zero idle slice gives better out of box experience.
>> CFQ employs this since commit 41c0126b3f22 ("block: Make CFQ default
>> to IOPS mode on SSDs")
>=20
> Well, that's interesting because 3 years ago I made the same =
suggestion
> and was told that BFQ's heuristics automagically make it not idle when
> rotational=3D0.

Yep, that automagic is probably 50% of the good of BFQ.

If one just sets slice_idle=3D0, then throughput is always maximum with
random I/O; but there is no control on I/O any longer.

At any rate, Konstantin, if you have some use case where BFQ fails,
I'll be very glad to analyze it, and hopefully improve BFQ.  Just one
request: use at least a 4.19.

Thanks,
Paolo

> Did you actually benchmark this? I just tried and don't
> get a noticeable performance difference with slice_idle=3D0 compared =
to
> deadline.
>=20
> Discussion link:
> =
https://groups.google.com/forum/#!msg/bfq-iosched/iRMw2n3kYLY/6l9cIm3TBgAJ=

>=20
> curious..
>=20
> Holger
