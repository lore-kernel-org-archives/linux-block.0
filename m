Return-Path: <efault@gmx.de>
Message-ID: <1517926038.25841.36.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Holger =?ISO-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, Jens Axboe
 <axboe@kernel.dk>,  linux-block <linux-block@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,  Ulf Hansson
 <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, 'Paolo Valente' via bfq-iosched
 <bfq-iosched@googlegroups.com>, Alban Browaeys <alban.browaeys@gmail.com>,
 ming.lei@redhat.com, ivan@ludios.org, 169364@studenti.unimore.it, Serena
 Ziviani <ziviani.serena@gmail.com>
Date: Tue, 06 Feb 2018 15:07:18 +0100
In-Reply-To: <7770589c-32e0-6bdb-530a-34c642e46630@applied-asynchrony.com>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
	 <20180205190510.5499-2-paolo.valente@linaro.org>
	 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
	 <1517903761.9843.12.camel@gmx.de>
	 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
	 <1517918234.25841.31.camel@gmx.de>
	 <BE442D49-D280-4B35-89ED-43C729263F2A@linaro.org>
	 <7770589c-32e0-6bdb-530a-34c642e46630@applied-asynchrony.com>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-02-06 at 13:43 +0100, Holger Hoffst=E4tte wrote:
>=20
> A much more interesting question to me is why there is kyber in the middl=
e. :)

Yeah, given per sysfs I have zero devices using kyber.

	-Mike
