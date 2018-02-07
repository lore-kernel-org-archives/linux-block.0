Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1517998516.6606.1.camel@gmx.de>
Date: Wed, 7 Feb 2018 11:27:56 +0100
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
 Alban Browaeys <alban.browaeys@gmail.com>,
 Ming Lei <ming.lei@redhat.com>,
 Ivan Kozik <ivan@ludios.org>,
 SERENA ZIVIANI <169364@studenti.unimore.it>,
 Serena Ziviani <ziviani.serena@gmail.com>,
 =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Message-Id: <5584030F-8F4E-4C98-84A5-79873A1BF775@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
 <20180205190510.5499-2-paolo.valente@linaro.org>
 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
 <1517903761.9843.12.camel@gmx.de>
 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
 <1517918234.25841.31.camel@gmx.de>
 <77124223e6116350a5184a5199850304@natalenko.name>
 <1517924768.25841.32.camel@gmx.de>
 <8842084cc8a26b7f46ae600bda8a7bd0@natalenko.name>
 <CC8CDDA5-A232-41A6-BE1E-CDB0B361C3DB@linaro.org>
 <82ffc96aacc3945861cbb708df346338@natalenko.name>
 <E52CCDEA-279A-40D8-AD9B-F4D1AF351BF1@linaro.org>
 <1517995431.25619.5.camel@gmx.de>
 <FBF6DCBB-B0F5-446B-8FD1-106E2538A9C1@linaro.org>
 <1517998516.6606.1.camel@gmx.de>
To: Mike Galbraith <efault@gmx.de>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 07 feb 2018, alle ore 11:15, Mike Galbraith <efault@gmx.de> =
ha scritto:
>=20
> On Wed, 2018-02-07 at 10:45 +0100, Paolo Valente wrote:
>>=20
>>> Il giorno 07 feb 2018, alle ore 10:23, Mike Galbraith =
<efault@gmx.de> ha scritto:
>>>=20
>>> On Wed, 2018-02-07 at 10:08 +0100, Paolo Valente wrote:
>>>>=20
>>>> The first piece of information I need is whether this failure =
happens
>>>> even without "BFQ hierarchical scheduling support".
>>>=20
>>> I presume you mean BFQ_GROUP_IOSCHED, which I do not have enabled.
>>>=20
>>=20
>> Great (so to speak), this saves us one step.
>>=20
>> So, here's my next request for help: please apply the attached patch
>> (compressed to preserve it from my email client) and retry. It adds
>> several anomaly checks. I hope I have not added any false-positive
>> check.
>=20
> kernel BUG at block/bfq-iosched.c:4742!
>=20
> 4742         BUG_ON(!(rq->rq_flags & RQF_ELVPRIV));

Oh my, this is as crazy as, fortunately, easy to fix.  The problem is
that this is easy to fix in bfq, but increases the doubts I have
expressed in my cover letter: is it ok that, in blk-mq, the functions
of an elevator may get invoked, without control, on requests that do
not belong to that elevator?

Anyway, two requests, Mike, if you haven't had enough already:

1. Could you paste a stack trace for this OOPS, just to understand how =
we
get there?

2. Could you please turn that BUG_ON into:
if (!(rq->rq_flags & RQF_ELVPRIV))
	return;
and see what happens?

Thanks a lot,
Paolo=
