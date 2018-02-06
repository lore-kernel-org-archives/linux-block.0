Return-Path: <efault@gmx.de>
Message-ID: <1517906853.9843.17.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com, alban.browaeys@gmail.com,
 ming.lei@redhat.com,  ivan@ludios.org, 169364@studenti.unimore.it, Serena
 Ziviani <ziviani.serena@gmail.com>
Date: Tue, 06 Feb 2018 09:47:33 +0100
In-Reply-To: <34a0aa9dead3a082615899b2830f60f1@natalenko.name>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
	 <20180205190510.5499-2-paolo.valente@linaro.org>
	 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
	 <1517903761.9843.12.camel@gmx.de>
	 <34a0aa9dead3a082615899b2830f60f1@natalenko.name>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-02-06 at 09:37 +0100, Oleksandr Natalenko wrote:
> Hi.
> 
> 06.02.2018 08:56, Mike Galbraith wrote:
> > I was doing kbuilds, and it blew up on me twice.  Switching back to cfq
> > seemed to confirm it was indeed the patch causing trouble, but that's
> > by no means a certainty.
> 
> Just to note, I was using v4.15.1, not the latest git HEAD. Are you able 
> to reproduce it on the stable kernel?

I didn't even try to wedge it into 4.15.1, tested it as posted.

>  Also, assuming this issue might be 
> unrelated to the BFQ itself, did you manage to reproduce the trouble 
> with another blk-mq scheduler (not CFQ, but mq-deadline/Kyber)?

I can give another scheduler a go this afternoon.

	-Mike
