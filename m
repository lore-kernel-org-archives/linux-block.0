Return-Path: <efault@gmx.de>
Message-ID: <1517998516.6606.1.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, Jens Axboe
 <axboe@kernel.dk>,  linux-block <linux-block@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,  Ulf Hansson
 <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, 'Paolo Valente' via bfq-iosched
 <bfq-iosched@googlegroups.com>, Alban Browaeys <alban.browaeys@gmail.com>,
 Ming Lei <ming.lei@redhat.com>, Ivan Kozik <ivan@ludios.org>, SERENA
 ZIVIANI <169364@studenti.unimore.it>, Serena Ziviani
 <ziviani.serena@gmail.com>,  Holger =?ISO-8859-1?Q?Hoffst=E4tte?=
 <holger@applied-asynchrony.com>
Date: Wed, 07 Feb 2018 11:15:16 +0100
In-Reply-To: <FBF6DCBB-B0F5-446B-8FD1-106E2538A9C1@linaro.org>
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
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-02-07 at 10:45 +0100, Paolo Valente wrote:
> 
> > Il giorno 07 feb 2018, alle ore 10:23, Mike Galbraith <efault@gmx.de> ha scritto:
> > 
> > On Wed, 2018-02-07 at 10:08 +0100, Paolo Valente wrote:
> >> 
> >> The first piece of information I need is whether this failure happens
> >> even without "BFQ hierarchical scheduling support".
> > 
> > I presume you mean BFQ_GROUP_IOSCHED, which I do not have enabled.
> > 
> 
> Great (so to speak), this saves us one step.
> 
> So, here's my next request for help: please apply the attached patch
> (compressed to preserve it from my email client) and retry. It adds
> several anomaly checks. I hope I have not added any false-positive
> check.

kernel BUG at block/bfq-iosched.c:4742!

4742         BUG_ON(!(rq->rq_flags & RQF_ELVPRIV));
