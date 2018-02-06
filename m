Return-Path: <efault@gmx.de>
Message-ID: <1517924861.25841.33.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, Jens Axboe
 <axboe@kernel.dk>,  linux-block <linux-block@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,  Ulf Hansson
 <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, 'Paolo Valente' via bfq-iosched
 <bfq-iosched@googlegroups.com>, Alban Browaeys <alban.browaeys@gmail.com>,
 ming.lei@redhat.com, ivan@ludios.org, 169364@studenti.unimore.it, Serena
 Ziviani <ziviani.serena@gmail.com>
Date: Tue, 06 Feb 2018 14:47:41 +0100
In-Reply-To: <BE442D49-D280-4B35-89ED-43C729263F2A@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
	 <20180205190510.5499-2-paolo.valente@linaro.org>
	 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
	 <1517903761.9843.12.camel@gmx.de>
	 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
	 <1517918234.25841.31.camel@gmx.de>
	 <BE442D49-D280-4B35-89ED-43C729263F2A@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-02-06 at 13:26 +0100, Paolo Valente wrote:
> 
> ok, right in the middle of bfq this time ... Was this the first OOPS in your kernel log?

Yeah.
