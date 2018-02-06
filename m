Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1517903761.9843.12.camel@gmx.de>
Date: Tue, 6 Feb 2018 10:38:03 +0100
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
 Alban Browaeys <alban.browaeys@gmail.com>,
 ming.lei@redhat.com,
 ivan@ludios.org,
 169364@studenti.unimore.it,
 Serena Ziviani <ziviani.serena@gmail.com>
Message-Id: <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
 <20180205190510.5499-2-paolo.valente@linaro.org>
 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
 <1517903761.9843.12.camel@gmx.de>
To: Mike Galbraith <efault@gmx.de>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 06 feb 2018, alle ore 08:56, Mike Galbraith <efault@gmx.de> =
ha scritto:
>=20
> On Tue, 2018-02-06 at 08:44 +0100, Oleksandr Natalenko wrote:
>> Hi, Paolo.
>>=20
>> I can confirm that this patch fixes cfdisk hang for me. I've also =
tried=20
>> to trigger the issue Mike has encountered, but with no luck (maybe, I=20=

>> wasn't insistent enough, just was doing dd on usb-storage device in =
the=20
>> VM).
>=20
> I was doing kbuilds, and it blew up on me twice.  Switching back to =
cfq
> seemed to confirm it was indeed the patch causing trouble, but that's
> by no means a certainty.
>=20

Hi Mike,
as you can imagine, I didn't get any failure in my pre-submission
tests on this patch.  In addition, it is not that easy to link this
patch, which just adds some internal bfq housekeeping in case of a
requeue, with a corruption of external lists for general I/O
management.

In this respect, as Oleksandr comments point out, by switching from
cfq to bfq, you switch between much more than two schedulers.  Anyway,
who knows ...

Maybe this report will ring a bell with some block-layer expert, or,
hopefully, next feedback will help puzzle this out.

Thanks,
Paolo


> 	-Mike
