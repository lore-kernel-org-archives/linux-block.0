Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
Message-Id: <8D356375-4C35-41EC-9F4D-0E321B08F9BF@linaro.org>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_23BA49C6-7568-4D80-875B-318B77F8E784"
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
Date: Wed, 7 Feb 2018 12:27:10 +0100
In-Reply-To: <5584030F-8F4E-4C98-84A5-79873A1BF775@linaro.org>
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
To: Mike Galbraith <efault@gmx.de>
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
 <5584030F-8F4E-4C98-84A5-79873A1BF775@linaro.org>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_23BA49C6-7568-4D80-875B-318B77F8E784
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 07 feb 2018, alle ore 11:27, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 07 feb 2018, alle ore 11:15, Mike Galbraith <efault@gmx.de> =
ha scritto:
>>=20
>> On Wed, 2018-02-07 at 10:45 +0100, Paolo Valente wrote:
>>>=20
>>>> Il giorno 07 feb 2018, alle ore 10:23, Mike Galbraith =
<efault@gmx.de> ha scritto:
>>>>=20
>>>> On Wed, 2018-02-07 at 10:08 +0100, Paolo Valente wrote:
>>>>>=20
>>>>> The first piece of information I need is whether this failure =
happens
>>>>> even without "BFQ hierarchical scheduling support".
>>>>=20
>>>> I presume you mean BFQ_GROUP_IOSCHED, which I do not have enabled.
>>>>=20
>>>=20
>>> Great (so to speak), this saves us one step.
>>>=20
>>> So, here's my next request for help: please apply the attached patch
>>> (compressed to preserve it from my email client) and retry. It adds
>>> several anomaly checks. I hope I have not added any false-positive
>>> check.
>>=20
>> kernel BUG at block/bfq-iosched.c:4742!
>>=20
>> 4742         BUG_ON(!(rq->rq_flags & RQF_ELVPRIV));
>=20
> Oh my, this is as crazy as, fortunately, easy to fix.  The problem is
> that this is easy to fix in bfq, but increases the doubts I have
> expressed in my cover letter: is it ok that, in blk-mq, the functions
> of an elevator may get invoked, without control, on requests that do
> not belong to that elevator?
>=20
> Anyway, two requests, Mike, if you haven't had enough already:
>=20
> 1. Could you paste a stack trace for this OOPS, just to understand how =
we
> get there?
>=20
> 2. Could you please turn that BUG_ON into:
> if (!(rq->rq_flags & RQF_ELVPRIV))
> 	return;
> and see what happens?
>=20

Hi Oleksandr, Holger,
before I prepare a V2 candidate patch, could you please test my
instrumentation patch too, with the above change made.  For your
convenience, I have attached a compressed archive with both the
instrumentation patch and a patch making the above change.

Crossing my fingers,
Paolo


--Apple-Mail=_23BA49C6-7568-4D80-875B-318B77F8E784
Content-Disposition: attachment;
	filename=patches.zip
Content-Type: application/zip;
	x-unix-mode=0644;
	name="patches.zip"
Content-Transfer-Encoding: base64

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
--Apple-Mail=_23BA49C6-7568-4D80-875B-318B77F8E784
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii




> Thanks a lot,
> Paolo


--Apple-Mail=_23BA49C6-7568-4D80-875B-318B77F8E784--
