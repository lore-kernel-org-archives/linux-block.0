Return-Path: <efault@gmx.de>
Message-ID: <1517924768.25841.32.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  Ulf Hansson <ulf.hansson@linaro.org>, Mark
 Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>, Alban
 Browaeys <alban.browaeys@gmail.com>,  ming.lei@redhat.com, ivan@ludios.org,
 169364@studenti.unimore.it, Serena Ziviani <ziviani.serena@gmail.com>
Date: Tue, 06 Feb 2018 14:46:08 +0100
In-Reply-To: <77124223e6116350a5184a5199850304@natalenko.name>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
	 <20180205190510.5499-2-paolo.valente@linaro.org>
	 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
	 <1517903761.9843.12.camel@gmx.de>
	 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
	 <1517918234.25841.31.camel@gmx.de>
	 <77124223e6116350a5184a5199850304@natalenko.name>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-02-06 at 13:16 +0100, Oleksandr Natalenko wrote:
> Hi.
>=20
> 06.02.2018 12:57, Mike Galbraith wrote:
> > Not me. =A0Box seems to be fairly sure that it is bfq.  Twice again box
> > went belly up on me in fairly short order with bfq, but seemed fine
> > with deadline.  I'm currently running deadline again, and box again
> > seems solid, thought I won't say _is_ solid until it's been happily
> > trundling along with deadline for a quite a bit longer.
>=20
> Sorry for the noise, but just to make it clear, are we talking about=20
> "deadline" or "mq-deadline" now?

mq-deadline.
